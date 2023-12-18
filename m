Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF5B816C65
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:37:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsT-00078P-27; Mon, 18 Dec 2023 06:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsI-000757-H1
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:30 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs9-0003NR-DJ
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:30 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3365424df34so1837606f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899200; x=1703504000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w7vPqwfDU29eCmhOGRZT8teepsBdfyJlwdVmbH4DSvk=;
 b=xafEtW9nUCu79KqhjB5FKCBMxvMwSQv7XvSzGHWmhz251aIcTZpR7NzaSiSx0aT+3q
 hz3i43nyTOUpcb9PDgan03wQ1hvD0uhLnlyLqIkY+5EmKj6E693OwUzOJxIz3gaVjg61
 fh0qOBsFrifWNzMX0xb4VCsm7XV6zOlrY5pgSKpOUlh/cCWTov8SMy9gRFeNYRvfzi2F
 CU0XrdPcL3nq5SMf19Oo4X5186mws9A0JW67+RdaHSSsIjbF1/N5kHDyPng6X3S1EPR1
 oLfJRUpXMyVrFU9xox++vHcFzvuxnGM1AQBh6e3fNNIrwBATFFTnIj3IvsK+yW5U27eL
 yPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899200; x=1703504000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7vPqwfDU29eCmhOGRZT8teepsBdfyJlwdVmbH4DSvk=;
 b=eDMpOUIJzDTvPu9OryImJ1Ipj11erWu3t8EAnGpSD45FPcEoSyC7GjlmySSjxpUszV
 nLmQE9aC4KETGm5TDJ1w6Hiun+oi5kNryUBF69zA+np7wj3Txm/8t6DPgebCUyquPfws
 cfL+SlFW0OCJQEQjuJQjjUZCC7jGKD5xIjj5fh4yu+IjXwrry6Inib5p1P2FUlza0O8d
 fyqcMdn2fygCROQ+QaESXBgqIcb1uifI2mS0yp4Y2rqeZyMiELc/JlZlt89DCqDkHJ9q
 MyaIii863beVNCJneI7eZsY5cycfU48t9ZeuMGGfhj2QPyB6R8puJ9KN2JGH0EiHQPzC
 Y7RQ==
X-Gm-Message-State: AOJu0YwEac8XvnOv6uSeGELBqATHXD8ild/v+hfm3XYhoHr4wv+1M/6g
 Wr5cxVw0XIu0OJnTrHH7t3icfQ==
X-Google-Smtp-Source: AGHT+IEOUerGNtEs2LEXyYqpZ5q+DxexQHeDY/Vvn4WMsETAKX1RjMRSESmXocOe9m5n3hydhOYIQA==
X-Received: by 2002:adf:fac7:0:b0:336:4438:e915 with SMTP id
 a7-20020adffac7000000b003364438e915mr4932119wrs.94.1702899199880; 
 Mon, 18 Dec 2023 03:33:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 27/35] target/arm: Report VNCR_EL2 based faults correctly
Date: Mon, 18 Dec 2023 11:32:57 +0000
Message-Id: <20231218113305.2511480-28-peter.maydell@linaro.org>
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
---
 target/arm/cpu.h               |  4 ++--
 target/arm/syndrome.h          | 20 ++++++++++++++++----
 target/arm/tcg/tlb_helper.c    | 27 +++++++++++++++++++++++++--
 target/arm/tcg/translate-a64.c |  4 ++++
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bc4fa95ea35..da640949518 100644
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
index 128bff4b445..8f905ed9645 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2293,6 +2293,7 @@ static void handle_sys(DisasContext *s, bool isread,
         MemOp mop = MO_64 | MO_ALIGN | MO_ATOM_IFALIGN;
         ARMMMUIdx armmemidx = s->nv2_mem_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_E2;
         int memidx = arm_to_core_mmu_idx(armmemidx);
+        uint32_t syn;
 
         if (s->nv2_mem_be) {
             mop |= MO_BE;
@@ -2302,6 +2303,9 @@ static void handle_sys(DisasContext *s, bool isread,
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


