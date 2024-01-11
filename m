Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D40582ACE3
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:08:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssU-0001Rb-6n; Thu, 11 Jan 2024 06:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssL-0001PP-IU
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssH-0004Xm-UR
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3374eb61cbcso4674300f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971123; x=1705575923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WQZ9joUzytLik4j8W+c4JeBQFuz0jyAB3AYXVmNfQ3M=;
 b=yIFQmENbNTkWx9E2R+KHebFYaEm+GKWSKrT6/F8Pk6QqtGh/g+Ky1Edk2yw8s778Li
 I5KT9Xaft6O3AeuWzVM+Rcik4k1RYAlniiGpCUZBBFqv6dNweclKb6U/43tq5tOMJvbu
 aR2bnjUtxPUEqSDStwGZ7N/FGqlfLBPl783GAYydf2z0N9FwlWUQwk1DUSr6o88d9Ep2
 p6BH/kWmqLVFkn6i9jbSHoCbrATdV0xYNtS42Rv4UADckzCTPPOsovcjKLMFuDFT1+xU
 yw5dLN5oyPSKbj4qjz5TjPJQi4IwVrmwwXuojzwUVoINYysch2VNelbh79uNxqn7RqZO
 ZLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971123; x=1705575923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQZ9joUzytLik4j8W+c4JeBQFuz0jyAB3AYXVmNfQ3M=;
 b=RknYjNfVR/3nPoyFnEezSkb7LMsEUANfsVWLjdezdTqFPOkzDuekP97K1vstPwxGN+
 8g+uvPBoOkROxdT2HFiER0/ZgJg86XYz9GmcgxJTnG8oRS2KBgmgVarBIoZy+4J0eddq
 IaG5mGbvKGj3/KwaCW+7qe3fwImPQ6HrQqXzoUdoHg/1MjxrQn62KlroHgeSbZbPbshO
 sb66XPRp12q3Yt5vWk1LuIMw/fA+fei3nxyvxZLV5YxT2h82AIBW1MVbxDVZBc5TI2Fj
 p0rizatqSr005CM/zydI9EiFBJrFOhM2H/NHCIpFs2AEhW5NPjs5Kkn9Axa6Eviy8F8b
 mdPg==
X-Gm-Message-State: AOJu0YwXgay7WywqPWUkkjzON2J7nvn1EVoxKlKsJogYDKlYDrgvNonO
 SvRri8J//7pfHLfFWXYmfxgc4fNkrZWykZKHAMFDs8vbbi0=
X-Google-Smtp-Source: AGHT+IFUI6h5Hgo4RLVvwOug8Mr6DG68K3Z2IiQH7X28Yr3RZZxpKznqaBgX4JQSZHb28NilUFYm/g==
X-Received: by 2002:adf:ec48:0:b0:337:61e3:7421 with SMTP id
 w8-20020adfec48000000b0033761e37421mr546032wrn.44.1704971123589; 
 Thu, 11 Jan 2024 03:05:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] hw/intc/arm_gicv3_cpuif: Mark up VNCR offsets for GIC
 CPU registers
Date: Thu, 11 Jan 2024 11:05:02 +0000
Message-Id: <20240111110505.1563291-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
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

Mark up the cpreginfo structs for the GIC CPU registers to indicate
the offsets from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ
in the Arm ARM.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 hw/intc/arm_gicv3_cpuif.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 6ac90536402..e1a60d8c15b 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2684,6 +2684,7 @@ static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
     { .name = "ICH_AP0R0_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 0,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x480,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2691,6 +2692,7 @@ static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
     { .name = "ICH_AP1R0_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 0,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4a0,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2698,6 +2700,7 @@ static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
     { .name = "ICH_HCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 0,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4c0,
       .access = PL2_RW,
       .readfn = ich_hcr_read,
       .writefn = ich_hcr_write,
@@ -2729,6 +2732,7 @@ static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
     { .name = "ICH_VMCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 7,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4c8,
       .access = PL2_RW,
       .readfn = ich_vmcr_read,
       .writefn = ich_vmcr_write,
@@ -2739,6 +2743,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr1_reginfo[] = {
     { .name = "ICH_AP0R1_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x488,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2746,6 +2751,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr1_reginfo[] = {
     { .name = "ICH_AP1R1_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4a8,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2756,6 +2762,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     { .name = "ICH_AP0R2_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 2,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x490,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2763,6 +2770,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     { .name = "ICH_AP0R3_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 3,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x498,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2770,6 +2778,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     { .name = "ICH_AP1R2_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 2,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4b0,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2777,6 +2786,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     { .name = "ICH_AP1R3_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 3,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4b8,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2898,6 +2908,7 @@ void gicv3_init_cpuif(GICv3State *s)
                       .opc0 = 3, .opc1 = 4, .crn = 12,
                       .crm = 12 + (j >> 3), .opc2 = j & 7,
                       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                      .nv2_redirect_offset = 0x400 + 8 * j,
                       .access = PL2_RW,
                       .readfn = ich_lr_read,
                       .writefn = ich_lr_write,
-- 
2.34.1


