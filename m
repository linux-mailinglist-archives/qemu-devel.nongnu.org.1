Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD007638E2
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWv-00038F-CR; Wed, 26 Jul 2023 09:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWe-0002rd-Jl; Wed, 26 Jul 2023 09:26:02 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWa-0003O6-S8; Wed, 26 Jul 2023 09:26:00 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fddd4e942eso10144176e87.3; 
 Wed, 26 Jul 2023 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377954; x=1690982754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAPsV35WaqbCWduHsBiHzhUzEkwY0B0uKgCN6HXB/9A=;
 b=R8hQTr1jPfnrplvf2ke9QuiTLQ5ysA5kS9N/AMBDyB4hmEF9/VBMH/zsUajyrBUVnb
 bHGJJ1vyF2JGgJX+ZbnWzawrTknTvynJjsA67zCcXjTjrTif7vBVdVfdAW1/hql5WrUh
 cqR1bjjq8sGwvpP6DxeIw+HuJtSwmhndeZwdgiN3QN9yfGsQJSFzmcOZi/qhKxoVOpW7
 /JiCnaZEGlW7NhNL1b/JmMMUFt52wqukA4ZUFDKuY3qr1vCAv+qLL9R57xjpkT/3KYTi
 p4dz89NldSzPo4ic1PSvDw+u131qBL9qOAWPxgiMV94rDPDtBLGERhFLOManEE++Xdaz
 U5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377954; x=1690982754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAPsV35WaqbCWduHsBiHzhUzEkwY0B0uKgCN6HXB/9A=;
 b=XDnybVu5OR+r4coSPCE/rR0mg+NP1NqEse0q9OIxAXcEzaP1k2IL3fVVK02pLo0tKw
 7YNuvl6tKLsSftcYYNNSIQqZG+dbMIB6D7azksw91LFnoeQxc2acfcoIedH1xcsJ2lkf
 kmE3cLkk4mqZFFxtUb4TXNu0YjcOol2TRI2Cs3TM2ad4oTeMQLxO9yyPthML2xSrxm1T
 WPkS7gldwHkf/S6bXqWToA9E0Hnn9wehbdeHagM32SqM5kd/Sf08MZfQDO0AK2+EUrQM
 NrgxXPHdMH+mCN2uZ6bFf9Pb52Pogf0TYuv6M0Wr4f437a+iGy+XtbtXIZb1gOYBlqyo
 07CQ==
X-Gm-Message-State: ABy/qLaLfR1dZXIFqI6m6IJpBjL/KIJ6MQVzl7p8h/yfD2NsoidwkWwV
 ogEeemOHE3ZNUm3LBKoRlOWLWao5aCI=
X-Google-Smtp-Source: APBJJlGrLjo4IkydYy22lYRwMvxcMUq67UMaDvN9kD6fU5ElZvpw8ZZWpBBboaLZtU74LQ4GAz6RGg==
X-Received: by 2002:a19:8c0b:0:b0:4fb:744e:17db with SMTP id
 o11-20020a198c0b000000b004fb744e17dbmr1529814lfd.1.1690377953452; 
 Wed, 26 Jul 2023 06:25:53 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:53 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 28/44] Impl GENET register ops.
Date: Wed, 26 Jul 2023 16:24:56 +0300
Message-Id: <20230726132512.149618-29-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x133.google.com
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c         | 183 +++++++++++++++++++++++++++++++--
 include/hw/net/bcm2838_genet.h |   2 +
 2 files changed, 175 insertions(+), 10 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index c3e7d90451..01e6819df4 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -19,25 +19,139 @@
 #include "trace.h"
 
 
+static void bcm2838_genet_set_qemu_mac(BCM2838GenetState *s)
+{
+    s->regs.umac.mac0.fields.addr_0 = s->nic_conf.macaddr.a[0];
+    s->regs.umac.mac0.fields.addr_1 = s->nic_conf.macaddr.a[1];
+    s->regs.umac.mac0.fields.addr_2 = s->nic_conf.macaddr.a[2];
+    s->regs.umac.mac0.fields.addr_3 = s->nic_conf.macaddr.a[3];
+    s->regs.umac.mac1.fields.addr_4 = s->nic_conf.macaddr.a[4];
+    s->regs.umac.mac1.fields.addr_5 = s->nic_conf.macaddr.a[5];
+}
+
+static void bcm2838_genet_set_irq_default(BCM2838GenetState *s)
+{
+    uint32_t intrl_0_status = s->regs.intrl0.stat.value;
+    uint32_t intrl_0_mask = s->regs.intrl0.mask_status.value;
+    int level = (intrl_0_status & ~intrl_0_mask) == 0 ? 0 : 1;
+
+    qemu_set_irq(s->irq_default, level);
+}
+
+static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
+{
+    uint32_t intrl_1_status = s->regs.intrl1.stat.value;
+    uint32_t intrl_1_mask = s->regs.intrl1.mask_status.value;
+    int level = (intrl_1_status & ~intrl_1_mask) == 0 ? 0 : 1;
+
+    qemu_set_irq(s->irq_prio, level);
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
+    BCM2838GenetState *s = opaque;
 
-    qemu_log_mask(
-        LOG_GUEST_ERROR,
-        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
-        __func__, size, offset);
+    if (offset + size < sizeof(s->regs)) {
+        memcpy(&value, (uint8_t *)&s->regs + offset, size);
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
 
     trace_bcm2838_genet_read(size, offset, value);
     return value;
 }
 
 static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
-                                unsigned size) {
-    qemu_log_mask(
-        LOG_GUEST_ERROR,
-        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
-        __func__, size, offset);
+                                unsigned size)
+{
+    BCM2838GenetState *s = opaque;
+    NetClientState *ncs = qemu_get_queue(s->nic);
+    BCM2838GenetUmacCmd umac_cmd = {.value = value};
+    BCM2838GenetUmacMac0 umac_mac0 = {.value = value};
+    BCM2838GenetUmacMac1 umac_mac1 = {.value = value};
+
+    trace_bcm2838_genet_write(size, offset, value);
+
+    if (offset + size < sizeof(s->regs)) {
+        switch (offset) {
+        case BCM2838_GENET_INTRL0_SET:
+            s->regs.intrl0.stat.value |= value;
+            break;
+        case BCM2838_GENET_INTRL0_CLEAR:
+            s->regs.intrl0.stat.value &= ~value;
+            break;
+        case BCM2838_GENET_INTRL0_MASK_SET:
+            s->regs.intrl0.mask_status.value |= value;
+            break;
+        case BCM2838_GENET_INTRL0_MASK_CLEAR:
+            s->regs.intrl0.mask_status.value &= ~value;
+            break;
+        case BCM2838_GENET_INTRL1_SET:
+            s->regs.intrl1.stat.value |= value;
+            break;
+        case BCM2838_GENET_INTRL1_CLEAR:
+            s->regs.intrl1.stat.value &= ~value;
+            break;
+        case BCM2838_GENET_INTRL1_MASK_SET:
+            s->regs.intrl1.mask_status.value |= value;
+            break;
+        case BCM2838_GENET_INTRL1_MASK_CLEAR:
+            s->regs.intrl1.mask_status.value &= ~value;
+            break;
+        case BCM2838_GENET_UMAC_CMD:
+            /* Complete SW reset as soon as it has been requested */
+            if (umac_cmd.fields.sw_reset == 1) {
+                device_cold_reset(DEVICE(s));
+                umac_cmd.fields.sw_reset = 0;
+                value = umac_cmd.value;
+            }
+            break;
+        /*
+         * TODO: before changing MAC address we'd better inform QEMU
+         * network subsystem about freeing previously used one, but
+         * qemu_macaddr_set_free function isn't accessible for us (marked
+         * as static in net/net.c), see also https://lists.nongnu.org/
+         * archive/html/qemu-devel/2022-07/msg02123.html
+         */
+        case BCM2838_GENET_UMAC_MAC0:
+            s->nic_conf.macaddr.a[0] = umac_mac0.fields.addr_0;
+            s->nic_conf.macaddr.a[1] = umac_mac0.fields.addr_1;
+            s->nic_conf.macaddr.a[2] = umac_mac0.fields.addr_2;
+            s->nic_conf.macaddr.a[3] = umac_mac0.fields.addr_3;
+            qemu_macaddr_default_if_unset(&s->nic_conf.macaddr);
+            qemu_format_nic_info_str(ncs, s->nic_conf.macaddr.a);
+            trace_bcm2838_genet_mac_address(ncs->info_str);
+            break;
+        case BCM2838_GENET_UMAC_MAC1:
+            s->nic_conf.macaddr.a[4] = umac_mac1.fields.addr_4;
+            s->nic_conf.macaddr.a[5] = umac_mac1.fields.addr_5;
+            qemu_macaddr_default_if_unset(&s->nic_conf.macaddr);
+            qemu_format_nic_info_str(ncs, s->nic_conf.macaddr.a);
+            trace_bcm2838_genet_mac_address(ncs->info_str);
+            break;
+        case BCM2838_GENET_UMAC_MDIO_CMD:
+        case BCM2838_GENET_TDMA_REGS
+            ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
+            qemu_log_mask(LOG_UNIMP,
+                "UMAC MDIO and TDMA aren't implemented yet");
+            break;
+        default:
+            break;
+        }
+
+        memcpy((uint8_t *)&s->regs + offset, &value, size);
+        bcm2838_genet_set_irq_default(s);
+        bcm2838_genet_set_irq_prio(s);
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
 }
 
 static const MemoryRegionOps bcm2838_genet_ops = {
@@ -48,9 +162,14 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = sizeof(uint32_t)},
 };
 
+static NetClientInfo bcm2838_genet_client_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState)
+};
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
 {
+    NetClientState *ncs;
     BCM2838GenetState *s = BCM2838_GENET(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
@@ -58,11 +177,45 @@ static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->regs_mr, OBJECT(s), &bcm2838_genet_ops, s,
                           "bcm2838_genet_regs", sizeof(s->regs));
     sysbus_init_mmio(sbd, &s->regs_mr);
+
+    /* QEMU-managed NIC (host network back-end connection) */
+    qemu_macaddr_default_if_unset(&s->nic_conf.macaddr);
+    s->nic = qemu_new_nic(&bcm2838_genet_client_info, &s->nic_conf,
+                          object_get_typename(OBJECT(dev)), dev->id, s);
+    bcm2838_genet_set_qemu_mac(s);
+    ncs = qemu_get_queue(s->nic);
+    qemu_format_nic_info_str(ncs, s->nic_conf.macaddr.a);
+    trace_bcm2838_genet_mac_address(ncs->info_str);
+
+    /* Interrupts */
+    sysbus_init_irq(sbd, &s->irq_default);
+    sysbus_init_irq(sbd, &s->irq_prio);
+
+    /* DMA space */
+    address_space_init(&s->dma_as, get_system_memory(), "bcm2838_genet_dma");
 }
 
 static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
 {
-    /* Temporary unimplemented */
+    memset(&s->phy_regs, 0x00, sizeof(s->phy_regs));
+    memset(&s->phy_shd_regs, 0x00, sizeof(s->phy_shd_regs));
+    memset(&s->phy_aux_ctl_shd_regs, 0x00, sizeof(s->phy_aux_ctl_shd_regs));
+
+    /* All the below values were taken from the real HW trace and logs */
+    s->phy_regs.bmcr.value = 0x1140;
+    s->phy_regs.bmsr.value = 0x7949;
+    s->phy_regs.sid1 = 0x600D;
+    s->phy_regs.sid2 = 0x84A2;
+    s->phy_regs.advertise = 0x01E1;
+    s->phy_regs.ctrl1000 = 0x0200;
+    s->phy_regs.estatus = 0x3000;
+
+    s->phy_shd_regs.clk_ctl = 0x0200;
+    s->phy_shd_regs.scr3 = 0x001F;
+    s->phy_shd_regs.apd = 0x0001;
+
+    s->phy_aux_ctl_shd_regs.misc = 0x1E;
+
     trace_bcm2838_genet_phy_reset("done");
 }
 
@@ -72,17 +225,27 @@ static void bcm2838_genet_reset(DeviceState *d)
 
     memset(&s->regs, 0x00, sizeof(s->regs));
 
+    /* All the below values were taken from the real HW trace and logs */
+    s->regs.sys.rev_ctrl.fields.major_rev = BCM2838_GENET_REV_MAJOR;
+    s->regs.sys.rev_ctrl.fields.minor_rev = BCM2838_GENET_REV_MINOR;
+
     trace_bcm2838_genet_reset("done");
 
     bcm2838_genet_phy_reset(s);
 }
 
+static Property genet_properties[] = {
+    DEFINE_NIC_PROPERTIES(BCM2838GenetState, nic_conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void bcm2838_genet_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
 
     dc->realize = bcm2838_genet_realize;
     dc->reset = bcm2838_genet_reset;
+    device_class_set_props(dc, genet_properties);
 }
 
 static const TypeInfo bcm2838_genet_info = {
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index bfe5e3ab31..025ac467d7 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -686,6 +686,8 @@ struct BCM2838GenetState {
     SysBusDevice parent_obj;
 
     /*< public >*/
+    NICState *nic;
+    NICConf nic_conf;
 
     MemoryRegion regs_mr;
     AddressSpace dma_as;
-- 
2.34.1


