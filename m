Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E782AFC1
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 14:34:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvC7-0005vw-JJ; Thu, 11 Jan 2024 08:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rNvC4-0005vV-VQ; Thu, 11 Jan 2024 08:34:01 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rNvC2-0003iu-Lu; Thu, 11 Jan 2024 08:34:00 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d4a2526a7eso30943395ad.3; 
 Thu, 11 Jan 2024 05:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704980036; x=1705584836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0WSZ5xNE3MipExZS0UbFPPpcyxTj+Sy/E4k9/1ukW8=;
 b=Q1keqeJAzIKSU/2muHhrBOxB9zgbO08XzFG8eF9aXlPFiaoLT8uCKhYbZXjwqy/juw
 xmwA9p2g5yE9wvpA05dBSNb8ByltsYNO117dIk1KmtMTEDGcykG41fRTlPKB4+PXfywH
 3sWcchiENjA+LfPbn2BB6dMBIm1b9Sci50z/uFKTfpV0mZM6IPPJa6uR9EXOmHjG+5FH
 gXxPyy2oB3GVJfzBan7ZRBlAGLPJMzTEh7biVUoUoufDStkp0AIfCl2gfL24Z51O7B+S
 3zaL1a+U4eITmuebmdUuQxokOaYUC8YEBXsQpnV6ncDqAbWo6gE6kkanAsgJxfh2ODVE
 RcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704980036; x=1705584836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0WSZ5xNE3MipExZS0UbFPPpcyxTj+Sy/E4k9/1ukW8=;
 b=iS1+Crb6EYm5+e8YNMrLDNemOgkjqvIh6iHav9bort15ANswW35IcmV/n6bcp8uvhz
 qRcOi4KfZ2QxG/itXSM/AeRVTaB+DSKJ5ftPMW6k2jvikRas1RBqvP1J7C0QtaOTPRdb
 vLtI2/i3mUQdTN/Jo1jUQ8n/KmvuRrprK+tT+7qao7XYqhzeLgaF2YhrAwArHYT1VrGD
 4yaRawgXqa3jhUWBgoNT+QYtjv6UPjrZKiCPlSeHcuHf9dmNrMW6bSpOs0m9gsRbCcFN
 dRVyjhFmnSz70b93tPEh1XlaWvqiBAgM5vSPyd3QbEO9PBbXS7OAKAoZHzacry5l4hcp
 J5KA==
X-Gm-Message-State: AOJu0Yz9P9XUhlKPIRQ80DoerbGbMJpg5JZB6kvstpjLUzh99jTwG9Hm
 6w/yah6uuF96HtfxehGY7YhnYeY5T0L0pnGR
X-Google-Smtp-Source: AGHT+IFg8yxBk/mT9LGiWSVSrFPEKD16LO2BzCjySzhcmyAtHrfYIb+GQLCVLQqINkMY4V9YU6Vctg==
X-Received: by 2002:a17:902:b197:b0:1d4:2d8d:3544 with SMTP id
 s23-20020a170902b19700b001d42d8d3544mr928501plr.69.1704980036462; 
 Thu, 11 Jan 2024 05:33:56 -0800 (PST)
Received: from localhost.localdomain ([49.37.225.171])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170902e80b00b001cffd42711csm1145895plg.199.2024.01.11.05.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 05:33:56 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rayhan Faizel <rayhan.faizel@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH] hw/char/imx_serial: Implement receive FIFO and ageing timer
 for imx serial.
Date: Thu, 11 Jan 2024 19:03:50 +0530
Message-Id: <20240111133350.66558-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pl1-x634.google.com
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

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/char/imx_serial.c         | 116 ++++++++++++++++++++++++++++++-----
 include/hw/char/imx_serial.h |  22 ++++++-
 2 files changed, 121 insertions(+), 17 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1df862eb7f..6ec67be282 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -44,7 +44,11 @@ static const VMStateDescription vmstate_imx_serial = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32(readbuff, IMXSerialState),
+        VMSTATE_INT32_ARRAY(rx_fifo, IMXSerialState,
+                            FIFO_SIZE),
+        VMSTATE_UINT8(rx_start, IMXSerialState),
+        VMSTATE_UINT8(rx_end, IMXSerialState),
+        VMSTATE_UINT8(rx_used, IMXSerialState),
         VMSTATE_UINT32(usr1, IMXSerialState),
         VMSTATE_UINT32(usr2, IMXSerialState),
         VMSTATE_UINT32(ucr1, IMXSerialState),
@@ -64,13 +68,16 @@ static void imx_update(IMXSerialState *s)
     uint32_t usr1;
     uint32_t usr2;
     uint32_t mask;
-
     /*
      * Lucky for us TRDY and RRDY has the same offset in both USR1 and
      * UCR1, so we can get away with something as simple as the
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
@@ -85,11 +92,73 @@ static void imx_update(IMXSerialState *s)
     usr2 = s->usr2 & mask;
 
     qemu_set_irq(s->irq, usr1 || usr2);
+
 }
 
-static void imx_serial_reset(IMXSerialState *s)
+static void imx_serial_rx_fifo_push(IMXSerialState *s, uint32_t value)
+{
+    uint8_t new_rx_end = (s->rx_end + 1) % FIFO_SIZE;
+    s->rx_used++;
+
+    if (s->rx_used > FIFO_SIZE) {
+        /*
+         * Handle 33rd character in filled RxFIFO
+         */
+        s->rx_start = (s->rx_start + 1) % FIFO_SIZE;
+        s->rx_used--;
+    }
+    s->rx_fifo[s->rx_end] = value;
+    s->rx_end = new_rx_end;
+}
+
+static int32_t imx_serial_rx_fifo_pop(IMXSerialState *s)
+{
+    int32_t front;
+    if (s->rx_used == 0) {
+        /*
+         * FIFO is already empty
+         */
+        return URXD_ERR;
+    }
+    front = s->rx_fifo[s->rx_start];
+
+    s->rx_start = (s->rx_start + 1) % FIFO_SIZE;
+    s->rx_used--;
+
+    return front;
+}
+
+static void imx_serial_rx_fifo_ageing_timer_int(void *opaque)
+{
+    IMXSerialState* s = (IMXSerialState *) opaque;
+    s->usr1 |= USR1_AGTIM;
+
+    imx_update(s);
+}
+
+static void imx_serial_rx_fifo_ageing_timer_restart(void *opaque)
 {
+    /*
+     * Ageing timer starts ticking when
+     * RX FIFO is non empty and below trigger level.
+     * Timer is reset if new character is received or
+     * a FIFO read occurs.
+     * Timer triggers an interrupt when duration of
+     * 8 characters has passed ( assuming 115200 baudrate ).
+     */
+    IMXSerialState* s = (IMXSerialState *) opaque;
+    uint8_t rxtl = s->ufcr & TL_MASK;
+
+    if (s->rx_used > 0 && s->rx_used < rxtl) {
+        timer_mod_ns(&s->ageing_timer,
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + AGE_DURATION_NS);
+    } else {
+        timer_del(&s->ageing_timer);
+    }
+}
 
+static void imx_serial_reset(IMXSerialState *s)
+{
     s->usr1 = USR1_TRDY | USR1_RXDS;
     /*
      * Fake attachment of a terminal: assert RTS.
@@ -102,13 +171,20 @@ static void imx_serial_reset(IMXSerialState *s)
     s->ucr3 = 0x700;
     s->ubmr = 0;
     s->ubrc = 4;
-    s->readbuff = URXD_ERR;
+
+
+    memset(s->rx_fifo, 0, sizeof(s->rx_fifo));
+    s->rx_used = 0;
+    s->rx_start = 0;
+    s->rx_end = 0;
+
+    timer_init_ns(&s->ageing_timer, QEMU_CLOCK_VIRTUAL,
+        imx_serial_rx_fifo_ageing_timer_int, s);
 }
 
 static void imx_serial_reset_at_boot(DeviceState *dev)
 {
     IMXSerialState *s = IMX_SERIAL(dev);
-
     imx_serial_reset(s);
 
     /*
@@ -126,19 +202,24 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
     uint32_t c;
-
+    uint8_t rxtl = s->ufcr & TL_MASK;
     DPRINTF("read(offset=0x%" HWADDR_PRIx ")\n", offset);
-
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
+            /* Clear RRDY if below threshold */
+            if (s->rx_used < rxtl) {
+                s->usr1 &= ~USR1_RRDY;
+            }
+            if (s->rx_used == 0) {
+                s->usr2 &= ~USR2_RDR;
+                s->uts1 |= UTS1_RXEMPTY;
+            }
             imx_update(s);
+            imx_serial_rx_fifo_ageing_timer_restart(s);
             qemu_chr_fe_accept_input(&s->chr);
         }
         return c;
@@ -300,19 +381,24 @@ static void imx_serial_write(void *opaque, hwaddr offset,
 static int imx_can_receive(void *opaque)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    return !(s->usr1 & USR1_RRDY);
+    return s->ucr1 & UCR1_RRDYEN &&
+        s->ucr2 & UCR2_RXEN && s->rx_used < FIFO_SIZE;
 }
 
 static void imx_put_data(void *opaque, uint32_t value)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-
+    uint8_t rxtl = s->ufcr & TL_MASK;
     DPRINTF("received char\n");
+    imx_serial_rx_fifo_push(s, value);
+    if (s->rx_used >= rxtl) {
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
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index b823f94519..86a0a102a5 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -25,6 +25,8 @@
 #define TYPE_IMX_SERIAL "imx.serial"
 OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 
+#define FIFO_SIZE       32
+
 #define URXD_CHARRDY    (1<<15)   /* character read is valid */
 #define URXD_ERR        (1<<14)   /* Character has error */
 #define URXD_FRMERR     (1<<12)   /* Character has frame error */
@@ -65,6 +67,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 #define UCR1_TXMPTYEN   (1<<6)    /* Tx Empty Interrupt Enable */
 #define UCR1_UARTEN     (1<<0)    /* UART Enable */
 
+#define UCR2_ATEN       BIT(3)    /* Ageing Timer Enable */
 #define UCR2_TXEN       (1<<2)    /* Transmitter enable */
 #define UCR2_RXEN       (1<<1)    /* Receiver enable */
 #define UCR2_SRST       (1<<0)    /* Reset complete */
@@ -78,13 +81,28 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
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
-
     /*< public >*/
     MemoryRegion iomem;
-    int32_t readbuff;
+    QEMUTimer ageing_timer;
+
+    int32_t rx_fifo[FIFO_SIZE];
+    uint8_t rx_start;
+    uint8_t rx_end;
+    uint8_t rx_used;
 
     uint32_t usr1;
     uint32_t usr2;
-- 
2.34.1


