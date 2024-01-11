Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA8082ACEA
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:09:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNsso-0001lO-0I; Thu, 11 Jan 2024 06:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssD-0001O1-1z
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:25 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss7-0004QJ-DE
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:20 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33694bf8835so4197722f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971113; x=1705575913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xMUaXwQGKRqjkeLfl66MTj+REoCxCyxmGFuF/1PCBbc=;
 b=OYiwWlPOmmBQTPu6U9PbWzCyviu4GdD7aclJQFTMcqxf8qlBCShB8yknaRIXb/dEcx
 6DQOgfLlxy9erqewaVO0ipwFJUv7miOqEeirGyjhkmwANZYfPK4/cUtDuOR+wtOKN6N+
 6ptjNQnxwsaxD2Vlvz9amdh8g7IC7LRQQSNL/D1AsEVue7wMzSas2RvEeFIB7+l14B33
 gCX7AiWSN4ImbzTnmy4vPhZLt0pq5xlJZpHWWBAueJYsOd0a5LJ12z+AFNur7aONQEgO
 GgN1wJOsXNsAFORGRDpFsemjktyI2GiVSD4T50EK1+x8vX5NnR6NcqpP8jV82UEe8ZCi
 sxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971113; x=1705575913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMUaXwQGKRqjkeLfl66MTj+REoCxCyxmGFuF/1PCBbc=;
 b=HXkNUAsGc5XRyIVIhmy7hFlDXzFROuJkv17E11FreOqMIRYzb1U1e6v2Pqn2oPRYOC
 0akVwPcaR+31DZ5vk4JBQRFYpFdn48MxKcNSPhF1JNDjHQ0WV9YupcS6AsH4jKm/od1U
 AbsdE15ycXjSaTEZ2rXetyNuEF7Vi4YYAopIm53JtSsqH1yyEfPjER12FLvfkRORpsMU
 AxCPgU1XbKbCcRL2DvIDVIs2b3mGcOV7uQNlrzPQvt16pAcSUJsAhWN8bdp2asAX4VW3
 DO0aR4xKhrGuVRB6fC15eFKPuDU5EyoU+dLokvOHJ58pCHUgvxmOz2O53DJxYZ+qWFKF
 CYYg==
X-Gm-Message-State: AOJu0YzkjWmrd6jpyrUiA3kjzGN1+H5lG24McfNcpNhguGrJ6AY9gHhB
 k6wBqUBov5nRHuVb2Ckkb3OaDy8zD3q4WYzVjNO6IcHQli8=
X-Google-Smtp-Source: AGHT+IFWWd2dxib2awPoRmSiBK+KfV1YC8PFywCBhv2b3BBPDBm2SPcowTgw5JhCcZJWL75nRFOfnw==
X-Received: by 2002:adf:f443:0:b0:336:8462:37f1 with SMTP id
 f3-20020adff443000000b00336846237f1mr486450wrp.51.1704971113330; 
 Thu, 11 Jan 2024 03:05:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] target/arm: Record correct opcode fields in cpreg for
 E2H aliases
Date: Thu, 11 Jan 2024 11:04:39 +0000
Message-Id: <20240111110505.1563291-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc4b4123e00..dc2471eda7e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6522,6 +6522,19 @@ static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -6621,6 +6634,28 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
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


