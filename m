Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5169B8731
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Nov 2024 00:36:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ehF-0002rX-IM; Thu, 31 Oct 2024 19:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6ehD-0002qj-FG
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 19:35:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6eh6-0004IT-Nx
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 19:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=n6f2/O7DlRyDlg0M6jzWm/1lLESkuEBJWRofCl1Lobk=; b=jiVwkE2gnnpDxSNSQ0GnKcBpt8
 2HtuuFryj4QLWaX2HlWD0t423IjTylUZ44TfrOIrZfZ22z8/dGJG2bcJ5Umgq91mImWxc6Ztz4Z8+
 IWSMWtnHSlNCb8xOQyzNjUHMSlzG6/XT19goDjqfyzgkd16tStC7FvWaA9YK/2smVwpZRrOi4zRWA
 p0mPhB+W3C7PJx+OwcU3HOqVrkJ8mFmsn/faRJcqf6vHdN8XXtuKSrMHznYh7MRD4bgUpJM8L/aXH
 OLCY78i05ZBDHhffpcFwrMZncOYcfya3t+kG76rcfSNH3nHYDDfbKVGxhfRckqOklbZRAlM0lVLwt
 yag3NN2Q/hR+bmOuaqT0oG7T/FqHwja0UwzrmAK3T0ayHtj1OMxufeSqXshv1sesADwD2OOE5mODr
 WHjf8v44nTBsGcvxhIMrrmHvMoqvRHyQk/btePZZi6dl10XdWYiO9z/MVORCP3+fq80fHx+d4o3MP
 P40JJNR+AXz1PQwpp6rOlSQUoN2gwkDipQ3tVoL4wOwnMVnJaCjS8jHWcV9w7nU2jol8zLDf5Pd4m
 27KHGRsYtKy+D3oSw3luXEHb7J/GpK2oMf09X9wOPEuA9lmgGGj37FEJGEaGFNdsdy6fvabM0j0zM
 rWfSXihwCrXzy8xFhSuEndNO4CBm6DOXA26h7NvDw=;
Received: from [2a00:23c4:8bb8:f600:57e5:6c14:c98a:3cb9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6egj-0008Ee-5P; Thu, 31 Oct 2024 23:34:53 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 31 Oct 2024 23:34:51 +0000
Message-Id: <20241031233452.1388728-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031233452.1388728-1-mark.cave-ayland@ilande.co.uk>
References: <20241031233452.1388728-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:57e5:6c14:c98a:3cb9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 1/2] next-kbd: convert to use qemu_input_handler_register()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
function to use qemu_input_handler_register().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-kbd.c | 158 +++++++++++++++++++++++++++++----------------
 1 file changed, 103 insertions(+), 55 deletions(-)

diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index bc67810f31..85ef784491 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -68,7 +68,6 @@ struct NextKBDState {
     uint16_t shift;
 };
 
-static void queue_code(void *opaque, int code);
 
 /* lots of magic numbers here */
 static uint32_t kbd_read_byte(void *opaque, hwaddr addr)
@@ -166,68 +165,79 @@ static const MemoryRegionOps kbd_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void nextkbd_event(void *opaque, int ch)
-{
-    /*
-     * Will want to set vars for caps/num lock
-     * if (ch & 0x80) -> key release
-     * there's also e0 escaped scancodes that might need to be handled
-     */
-    queue_code(opaque, ch);
-}
-
-static const unsigned char next_keycodes[128] = {
-    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
-    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
-    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
-    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
-    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
-    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
-    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
-    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+#define NEXTKDB_NO_KEY 0xff
+
+static const int qcode_to_nextkbd_keycode[] = {
+    /* Make sure future additions are automatically set to NEXTKDB_NO_KEY */
+    [0 ... 0xff]               = NEXTKDB_NO_KEY,
+
+    [Q_KEY_CODE_ESC]           = 0x49,
+    [Q_KEY_CODE_1]             = 0x4a,
+    [Q_KEY_CODE_2]             = 0x4b,
+    [Q_KEY_CODE_3]             = 0x4c,
+    [Q_KEY_CODE_4]             = 0x4d,
+    [Q_KEY_CODE_5]             = 0x50,
+    [Q_KEY_CODE_6]             = 0x4f,
+    [Q_KEY_CODE_7]             = 0x4e,
+    [Q_KEY_CODE_8]             = 0x1e,
+    [Q_KEY_CODE_9]             = 0x1f,
+    [Q_KEY_CODE_0]             = 0x20,
+    [Q_KEY_CODE_MINUS]         = 0x1d,
+    [Q_KEY_CODE_EQUAL]         = 0x1c,
+    [Q_KEY_CODE_BACKSPACE]     = 0x1b,
+    [Q_KEY_CODE_TAB]           = 0x00,
+
+    [Q_KEY_CODE_Q]             = 0x42,
+    [Q_KEY_CODE_W]             = 0x43,
+    [Q_KEY_CODE_E]             = 0x44,
+    [Q_KEY_CODE_R]             = 0x45,
+    [Q_KEY_CODE_T]             = 0x48,
+    [Q_KEY_CODE_Y]             = 0x47,
+    [Q_KEY_CODE_U]             = 0x46,
+    [Q_KEY_CODE_I]             = 0x06,
+    [Q_KEY_CODE_O]             = 0x07,
+    [Q_KEY_CODE_P]             = 0x08,
+    [Q_KEY_CODE_RET]           = 0x2a,
+    [Q_KEY_CODE_A]             = 0x39,
+    [Q_KEY_CODE_S]             = 0x3a,
+
+    [Q_KEY_CODE_D]             = 0x3b,
+    [Q_KEY_CODE_F]             = 0x3c,
+    [Q_KEY_CODE_G]             = 0x3d,
+    [Q_KEY_CODE_H]             = 0x40,
+    [Q_KEY_CODE_J]             = 0x3f,
+    [Q_KEY_CODE_K]             = 0x3e,
+    [Q_KEY_CODE_L]             = 0x2d,
+    [Q_KEY_CODE_SEMICOLON]     = 0x2c,
+    [Q_KEY_CODE_APOSTROPHE]    = 0x2b,
+    [Q_KEY_CODE_GRAVE_ACCENT]  = 0x26,
+    [Q_KEY_CODE_SHIFT]         = 0x00,
+    [Q_KEY_CODE_BACKSLASH]     = 0x00,
+    [Q_KEY_CODE_Z]             = 0x31,
+    [Q_KEY_CODE_X]             = 0x32,
+    [Q_KEY_CODE_C]             = 0x33,
+    [Q_KEY_CODE_V]             = 0x34,
+
+    [Q_KEY_CODE_B]             = 0x35,
+    [Q_KEY_CODE_N]             = 0x37,
+    [Q_KEY_CODE_M]             = 0x36,
+    [Q_KEY_CODE_COMMA]         = 0x2e,
+    [Q_KEY_CODE_DOT]           = 0x2f,
+    [Q_KEY_CODE_SLASH]         = 0x30,
+    [Q_KEY_CODE_SHIFT_R]       = 0x00,
+
+    [Q_KEY_CODE_SPC]           = 0x38,
 };
 
-static void queue_code(void *opaque, int code)
+static void nextkbd_put_keycode(NextKBDState *s, int keycode)
 {
-    NextKBDState *s = NEXTKBD(opaque);
     KBDQueue *q = &s->queue;
-    int key = code & KD_KEYMASK;
-    int release = code & 0x80;
-    static int ext;
-
-    if (code == 0xE0) {
-        ext = 1;
-    }
-
-    if (code == 0x2A || code == 0x1D || code == 0x36) {
-        if (code == 0x2A) {
-            s->shift = KD_LSHIFT;
-        } else if (code == 0x36) {
-            s->shift = KD_RSHIFT;
-            ext = 0;
-        } else if (code == 0x1D && !ext) {
-            s->shift = KD_LCOMM;
-        } else if (code == 0x1D && ext) {
-            ext = 0;
-            s->shift = KD_RCOMM;
-        }
-        return;
-    } else if (code == (0x2A | 0x80) || code == (0x1D | 0x80) ||
-               code == (0x36 | 0x80)) {
-        s->shift = 0;
-        return;
-    }
 
     if (q->count >= KBD_QUEUE_SIZE) {
         return;
     }
 
-    q->data[q->wptr] = next_keycodes[key] | release;
-
+    q->data[q->wptr] = keycode;
     if (++q->wptr == KBD_QUEUE_SIZE) {
         q->wptr = 0;
     }
@@ -241,6 +251,44 @@ static void queue_code(void *opaque, int code)
     /* s->update_irq(s->update_arg, 1); */
 }
 
+static void nextkbd_event(DeviceState *dev, QemuConsole *src, InputEvent *evt)
+{
+    NextKBDState *s = NEXTKBD(dev);
+    int qcode, keycode;
+    bool key_down = evt->u.key.data->down;
+
+    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
+    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
+        return;
+    }
+
+    keycode = qcode_to_nextkbd_keycode[qcode];
+    if (keycode == NEXTKDB_NO_KEY) {
+        return;
+    }
+
+    if (qcode == Q_KEY_CODE_SHIFT) {
+        s->shift = key_down ? KD_LSHIFT : 0;
+    }
+
+    if (qcode == Q_KEY_CODE_SHIFT_R) {
+        s->shift = key_down ? KD_RSHIFT : 0;
+    }
+
+    /* If key release event, create keyboard break code */
+    if (!key_down) {
+        keycode = keycode | 0x80;
+    }
+
+    nextkbd_put_keycode(s, keycode);
+}
+
+static const QemuInputHandler nextkbd_handler = {
+    .name  = "QEMU NeXT Keyboard",
+    .mask  = INPUT_EVENT_MASK_KEY,
+    .event = nextkbd_event,
+};
+
 static void nextkbd_reset(DeviceState *dev)
 {
     NextKBDState *nks = NEXTKBD(dev);
@@ -256,7 +304,7 @@ static void nextkbd_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->mr, OBJECT(dev), &kbd_ops, s, "next.kbd", 0x1000);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
 
-    qemu_add_kbd_event_handler(nextkbd_event, s);
+    qemu_input_handler_register(dev, &nextkbd_handler);
 }
 
 static const VMStateDescription nextkbd_vmstate = {
-- 
2.39.5


