Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABC7723E3F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:50:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIq-0007hV-7E; Tue, 06 Jun 2023 05:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0007e1-VP
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIe-0004lF-Si
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3094910b150so6000280f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044903; x=1688636903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YcEuFjoJrq6egajLntzeA2rvMcSnJn/H54JwZEGh+p4=;
 b=Cxy96wHG1TsPsicBehBZhKJykM0uFzfJnYBORgozQ7gncJ/7X68Hz+er5mETWvGGJN
 6lLhxqJ7q/K5gLxqRWDcbp11DRVNnhXalrlAhIWdVPTzdoHxNTW6g83UPfGlalWSRs0o
 u0EnAhNFLkPH4FwUXQTdbK9jvBOXT2A2m2RggZtOJsfUr5jJR8pUcZUE5hcAK2ny9uE0
 fB9YD5CBYVg6mYHaGyqVxWEfWedhd2JoEsuyjUJNexpAiK6EEAabSMJmiHae86paA8nD
 q8juhZkgRcmr0H7m7mqyEUQZGoglUelJleAEP/jb/fNVLeAC7AHPSmQFHqF2CFb6FyS8
 fYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044903; x=1688636903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcEuFjoJrq6egajLntzeA2rvMcSnJn/H54JwZEGh+p4=;
 b=hrO4/nSUFSjPKnKpN2380mH/EP7Dj0bRCJMIW0Xnxs3fzB/EE2GWVUwp8I11Zfcj7j
 gJqj/DtGJ5LvyGSYXe2mNw3VhmxhK+Ain8uVqwi99qrEI9uGaGf+dsLu2mG7B+hShteY
 9oEGgoULqlYNthTapCyJOWWBw2C+MjuxMCqbWPUn1IYDq4UC8ADnxmZ/IefWX3yWhLMy
 jAjxAnoQJifMOWCO65MvCnWzREOXZ73cUINWzh5K3coV8VLY0X0o+Kxlsvxn3R/vHFGJ
 b6fZk66QXWlUt963wz2nJz361RWu7n9dnc/ZebqPldya7LNwI5XhyFjp7eqA1vedMzle
 F1dg==
X-Gm-Message-State: AC+VfDwqzq1gPJWH8ToBAS3W8ckeneYFWZxXcqg0petGWvoaoAYqwqUy
 Ii61eTDxKGeXqt0jaXfYnrg+iI7+WoCc1E+zeOY=
X-Google-Smtp-Source: ACHHUZ63E6g0yaIzT2t88q1MHAopekdQg9zgtMqVHQewfTGNzhY3Ag0WQz4nUzrEWb5RO0o2U9+l3A==
X-Received: by 2002:a05:6000:1112:b0:30e:5282:8d34 with SMTP id
 z18-20020a056000111200b0030e52828d34mr400870wrw.71.1686044903638; 
 Tue, 06 Jun 2023 02:48:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/42] hw: sd: allwinner-sdhost: Add sun50i-a64 SoC support
Date: Tue,  6 Jun 2023 10:47:47 +0100
Message-Id: <20230606094814.3581397-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: qianfan Zhao <qianfanguijin@163.com>

A64's sd register was similar to H3, and it introduced a new register
named SAMP_DL_REG location at 0x144. The dma descriptor buffer size of
mmc2 is only 8K and the other mmc controllers has 64K.

Also fix allwinner-r40's mmc controller type.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/allwinner-sdhost.h |  9 ++++
 hw/arm/allwinner-r40.c           |  2 +-
 hw/sd/allwinner-sdhost.c         | 72 ++++++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/include/hw/sd/allwinner-sdhost.h b/include/hw/sd/allwinner-sdhost.h
index 30c1e604041..1b951177dda 100644
--- a/include/hw/sd/allwinner-sdhost.h
+++ b/include/hw/sd/allwinner-sdhost.h
@@ -38,6 +38,12 @@
 /** Allwinner sun5i family and newer (A13, H2+, H3, etc) */
 #define TYPE_AW_SDHOST_SUN5I TYPE_AW_SDHOST "-sun5i"
 
+/** Allwinner sun50i-a64 */
+#define TYPE_AW_SDHOST_SUN50I_A64 TYPE_AW_SDHOST "-sun50i-a64"
+
+/** Allwinner sun50i-a64 emmc */
+#define TYPE_AW_SDHOST_SUN50I_A64_EMMC  TYPE_AW_SDHOST "-sun50i-a64-emmc"
+
 /** @} */
 
 /**
@@ -110,6 +116,7 @@ struct AwSdHostState {
     uint32_t startbit_detect;   /**< eMMC DDR Start Bit Detection Control */
     uint32_t response_crc;      /**< Response CRC */
     uint32_t data_crc[8];       /**< Data CRC */
+    uint32_t sample_delay;      /**< Sample delay control */
     uint32_t status_crc;        /**< Status CRC */
 
     /** @} */
@@ -132,6 +139,8 @@ struct AwSdHostClass {
     size_t max_desc_size;
     bool   is_sun4i;
 
+    /** does the IP block support autocalibration? */
+    bool can_calibrate;
 };
 
 #endif /* HW_SD_ALLWINNER_SDHOST_H */
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 0e4542d35f2..b148c564498 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -271,7 +271,7 @@ static void allwinner_r40_init(Object *obj)
 
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
         object_initialize_child(obj, mmc_names[i], &s->mmc[i],
-                                TYPE_AW_SDHOST_SUN5I);
+                                TYPE_AW_SDHOST_SUN50I_A64);
     }
 
     object_initialize_child(obj, "twi0", &s->i2c0, TYPE_AW_I2C_SUN6I);
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index 92a0f42708d..286e0095098 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -77,6 +77,7 @@ enum {
     REG_SD_DATA1_CRC  = 0x12C, /* CRC Data 1 from card/eMMC */
     REG_SD_DATA0_CRC  = 0x130, /* CRC Data 0 from card/eMMC */
     REG_SD_CRC_STA    = 0x134, /* CRC status from card/eMMC during write */
+    REG_SD_SAMP_DL    = 0x144, /* Sample Delay Control (sun50i-a64) */
     REG_SD_FIFO       = 0x200, /* Read/Write FIFO */
 };
 
@@ -158,6 +159,7 @@ enum {
     REG_SD_RES_CRC_RST      = 0x0,
     REG_SD_DATA_CRC_RST     = 0x0,
     REG_SD_CRC_STA_RST      = 0x0,
+    REG_SD_SAMPLE_DL_RST    = 0x00002000,
     REG_SD_FIFO_RST         = 0x0,
 };
 
@@ -459,6 +461,7 @@ static uint64_t allwinner_sdhost_read(void *opaque, hwaddr offset,
 {
     AwSdHostState *s = AW_SDHOST(opaque);
     AwSdHostClass *sc = AW_SDHOST_GET_CLASS(s);
+    bool out_of_bounds = false;
     uint32_t res = 0;
 
     switch (offset) {
@@ -577,13 +580,24 @@ static uint64_t allwinner_sdhost_read(void *opaque, hwaddr offset,
     case REG_SD_FIFO:      /* Read/Write FIFO */
         res = allwinner_sdhost_fifo_read(s);
         break;
+    case REG_SD_SAMP_DL: /* Sample Delay */
+        if (sc->can_calibrate) {
+            res = s->sample_delay;
+        } else {
+            out_of_bounds = true;
+        }
+        break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
-                      HWADDR_PRIx"\n", __func__, offset);
+        out_of_bounds = true;
         res = 0;
         break;
     }
 
+    if (out_of_bounds) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
+                      HWADDR_PRIx"\n", __func__, offset);
+    }
+
     trace_allwinner_sdhost_read(offset, res, size);
     return res;
 }
@@ -602,6 +616,7 @@ static void allwinner_sdhost_write(void *opaque, hwaddr offset,
 {
     AwSdHostState *s = AW_SDHOST(opaque);
     AwSdHostClass *sc = AW_SDHOST_GET_CLASS(s);
+    bool out_of_bounds = false;
 
     trace_allwinner_sdhost_write(offset, value, size);
 
@@ -725,10 +740,21 @@ static void allwinner_sdhost_write(void *opaque, hwaddr offset,
     case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
     case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write operation */
         break;
+    case REG_SD_SAMP_DL: /* Sample delay control */
+        if (sc->can_calibrate) {
+            s->sample_delay = value;
+        } else {
+            out_of_bounds = true;
+        }
+        break;
     default:
+        out_of_bounds = true;
+        break;
+    }
+
+    if (out_of_bounds) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
                       HWADDR_PRIx"\n", __func__, offset);
-        break;
     }
 }
 
@@ -777,6 +803,7 @@ static const VMStateDescription vmstate_allwinner_sdhost = {
         VMSTATE_UINT32(response_crc, AwSdHostState),
         VMSTATE_UINT32_ARRAY(data_crc, AwSdHostState, 8),
         VMSTATE_UINT32(status_crc, AwSdHostState),
+        VMSTATE_UINT32(sample_delay, AwSdHostState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -815,6 +842,7 @@ static void allwinner_sdhost_realize(DeviceState *dev, Error **errp)
 static void allwinner_sdhost_reset(DeviceState *dev)
 {
     AwSdHostState *s = AW_SDHOST(dev);
+    AwSdHostClass *sc = AW_SDHOST_GET_CLASS(s);
 
     s->global_ctl = REG_SD_GCTL_RST;
     s->clock_ctl = REG_SD_CKCR_RST;
@@ -855,6 +883,10 @@ static void allwinner_sdhost_reset(DeviceState *dev)
     }
 
     s->status_crc = REG_SD_CRC_STA_RST;
+
+    if (sc->can_calibrate) {
+        s->sample_delay = REG_SD_SAMPLE_DL_RST;
+    }
 }
 
 static void allwinner_sdhost_bus_class_init(ObjectClass *klass, void *data)
@@ -879,6 +911,7 @@ static void allwinner_sdhost_sun4i_class_init(ObjectClass *klass, void *data)
     AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
     sc->max_desc_size = 8 * KiB;
     sc->is_sun4i = true;
+    sc->can_calibrate = false;
 }
 
 static void allwinner_sdhost_sun5i_class_init(ObjectClass *klass, void *data)
@@ -886,6 +919,25 @@ static void allwinner_sdhost_sun5i_class_init(ObjectClass *klass, void *data)
     AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
     sc->max_desc_size = 64 * KiB;
     sc->is_sun4i = false;
+    sc->can_calibrate = false;
+}
+
+static void allwinner_sdhost_sun50i_a64_class_init(ObjectClass *klass,
+                                                   void *data)
+{
+    AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
+    sc->max_desc_size = 64 * KiB;
+    sc->is_sun4i = false;
+    sc->can_calibrate = true;
+}
+
+static void allwinner_sdhost_sun50i_a64_emmc_class_init(ObjectClass *klass,
+                                                        void *data)
+{
+    AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
+    sc->max_desc_size = 8 * KiB;
+    sc->is_sun4i = false;
+    sc->can_calibrate = true;
 }
 
 static const TypeInfo allwinner_sdhost_info = {
@@ -910,6 +962,18 @@ static const TypeInfo allwinner_sdhost_sun5i_info = {
     .class_init    = allwinner_sdhost_sun5i_class_init,
 };
 
+static const TypeInfo allwinner_sdhost_sun50i_a64_info = {
+    .name          = TYPE_AW_SDHOST_SUN50I_A64,
+    .parent        = TYPE_AW_SDHOST,
+    .class_init    = allwinner_sdhost_sun50i_a64_class_init,
+};
+
+static const TypeInfo allwinner_sdhost_sun50i_a64_emmc_info = {
+    .name          = TYPE_AW_SDHOST_SUN50I_A64_EMMC,
+    .parent        = TYPE_AW_SDHOST,
+    .class_init    = allwinner_sdhost_sun50i_a64_emmc_class_init,
+};
+
 static const TypeInfo allwinner_sdhost_bus_info = {
     .name = TYPE_AW_SDHOST_BUS,
     .parent = TYPE_SD_BUS,
@@ -922,6 +986,8 @@ static void allwinner_sdhost_register_types(void)
     type_register_static(&allwinner_sdhost_info);
     type_register_static(&allwinner_sdhost_sun4i_info);
     type_register_static(&allwinner_sdhost_sun5i_info);
+    type_register_static(&allwinner_sdhost_sun50i_a64_info);
+    type_register_static(&allwinner_sdhost_sun50i_a64_emmc_info);
     type_register_static(&allwinner_sdhost_bus_info);
 }
 
-- 
2.34.1


