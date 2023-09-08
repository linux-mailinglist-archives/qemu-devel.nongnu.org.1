Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C363798B2C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeewB-0005dE-JH; Fri, 08 Sep 2023 13:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeew7-0005Wc-25
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevq-000198-NT
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so24377195e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192768; x=1694797568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UGFdniUa1jCBWdX2jgIAAKDJpiZuYqX+QKQ1XjeA+no=;
 b=algWC4pkVjgw0FaVjz4Uv696Wvf43SooJhMAnsL5Dv4NezQj7i843eEGCiAzVn+6GS
 c18EJOyWXnLCdd/RUN46AEOHPH9cBnprnnBHW50UZiw6V0F7tDkD0wP5Eir5pWgXK8nx
 MtsDDCN5A7mDsKJzTWBZ0C+Ix8jCOx1WB0U5XNin5pTvpvqS1uI8xrg7Rw55XQX+3Yac
 T+sbhMHfWlVbFgI2VeJDcL8Pd63q6EFZQ900QhC6d/tHJa78OcFtBYMYd/T/iZSoK5yS
 6agyxHK27Qsey4b4FFqHzsGhNpRtsRpGR6AWZRZSgdtkY731opJBtzzBzHwmmloBeZ8i
 jaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192768; x=1694797568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGFdniUa1jCBWdX2jgIAAKDJpiZuYqX+QKQ1XjeA+no=;
 b=fyG+dHW4H00jMPX9pdpqhycKUuaoIUpIRT6fEJqwx0fBN5EMYHa/5bHS1GbOethL+r
 jw1KLsfL62gBpoYTNQ+k2d2DB87DxyAh3xjVbGvFYucZg8Rg3AUDI/CCfZryij7F8R94
 LNXNOcRNO0tyVM9LDULeF8f7xwcH/Mft7E4T9Sw2QwEMM2fl2efvn10PVep+FdbQjBsq
 71DIyr+QaDb/He8rkjgZlNqmHIrsOAfB90IqhKX/n2A884Zsv2l+TbUAWTKc006dU0nc
 tAb7QUlHa5T90p4Jo5soa9+ZsfiC6VVVn7ya3xCibXwK2Ldk8pKfO8OxDw+YIo3NWblQ
 eybg==
X-Gm-Message-State: AOJu0YzJZfwMYTftxd1dfYo+37+Vw3aeLgkYz91nXmgdDBbp+WAMxQIz
 31ZbLn9rqh09Il3RYRZKBousji40h6nn/5TMyLs=
X-Google-Smtp-Source: AGHT+IFOxdRMT+IH96+BtESIakPyCNFQ0Xv1Kqx9RSqRl3v+cCdq5GI+azBEjybcl5fzirOKQBXpeQ==
X-Received: by 2002:a05:600c:245:b0:3fb:e2af:49f6 with SMTP id
 5-20020a05600c024500b003fbe2af49f6mr2564837wmj.39.1694192768626; 
 Fri, 08 Sep 2023 10:06:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/26] hw/arm/versal: Connect the CFRAME_REG and
 CFRAME_BCAST_REG
Date: Fri,  8 Sep 2023 18:05:49 +0100
Message-Id: <20230908170557.773048-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Connect the Configuration Frame controller (CFRAME_REG) and the
Configuration Frame broadcast controller (CFRAME_BCAST_REG) to the
Versal machine.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230831165701.2016397-9-francisco.iglesias@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  69 +++++++++++++++++++++
 hw/arm/xlnx-versal.c         | 113 ++++++++++++++++++++++++++++++++++-
 2 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 29b9c603010..7b419f88c2c 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -33,6 +33,7 @@
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/misc/xlnx-versal-cfu.h"
+#include "hw/misc/xlnx-versal-cframe-reg.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
@@ -47,6 +48,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
 #define XLNX_VERSAL_NR_IRQS    192
 #define XLNX_VERSAL_NR_CANFD   2
 #define XLNX_VERSAL_CANFD_REF_CLK (24 * 1000 * 1000)
+#define XLNX_VERSAL_NR_CFRAME  15
 
 struct Versal {
     /*< private >*/
@@ -121,6 +123,8 @@ struct Versal {
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
         XlnxVersalCFUSFR cfu_sfr;
+        XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
+        XlnxVersalCFrameBcastReg cframe_bcast;
 
         OrIRQState apb_irq_orgate;
     } pmc;
@@ -256,6 +260,71 @@ struct Versal {
 #define MM_PMC_CFU_STREAM_2         0xf1f80000
 #define MM_PMC_CFU_STREAM_2_SIZE    0x40000
 
+#define MM_PMC_CFRAME0_REG          0xf12d0000
+#define MM_PMC_CFRAME0_REG_SIZE     0x1000
+#define MM_PMC_CFRAME0_FDRI         0xf12d1000
+#define MM_PMC_CFRAME0_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME1_REG          0xf12d2000
+#define MM_PMC_CFRAME1_REG_SIZE     0x1000
+#define MM_PMC_CFRAME1_FDRI         0xf12d3000
+#define MM_PMC_CFRAME1_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME2_REG          0xf12d4000
+#define MM_PMC_CFRAME2_REG_SIZE     0x1000
+#define MM_PMC_CFRAME2_FDRI         0xf12d5000
+#define MM_PMC_CFRAME2_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME3_REG          0xf12d6000
+#define MM_PMC_CFRAME3_REG_SIZE     0x1000
+#define MM_PMC_CFRAME3_FDRI         0xf12d7000
+#define MM_PMC_CFRAME3_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME4_REG          0xf12d8000
+#define MM_PMC_CFRAME4_REG_SIZE     0x1000
+#define MM_PMC_CFRAME4_FDRI         0xf12d9000
+#define MM_PMC_CFRAME4_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME5_REG          0xf12da000
+#define MM_PMC_CFRAME5_REG_SIZE     0x1000
+#define MM_PMC_CFRAME5_FDRI         0xf12db000
+#define MM_PMC_CFRAME5_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME6_REG          0xf12dc000
+#define MM_PMC_CFRAME6_REG_SIZE     0x1000
+#define MM_PMC_CFRAME6_FDRI         0xf12dd000
+#define MM_PMC_CFRAME6_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME7_REG          0xf12de000
+#define MM_PMC_CFRAME7_REG_SIZE     0x1000
+#define MM_PMC_CFRAME7_FDRI         0xf12df000
+#define MM_PMC_CFRAME7_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME8_REG          0xf12e0000
+#define MM_PMC_CFRAME8_REG_SIZE     0x1000
+#define MM_PMC_CFRAME8_FDRI         0xf12e1000
+#define MM_PMC_CFRAME8_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME9_REG          0xf12e2000
+#define MM_PMC_CFRAME9_REG_SIZE     0x1000
+#define MM_PMC_CFRAME9_FDRI         0xf12e3000
+#define MM_PMC_CFRAME9_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME10_REG         0xf12e4000
+#define MM_PMC_CFRAME10_REG_SIZE    0x1000
+#define MM_PMC_CFRAME10_FDRI        0xf12e5000
+#define MM_PMC_CFRAME10_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME11_REG         0xf12e6000
+#define MM_PMC_CFRAME11_REG_SIZE    0x1000
+#define MM_PMC_CFRAME11_FDRI        0xf12e7000
+#define MM_PMC_CFRAME11_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME12_REG         0xf12e8000
+#define MM_PMC_CFRAME12_REG_SIZE    0x1000
+#define MM_PMC_CFRAME12_FDRI        0xf12e9000
+#define MM_PMC_CFRAME12_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME13_REG         0xf12ea000
+#define MM_PMC_CFRAME13_REG_SIZE    0x1000
+#define MM_PMC_CFRAME13_FDRI        0xf12eb000
+#define MM_PMC_CFRAME13_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME14_REG         0xf12ec000
+#define MM_PMC_CFRAME14_REG_SIZE    0x1000
+#define MM_PMC_CFRAME14_FDRI        0xf12ed000
+#define MM_PMC_CFRAME14_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME_BCAST_REG       0xf12ee000
+#define MM_PMC_CFRAME_BCAST_REG_SIZE  0x1000
+#define MM_PMC_CFRAME_BCAST_FDRI      0xf12ef000
+#define MM_PMC_CFRAME_BCAST_FDRI_SIZE 0x1000
+
 #define MM_PMC_CRP                  0xf1260000U
 #define MM_PMC_CRP_SIZE             0x10000
 #define MM_PMC_RTC                  0xf12a0000
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3f4b4b15600..fa556d8764b 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -27,7 +27,7 @@
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
-#define VERSAL_NUM_PMC_APB_IRQS 3
+#define VERSAL_NUM_PMC_APB_IRQS 18
 #define NUM_OSPI_IRQ_LINES 3
 
 static void versal_create_apu_cpus(Versal *s)
@@ -341,6 +341,7 @@ static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
      *  - RTC
      *  - BBRAM
      *  - PMC SLCR
+     *  - CFRAME regs (input 3 - 17 to the orgate)
      */
     object_initialize_child(OBJECT(s), "pmc-apb-irq-orgate",
                             &s->pmc.apb_irq_orgate, TYPE_OR_IRQ);
@@ -573,6 +574,42 @@ static void versal_create_ospi(Versal *s, qemu_irq *pic)
 static void versal_create_cfu(Versal *s, qemu_irq *pic)
 {
     SysBusDevice *sbd;
+    DeviceState *dev;
+    int i;
+    const struct {
+        uint64_t reg_base;
+        uint64_t fdri_base;
+    } cframe_addr[] = {
+        { MM_PMC_CFRAME0_REG, MM_PMC_CFRAME0_FDRI },
+        { MM_PMC_CFRAME1_REG, MM_PMC_CFRAME1_FDRI },
+        { MM_PMC_CFRAME2_REG, MM_PMC_CFRAME2_FDRI },
+        { MM_PMC_CFRAME3_REG, MM_PMC_CFRAME3_FDRI },
+        { MM_PMC_CFRAME4_REG, MM_PMC_CFRAME4_FDRI },
+        { MM_PMC_CFRAME5_REG, MM_PMC_CFRAME5_FDRI },
+        { MM_PMC_CFRAME6_REG, MM_PMC_CFRAME6_FDRI },
+        { MM_PMC_CFRAME7_REG, MM_PMC_CFRAME7_FDRI },
+        { MM_PMC_CFRAME8_REG, MM_PMC_CFRAME8_FDRI },
+        { MM_PMC_CFRAME9_REG, MM_PMC_CFRAME9_FDRI },
+        { MM_PMC_CFRAME10_REG, MM_PMC_CFRAME10_FDRI },
+        { MM_PMC_CFRAME11_REG, MM_PMC_CFRAME11_FDRI },
+        { MM_PMC_CFRAME12_REG, MM_PMC_CFRAME12_FDRI },
+        { MM_PMC_CFRAME13_REG, MM_PMC_CFRAME13_FDRI },
+        { MM_PMC_CFRAME14_REG, MM_PMC_CFRAME14_FDRI },
+    };
+    const struct {
+        uint32_t blktype0_frames;
+        uint32_t blktype1_frames;
+        uint32_t blktype2_frames;
+        uint32_t blktype3_frames;
+        uint32_t blktype4_frames;
+        uint32_t blktype5_frames;
+        uint32_t blktype6_frames;
+    } cframe_cfg[] = {
+        [0] = { 34111, 3528, 12800, 11, 5, 1, 1 },
+        [1] = { 38498, 3841, 15361, 13, 7, 3, 1 },
+        [2] = { 38498, 3841, 15361, 13, 7, 3, 1 },
+        [3] = { 38498, 3841, 15361, 13, 7, 3, 1 },
+    };
 
     /* CFU FDRO */
     object_initialize_child(OBJECT(s), "cfu-fdro", &s->pmc.cfu_fdro,
@@ -583,10 +620,84 @@ static void versal_create_cfu(Versal *s, qemu_irq *pic)
     memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_FDRO,
                                 sysbus_mmio_get_region(sbd, 0));
 
+    /* CFRAME REG */
+    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
+        g_autofree char *name = g_strdup_printf("cframe%d", i);
+
+        object_initialize_child(OBJECT(s), name, &s->pmc.cframe[i],
+                                TYPE_XLNX_VERSAL_CFRAME_REG);
+
+        sbd = SYS_BUS_DEVICE(&s->pmc.cframe[i]);
+        dev = DEVICE(&s->pmc.cframe[i]);
+
+        if (i < ARRAY_SIZE(cframe_cfg)) {
+            object_property_set_int(OBJECT(dev), "blktype0-frames",
+                                    cframe_cfg[i].blktype0_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype1-frames",
+                                    cframe_cfg[i].blktype1_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype2-frames",
+                                    cframe_cfg[i].blktype2_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype3-frames",
+                                    cframe_cfg[i].blktype3_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype4-frames",
+                                    cframe_cfg[i].blktype4_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype5-frames",
+                                    cframe_cfg[i].blktype5_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype6-frames",
+                                    cframe_cfg[i].blktype6_frames,
+                                    &error_abort);
+        }
+        object_property_set_link(OBJECT(dev), "cfu-fdro",
+                                 OBJECT(&s->pmc.cfu_fdro), &error_fatal);
+
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+
+        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].reg_base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].fdri_base,
+                                    sysbus_mmio_get_region(sbd, 1));
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate),
+                                            3 + i));
+    }
+
+    /* CFRAME BCAST */
+    object_initialize_child(OBJECT(s), "cframe_bcast", &s->pmc.cframe_bcast,
+                            TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
+
+    sbd = SYS_BUS_DEVICE(&s->pmc.cframe_bcast);
+    dev = DEVICE(&s->pmc.cframe_bcast);
+
+    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
+        g_autofree char *propname = g_strdup_printf("cframe%d", i);
+        object_property_set_link(OBJECT(dev), propname,
+                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
+    }
+
+    sysbus_realize(sbd, &error_fatal);
+
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_REG,
+                                sysbus_mmio_get_region(sbd, 0));
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_FDRI,
+                                sysbus_mmio_get_region(sbd, 1));
+
     /* CFU APB */
     object_initialize_child(OBJECT(s), "cfu-apb", &s->pmc.cfu_apb,
                             TYPE_XLNX_VERSAL_CFU_APB);
     sbd = SYS_BUS_DEVICE(&s->pmc.cfu_apb);
+    dev = DEVICE(&s->pmc.cfu_apb);
+
+    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
+        g_autofree char *propname = g_strdup_printf("cframe%d", i);
+        object_property_set_link(OBJECT(dev), propname,
+                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
+    }
 
     sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_APB,
-- 
2.34.1


