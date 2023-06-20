Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 993AD73662F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh8-0003qJ-7W; Tue, 20 Jun 2023 04:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh0-0003ni-El
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:28 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgx-00067E-1V
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:25 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-983f499fc81so535576466b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249581; x=1689841581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xr8xkNcKwgwoONsVtAD+H1pU4pyhmWsZaQ/1NBOXoO8=;
 b=SNchMFtpq+YpYDD5cqfhFy1e+puZ3IdyR7RxYW6koa+HpGNGEENwrCgmulZUwhp5zj
 c5dI6Q5whyE1Y3ulYs256Bq1eGpWc7Q3zlCnn/N6vOSZe3CmQWzY4mBj6IUilEd/lF/w
 dtdBesLMJMf65puafKXVhwR4ykuZ8/IyOdz1CrsfOiq8UhrQ/bFgVU0A28str0LQKApZ
 m4RU+MJ3LruSc28a6z+XIrAI1dyJFTwUTuYCqPmfXdlBCJNYBME8Q265mTdjwctisXHZ
 UQRN4p10EXAc96BZcOiCO0sK4AloIi/CnGwpW94f7wI2tPocCDkubIhpOQAg+ZcfXJdl
 CXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249581; x=1689841581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xr8xkNcKwgwoONsVtAD+H1pU4pyhmWsZaQ/1NBOXoO8=;
 b=WHror7E7cbZbh581TjqLcVrn5LAWVMmNsFeSDCNr8jAsLSYl/zTUlazGk8z9b09jgE
 UkdJ9Kn6q5n91MkkWXqKznKZHoYVbnztx3kFkb44lLQ76YtFVjqi2XnBC7YeEkWLVM3J
 ITd8bCwFfZVme+TfK+snOG8UgHoobRYTB/+q5UpiGRW0tF+vnVRUgMXT3e+yHXHk6U4l
 VFhyEZ8z54JfiVzz41V4DGHdsP0lvqdsz4s5/trkGtoXfFsXgjtQYudUivFx5t7XurLT
 PqIO9US2NTZM4qDC6leHRHwq6cdeFJ8pSQJAb1uOGfcRFKK2RoWpBJsTFRrn9nFV28+I
 TJHw==
X-Gm-Message-State: AC+VfDwvIu/4vGYIbEXcOzCOyXQhIcu86qotWkbu3nVSbKMpqjFQvbEz
 la7uWPaexza05TLAiPurHJFIFuwFodFotvN4G5kFQlRO
X-Google-Smtp-Source: ACHHUZ7xKmd6ZeCk7a157+SxpHAkap0olzEUtMmMlr4yXHV4FjayOaZ346XwXUN4F/qW7nR8D9OfFA==
X-Received: by 2002:a17:906:27ca:b0:977:e2a6:47ce with SMTP id
 k10-20020a17090627ca00b00977e2a647cemr8944534ejc.35.1687249581460; 
 Tue, 20 Jun 2023 01:26:21 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/16] hw/core/cpu: Check for USER_ONLY definition instead of
 SOFTMMU one
Date: Tue, 20 Jun 2023 10:26:03 +0200
Message-Id: <20230620082611.770620-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

Invert the #ifdef'ry in TCGCPUOps structure for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230613133347.82210-6-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h         |   4 +-
 include/hw/core/tcg-cpu-ops.h | 102 +++++++++++++++++-----------------
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d84fbccaab..4871ad85f0 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1016,7 +1016,7 @@ void page_size_init(void);
 
 #ifdef NEED_CPU_H
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 
 extern const VMStateDescription vmstate_cpu_common;
 
@@ -1027,7 +1027,7 @@ extern const VMStateDescription vmstate_cpu_common;
     .flags = VMS_STRUCT,                                                    \
     .offset = 0,                                                            \
 }
-#endif /* CONFIG_SOFTMMU */
+#endif /* !CONFIG_USER_ONLY */
 
 #endif /* NEED_CPU_H */
 
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 0ae08df47e..3e8b1b737a 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -64,7 +64,56 @@ struct TCGCPUOps {
      */
     void (*do_interrupt)(CPUState *cpu);
 #endif /* !CONFIG_USER_ONLY || !TARGET_I386 */
-#ifdef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
+    /**
+     * record_sigsegv:
+     * @cpu: cpu context
+     * @addr: faulting guest address
+     * @access_type: access was read/write/execute
+     * @maperr: true for invalid page, false for permission fault
+     * @ra: host pc for unwinding
+     *
+     * We are about to raise SIGSEGV with si_code set for @maperr,
+     * and si_addr set for @addr.  Record anything further needed
+     * for the signal ucontext_t.
+     *
+     * If the emulated kernel does not provide anything to the signal
+     * handler with anything besides the user context registers, and
+     * the siginfo_t, then this hook need do nothing and may be omitted.
+     * Otherwise, record the data and return; the caller will raise
+     * the signal, unwind the cpu state, and return to the main loop.
+     *
+     * If it is simpler to re-use the sysemu tlb_fill code, @ra is provided
+     * so that a "normal" cpu exception can be raised.  In this case,
+     * the signal must be raised by the architecture cpu_loop.
+     */
+    void (*record_sigsegv)(CPUState *cpu, vaddr addr,
+                           MMUAccessType access_type,
+                           bool maperr, uintptr_t ra);
+    /**
+     * record_sigbus:
+     * @cpu: cpu context
+     * @addr: misaligned guest address
+     * @access_type: access was read/write/execute
+     * @ra: host pc for unwinding
+     *
+     * We are about to raise SIGBUS with si_code BUS_ADRALN,
+     * and si_addr set for @addr.  Record anything further needed
+     * for the signal ucontext_t.
+     *
+     * If the emulated kernel does not provide the signal handler with
+     * anything besides the user context registers, and the siginfo_t,
+     * then this hook need do nothing and may be omitted.
+     * Otherwise, record the data and return; the caller will raise
+     * the signal, unwind the cpu state, and return to the main loop.
+     *
+     * If it is simpler to re-use the sysemu do_unaligned_access code,
+     * @ra is provided so that a "normal" cpu exception can be raised.
+     * In this case, the signal must be raised by the architecture cpu_loop.
+     */
+    void (*record_sigbus)(CPUState *cpu, vaddr addr,
+                          MMUAccessType access_type, uintptr_t ra);
+#else
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
     /**
@@ -121,56 +170,7 @@ struct TCGCPUOps {
      */
     bool (*io_recompile_replay_branch)(CPUState *cpu,
                                        const TranslationBlock *tb);
-#else
-    /**
-     * record_sigsegv:
-     * @cpu: cpu context
-     * @addr: faulting guest address
-     * @access_type: access was read/write/execute
-     * @maperr: true for invalid page, false for permission fault
-     * @ra: host pc for unwinding
-     *
-     * We are about to raise SIGSEGV with si_code set for @maperr,
-     * and si_addr set for @addr.  Record anything further needed
-     * for the signal ucontext_t.
-     *
-     * If the emulated kernel does not provide anything to the signal
-     * handler with anything besides the user context registers, and
-     * the siginfo_t, then this hook need do nothing and may be omitted.
-     * Otherwise, record the data and return; the caller will raise
-     * the signal, unwind the cpu state, and return to the main loop.
-     *
-     * If it is simpler to re-use the sysemu tlb_fill code, @ra is provided
-     * so that a "normal" cpu exception can be raised.  In this case,
-     * the signal must be raised by the architecture cpu_loop.
-     */
-    void (*record_sigsegv)(CPUState *cpu, vaddr addr,
-                           MMUAccessType access_type,
-                           bool maperr, uintptr_t ra);
-    /**
-     * record_sigbus:
-     * @cpu: cpu context
-     * @addr: misaligned guest address
-     * @access_type: access was read/write/execute
-     * @ra: host pc for unwinding
-     *
-     * We are about to raise SIGBUS with si_code BUS_ADRALN,
-     * and si_addr set for @addr.  Record anything further needed
-     * for the signal ucontext_t.
-     *
-     * If the emulated kernel does not provide the signal handler with
-     * anything besides the user context registers, and the siginfo_t,
-     * then this hook need do nothing and may be omitted.
-     * Otherwise, record the data and return; the caller will raise
-     * the signal, unwind the cpu state, and return to the main loop.
-     *
-     * If it is simpler to re-use the sysemu do_unaligned_access code,
-     * @ra is provided so that a "normal" cpu exception can be raised.
-     * In this case, the signal must be raised by the architecture cpu_loop.
-     */
-    void (*record_sigbus)(CPUState *cpu, vaddr addr,
-                          MMUAccessType access_type, uintptr_t ra);
-#endif /* CONFIG_SOFTMMU */
+#endif /* !CONFIG_USER_ONLY */
 #endif /* NEED_CPU_H */
 
 };
-- 
2.34.1


