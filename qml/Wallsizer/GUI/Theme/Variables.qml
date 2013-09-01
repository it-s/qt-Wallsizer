import QtQuick 2.0
import QtQuick.Window 2.0

Item {

    // Grays
    // -------------------------
    property color transparent: rgba(0,0,0,0)
    property color black:                   "#252f3f"
    property color grayDarker:              "#38475e"
    property color grayDark:                "#445670"
    property color gray:                    "#869092"
    property color grayLight:               "#9da9ab"
    property color grayLighter:             "#c2c6ca"
    property color white:                   "#edf0f1"
    property color blank:                   "#ffffff"

    // Accent colors
    // -------------------------
    property color blue:                    "#347bbe"
    property color blueLight:               "#6ca2da"
    property color green:                   "#31b575"
    property color greenLight:              "#41c987"
    property color sea:                     "#20a99b"
    property color seaLight:                "#26c2b0"
    property color red:                     "#c73755"
    property color redLight:                "#e3738b"
    property color yellow:                  "#e7b02c"
    property color yellowLight:             "#e5d028"
    property color orange:                  "#d9710c"
    property color orangeLight:             "#db9439"
    property color purple:                  "#9d50b0"
    property color purpleLight:             "#a668b4"

    // Scaffolding
    // -------------------------
    property color bodyBackground:          white
    property color textColor:               grayDarker

    // Links
    // -------------------------
    property color linkColor:               blue
    property color linkColorHover:          darken(linkColor, 15)

    // Typography
    // -------------------------
    property string sansFontFamily:         "SourceSansPro"
    property string serifFontFamily:        "SourceSansProLight"
    property string monoFontFamily:         "mono"
    property string iconsFontFamily:         "Glyphicons"

    property int baseFontSize:              em(2)
    property string baseFontFamily:         sansFontFamily
    property double baseLineHeight:         1
    property string altFontFamily:          serifFontFamily

    property string headingsFontFamily:     serifFontFamily
    property string headingsFontWeight:     "normal"
    property color headingsColor:           grayDark

    property string labelFontFamily: baseFontFamily
    property int labelFontSize: baseFontSize
    property color labelColor: blue

    // Component sizing
    // -------------------------
    property int fontSizeHuge: baseFontSize * 3
    property int fontSizeLarge:             baseFontSize * 1.50
    property int fontSizeSmall:             baseFontSize * 0.75
    property int fontSizeMini:              baseFontSize * 0.50
    property int fontSizeMedium: baseFontSize
    property int fontSizeNormal: baseFontSize

    property int paddingLarge:              em(4)
    property int paddingSmall:              em(2)
    property int paddingMini:               em(1)

    property int baseBorderRadius:          em(0.25)
    property int borderRadiusLarge:         em(0.25)
    property int borderRadiusSmall:         em(0.25)

    // Buttons
    // -------------------------
    property color btnBorder:                         white

    property color btnBackground:                     bodyBackground
    property color btnBackgroundActive:               darken(btnBackground,10)
    property color btnBackgroundHighlight:            lighten(btnBackground,10)
    property color btnPrimaryBackground:              linkColor
    property color btnPrimaryBackgroundActive:        darken(btnPrimaryBackground,10)
    property color btnPrimaryBackgroundHighlight:     lighten(btnPrimaryBackground,10)
    property color btnInfoBackground:                 sea
    property color btnInfoBackgroundActive:           darken(btnInfoBackground,10)
    property color btnSuccessBackground:              green
    property color btnSuccessBackgroundActive:         darken(btnSuccessBackground,10)
    property color btnWarningBackground:              orange
    property color btnWarningBackgroundActive:         darken(btnWarningBackground,10)
    property color btnDangerBackground:               red
    property color btnDangerBackgroundActive:         darken(btnDangerBackground,10)
//    property color btnInverseBackground:              grayDark
//    property color btnInverseBackground:              grayDark

    // Forms
    // -------------------------
    property color inputBackground:               blank
    property color inputBorder:                   blank
    property int inputBorderRadius:             baseBorderRadius
    property color inputDisabledBackground:       grayLighter
    property int inputHeight:                   em(4)

    // Input placeholder text color
    // -------------------------
    property color placeholderText:                 grayLight

    // Dropdowns
    // -------------------------
    property color dropdownBackground:            blank
    property color dropdownBorder:                blank

    property color dropdownLinkColor:             textColor
    property color dropdownLinkColorHover:        textColor
    property color dropdownLinkColorActive:       blank

    property color dropdownLinkBackgroundActive:  sea
    property color dropdownLinkBackgroundHover:   blank

    // Hr border color
    // -------------------------
    property color hrBorder:                        grayLighter

    // Popovers
    // -------------------------
    property color popoverBackground:       white
    property int popoverArrowWidth:         em(1)
    property color popoverArrowColor:       white
    property color popoverTitleBackground:  white
    property color popoverTitleColor:       grayDark


    // GRID
    // --------------------------------------------------
    property int baseUnitSize:      _computeBaseUnitSize()//(app.width/48)

    property int gridColumns:       12
    property int gridColumnWidth:   em(4)
    property int gridMarginWidth:   em(4)
    property int gridRowHeight:     em(4)
    property int gridRowSpacing:    em(2)

    property int span1: column(1)
    property int span2: column(2)
    property int span3: column(3)
    property int span4: column(4)
    property int span5: column(5)
    property int span6: column(6)
    property int span7: column(7)
    property int span8: column(8)
    property int span9: column(9)
    property int span10: column(10)
    property int span11: column(11)
    property int span12: column(12)


    // JAVA SCRIPT
    // --------------------------------------------------
    function _computeBaseUnitSize(){
        var d = Screen.logicalPixelDensity;
        console.log("Density: "+d);
        var s = Math.floor(d*2.5);
        console.log("Base Unit: "+s);
        return s<8?8:s;
    }

    function _componentToHex(c) {var hex = (c<255?c<1?0:c:255).toString(16); return hex.length == 1 ? "0" + hex : hex;}
    function rgb(R,G,B){return "#" + _componentToHex(R) + _componentToHex(G) + _componentToHex(B);}
    function rgba(R,G,B,A){return "#" + _componentToHex(A) + rgb(R,G,B).replace("#","");}
    function shadeColor(color, percent) {
        var num = parseInt(String(color).replace("#",""),16),
            amt = Math.round(2.55 * percent),
            R = (num >> 16) + amt,
            G = (num >> 8 & 0x00FF) + amt,
            B = (num & 0x0000FF) + amt;
        return rgb(R,G,B);
    }
    function lighten(color, percent){return shadeColor(color, percent)}
    function darken(color,percent){return shadeColor(color, percent*-1)}
    function em(i){return i*baseUnitSize}
    function column(i){return i*gridColumnWidth}
    function getIconCode(i){
        var codes = {'glass': '\uE001','leaf': '\uE002','dog': '\u1F415','user': '\uE004','girl': '\u1F467','car': '\uE006','user_add': '\uE007','user_remove': '\uE008','film': '\uE009','magic': '\uE010','envelope': '\u2709','camera': '\u1F4F7','heart': '\uE013','beach_umbrella': '\uE014','train': '\u1F686','print': '\uE016','bin': '\uE017','music': '\uE018','note': '\uE019','heart_empty': '\uE020','home': '\uE021','snowflake': '\u2744','fire': '\u1F525','magnet': '\uE024','parents': '\uE025','binoculars': '\uE026','road': '\uE027','search': '\uE028','cars': '\uE029','notes_2': '\uE030','pencil': '\u270F','bus': '\u1F68C','wifi_alt': '\uE033','luggage': '\uE034','old_man': '\uE035','woman': '\u1F469','file': '\uE037','coins': '\uE038','airplane': '\u2708','notes': '\uE040','stats': '\uE041','charts': '\uE042','pie_chart': '\uE043','group': '\uE044','keys': '\uE045','calendar': '\u1F4C5','router': '\uE047','camera_small': '\uE048','dislikes': '\uE049','star': '\uE050','link': '\uE051','eye_open': '\uE052','eye_close': '\uE053','alarm': '\uE054','clock': '\uE055','stopwatch': '\uE056','projector': '\uE057','history': '\uE058','truck': '\uE059','cargo': '\uE060','compass': '\uE061','keynote': '\uE062','paperclip': '\u1F4CE','power': '\uE064','lightbulb': '\uE065','tag': '\uE066','tags': '\uE067','cleaning': '\uE068','ruller': '\uE069','gift': '\uE070','umbrella': '\u2602','book': '\uE072','bookmark': '\u1F516','wifi': '\uE074','cup': '\uE075','stroller': '\uE076','headphones': '\uE077','headset': '\uE078','warning_sign': '\uE079','signal': '\uE080','retweet': '\uE081','refresh': '\uE082','roundabout': '\uE083','random': '\uE084','heat': '\uE085','repeat': '\uE086','display': '\uE087','log_book': '\uE088','address_book': '\uE089','building': '\uE090','eyedropper': '\uE091','adjust': '\uE092','tint': '\uE093','crop': '\uE094','vector_path_square': '\uE095','vector_path_circle': '\uE096','vector_path_polygon': '\uE097','vector_path_line': '\uE098','vector_path_curve': '\uE099','vector_path_all': '\uE100','font': '\uE101','italic': '\uE102','bold': '\uE103','text_underline': '\uE104','text_strike': '\uE105','text_height': '\uE106','text_width': '\uE107','text_resize': '\uE108','left_indent': '\uE109','right_indent': '\uE110','align_left': '\uE111','align_center': '\uE112','align_right': '\uE113','justify': '\uE114','list': '\uE115','text_smaller': '\uE116','text_bigger': '\uE117','embed': '\uE118','embed_close': '\uE119','table': '\uE120','message_full': '\uE121','message_empty': '\uE122','message_in': '\uE123','message_out': '\uE124','message_plus': '\uE125','message_minus': '\uE126','message_ban': '\uE127','message_flag': '\uE128','message_lock': '\uE129','message_new': '\uE130','inbox': '\uE131','inbox_plus': '\uE132','inbox_minus': '\uE133','inbox_lock': '\uE134','inbox_in': '\uE135','inbox_out': '\uE136','cogwheel': '\uE137','cogwheels': '\uE138','picture': '\uE139','adjust_alt': '\uE140','database_lock': '\uE141','database_plus': '\uE142','database_minus': '\uE143','database_ban': '\uE144','folder_open': '\uE145','folder_plus': '\uE146','folder_minus': '\uE147','folder_lock': '\uE148','folder_flag': '\uE149','folder_new': '\uE150','edit': '\uE151','new_window': '\uE152','check': '\uE153','unchecked': '\uE154','more_windows': '\uE155','show_big_thumbnails': '\uE156','show_thumbnails': '\uE157','show_thumbnails_with_lines': '\uE158','show_lines': '\uE159','playlist': '\uE160','imac': '\uE161','macbook': '\uE162','ipad': '\uE163','iphone': '\uE164','iphone_transfer': '\uE165','iphone_exchange': '\uE166','ipod': '\uE167','ipod_shuffle': '\uE168','ear_plugs': '\uE169','record': '\uE170','step_backward': '\uE171','fast_backward': '\uE172','rewind': '\uE173','play': '\uE174','pause': '\uE175','stop': '\uE176','forward': '\uE177','fast_forward': '\uE178','step_forward': '\uE179','eject': '\uE180','facetime_video': '\uE181','download_alt': '\uE182','mute': '\uE183','volume_down': '\uE184','volume_up': '\uE185','screenshot': '\uE186','move': '\uE187','more': '\uE188','brightness_reduce': '\uE189','brightness_increase': '\uE190','circle_plus': '\uE191','circle_minus': '\uE192','circle_remove': '\uE193','circle_ok': '\uE194','circle_question_mark': '\uE195','circle_info': '\uE196','circle_exclamation_mark': '\uE197','remove': '\uE198','ok': '\uE199','ban': '\uE200','download': '\uE201','upload': '\uE202','shopping_cart': '\uE203','lock': '\u1F512','unlock': '\uE205','electricity': '\uE206','ok_2': '\uE207','remove_2': '\uE208','cart_out': '\uE209','cart_in': '\uE210','left_arrow': '\uE211','right_arrow': '\uE212','down_arrow': '\uE213','up_arrow': '\uE214','resize_small': '\uE215','resize_full': '\uE216','circle_arrow_left': '\uE217','circle_arrow_right': '\uE218','circle_arrow_top': '\uE219','circle_arrow_down': '\uE220','play_button': '\uE221','unshare': '\uE222','share': '\uE223','chevron_right': '\uE224','chevron_left': '\uE225','bluetooth': '\uE226','euro': '\u20AC','usd': '\uE228','gbp': '\uE229','retweet_2': '\uE230','moon': '\uE231','sun': '\u2609','cloud': '\u2601','direction': '\uE234','brush': '\uE235','pen': '\uE236','zoom_in': '\uE237','zoom_out': '\uE238','pin': '\uE239','albums': '\uE240','rotation_lock': '\uE241','flash': '\uE242','google_maps': '\uE243','anchor': '\u2693','conversation': '\uE245','chat': '\uE246','male': '\uE247','female': '\uE248','asterisk': '\u002A','divide': '\u00F7','snorkel_diving': '\uE251','scuba_diving': '\uE252','oxygen_bottle': '\uE253','fins': '\uE254','fishes': '\uE255','boat': '\uE256','delete': '\uE257','sheriffs_star': '\uE258','qrcode': '\uE259','barcode': '\uE260','pool': '\uE261','buoy': '\uE262','spade': '\uE263','bank': '\u1F3E6','vcard': '\uE265','electrical_plug': '\uE266','flag': '\uE267','credit_card': '\uE268','keyboard_wireless': '\uE269','keyboard_wired': '\uE270','shield': '\uE271','ring': '\u02DA','cake': '\uE273','drink': '\uE274','beer': '\uE275','fast_food': '\uE276','cutlery': '\uE277','pizza': '\uE278','birthday_cake': '\uE279','tablet': '\uE280','settings': '\uE281','bullets': '\uE282','cardio': '\uE283','t_shirt': '\uE284','pants': '\uE285','sweater': '\uE286','fabric': '\uE287','leather': '\uE288','scissors': '\uE289','bomb': '\u1F4A3','skull': '\u1F480','celebration': '\uE292','tea_kettle': '\uE293','french_press': '\uE294','coffe_cup': '\uE295','pot': '\uE296','grater': '\uE297','kettle': '\uE298','hospital': '\u1F3E5','hospital_h': '\uE300','microphone': '\u1F3A4','webcam': '\uE302','temple_christianity_church': '\uE303','temple_islam': '\uE304','temple_hindu': '\uE305','temple_buddhist': '\uE306','bicycle': '\u1F6B2','life_preserver': '\uE308','share_alt': '\uE309','comments': '\uE310','flower': '\u2698','baseball': '\u26BE','rugby': '\uE313','ax': '\uE314','table_tennis': '\uE315','bowling': '\u1F3B3','tree_conifer': '\uE317','tree_deciduous': '\uE318','more_items': '\uE319','sort': '\uE320','filter': '\uE321','gamepad': '\uE322','playing_dices': '\uE323','calculator': '\uE324','tie': '\uE325','wallet': '\uE326','piano': '\uE327','sampler': '\uE328','podium': '\uE329','soccer_ball': '\uE330','blog': '\uE331','dashboard': '\uE332','certificate': '\uE333','bell': '\u1F514','candle': '\uE335','pushpin': '\u1F4CC','iphone_shake': '\uE337','pin_flag': '\uE338','turtle': '\u1F422','rabbit': '\u1F407','globe': '\uE341','briefcase': '\u1F4BC','hdd': '\uE343','thumbs_up': '\uE344','thumbs_down': '\uE345','hand_right': '\uE346','hand_left': '\uE347','hand_up': '\uE348','hand_down': '\uE349','fullscreen': '\uE350','shopping_bag': '\uE351','book_open': '\uE352','nameplate': '\uE353','nameplate_alt': '\uE354','vases': '\uE355','bullhorn': '\uE356','dumbbell': '\uE357','suitcase': '\uE358','file_import': '\uE359','file_export': '\uE360','bug': '\u1F41B','crown': '\u1F451','smoking': '\uE363','cloud_upload': '\uE364','cloud_download': '\uE365','restart': '\uE366','security_camera': '\uE367','expand': '\uE368','collapse': '\uE369','collapse_top': '\uE370','globe_af': '\uE371','global': '\uE372','spray': '\uE373','nails': '\uE374','claw_hammer': '\uE375','classic_hammer': '\uE376','hand_saw': '\uE377','riflescope': '\uE378','electrical_socket_eu': '\uE379','electrical_socket_us': '\uE380','message_forward': '\uE381','coat_hanger': '\uE382','dress': '\u1F457','bathrobe': '\uE384','shirt': '\uE385','underwear': '\uE386','log_in': '\uE387','log_out': '\uE388','exit': '\uE389','new_window_alt': '\uE390','video_sd': '\uE391','video_hd': '\uE392','subtitles': '\uE393','sound_stereo': '\uE394','sound_dolby': '\uE395','sound_5_1': '\uE396','sound_6_1': '\uE397','sound_7_1': '\uE398','copyright_mark': '\uE399','registration_mark': '\uE400','radar': '\uE401','skateboard': '\uE402','golf_course': '\uE403','sorting': '\uE404','sort_by_alphabet': '\uE405','sort_by_alphabet_alt': '\uE406','sort_by_order': '\uE407','sort_by_order_alt': '\uE408','sort_by_attributes': '\uE409','sort_by_attributes_alt': '\uE410','compressed': '\uE411','package': '\u1F4E6','cloud_plus': '\uE413','cloud_minus': '\uE414','disk_save': '\uE415','disk_open': '\uE416','disk_saved': '\uE417','disk_remove': '\uE418','disk_import': '\uE419','disk_export': '\uE420','tower': '\uE421','send': '\uE422','git_branch': '\uE423','git_create': '\uE424','git_private': '\uE425','git_delete': '\uE426','git_merge': '\uE427','git_pull_request': '\uE428','git_compare': '\uE429','git_commit': '\uE430','construction_cone': '\uE431','shoe_steps': '\uE432','plus': '\u002B','minus': '\u2212','redo': '\uE435','undo': '\uE436','golf': '\uE437','hockey': '\uE438','pipe': '\uE439','wrench': '\u1F527','folder_closed': '\uE441','phone_alt': '\uE442','earphone': '\uE443','floppy_disk': '\uE444','floppy_saved': '\uE445','floppy_remove': '\uE446','floppy_save': '\uE447','floppy_open': '\uE448','translate': '\uE449','fax': '\uE450','factory': '\u1F3ED','shop_window': '\uE452','shop': '\uE453','kiosk': '\uE454','kiosk_wheels': '\uE455','kiosk_light': '\uE456','kiosk_food': '\uE457','transfer': '\uE458','money': '\uE459','header': '\uE460','blacksmith': '\uE461','saw_blade': '\uE462','basketball': '\uE463','server': '\uE464','server_plus': '\uE465','server_minus': '\uE466','server_ban': '\uE467','server_flag': '\uE468','server_lock': '\uE469','server_new': '\uE470'};
        return codes[i]==undefined?"":codes[i];
    }
}
