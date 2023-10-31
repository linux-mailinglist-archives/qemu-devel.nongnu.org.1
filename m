Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 125E47DD4C6
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:38:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxsgI-0001Gh-LT; Tue, 31 Oct 2023 13:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxsgG-0001Eu-0j
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:37:32 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxsgC-0008CZ-OF
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:37:31 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c4fdf94666so76918631fa.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698773845; x=1699378645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PdV1GeFlfaLHBKbxsOWgoRO1D00OQ9VZbqz3Qac7I2E=;
 b=ixf1gyabE4xUIUrUZceSsTbd9o5VwF1hYKjHpiZonLqG4T8gHPMguWrOzZsZAIj2mj
 PPO3a98G6KZmk31TyYxR+f9CylbOnCmddSsr7mKSezOv0I5kRfqXVH7GlwCfQ/Oh50Mn
 +9KEVW76t1uXeLj6QcN+J+SRCSK83yOCLRv8eMIQ1XJlfu05nwrrElhsdIQylZn8efY7
 cii7R05nxUeKjDGrq99rEteQOE+qDmytW8WpWsR4rK8rRqsgttwUvja+UUuRzwME8t3l
 ZpsOJMDFxR1OvSF6z7VMCHGyZQ59FxR5pd/w5rZrQiZQe/l2A8hmZbP32Gv8wWVg2ttd
 BU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698773845; x=1699378645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PdV1GeFlfaLHBKbxsOWgoRO1D00OQ9VZbqz3Qac7I2E=;
 b=FGsU/aCvOhHebc8KFTJ1AE8NpnWKwvSPp22xkn9sASH7Ch+LTsW1V186AIdljjZm4j
 YSYajuDb/h1PbqcHFvVYxg4WvwNh141RmOhN87G/mBP2qXVhx61b1JktD0ZvM/PFVutC
 /ZUMSlXoCflNdRZH6HF7loLmZ95iUZ/KEVQ94lzuKkukwzKhFUZ5MnKSsIrUdBrIcMK0
 CrGrrjvmKByFBSVCC/O8K12OYoSdXX+Wg9FySRm4lutCLD7Yc3LKbl6Fnsbn8na4qpXX
 l3isytd7deHHO0RJ+xH32EaF0JAnnJ7/H4nZa4f4KwFJRT1wfeTOcCbaj0tgoYYOb49O
 4Kig==
X-Gm-Message-State: AOJu0Yy2d92PY/J1rbgj9H69Tz2+YwHrcKXlbC+qIG8kGOA4xKJzHO85
 XQjbzY/M0y1ZsiKHpD28yop5qwjlClaarfxvzQg=
X-Google-Smtp-Source: AGHT+IEEEYat+Co0UQxKgbbN6z0Tg1moYWRZ6VZUDDGdU8Ng0eOL5AtNx91OMCQuyzgl4Iqil6dr2w==
X-Received: by 2002:a2e:3e1a:0:b0:2bf:ab17:d48b with SMTP id
 l26-20020a2e3e1a000000b002bfab17d48bmr11174988lja.34.1698773845272; 
 Tue, 31 Oct 2023 10:37:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a05600c0a4900b00407460234f9sm2415161wmq.21.2023.10.31.10.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:37:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Correctly propagate stage 1 BTI guarded bit in a
 two-stage walk
Date: Tue, 31 Oct 2023 17:37:23 +0000
Message-Id: <20231031173723.26582-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

In a two-stage translation, the result of the BTI guarded bit should
be the guarded bit from the first stage of translation, as there is
no BTI guard information in stage two.  Our code tried to do this,
but got it wrong, because we currently have two fields where the GP
bit information might live (ARMCacheAttrs::guarded and
CPUTLBEntryFull::extra::arm::guarded), and we were storing the GP bit
in the latter during the stage 1 walk but trying to copy the former
in combine_cacheattrs().

Remove the duplicated storage, and always use the field in
CPUTLBEntryFull; correctly propagate the stage 1 value to the output
in get_phys_addr_twostage().

Note for stable backports: in v8.0 and earlier the field is named
result->f.guarded, not result->f.extra.arm.guarded.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1950
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 1 -
 target/arm/ptw.c       | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f7224e6f4d9..c837506e448 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1181,7 +1181,6 @@ typedef struct ARMCacheAttrs {
     unsigned int attrs:8;
     unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 PTEs */
     bool is_s2_format:1;
-    bool guarded:1;              /* guarded bit of the v8-64 PTE */
 } ARMCacheAttrs;
 
 /* Fields that are valid upon success. */
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 53713e03006..1762b058aec 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3032,7 +3032,6 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
 
     assert(!s1.is_s2_format);
     ret.is_s2_format = false;
-    ret.guarded = s1.guarded;
 
     if (s1.attrs == 0xf0) {
         tagged = true;
@@ -3175,7 +3174,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     hwaddr ipa;
     int s1_prot, s1_lgpgsz;
     ARMSecuritySpace in_space = ptw->in_space;
-    bool ret, ipa_secure;
+    bool ret, ipa_secure, s1_guarded;
     ARMCacheAttrs cacheattrs1;
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
@@ -3202,6 +3201,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
      */
     s1_prot = result->f.prot;
     s1_lgpgsz = result->f.lg_page_size;
+    s1_guarded = result->f.extra.arm.guarded;
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
@@ -3252,6 +3252,9 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     result->cacheattrs = combine_cacheattrs(hcr, cacheattrs1,
                                             result->cacheattrs);
 
+    /* No BTI GP information in stage 2, we just use the S1 value */
+    result->f.extra.arm.guarded = s1_guarded;
+
     /*
      * Check if IPA translates to secure or non-secure PA space.
      * Note that VSTCR overrides VTCR and {N}SW overrides {N}SA.
-- 
2.34.1


