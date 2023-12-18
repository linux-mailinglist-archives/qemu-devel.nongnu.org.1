Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CDF816C7F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBs8-0006e2-Tl; Mon, 18 Dec 2023 06:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs5-0006bB-Hv
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:17 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs0-0003IE-81
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:17 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3366af69d4bso374035f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899191; x=1703503991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rIyXbTygsThOVzP4jBkF7Rj3QO0R5JlePmQL1JlO97A=;
 b=IYkHe442q5CBR70lIuFgjBrYM3Eyrk6VYnWQWYo/+TrH04Ur/fLevm/qM+/Kgc51We
 Tbm71kJHHw1wx5PtVpPDHykPpKVQEv2WRI0K/QeP7ShJUl7UJycv2doNtrawvEK+ALxO
 TlemXQopmoAeKVSjQTVZqGCkS5oq5DqscLcK7+SdVsqZ6+DGK24Kl/n0kSznLisGDdqx
 0LEQSINn10sSs/mtuCryZX/+xZ2Th5uSBgw6uL3z3S5yrNw2oosoyYp/fnRJIjptta02
 N+IRUZtEq52eZ/OvI10688pVcohIRDYGclpV210X92uEN//imOZcrRqxkqPDKWPeeNRk
 WzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899191; x=1703503991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIyXbTygsThOVzP4jBkF7Rj3QO0R5JlePmQL1JlO97A=;
 b=JkEM1BtnUSZW68/dCRkZu5AbVV1UXo4d1DCKa2zFt5wqogfWfipJD8hkgnMAAMQv3Q
 zqtnHoAaONg+Glc6FQObrQNH3rVY3XRo//kpHkJW+L5IWiSzD0bultOM/5ArY/uuZF0o
 c5C5Yl0N23CxJWrToqYnJ6mUadUtHK/hVvhmPM1V+5EAixBstRWDXfXtxRa3DIBX0ZKf
 6FdXdONtr5qfpSKKSJT0rLXvJoBfvUdvFyRQd5i5PSr71L6zvo+UZCiyiObwdMK6eWS7
 GTOL+io9YB8eUuBIWAr1s9izOAsSwzCSP9RYEfzfnLPHGw5+VTCcbVLLd2dUjUh8ipiE
 PUOg==
X-Gm-Message-State: AOJu0Yy3d/PjAp5zr9K76e5veKV5N0vK0WoaYmG570OtRi2OhIpHqmqb
 rY5wk11zgmQhU6Ec5Ik5o/1G72CFbxk0Oae94g0=
X-Google-Smtp-Source: AGHT+IHrL3DuMNeM6+NhlpvRAEwOiGe3NOI6z9r9YAdenHv7dWSRcWzWhWbFnWrEc6EkL2hGggXEng==
X-Received: by 2002:a05:6000:889:b0:336:96d:475c with SMTP id
 cs9-20020a056000088900b00336096d475cmr8115437wrb.5.1702899190943; 
 Mon, 18 Dec 2023 03:33:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/35] target/arm: Record correct opcode fields in cpreg for
 E2H aliases
Date: Mon, 18 Dec 2023 11:32:39 +0000
Message-Id: <20231218113305.2511480-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

For FEAT_VHE, we define a set of register aliases, so that for instance:
 * the SCTLR_EL1 either accesses the real SCTLR_EL1, or (if E2H is 1)
   SCTLR_EL2
 * a new SCTLR_EL12 register accesses SCTLR_EL1 if E2H is 1

However when we create the 'new_reg' cpreg struct for the SCTLR_EL12
register, we duplicate the information in the SCTLR_EL1 cpreg, which
means the opcode fields are those of SCTLR_EL1, not SCTLR_EL12.  This
is a problem for code which looks at the cpreg opcode fields to
determine behaviour (e.g.  in access_check_cp_reg()). In practice
the current checks we do there don't intersect with the *_EL12
registers, but for FEAT_NV this will become a problem.

Write the correct values from the encoding into the new_reg struct.
This restores the invariant that the cpreg that you get back
from the hashtable has opcode fields that match the key you used
to retrieve it.

When we call the readfn or writefn for the target register, we
pass it the cpreg struct for that target register, not the one
for the alias, in case the readfn/writefn want to look at the
opcode fields to determine behaviour. This means we need to
interpose custom read/writefns for the e12 aliases.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f1c7fbf319c..c6f069b74cd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6506,6 +6506,19 @@ static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
     writefn(env, ri, value);
 }
 
+static uint64_t el2_e2h_e12_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* Pass the EL1 register accessor its ri, not the EL12 alias ri */
+    return ri->orig_readfn(env, ri->opaque);
+}
+
+static void el2_e2h_e12_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    /* Pass the EL1 register accessor its ri, not the EL12 alias ri */
+    return ri->orig_writefn(env, ri->opaque, value);
+}
+
 static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
 {
     struct E2HAlias {
@@ -6605,6 +6618,28 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         new_reg->type |= ARM_CP_ALIAS;
         /* Remove PL1/PL0 access, leaving PL2/PL3 R/W in place.  */
         new_reg->access &= PL2_RW | PL3_RW;
+        /* The new_reg op fields are as per new_key, not the target reg */
+        new_reg->crn = (a->new_key & CP_REG_ARM64_SYSREG_CRN_MASK)
+            >> CP_REG_ARM64_SYSREG_CRN_SHIFT;
+        new_reg->crm = (a->new_key & CP_REG_ARM64_SYSREG_CRM_MASK)
+            >> CP_REG_ARM64_SYSREG_CRM_SHIFT;
+        new_reg->opc0 = (a->new_key & CP_REG_ARM64_SYSREG_OP0_MASK)
+            >> CP_REG_ARM64_SYSREG_OP0_SHIFT;
+        new_reg->opc1 = (a->new_key & CP_REG_ARM64_SYSREG_OP1_MASK)
+            >> CP_REG_ARM64_SYSREG_OP1_SHIFT;
+        new_reg->opc2 = (a->new_key & CP_REG_ARM64_SYSREG_OP2_MASK)
+            >> CP_REG_ARM64_SYSREG_OP2_SHIFT;
+        new_reg->opaque = src_reg;
+        new_reg->orig_readfn = src_reg->readfn ?: raw_read;
+        new_reg->orig_writefn = src_reg->writefn ?: raw_write;
+        if (!new_reg->raw_readfn) {
+            new_reg->raw_readfn = raw_read;
+        }
+        if (!new_reg->raw_writefn) {
+            new_reg->raw_writefn = raw_write;
+        }
+        new_reg->readfn = el2_e2h_e12_read;
+        new_reg->writefn = el2_e2h_e12_write;
 
         ok = g_hash_table_insert(cpu->cp_regs,
                                  (gpointer)(uintptr_t)a->new_key, new_reg);
-- 
2.34.1


