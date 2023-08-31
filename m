Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423D78EAF7
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:47:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBK-0003qj-I9; Thu, 31 Aug 2023 06:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfBD-0003gT-96
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB7-00045O-8x
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401b5516104so5828945e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478730; x=1694083530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7younOAESMSGZRgRGk0G3tpzN8Y0x16KvD+mTonKpbs=;
 b=jIVKcokWZDG/z0njsF5GL2nenq/XvHilXAy+unwkzoROPmPtQ+1h7mCI8pwQF4I3Ai
 Y8TVcEtqhHHRjpiYGFt9ze0rQV5j0GUrADgSdcwJl6DGcA22dvzpCODzzm5YvFhhyw7v
 pTpsy8vNG8BEJo64MLhac2KBJTsUsFsUPQZy+QFr5+iSSQ/LfaqoLvv+tjM81WG5zUmq
 NGphtBt3U1Vh3HkhlaN8osWmW+1wS+3NMTWl3W2sExyvUFGUqtq9IEm1ZTjshw8izXeV
 HX2NhQllfjSqXVXgg692HEi2KXz/RssTDw0UA61/rsPoY/gs65vY2tTn7RGzx+lOuGeg
 W6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478730; x=1694083530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7younOAESMSGZRgRGk0G3tpzN8Y0x16KvD+mTonKpbs=;
 b=dz+iMM9HRgAnemk3QCqTEL5mVxBcTDjsgXf1j8PbxldaP49cXfAf2P+yKvp1yOR+B6
 fMMpybahudhNtq9KkOg5p1NJe0Dy5FPL7ruEQwsABjQWmLe9defORDzXwW6usZbtfDNa
 g1teX2woKUwNJ56bk66hkRdtoiaq7jgtsG/telBo96vudCgyKyvfJTyAVXTIkSrhhOy1
 PHDv0mlABrU2SjBeeDZVeSZj3Jz6axHGhH2h/aKMmGnnyXKbUTG2apEBAWYHZQu6NhWY
 E/o4eBf0WaJEPESUv1xXcWelDZv4XJbM8k59Jb4wdgu9sWD3MJS7fwfrFklyRtY3J5/k
 7AKA==
X-Gm-Message-State: AOJu0YySniL32OKG4Pel2Jy+uOCkUyVEC91W88+6Y8i00kgVineHpSXx
 bjYuciAcdMQjmBasafkTwbS5u2B/gUuoLhoO8RE=
X-Google-Smtp-Source: AGHT+IEV7dtCNFR8xICoW/KiZGwQqNVfi1UEgLj4lV1puSY4Ivsvtz1h8qZhZPweNdy4QVESZ7OzOA==
X-Received: by 2002:a05:600c:3655:b0:401:b3a5:ec03 with SMTP id
 y21-20020a05600c365500b00401b3a5ec03mr3740108wmq.1.1693478730639; 
 Thu, 31 Aug 2023 03:45:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] hw/arm/armv7m: Add mpu-ns-regions and mpu-s-regions
 properties
Date: Thu, 31 Aug 2023 11:45:18 +0100
Message-Id: <20230831104519.3520658-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

M-profile CPUs generally allow configuration of the number of MPU
regions that they have.  We don't currently model this, so our
implementations of some of the board models provide CPUs with the
wrong number of regions.  RTOSes like Zephyr that hardcode the
expected number of regions may therefore not run on the model if they
are set up to run on real hardware.

Add properties mpu-ns-regions and mpu-s-regions to the ARMV7M object,
matching the ability of hardware to configure the number of Secure
and NonSecure regions separately.  Our actual CPU implementation
doesn't currently support that, and it happens that none of the MPS
boards we model set the number of regions differently for Secure vs
NonSecure, so we provide an interface to the boards and SoCs that
won't need to change if we ever do add that functionality in future,
but make it an error to configure the two properties to different
values.

(The property name on the CPU is the somewhat misnamed-for-M-profile
"pmsav7-dregion", so we don't follow that naming convention for
the properties here. The TRM doesn't say what the CPU configuration
variable names are, so we pick something, and follow the lowercase
convention we already have for properties here.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230724174335.2150499-3-peter.maydell@linaro.org
---
 include/hw/arm/armv7m.h |  8 ++++++++
 hw/arm/armv7m.c         | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index b7ba0ff409c..e2cebbd15c0 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -52,6 +52,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(ARMv7MState, ARMV7M)
  * + Property "vfp": enable VFP (forwarded to CPU object)
  * + Property "dsp": enable DSP (forwarded to CPU object)
  * + Property "enable-bitband": expose bitbanded IO
+ * + Property "mpu-ns-regions": number of Non-Secure MPU regions (forwarded
+ *   to CPU object pmsav7-dregion property; default is whatever the default
+ *   for the CPU is)
+ * + Property "mpu-s-regions": number of Secure MPU regions (default is
+ *   whatever the default for the CPU is; must currently be set to the same
+ *   value as mpu-ns-regions if the CPU implements the Security Extension)
  * + Clock input "refclk" is the external reference clock for the systick timers
  * + Clock input "cpuclk" is the main CPU clock
  */
@@ -95,6 +101,8 @@ struct ARMv7MState {
     Object *idau;
     uint32_t init_svtor;
     uint32_t init_nsvtor;
+    uint32_t mpu_ns_regions;
+    uint32_t mpu_s_regions;
     bool enable_bitband;
     bool start_powered_off;
     bool vfp;
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 50a9507c0bd..bf173b10b8b 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -334,6 +334,25 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /*
+     * Real M-profile hardware can be configured with a different number of
+     * MPU regions for Secure vs NonSecure. QEMU's CPU implementation doesn't
+     * support that yet, so catch attempts to select that.
+     */
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY) &&
+        s->mpu_ns_regions != s->mpu_s_regions) {
+        error_setg(errp,
+                   "mpu-ns-regions and mpu-s-regions properties must have the same value");
+        return;
+    }
+    if (s->mpu_ns_regions != UINT_MAX &&
+        object_property_find(OBJECT(s->cpu), "pmsav7-dregion")) {
+        if (!object_property_set_uint(OBJECT(s->cpu), "pmsav7-dregion",
+                                      s->mpu_ns_regions, errp)) {
+            return;
+        }
+    }
+
     /*
      * Tell the CPU where the NVIC is; it will fail realize if it doesn't
      * have one. Similarly, tell the NVIC where its CPU is.
@@ -530,6 +549,8 @@ static Property armv7m_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vfp", ARMv7MState, vfp, true),
     DEFINE_PROP_BOOL("dsp", ARMv7MState, dsp, true),
+    DEFINE_PROP_UINT32("mpu-ns-regions", ARMv7MState, mpu_ns_regions, UINT_MAX),
+    DEFINE_PROP_UINT32("mpu-s-regions", ARMv7MState, mpu_s_regions, UINT_MAX),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


