Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A39E7676D8
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPTYw-0002uF-6L; Fri, 28 Jul 2023 15:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPTYu-0002to-0V
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:55:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPTYs-0003Z6-CL
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:55:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686f1240a22so2201383b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690574139; x=1691178939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fGebRBySZ8EIc+SS0XHAneWNrFn+xa0T4f+s5LNl++U=;
 b=xbn1E6NLzzBlzMsCJH5MUJbVlPTbZ/tprjPg46osoEByZg6HSktu6QdHbpnf/wMRmd
 3xuSQ9jloCdp53/nqyh3H4YQh4G01xnzSE2J5VqQvNoklZqucRgOBpJM11rKSGuUAHj2
 ZcuXRXbzFfWG+EUNqz/9Uw3/h/Jm/krIhMr15mJOfaDWKicPSiAXWEGVOBpNh/MH3V6Z
 el1Sf5uWrJBUhrVbO752REyrt8TOAMxKzk4PrafVTpyRFo5dkdvO3eLSWJQkagepjKDx
 lNTACt58NiU8s2Qu+hqKGUz8qzjDWcj3ARyQbo2SFa8v/5ASKTxJyiFlmCu3B8jkUM7e
 d0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690574139; x=1691178939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGebRBySZ8EIc+SS0XHAneWNrFn+xa0T4f+s5LNl++U=;
 b=FCMPcFduq5lc0s5ghTlxBn0f/LXLQRxqhtQzZxvBbzeliBHxPey9JQfjhzsnYKU5a8
 WrecMPhuBFd5wI6/gs4fRVuVOIZmgM85qaNqZXfks3gBAEYLyNGlAJmdtxWbMvDzJDwr
 YevKt3nPIQS7vWnriX/ARZCLhwbmd7vVmqsbtA3vYLT0TARwgS945rJcyNCcfIBzm2Sr
 UDFpVtne8CXR2ZdLaP7bBgteULkkpKROTooY9WZx5qI2bQ8GSmLIcZD8p4eoHhPi6ptX
 j5keVvubIjZ1XJkxWReVCoGVR/bEn3n784HJ/vQgUtmptbt3Tzb3Ph/BAEHoIdmAya2c
 jSRA==
X-Gm-Message-State: ABy/qLad78Ohq147tlVO/iQdpuFep6ztRSYoKN5iTtfwkCM8HqvVUc3j
 cwmhKu4KYymOhgAIgz70peCQekp8dMCx0tKaoF4=
X-Google-Smtp-Source: APBJJlFMU9mOYSm7RsGgu/mDPVtzq9lUWCoBGdyEqHGQj5CLjOBLvgduuWoHZy7nFbN3sHIoYnDiEg==
X-Received: by 2002:a17:902:e88e:b0:1b8:b459:f47a with SMTP id
 w14-20020a170902e88e00b001b8b459f47amr3479914plg.34.1690574139405; 
 Fri, 28 Jul 2023 12:55:39 -0700 (PDT)
Received: from stoup.. ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001b54a88e6adsm3935255plc.309.2023.07.28.12.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 12:55:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, david@redhat.com, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH] target/s390x: Move trans_exc_code update to
 do_program_interrupt
Date: Fri, 28 Jul 2023 12:55:38 -0700
Message-Id: <20230728195538.488932-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

This solves a problem in which the store to LowCore during tlb_fill
triggers a clean-page TB invalidation for page0 during translation,
which results in an assertion failure for locked pages.

By delaying the store until after the exception has been raised,
we will have unwound the pages locked for translation and the
problem does not arise.  There are plenty of other updates to
LowCore while delivering an interrupt/exception; trans_exc_code
does not need to be special.

Reported-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/excp_helper.c | 42 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 3da337f7c7..b260bf7331 100644
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
@@ -211,20 +206,34 @@ static void do_program_interrupt(CPUS390XState *env)
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
+    case PGM_TRANS_SPEC:
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
@@ -236,18 +245,21 @@ static void do_program_interrupt(CPUS390XState *env)
     case PGM_HFP_EXP_UNDERFLOW:
     case PGM_HFP_SIGNIFICANCE:
     case PGM_HFP_DIVIDE:
-    case PGM_TRANS_SPEC:
     case PGM_SPECIAL_OP:
     case PGM_OPERAND:
     case PGM_HFP_SQRT:
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


