Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E11816C4C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:35:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBs9-0006en-Fh; Mon, 18 Dec 2023 06:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs6-0006cP-LX
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:18 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs0-0003IX-M2
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:18 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3366af69d4bso374044f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899191; x=1703503991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hqhZ/TYrEHVthS8Snx3nWwPfhsJPpj41dOm4FCOn7mk=;
 b=hYYwX/kIsovbcAZBZkeuzf1mk2JCewCOeCpJPUUDRfBjUBPEfFSSsrlb//eHGDQV+C
 A28hzHyR4WbO4C9chM+MQUPLBcipJSVFF3RfBuoM0iE1XTczGibudppN7aZ3c2DWUGI5
 Kmn0QmVgvbLDgp18SU0CyBY+zo9RiArMrZKDkP9wL60Z4crWohvV827fvzpzvu3Za/95
 vWKJPfIQw46cvTz5VmlRp3xjEJ0/BJ9vZxVfAdpMVnTCwn+okRKZhEj+XSaWyyhK/YZJ
 vier0O5pN5giHrslSAXplrFHvcsr/Zw5tDnnAJO2wept4jkcxfJ/e5qhhaQVVuuaRE2c
 2pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899191; x=1703503991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hqhZ/TYrEHVthS8Snx3nWwPfhsJPpj41dOm4FCOn7mk=;
 b=e9Nz8uiY3LsNfZ2J/6ZTob7T5QPp9Dl73cUzlISk22hXbHimdzmpSOlUG78H3bln6w
 BlA/5B+mIZR8dglH22g0UuYWiPxVGyYMBx/IXtFQpz3mlRkbRS7TVzC0mvJVXfnJdIlj
 w2icSdUh9d6smhOeSsecexbm9wLBsxsBk2J/2vWQJVk8CyQH2fwZAULnBg2vV/qQACnL
 zT+hcwesZJfB7pZF4tH00iDf15vFnowQY7dBhkCrfePfjd80/MpZrQJhvMkYdwVX67Nc
 a6Nn1yT+XmXHsggQ1PALDODNMBzhJux3NH0FCncxyv3mdW3fxm21mEGT5UjqAllrNHq7
 FxFQ==
X-Gm-Message-State: AOJu0YzO8m5bJZmWRhbCpw4vGSGqLvhYJ+1J+X2+1Gxnv2pjaGrWkYhB
 eeiViG8g+CdljQXGk9iD9SeaRg==
X-Google-Smtp-Source: AGHT+IFapuFHVRK+HiGU2Q5wGRkIDG7abtwzeUaDt4ibsdy1OO9kq9avFl5a5xmo2JA24RAek7v9ng==
X-Received: by 2002:adf:f551:0:b0:336:5e1d:bac0 with SMTP id
 j17-20020adff551000000b003365e1dbac0mr2051500wrp.4.1702899191388; 
 Mon, 18 Dec 2023 03:33:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/35] target/arm: *_EL12 registers should UNDEF when
 HCR_EL2.E2H is 0
Date: Mon, 18 Dec 2023 11:32:40 +0000
Message-Id: <20231218113305.2511480-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The alias registers like SCTLR_EL12 only exist when HCR_EL2.E2H
is 1; they should UNDEF otherwise. We weren't implementing this.
Add an intercept of the accessfn for these aliases, and implement
the UNDEF check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h |  3 ++-
 target/arm/helper.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index f1293d16c07..e748d184cb6 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -937,7 +937,7 @@ struct ARMCPRegInfo {
     CPResetFn *resetfn;
 
     /*
-     * "Original" writefn and readfn.
+     * "Original" readfn, writefn, accessfn.
      * For ARMv8.1-VHE register aliases, we overwrite the read/write
      * accessor functions of various EL1/EL0 to perform the runtime
      * check for which sysreg should actually be modified, and then
@@ -948,6 +948,7 @@ struct ARMCPRegInfo {
      */
     CPReadFn *orig_readfn;
     CPWriteFn *orig_writefn;
+    CPAccessFn *orig_accessfn;
 };
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c6f069b74cd..e90eb5e16f3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6519,6 +6519,20 @@ static void el2_e2h_e12_write(CPUARMState *env, const ARMCPRegInfo *ri,
     return ri->orig_writefn(env, ri->opaque, value);
 }
 
+static CPAccessResult el2_e2h_e12_access(CPUARMState *env,
+                                         const ARMCPRegInfo *ri,
+                                         bool isread)
+{
+    /* FOO_EL12 aliases only exist when E2H is 1; otherwise they UNDEF */
+    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
+    }
+    if (ri->orig_accessfn) {
+        return ri->orig_accessfn(env, ri->opaque, isread);
+    }
+    return CP_ACCESS_OK;
+}
+
 static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
 {
     struct E2HAlias {
@@ -6632,6 +6646,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         new_reg->opaque = src_reg;
         new_reg->orig_readfn = src_reg->readfn ?: raw_read;
         new_reg->orig_writefn = src_reg->writefn ?: raw_write;
+        new_reg->orig_accessfn = src_reg->accessfn;
         if (!new_reg->raw_readfn) {
             new_reg->raw_readfn = raw_read;
         }
@@ -6640,6 +6655,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         }
         new_reg->readfn = el2_e2h_e12_read;
         new_reg->writefn = el2_e2h_e12_write;
+        new_reg->accessfn = el2_e2h_e12_access;
 
         ok = g_hash_table_insert(cpu->cp_regs,
                                  (gpointer)(uintptr_t)a->new_key, new_reg);
-- 
2.34.1


