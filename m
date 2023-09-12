Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D922579CEC9
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:48:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vW-0002zH-J6; Tue, 12 Sep 2023 06:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vU-0002z9-0e
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vR-0003GQ-Ed
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGSX3VSTfowEWnReKm2v86qri4x0T7v1nFRl0NaKYuU=;
 b=SkV49VgI7L2xZwtPcL++wjDD95kh4HDZs3TBSqQcjdJw3AMRojN5IT3z4G5ZsSaAheNSdJ
 BcXGx+8uvPdIsnMkRPDnZieW+PtiyOLvG7dgqGPHpIehdAKv4iTvWgNSLLZVyMylP2yl4f
 cbyIVihSYjTD2LTunzo19VW3xOTVvBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-H0sTwx0KNgeJ9t4YfJ1skg-1; Tue, 12 Sep 2023 06:47:18 -0400
X-MC-Unique: H0sTwx0KNgeJ9t4YfJ1skg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C206933862;
 Tue, 12 Sep 2023 10:47:18 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7753E40C6EBF;
 Tue, 12 Sep 2023 10:47:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 07/14] ui/vc: rename kbd_put to qemu_text_console functions
Date: Tue, 12 Sep 2023 14:46:41 +0400
Message-ID: <20230912104649.1638640-8-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

They are QemuTextConsole functions, let's make it clear.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/ui/console.h |  6 ++---
 ui/console.c         | 10 ++++----
 ui/curses.c          |  2 +-
 ui/gtk.c             |  6 ++---
 ui/sdl2-input.c      |  4 ++--
 ui/sdl2.c            |  2 +-
 ui/vnc.c             | 54 ++++++++++++++++++++++----------------------
 ui/cocoa.m           |  2 +-
 8 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 9c362f0e87..26d63d17a2 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -112,9 +112,9 @@ bool qemu_mouse_set(int index, Error **errp);
 #define QEMU_KEY_CTRL_PAGEUP     0xe406
 #define QEMU_KEY_CTRL_PAGEDOWN   0xe407
 
-void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
-bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
-void kbd_put_string_console(QemuTextConsole *s, const char *str, int len);
+void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym);
+bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl);
+void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len);
 
 /* Touch devices */
 typedef struct touch_slot {
diff --git a/ui/console.c b/ui/console.c
index 4c07791ac7..7c60fc7d18 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1135,7 +1135,7 @@ static void kbd_send_chars(QemuTextConsole *s)
 }
 
 /* called when an ascii key is pressed */
-void kbd_put_keysym_console(QemuTextConsole *s, int keysym)
+void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym)
 {
     uint8_t buf[16], *q;
     int c;
@@ -1217,7 +1217,7 @@ static const int ctrl_qcode_to_keysym[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_PGDN]   = QEMU_KEY_CTRL_PAGEDOWN,
 };
 
-bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl)
+bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl)
 {
     int keysym;
 
@@ -1225,16 +1225,16 @@ bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl)
     if (keysym == 0) {
         return false;
     }
-    kbd_put_keysym_console(s, keysym);
+    qemu_text_console_put_keysym(s, keysym);
     return true;
 }
 
-void kbd_put_string_console(QemuTextConsole *s, const char *str, int len)
+void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len)
 {
     int i;
 
     for (i = 0; i < len && str[i]; i++) {
-        kbd_put_keysym_console(s, str[i]);
+        qemu_text_console_put_keysym(s, str[i]);
     }
 }
 
diff --git a/ui/curses.c b/ui/curses.c
index 4ddbbae7cd..8bde8c5cf7 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -400,7 +400,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
             if (keysym == -1)
                 keysym = chr;
 
-            kbd_put_keysym_console(NULL, keysym);
+            qemu_text_console_put_keysym(NULL, keysym);
         }
     }
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index a14d56168d..c05f9a3f83 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1190,12 +1190,12 @@ static gboolean gd_text_key_down(GtkWidget *widget,
     QemuTextConsole *con = QEMU_TEXT_CONSOLE(vc->gfx.dcl.con);
 
     if (key->keyval == GDK_KEY_Delete) {
-        kbd_put_qcode_console(con, Q_KEY_CODE_DELETE, false);
+        qemu_text_console_put_qcode(con, Q_KEY_CODE_DELETE, false);
     } else if (key->length) {
-        kbd_put_string_console(con, key->string, key->length);
+        qemu_text_console_put_string(con, key->string, key->length);
     } else {
         int qcode = gd_map_keycode(gd_get_keycode(key));
-        kbd_put_qcode_console(con, qcode, false);
+        qemu_text_console_put_qcode(con, qcode, false);
     }
     return TRUE;
 }
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index a318cc5867..b02a89ee7c 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -49,10 +49,10 @@ void sdl2_process_key(struct sdl2_console *scon,
         if (ev->type == SDL_KEYDOWN) {
             switch (qcode) {
             case Q_KEY_CODE_RET:
-                kbd_put_keysym_console(s, '\n');
+                qemu_text_console_put_keysym(s, '\n');
                 break;
             default:
-                kbd_put_qcode_console(s, qcode, ctrl);
+                qemu_text_console_put_qcode(s, qcode, ctrl);
                 break;
             }
         }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index dfa260a507..178cc054ab 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -484,7 +484,7 @@ static void handle_textinput(SDL_Event *ev)
     }
 
     if (QEMU_IS_TEXT_CONSOLE(con)) {
-        kbd_put_string_console(QEMU_TEXT_CONSOLE(con), ev->text.text, strlen(ev->text.text));
+        qemu_text_console_put_string(QEMU_TEXT_CONSOLE(con), ev->text.text, strlen(ev->text.text));
     }
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 1fa4456744..22894b7b1f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1945,88 +1945,88 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
             case 0xb8:                          /* Right ALT */
                 break;
             case 0xc8:
-                kbd_put_keysym_console(NULL, QEMU_KEY_UP);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_UP);
                 break;
             case 0xd0:
-                kbd_put_keysym_console(NULL, QEMU_KEY_DOWN);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_DOWN);
                 break;
             case 0xcb:
-                kbd_put_keysym_console(NULL, QEMU_KEY_LEFT);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_LEFT);
                 break;
             case 0xcd:
-                kbd_put_keysym_console(NULL, QEMU_KEY_RIGHT);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_RIGHT);
                 break;
             case 0xd3:
-                kbd_put_keysym_console(NULL, QEMU_KEY_DELETE);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_DELETE);
                 break;
             case 0xc7:
-                kbd_put_keysym_console(NULL, QEMU_KEY_HOME);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_HOME);
                 break;
             case 0xcf:
-                kbd_put_keysym_console(NULL, QEMU_KEY_END);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_END);
                 break;
             case 0xc9:
-                kbd_put_keysym_console(NULL, QEMU_KEY_PAGEUP);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_PAGEUP);
                 break;
             case 0xd1:
-                kbd_put_keysym_console(NULL, QEMU_KEY_PAGEDOWN);
+                qemu_text_console_put_keysym(NULL, QEMU_KEY_PAGEDOWN);
                 break;
 
             case 0x47:
-                kbd_put_keysym_console(NULL, numlock ? '7' : QEMU_KEY_HOME);
+                qemu_text_console_put_keysym(NULL, numlock ? '7' : QEMU_KEY_HOME);
                 break;
             case 0x48:
-                kbd_put_keysym_console(NULL, numlock ? '8' : QEMU_KEY_UP);
+                qemu_text_console_put_keysym(NULL, numlock ? '8' : QEMU_KEY_UP);
                 break;
             case 0x49:
-                kbd_put_keysym_console(NULL, numlock ? '9' : QEMU_KEY_PAGEUP);
+                qemu_text_console_put_keysym(NULL, numlock ? '9' : QEMU_KEY_PAGEUP);
                 break;
             case 0x4b:
-                kbd_put_keysym_console(NULL, numlock ? '4' : QEMU_KEY_LEFT);
+                qemu_text_console_put_keysym(NULL, numlock ? '4' : QEMU_KEY_LEFT);
                 break;
             case 0x4c:
-                kbd_put_keysym_console(NULL, '5');
+                qemu_text_console_put_keysym(NULL, '5');
                 break;
             case 0x4d:
-                kbd_put_keysym_console(NULL, numlock ? '6' : QEMU_KEY_RIGHT);
+                qemu_text_console_put_keysym(NULL, numlock ? '6' : QEMU_KEY_RIGHT);
                 break;
             case 0x4f:
-                kbd_put_keysym_console(NULL, numlock ? '1' : QEMU_KEY_END);
+                qemu_text_console_put_keysym(NULL, numlock ? '1' : QEMU_KEY_END);
                 break;
             case 0x50:
-                kbd_put_keysym_console(NULL, numlock ? '2' : QEMU_KEY_DOWN);
+                qemu_text_console_put_keysym(NULL, numlock ? '2' : QEMU_KEY_DOWN);
                 break;
             case 0x51:
-                kbd_put_keysym_console(NULL, numlock ? '3' : QEMU_KEY_PAGEDOWN);
+                qemu_text_console_put_keysym(NULL, numlock ? '3' : QEMU_KEY_PAGEDOWN);
                 break;
             case 0x52:
-                kbd_put_keysym_console(NULL, '0');
+                qemu_text_console_put_keysym(NULL, '0');
                 break;
             case 0x53:
-                kbd_put_keysym_console(NULL, numlock ? '.' : QEMU_KEY_DELETE);
+                qemu_text_console_put_keysym(NULL, numlock ? '.' : QEMU_KEY_DELETE);
                 break;
 
             case 0xb5:
-                kbd_put_keysym_console(NULL, '/');
+                qemu_text_console_put_keysym(NULL, '/');
                 break;
             case 0x37:
-                kbd_put_keysym_console(NULL, '*');
+                qemu_text_console_put_keysym(NULL, '*');
                 break;
             case 0x4a:
-                kbd_put_keysym_console(NULL, '-');
+                qemu_text_console_put_keysym(NULL, '-');
                 break;
             case 0x4e:
-                kbd_put_keysym_console(NULL, '+');
+                qemu_text_console_put_keysym(NULL, '+');
                 break;
             case 0x9c:
-                kbd_put_keysym_console(NULL, '\n');
+                qemu_text_console_put_keysym(NULL, '\n');
                 break;
 
             default:
                 if (control) {
-                    kbd_put_keysym_console(NULL, sym & 0x1f);
+                    qemu_text_console_put_keysym(NULL, sym & 0x1f);
                 } else {
-                    kbd_put_keysym_console(NULL, sym);
+                    qemu_text_console_put_keysym(NULL, sym);
                 }
                 break;
             }
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 90a89c5c8e..df6d13be38 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -784,7 +784,7 @@ - (void) handleMonitorInput:(NSEvent *)event
     }
 
     if (keysym) {
-        kbd_put_keysym_console(NULL, keysym);
+        qemu_text_console_put_keysym(NULL, keysym);
     }
 }
 
-- 
2.41.0


