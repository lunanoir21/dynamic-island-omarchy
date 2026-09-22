import QtQuick
import Quickshell
import "./dynamic-island" as DynamicIslandModule

// Omarchy entry point for the "service" kind. The island owns its own
// per-screen PanelWindow (layer-shell surface, mask, IPC handler) so there
// is nothing for omarchy-shell to summon or position — DynamicIslandHost
// just needs to exist once, which is exactly what a headless service is for.
Scope {
    DynamicIslandModule.DynamicIslandHost {}
}
