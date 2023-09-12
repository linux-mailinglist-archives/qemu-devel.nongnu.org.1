Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D679CEB4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:48:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vU-0002z7-2D; Tue, 12 Sep 2023 06:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vR-0002yR-OK
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vP-0003GD-Bs
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tNCg7/131/j8UlDEUuGwpZGI6/ApHpk0SlrjN6YlNA=;
 b=ijA/c+AftlJPpRIhx3DnCsf2fdtuVHDWVjBzCSe9y6ji+wJRdYFTQuaBAiqlQSdZptJAVq
 tOCetoZcKjchjOY6Yd8BXocOMccPBrzQ+JtYfXGmESIshSI9s4ulQ5XISRPfSgbut5o4Vz
 5hSPSjmVCGrvFBWbywLbQINFVLXKk4A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-VtAZmBDbM4uUX9hDBVDPbg-1; Tue, 12 Sep 2023 06:47:15 -0400
X-MC-Unique: VtAZmBDbM4uUX9hDBVDPbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B035E3814E87;
 Tue, 12 Sep 2023 10:47:14 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EC8E63F9D;
 Tue, 12 Sep 2023 10:47:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 06/14] ui/vc: remove kbd_put_keysym() and update function calls
Date: Tue, 12 Sep 2023 14:46:40 +0400
Message-ID: <20230912104649.1638640-7-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The function calls to `kbd_put_keysym` have been updated to now call
`kbd_put_keysym_console` with a NULL console parameter.

Like most console functions, NULL argument is now for the active console.

This will allow to rename the text console functions in a consistent manner.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/ui/console.h |  1 -
 ui/console.c         | 14 ++++++------
 ui/curses.c          |  2 +-
 ui/vnc.c             | 54 ++++++++++++++++++++++----------------------
 ui/cocoa.m           |  2 +-
 5 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 1ccd432b4d..9c362f0e87 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -115,7 +115,6 @@ bool qemu_mouse_set(int index, Error **errp);
 void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
 bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
 void kbd_put_string_console(QemuTextConsole *s, const char *str, int len);
-void kbd_put_keysym(int keysym);
 
 /* Touch devices */
 typedef struct touch_slot {
diff --git a/ui/console.c b/ui/console.c
index e4d61794bb..4c07791ac7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1141,6 +1141,13 @@ void kbd_put_keysym_console(QemuTextConsole *s, int keysym)
     int c;
     uint32_t num_free;
 
+    if (!s) {
+        if (!QEMU_IS_TEXT_CONSOLE(active_console)) {
+            return;
+        }
+        s = QEMU_TEXT_CONSOLE(active_console);
+    }
+
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
         console_scroll(s, -1);
@@ -1231,13 +1238,6 @@ void kbd_put_string_console(QemuTextConsole *s, const char *str, int len)
     }
 }
 
-void kbd_put_keysym(int keysym)
-{
-    if (QEMU_IS_TEXT_CONSOLE(active_console)) {
-        kbd_put_keysym_console(QEMU_TEXT_CONSOLE(active_console), keysym);
-    }
-}
-
 static void text_console_invalidate(void *opaque)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
diff --git a/ui/curses.c b/ui/curses.c
index de962faa7c..4ddbbae7cd 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -400,7 +400,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
             if (keysym == -1)
                 keysym = chr;
 
-            kbd_put_keysym(keysym);
+            kbd_put_keysym_console(NULL, keysym);
         }
     }
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 92964dcc0c..1fa4456744 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1945,88 +1945,88 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
             case 0xb8:                          /* Right ALT */
                 break;
             case 0xc8:
-                kbd_put_keysym(QEMU_KEY_UP);
+                kbd_put_keysym_console(NULL, QEMU_KEY_UP);
                 break;
             case 0xd0:
-                kbd_put_keysym(QEMU_KEY_DOWN);
+                kbd_put_keysym_console(NULL, QEMU_KEY_DOWN);
                 break;
             case 0xcb:
-                kbd_put_keysym(QEMU_KEY_LEFT);
+                kbd_put_keysym_console(NULL, QEMU_KEY_LEFT);
                 break;
             case 0xcd:
-                kbd_put_keysym(QEMU_KEY_RIGHT);
+                kbd_put_keysym_console(NULL, QEMU_KEY_RIGHT);
                 break;
             case 0xd3:
-                kbd_put_keysym(QEMU_KEY_DELETE);
+                kbd_put_keysym_console(NULL, QEMU_KEY_DELETE);
                 break;
             case 0xc7:
-                kbd_put_keysym(QEMU_KEY_HOME);
+                kbd_put_keysym_console(NULL, QEMU_KEY_HOME);
                 break;
             case 0xcf:
-                kbd_put_keysym(QEMU_KEY_END);
+                kbd_put_keysym_console(NULL, QEMU_KEY_END);
                 break;
             case 0xc9:
-                kbd_put_keysym(QEMU_KEY_PAGEUP);
+                kbd_put_keysym_console(NULL, QEMU_KEY_PAGEUP);
                 break;
             case 0xd1:
-                kbd_put_keysym(QEMU_KEY_PAGEDOWN);
+                kbd_put_keysym_console(NULL, QEMU_KEY_PAGEDOWN);
                 break;
 
             case 0x47:
-                kbd_put_keysym(numlock ? '7' : QEMU_KEY_HOME);
+                kbd_put_keysym_console(NULL, numlock ? '7' : QEMU_KEY_HOME);
                 break;
             case 0x48:
-                kbd_put_keysym(numlock ? '8' : QEMU_KEY_UP);
+                kbd_put_keysym_console(NULL, numlock ? '8' : QEMU_KEY_UP);
                 break;
             case 0x49:
-                kbd_put_keysym(numlock ? '9' : QEMU_KEY_PAGEUP);
+                kbd_put_keysym_console(NULL, numlock ? '9' : QEMU_KEY_PAGEUP);
                 break;
             case 0x4b:
-                kbd_put_keysym(numlock ? '4' : QEMU_KEY_LEFT);
+                kbd_put_keysym_console(NULL, numlock ? '4' : QEMU_KEY_LEFT);
                 break;
             case 0x4c:
-                kbd_put_keysym('5');
+                kbd_put_keysym_console(NULL, '5');
                 break;
             case 0x4d:
-                kbd_put_keysym(numlock ? '6' : QEMU_KEY_RIGHT);
+                kbd_put_keysym_console(NULL, numlock ? '6' : QEMU_KEY_RIGHT);
                 break;
             case 0x4f:
-                kbd_put_keysym(numlock ? '1' : QEMU_KEY_END);
+                kbd_put_keysym_console(NULL, numlock ? '1' : QEMU_KEY_END);
                 break;
             case 0x50:
-                kbd_put_keysym(numlock ? '2' : QEMU_KEY_DOWN);
+                kbd_put_keysym_console(NULL, numlock ? '2' : QEMU_KEY_DOWN);
                 break;
             case 0x51:
-                kbd_put_keysym(numlock ? '3' : QEMU_KEY_PAGEDOWN);
+                kbd_put_keysym_console(NULL, numlock ? '3' : QEMU_KEY_PAGEDOWN);
                 break;
             case 0x52:
-                kbd_put_keysym('0');
+                kbd_put_keysym_console(NULL, '0');
                 break;
             case 0x53:
-                kbd_put_keysym(numlock ? '.' : QEMU_KEY_DELETE);
+                kbd_put_keysym_console(NULL, numlock ? '.' : QEMU_KEY_DELETE);
                 break;
 
             case 0xb5:
-                kbd_put_keysym('/');
+                kbd_put_keysym_console(NULL, '/');
                 break;
             case 0x37:
-                kbd_put_keysym('*');
+                kbd_put_keysym_console(NULL, '*');
                 break;
             case 0x4a:
-                kbd_put_keysym('-');
+                kbd_put_keysym_console(NULL, '-');
                 break;
             case 0x4e:
-                kbd_put_keysym('+');
+                kbd_put_keysym_console(NULL, '+');
                 break;
             case 0x9c:
-                kbd_put_keysym('\n');
+                kbd_put_keysym_console(NULL, '\n');
                 break;
 
             default:
                 if (control) {
-                    kbd_put_keysym(sym & 0x1f);
+                    kbd_put_keysym_console(NULL, sym & 0x1f);
                 } else {
-                    kbd_put_keysym(sym);
+                    kbd_put_keysym_console(NULL, sym);
                 }
                 break;
             }
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4d8989c4eb..90a89c5c8e 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -784,7 +784,7 @@ - (void) handleMonitorInput:(NSEvent *)event
     }
 
     if (keysym) {
-        kbd_put_keysym(keysym);
+        kbd_put_keysym_console(NULL, keysym);
     }
 }
 
-- 
2.41.0


