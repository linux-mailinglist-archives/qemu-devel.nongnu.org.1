Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB88AB5BA7
	for <lists+qemu-devel@lfdr.de>; Tue, 13 May 2025 19:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtkT-0002ho-HY; Tue, 13 May 2025 13:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcp-0000uB-AO
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:41:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcl-0003Rb-2p
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:41:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso45440485e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158055; x=1747762855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mc5S9P/50U+uOhuImq7ntWk/pRQZs10UmelyfyrMZ/I=;
 b=XtMiMzbiW37jSEUA7c/VQb+J1gZozMwDIkBcgt5URMFBmPyzIdkkmhlQzPA8P4buWm
 1b/BTe7GSaLNACC9+haMtbu5paHvtEa2yRuDTUC6lTX2Uhh7fuVBC4r/p87PCINFZBP0
 sLm252opMS9OVXy+0kCMT+VTBkZ2MBZt9JOwIJsTJtpg1b4H0Fauh2S0Ih7xp+DfSr/+
 OUrZb1A8otzlgKN0M3DKoV5xR4wATJw0MG46n0usKHrHB2HaKEIl4ZiE2RzUT9etVOXj
 f62VbZ7L5RaJHP2ZO2lhaLgHiz0FdA2nYrrSewiTLobYVm9xLRyj2rfHLhjZVuyVmy+X
 5f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158055; x=1747762855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mc5S9P/50U+uOhuImq7ntWk/pRQZs10UmelyfyrMZ/I=;
 b=Nsembdd6fmMHLFO+cKcWjwg2o4fEqfQHr87H1VK7FtZ3i95loiIMRGKczGJaOPt7IT
 SaMsjAmGrXYcffs+kLRCPkek0o4CLpQC3kXjWxyQPJjYvqgCHSHdWzGvULwlD4Ze3J3S
 5wrKF8NyaVKRX2TcZy8rNXfOELTNXP0OBTpQczrndyyWlbNf4YSbNb5qsvMG/9eufbuk
 7+8SPm4UvxwaznhFtaG8faMkgKY90ogj+HruLdkAYHBBM4vc6M/EwEU14UrFqHtWIMBf
 nYCE7X1Mx358hkwJqjf6CRUxcUV65rAKXOzBHJFUxdn7aouo9apy5c/DKyfBLkEvE+QI
 E2vQ==
X-Gm-Message-State: AOJu0Yy3a+U9wdWQPIfJ2L5q1rmMJ9Dk9YzROsTD0KJ/MFjjd93SWHh+
 WNAhD9QWvNbYElSiZ/lzAjJch0saArY52tJxnMK18zOU5pd+3xFc3yNSSF3Iswl5E4hdBUsOk03
 6Q8U=
X-Gm-Gg: ASbGnctJCEvZiiHfPCz9zwmUehbFKUJ9pNS3tBeLqHGbdZO63U5BqIsbwb3+sWv59+w
 Y13/s1Q7vzDW/c0xe+7fHAG8MwpqA9kQVMG3KMWQUZZN7gM/BD0fvv2bO+2QZ1Bz/cIyroxnTRL
 s2AK4XiHG8zbF3LC5ylUD/j5v4K+rSSw3/NgKsgdXzepkuwIf1bzOSppl4ura4rLGjC1ADcSTzi
 e9vJ1dfWmcZD6srMN1aeDtxpChZhgzqL+Z9q4SCyK5cdXFH/cdQDgPjjmDKyGgLWtXnyZROqy2j
 /tYua/TNAg8FpIsJ98UY/FFrRGvn7+qaU/wCMU4E07vphSDy+GwcaOvxCvQugjVLGn11OAd8oUv
 qd6P5UdcTsHyLSNnA+5xmbJjwPUgU
X-Google-Smtp-Source: AGHT+IFLkgkIv806lDoC0d/3pkBhRsCUuWsFWcI2Ig5dVmkTiEYxRrQWCewkvd7DKokGo8OSpMKw7A==
X-Received: by 2002:a05:600c:6308:b0:441:b3f0:e5f6 with SMTP id
 5b1f17b1804b1-442f215dcc7mr1737495e9.25.1747158054951; 
 Tue, 13 May 2025 10:40:54 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d7795sm181970525e9.8.2025.05.13.10.40.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:40:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/19] hw/arm/realview: Replace arm_feature() ->
 arm_cpu_has_feature()
Date: Tue, 13 May 2025 18:39:26 +0100
Message-ID: <20250513173928.77376-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

By using arm_cpu_has_feature() instead of arm_feature()
we don't need to include "cpu.h" anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/realview.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 5c9050490b4..4c0a8b42709 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -9,7 +9,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
@@ -31,6 +30,7 @@
 #include "hw/sd/sd.h"
 #include "audio/audio.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu_has_feature.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
@@ -77,7 +77,6 @@ static void realview_init(MachineState *machine,
                           enum realview_board_type board_type)
 {
     ARMCPU *cpu = NULL;
-    CPUARMState *env;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram_lo;
     MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
@@ -138,16 +137,15 @@ static void realview_init(MachineState *machine,
         cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpuobj), ARM_CPU_IRQ);
     }
     cpu = ARM_CPU(first_cpu);
-    env = &cpu->env;
-    if (arm_feature(env, ARM_FEATURE_V7)) {
+    if (arm_cpu_has_feature(cpu, ARM_FEATURE_V7)) {
         if (is_mpcore) {
             proc_id = 0x0c000000;
         } else {
             proc_id = 0x0e000000;
         }
-    } else if (arm_feature(env, ARM_FEATURE_V6K)) {
+    } else if (arm_cpu_has_feature(cpu, ARM_FEATURE_V6K)) {
         proc_id = 0x06000000;
-    } else if (arm_feature(env, ARM_FEATURE_V6)) {
+    } else if (arm_cpu_has_feature(cpu, ARM_FEATURE_V6)) {
         proc_id = 0x04000000;
     } else {
         proc_id = 0x02000000;
-- 
2.47.1


