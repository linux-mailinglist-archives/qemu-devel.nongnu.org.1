Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D607799B5
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsJ-0003Cv-J9; Fri, 11 Aug 2023 17:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsH-0003Ai-7B
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:49 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-00029B-Ga
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:48 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-564af0ac494so1591059a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790042; x=1692394842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyazxeEkqj9Hcr039Rs95Pk/TkvjVIVgvCNYykbHWYI=;
 b=cYIWAf1VrnPUZit5NfPgjARzwLoPXvsDf3X2IcTXFCm1QPQPUCH+vY6emUY5nyoToC
 ZeUWZGH+zrMpJxEvDOlDNYcRAbbCHRmvng4KAW9qa/n2adH5VANOmaYaQ4dNo76Vv/z9
 TSUaZYPG/gH1zqc2nKpyF1p0fUczbRdwYAmAXScYNPGvDV+UPWaeQW2fM2gvAXVTtVD5
 75pCllzbVLJENlzauBniTaCDX26isrspjWp3XrwPQjGB11ecOPX89qPAr90z+GHhrs/i
 mKyMiM3fvoGfVoXjqyyehkyDRFm2rB39w9I/JciPwbIqKP0pbcreVXzoe87Xi9aIxZuM
 OItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790042; x=1692394842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyazxeEkqj9Hcr039Rs95Pk/TkvjVIVgvCNYykbHWYI=;
 b=hMxliWM9lSHoZLUNGpG/2BzQXoQOBKOufjshpwPXJgkITocSnxml9kO996gqKMqHa6
 viE6Idlg/TDpSu6t93TCouKbbMNkLFtkKFl6OmAKLLHhBmAmp/8teyM/6n0gjzkDMfQR
 M0/SoecVLhCkXsPPfKpKFbkyLW3mG3z3r/YCrA6CtKjqO/bcDXbD6qAPFVNSgdenUzrR
 yzqeH32QfdkzXkJmjRRbTVO6S7TYyVjMyEd8nnHchbbQrB60HGtKrTLWRtYTWYnu5wMe
 DlnFzM+O44UNFc19muAqYf1HZSwEmqGtR/Vt+jDIFNeFJlDhrT+QHUBaGVt+gKqkCmtX
 PqJw==
X-Gm-Message-State: AOJu0YwckzhuU3x21ltlI7RQAugeTttRHgTCCdemrUC4Qms2TQlMtY4M
 uoA1mYklgSC3H/hmc0llZ26kIF4AArLkrGLmD2Y=
X-Google-Smtp-Source: AGHT+IG761XXI08GFvCQFpIRjW7N3OhGBQBsStHBDmG7S/2Lr97m8XZbRZH76dEDmsj5KvAQQVr+yw==
X-Received: by 2002:a17:90a:410b:b0:269:1abd:3ba6 with SMTP id
 u11-20020a17090a410b00b002691abd3ba6mr2320142pjf.28.1691790041746; 
 Fri, 11 Aug 2023 14:40:41 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 10/11] target/arm: Implement FEAT_HPDS2 as a no-op
Date: Fri, 11 Aug 2023 14:40:30 -0700
Message-Id: <20230811214031.171020-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This feature allows the operating system to set TCR_ELx.HWU*
to allow the implementation to use the PBHA bits from the
block and page descriptors for for IMPLEMENTATION DEFINED
purposes.  Since QEMU has no need to use these bits, we may
simply ignore them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu32.c        | 2 +-
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bdafc68819..2012bbf7c7 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -40,6 +40,7 @@ the following architecture extensions:
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HCX (Support for the HCRX_EL2 register)
 - FEAT_HPDS (Hierarchical permission disables)
+- FEAT_HPDS2 (Translation table page-based hardware attributes)
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
 - FEAT_IESB (Implicit error synchronization event)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 47d2e8e781..1f918ff537 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -62,7 +62,7 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_mmfr3 = t;
 
     t = cpu->isar.id_mmfr4;
-    t = FIELD_DP32(t, ID_MMFR4, HPDS, 1);         /* FEAT_AA32HPD */
+    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
     t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
     t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
     t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0054bb6dfa..b12e10d3ab 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -865,7 +865,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, HAFDBS, 2);   /* FEAT_HAFDBS */
     t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* FEAT_VMID16 */
     t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);       /* FEAT_VHE */
-    t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1);     /* FEAT_HPDS */
+    t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 2);     /* FEAT_HPDS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);       /* FEAT_LOR */
     t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 3);      /* FEAT_PAN3 */
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
-- 
2.34.1


