Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4C70DE6F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1STM-0006tY-S5; Tue, 23 May 2023 09:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSV-00056C-EO
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:52 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SST-00031A-OT
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:51 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso6821333b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850028; x=1687442028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OszBk/d2Y8+QVrgN8+lEyjMHe0GfWFJfnXUVK38CHQc=;
 b=sm5FSgIlg11c4ZRFqRvCW1uiVqXvvg4qvCqPvEDUbtalYk+p4NOqXdCCrtO0Mgiizy
 htj4RbbCYb0q73eDu4Yg1529WX309H3qt8t7RX8eNNAT0h78y26YvVDODnjSL7AP7iYu
 kTD70DQnJpg3V0f6zl7Bzgp/ngoVBIYgSvMO0qFqiWMQdZV1mzhkcQflWJ/4u7OHcCq6
 aXsa8KkZPVQRsRTl6M5WgmFrmQRrnE7GDD4TabaiLJ0vFV+M5mzlgLNxcAmlzk5BS1/W
 i3kQjrqabiGCXBeYNrz3E9OY9JKaXbI6L2gXrlBj6pVqeFYt0kRAJwx+p2laJMD3E+hd
 Zpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850028; x=1687442028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OszBk/d2Y8+QVrgN8+lEyjMHe0GfWFJfnXUVK38CHQc=;
 b=jLaqZGFaJxJ9Y/9tKnvtxlD8ruhmAHgcDluL2SQZsuSh2TjsQvRY97azLKTZYYEwan
 7/GEDc98PvZOazc0MXolC0s/jxJy1WLjSiq21tVnbnU+Ou3nH+HXOUlZvH1aOp6IFKSE
 uQhZMGB6VKITROS4aqLFOPSVLWUk7ApzHvxexfzPScA6qohWkvLNGOR7zmvEHYITjedS
 mXXzKLi2ICgYnDhj1AiKCtqSsgcdT5sl4xk7YuFm1QRlm/Wq8Ygw6C5AgwKZnTENeYbG
 tVDdpNHN9VNg9wa+ig7bUlpCiOcMMUct7SwWvYE1k5iZ8TWjUkEByrqQv/grrY8I1vJ7
 Rcfg==
X-Gm-Message-State: AC+VfDxO0GBUbNvV7SRc/pKzlpa43rRoqJiShuB4ME3NCrPGTpqMD/58
 OpTjwrpxHtGYF7B9QqqL1y+mhX09KtFaF87J53s=
X-Google-Smtp-Source: ACHHUZ5ru8y2wHnLks3vVl9vNwS4DE4R0Mkbalu6SHEiMIlRUE+NEN4lym4y61HR2VlQQx4TUK5jSw==
X-Received: by 2002:a05:6a00:23d5:b0:641:39cb:1716 with SMTP id
 g21-20020a056a0023d500b0064139cb1716mr17151386pfc.20.1684850028546; 
 Tue, 23 May 2023 06:53:48 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/52] tcg: Remove NO_CPU_IO_DEFS
Date: Tue, 23 May 2023 06:53:00 -0700
Message-Id: <20230523135322.678948-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index 181f276b18..347768b979 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 
-#define NO_CPU_IO_DEFS
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3888a22ba1..a976e851d5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -37,12 +37,6 @@
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


