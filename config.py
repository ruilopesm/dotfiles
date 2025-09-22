import os
import subprocess
from dataclasses import dataclass
from enum import Enum
from typing import Any, List, Optional, Union
from pathlib import Path

import tomllib
from rich.console import Console
from rich.panel import Panel
from rich.table import Table
from rich import box
from rich.prompt import Prompt

class ItemType(Enum):
    PACKAGE = "package"
    HOOK = "hook"
    SYMLINK = "symlink"

type Item = Union["Package", "Hook", "Symlink"]

@dataclass
class Package:
    name: str
    type: ItemType = ItemType.PACKAGE

    @property
    def color(self) -> str:
        return "blue"
    
    def __str__(self) -> str:
        return f"📦 {self.name}"

@dataclass
class Hook:
    path: str
    type: ItemType = ItemType.HOOK

    @property
    def color(self) -> str:
        return "magenta"
    
    def __str__(self) -> str:
        return f"🔧 {self.path}"

@dataclass
class Symlink:
    source: str
    target: str
    type: ItemType = ItemType.SYMLINK

    @property
    def color(self) -> str:
        return "cyan"
    
    def __str__(self) -> str:
        return f"🔗 {self.source} → {self.target}"

@dataclass
class Section:
    name: str
    items: List[Item]
    
    @property
    def packages(self) -> List[Package]:
        return [item for item in self.items if isinstance(item, Package)]
    
    @property
    def hooks(self) -> List[Hook]:
        return [item for item in self.items if isinstance(item, Hook)]
    
    @property
    def symlinks(self) -> List[Symlink]:
        return [item for item in self.items if isinstance(item, Symlink)]

def _build_section_items(items: Any) -> List[Item]:
    section_items: List[Item] = []

    for item in items:
        match item:
            case {"type": "hook", "path": path}:
                section_items.append(Hook(path = path))

            case {"type": "symlink", "source": source, "target": target}:
                section_items.append(Symlink(source = source, target = target))

            case str(item):
                section_items.append(Package(name = item))

            case _:
                continue

    return section_items  

def load_sections(path: str, machine: Optional[str]) -> List[Section]:
    with open(path, "rb") as f:
        data = tomllib.load(f)

    sections: List[Section] = []
    
    common_sections = data.get("common", {})
    for section_name, raw_section_items in common_sections.items():
        section_items: List[Item] = _build_section_items(raw_section_items)
        
        if section_items:
            sections.append(Section(name = section_name, items = section_items))
    
    if machine and machine in data:
        machine_data = data[machine]

        for section_name, raw_section_items in machine_data.items():
            section_items: List[Item] = _build_section_items(raw_section_items)
            existing_section: Optional[Section] = next((s for s in sections if s.name == section_name), None)
            
            if section_items:
                if existing_section:
                    existing_section.items.extend(section_items)
                else:
                    sections.append(Section(name = section_name, items = section_items))
    
    return sections

def select_sections(sections: List[Section], console: Console) -> List[Section]:
    console.print(Panel.fit(
        "Review each section and select items you don't want to install, execute or symlink",
        border_style = "red"
    ))

    filtered_sections: List[Section] = []
    
    for section in sections:
        if not section.items:
            continue
        
        console.print()
        console.print(f"[bold cyan]═══ {section.name.upper()} ═══[/bold cyan]")
        console.print(f"[green]{len(section.packages)}[/green] packages, [yellow]{len(section.hooks)}[/yellow] hooks and [blue]{len(section.symlinks)}[/blue] symlinks")
        
        table = Table(box = box.SIMPLE_HEAVY)
        table.add_column("Index", justify = "right", style = "green", no_wrap = True)
        table.add_column(f"Item ({len(section.items)})")

        for i, item in enumerate(section.items, start=1):
            item_display = f"[{item.color}]{item}[/{item.color}]"
            table.add_row(str(i), item_display)

        console.print(table)

        indices = Prompt.ask(
            f"Enter indices to exclude from [cyan]{section.name}[/cyan] (comma-separated), press Enter to keep all, or type 'skip' to skip this section entirely",
            default = ""
        )

        if indices.strip().lower() == "skip":
            console.print(f"[yellow]Skipping entire section: {section.name}[/yellow]")
            continue

        parsed_indices = [int(i) for i in indices.split(",") if i.strip().isdigit()]
        excluded_indices = set(parsed_indices)
        
        filtered_items: List[Item] = []
        for i, item in enumerate(section.items, start = 1):
            if i not in excluded_indices:
                filtered_items.append(item)
        
        filtered_sections.append(Section(name = section.name, items = filtered_items))
        console.print(f"[green]✓[/green] Keeping {len(filtered_items)}/{len(section.items)} items from {section.name}")

    return filtered_sections

@dataclass
class InstallationError:
    item_type: ItemType
    item_name: str
    error_message: str
    section_name: str = ""
    
    def __str__(self) -> str:
        prefix = {
            ItemType.PACKAGE: "[red]✗[/red] Package",
            ItemType.HOOK: "[red]✗[/red] Hook",
            ItemType.SYMLINK: "[red]✗[/red] Symlink"
        }.get(self.item_type, "[red]✗[/red] Item")

        return f"{prefix} {self.item_name}: {self.error_message}"

def process_sections(sections: List[Section], console: Console) -> List[InstallationError]:
    errors: List[InstallationError] = []
    
    for section in sections:
        if not section.items:
            continue
            
        console.print(Panel.fit(
            f"Processing section: [cyan]{section.name}[/cyan]",
            border_style="cyan"
        ))
        
        for item in section.items:
            if isinstance(item, Package):
                error = _install_package(item, console)
                if error:
                    error.section_name = section.name
                    errors.append(error)

            elif isinstance(item, Hook):
                error = _execute_hook(item, console)
                if error:
                    error.section_name = section.name
                    errors.append(error)

            elif isinstance(item, Symlink):
                error = _create_symlink(item, console)
                if error:
                    error.section_name = section.name
                    errors.append(error)
    
    return errors

def _install_package(package: Package, console: Console) -> Optional[InstallationError]:
    console.print(f"Installing {package}...")

    try:
        env = _prepare_env_for_yay()
        subprocess.run(["yay", "-S", "--noconfirm", package.name], env = env, check = True)
        console.print(f"[green]✓[/green] {package.name} installed successfully")
        return None

    except subprocess.CalledProcessError as e:
        error_message = f"Failed to install {package.name} (exit code {e.returncode})"
        console.print(f"[red]✗[/red] {error_message}")
        return InstallationError(ItemType.PACKAGE, package.name, error_message)

    except FileNotFoundError:
        error_message = "yay not found. Please install yay first"
        console.print(f"[red]✗[/red] {error_message}")
        return InstallationError(ItemType.PACKAGE, package.name, error_message)

def _prepare_env_for_yay() -> Any:
    env = os.environ.copy()
    current_venv = os.path.join(env.get("VIRTUAL_ENV", ""), "bin")

    parts = env.get("PATH", "").split(":")
    new = []

    for p in parts:
        if p == current_venv:
            continue

        new.append(p)

    env["PATH"] = ":".join(new)
    return env

def _execute_hook(hook: Hook, console: Console) -> Optional[InstallationError]:
    console.print(f"Executing {hook}...")
    hooks_directory = "hooks"
    
    try:
        hook_script_path = f"{hooks_directory}/{hook.path}"
        subprocess.run(["sh", hook_script_path], check = True)
        console.print(f"[green]✓[/green] {hook.path} executed successfully")
        return None

    except subprocess.CalledProcessError as e:
        error_message = f"{hook.path} failed with exit code {e.returncode}"
        console.print(f"[red]✗[/red] {error_message}")
        return InstallationError(ItemType.HOOK, hook.path, error_message)

    except FileNotFoundError:
        error_message = f"Hook script not found: {hooks_directory}/{hook.path}"
        console.print(f"[red]✗[/red] {error_message}")
        return InstallationError(ItemType.HOOK, hook.path, error_message)

def _create_symlink(symlink: Symlink, console: Console) -> Optional[InstallationError]:
    console.print(f"Creating symlink {symlink}...")
    
    files_directory = Path.cwd() / "files"
    source_path = (files_directory / symlink.source).resolve()
    target_path = Path(symlink.target).expanduser()

    try:
        if not source_path.exists():
            error_message = f"Source file not found: {source_path}"
            console.print(f"[red]✗[/red] {error_message}")
            return InstallationError(ItemType.SYMLINK, f"{symlink.source} → {symlink.target}", error_message)
        
        target_path.parent.mkdir(parents = True, exist_ok = True)
        
        if target_path.exists() or target_path.is_symlink():
            if target_path.is_symlink():
                console.print(f"Removing existing symlink: {target_path}")
            else:
                console.print(f"Removing existing file: {target_path}")

            target_path.unlink()
        
        target_path.symlink_to(source_path)
        console.print(f"[green]✓[/green] Symlink created: {target_path} → {source_path}")
        return None
        
    except PermissionError:
        error_message = f"Permission denied creating symlink: {target_path}"
        console.print(f"[red]✗[/red] {error_message}")
        return InstallationError(ItemType.SYMLINK, f"{symlink.source} → {symlink.target}", error_message)

    except OSError as e:
        error_message = f"Failed to create symlink: {e}"
        console.print(f"[red]✗[/red] {error_message}")
        return InstallationError(ItemType.SYMLINK, f"{symlink.source} → {symlink.target}", error_message)
