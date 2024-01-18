Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39810831359
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQN9C-00077y-At; Thu, 18 Jan 2024 02:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rQN9A-00077h-HD; Thu, 18 Jan 2024 02:49:08 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rQN98-0005bo-74; Thu, 18 Jan 2024 02:49:08 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d5dfda4319so21821935ad.0; 
 Wed, 17 Jan 2024 23:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705564144; x=1706168944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mfh4veqbaX/t17E8a5QVpXbU74gFm2H55VSmHu7JOGw=;
 b=JAczx3XjGacNLxyopl7zg7Qe3tfPBM/H2V7xf9QaIg1EWopiueEb1HdKSX5zdGjbNc
 m4WR2iPSRFJF2VQuYLEloS2bmx5MV2EKm2WfYJI8e0YWx53A71K3In47/DChwdPJwPdb
 TmOE+YHtjN3gfF/BdtQaI4F1gvBzWdb3zGw53OJpGX//O3JJau79NS7feDuyZNXWFdLR
 vO8phIX/WNdjdaTlLVu3JyHmz5m4KA+X1CoT7DS58peX9RiJnEhtjnrWSrIfdvV9YoWk
 BF+sY2cVgOqCCS6lQvuIoEHc58kUG4Xl86biEq3dR4hJPqeuVkhLXoypTRsJ7PMUJwIY
 zSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705564144; x=1706168944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mfh4veqbaX/t17E8a5QVpXbU74gFm2H55VSmHu7JOGw=;
 b=HG+i5VXAzB1YC1gGqOues5t39gTwUo6YZtV5LSEFL1kCGX/e7eg5t5EDuvfmm2FPfU
 ZvtegxKWFJutvTQE8Wi0oYs8EFxWDcJglrV2Yl730DJff6ZwB3c3iPGU2h2j39wR7KbD
 VgpnGuXF4WF/pK+xTNf7P19neglUsQ1wbyeET0Lx9W8nUGe8e6XDlCPjx/MJUGgvyYyI
 M0Iw6GD5xba91LCcaxPxD2C94IxGsVBbhB/5MNvOvzseRQmnRapZv9UY83gnA7KMVo5V
 XSuYJ/cbdtPkusaYtVAOS+/3eJrrFrbLQnMGfxJU15eXfUoBohHqf3GXi/Icxg/wuaXM
 J2wA==
X-Gm-Message-State: AOJu0YxG9pC8C8b+BX3nijsr0OEd+4HqjeaoI9oiBivMlmvVldYs6iyp
 3iX12qba/Y12G3NWGRn/ssAv7MvUS63JWyXZjL+gmHS2MTTI2DONavX/QVFP1vOtmA==
X-Google-Smtp-Source: AGHT+IFxazeN1XRMKZbDocVfLsBOF4qBu3YtSBUAkYPcO4JrbGXUd5mBQR5/ZA4vgwqqbjgst2w80w==
X-Received: by 2002:a17:902:7888:b0:1d6:ee79:c1f with SMTP id
 q8-20020a170902788800b001d6ee790c1fmr434890pll.89.1705564144105; 
 Wed, 17 Jan 2024 23:49:04 -0800 (PST)
Received: from localhost.localdomain ([49.37.224.90])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a170902b94a00b001d4c6a9ca2dsm783007pls.208.2024.01.17.23.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 23:49:03 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rayhan Faizel <rayhan.faizel@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH v3] hw/char/imx_serial: Implement receive FIFO and ageing
 timer for imx serial.
Date: Thu, 18 Jan 2024 13:17:51 +0530
Message-Id: <20240118074749.2299959-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch implements a 32 half word FIFO as per imx serial device
specifications. If a non empty FIFO is below the trigger level, an ageing
timer will tick for a duration of 8 characters. On expiry, AGTIM will be set
triggering an interrupt. AGTIM timer resets when there is activity in
the receive FIFO.

Otherwise, RRDY is set when trigger level is
exceeded. The receive trigger level is 8 in newer kernel versions and 1 in
older ones.

This change will break migration compatibility.

[Changes in v3]

- Caught more whitespace changes that went overlooked
- Moved fifo and timer initialization to realize

[Changes in v2]

As per Peter Maydell's suggestions,

- Use generic FIFO32 implementation in place of handmade impl.
- Moved timer_init to serial init and use timer_del in reset
- Removed stray whitespaces
- Increment VMSTATE version

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/char/imx_serial.c         | 97 +++++++++++++++++++++++++++++++-----
 include/hw/char/imx_serial.h | 18 ++++++-
 2 files changed, 102 insertions(+), 13 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1df862eb7f..893e84ccf6 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -26,6 +26,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/fifo32.h"
 
 #ifndef DEBUG_IMX_UART
 #define DEBUG_IMX_UART 0
@@ -41,10 +42,11 @@
 
 static const VMStateDescription vmstate_imx_serial = {
     .name = TYPE_IMX_SERIAL,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32(readbuff, IMXSerialState),
+        VMSTATE_FIFO32(rx_fifo, IMXSerialState),
+        VMSTATE_TIMER(ageing_timer, IMXSerialState),
         VMSTATE_UINT32(usr1, IMXSerialState),
         VMSTATE_UINT32(usr2, IMXSerialState),
         VMSTATE_UINT32(ucr1, IMXSerialState),
@@ -71,6 +73,10 @@ static void imx_update(IMXSerialState *s)
      * following:
      */
     usr1 = s->usr1 & s->ucr1 & (USR1_TRDY | USR1_RRDY);
+    /*
+     * Interrupt if AGTIM is set (ageing timer interrupt in RxFIFO)
+     */
+    usr1 |= (s->ucr2 & UCR2_ATEN) ? (s->usr1 & USR1_AGTIM) : 0;
     /*
      * Bits that we want in USR2 are not as conveniently laid out,
      * unfortunately.
@@ -87,6 +93,53 @@ static void imx_update(IMXSerialState *s)
     qemu_set_irq(s->irq, usr1 || usr2);
 }
 
+static void imx_serial_rx_fifo_push(IMXSerialState *s, uint32_t value)
+{
+    if (fifo32_is_full(&s->rx_fifo)) {
+        /* Discard lost character on overflow */
+        fifo32_pop(&s->rx_fifo);
+    }
+    fifo32_push(&s->rx_fifo, value);
+}
+
+static uint32_t imx_serial_rx_fifo_pop(IMXSerialState *s)
+{
+    if (fifo32_is_empty(&s->rx_fifo)) {
+        return URXD_ERR;
+    }
+    return fifo32_pop(&s->rx_fifo);
+}
+
+static void imx_serial_rx_fifo_ageing_timer_int(void *opaque)
+{
+    IMXSerialState *s = (IMXSerialState *) opaque;
+    s->usr1 |= USR1_AGTIM;
+
+    imx_update(s);
+}
+
+static void imx_serial_rx_fifo_ageing_timer_restart(void *opaque)
+{
+    /*
+     * Ageing timer starts ticking when
+     * RX FIFO is non empty and below trigger level.
+     * Timer is reset if new character is received or
+     * a FIFO read occurs.
+     * Timer triggers an interrupt when duration of
+     * 8 characters has passed ( assuming 115200 baudrate ).
+     */
+    IMXSerialState *s = (IMXSerialState *) opaque;
+    uint8_t rxtl = s->ufcr & TL_MASK;
+    int rx_used = fifo32_num_used(&s->rx_fifo);
+
+    if (rx_used > 0 && rx_used < rxtl) {
+        timer_mod_ns(&s->ageing_timer,
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + AGE_DURATION_NS);
+    } else {
+        timer_del(&s->ageing_timer);
+    }
+}
+
 static void imx_serial_reset(IMXSerialState *s)
 {
 
@@ -102,7 +155,9 @@ static void imx_serial_reset(IMXSerialState *s)
     s->ucr3 = 0x700;
     s->ubmr = 0;
     s->ubrc = 4;
-    s->readbuff = URXD_ERR;
+
+    fifo32_reset(&s->rx_fifo);
+    timer_del(&s->ageing_timer);
 }
 
 static void imx_serial_reset_at_boot(DeviceState *dev)
@@ -125,20 +180,28 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
                                 unsigned size)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    uint32_t c;
+    uint32_t c, rx_used;
+    uint8_t rxtl = s->ufcr & TL_MASK;
 
     DPRINTF("read(offset=0x%" HWADDR_PRIx ")\n", offset);
 
     switch (offset >> 2) {
     case 0x0: /* URXD */
-        c = s->readbuff;
+        c = imx_serial_rx_fifo_pop(s);
         if (!(s->uts1 & UTS1_RXEMPTY)) {
             /* Character is valid */
             c |= URXD_CHARRDY;
-            s->usr1 &= ~USR1_RRDY;
-            s->usr2 &= ~USR2_RDR;
-            s->uts1 |= UTS1_RXEMPTY;
+            rx_used = fifo32_num_used(&s->rx_fifo);
+            /* Clear RRDY if below threshold */
+            if (rx_used < rxtl) {
+                s->usr1 &= ~USR1_RRDY;
+            }
+            if (rx_used == 0) {
+                s->usr2 &= ~USR2_RDR;
+                s->uts1 |= UTS1_RXEMPTY;
+            }
             imx_update(s);
+            imx_serial_rx_fifo_ageing_timer_restart(s);
             qemu_chr_fe_accept_input(&s->chr);
         }
         return c;
@@ -300,19 +363,25 @@ static void imx_serial_write(void *opaque, hwaddr offset,
 static int imx_can_receive(void *opaque)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    return !(s->usr1 & USR1_RRDY);
+    return s->ucr1 & UCR1_RRDYEN &&
+        s->ucr2 & UCR2_RXEN && fifo32_num_used(&s->rx_fifo) < FIFO_SIZE;
 }
 
 static void imx_put_data(void *opaque, uint32_t value)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
+    uint8_t rxtl = s->ufcr & TL_MASK;
 
     DPRINTF("received char\n");
+    imx_serial_rx_fifo_push(s, value);
+    if (fifo32_num_used(&s->rx_fifo) >= rxtl) {
+        s->usr1 |= USR1_RRDY;
+    }
+
+    imx_serial_rx_fifo_ageing_timer_restart(s);
 
-    s->usr1 |= USR1_RRDY;
     s->usr2 |= USR2_RDR;
     s->uts1 &= ~UTS1_RXEMPTY;
-    s->readbuff = value;
     if (value & URXD_BRK) {
         s->usr2 |= USR2_BRCD;
     }
@@ -345,6 +414,10 @@ static void imx_serial_realize(DeviceState *dev, Error **errp)
 {
     IMXSerialState *s = IMX_SERIAL(dev);
 
+    fifo32_create(&s->rx_fifo, FIFO_SIZE);
+    timer_init_ns(&s->ageing_timer, QEMU_CLOCK_VIRTUAL,
+        imx_serial_rx_fifo_ageing_timer_int, s);
+
     DPRINTF("char dev for uart: %p\n", qemu_chr_fe_get_driver(&s->chr));
 
     qemu_chr_fe_set_handlers(&s->chr, imx_can_receive, imx_receive,
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index b823f94519..b5f714add1 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -21,10 +21,13 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
+#include "qemu/fifo32.h"
 
 #define TYPE_IMX_SERIAL "imx.serial"
 OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 
+#define FIFO_SIZE       32
+
 #define URXD_CHARRDY    (1<<15)   /* character read is valid */
 #define URXD_ERR        (1<<14)   /* Character has error */
 #define URXD_FRMERR     (1<<12)   /* Character has frame error */
@@ -65,6 +68,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 #define UCR1_TXMPTYEN   (1<<6)    /* Tx Empty Interrupt Enable */
 #define UCR1_UARTEN     (1<<0)    /* UART Enable */
 
+#define UCR2_ATEN       BIT(3)    /* Ageing Timer Enable */
 #define UCR2_TXEN       (1<<2)    /* Transmitter enable */
 #define UCR2_RXEN       (1<<1)    /* Receiver enable */
 #define UCR2_SRST       (1<<0)    /* Reset complete */
@@ -78,13 +82,25 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 #define UTS1_TXFULL     (1<<4)
 #define UTS1_RXFULL     (1<<3)
 
+#define TL_MASK         0x3f
+
+ /* Bit time in nanoseconds assuming maximum baud rate of 115200 */
+#define BIT_TIME_NS     8681
+
+/* Assume 8 bits per character */
+#define NUM_BITS        8
+
+/* Ageing timer triggers after 8 characters */
+#define AGE_DURATION_NS (8 * NUM_BITS * BIT_TIME_NS)
+
 struct IMXSerialState {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
     MemoryRegion iomem;
-    int32_t readbuff;
+    QEMUTimer ageing_timer;
+    Fifo32 rx_fifo;
 
     uint32_t usr1;
     uint32_t usr2;
-- 
2.34.1


