Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6080C3A4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 09:53:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCc0n-0006Z1-UL; Mon, 11 Dec 2023 03:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCc0j-0006Yc-5d
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 03:51:33 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCc0h-0008NX-7l
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 03:51:32 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28647f4ebd9so3070379a91.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 00:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702284689; x=1702889489;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B/pzIZ3BohsXqpWfmB+fQTt0imLSwJ89JKWtIquebsc=;
 b=IgRBoxfOYRM4ynWmGH7gh3eqIbVqM3RRxyOrZyyvgOoRNnf4mnaoWXfBWLuGpTCmyA
 KV/SRG8Ygf9CpDSzDoevrD6Msq+tsGws1qjvZg9NxRRYgNNjiP4owbYuW5GrPcWmOVMR
 Ip2oCfLBG7Z1NM91lAdtgSieXPOjogEM8ISrEyX0//e7ukdm6mwAv54CavT6EhI7LCbf
 F4LMO245LzYdeVqO7OMz5Nb2KMyxmQAN0lMg6ffqEOOhukDQZ+BZ13bJVUJHW43Guw/D
 iqJHaow6yHfEEj+kl6PURmqZ/Sr/IIu4eHffVXuw4+uzpyyEnnJ70tyn1gPEqLWOUSah
 cn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702284689; x=1702889489;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/pzIZ3BohsXqpWfmB+fQTt0imLSwJ89JKWtIquebsc=;
 b=J2dGvfj+KuwqcyZAd/vCg8OVHJ/XD3Bz0m7ktWwMudxsCk/bpXZD6gzj8ADYkfB/hx
 w9JKf9+hzuVSHL4ONj19E00FiJ6A2e1/LXJmOMh/EYGxZfHhYqgAQ2NArVnwjwlozm1H
 kaM1VMNqt9R9lDI+Gbts2CZzqblvsTQZqrfcoHb5HXGGGqrim69VOI6PPFo3vxfqTKZ/
 niMgEyayF4S/oAYpEwLuBOjePVieqYvVD19wx8bRNboVJbIbzQFHRvV6Cmt9eIEjfSnq
 +9qK4AO8b76mcYU3m+XpBF8wufRE0v6ArAUSUaLncSyiFCZ0jKeBXFYI1CUVu8Do/+OL
 uKjg==
X-Gm-Message-State: AOJu0YxIr2Z+7GSh6dvLBFzjpbcwLccCYpYoBFl5ZeZhzRrdH0B3BFC9
 eV/bLcHK2fKxYYc2q6tS8dqsXDe22TMRkM/f7BsHYw==
X-Google-Smtp-Source: AGHT+IF6fTpDLcWd1+qyZ/gzgM6+pgczWV1PKDevIEsYywRG+pqVHOSbXUWF/Oq9pjNByKxbGBi1sg==
X-Received: by 2002:a17:90b:3d8:b0:286:c138:c2a5 with SMTP id
 go24-20020a17090b03d800b00286c138c2a5mr1509903pjb.17.1702284689264; 
 Mon, 11 Dec 2023 00:51:29 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 sr6-20020a17090b4e8600b00286d44e0c59sm6445785pjb.36.2023.12.11.00.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 00:51:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 11 Dec 2023 17:51:20 +0900
Subject: [PATCH] ui/vnc: Respect bound console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-vnc-v1-1-a3551d284809@daynix.com>
X-B4-Tracking: v=1; b=H4sIAIfNdmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0ND3bK8ZN00yxTzJAMLC4PE5CQloMqCotS0zAqwKdGxtbUAAswC3VU
 AAAA=
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ui/vnc may have a bound console so pass it to qemu_console_is_graphic()
and qemu_text_console_put_keysym().

Fixes: 1d0d59fe2919 ("vnc: allow binding servers to qemu consoles")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/vnc.c | 59 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 4f23a0fa79..ddab42346f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1931,7 +1931,8 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
     }
 
     qkbd_state_key_event(vs->vd->kbd, qcode, down);
-    if (!qemu_console_is_graphic(NULL)) {
+    if (!qemu_console_is_graphic(vs->vd->dcl.con)) {
+        QemuTextConsole *con = QEMU_TEXT_CONSOLE(vs->vd->dcl.con);
         bool numlock = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK);
         bool control = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL);
         /* QEMU console emulation */
@@ -1945,88 +1946,88 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
             case 0xb8:                          /* Right ALT */
                 break;
             case 0xc8:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_UP);
+                qemu_text_console_put_keysym(con, QEMU_KEY_UP);
                 break;
             case 0xd0:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_DOWN);
+                qemu_text_console_put_keysym(con, QEMU_KEY_DOWN);
                 break;
             case 0xcb:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_LEFT);
+                qemu_text_console_put_keysym(con, QEMU_KEY_LEFT);
                 break;
             case 0xcd:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_RIGHT);
+                qemu_text_console_put_keysym(con, QEMU_KEY_RIGHT);
                 break;
             case 0xd3:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_DELETE);
+                qemu_text_console_put_keysym(con, QEMU_KEY_DELETE);
                 break;
             case 0xc7:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_HOME);
+                qemu_text_console_put_keysym(con, QEMU_KEY_HOME);
                 break;
             case 0xcf:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_END);
+                qemu_text_console_put_keysym(con, QEMU_KEY_END);
                 break;
             case 0xc9:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_PAGEUP);
+                qemu_text_console_put_keysym(con, QEMU_KEY_PAGEUP);
                 break;
             case 0xd1:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_PAGEDOWN);
+                qemu_text_console_put_keysym(con, QEMU_KEY_PAGEDOWN);
                 break;
 
             case 0x47:
-                qemu_text_console_put_keysym(NULL, numlock ? '7' : QEMU_KEY_HOME);
+                qemu_text_console_put_keysym(con, numlock ? '7' : QEMU_KEY_HOME);
                 break;
             case 0x48:
-                qemu_text_console_put_keysym(NULL, numlock ? '8' : QEMU_KEY_UP);
+                qemu_text_console_put_keysym(con, numlock ? '8' : QEMU_KEY_UP);
                 break;
             case 0x49:
-                qemu_text_console_put_keysym(NULL, numlock ? '9' : QEMU_KEY_PAGEUP);
+                qemu_text_console_put_keysym(con, numlock ? '9' : QEMU_KEY_PAGEUP);
                 break;
             case 0x4b:
-                qemu_text_console_put_keysym(NULL, numlock ? '4' : QEMU_KEY_LEFT);
+                qemu_text_console_put_keysym(con, numlock ? '4' : QEMU_KEY_LEFT);
                 break;
             case 0x4c:
-                qemu_text_console_put_keysym(NULL, '5');
+                qemu_text_console_put_keysym(con, '5');
                 break;
             case 0x4d:
-                qemu_text_console_put_keysym(NULL, numlock ? '6' : QEMU_KEY_RIGHT);
+                qemu_text_console_put_keysym(con, numlock ? '6' : QEMU_KEY_RIGHT);
                 break;
             case 0x4f:
-                qemu_text_console_put_keysym(NULL, numlock ? '1' : QEMU_KEY_END);
+                qemu_text_console_put_keysym(con, numlock ? '1' : QEMU_KEY_END);
                 break;
             case 0x50:
-                qemu_text_console_put_keysym(NULL, numlock ? '2' : QEMU_KEY_DOWN);
+                qemu_text_console_put_keysym(con, numlock ? '2' : QEMU_KEY_DOWN);
                 break;
             case 0x51:
-                qemu_text_console_put_keysym(NULL, numlock ? '3' : QEMU_KEY_PAGEDOWN);
+                qemu_text_console_put_keysym(con, numlock ? '3' : QEMU_KEY_PAGEDOWN);
                 break;
             case 0x52:
-                qemu_text_console_put_keysym(NULL, '0');
+                qemu_text_console_put_keysym(con, '0');
                 break;
             case 0x53:
-                qemu_text_console_put_keysym(NULL, numlock ? '.' : QEMU_KEY_DELETE);
+                qemu_text_console_put_keysym(con, numlock ? '.' : QEMU_KEY_DELETE);
                 break;
 
             case 0xb5:
-                qemu_text_console_put_keysym(NULL, '/');
+                qemu_text_console_put_keysym(con, '/');
                 break;
             case 0x37:
-                qemu_text_console_put_keysym(NULL, '*');
+                qemu_text_console_put_keysym(con, '*');
                 break;
             case 0x4a:
-                qemu_text_console_put_keysym(NULL, '-');
+                qemu_text_console_put_keysym(con, '-');
                 break;
             case 0x4e:
-                qemu_text_console_put_keysym(NULL, '+');
+                qemu_text_console_put_keysym(con, '+');
                 break;
             case 0x9c:
-                qemu_text_console_put_keysym(NULL, '\n');
+                qemu_text_console_put_keysym(con, '\n');
                 break;
 
             default:
                 if (control) {
-                    qemu_text_console_put_keysym(NULL, sym & 0x1f);
+                    qemu_text_console_put_keysym(con, sym & 0x1f);
                 } else {
-                    qemu_text_console_put_keysym(NULL, sym);
+                    qemu_text_console_put_keysym(con, sym);
                 }
                 break;
             }
@@ -2044,7 +2045,7 @@ static void key_event(VncState *vs, int down, uint32_t sym)
     int keycode;
     int lsym = sym;
 
-    if (lsym >= 'A' && lsym <= 'Z' && qemu_console_is_graphic(NULL)) {
+    if (lsym >= 'A' && lsym <= 'Z' && qemu_console_is_graphic(vs->vd->dcl.con)) {
         lsym = lsym - 'A' + 'a';
     }
 

---
base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
change-id: 20231211-vnc-f9d7b0880acb

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


