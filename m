Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E857D7174DA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4C-0007Yr-7h; Wed, 31 May 2023 00:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D43-0007L9-4T
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:59 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3z-0006FQ-Iw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:57 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-394c7ba4cb5so1849848b6e.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505834; x=1688097834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pswqf03JvYtX7swRW45vcnt5ypXRAWN6cAPEoKWRXIQ=;
 b=MnT/oEYPfoRklN0pS3IHL8YrRxjz/BbyvfwV4idW8Bldaxg3cgsUSGagk/wpxRUKjE
 MlZCQTOzyqfBmxOItkz2eP6oeTWNneIlYstmGxwQl7Sfx1gkugK49oyxo+O6C2TxGyNb
 PaciKP16mOGZEQ6m0iuqcuj7mxZ4HR+JL4ber7R15iFibsI2X7G1M892bTL9mNM0ddMF
 e0T4kHaeuxNVKvCCBWj7hkvlQJF1q84a2OWgkIKS1JNO7Oj3VDtaWLEafVFg+Q8kJmcc
 Xt4FyoTHdSmtVCmpRMqBFf//gaxMoaZraS3BqC2pDb5wKU1sovdlKBva3WI17Det0/7+
 VY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505834; x=1688097834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pswqf03JvYtX7swRW45vcnt5ypXRAWN6cAPEoKWRXIQ=;
 b=FeOO7oFagjdGAN+H00Z2TEEQ6k06N6bwzd2UNGYpYiT7UweFHVRcmZRTcdHzrQpdOU
 nWufCWLIbFIIrxVENev1c9OvHMw68ORWyy1zVkT2vR2QFQO+HVgJIm+UKOaCZP/+XLGd
 YEp/4adCcuNY54WxJwJBhZBpQVUS4qaRytkd3KK2SZfR3AUxmyCKTd6z2orCH8IOl7w/
 n0BusO4gxinxt2rzMO27pdCet/5U6RKQKi5v6B/YZO30yIPujV2LPBCBj6PysMIjMv6j
 MjvM7K9WwaAnoliHY84yWtyt/r+LuBuqquEzZ+BBtfW2imDCgrx0chivmol2VSi3CDy4
 QdqA==
X-Gm-Message-State: AC+VfDz36umoo9s+mWqP7HeWt20Qm93jN10HoHL/Rw8gjUYY73JEdasr
 KzAmSfyTzMh4G1jm1J4pqfb2II/mwm6CVUd9z6M=
X-Google-Smtp-Source: ACHHUZ6yXVmhRkG8rWODYQRWrBmSdPcR0dqkO3lH1oNliGlUB3WeAqDtJzH5tcnDp5Lk2eeoVGkiaA==
X-Received: by 2002:a05:6808:bc3:b0:396:d10:43a0 with SMTP id
 o3-20020a0568080bc300b003960d1043a0mr2990416oik.46.1685505833767; 
 Tue, 30 May 2023 21:03:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 29/48] tcg: Remove NO_CPU_IO_DEFS
Date: Tue, 30 May 2023 21:03:11 -0700
Message-Id: <20230531040330.8950-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
index 7ea927be3c..dd19b3ca78 100644
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


