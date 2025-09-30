"""
🐧 dotfiles installation and configuration script

Usage:
  ./install [--machine <name>]
  ./install (-h | --help)
  ./install --version

Options:
  --machine <name>  Specify machine for specific configurations (optional).
  -h --help         Show this screen.
  --version         Show version.

"""
from config import load_sections, select_sections, process_sections
from utils import setup_signal_handlers, format_execution_time, display_error_summary

import subprocess
import time
from typing import Final

from docopt import docopt
from rich.console import Console
from rich.panel import Panel
from rich.prompt import Confirm

console: Final[Console] = Console()

def _ensure_prerequisites() -> None:
    try:
        subprocess.run(["yay", "--version"], check = True, stdout = subprocess.DEVNULL, stderr = subprocess.DEVNULL)
    except FileNotFoundError:
        console.print(Panel.fit(
            "[red]✗[/red] 'yay' is not installed. Please install it first and re-run the script",
            border_style = "red"
        ))
        exit(1)

def _cleanup_created_folders() -> None:
    current_user = subprocess.run(["whoami"], capture_output = True, text = True).stdout.strip()

    folders = [
        f"/home/{current_user}/yay",
        f"/home/{current_user}/go",
    ]

    for folder in folders:
        try:
            subprocess.run(["rm", "-rf", folder], check = True)
        except subprocess.CalledProcessError:
            console.print(f"[red]✗[/red] Failed to remove {folder}, please delete it manually")

def main() -> None:
    _ensure_prerequisites()

    start_time = time.time()
    setup_signal_handlers()

    arguments = docopt(__doc__)
    machine = arguments["--machine"]

    console.print(Panel.fit(
        f"Machine selected: [cyan]{machine}[/cyan]" if machine else "No machine selected",
        border_style = "blue"
    ))

    sections = load_sections("config.toml", machine)
    selected_sections = select_sections(sections, console)

    total_packages = sum(len(section.packages) for section in selected_sections)
    total_hooks = sum(len(section.hooks) for section in selected_sections)
    total_symlinks = sum(len(section.symlinks) for section in selected_sections)

    console.print()
    console.print(Panel.fit(
        f"Summary: [green]{total_packages}[/green] packages, [yellow]{total_hooks}[/yellow] hooks, [blue]{total_symlinks}[/blue] symlinks",
        border_style = "magenta"
    ))

    errors = process_sections(selected_sections, console)
    
    end_time = time.time()
    execution_time = end_time - start_time
    time_str = format_execution_time(execution_time)
    
    display_error_summary(errors, console)
    
    console.print()
    if errors:
        console.print(Panel.fit(
            f"[yellow]Installation completed with {len(errors)} error(s)!\n[dim]Took {time_str}[/dim][/yellow]",
            border_style = "yellow"
        ))
    else:
        console.print(Panel.fit(
            f"[green]✓[/green] Installation completed successfully!\n[dim]Took {time_str}[/dim]",
            border_style = "green"
        ))

    _cleanup_created_folders()

    console.print(Panel.fit(
        "[bold green]✓[/bold green] Post cleanup completed successfully!",
        border_style = "green"
    ))
    
    should_reboot = Confirm.ask(
        "[yellow]Some changes may require a reboot to take effect. Would you like to reboot now?[/yellow]",
        default = False
    )
    
    if should_reboot:
        console.print("[yellow]Rebooting system...[/yellow]")
        try:
            subprocess.run(["sudo", "reboot"], check = True)

        except subprocess.CalledProcessError:
            console.print(f"[red]✗[/red] Failed to reboot, you can do so manually with [cyan]sudo reboot[/cyan]")

        except KeyboardInterrupt:
            console.print("\n[yellow]Reboot cancelled by user[/yellow]")
    else:
        console.print("You can reboot later with: [cyan]sudo reboot[/cyan]")
    
if __name__ == "__main__":
    main()
