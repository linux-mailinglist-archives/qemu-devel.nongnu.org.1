Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF2881AD1F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:18:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Yo-0007HB-Ie; Wed, 20 Dec 2023 22:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yn-0007H2-0T
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:21 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yl-0003gV-1Y
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:20 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-77f524597c3so19359085a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128638; x=1703733438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCu52KW/EDOsijWBXsGWXcmu8Q0OiP0WdLJKxsvxad0=;
 b=ZhIhUCQhKB9I+Lrmx7d4udyaH6Y84lON4KaCCyl3TyZbj2KrDjgq5BFKNHz+1m0Ro+
 bZJ5ld9rhLiA26PYja/hvD+Qq0m5s0F8IrcpEpV4bhe3EaSH5sXyoK3e1ixjvtFLTEuQ
 15lGuPYotSQp5woyb1pHCqalvxjh9bOHTKJd8jxfRRpQrJQqBokcxdVoln0tE019NWUV
 DJhzbo4//EZigsUpyP/18ZtMDlOZHJGzs/c1TygcaWYNEio6YIdvQzllum5rwrJiYsKA
 HXXtAf7e1ypIw8N+0t/PpUJn8xN3AxcA472E4mNgIP0hqe1ZtuThmOIYQr68sHHdQzJU
 ckMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128638; x=1703733438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCu52KW/EDOsijWBXsGWXcmu8Q0OiP0WdLJKxsvxad0=;
 b=wC8r6sMQyzn7XQVcNsxlxK2Zdd00WjKO/ZHjKaOl6E4YbxeydV901W+2NKaLS1aFs7
 I3vDw3r/IfnUKtDkDDTChg8ePsRr87VdiYQQz5e83Uo1nil24xWvrLbdJIqJE4SfAwwh
 u41TsT0NjliScDnTtyLeuRFx3gwKQ/effXdRSYFRO1+ZhLqPkf3UMcWcxxRHtcNL5YeV
 HD/FRldvQGs+ICsjW9LFM71AzWLy0HL6zr667cnfYni7tEugxPjqSqp9cGnR+0kw1Jv0
 Go/z5OChMRMAIxDj65ru9XQ69q5aZR8uQMQ0SAgQFSR+Gw9BMplTQqy4m3X5wKYtLtJs
 Prjg==
X-Gm-Message-State: AOJu0YwrvLt3d7GftP1MG13bdcUJ1K2xflBm4UoplevXSeIDsAzeZdA7
 y/vkM/nDotqkxGUh2syEWswzOx/FQPF4Rv3p/KxIcmRM
X-Google-Smtp-Source: AGHT+IEuEixtJ2a5jbFw2Y3UTK0vi/wi3STndqZ6SM06DjNiVfRzawda7vOaPEZ5eJFrAVYEmg98wQ==
X-Received: by 2002:a05:620a:674:b0:781:1362:c89 with SMTP id
 a20-20020a05620a067400b0078113620c89mr1695017qkh.18.1703128637947; 
 Wed, 20 Dec 2023 19:17:17 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/71] target/arm: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:43 +1100
Message-Id: <20231221031652.119827-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x732.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/machine.c | 54 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 9e20b41189..542be14bec 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -49,7 +49,7 @@ static const VMStateDescription vmstate_vfp = {
     .version_id = 3,
     .minimum_version_id = 3,
     .needed = vfp_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* For compatibility, store Qn out of Zn here.  */
         VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[0].d, ARMCPU, 0, 2),
         VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[1].d, ARMCPU, 0, 2),
@@ -115,7 +115,7 @@ static const VMStateDescription vmstate_iwmmxt = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = iwmmxt_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.iwmmxt.regs, ARMCPU, 16),
         VMSTATE_UINT32_ARRAY(env.iwmmxt.cregs, ARMCPU, 16),
         VMSTATE_END_OF_LIST()
@@ -140,7 +140,7 @@ static const VMStateDescription vmstate_zreg_hi_reg = {
     .name = "cpu/sve/zreg_hi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_SUB_ARRAY(d, ARMVectorReg, 2, ARM_MAX_VQ - 2),
         VMSTATE_END_OF_LIST()
     }
@@ -150,7 +150,7 @@ static const VMStateDescription vmstate_preg_reg = {
     .name = "cpu/sve/preg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(p, ARMPredicateReg, 2 * ARM_MAX_VQ / 8),
         VMSTATE_END_OF_LIST()
     }
@@ -161,7 +161,7 @@ static const VMStateDescription vmstate_sve = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = sve_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(env.vfp.zregs, ARMCPU, 32, 0,
                              vmstate_zreg_hi_reg, ARMVectorReg),
         VMSTATE_STRUCT_ARRAY(env.vfp.pregs, ARMCPU, 17, 0,
@@ -174,7 +174,7 @@ static const VMStateDescription vmstate_vreg = {
     .name = "vreg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(d, ARMVectorReg, ARM_MAX_VQ * 2),
         VMSTATE_END_OF_LIST()
     }
@@ -196,7 +196,7 @@ static const VMStateDescription vmstate_za = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = za_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(env.zarray, ARMCPU, ARM_MAX_VQ * 16, 0,
                              vmstate_vreg, ARMVectorReg),
         VMSTATE_END_OF_LIST()
@@ -217,7 +217,7 @@ static const VMStateDescription vmstate_serror = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = serror_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(env.serror.pending, ARMCPU),
         VMSTATE_UINT8(env.serror.has_esr, ARMCPU),
         VMSTATE_UINT64(env.serror.esr, ARMCPU),
@@ -235,7 +235,7 @@ static const VMStateDescription vmstate_irq_line_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = irq_line_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.irq_line_state, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -254,7 +254,7 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.v7m.faultmask[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.primask[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
@@ -289,7 +289,7 @@ static const VMStateDescription vmstate_m_csselr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m_csselr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.v7m.csselr, ARMCPU, M_REG_NUM_BANKS),
         VMSTATE_VALIDATE("CSSELR is valid", csselr_vmstate_validate),
         VMSTATE_END_OF_LIST()
@@ -301,7 +301,7 @@ static const VMStateDescription vmstate_m_scr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.v7m.scr[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -312,7 +312,7 @@ static const VMStateDescription vmstate_m_other_sp = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.v7m.other_sp, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -331,7 +331,7 @@ static const VMStateDescription vmstate_m_v8m = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m_v8m_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.v7m.msplim, ARMCPU, M_REG_NUM_BANKS),
         VMSTATE_UINT32_ARRAY(env.v7m.psplim, ARMCPU, M_REG_NUM_BANKS),
         VMSTATE_END_OF_LIST()
@@ -343,7 +343,7 @@ static const VMStateDescription vmstate_m_fp = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vfp_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.v7m.fpcar, ARMCPU, M_REG_NUM_BANKS),
         VMSTATE_UINT32_ARRAY(env.v7m.fpccr, ARMCPU, M_REG_NUM_BANKS),
         VMSTATE_UINT32_ARRAY(env.v7m.fpdscr, ARMCPU, M_REG_NUM_BANKS),
@@ -365,7 +365,7 @@ static const VMStateDescription vmstate_m_mve = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = mve_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.v7m.vpr, ARMCPU),
         VMSTATE_UINT32(env.v7m.ltpsize, ARMCPU),
         VMSTATE_END_OF_LIST()
@@ -377,7 +377,7 @@ static const VMStateDescription vmstate_m = {
     .version_id = 4,
     .minimum_version_id = 4,
     .needed = m_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.v7m.vecbase[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.control[M_REG_NS], ARMCPU),
@@ -391,7 +391,7 @@ static const VMStateDescription vmstate_m = {
         VMSTATE_INT32(env.v7m.exception, ARMCPU),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_m_faultmask_primask,
         &vmstate_m_csselr,
         &vmstate_m_scr,
@@ -416,7 +416,7 @@ static const VMStateDescription vmstate_thumb2ee = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = thumb2ee_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.teecr, ARMCPU),
         VMSTATE_UINT32(env.teehbr, ARMCPU),
         VMSTATE_END_OF_LIST()
@@ -445,7 +445,7 @@ static const VMStateDescription vmstate_pmsav7 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmsav7_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VARRAY_UINT32(env.pmsav7.drbar, ARMCPU, pmsav7_dregion, 0,
                               vmstate_info_uint32, uint32_t),
         VMSTATE_VARRAY_UINT32(env.pmsav7.drsr, ARMCPU, pmsav7_dregion, 0,
@@ -474,7 +474,7 @@ static const VMStateDescription vmstate_pmsav7_rnr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmsav7_rnr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.pmsav7.rnr[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -504,7 +504,7 @@ static const VMStateDescription vmstate_pmsav8r = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmsav8r_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VARRAY_UINT32(env.pmsav8.hprbar, ARMCPU,
                         pmsav8r_hdregion, 0, vmstate_info_uint32, uint32_t),
         VMSTATE_VARRAY_UINT32(env.pmsav8.hprlar, ARMCPU,
@@ -518,7 +518,7 @@ static const VMStateDescription vmstate_pmsav8 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmsav8_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VARRAY_UINT32(env.pmsav8.rbar[M_REG_NS], ARMCPU, pmsav7_dregion,
                               0, vmstate_info_uint32, uint32_t),
         VMSTATE_VARRAY_UINT32(env.pmsav8.rlar[M_REG_NS], ARMCPU, pmsav7_dregion,
@@ -527,7 +527,7 @@ static const VMStateDescription vmstate_pmsav8 = {
         VMSTATE_UINT32(env.pmsav8.mair1[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_pmsav8r,
         NULL
     }
@@ -560,7 +560,7 @@ static const VMStateDescription vmstate_m_security = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m_security_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.v7m.secure, ARMCPU),
         VMSTATE_UINT32(env.v7m.other_ss_msp, ARMCPU),
         VMSTATE_UINT32(env.v7m.other_ss_psp, ARMCPU),
@@ -888,7 +888,7 @@ const VMStateDescription vmstate_arm_cpu = {
     .post_save = cpu_post_save,
     .pre_load = cpu_pre_load,
     .post_load = cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
         VMSTATE_UINT64_ARRAY(env.xregs, ARMCPU, 32),
         VMSTATE_UINT64(env.pc, ARMCPU),
@@ -937,7 +937,7 @@ const VMStateDescription vmstate_arm_cpu = {
         },
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_vfp,
         &vmstate_iwmmxt,
         &vmstate_m,
-- 
2.34.1


