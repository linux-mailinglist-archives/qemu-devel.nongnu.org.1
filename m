Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F882ACE4
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:08:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssd-0001S1-UP; Thu, 11 Jan 2024 06:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssL-0001PO-FC
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssH-0004WQ-NB
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:29 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ccec119587so62363841fa.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971121; x=1705575921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r7kELvk9H89WulGcKlRghZk0iXJ6Vb7McKJcJAbBpHc=;
 b=s4RaRlwWZu4sltNXcrk0onIhoNsPBh5Wg0NQqLJiCbj+VgLkM9xOqYe4o0jXk4btiT
 Vx7YcZIMl1L9bMWsUtj7eEu/yZ1LbDC34iWhEqvdSJn6l7vEwXWv+n/2+RiTkYuLu4r7
 cuYG/e80Yb+m1RvCrLQyNRyIA3EicvFDbXrdLh8NcPyR7S5Mzz6lIBgy/krlt9Ur2LCe
 Yj6LtrFIhppJ8AB0pgY0VjIEqEvi0RNkc+CwPoLl1yZ78FqM/AUdMjpuJ/nwEXERtsgO
 L1CtWms7bL8KsnIhq0kVwmRKvvM8D1dk2MeBk1zMPmhC/epnvkZxphC7CgeRFETx67rS
 Xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971121; x=1705575921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7kELvk9H89WulGcKlRghZk0iXJ6Vb7McKJcJAbBpHc=;
 b=cjAf7Tqxg+lVgpWzySFB4hTSfNqOX02Ra6D4W+U4CrU0lLioMJfA+G4LV2MkAIjNPw
 Z0OYnIWaQQ01OWYfTLnhm8I78fZJsR1116cQbvKZgNPAb1w7lWN2VTs1NfvYQ8T/oGcq
 eittI058yKBCxrm4ldy1enNSzrFIVoLM+AwzFNA/MDrpVXrHa4grhLhfD0dT0DEpGBWq
 Sq65PHjb9RTa/UWwUToPnTzMzdI4Wo59TJqSLTQiJJITZsH0CKjTcFrVa6afLXAqd5Uo
 ksjQSxF6YXzG9XDq96n++LcTbI4kBs2VXqTz/20iiTWsD+ksFwFpvtExovoPByU5/Nu4
 hCyg==
X-Gm-Message-State: AOJu0YxlvdoVng2rd1PW362HMjwdTaNbRABR0dTzQNXu8PwDREwqFBEN
 Vw0D+spK0u0k15OgIHhc3CuFhvRzkPArVpAUcuO34lRqDFA=
X-Google-Smtp-Source: AGHT+IFiTga4w3O6Bd6AJY4wLFRSs3PfRhsAHoZnbEcU63BZLZibtkpm03sGtixDx9h/+0nN5UecjQ==
X-Received: by 2002:a2e:8894:0:b0:2cc:e50e:4758 with SMTP id
 k20-20020a2e8894000000b002cce50e4758mr330844lji.34.1704971121613; 
 Thu, 11 Jan 2024 03:05:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] target/arm: Report VNCR_EL2 based faults correctly
Date: Thu, 11 Jan 2024 11:04:57 +0000
Message-Id: <20240111110505.1563291-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

If FEAT_NV2 redirects a system register access to a memory offset
from VNCR_EL2, that access might fault.  In this case we need to
report the correct syndrome information:
 * Data Abort, from same-EL
 * no ISS information
 * the VNCR bit (bit 13) is set

and the exception must be taken to EL2.

Save an appropriate syndrome template when generating code; we can
then use that to:
 * select the right target EL
 * reconstitute a correct final syndrome for the data abort
 * report the right syndrome if we take a FEAT_RME granule protection
   fault on the VNCR-based write

Note that because VNCR is bit 13, we must start keeping bit 13 in
template syndromes, by adjusting ARM_INSN_START_WORD2_SHIFT.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/cpu.h               |  4 ++--
 target/arm/syndrome.h          | 20 ++++++++++++++++----
 target/arm/tcg/tlb_helper.c    | 27 +++++++++++++++++++++++++--
 target/arm/tcg/translate-a64.c |  4 ++++
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9281d74aa9d..ec276fcd57c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -120,12 +120,12 @@ enum {
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
 /* The 2nd extra word holding syndrome info for data aborts does not use
- * the upper 6 bits nor the lower 14 bits. We mask and shift it down to
+ * the upper 6 bits nor the lower 13 bits. We mask and shift it down to
  * help the sleb128 encoder do a better job.
  * When restoring the CPU state, we shift it back up.
  */
 #define ARM_INSN_START_WORD2_MASK ((1 << 26) - 1)
-#define ARM_INSN_START_WORD2_SHIFT 14
+#define ARM_INSN_START_WORD2_SHIFT 13
 
 /* We currently assume float and double are IEEE single and double
    precision respectively.
diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 95454b5b3bb..1a49767479f 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -86,6 +86,9 @@ typedef enum {
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
 #define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
 
+/* In the Data Abort syndrome */
+#define ARM_EL_VNCR (1 << 13)
+
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
     return syn >> ARM_EL_EC_SHIFT;
@@ -256,13 +259,12 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
         (cv << 24) | (cond << 20) | rm;
 }
 
-static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc,
+static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
                                int cm, int s1ptw, int wnr, int fsc)
 {
-    /* TODO: FEAT_NV2 adds VNCR */
     return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
-            | (ind << 20) | (gpcsc << 14) | (cm << 8) | (s1ptw << 7)
-            | (wnr << 6) | fsc;
+        | (ind << 20) | (gpcsc << 14) | (vncr << 13) | (cm << 8)
+        | (s1ptw << 7) | (wnr << 6) | fsc;
 }
 
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
@@ -295,6 +297,16 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
            | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
 }
 
+/*
+ * Faults due to FEAT_NV2 VNCR_EL2-based accesses report as same-EL
+ * Data Aborts with the VNCR bit set.
+ */
+static inline uint32_t syn_data_abort_vncr(int ea, int wnr, int fsc)
+{
+    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (1 << ARM_EL_EC_SHIFT)
+        | ARM_EL_IL | ARM_EL_VNCR | (wnr << 6) | fsc;
+}
+
 static inline uint32_t syn_swstep(int same_el, int isv, int ex)
 {
     return (EC_SOFTWARESTEP << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 4fdd85359e1..dd5de74ffb7 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -50,7 +50,15 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
      * ST64BV, or ST64BV0 insns report syndrome info even for stage-1
      * faults and regardless of the target EL.
      */
-    if (!(template_syn & ARM_EL_ISV) || target_el != 2
+    if (template_syn & ARM_EL_VNCR) {
+        /*
+         * FEAT_NV2 faults on accesses via VNCR_EL2 are a special case:
+         * they are always reported as "same EL", even though we are going
+         * from EL1 to EL2.
+         */
+        assert(!fi->stage2);
+        syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
+    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
         || fi->s1ptw || !fi->stage2) {
         syn = syn_data_abort_no_iss(same_el, 0,
                                     fi->ea, 0, fi->s1ptw, is_write, fsc);
@@ -169,6 +177,20 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     int current_el = arm_current_el(env);
     bool same_el;
     uint32_t syn, exc, fsr, fsc;
+    /*
+     * We know this must be a data or insn abort, and that
+     * env->exception.syndrome contains the template syndrome set
+     * up at translate time. So we can check only the VNCR bit
+     * (and indeed syndrome does not have the EC field in it,
+     * because we masked that out in disas_set_insn_syndrome())
+     */
+    bool is_vncr = (mmu_idx != MMU_INST_FETCH) &&
+        (env->exception.syndrome & ARM_EL_VNCR);
+
+    if (is_vncr) {
+        /* FEAT_NV2 faults on accesses via VNCR_EL2 go to EL2 */
+        target_el = 2;
+    }
 
     if (report_as_gpc_exception(cpu, current_el, fi)) {
         target_el = 3;
@@ -177,7 +199,8 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
 
         syn = syn_gpc(fi->stage2 && fi->type == ARMFault_GPCFOnWalk,
                       access_type == MMU_INST_FETCH,
-                      encode_gpcsc(fi), 0, fi->s1ptw,
+                      encode_gpcsc(fi), is_vncr,
+                      0, fi->s1ptw,
                       access_type == MMU_DATA_STORE, fsc);
 
         env->cp15.mfar_el3 = fi->paddr;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2938397d52c..27335e85407 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2294,6 +2294,7 @@ static void handle_sys(DisasContext *s, bool isread,
         MemOp mop = MO_64 | MO_ALIGN | MO_ATOM_IFALIGN;
         ARMMMUIdx armmemidx = s->nv2_mem_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_E2;
         int memidx = arm_to_core_mmu_idx(armmemidx);
+        uint32_t syn;
 
         mop |= (s->nv2_mem_be ? MO_BE : MO_LE);
 
@@ -2301,6 +2302,9 @@ static void handle_sys(DisasContext *s, bool isread,
         tcg_gen_addi_i64(ptr, ptr,
                          (ri->nv2_redirect_offset & ~NV2_REDIR_FLAG_MASK));
         tcg_rt = cpu_reg(s, rt);
+
+        syn = syn_data_abort_vncr(0, !isread, 0);
+        disas_set_insn_syndrome(s, syn);
         if (isread) {
             tcg_gen_qemu_ld_i64(tcg_rt, ptr, memidx, mop);
         } else {
-- 
2.34.1


