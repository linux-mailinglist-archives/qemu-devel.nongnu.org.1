Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F3F72E442
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:37:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q94C6-0001ba-Bt; Tue, 13 Jun 2023 09:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94Bn-0001GL-Vx
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:36:04 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94Bk-0002dA-Dt
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:36:03 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f62b512fe2so7059583e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686663358; x=1689255358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWPTnkImhuHCo3jirUvcxZ5f588h3TWca2fzH3d9+/s=;
 b=etfl5uxgikvtUSh5hOV/QhteyFz9S9M0LqnpCIT0ZtrgCOwvyNDLTxVeo9njqJKxw5
 Q5C2qZf6cQj7OAylQ5b2oQmqqMlR7IA/FEDc988GbOyaKohV4mBnjRjSefP82yZLYrJX
 m6exBC2d2aKxXRxncBy35zpt/QdbmPuY6bVaCIvY+bUz+IngmpOFRR3Tu89JoUO7yGVK
 cruw8ReX1w0XakBdW5UzvH2mUkJk0VfspJ2XQTjmPvqtzdlZBzId2ep5VWjskeLYemAO
 HaIkFmu3uj8r1rGe4anGHYNxwm4FzzN/F24aqAALAYXJU88i3n0gEQA+58LVqPx7Ne2n
 ZycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686663358; x=1689255358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWPTnkImhuHCo3jirUvcxZ5f588h3TWca2fzH3d9+/s=;
 b=BozmyP128bR0xGq8ZKWwOcPL8qSjzQmu0c0aZFzdLR2mbZo1481YLPHG7RFflYyQAy
 0QP0Uv4Ki8QQYRN/KKkWfRHKsrEbWayTOmRql5kx5lXz5kwgAM4TWpl+V2Fd1AySNL8s
 fYQruVRl5WezCh7XtIj7pYEW7XTL03owqDx+zc7Tx+xwW1TGgm2Wvx/Cyea2+FP0LUQ3
 wHuVM+A4ykpdiZinUjgmVoFx1RW8OMjGsBqGeRaehCa5rT8N10/IWiL2BeKfxiS0XM4y
 55ciRrMsZB6v6I9olHKr9+LUNV4cyQ54M3eVCPgsMgt95P0py892xhx6FAbiWMfxgCxY
 Vzlw==
X-Gm-Message-State: AC+VfDwsZJkGRln9s/jTYB1Vut4QzmAs2NhSpYJQiViPZPHZHc+aw6TY
 R8Y9yTLKhyfoE/A2M5MUAi82uQjs1giL6i64JLU=
X-Google-Smtp-Source: ACHHUZ4h7/WGYQAnWECUDRK1Db5g5x6cIq6gVpli5gyMCHc/xV7gMznDid04VvLG2F95wb2Rwoas0A==
X-Received: by 2002:a19:5e12:0:b0:4f6:d9e:7c3b with SMTP id
 s18-20020a195e12000000b004f60d9e7c3bmr5524079lfb.44.1686663358151; 
 Tue, 13 Jun 2023 06:35:58 -0700 (PDT)
Received: from localhost.localdomain ([213.235.133.109])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a170906a28800b009655eb8be26sm6697881ejz.73.2023.06.13.06.35.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 06:35:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/9] hw/core/cpu: Check for USER_ONLY definition instead of
 SOFTMMU one
Date: Tue, 13 Jun 2023 15:33:43 +0200
Message-Id: <20230613133347.82210-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613133347.82210-1-philmd@linaro.org>
References: <20230613133347.82210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


