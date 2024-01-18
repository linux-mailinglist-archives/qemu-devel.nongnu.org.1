Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA02832050
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:11:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYfp-0003aP-GO; Thu, 18 Jan 2024 15:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfo-0003Zz-Eu
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfl-0006xi-Pt
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:36 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e87d07c07so316345e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608452; x=1706213252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hzkrmNX2ysOo1dkZvzaMS1RLQpmfGYrCHnlQkXBKNY=;
 b=O61rlZlnSJ6NDGybdm+SeQvJ8GyDRGMx9UHclh/QVs2SzJ6djnV2HL26INRbPFMsfw
 emCvipVuH7ouOrpw/b0OdOc18O/Mv+LrSR6UE7C8ezZtzYTyrtXKiqCjBKM8l0dpVsI3
 hUZsQNRiBq5SIqVW0ZEO45fH2iaM+npGLuk0TsdFsPZaDDd1IbYJS8ovhjZpMWZ4Uw+R
 mNlYBH93a9k/xjlDnnKpIIW3OlLHecXCCcYWpzwT1DT+72pkIZQngMVihHuJfHxphcU8
 AcQ4mT8//RN90Q+dnHKGMgBM1OHJOmFKUXWqn9HjQTvF3VpASftn2Nq0T1mqOblKb4dN
 qOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608452; x=1706213252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7hzkrmNX2ysOo1dkZvzaMS1RLQpmfGYrCHnlQkXBKNY=;
 b=ILSRRDVJZSsAiNG2hNGK5G3tauXXfkAs2gC2eWUt73CgUU62+Q1ixW4e99zmjZdFji
 V5zNMnJk4DpKyjXyxjKT13eFDSP+KVLXLZ7leQg4VyEXZ5frLEqtq10MazFEZcS+OOX4
 vkib2V+5y0PTnDU3DVaI5nHo4PcsMLk79FQJYi1BXwwjZk9+odckj4qrwVL3d8rDA35+
 MiiYxKUm+7kzmo3QXwv5NQHmJTJmVDtXX1E+MF4LmjLxmr5+g7obcPwsUCKvJNzr0aWZ
 sIN7TmxYF7ICznKVhK8Gluu6mkMerqE8cdRyDb454aUzGsJP0SVeT3pE7DSE8O6nwRks
 eHBg==
X-Gm-Message-State: AOJu0YwLtkwRAiyOUlmJP6VvPd3RdjizkGpLuzwgS6SmT2C1W8VVrHga
 A7ZLaSfRXCR1+ksTLKFuNc/795jGS4sD1OXuY833KRkRfWa3FGwdVnOqcuiSAZuLn4Vi4Gr1i12
 7WrkJk+kV
X-Google-Smtp-Source: AGHT+IGiWJ01PrIIpUtFykW2Sm2jPJBpTM7EVQ4g3zt9d/zBQ0Fzxr+ryLJVC7MuKfPrdUNpBb4ptA==
X-Received: by 2002:a05:600c:2116:b0:40e:85e9:742b with SMTP id
 u22-20020a05600c211600b0040e85e9742bmr919818wml.161.1705608452264; 
 Thu, 18 Jan 2024 12:07:32 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c499100b0040d6e07a147sm25843127wmp.23.2024.01.18.12.07.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 08/20] target/arm: Rename arm_cpu_mp_affinity
Date: Thu, 18 Jan 2024 21:06:29 +0100
Message-ID: <20240118200643.29037-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Rename to arm_build_mp_affinity.  This frees up the name for
other usage, and emphasizes that the cpu object is not involved.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h  | 2 +-
 hw/arm/npcm7xx.c  | 2 +-
 hw/arm/sbsa-ref.c | 2 +-
 hw/arm/virt.c     | 2 +-
 target/arm/cpu.c  | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ec276fcd57..55a19e8539 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1171,7 +1171,7 @@ void arm_cpu_post_init(Object *obj);
     (ARM_AFF0_MASK | ARM_AFF1_MASK | ARM_AFF2_MASK | ARM_AFF3_MASK)
 #define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
 
-uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
+uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz);
 
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_arm_cpu;
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 15ff21d047..7fb0a233b2 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -474,7 +474,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
         object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
-                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
+                                arm_build_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
                                 &error_abort);
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                 NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 477dca0637..b8857d1e9e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -148,7 +148,7 @@ static const int sbsa_ref_irqmap[] = {
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
 {
     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
-    return arm_cpu_mp_affinity(idx, clustersz);
+    return arm_build_mp_affinity(idx, clustersz);
 }
 
 static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2793121cb4..3fc144236b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1676,7 +1676,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
             clustersz = GICV3_TARGETLIST_BITS;
         }
     }
-    return arm_cpu_mp_affinity(idx, clustersz);
+    return arm_build_mp_affinity(idx, clustersz);
 }
 
 static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 826ce842c0..0bbba48faa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1307,7 +1307,7 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
+uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
 {
     uint32_t Aff1 = idx / clustersz;
     uint32_t Aff0 = idx % clustersz;
@@ -2113,8 +2113,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * so these bits always RAZ.
      */
     if (cpu->mp_affinity == ARM64_AFFINITY_INVALID) {
-        cpu->mp_affinity = arm_cpu_mp_affinity(cs->cpu_index,
-                                               ARM_DEFAULT_CPUS_PER_CLUSTER);
+        cpu->mp_affinity = arm_build_mp_affinity(cs->cpu_index,
+                                                 ARM_DEFAULT_CPUS_PER_CLUSTER);
     }
 
     if (cpu->reset_hivecs) {
-- 
2.41.0


