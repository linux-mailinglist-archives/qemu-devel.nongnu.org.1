Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08DA3FDFE
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 18:53:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXAQ-000101-Ru; Fri, 21 Feb 2025 12:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXAA-0000wt-7o; Fri, 21 Feb 2025 12:50:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXA8-0001os-2B; Fri, 21 Feb 2025 12:50:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4875FEFB6B;
 Fri, 21 Feb 2025 20:49:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F3BB31BB587;
 Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E119D53F89; Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 08/14] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
Date: Fri, 21 Feb 2025 20:49:38 +0300
Message-Id: <20250221174949.836197-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
References: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Volker Rümelin <vr_qemu@t-online.de>

Windows only:

The libSDL2 Windows message loop needs the libSDL2 Windows low
level keyboard hook procedure to grab the left and right Windows
keys correctly. Reenable the SDL2 Windows keyboard hook procedure.

Since SDL2 2.30.4 the SDL2 keyboard hook procedure also filters
out the special left Control key event for every Alt Gr key event
on keyboards with an international layout. This means the QEMU low
level keyboard hook procedure is no longer needed. Remove the QEMU
Windows keyboard hook procedure.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Link: https://lore.kernel.org/r/20241231115950.6732-1-vr_qemu@t-online.de
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4dafba778aa3e5f5fd3b2c6333afd7650dcf54e2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix in ui/sdl2.c (includes))

diff --git a/ui/meson.build b/ui/meson.build
index 28c7381dd1..35fb04cadf 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -120,10 +120,6 @@ if gtk.found()
 endif
 
 if sdl.found()
-  if host_os == 'windows'
-    system_ss.add(files('win32-kbd-hook.c'))
-  endif
-
   sdl_ss = ss.source_set()
   sdl_ss.add(sdl, sdl_image, pixman, glib, files(
     'sdl2-2d.c',
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da1..3d70eaebfa 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -32,7 +32,6 @@
 #include "sysemu/runstate.h"
 #include "sysemu/runstate-action.h"
 #include "sysemu/sysemu.h"
-#include "ui/win32-kbd-hook.h"
 #include "qemu/log.h"
 
 static int sdl2_num_outputs;
@@ -262,7 +261,6 @@ static void sdl_grab_start(struct sdl2_console *scon)
     }
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
     gui_grab = 1;
-    win32_kbd_set_grab(true);
     sdl_update_caption(scon);
 }
 
@@ -270,7 +268,6 @@ static void sdl_grab_end(struct sdl2_console *scon)
 {
     SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
     gui_grab = 0;
-    win32_kbd_set_grab(false);
     sdl_show_cursor(scon);
     sdl_update_caption(scon);
 }
@@ -371,19 +368,6 @@ static int get_mod_state(void)
     }
 }
 
-static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
-{
-#ifdef CONFIG_WIN32
-    SDL_SysWMinfo info;
-
-    SDL_VERSION(&info.version);
-    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
-        return info.info.win.window;
-    }
-#endif
-    return NULL;
-}
-
 static void handle_keydown(SDL_Event *ev)
 {
     int win;
@@ -608,10 +592,6 @@ static void handle_windowevent(SDL_Event *ev)
         sdl2_redraw(scon);
         break;
     case SDL_WINDOWEVENT_FOCUS_GAINED:
-        win32_kbd_set_grab(gui_grab);
-        if (qemu_console_is_graphic(scon->dcl.con)) {
-            win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
-        }
         /* fall through */
     case SDL_WINDOWEVENT_ENTER:
         if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled)) {
@@ -627,9 +607,6 @@ static void handle_windowevent(SDL_Event *ev)
         scon->ignore_hotkeys = get_mod_state();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
-        if (qemu_console_is_graphic(scon->dcl.con)) {
-            win32_kbd_set_window(NULL);
-        }
         if (gui_grab && !gui_fullscreen) {
             sdl_grab_end(scon);
         }
@@ -869,10 +846,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available since SDL 2.0.8 */
     SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
 #endif
-#ifndef CONFIG_WIN32
-    /* QEMU uses its own low level keyboard hook procedure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
-#endif
 #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
-- 
2.39.5


