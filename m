Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B95D7DF8E5
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybed-0003CM-Qb; Thu, 02 Nov 2023 13:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeV-00038R-Rv
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:46 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeS-0002h7-KY
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:43 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c515527310so17091641fa.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946718; x=1699551518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I+vgPU4tOb8/bVT99xfNgupP4cOnz/a8+RCUWUXb08Y=;
 b=xsBUYtZ21QW2ODBNY2Anm9jX/PH+ONwkIppCMNI/ksUKJvG7CfKf+eo433CCrQGgPH
 pdbr5Z3rMDamxtSJufR62euZtgehM1E+IVx4kOUKL2v1l0TJwnF63cw2FooiptxJj2LQ
 pOZ43QugL5PkHT+HKI8AbRoR6Uo56vkaZwmIB6HxZFDxJeUwCNmW+RJm28pT+1qIvwF0
 jRdFxikuuAEf45HA9TvNvqdkw2IWX5bPFRisOXHZiH85HHW6C3OqvctYiWjq/BRfRQCx
 IeIL3oG3iDYy2uPVhbH4+SdlYNRzuYiep7LNpYVBOsuXmhZ7/m/oDDrgEnw4NMwUl7Zm
 KsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946718; x=1699551518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+vgPU4tOb8/bVT99xfNgupP4cOnz/a8+RCUWUXb08Y=;
 b=WNoHuDFO3Zgi/VCA8/a2MaRL+WY1i94/A1AOZIcdL6sqpCNXM6mf80MQ5BoLmQkmcw
 EPSEuZLEoHewoDqfOMaRRWekFF7qSG4TL0dh27h0oWC92hWEGAFE0gafzs/mBuDd12Fn
 TDzNLBdqitEn3xcDCxvrJ8CD2pBU+dKupn1PvzIzmaehWgUH867vj/ylvWMiPUt8te/j
 Zmup/lDTG6uvpOP83pGcWFXYKcnUNIHkaB22S8JCCltCxxhk9ZcMcAC/G9tNHDDoUHr4
 5uVTDsB/Mam50UJyFvZ0JliiQYBiqYiqSirNUfl7MkP+otzYGceDsXamHP28WI1ZVt/y
 mWEg==
X-Gm-Message-State: AOJu0Yx5TItuauKVNuLbriBV7JwpQsvwG2O9mxCvqwTm0/ByXPE9Qa6c
 tC0cf0y5W8Ag4LGw6ec26UAMVfL1eBWtTu1lVXM=
X-Google-Smtp-Source: AGHT+IGP2MWxwvu5jGpX9+6HIFl/Jo2YngssnLMQ2otnJutndv35lU28Jy8U4MGyDVMl9oJmXwvBeg==
X-Received: by 2002:a2e:9410:0:b0:2c4:fe14:a85 with SMTP id
 i16-20020a2e9410000000b002c4fe140a85mr17240272ljh.18.1698946717764; 
 Thu, 02 Nov 2023 10:38:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/33] linux-user/elfload: Add missing arm64 hwcap values
Date: Thu,  2 Nov 2023 17:38:03 +0000
Message-Id: <20231102173835.609985-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

From: Marielle Novastrider <marielle@novastrider.com>

Specifically DIT, LSE2, and MTE3.

We already expose detection of these via the CPUID interface, but
missed these from ELF hwcaps.

Signed-off-by: Marielle Novastrider <marielle@novastrider.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231029210058.38986-1-marielle@novastrider.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fixed conflict with feature tests moving to cpu-features.h]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 linux-user/elfload.c      | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 66212cd7ecc..954d3582685 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -669,6 +669,11 @@ static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
 }
 
+static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 3;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8761f9e26b8..3f3975352af 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -800,12 +800,14 @@ uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
     GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
     GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_lse2, ARM_HWCAP_A64_USCAT);
     GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
     GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
     GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
     GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
     GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
+    GET_FEATURE_ID(aa64_dit, ARM_HWCAP_A64_DIT);
     GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
@@ -839,6 +841,7 @@ uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_rndr, ARM_HWCAP2_A64_RNG);
     GET_FEATURE_ID(aa64_bti, ARM_HWCAP2_A64_BTI);
     GET_FEATURE_ID(aa64_mte, ARM_HWCAP2_A64_MTE);
+    GET_FEATURE_ID(aa64_mte3, ARM_HWCAP2_A64_MTE3);
     GET_FEATURE_ID(aa64_sme, (ARM_HWCAP2_A64_SME |
                               ARM_HWCAP2_A64_SME_F32F32 |
                               ARM_HWCAP2_A64_SME_B16F32 |
-- 
2.34.1


