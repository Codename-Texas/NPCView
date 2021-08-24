# NPCView
Simple Roblox Luau module for implementing a semi-realistic "algorithm" for detecting players or parts in view of an object or NPC. This factors in maximum distance, field of view, occlusion.

# Usage
NPCView.Create static method constructs an object for you to use.
- Head - BasePart indicating what the "origin" of the view is.
- FoV - Number between -1 (directly behind line of sight) and 1 (directly in line of sight) indicating the field of view for the head.
- MaxDistance - Number indicating the maximum distance of part detection.
- IgnoreInstance - Instance whose descendants (and itself) are ignored during the occlusion check.

NPCView:GetPlayersInView method returns an array of Player instances currently in the view of NPCView

NPCView:IsCharacterInView method returns true if a Player instance's character is in view of NPCView. Note that only one part of the player's character model has to be visible to NPCView for the function to return true.
- Player - Player instance whose Character's BaseParts will be fed to NPCView:IsBasePartInView in order to determine occlusion.

NPCView:IsBasePartInView method returns true if a BasePart is in view of NPCView.
- BasePart - BasePart which will be checked to be in bounds of MaxDistance and the FoV minimum as well as not occluded by other objects.
