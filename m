Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C3798B2D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew4-0005U5-8K; Fri, 08 Sep 2023 13:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeew2-0005TD-K5
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevp-00018w-4h
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401d24f1f27so25716165e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192767; x=1694797567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DLnFqq9CUh3kyqRiLPpF1cXp2CymOh9PzceMamk3iwQ=;
 b=HR/ztrmLQAvKgfdM+6Mlc480KVOxChSRdjm0UY97QFeE70Yi4ap4hINKpFT2SiFGXB
 scn6RUqUUwZo7cv35HOSxqLMpSjHh22nK1JjAorJ2fftg8PQUrfRw7uQpRq4PrwwlAHs
 /+YLtnZezcBc8+L8wrWnuEwfayOwdxfJAqnTjmLQjCyCyMaVN59QX8L4G7jtQ2/sYGmV
 IzQw9nQo1HQQnCEJ0PGN+ANo7qqHR0NzVlNJ6quja8IVLbrz5fahES7ay3AelX3T25n0
 JzL/fETqgS5O4QFszQ9Qpxxjuum5sn9/QX/qw92veZSM1QxMtS8trZ52vvqftmVGZ57o
 Kc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192767; x=1694797567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLnFqq9CUh3kyqRiLPpF1cXp2CymOh9PzceMamk3iwQ=;
 b=WPsLID6V/ab5qiiqztp2hDRpWA3JWK2iBn4QeyR3jO3R4otaUcrK2FfdFudX9Hak7C
 SohufMzUg6NiOJvAKKrOsu6nnwpy4vyo7ZXzm5B4IrwcJdoKkbDVnKAIgaz4/jVqTMvF
 Zk4PjtNjaPO4N6cWcWwDZIe1yqRMiOhtvNpV6DD9V8xhZBe/mJLW5vQbkmbBJEuBUW6i
 wt058Lf0QV5q/21S59cMutrn1DEPSQPRVJCFqqAxsnN1RGWsIH5f0+XXIHskR+i2njy2
 WNdXf3UQ6+TE6dWMDxpaUym5ppYjW4OVNEwy69ZctLu8MguqLMDuZ5DFI4mWUkZpHwit
 DRew==
X-Gm-Message-State: AOJu0YzVDn7ecZdlIsrkQoMiIWSQuRRpzt8obast2Zb0/K0TwGmVVqWR
 5soLP9PRPwPljaINQWeYayXnL2bRQv2nMEGMzZY=
X-Google-Smtp-Source: AGHT+IGo2ZrHCKlCoGWmPi8ZYCTVlWn9w50+TCUk9Hh4FdNFcQuZXvdRFOH5KATQNZyQjz3I1rJszw==
X-Received: by 2002:a05:600c:210f:b0:401:dc7c:2494 with SMTP id
 u15-20020a05600c210f00b00401dc7c2494mr2770991wml.27.1694192767693; 
 Fri, 08 Sep 2023 10:06:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/26] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_BCAST_REG
Date: Fri,  8 Sep 2023 18:05:47 +0100
Message-Id: <20230908170557.773048-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Francisco Iglesias <francisco.iglesias@amd.com>

Introduce a model of Xilinx Versal's Configuration Frame broadcast
controller (CFRAME_BCAST_REG).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230831165701.2016397-7-francisco.iglesias@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/xlnx-versal-cframe-reg.h |  17 +++
 hw/misc/xlnx-versal-cframe-reg.c         | 161 +++++++++++++++++++++++
 2 files changed, 178 insertions(+)

diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
index f286d973bf1..a14fbd7fe45 100644
--- a/include/hw/misc/xlnx-versal-cframe-reg.h
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -26,6 +26,10 @@
 #define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx,cframe-reg"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameReg, XLNX_VERSAL_CFRAME_REG)
 
+#define TYPE_XLNX_VERSAL_CFRAME_BCAST_REG "xlnx.cframe-bcast-reg"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameBcastReg,
+                           XLNX_VERSAL_CFRAME_BCAST_REG)
+
 /*
  * The registers in this module are 128 bits wide but it is ok to write
  * and read them through 4 sequential 32 bit accesses (address[3:2] = 0,
@@ -283,4 +287,17 @@ struct XlnxVersalCFrameReg {
     bool row_configured;
 };
 
+struct XlnxVersalCFrameBcastReg {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_reg;
+    MemoryRegion iomem_fdri;
+
+    /* 128-bit wfifo. */
+    uint32_t wfifo[WFIFO_SZ];
+
+    struct {
+        XlnxCfiIf *cframe[15];
+    } cfg;
+};
+
 #endif
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 78db68f10c2..8e8ec0715ab 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -569,6 +569,83 @@ static const MemoryRegionOps cframe_reg_fdri_ops = {
     },
 };
 
+static uint64_t cframes_bcast_reg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cframes_bcast_write(XlnxVersalCFrameBcastReg *s, uint8_t reg_addr,
+                                uint32_t *wfifo)
+{
+    XlnxCfiPacket pkt = {
+        .reg_addr = reg_addr,
+        .data[0] = wfifo[0],
+        .data[1] = wfifo[1],
+        .data[2] = wfifo[2],
+        .data[3] = wfifo[3]
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(s->cfg.cframe); i++) {
+        if (s->cfg.cframe[i]) {
+            xlnx_cfi_transfer_packet(s->cfg.cframe[i], &pkt);
+        }
+    }
+}
+
+static void cframes_bcast_reg_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(opaque);
+    uint32_t wfifo[WFIFO_SZ];
+
+    if (update_wfifo(addr, value, s->wfifo, wfifo)) {
+        uint8_t reg_addr = extract32(addr, 4, 6);
+
+        cframes_bcast_write(s, reg_addr, wfifo);
+    }
+}
+
+static uint64_t cframes_bcast_fdri_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cframes_bcast_fdri_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(opaque);
+    uint32_t wfifo[WFIFO_SZ];
+
+    if (update_wfifo(addr, value, s->wfifo, wfifo)) {
+        cframes_bcast_write(s, CFRAME_FDRI, wfifo);
+    }
+}
+
+static const MemoryRegionOps cframes_bcast_reg_reg_ops = {
+    .read = cframes_bcast_reg_read,
+    .write = cframes_bcast_reg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps cframes_bcast_reg_fdri_ops = {
+    .read = cframes_bcast_fdri_read,
+    .write = cframes_bcast_fdri_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void cframe_reg_realize(DeviceState *dev, Error **errp)
 {
     XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(dev);
@@ -663,6 +740,71 @@ static Property cframe_regs_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void cframe_bcast_reg_init(Object *obj)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem_reg, obj, &cframes_bcast_reg_reg_ops, s,
+                          TYPE_XLNX_VERSAL_CFRAME_BCAST_REG, KEYHOLE_STREAM_4K);
+    memory_region_init_io(&s->iomem_fdri, obj, &cframes_bcast_reg_fdri_ops, s,
+                          TYPE_XLNX_VERSAL_CFRAME_BCAST_REG "-fdri",
+                          KEYHOLE_STREAM_4K);
+    sysbus_init_mmio(sbd, &s->iomem_reg);
+    sysbus_init_mmio(sbd, &s->iomem_fdri);
+}
+
+static void cframe_bcast_reg_reset_enter(Object *obj, ResetType type)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(obj);
+
+    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
+}
+
+static const VMStateDescription vmstate_cframe_bcast_reg = {
+    .name = TYPE_XLNX_VERSAL_CFRAME_BCAST_REG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFrameBcastReg, 4),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property cframe_bcast_regs_props[] = {
+    DEFINE_PROP_LINK("cframe0", XlnxVersalCFrameBcastReg, cfg.cframe[0],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe1", XlnxVersalCFrameBcastReg, cfg.cframe[1],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe2", XlnxVersalCFrameBcastReg, cfg.cframe[2],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe3", XlnxVersalCFrameBcastReg, cfg.cframe[3],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe4", XlnxVersalCFrameBcastReg, cfg.cframe[4],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe5", XlnxVersalCFrameBcastReg, cfg.cframe[5],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe6", XlnxVersalCFrameBcastReg, cfg.cframe[6],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe7", XlnxVersalCFrameBcastReg, cfg.cframe[7],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe8", XlnxVersalCFrameBcastReg, cfg.cframe[8],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe9", XlnxVersalCFrameBcastReg, cfg.cframe[9],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe10", XlnxVersalCFrameBcastReg, cfg.cframe[10],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe11", XlnxVersalCFrameBcastReg, cfg.cframe[11],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe12", XlnxVersalCFrameBcastReg, cfg.cframe[12],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe13", XlnxVersalCFrameBcastReg, cfg.cframe[13],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe14", XlnxVersalCFrameBcastReg, cfg.cframe[14],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void cframe_reg_class_init(ObjectClass *klass, void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -677,6 +819,16 @@ static void cframe_reg_class_init(ObjectClass *klass, void *data)
     xcic->cfi_transfer_packet = cframe_reg_cfi_transfer_packet;
 }
 
+static void cframe_bcast_reg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_cframe_bcast_reg;
+    device_class_set_props(dc, cframe_bcast_regs_props);
+    rc->phases.enter = cframe_bcast_reg_reset_enter;
+}
+
 static const TypeInfo cframe_reg_info = {
     .name          = TYPE_XLNX_VERSAL_CFRAME_REG,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -689,9 +841,18 @@ static const TypeInfo cframe_reg_info = {
     }
 };
 
+static const TypeInfo cframe_bcast_reg_info = {
+    .name          = TYPE_XLNX_VERSAL_CFRAME_BCAST_REG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalCFrameBcastReg),
+    .class_init    = cframe_bcast_reg_class_init,
+    .instance_init = cframe_bcast_reg_init,
+};
+
 static void cframe_reg_register_types(void)
 {
     type_register_static(&cframe_reg_info);
+    type_register_static(&cframe_bcast_reg_info);
 }
 
 type_init(cframe_reg_register_types)
-- 
2.34.1


