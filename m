Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD18201A8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:27:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKM1-00015V-Jk; Fri, 29 Dec 2023 16:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLy-0000td-On
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:14 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLw-0007eO-9m
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:14 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9b13fe9e9so3722769b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885110; x=1704489910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qgkuS+i2FIBjbyaVYxu+JMHtGHEswSdNhRbEwEalApI=;
 b=RandzgvRkvovy/27gKG+CMPiYr2zfj7kkryCXTsU7aOhL+mXnNhHA8VwlndiI7uM7X
 1LQPiOl3bpc7DWoK903nhgFcejTrlQpuh5zD6lw9cU7VkryVy9ueqwWgYoVJsgK+H1L/
 dRNpwaAhb4rcv53K/j/xMrOlXxZCZJ0UGaEQQJSY4dCDeakRQY7sgJiIZMRZHrxqEuSu
 jaZVyXuo8Ez4j1wSLUak4XSVV538roJWdmw/n7HES2Y8zenC2urrX0ldJyJMrcJ2cwCm
 U/p//t9Bf41642ZkIraf1JAKgQo0QoAeWxBQNZxO2H1SMmBpGvYUW/D6sMcprbvI81AT
 rABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885110; x=1704489910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgkuS+i2FIBjbyaVYxu+JMHtGHEswSdNhRbEwEalApI=;
 b=scnv4zptnCJWeqS7D+2YfbBQCCSzyp8S4mey7+g6QSZCSen1ERcINtUadoUZ7mOiDs
 FPY5dGOMetbf7YI9ZlToEm+vpLeRRxaXJLyQjhS8cK2gkCS2xWj7QMXbjpgUr3kiFnD8
 J9n3yiXrTQ1zYAewLDk2W9mukxnp1xIhREYCKPMTiGgvaC2IEpgAlW25tbtBlPW3FlBp
 6UAaAWWnLSknmZF+5Z7eYDC7TiakkhAPDKlsXJ0ai5IzP4MGf/TJH0G+ifgl1XX7zLKH
 9fxI4/HQ4L6+q2ZUclJcoatsxBX8M+4uK/F5RTXHks5g+/pp+rDlArHGWfjFhbhCKVhI
 yWkA==
X-Gm-Message-State: AOJu0YxVfQp1Hc+v2QqYGCa8y1RRlqqJZqpboSRAy4K2c6MjJP+IR1U1
 luwOUOBQIlldJT2YROGTR4umaLQGpYQbamoMnsjrARAd1s8ALQ==
X-Google-Smtp-Source: AGHT+IG47X88dpIqLK0H0oyg7JPdny1vU4B2ruDETUHXVg+Ae7lstsYVx81S2a7pJPABn5OZqToj6Q==
X-Received: by 2002:a05:6a20:3d06:b0:196:5283:39a7 with SMTP id
 y6-20020a056a203d0600b00196528339a7mr3523490pzi.75.1703885110239; 
 Fri, 29 Dec 2023 13:25:10 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.25.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:25:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/71] hw/input: Constify VMState
Date: Sat, 30 Dec 2023 08:23:08 +1100
Message-Id: <20231229212346.147149-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-34-richard.henderson@linaro.org>
---
 hw/input/adb-kbd.c           |  2 +-
 hw/input/adb-mouse.c         |  2 +-
 hw/input/adb.c               |  4 ++--
 hw/input/ads7846.c           |  2 +-
 hw/input/hid.c               |  6 +++---
 hw/input/lasips2.c           |  4 ++--
 hw/input/lm832x.c            |  2 +-
 hw/input/pckbd.c             | 12 ++++++------
 hw/input/pl050.c             |  2 +-
 hw/input/ps2.c               | 14 +++++++-------
 hw/input/pxa2xx_keypad.c     |  2 +-
 hw/input/stellaris_gamepad.c |  2 +-
 hw/input/tsc2005.c           |  2 +-
 hw/input/tsc210x.c           |  2 +-
 hw/input/virtio-input.c      |  2 +-
 15 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index e21edf9acd..758fa6d267 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -332,7 +332,7 @@ static const VMStateDescription vmstate_adb_kbd = {
     .name = "adb_kbd",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, KBDState, 0, vmstate_adb_device, ADBDevice),
         VMSTATE_BUFFER(data, KBDState),
         VMSTATE_INT32(rptr, KBDState),
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index e6b341f028..144a0ccce7 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -217,7 +217,7 @@ static const VMStateDescription vmstate_adb_mouse = {
     .name = "adb_mouse",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, MouseState, 0, vmstate_adb_device,
                        ADBDevice),
         VMSTATE_INT32(buttons_state, MouseState),
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 8aed0da2cd..0f3c73d6d0 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -221,7 +221,7 @@ static const VMStateDescription vmstate_adb_bus = {
     .name = "adb_bus",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(autopoll_timer, ADBBusState),
         VMSTATE_BOOL(autopoll_enabled, ADBBusState),
         VMSTATE_UINT8(autopoll_rate_ms, ADBBusState),
@@ -279,7 +279,7 @@ const VMStateDescription vmstate_adb_device = {
     .name = "adb_device",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(devaddr, ADBDevice),
         VMSTATE_INT32(handler, ADBDevice),
         VMSTATE_END_OF_LIST()
diff --git a/hw/input/ads7846.c b/hw/input/ads7846.c
index 91116c6bdb..cde3892216 100644
--- a/hw/input/ads7846.c
+++ b/hw/input/ads7846.c
@@ -130,7 +130,7 @@ static const VMStateDescription vmstate_ads7846 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ads7856_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SSI_PERIPHERAL(ssidev, ADS7846State),
         VMSTATE_INT32_ARRAY(input, ADS7846State, 8),
         VMSTATE_INT32(noise, ADS7846State),
diff --git a/hw/input/hid.c b/hw/input/hid.c
index b8e85374ca..76bedc1844 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -581,7 +581,7 @@ static const VMStateDescription vmstate_hid_ptr_queue = {
     .name = "HIDPointerEventQueue",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(xdx, HIDPointerEvent),
         VMSTATE_INT32(ydy, HIDPointerEvent),
         VMSTATE_INT32(dz, HIDPointerEvent),
@@ -595,7 +595,7 @@ const VMStateDescription vmstate_hid_ptr_device = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = hid_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(ptr.queue, HIDState, QUEUE_LENGTH, 0,
                              vmstate_hid_ptr_queue, HIDPointerEvent),
         VMSTATE_UINT32(head, HIDState),
@@ -611,7 +611,7 @@ const VMStateDescription vmstate_hid_keyboard_device = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = hid_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(kbd.keycodes, HIDState, QUEUE_LENGTH),
         VMSTATE_UINT32(head, HIDState),
         VMSTATE_UINT32(n, HIDState),
diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index 6075121b72..d9f8c36778 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -39,7 +39,7 @@ static const VMStateDescription vmstate_lasips2_port = {
     .name = "lasips2-port",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(control, LASIPS2Port),
         VMSTATE_UINT8(buf, LASIPS2Port),
         VMSTATE_BOOL(loopback_rbne, LASIPS2Port),
@@ -51,7 +51,7 @@ static const VMStateDescription vmstate_lasips2 = {
     .name = "lasips2",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(int_status, LASIPS2State),
         VMSTATE_STRUCT(kbd_port.parent_obj, LASIPS2State, 1,
                        vmstate_lasips2_port, LASIPS2Port),
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index 19a646d9bb..59e5567afd 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -441,7 +441,7 @@ static const VMStateDescription vmstate_lm_kbd = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = lm_kbd_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_I2C_SLAVE(parent_obj, LM823KbdState),
         VMSTATE_UINT8(i2c_dir, LM823KbdState),
         VMSTATE_UINT8(i2c_cycle, LM823KbdState),
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index b92b63bedc..90a4d9eb40 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -510,7 +510,7 @@ static const VMStateDescription vmstate_kbd_outport = {
     .minimum_version_id = 1,
     .post_load = kbd_outport_post_load,
     .needed = kbd_outport_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(outport, KBDState),
         VMSTATE_END_OF_LIST()
     }
@@ -552,7 +552,7 @@ static const VMStateDescription vmstate_kbd_extended_state = {
     .post_load = kbd_extended_state_post_load,
     .pre_save = kbd_extended_state_pre_save,
     .needed = kbd_extended_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(migration_flags, KBDState),
         VMSTATE_UINT32(obsrc, KBDState),
         VMSTATE_UINT8(obdata, KBDState),
@@ -619,14 +619,14 @@ static const VMStateDescription vmstate_kbd = {
     .pre_load = kbd_pre_load,
     .post_load = kbd_post_load,
     .pre_save = kbd_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(write_cmd, KBDState),
         VMSTATE_UINT8(status, KBDState),
         VMSTATE_UINT8(mode, KBDState),
         VMSTATE_UINT8(pending_tmp, KBDState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_kbd_outport,
         &vmstate_kbd_extended_state,
         NULL
@@ -745,7 +745,7 @@ static const VMStateDescription vmstate_kbd_mmio = {
     .name = "pckbd-mmio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(kbd, MMIOKBDState, 0, vmstate_kbd, KBDState),
         VMSTATE_END_OF_LIST()
     }
@@ -786,7 +786,7 @@ static const VMStateDescription vmstate_kbd_isa = {
     .name = "pckbd",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(kbd, ISAKBDState, 0, vmstate_kbd, KBDState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index ec5e19285e..6519e260ed 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -30,7 +30,7 @@ static const VMStateDescription vmstate_pl050 = {
     .name = "pl050",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cr, PL050State),
         VMSTATE_UINT32(clk, PL050State),
         VMSTATE_UINT32(last, PL050State),
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index c8fd23cf36..00b695a0b9 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1093,7 +1093,7 @@ static const VMStateDescription vmstate_ps2_common = {
     .name = "PS2 Common State",
     .version_id = 3,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(write_cmd, PS2State),
         VMSTATE_INT32(queue.rptr, PS2State),
         VMSTATE_INT32(queue.wptr, PS2State),
@@ -1124,7 +1124,7 @@ static const VMStateDescription vmstate_ps2_keyboard_ledstate = {
     .minimum_version_id = 2,
     .post_load = ps2_kbd_ledstate_post_load,
     .needed = ps2_keyboard_ledstate_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(ledstate, PS2KbdState),
         VMSTATE_END_OF_LIST()
     }
@@ -1141,7 +1141,7 @@ static const VMStateDescription vmstate_ps2_keyboard_need_high_bit = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ps2_keyboard_need_high_bit_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(need_high_bit, PS2KbdState),
         VMSTATE_END_OF_LIST()
     }
@@ -1158,7 +1158,7 @@ static bool ps2_keyboard_cqueue_needed(void *opaque)
 static const VMStateDescription vmstate_ps2_keyboard_cqueue = {
     .name = "ps2kbd/command_reply_queue",
     .needed = ps2_keyboard_cqueue_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(parent_obj.queue.cwptr, PS2KbdState),
         VMSTATE_END_OF_LIST()
     }
@@ -1183,7 +1183,7 @@ static const VMStateDescription vmstate_ps2_keyboard = {
     .version_id = 3,
     .minimum_version_id = 2,
     .post_load = ps2_kbd_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, PS2KbdState, 0, vmstate_ps2_common,
                        PS2State),
         VMSTATE_INT32(scan_enabled, PS2KbdState),
@@ -1191,7 +1191,7 @@ static const VMStateDescription vmstate_ps2_keyboard = {
         VMSTATE_INT32_V(scancode_set, PS2KbdState, 3),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_ps2_keyboard_ledstate,
         &vmstate_ps2_keyboard_need_high_bit,
         &vmstate_ps2_keyboard_cqueue,
@@ -1214,7 +1214,7 @@ static const VMStateDescription vmstate_ps2_mouse = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = ps2_mouse_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, PS2MouseState, 0, vmstate_ps2_common,
                        PS2State),
         VMSTATE_UINT8(mouse_status, PS2MouseState),
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 3dd03e8c9f..3858648d9f 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -288,7 +288,7 @@ static const VMStateDescription vmstate_pxa2xx_keypad = {
     .name = "pxa2xx_keypad",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(kpc, PXA2xxKeyPadState),
         VMSTATE_UINT32(kpdk, PXA2xxKeyPadState),
         VMSTATE_UINT32(kprec, PXA2xxKeyPadState),
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 9dfa620e29..17ee42b9fc 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -35,7 +35,7 @@ static const VMStateDescription vmstate_stellaris_gamepad = {
     .name = "stellaris_gamepad",
     .version_id = 4,
     .minimum_version_id = 4,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VARRAY_UINT32(pressed, StellarisGamepad, num_buttons,
                               0, vmstate_info_uint8, uint8_t),
         VMSTATE_END_OF_LIST()
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index db2b80e35f..941f163d36 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -454,7 +454,7 @@ static const VMStateDescription vmstate_tsc2005 = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = tsc2005_post_load,
-    .fields      = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_BOOL(pressure, TSC2005State),
         VMSTATE_BOOL(irq, TSC2005State),
         VMSTATE_BOOL(command, TSC2005State),
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 950506fb38..c4e32c7a42 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -1017,7 +1017,7 @@ static int tsc210x_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static VMStateField vmstatefields_tsc210x[] = {
+static const VMStateField vmstatefields_tsc210x[] = {
     VMSTATE_BOOL(enabled, TSC210xState),
     VMSTATE_BOOL(host_mode, TSC210xState),
     VMSTATE_BOOL(irq, TSC210xState),
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 5b5398b3ca..3bcdae41b2 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -293,7 +293,7 @@ static const VMStateDescription vmstate_virtio_input = {
     .name = "virtio-input",
     .minimum_version_id = VIRTIO_INPUT_VM_VERSION,
     .version_id = VIRTIO_INPUT_VM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


