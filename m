Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C2A798B46
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew2-0005Sv-UF; Fri, 08 Sep 2023 13:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeew0-0005Po-Jp
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevo-00018c-4l
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso26191375e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192767; x=1694797567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B2Y36K7oIngAzTAuOkoWkj7bctfs8hVULKnKaNJRbYA=;
 b=gLbVSGP3D+aQrpvB9dWXoY1c7r2IPj9xGhmW5pmdm+sRYlv8zMF6jb48oNr11umy2v
 0hYf20Szavi5egancYSRnlE5Rz7B77FtodnlSJ4GDgKNtMNxf1HvIQ7ojS2K9KqfosY1
 v7+dF5KFuylykdzUOlIJ9ATj3lBggd2D3+kiFTEinyIRBpLoODtio2Yiq3aE8ZofsFgg
 KE3IGFQd0fAMS7v8lkwNRgx288IPZ3G2s2Qwmil1vIc5GxucLt/0cmMp5yo/rcNf+Bgr
 5i+bmI2bbqIPGcq5yas1WsYxZAOBoTSdOXcIIxhEJks2yfAJ+h2ojNFVrZlbJkmtNcaw
 Vm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192767; x=1694797567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2Y36K7oIngAzTAuOkoWkj7bctfs8hVULKnKaNJRbYA=;
 b=ZawMZ2OB8KbbTe7U4jW8lNOPomsKMiugArxm27xzzoGeazwWmiXICOFlo2ZpW4bzai
 gimhSX2goVg0qMUwff1muySB+al+L4PVFulC1Y0/mDZ8+990o9oeCmfOA6dLJdyAVCuo
 5RdLJeD4xGIvzfTolkucyYcCn+yBY4UaTqmWdbcv9I7M5ssxmKS+6ZkO/16oe7GqSoT2
 oRhAeek18edl7V1hoG54QPJCAWFInJwsjJ4DP6bcxsYd+PJYGAm7bqg21NfWcbpaMiCp
 zcm0lAJ2dYk7mOJi9KRxPVIgfG3ts4yHegkLbO5CIEnBGuJgzNywK3UOoQQ96vISNMq0
 G3MQ==
X-Gm-Message-State: AOJu0YyOqD/0yrHT5DPvVmf+bl4GFuVeUXD6vSpX6Ma52+lxN1dlJ78R
 K4KNwYooH28V0PTiNjYn65c7AcM2ZjTNJ6GbZhk=
X-Google-Smtp-Source: AGHT+IF+KmZ7J7tpil5dnqq4ksqTlX+IrMGROC7/5wJKm0qD4FwJu+l7Xsrbd0u+/GcSkU6o/7W1+w==
X-Received: by 2002:a05:600c:ad3:b0:401:d803:624f with SMTP id
 c19-20020a05600c0ad300b00401d803624fmr2682673wmr.4.1694192766764; 
 Fri, 08 Sep 2023 10:06:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/26] hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx
 Versal's CFU_SFR
Date: Fri,  8 Sep 2023 18:05:45 +0100
Message-Id: <20230908170557.773048-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Introduce a model of Xilinx Versal's Configuration Frame Unit's Single
Frame Read port (CFU_SFR).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230831165701.2016397-5-francisco.iglesias@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/xlnx-versal-cfu.h | 15 ++++++
 hw/misc/xlnx-versal-cfu.c         | 87 +++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index 73e9a21af4d..86fb8410538 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -28,6 +28,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
 #define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx,versal-cfu-fdro"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUFDRO, XLNX_VERSAL_CFU_FDRO)
 
+#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx,versal-cfu-sfr"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUSFR, XLNX_VERSAL_CFU_SFR)
+
 REG32(CFU_ISR, 0x0)
     FIELD(CFU_ISR, USR_GTS_EVENT, 9, 1)
     FIELD(CFU_ISR, USR_GSR_EVENT, 8, 1)
@@ -222,6 +225,18 @@ struct XlnxVersalCFUFDRO {
     Fifo32 fdro_data;
 };
 
+struct XlnxVersalCFUSFR {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_sfr;
+
+    /* 128-bit wfifo. */
+    uint32_t wfifo[WFIFO_SZ];
+
+    struct {
+        XlnxVersalCFUAPB *cfu;
+    } cfg;
+};
+
 /**
  * This is a helper function for updating a CFI data write fifo, an array of 4
  * uint32_t and 128 bits of data that are allowed to be written through 4
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 255c1bf4b8c..8e588ac1d83 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -264,6 +264,31 @@ static void cfu_stream_write(void *opaque, hwaddr addr, uint64_t value,
     }
 }
 
+static uint64_t cfu_sfr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cfu_sfr_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFUSFR *s = XLNX_VERSAL_CFU_SFR(opaque);
+    uint32_t wfifo[WFIFO_SZ];
+
+    if (update_wfifo(addr, value, s->wfifo, wfifo)) {
+        uint8_t row_addr = extract32(wfifo[0], 23, 5);
+        uint32_t frame_addr = extract32(wfifo[0], 0, 23);
+        XlnxCfiPacket pkt = { .reg_addr = CFRAME_SFR,
+                              .data[0] = frame_addr };
+
+        if (s->cfg.cfu) {
+            cfu_transfer_cfi_packet(s->cfg.cfu, row_addr, &pkt);
+        }
+    }
+}
+
 static uint64_t cfu_fdro_read(void *opaque, hwaddr addr, unsigned size)
 {
     XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
@@ -293,6 +318,16 @@ static const MemoryRegionOps cfu_stream_ops = {
     },
 };
 
+static const MemoryRegionOps cfu_sfr_ops = {
+    .read = cfu_sfr_read,
+    .write = cfu_sfr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static const MemoryRegionOps cfu_fdro_ops = {
     .read = cfu_fdro_read,
     .write = cfu_fdro_write,
@@ -334,6 +369,23 @@ static void cfu_apb_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq_cfu_imr);
 }
 
+static void cfu_sfr_init(Object *obj)
+{
+    XlnxVersalCFUSFR *s = XLNX_VERSAL_CFU_SFR(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem_sfr, obj, &cfu_sfr_ops, s,
+                          TYPE_XLNX_VERSAL_CFU_SFR, KEYHOLE_STREAM_4K);
+    sysbus_init_mmio(sbd, &s->iomem_sfr);
+}
+
+static void cfu_sfr_reset_enter(Object *obj, ResetType type)
+{
+    XlnxVersalCFUSFR *s = XLNX_VERSAL_CFU_SFR(obj);
+
+    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
+}
+
 static void cfu_fdro_init(Object *obj)
 {
     XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
@@ -401,6 +453,12 @@ static Property cfu_props[] = {
         DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property cfu_sfr_props[] = {
+        DEFINE_PROP_LINK("cfu", XlnxVersalCFUSFR, cfg.cfu,
+                         TYPE_XLNX_VERSAL_CFU_APB, XlnxVersalCFUAPB *),
+        DEFINE_PROP_END_OF_LIST(),
+};
+
 static const VMStateDescription vmstate_cfu_apb = {
     .name = TYPE_XLNX_VERSAL_CFU_APB,
     .version_id = 1,
@@ -423,6 +481,16 @@ static const VMStateDescription vmstate_cfu_fdro = {
     }
 };
 
+static const VMStateDescription vmstate_cfu_sfr = {
+    .name = TYPE_XLNX_VERSAL_CFU_SFR,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFUSFR, 4),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
 static void cfu_apb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -443,6 +511,16 @@ static void cfu_fdro_class_init(ObjectClass *klass, void *data)
     rc->phases.enter = cfu_fdro_reset_enter;
 }
 
+static void cfu_sfr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    device_class_set_props(dc, cfu_sfr_props);
+    dc->vmsd = &vmstate_cfu_sfr;
+    rc->phases.enter = cfu_sfr_reset_enter;
+}
+
 static const TypeInfo cfu_apb_info = {
     .name          = TYPE_XLNX_VERSAL_CFU_APB,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -467,10 +545,19 @@ static const TypeInfo cfu_fdro_info = {
     }
 };
 
+static const TypeInfo cfu_sfr_info = {
+    .name          = TYPE_XLNX_VERSAL_CFU_SFR,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalCFUSFR),
+    .class_init    = cfu_sfr_class_init,
+    .instance_init = cfu_sfr_init,
+};
+
 static void cfu_apb_register_types(void)
 {
     type_register_static(&cfu_apb_info);
     type_register_static(&cfu_fdro_info);
+    type_register_static(&cfu_sfr_info);
 }
 
 type_init(cfu_apb_register_types)
-- 
2.34.1


