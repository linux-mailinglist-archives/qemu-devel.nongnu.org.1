Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75771723327
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 00:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6IdF-0008TY-Ls; Mon, 05 Jun 2023 18:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6IdD-0008Rk-BU
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:55 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6IdA-00069F-0l
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:55 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f3b4ed6fdeso6800833e87.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686003890; x=1688595890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJBqBbChR/+wuwcjMNAnFqc7wtXYEDeITPWhBBf8hLU=;
 b=MGRvKQL1GTbt8xk3yQvUqFybiP4dmWsLbCaQFam5l1KqDQswGCOYceIQ8AFwchwpwr
 aaZPrghoYYvTXeRRm5eFYpZQ2Z2Wo8sogRnmfkDSQYh6PgVsDG5dZKpPCkSZ2ylrbziw
 9WSfPWLLvKe3OEruR8KDQQtSo2QcA6FfbgJYAsOjjjo63lmV2LA7ujgaf0pZfVE51fm0
 qWqAi/vAtzSzX381nZrwE1IjbIrVrZpusfIR6QzRsz35pUMHiiRMU8JuGFKCovcwUaCY
 TFDPABQl7eFnieyuTSWpOXJP3lPsiaMaknAiqTET+dRqR1F6Z5m41kNdtOVy8SkP1SLR
 8S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686003890; x=1688595890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJBqBbChR/+wuwcjMNAnFqc7wtXYEDeITPWhBBf8hLU=;
 b=XdtzKY+5HU0Qeu9ffrL47pInAk6GyAH+wz3gtHAQKRpoazvL0EPA1enH0r8Vwrwvx7
 2Auca7xKjN4zB3Q2pjwy43L7Z6vHydIDsVy+EPZ2vHEuhHSqjBx0TgVffbsOZJ2ujjRu
 dCBuUB+vmOyKyxP8HwNDTmWYsJhcGT5rvrAB2puvSD2Eh2As94+VDTMD0BqlsSVESTaX
 vFEyVMoshM43KkSVT20Fl2ntvwUFaRlSIt0Pp8XjR3HKaN5rh3nXLpeRYEdyVgzJpfZm
 1Dlz9k/Au/cCBBqwGmVg69RLRBL2jwIuZoegc+UPkr26HsiHQyJYHe4SulUGIecOGt3x
 B51w==
X-Gm-Message-State: AC+VfDxb9y/iDNTzvuaYh1YrWWA8DPDJei5Nlox6wlcE2NFpYX5CwUzH
 Jxl/uUkjxMQi/mfephED3H0f/51hclnPnI9qw5c=
X-Google-Smtp-Source: ACHHUZ6KwmXfhSTqJdcO8nN1K9TJHWyKY3Vz9X9Wo7c12+vDkUPjtfnbHJwkJHtEDBTRDQkyvC5WTw==
X-Received: by 2002:a05:651c:22d:b0:2b1:d4fc:75f2 with SMTP id
 z13-20020a05651c022d00b002b1d4fc75f2mr346883ljn.7.1686003889974; 
 Mon, 05 Jun 2023 15:24:49 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a1cf608000000b003f42d8dd7d1sm15483144wmc.7.2023.06.05.15.24.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 15:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 5/9] hw/core/cpu: Check for USER_ONLY definition
 instead of SOFTMMU one
Date: Tue,  6 Jun 2023 00:24:16 +0200
Message-Id: <20230605222420.14776-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605222420.14776-1-philmd@linaro.org>
References: <20230605222420.14776-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

Invert the #ifdef'ry in TCGCPUOps structure for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h         |   4 +-
 include/hw/core/tcg-cpu-ops.h | 102 +++++++++++++++++-----------------
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 383456d1b3..f41b0c56f7 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1014,7 +1014,7 @@ void page_size_init(void);
 
 #ifdef NEED_CPU_H
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 
 extern const VMStateDescription vmstate_cpu_common;
 
@@ -1025,7 +1025,7 @@ extern const VMStateDescription vmstate_cpu_common;
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
2.38.1


