Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE787C80FF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:56:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqI-0008L0-I8; Fri, 13 Oct 2023 04:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq2-0007ja-1f
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:07 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpx-0000sK-QX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso305906866b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186879; x=1697791679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnPZdFP4zSVSLnrMNIBydzoPP2JRWCq+Jkwh11CTa9k=;
 b=w2y5qOcydZyOWNo8TaNflmn1s5sivrPqTfyd0c/tRNmW5qXsMhe1bKxNsQUNvHmfzJ
 QJfe/wpo6acBY3L5C++vuJZ9H247RO7rZWveuSMFU6CmSo7ma7iR0VR7vRNhoCrydQrh
 wJlE4RuoZCRziFrgVwtioV2q21SxeHAP7EqBnXrG6aznsvNAyBND5swprK3sZPLJqMJf
 /AlIBtZ5qK1FLlhaCuiawEfshzQC2JXcx/GUHR6AkF6+OzBhoGHTQAhD+BPjcPx2i8MI
 PjOYCrxnu+ESAHrEvATOwdSPLCPFWUu4rdm/44ytPo7UobATt9gHDspQciJ15/ho2s/w
 91MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186879; x=1697791679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnPZdFP4zSVSLnrMNIBydzoPP2JRWCq+Jkwh11CTa9k=;
 b=Nginx4vszseVAuykDjNt1hMYcT8QnZXg5jkpGnDKrEgBriaiRzB1WkUGTsbY+mIb0D
 ZpoU5HcS+q9bled3kLAwZUgd+7Af9qfi6LyEExE70aZsBLDPhe8QIPzX6zUjEbhRzq+T
 dta6CXdFzcmyt2/9B7WXy2EdhIVIG4N4d2ld09Nq+KPLXxPYCCaT6TNryC8pi+SKzFn1
 Ukzk/yweNS3VirK842/zGdH85d5fuKJZyqdzrQh813CnsaALCf4GUrRo+sfHSkWRDeG7
 +xLGjfP8YLJ9erJ8sjK95zzdHlK1HgiPglymrxe7f0JhgbqJd9WRkOJ0sycbTKx2+Rkq
 Codg==
X-Gm-Message-State: AOJu0YyQJCwlpTLYtg04eVCbL99jjrH78MQ7ADgUE5pK99BhfsfUPGTF
 4WX9kEbDjD+DkrzIylyxxfkXUzN4S8qvf3d+mzA=
X-Google-Smtp-Source: AGHT+IE+RUNrof+2JNTzxJWpzAVieh57+4ZSfAWV7LweCfiz3homKVArpEf6aV35gRO/+sKdqJBM+Q==
X-Received: by 2002:a17:906:31cc:b0:9ae:56da:6068 with SMTP id
 f12-20020a17090631cc00b009ae56da6068mr15912136ejf.57.1697186878756; 
 Fri, 13 Oct 2023 01:47:58 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:58 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [RFC PATCH v3 26/78] target/s390x: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:54 +0300
Message-Id: <c07f2b29188ba9072ae9470f1b5ba8e4a155dba6.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/s390x/cpu.c                  |  4 ++--
 target/s390x/kvm/kvm.c              |  2 +-
 target/s390x/mmu_helper.c           |  6 +++---
 target/s390x/tcg/translate.c        | 18 +++++++++++-------
 target/s390x/tcg/translate_vx.c.inc |  2 +-
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4f7599d72c..01df983991 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -162,7 +162,7 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
     switch (type) {
     case S390_CPU_RESET_CLEAR:
         memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fields));
-        /* fall through */
+        fallthrough;
     case S390_CPU_RESET_INITIAL:
         /* initial reset does not clear everything! */
         memset(&env->start_initial_reset_fields, 0,
@@ -187,7 +187,7 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
         /* tininess for underflow is detected before rounding */
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
-       /* fall through */
+        fallthrough;
     case S390_CPU_RESET_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
         memset(&env->start_normal_reset_fields, 0,
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index bc5c56a305..11b2c05df6 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1086,7 +1086,7 @@ static int s390_kvm_irq_to_interrupt(struct kvm_s390_irq *irq,
     switch (irq->type) {
     case KVM_S390_INT_VIRTIO:
         interrupt->parm = irq->u.ext.ext_params;
-        /* fall through */
+        fallthrough;
     case KVM_S390_INT_PFAULT_INIT:
     case KVM_S390_INT_PFAULT_DONE:
         interrupt->parm64 = irq->u.ext.ext_params2;
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index fbb2f1b4d4..5833917552 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -199,7 +199,7 @@ static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
             *flags &= ~PAGE_WRITE;
         }
         gaddr = (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION2_TX(vaddr) * 8;
-        /* fall through */
+        fallthrough;
     case ASCE_TYPE_REGION2:
         if (!read_table_entry(env, gaddr, &entry)) {
             return PGM_ADDRESSING;
@@ -218,7 +218,7 @@ static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
             *flags &= ~PAGE_WRITE;
         }
         gaddr = (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION3_TX(vaddr) * 8;
-        /* fall through */
+        fallthrough;
     case ASCE_TYPE_REGION3:
         if (!read_table_entry(env, gaddr, &entry)) {
             return PGM_ADDRESSING;
@@ -248,7 +248,7 @@ static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
             return PGM_SEGMENT_TRANS;
         }
         gaddr = (entry & REGION_ENTRY_ORIGIN) + VADDR_SEGMENT_TX(vaddr) * 8;
-        /* fall through */
+        fallthrough;
     case ASCE_TYPE_SEGMENT:
         if (!read_table_entry(env, gaddr, &entry)) {
             return PGM_ADDRESSING;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4bae1509f5..986d6433d2 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -576,6 +576,7 @@ static void gen_op_calc_cc(DisasContext *s)
     default:
         dummy = tcg_constant_i64(0);
         /* FALLTHRU */
+        fallthrough;
     case CC_OP_ADD_64:
     case CC_OP_SUB_64:
     case CC_OP_ADD_32:
@@ -820,6 +821,7 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         /* Calculate cc value.  */
         gen_op_calc_cc(s);
         /* FALLTHRU */
+        fallthrough;
 
     case CC_OP_STATIC:
         /* Jump based on CC.  We'll load up the real cond below;
@@ -1323,7 +1325,7 @@ static void compute_carry(DisasContext *s)
         break;
     default:
         gen_op_calc_cc(s);
-        /* fall through */
+        fallthrough;
     case CC_OP_STATIC:
         /* The carry flag is the msb of CC; compute into cc_src. */
         tcg_gen_extu_i32_i64(cc_src, cc_op);
@@ -2612,13 +2614,13 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        fallthrough;
     case S390_FEAT_TYPE_KMCTR:
         if (r3 & 1 || !r3) {
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        fallthrough;
     case S390_FEAT_TYPE_PPNO:
     case S390_FEAT_TYPE_KMF:
     case S390_FEAT_TYPE_KMC:
@@ -2628,7 +2630,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        fallthrough;
     case S390_FEAT_TYPE_KMAC:
     case S390_FEAT_TYPE_KIMD:
     case S390_FEAT_TYPE_KLMD:
@@ -2636,7 +2638,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        fallthrough;
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
         break;
@@ -4585,12 +4587,12 @@ static void compute_borrow(DisasContext *s)
         break;
     default:
         gen_op_calc_cc(s);
-        /* fall through */
+        fallthrough;
     case CC_OP_STATIC:
         /* The carry flag is the msb of CC; compute into cc_src. */
         tcg_gen_extu_i32_i64(cc_src, cc_op);
         tcg_gen_shri_i64(cc_src, cc_src, 1);
-        /* fall through */
+        fallthrough;
     case CC_OP_ADDU:
         /* Convert carry (1,0) to borrow (0,-1). */
         tcg_gen_subi_i64(cc_src, cc_src, 1);
@@ -6486,11 +6488,13 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_TOO_MANY:
         update_psw_addr(dc);
         /* FALLTHRU */
+        fallthrough;
     case DISAS_PC_UPDATED:
         /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
            cc op type is in env */
         update_cc_op(dc);
         /* FALLTHRU */
+        fallthrough;
     case DISAS_PC_CC_UPDATED:
         /* Exit the TB, either by raising a debug exception or by return.  */
         if (dc->exit_to_mainloop) {
diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
index e073e5ad3a..75463b4f5c 100644
--- a/target/s390x/tcg/translate_vx.c.inc
+++ b/target/s390x/tcg/translate_vx.c.inc
@@ -686,7 +686,7 @@ static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
             enr = 0;
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
-- 
2.39.2


