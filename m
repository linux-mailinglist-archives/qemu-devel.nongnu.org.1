Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AEA82AD0F
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:12:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssj-0001dB-51; Thu, 11 Jan 2024 06:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss7-0001LQ-UW
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:16 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0004PL-BX
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:15 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso4417063f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971111; x=1705575911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MggGO+NPAbBJmsyAFGskbOZEUDcciWvWwdLwaUXekp4=;
 b=k0fUZ55OnwPMRbZdtr9VeijGOF4Ni+eQP/QtBskG2QKY50YQ7IXU3Woa23gaW+IV4A
 cebyHUGIl8oVbgfkoYh0v/9/G8B4q0J/58nfAiOF3Mxv/Teb+f5ojOs3cscoCszJ9pmn
 KmPp4WD48+ar3Ae/xkKCyxJnlqSksFuU/UW5h8ciW1AyAkBxqSlIDDBrRGGlRFDNFsQc
 rjx5PBjq5H41kVZxjWlzaorqP/nABci2n0xaIBR9XhrcQUCGxm9WWINYondTWu+oJSK5
 p6lCLDFCUl4zPWcC5VMYpb1BiAyy2BWsrnetOPrACqzWRFbs6h3S0RvQwyaOsgpp02Qa
 IEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971111; x=1705575911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MggGO+NPAbBJmsyAFGskbOZEUDcciWvWwdLwaUXekp4=;
 b=HG3eRKn3uU+PKAdBNqjTAMZg8HUQKaJo0cK6rKfDFl+s8jv9v+a8K7Ufsa/zCF0xO4
 BPEhlHx6/Zje0NSkWBORTFhJyOxsDjCB4whFHLYAjFv5tGshkLS4YdtoqGRZP8E6mDd0
 Ask2JF9lIbiySv2wyjmK/bj1ksRSWuya+64ziYbXSTyOnRsnICQZNx+Qf/iS2/i6UP2v
 1C30UCH8ONkenyRuOKjF5kjFErICEPjXgFlFHNZM4STNfraftvdm6+bCXsT8QIoi3roB
 5WSlxZhTQObg+s8m7EUJl1dpOcgXko2V8kcte+T4iNgsBfeZb9jAxhmwFtPm4V8qFV5v
 v1Sg==
X-Gm-Message-State: AOJu0Yy7QrcMSdMWA8azRWvCZdvhvBNlEHDmXSgXaxVjYtH8i2vjLgdT
 ONXCoLzeQje5wqIXTZL0+M4ZOD3p6ZQyyIUnwcs749n2H/Y=
X-Google-Smtp-Source: AGHT+IGGiBc3aZZZA5aurfolZP5L5u2bbef1yv0+fPOJp3vJEMFZHifDUVa9r7947LiLkpiyT25ceg==
X-Received: by 2002:adf:e989:0:b0:336:d299:ada5 with SMTP id
 h9-20020adfe989000000b00336d299ada5mr482341wrm.112.1704971111723; 
 Thu, 11 Jan 2024 03:05:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/41] target/arm: Implement HCR_EL2.AT handling
Date: Thu, 11 Jan 2024 11:04:35 +0000
Message-Id: <20240111110505.1563291-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The FEAT_NV HCR_EL2.AT bit enables trapping of some address
translation instructions from EL1 to EL2.  Implement this behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4e5fd25199c..dc4b4123e00 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3703,6 +3703,15 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return at_e012_access(env, ri, isread);
 }
 
+static CPAccessResult at_s1e01_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_AT)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return at_e012_access(env, ri, isread);
+}
+
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -5568,22 +5577,22 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 0,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1R,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
     { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 1,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1W,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
     { .name = "AT_S1E0R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 2,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E0R,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
     { .name = "AT_S1E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 3,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E0W,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
     { .name = "AT_S12E1R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
@@ -8168,12 +8177,12 @@ static const ARMCPRegInfo ats1e1_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1RP,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
     { .name = "AT_S1E1WP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1WP,
-      .accessfn = at_e012_access, .writefn = ats_write64 },
+      .accessfn = at_s1e01_access, .writefn = ats_write64 },
 };
 
 static const ARMCPRegInfo ats1cp_reginfo[] = {
-- 
2.34.1


