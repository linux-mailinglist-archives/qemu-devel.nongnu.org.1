Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1DC7916D1
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8BZ-0000nh-3k; Mon, 04 Sep 2023 07:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BL-0000U9-VY
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BJ-0000nm-KE
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwisok89V+z6ZrudsYeGkn84x6t1e0ASdik0dInwXEg=;
 b=OP17o875bps6mfUb6TNuSutwtg7KGHukxRhCmLPdzRn8vlh6x2CieUPn/SZGayfdZmcOcZ
 xv32q3nSI2q4hS1gnKAe52J5Xsl9K3OvqygSJOKkWky9sZmjE7/E/jrJaiF6FnqcjVNRlj
 0CQf6kkIqC5/3pTQI+fbPKDlZoZCj7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-CfvFrV1vOrihkURvo0_bJQ-1; Mon, 04 Sep 2023 07:55:47 -0400
X-MC-Unique: CfvFrV1vOrihkURvo0_bJQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 860A51817909
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:47 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82E13493110;
 Mon,  4 Sep 2023 11:55:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 44/52] ui/vc: change the argument for QemuTextConsole
Date: Mon,  4 Sep 2023 15:52:41 +0400
Message-ID: <20230904115251.4161397-45-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Those functions are specifc to text/vc console, make that explicit from
the argument type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-45-marcandre.lureau@redhat.com>
---
 include/ui/console.h |  6 +++---
 ui/console.c         | 14 ++++++--------
 ui/gtk.c             |  2 +-
 ui/sdl2-input.c      |  7 ++++---
 ui/sdl2.c            |  5 ++---
 5 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 91d8bbc9dc..1ccd432b4d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -112,9 +112,9 @@ bool qemu_mouse_set(int index, Error **errp);
 #define QEMU_KEY_CTRL_PAGEUP     0xe406
 #define QEMU_KEY_CTRL_PAGEDOWN   0xe407
 
-void kbd_put_keysym_console(QemuConsole *s, int keysym);
-bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl);
-void kbd_put_string_console(QemuConsole *s, const char *str, int len);
+void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
+bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
+void kbd_put_string_console(QemuTextConsole *s, const char *str, int len);
 void kbd_put_keysym(int keysym);
 
 /* Touch devices */
diff --git a/ui/console.c b/ui/console.c
index e2b0b9ce06..e4d61794bb 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1135,16 +1135,12 @@ static void kbd_send_chars(QemuTextConsole *s)
 }
 
 /* called when an ascii key is pressed */
-void kbd_put_keysym_console(QemuConsole *con, int keysym)
+void kbd_put_keysym_console(QemuTextConsole *s, int keysym)
 {
-    QemuTextConsole *s = (QemuTextConsole *)object_dynamic_cast(OBJECT(con), TYPE_QEMU_TEXT_CONSOLE);
     uint8_t buf[16], *q;
     int c;
     uint32_t num_free;
 
-    if (!s)
-        return;
-
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
         console_scroll(s, -1);
@@ -1214,7 +1210,7 @@ static const int ctrl_qcode_to_keysym[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_PGDN]   = QEMU_KEY_CTRL_PAGEDOWN,
 };
 
-bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl)
+bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl)
 {
     int keysym;
 
@@ -1226,7 +1222,7 @@ bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl)
     return true;
 }
 
-void kbd_put_string_console(QemuConsole *s, const char *str, int len)
+void kbd_put_string_console(QemuTextConsole *s, const char *str, int len)
 {
     int i;
 
@@ -1237,7 +1233,9 @@ void kbd_put_string_console(QemuConsole *s, const char *str, int len)
 
 void kbd_put_keysym(int keysym)
 {
-    kbd_put_keysym_console(active_console, keysym);
+    if (QEMU_IS_TEXT_CONSOLE(active_console)) {
+        kbd_put_keysym_console(QEMU_TEXT_CONSOLE(active_console), keysym);
+    }
 }
 
 static void text_console_invalidate(void *opaque)
diff --git a/ui/gtk.c b/ui/gtk.c
index ef98bb0648..c34c133550 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1187,7 +1187,7 @@ static gboolean gd_text_key_down(GtkWidget *widget,
                                  GdkEventKey *key, void *opaque)
 {
     VirtualConsole *vc = opaque;
-    QemuConsole *con = vc->gfx.dcl.con;
+    QemuTextConsole *con = QEMU_TEXT_CONSOLE(vc->gfx.dcl.con);
 
     if (key->keyval == GDK_KEY_Delete) {
         kbd_put_qcode_console(con, Q_KEY_CODE_DELETE, false);
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index f068382209..a318cc5867 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -43,15 +43,16 @@ void sdl2_process_key(struct sdl2_console *scon,
                            ev->type == SDL_KEYDOWN ? "down" : "up");
     qkbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
 
-    if (!qemu_console_is_graphic(con)) {
+    if (QEMU_IS_TEXT_CONSOLE(con)) {
+        QemuTextConsole *s = QEMU_TEXT_CONSOLE(con);
         bool ctrl = qkbd_state_modifier_get(scon->kbd, QKBD_MOD_CTRL);
         if (ev->type == SDL_KEYDOWN) {
             switch (qcode) {
             case Q_KEY_CODE_RET:
-                kbd_put_keysym_console(con, '\n');
+                kbd_put_keysym_console(s, '\n');
                 break;
             default:
-                kbd_put_qcode_console(con, qcode, ctrl);
+                kbd_put_qcode_console(s, qcode, ctrl);
                 break;
             }
         }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 0d91b555e3..16b515fcf9 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -483,10 +483,9 @@ static void handle_textinput(SDL_Event *ev)
         return;
     }
 
-    if (qemu_console_is_graphic(con)) {
-        return;
+    if (QEMU_IS_TEXT_CONSOLE(con)) {
+        kbd_put_string_console(QEMU_TEXT_CONSOLE(con), ev->text.text, strlen(ev->text.text));
     }
-    kbd_put_string_console(con, ev->text.text, strlen(ev->text.text));
 }
 
 static void handle_mousemotion(SDL_Event *ev)
-- 
2.41.0


