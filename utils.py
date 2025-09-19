import signal
import sys
from typing import Final, List

from rich.console import Console
from rich.panel import Panel

console: Final[Console] = Console()

def _signal_handler(_signum: int, _frame: None) -> None:
    console.print()
    console.print(Panel.fit(
        "[red]✗[/red] Installation interrupted by user",
        border_style = "red"
    ))
    console.print("[yellow]Exiting gracefully...[/yellow]")
    sys.exit(130)

def setup_signal_handlers():
    signal.signal(signal.SIGINT, _signal_handler)
    signal.signal(signal.SIGTERM, _signal_handler)

def format_execution_time(execution_time: float) -> str:
    if execution_time < 60:
        return f"{execution_time:.1f} seconds"
    else:
        minutes = int(execution_time // 60)
        seconds = execution_time % 60
        return f"{minutes}m {seconds:.1f}s"

def display_error_summary(errors: List, console: Console) -> None:
    if not errors:
        return
    
    console.print()
    console.print(Panel.fit(
        f"[red]✗[/red] {len(errors)} error(s) occurred during installation",
        border_style = "red"
    ))
    
    errors_by_section = {}
    for error in errors:
        section = error.section_name or "Unknown"
        if section not in errors_by_section:
            errors_by_section[section] = []
        errors_by_section[section].append(error)
    
    for section_name, section_errors in errors_by_section.items():
        console.print(f"\n[bold red]Section: {section_name}[/bold red]")
        for error in section_errors:
            console.print(f"  {error}")
