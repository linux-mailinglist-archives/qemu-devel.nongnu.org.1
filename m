Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B37A6C00
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigxo-00061a-7r; Tue, 19 Sep 2023 16:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FeEJZQwKCi4XKLSROcdOPKXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--nabihestefan.bounces.google.com>)
 id 1qiezA-00059c-01
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:08 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FeEJZQwKCi4XKLSROcdOPKXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--nabihestefan.bounces.google.com>)
 id 1qieys-00010l-Eb
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:07 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d8186d705a9so6505865276.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695146261; x=1695751061; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lj7mqI1GU0t5hK+E7SvhYOkU8PHwZlvaChv6bZL+R7Q=;
 b=RC2FHK3M1zJMJmTjVd4vdRknReG9TFcxbK9K0Ps66aZHW9YrB0pjE8zbBZ3ZkLgx4X
 dVRr3Zuy3NRujlKxNmk98ISQi8IDdX5hLHPHdGbkeDLiAOSKVJzES8qp5KJQYL00Zmhg
 a5W7JG0e4Tw6gKcjyle3SmJCCVteAvZjrHUOgbxK72Wlvm4HCWWzu5I/1KxZ+7B9EAQh
 viMv0tWE0oC8geWCS81K1ek+tjmWkHWIhUrC/M8ce3i/fscZBrNelBmiWXBLH/ozYUyl
 T0XsB4Xo5fQRQUMHxF22wzRIaQDgQtpaF8hXO93jCCuB1kLOf/bPT8/JlmvxKSAPMK7W
 j/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146261; x=1695751061;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lj7mqI1GU0t5hK+E7SvhYOkU8PHwZlvaChv6bZL+R7Q=;
 b=MoDXM/LFxyQp2mPcSbS5wQJel5lEB1xc+H9uOa5mf93wBsn9oQpdxcCDwvGGqb3HQT
 2zXvMlbmYjz+OKD+PonZGP1JXEa1+h0H5P0H2cibgNxabtGbAF2zLS8zr7sbw9kU+rL4
 TtzP8RYT0gKSD8g2Ea++OG0mQ2Kiu4lhYr38sfaMt2RjMPi6eqoaZZoI+BJHEicmR2XP
 AFKJ7Nkoi7Bj6+dMBI05DfKXsw1R5Mup6voe3RkEwmo4xyOTIHF3GB5QNzuJltnKA/vY
 7TFHE8JaM/T0iXY7+gdR1flbSDOoCzcItssPfbwLYdu1eZa9ilhxxsG8lKUunOSmROAa
 PGuQ==
X-Gm-Message-State: AOJu0YwrafuVi9gj4MJzF/mVVDPUYzrs08gDkg/r2GQdptetzJkj6k48
 ZqY44HqiY9OqnPuBPXrhcD13JFdB4snN1jPRwWA=
X-Google-Smtp-Source: AGHT+IFcyhoYXdH755G4TdPCVkb/LETBNMCFBXNvmAGDKAYVcaKuIy92evsq0FjF4zPbYGCyZ7ZLa2c4np9uNT9T0oo=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:496:0:b0:d7f:2cb6:7d88 with SMTP
 id 144-20020a250496000000b00d7f2cb67d88mr5812ybe.13.1695146261094; Tue, 19
 Sep 2023 10:57:41 -0700 (PDT)
Date: Tue, 19 Sep 2023 17:57:13 +0000
In-Reply-To: <20230919175725.3413108-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230919175725.3413108-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919175725.3413108-3-nabihestefan@google.com>
Subject: [PATCH 02/14] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, Avi.Fishman@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3FeEJZQwKCi4XKLSROcdOPKXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Sep 2023 16:04:51 -0400
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

From: Hao Wu <wuhaotsh@google.com>

This patch wires the PCI mailbox module to Nuvoton SoC.

hw/misc: Add chardev to PCI mailbox

This patches adds a chardev to PCI mailbox that can be used to
receive external read and write request from the host.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/arm/npcm7xx.c                   |  16 +++-
 hw/misc/npcm7xx_pci_mbox.c         | 147 +++++++++++++++++++++++++++++
 include/hw/arm/npcm7xx.h           |   1 +
 include/hw/misc/npcm7xx_pci_mbox.h |  18 ++++
 4 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 15ff21d047..c69e936669 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -53,6 +53,9 @@
 /* ADC Module */
 #define NPCM7XX_ADC_BA          (0xf000c000)
 
+/* PCI Mailbox Module */
+#define NPCM7XX_PCI_MBOX_BA     (0xf0848000)
+
 /* Internal AHB SRAM */
 #define NPCM7XX_RAM3_BA         (0xc0008000)
 #define NPCM7XX_RAM3_SZ         (4 * KiB)
@@ -83,6 +86,10 @@ enum NPCM7xxInterrupt {
     NPCM7XX_UART1_IRQ,
     NPCM7XX_UART2_IRQ,
     NPCM7XX_UART3_IRQ,
+    NPCM7XX_PECI_IRQ            = 6,
+    NPCM7XX_PCI_MBOX_IRQ        = 8,
+    NPCM7XX_KCS_HIB_IRQ         = 9,
+    NPCM7XX_GMAC1_IRQ           = 14,
     NPCM7XX_EMC1RX_IRQ          = 15,
     NPCM7XX_EMC1TX_IRQ,
     NPCM7XX_MMC_IRQ             = 26,
@@ -706,6 +713,14 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* PCI Mailbox. Cannot fail */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pci_mbox), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pci_mbox), 0, NPCM7XX_PCI_MBOX_BA);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pci_mbox), 1,
+        NPCM7XX_PCI_MBOX_BA + NPCM7XX_PCI_MBOX_RAM_SIZE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pci_mbox), 0,
+                       npcm7xx_irq(s, NPCM7XX_PCI_MBOX_IRQ));
+
     /* RAM2 (SRAM) */
     memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
                            NPCM7XX_RAM2_SZ, &error_abort);
@@ -765,7 +780,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm7xx.usbd[8]",      0xf0838000,   4 * KiB);
     create_unimplemented_device("npcm7xx.usbd[9]",      0xf0839000,   4 * KiB);
     create_unimplemented_device("npcm7xx.sd",           0xf0840000,   8 * KiB);
-    create_unimplemented_device("npcm7xx.pcimbx",       0xf0848000, 512 * KiB);
     create_unimplemented_device("npcm7xx.aes",          0xf0858000,   4 * KiB);
     create_unimplemented_device("npcm7xx.des",          0xf0859000,   4 * KiB);
     create_unimplemented_device("npcm7xx.sha",          0xf085a000,   4 * KiB);
diff --git a/hw/misc/npcm7xx_pci_mbox.c b/hw/misc/npcm7xx_pci_mbox.c
index d82a87fc41..8f971a1b0d 100644
--- a/hw/misc/npcm7xx_pci_mbox.c
+++ b/hw/misc/npcm7xx_pci_mbox.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "chardev/char-fe.h"
 #include "hw/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties-system.h"
@@ -35,6 +36,18 @@ REG32(NPCM7XX_PCI_MBOX_BMBXSTAT, 0x00);
 REG32(NPCM7XX_PCI_MBOX_BMBXCTL, 0x04);
 REG32(NPCM7XX_PCI_MBOX_BMBXCMD, 0x08);
 
+enum NPCM7xxPCIMBoxOperation {
+    NPCM7XX_PCI_MBOX_OP_READ = 1,
+    NPCM7XX_PCI_MBOX_OP_WRITE,
+};
+
+#define NPCM7XX_PCI_MBOX_OFFSET_BYTES 8
+
+/* Response code */
+#define NPCM7XX_PCI_MBOX_OK 0
+#define NPCM7XX_PCI_MBOX_INVALID_OP 0xa0
+#define NPCM7XX_PCI_MBOX_INVALID_SIZE 0xa1
+#define NPCM7XX_PCI_MBOX_UNSPECIFIED_ERROR 0xff
 
 #define NPCM7XX_PCI_MBOX_NR_CI 8
 #define NPCM7XX_PCI_MBOX_CI_MASK MAKE_64BIT_MASK(0, NPCM7XX_PCI_MBOX_NR_CI)
@@ -53,6 +66,92 @@ static void npcm7xx_pci_mbox_update_irq(NPCM7xxPCIMBoxState *s)
     }
 }
 
+static void npcm7xx_pci_mbox_send_response(NPCM7xxPCIMBoxState *s, uint8_t code)
+{
+    qemu_chr_fe_write(&s->chr, &code, 1);
+    if (code == NPCM7XX_PCI_MBOX_OK && s->op == NPCM7XX_PCI_MBOX_OP_READ) {
+        qemu_chr_fe_write(&s->chr, (uint8_t *)(&s->data), s->size);
+    }
+}
+
+static void npcm7xx_pci_mbox_handle_read(NPCM7xxPCIMBoxState *s)
+{
+    MemTxResult r = memory_region_dispatch_read(
+        &s->ram, s->offset, &s->data, MO_LE | size_memop(s->size),
+        MEMTXATTRS_UNSPECIFIED);
+
+    npcm7xx_pci_mbox_send_response(s, (uint8_t)r);
+}
+
+static void npcm7xx_pci_mbox_handle_write(NPCM7xxPCIMBoxState *s)
+{
+    MemTxResult r = memory_region_dispatch_write(
+        &s->ram, s->offset, s->data, MO_LE | size_memop(s->size),
+        MEMTXATTRS_UNSPECIFIED);
+
+    npcm7xx_pci_mbox_send_response(s, (uint8_t)r);
+}
+
+static void npcm7xx_pci_mbox_receive_char(NPCM7xxPCIMBoxState *s, uint8_t byte)
+{
+    switch (s->state) {
+    case NPCM7XX_PCI_MBOX_STATE_IDLE:
+        switch (byte) {
+        case NPCM7XX_PCI_MBOX_OP_READ:
+        case NPCM7XX_PCI_MBOX_OP_WRITE:
+            s->op = byte;
+            s->state = NPCM7XX_PCI_MBOX_STATE_OFFSET;
+            s->offset = 0;
+            s->receive_count = 0;
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "received invalid op type: 0x%" PRIx8, byte);
+            npcm7xx_pci_mbox_send_response(s, NPCM7XX_PCI_MBOX_INVALID_OP);
+            break;
+        }
+        break;
+
+    case NPCM7XX_PCI_MBOX_STATE_OFFSET:
+        s->offset += (uint64_t)byte << (s->receive_count * BITS_PER_BYTE);
+        if (++s->receive_count >= NPCM7XX_PCI_MBOX_OFFSET_BYTES) {
+            s->state = NPCM7XX_PCI_MBOX_STATE_SIZE;
+        }
+        break;
+
+    case NPCM7XX_PCI_MBOX_STATE_SIZE:
+        s->size = byte;
+        if (s->size < 1 || s->size > sizeof(uint64_t)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "received invalid size: %u", byte);
+            npcm7xx_pci_mbox_send_response(s, NPCM7XX_PCI_MBOX_INVALID_SIZE);
+            s->state = NPCM7XX_PCI_MBOX_STATE_IDLE;
+            break;
+        }
+        if (s->op == NPCM7XX_PCI_MBOX_OP_READ) {
+            npcm7xx_pci_mbox_handle_read(s);
+            s->state = NPCM7XX_PCI_MBOX_STATE_IDLE;
+        } else {
+            s->receive_count = 0;
+            s->data = 0;
+            s->state = NPCM7XX_PCI_MBOX_STATE_DATA;
+        }
+        break;
+
+    case NPCM7XX_PCI_MBOX_STATE_DATA:
+        g_assert(s->op == NPCM7XX_PCI_MBOX_OP_WRITE);
+        s->data += (uint64_t)byte << (s->receive_count * BITS_PER_BYTE);
+        if (++s->receive_count >= s->size) {
+            npcm7xx_pci_mbox_handle_write(s);
+            s->state = NPCM7XX_PCI_MBOX_STATE_IDLE;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static uint64_t npcm7xx_pci_mbox_read(void *opaque, hwaddr offset, unsigned size)
 {
     NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(opaque);
@@ -116,6 +215,8 @@ static void npcm7xx_pci_mbox_enter_reset(Object *obj, ResetType type)
     NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(obj);
 
     memset(s->regs, 0, 4 * NPCM7XX_PCI_MBOX_NR_REGS);
+    s->state = NPCM7XX_PCI_MBOX_STATE_IDLE;
+    s->receive_count = 0;
 }
 
 static void npcm7xx_pci_mbox_hold_reset(Object *obj)
@@ -125,6 +226,37 @@ static void npcm7xx_pci_mbox_hold_reset(Object *obj)
     qemu_irq_lower(s->irq);
 }
 
+static int can_receive(void *opaque)
+{
+    return 1;
+}
+
+static void receive(void *opaque, const uint8_t *buf, int size)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(opaque);
+    int i;
+
+    for (i = 0; i < size; ++i) {
+        npcm7xx_pci_mbox_receive_char(s, buf[i]);
+    }
+}
+
+static void chr_event(void *opaque, QEMUChrEvent event)
+{
+    switch (event) {
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_CLOSED:
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void npcm7xx_pci_mbox_init(Object *obj)
 {
     NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(obj);
@@ -139,6 +271,14 @@ static void npcm7xx_pci_mbox_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq);
 }
 
+static void npcm7xx_pci_mbox_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxPCIMBoxState *s = NPCM7XX_PCI_MBOX(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, can_receive, receive,
+                             chr_event, NULL, OBJECT(dev), NULL, true);
+}
+
 static const VMStateDescription vmstate_npcm7xx_pci_mbox = {
     .name = "npcm7xx-pci-mbox-module",
     .version_id = 0,
@@ -150,6 +290,11 @@ static const VMStateDescription vmstate_npcm7xx_pci_mbox = {
     },
 };
 
+static Property npcm7xx_pci_mbox_properties[] = {
+    DEFINE_PROP_CHR("chardev", NPCM7xxPCIMBoxState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void npcm7xx_pci_mbox_class_init(ObjectClass *klass, void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -157,8 +302,10 @@ static void npcm7xx_pci_mbox_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "NPCM7xx PCI Mailbox Controller";
     dc->vmsd = &vmstate_npcm7xx_pci_mbox;
+    dc->realize = npcm7xx_pci_mbox_realize;
     rc->phases.enter = npcm7xx_pci_mbox_enter_reset;
     rc->phases.hold = npcm7xx_pci_mbox_hold_reset;
+    device_class_set_props(dc, npcm7xx_pci_mbox_properties);
 }
 
 static const TypeInfo npcm7xx_pci_mbox_info = {
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 72c7722096..273090ac60 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -26,6 +26,7 @@
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
+#include "hw/misc/npcm7xx_pci_mbox.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/misc/npcm7xx_rng.h"
 #include "hw/net/npcm7xx_emc.h"
diff --git a/include/hw/misc/npcm7xx_pci_mbox.h b/include/hw/misc/npcm7xx_pci_mbox.h
index 0f8fda0db1..e595fbcc70 100644
--- a/include/hw/misc/npcm7xx_pci_mbox.h
+++ b/include/hw/misc/npcm7xx_pci_mbox.h
@@ -31,6 +31,13 @@
 #define NPCM7XX_PCI_REVISION    0
 #define NPCM7XX_PCI_CLASS_CODE  0xff
 
+typedef enum NPCM7xxPCIMBoxHostState {
+    NPCM7XX_PCI_MBOX_STATE_IDLE,
+    NPCM7XX_PCI_MBOX_STATE_OFFSET,
+    NPCM7XX_PCI_MBOX_STATE_SIZE,
+    NPCM7XX_PCI_MBOX_STATE_DATA,
+} NPCM7xxPCIMBoxHostState ;
+
 /*
  * Maximum amount of control registers in PCI Mailbox module. Do not increase
  * this value without bumping vm version.
@@ -44,6 +51,8 @@
  * @iomem: Memory region through which registers are accessed.
  * @content: The content of the PCI mailbox, initialized to 0.
  * @regs: The MMIO registers.
+ * @chr: The chardev backend used to communicate with core CPU.
+ * @offset: The offset to start transfer.
  */
 typedef struct NPCM7xxPCIMBoxState {
     SysBusDevice parent;
@@ -54,6 +63,15 @@ typedef struct NPCM7xxPCIMBoxState {
     qemu_irq irq;
     uint8_t content[NPCM7XX_PCI_MBOX_RAM_SIZE];
     uint32_t regs[NPCM7XX_PCI_MBOX_NR_REGS];
+    CharBackend chr;
+
+    /* aux data for receiving host commands. */
+    NPCM7xxPCIMBoxHostState state;
+    uint8_t op;
+    hwaddr offset;
+    uint8_t size;
+    uint64_t data;
+    int receive_count;
 } NPCM7xxPCIMBoxState;
 
 #define TYPE_NPCM7XX_PCI_MBOX "npcm7xx-pci-mbox"
-- 
2.42.0.459.ge4e396fd5e-goog


