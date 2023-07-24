Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DDD75FE20
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzb5-0007CI-V6; Mon, 24 Jul 2023 13:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNzay-00079q-BX
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:43:46 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNzau-0004GR-QZ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:43:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so99056f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690220619; x=1690825419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v36Ezb822ebJ8nd5Azc7yBmOGNwXjSOF/9RPfNN4WmQ=;
 b=Bf7WG1sXXT6q82/+PGokC704KywPdQ7nl/CWmQ2uoivskvpTMUymGKWAk3ofh26Beg
 0CE9VMtn5zFXmUNoP3MFOfcii/sWJE3mWlwj/3ITKdZ+uMFioJYbLnO25mplzf/GTaDj
 pGHDYb3mD8f5cEG4/eE5HDaRETnhx83plARmV1j5dgTa7tdBWrWuAym8R+KRTCZh0fgk
 Ls0yGj+MfiO9r0TGPjSRL36UZeVltYfHbb7diFL9Ra87JztrYA0+1pLVpEBdjrqWUPG7
 UfYK6v4eaJbE2F1IRkC89t3HpzusVkuNfFhOg+iW80y3YpHmRo8ngffpTB/IcW9aSrd5
 fYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690220619; x=1690825419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v36Ezb822ebJ8nd5Azc7yBmOGNwXjSOF/9RPfNN4WmQ=;
 b=CXGsjCGak7rk+L4wgtDsDwKTYfEJympGbkM/wS/I/MrRtIJECeWYJzysYTv4XqipUf
 7xy1Xiz8kB71zc/NdFO/ULPEfSB3H6BWt99Cbcn6bDvejPiFUgTi4iu5Zono49rbfmQu
 zIrREK/quwsPkZK8ZupeCiAJZBREkqCG12exrEHDyDjOJsyHtCzVQvpxydJi+qTEB+DB
 gp0FVO3mv5MV4r7xc/1UhCD1jTyDPCfrb6GzEROw/prl7GeLOvtBwsBjej3hEi4ZK61d
 HwA+KArjb4KR7H/qwhYgA4nRyss28eAmVb7JrE0vQtobqvUDrFN/jqsIYuQkJwO4r9Ox
 0tXg==
X-Gm-Message-State: ABy/qLYwtRlZxyFdnMfkTHK+WkAX0ToonRBAvYP8PkyKVpWCEDS83rNv
 33/2JDq5G1mifNjXIEz1n+QVTzADWUVpRmhruRk=
X-Google-Smtp-Source: APBJJlEQO3qELQ1GSkzGOfDuG9n2WC4RU3J2XFN0fP0MWlMYTucHStf+R3FSfb31bq58pQI9DPSd3A==
X-Received: by 2002:adf:f701:0:b0:317:3d36:b2cd with SMTP id
 r1-20020adff701000000b003173d36b2cdmr5808341wrp.71.1690220618737; 
 Mon, 24 Jul 2023 10:43:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a0560001b0300b0030e52d4c1bcsm13687423wrz.71.2023.07.24.10.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 10:43:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.2 2/3] hw/arm/armv7m: Add mpu-ns-regions and
 mpu-s-regions properties
Date: Mon, 24 Jul 2023 18:43:34 +0100
Message-Id: <20230724174335.2150499-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724174335.2150499-1-peter.maydell@linaro.org>
References: <20230724174335.2150499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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


