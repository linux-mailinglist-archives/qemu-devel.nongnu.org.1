Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D975876A258
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa2D-0000v2-Pi; Mon, 31 Jul 2023 17:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa25-0000tF-Mi
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa23-0006QN-B3
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bc02bd4eafso17988765ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837342; x=1691442142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phI5Yifm8+sVICy6zvS1SqnS1qeRxyYiP8ZIuvl4nQs=;
 b=KfHqb3El5BkLxhdzG4xvyFktdVpP40gjBUM6NITs23RNx/xJynrfsHhF8sTzPwjnor
 cjVZFTxtqpbRjcdJQRPPaPa88zm7HYqP5s/RU+BXpu4zgtut6gfxWJEnnCwji06goVyM
 Stdq19NWoFogVepSwaovXEtcb+FO4gY3fKsYCYIghSjsV7szuWCMAXRdbUuF1hUcFu0V
 Ug0+pP4JN987ZGtc/UgyeNGztLBqNVNx08+Yne50tuYZaA0WuUsdw5q1gndyDqK11CEF
 dtcfz8mgeQzyYXZz+i+o6+fOEr3cIiQ4q6+K1kSLrlNOWzW+voZT8j54xuCMK2Nh0Xaf
 uXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837342; x=1691442142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phI5Yifm8+sVICy6zvS1SqnS1qeRxyYiP8ZIuvl4nQs=;
 b=XqJxReEclGdSnUH3QpEfqUEIh+Th7OL6rq6IHXtLfzREII2RAoSvzgd/3jm+98tDiM
 nIXa6C2qlPGwRlzvcV7CEzwhO3e+nM2O5YKB6THaTdWc7eGPvZVJ95/NqPJLwFIcoKfJ
 uBAgGKu0BzbOyBmJm2JxeOoK/+AuRyDk7gvixY5fnpYWw9Rz0eA5xxyPCIdjgfSu9LKq
 /9kVyxzN3EZY2vSS+0lcAZulu6ENdHy9HgXmBJKlOu7phg8kXX0xQR/HqtgW8MfJD8nh
 N9KsbeRr00aVXBDopLq+zfej4QRqStbg3CBRG0LA7mfAB5btPJcqP3WfewaXgN3mAkTo
 MMQA==
X-Gm-Message-State: ABy/qLYrPPN9RXnZUMBvw9Dr1sUuE+9rX00zusFqcaQw/Mt71+S7ex/d
 8JmhhgZbaqykdNjdroHECc0/ee6Vq3T73EW9oZ4=
X-Google-Smtp-Source: APBJJlHtpzMBsspgjuZARL0YWHlOgPGr58+OVZ8vz/OpnFO9B/gjmP//gRNrFM0Y5X06lIGlFjvK7g==
X-Received: by 2002:a17:902:d490:b0:1b8:a70e:8a7e with SMTP id
 c16-20020a170902d49000b001b8a70e8a7emr13003120plg.66.1690837341872; 
 Mon, 31 Jul 2023 14:02:21 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 10/10] target/s390x: Move trans_exc_code update to
 do_program_interrupt
Date: Mon, 31 Jul 2023 14:02:11 -0700
Message-Id: <20230731210211.137353-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

This solves a problem in which the store to LowCore during tlb_fill
triggers a clean-page TB invalidation for page0 during translation,
which results in an assertion failure for locked pages.

By delaying the store until after the exception has been raised,
we will have unwound the pages locked for translation and the
problem does not arise.  There are plenty of other updates to
LowCore while delivering an interrupt/exception; trans_exc_code
does not need to be special.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/excp_helper.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 3da337f7c7..b7116d0577 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -190,11 +190,6 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         return false;
     }
 
-    if (excp != PGM_ADDRESSING) {
-        stq_phys(env_cpu(env)->as,
-                 env->psa + offsetof(LowCore, trans_exc_code), tec);
-    }
-
     /*
      * For data accesses, ILEN will be filled in from the unwind info,
      * within cpu_loop_exit_restore.  For code accesses, retaddr == 0,
@@ -211,20 +206,33 @@ static void do_program_interrupt(CPUS390XState *env)
     uint64_t mask, addr;
     LowCore *lowcore;
     int ilen = env->int_pgm_ilen;
+    bool set_trans_exc_code = false;
+    bool advance = false;
 
     assert((env->int_pgm_code == PGM_SPECIFICATION && ilen == 0) ||
            ilen == 2 || ilen == 4 || ilen == 6);
 
     switch (env->int_pgm_code) {
     case PGM_PER:
-        if (env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION) {
-            break;
-        }
-        /* FALL THROUGH */
+        advance = !(env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION);
+        break;
+    case PGM_ASCE_TYPE:
+    case PGM_REG_FIRST_TRANS:
+    case PGM_REG_SEC_TRANS:
+    case PGM_REG_THIRD_TRANS:
+    case PGM_SEGMENT_TRANS:
+    case PGM_PAGE_TRANS:
+        assert(env->int_pgm_code == env->tlb_fill_exc);
+        set_trans_exc_code = true;
+        break;
+    case PGM_PROTECTION:
+        assert(env->int_pgm_code == env->tlb_fill_exc);
+        set_trans_exc_code = true;
+        advance = true;
+        break;
     case PGM_OPERATION:
     case PGM_PRIVILEGED:
     case PGM_EXECUTE:
-    case PGM_PROTECTION:
     case PGM_ADDRESSING:
     case PGM_SPECIFICATION:
     case PGM_DATA:
@@ -243,11 +251,15 @@ static void do_program_interrupt(CPUS390XState *env)
     case PGM_PC_TRANS_SPEC:
     case PGM_ALET_SPEC:
     case PGM_MONITOR:
-        /* advance the PSW if our exception is not nullifying */
-        env->psw.addr += ilen;
+        advance = true;
         break;
     }
 
+    /* advance the PSW if our exception is not nullifying */
+    if (advance) {
+        env->psw.addr += ilen;
+    }
+
     qemu_log_mask(CPU_LOG_INT,
                   "%s: code=0x%x ilen=%d psw: %" PRIx64 " %" PRIx64 "\n",
                   __func__, env->int_pgm_code, ilen, env->psw.mask,
@@ -263,6 +275,10 @@ static void do_program_interrupt(CPUS390XState *env)
         env->per_perc_atmid = 0;
     }
 
+    if (set_trans_exc_code) {
+        lowcore->trans_exc_code = cpu_to_be64(env->tlb_fill_tec);
+    }
+
     lowcore->pgm_ilen = cpu_to_be16(ilen);
     lowcore->pgm_code = cpu_to_be16(env->int_pgm_code);
     lowcore->program_old_psw.mask = cpu_to_be64(s390_cpu_get_psw_mask(env));
-- 
2.34.1


