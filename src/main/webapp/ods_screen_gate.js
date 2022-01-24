function CallOdsScreenEvent(menu_id, event_name, param1, param2, param3, param4, param5) {
    try {if (g_ods_screen_inst_map_on_gate[menu_id.toUpperCase()] != undefined &&
            g_ods_screen_inst_map_on_gate[menu_id.toUpperCase()] != null) {

            var p_data = ['ods_screen_call', event_name, param1, param2, param3, param4, param5];
            g_ods_screen_inst_map_on_gate[menu_id.toUpperCase()].postMessage(p_data, "*");
            }
    }catch (exp200) {}
}
var g_ods_screen_inst_map_on_gate = new Array();
function RegistOdsScreen(menu_id, form_inst) {
    g_ods_screen_inst_map_on_gate[menu_id.toUpperCase()] = form_inst;
    g_ods_screen_inst_map_on_gate["*"] = form_inst;
    if (eval("typeof OnOdsScreenRegist == 'function'")) {
        OnOdsScreenRegist(menu_id);
    }
}
function OdsWebGateParentCall(menu_id, form_inst, event_name, param1, param2, param3, param4, param5) {
    g_ods_screen_inst_map_on_gate[menu_id.toUpperCase()] = form_inst;
    g_ods_screen_inst_map_on_gate["*"] = form_inst;
    if (eval("typeof OnOdsScreenEvent == 'function'")) {
        OnOdsScreenEvent( menu_id, event_name, param1, param2, param3, param4, param5);
    }
}


function OdsIFrameCommMessage1(e) {

    if (event.data.length > 1) {
        if (event.data[0] == "ods_regist") {
            RegistOdsScreen(event.data[1], event.source);
        }
        else if (event.data[0] == "ods_parent_call") {
        OdsWebGateParentCall(event.data[1], event.source, event.data[2], event.data[3], event.data[4], event.data[5], event.data[6], event.data[7])
        }
    }

    //var p_data = ['ods_parent_call', this._menu_id, event_name, param1, param2, param3, param4, param5];
}
window.addEventListener("message", OdsIFrameCommMessage1, false);