Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9349749D8A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:26:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzB-0004mL-FP; Thu, 06 Jul 2023 09:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOz7-0004lj-FF
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:25 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOz0-0000qU-SC
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142970df44so595722f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649914; x=1691241914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=woUU+HiOTdfeWxIkByv1Ka1J61xMATqCD7GSJSY7c+4=;
 b=nwqia1cCeC72BqRokDx9wfzmBeNWi9/RU7p3TkupwCGtXbvTTsfubW5tQpjbb+lNHX
 WvKtKXUgGuHQPZQT0Wohrn/1OqdXiSQDK95Q5dPYTdNv0EEtocZbLbvjDl1dwVLFSwO/
 LO+AMIBLTOntx4NAmPUBwsKczyEZPqVZhiaAKoavfUAYYQvYViP2wutMCXpLE8UYz/aY
 Bvd1WLqV/+VVBhS8jYZ10fcHxkV+AIfLr3FPLBj+tJlPoO1FPLOZoRA0D9i1abJ1797c
 XL4fB7hgZJzQP6dlg09V1Ml+WZcxB64eGZgoeUTgywFzV/Gur3/c6kX1ircwJFik6c5X
 jEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649915; x=1691241915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woUU+HiOTdfeWxIkByv1Ka1J61xMATqCD7GSJSY7c+4=;
 b=ltpeWR/C6ydF5U5M6bUlpFVZ+fvyS9zr5apIgWpzau1cJZJDO4IRwpKCde4qXAUmV0
 W2ZhkzXk4XHp61PkezMpIxBMw7R8uiH30WJh99mG6k3SqBe3uF5WP1At2regXIJ6+1yO
 MVXVBlFEXPfm2qMJetvjmJB/kZVAFzfn1ahvAwy1wpjAVYNoaN1jly4/yccwhGKRrvJ4
 I92NJpS0EMCYXkLVCc/7LzXssViJfnawG/kGuvSJrjtEjS7ngjw2d8Y4HG+OUQGMA6f6
 AIQNMqZ3Z4T87ujblgd8IceO5tBW7c1fY4t+kJBmCjLOiKKsP3IuqZB43uZlkSCRFO9E
 kwPw==
X-Gm-Message-State: ABy/qLb/FRCs5ooSXm/N4Q3u4osJTonIZdXdZ7Bkrgk7aJsR44vtUUbl
 6ST2sgH4cZ/hCNelgAOKpj6mygRpVQagwdPoevs=
X-Google-Smtp-Source: APBJJlEAu951UKyUakwcg8WL0m/2AMMlnadOxUuH0GNvZSJ/qo5NPqFNLtmgQyW20XKJe3yUNLdi7g==
X-Received: by 2002:adf:e803:0:b0:314:11ea:480d with SMTP id
 o3-20020adfe803000000b0031411ea480dmr1455520wrm.9.1688649914726; 
 Thu, 06 Jul 2023 06:25:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/14] target/arm: Add raw_writes ops for register whose write
 induce TLB maintenance
Date: Thu,  6 Jul 2023 14:24:59 +0100
Message-Id: <20230706132512.3534397-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Some registers whose 'cooked' writefns induce TLB maintenance do
not have raw_writefn ops defined. If only the writefn ops is set
(ie. no raw_writefn is provided), it is assumed the cooked also
work as the raw one. For those registers it is not obvious the
tlb_flush works on KVM mode so better/safer setting the raw write.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d08c058e424..a0b84efab52 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4189,14 +4189,14 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR0_EL1,
-      .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
     { .name = "TTBR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR1_EL1,
-      .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
@@ -4456,13 +4456,13 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr_write, .raw_writefn = raw_write },
     { .name = "TTBR1", .cp = 15, .crm = 2, .opc1 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr_write, .raw_writefn = raw_write },
 };
 
 static uint64_t aa64_fpcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -5911,7 +5911,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
-      .writefn = hcr_write },
+      .writefn = hcr_write, .raw_writefn = raw_write },
     { .name = "HCR", .state = ARM_CP_STATE_AA32,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
@@ -5983,6 +5983,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
       .access = PL2_RW, .writefn = vmsa_tcr_el12_write,
+      .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
@@ -5999,10 +6000,10 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .access = PL2_RW, .accessfn = access_el3_aa32ns,
       .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2),
-      .writefn = vttbr_write },
+      .writefn = vttbr_write, .raw_writefn = raw_write },
     { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 0,
-      .access = PL2_RW, .writefn = vttbr_write,
+      .access = PL2_RW, .writefn = vttbr_write, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2) },
     { .name = "SCTLR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 0,
@@ -6014,7 +6015,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
     { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL2_RW, .resetvalue = 0, .writefn = vmsa_tcr_ttbr_el2_write,
+      .access = PL2_RW, .resetvalue = 0,
+      .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
@@ -6201,12 +6203,12 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "SCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.scr_el3),
-      .resetfn = scr_reset, .writefn = scr_write },
+      .resetfn = scr_reset, .writefn = scr_write, .raw_writefn = raw_write },
     { .name = "SCR",  .type = ARM_CP_ALIAS | ARM_CP_NEWEL,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.scr_el3),
-      .writefn = scr_write },
+      .writefn = scr_write, .raw_writefn = raw_write },
     { .name = "SDER32_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 1,
       .access = PL3_RW, .resetvalue = 0,
@@ -7927,6 +7929,7 @@ static const ARMCPRegInfo vhe_reginfo[] = {
     { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
       .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+      .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
 #ifndef CONFIG_USER_ONLY
     { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
-- 
2.34.1


