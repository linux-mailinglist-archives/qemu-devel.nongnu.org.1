Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD37230F7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gd9-00027k-Qk; Mon, 05 Jun 2023 16:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcm-0001w5-HP
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:21 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gci-0003wa-Gv
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:19 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-651e298be3fso5056884b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996176; x=1688588176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQUG9TNMAhGpe5iTw0NjCb9NduwuP3cDZzAY6JDjg7s=;
 b=A1ibxh1Qkibzo2eHJdY2uXXamA4TxyfF2AkSKBFzeSHfaMGqAuIfwXEK3snz7JwE4x
 2bU3HPF+pKQvVIYbuJGEQ+fQZ9EpQalQj6jQtXkRGgTMsUq+sAFfrjHUT5voJydTVyP3
 S9i/x/FwShNCuNIByONhPE6/x0AJPaO1q1Da0ff8TYZIDtfK1GE8An2FVVKdO3FU/sqe
 3DkM7K85tycCaZHlZRsNAErPOF16vYlt7N2wzKB2zQ9qEMWcLPi33spdni63W65E/ZK8
 svDPevKuejrM6s235bkbG19o/Jt6mV6w/f7MUlNUsJQVEs1n2ii1rfnm1jwYu6S23vuU
 Rlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996176; x=1688588176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQUG9TNMAhGpe5iTw0NjCb9NduwuP3cDZzAY6JDjg7s=;
 b=CRUYJJp0l97VPJ9NTsfyVrIJYmtnJyh4PLcxHLKI4zLPRDGGp62us0LSbtpkcvlMNI
 jV1Gh+th162mUMO02juixjQikT+GNQVOz/dev1pvVgETxVDex4ofDcTMi5Uss1bq9gKp
 RRipVZ7y+Ul1e3bxeHpdPfRO0EDFReZMYBa9egOCsUgPIdNVPx+w18diREDvkt2pRH2g
 wvdIuhKoeld06RJgNSjE/oO7VxetRGZk5u/psmz0IyfiAOk2/nuo8g2HjpLi/S+i32a8
 cW/xwe7Nx3mAnhknh70uM4IrORUKeOkedAMsgixvTkQzD8F/NNQ8RUptjEs3dgVMHKnE
 CwOw==
X-Gm-Message-State: AC+VfDwf9HW+AuQIyn2GXLqVr1dIfM5UWvYAKy1s0JHvuhPEsbXyy2CY
 Z3GOf4RazTouNkFEoGPg19MfTWcQI+zaaqsI0NU=
X-Google-Smtp-Source: ACHHUZ7+rSpCBTDBfjv7uwpynmdZvd/jpTQX+FTYXBw7gV18f0YtgHcL308uFD6Niw2EFImJUBwemw==
X-Received: by 2002:a05:6a00:2292:b0:643:9e7c:3829 with SMTP id
 f18-20020a056a00229200b006439e7c3829mr1014996pfe.12.1685996175735; 
 Mon, 05 Jun 2023 13:16:15 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/52] tcg: Remove NO_CPU_IO_DEFS
Date: Mon,  5 Jun 2023 13:15:26 -0700
Message-Id: <20230605201548.1596865-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From this remove, it's no longer clear what this is attempting
to protect.  The last time a use of this define was added to
the source tree, as opposed to merely moved around, was 2008.
There have been many cleanups since that time and this is
no longer required for the build to succeed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h          | 2 --
 target/sparc/cpu.h        | 2 --
 accel/tcg/translate-all.c | 1 -
 tcg/tcg.c                 | 6 ------
 4 files changed, 11 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0f9f2e1a0c..10c4ffa148 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1394,7 +1394,6 @@ void ppc_store_msr(CPUPPCState *env, target_ulong value);
 void ppc_cpu_list(void);
 
 /* Time-base and decrementer management */
-#ifndef NO_CPU_IO_DEFS
 uint64_t cpu_ppc_load_tbl(CPUPPCState *env);
 uint32_t cpu_ppc_load_tbu(CPUPPCState *env);
 void cpu_ppc_store_tbu(CPUPPCState *env, uint32_t value);
@@ -1435,7 +1434,6 @@ int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
 hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
                                         ppcmas_tlb_t *tlb);
 #endif
-#endif
 
 void ppc_store_fpscr(CPUPPCState *env, target_ulong val);
 void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index fb98843dad..3d090e8278 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -581,7 +581,6 @@ G_NORETURN void sparc_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                               uintptr_t retaddr);
 G_NORETURN void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t);
 
-#ifndef NO_CPU_IO_DEFS
 /* cpu_init.c */
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 void sparc_cpu_list(void);
@@ -637,7 +636,6 @@ static inline int tlb_compare_context(const SparcTLBEntry *tlb,
     return compare_masked(context, tlb->tag, MMU_CONTEXT_MASK);
 }
 
-#endif
 #endif
 
 /* cpu-exec.c */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 200de2793c..c4d081f5ad 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 
-#define NO_CPU_IO_DEFS
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a339e3e3d8..41186f540f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -34,12 +34,6 @@
 #include "qemu/cacheflush.h"
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
-
-/* Note: the long term plan is to reduce the dependencies on the QEMU
-   CPU definitions. Currently they are used for qemu_ld/st
-   instructions */
-#define NO_CPU_IO_DEFS
-
 #include "exec/exec-all.h"
 #include "exec/tlb-common.h"
 #include "tcg/tcg-op-common.h"
-- 
2.34.1


