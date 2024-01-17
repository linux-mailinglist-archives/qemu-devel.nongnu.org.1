Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94365830DBC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 21:09:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQCCM-00044w-35; Wed, 17 Jan 2024 15:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rQCCK-00044G-Ar; Wed, 17 Jan 2024 15:07:40 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rQCCI-0000dE-Cp; Wed, 17 Jan 2024 15:07:40 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6dac8955af0so6642652b3a.0; 
 Wed, 17 Jan 2024 12:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705522056; x=1706126856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9XkYNOwR5SV4ZK30HK6EzXtsYl/yvEbJEqih4Pyufew=;
 b=lUaSuYOOOMGCU+0RnaSU8bnrjMKP3GpvP4A0eIxWh9//KgOIxCXThRp75TUOeubEtr
 p1BLo9HUysozlVJUP/WfyILI3uMXO3TxwtM9zDc+PqobMlW2MPSrHiQgbXO/JdxiSv7m
 59cs+n1Fg9VTn3fOU3NxbO4Qw+OVlSYd1w3qpqWSU/5HiVaiNK2P2710RYZomXnZKDuV
 daTR7TsmfAq7Ghhs/auFggnWlvhPvqFgzgzxWZw0p5GhZjRTziAgo7TtVzef4+MMeO9n
 ZblhBrXGTst7Bal7aRDJ6l3O597eUDW4U9GO2oTXr3WClIJksATyf4BFGchHoSNID3ET
 G3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705522056; x=1706126856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9XkYNOwR5SV4ZK30HK6EzXtsYl/yvEbJEqih4Pyufew=;
 b=cx9CvcVVQFYXycRKWZ+lYebHGNG/EjlXNhK2HJU8Vz8QdsyyUlLRyTxA0qA9fJuZWA
 3KE1bIvSVfMnODcBFrWf7wzV/5vPGZ6Tvph5wVI5vvYRyvovmFCGi2qgWMKmJaGZDsr5
 TDRfqvlf3zifz+KKeF8Ydm5sXyZikLIyCpbrft995xmyWJCUR4/+83rOP6TtuxMrTAWQ
 WVskvV3yyogZ34CddF+URgzA1aHav9JAwHQYz+PxHTmghc3SSM38/5zJ+J1N7ONSMUDt
 3V/nb4VpcbAF0gGtL3FIImDJp9QD5t9J2M6QvJaGeTKcxgs6e5ICasQBCU1zo0E95GMH
 7TvA==
X-Gm-Message-State: AOJu0YymORi5MwtWzr3zOLsvpl570uzmDWIZ+n/v3+5hU/WflpsWysFJ
 DQf49xIwKlzEf9i9RlaBmrAh5o7g+o2kh4+l
X-Google-Smtp-Source: AGHT+IFN47/EAgNA+Rs9wvi91vPSeROoVv2p+srs+r8wS6VlX+J7TKWvB085FMGlzFa2l+cIHpMSRg==
X-Received: by 2002:a05:6a21:a595:b0:199:b81d:ac41 with SMTP id
 gd21-20020a056a21a59500b00199b81dac41mr5949018pzc.92.1705522055648; 
 Wed, 17 Jan 2024 12:07:35 -0800 (PST)
Received: from localhost.localdomain ([49.37.224.90])
 by smtp.gmail.com with ESMTPSA id
 kn7-20020a170903078700b001d6ff4a3ad7sm51437plb.85.2024.01.17.12.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 12:07:35 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rayhan Faizel <rayhan.faizel@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH v2] hw/char/imx_serial: Implement receive FIFO and ageing
 timer for imx serial.
Date: Thu, 18 Jan 2024 01:36:46 +0530
Message-Id: <20240117200645.2152170-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pf1-x42a.google.com
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

[Changes in v2]

As per Peter Maydell's suggestions,

- Use generic FIFO32 implementation in place of handmade impl.
- Moved timer_init to serial init and use timer_del in reset
- Removed stray whitespaces
- Increment VMSTATE version

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/char/imx_serial.c         | 99 +++++++++++++++++++++++++++++++-----
 include/hw/char/imx_serial.h | 18 ++++++-
 2 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1df862eb7f..4c3aea7ea7 100644
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
@@ -87,9 +93,55 @@ static void imx_update(IMXSerialState *s)
     qemu_set_irq(s->irq, usr1 || usr2);
 }
 
-static void imx_serial_reset(IMXSerialState *s)
+static void imx_serial_rx_fifo_push(IMXSerialState *s, uint32_t value)
 {
+    if (fifo32_is_full(&s->rx_fifo)) {
+        /* Discard lost character on overflow */
+        fifo32_pop(&s->rx_fifo);
+    }
+    fifo32_push(&s->rx_fifo, value);
+}
 
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
+static void imx_serial_reset(IMXSerialState *s)
+{
     s->usr1 = USR1_TRDY | USR1_RXDS;
     /*
      * Fake attachment of a terminal: assert RTS.
@@ -102,7 +154,9 @@ static void imx_serial_reset(IMXSerialState *s)
     s->ucr3 = 0x700;
     s->ubmr = 0;
     s->ubrc = 4;
-    s->readbuff = URXD_ERR;
+
+    fifo32_reset(&s->rx_fifo);
+    timer_del(&s->ageing_timer);
 }
 
 static void imx_serial_reset_at_boot(DeviceState *dev)
@@ -125,20 +179,28 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
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
@@ -300,19 +362,24 @@ static void imx_serial_write(void *opaque, hwaddr offset,
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
-
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
@@ -360,6 +427,10 @@ static void imx_serial_init(Object *obj)
                           TYPE_IMX_SERIAL, 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
+
+    fifo32_create(&s->rx_fifo, FIFO_SIZE);
+    timer_init_ns(&s->ageing_timer, QEMU_CLOCK_VIRTUAL,
+        imx_serial_rx_fifo_ageing_timer_int, s);
 }
 
 static Property imx_serial_properties[] = {
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


