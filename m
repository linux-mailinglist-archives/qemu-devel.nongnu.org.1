Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE27B6FFD
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFC-00005N-N1; Tue, 03 Oct 2023 13:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF6-0008U3-MO
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:32 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF4-0007XJ-L6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-690b7cb71aeso48139b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354289; x=1696959089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzEQfKezgAt65j3pfMrIbIQsqXw7idxv2pPTvZtkhzo=;
 b=FZeTDFJaK+ckfA6pnBX6woS26qPmHKiShHHQOprA1bpr1vl8W9ApdR1ME6xZZwNP0h
 CsHjfz3T6IjTLYNpD1PLaV6TfXRzHLMBtuagw5vqUEuXeJQb451xEgyFz/y3/zOg86Iu
 KQGL1269eHlm4d9RL573YcyaOBZqru38c/WZt6v+8+K5F/20FxwLRhidCmDyIducZEoY
 Wd/mG0SAJ4nQ1ZLmHNk3w2Ykf/EPkYG5cucAsfekKjQYF9v93hyESKEy9DTQsQY66OSt
 rJ2Y7dCGZYHlGdQuVkVCSQT7uuu5MCpu1or+wdDfhezVA2rM1v1u/PD/GW+IBuz6tc3h
 eYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354289; x=1696959089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzEQfKezgAt65j3pfMrIbIQsqXw7idxv2pPTvZtkhzo=;
 b=YI+xb/n/9hX9alZ3QBoD2HsP6driz+6ZK02TScG26U7V7JbLgmkiqJXnnCOuGist80
 APcdnHpMmlh0Yv70y4jqQ4UbOkc1D89N5vVZaUMK5k3RElbrQfJ8B5Yw/mHf3GfIGeyo
 l8LJb3j2xWogM/RjFXQOXu49En9OroHBVx2pOM+etIJXmwAXJ/xYCvOQL5IQ1Mv6RsRL
 slLOVDGze3Lv1f69HaZ/7vqPee8lKbCRl626dHXw15e3tU4JR9d0v2Gg4n9z8vtc9L6o
 yWvYann/YE6evHmg8kB27OVzZ/Wa7rOcywxuJSKs1FGlcleDzFEv9jYgGKF3roWShjk3
 AeJQ==
X-Gm-Message-State: AOJu0Yx2BvGhuAcajEwkWW9bP1OBeppsSTQbKmzlHf9qq2GKaPmNL0bQ
 SSJj1SI/LJPp4VKOuDd9akOVcOjZnf+/T+pOQLA=
X-Google-Smtp-Source: AGHT+IEJtT4anM7ZvSJuo6VQuPI4zPUk4d8vrqqB/Qw9oQ6CQPuJfMMZSpMeeGYXB5xLTTAVJ3RPcw==
X-Received: by 2002:a05:6a00:10cb:b0:68e:3616:604a with SMTP id
 d11-20020a056a0010cb00b0068e3616604amr4911321pfu.8.1696354289287; 
 Tue, 03 Oct 2023 10:31:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 32/47] exec: Move cpu_loop_foo() target agnostic functions to
 'cpu-common.h'
Date: Tue,  3 Oct 2023 10:30:37 -0700
Message-Id: <20231003173052.1601813-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While these functions are not TCG specific, they are not target
specific. Move them to "exec/cpu-common.h" so their callers don't
have to be tainted as target specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 32 ++++++++++++++++++++++++++++++++
 include/exec/exec-all.h   | 30 ------------------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 360b8298a4..605b160a7e 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -173,4 +173,36 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 /* vl.c */
 void list_cpus(void);
 
+#ifdef CONFIG_TCG
+/**
+ * cpu_unwind_state_data:
+ * @cpu: the cpu context
+ * @host_pc: the host pc within the translation
+ * @data: output data
+ *
+ * Attempt to load the the unwind state for a host pc occurring in
+ * translated code.  If @host_pc is not in translated code, the
+ * function returns false; otherwise @data is loaded.
+ * This is the same unwind info as given to restore_state_to_opc.
+ */
+bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
+
+/**
+ * cpu_restore_state:
+ * @cpu: the cpu context
+ * @host_pc: the host pc within the translation
+ * @return: true if state was restored, false otherwise
+ *
+ * Attempt to restore the state for a fault occurring in translated
+ * code. If @host_pc is not in translated code no state is
+ * restored and the function returns false.
+ */
+bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
+
+G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
+G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
+#endif /* CONFIG_TCG */
+G_NORETURN void cpu_loop_exit(CPUState *cpu);
+G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
+
 #endif /* CPU_COMMON_H */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2e4d337805..ee90ef122b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -27,36 +27,6 @@
 #include "exec/translation-block.h"
 #include "qemu/clang-tsa.h"
 
-/**
- * cpu_unwind_state_data:
- * @cpu: the cpu context
- * @host_pc: the host pc within the translation
- * @data: output data
- *
- * Attempt to load the the unwind state for a host pc occurring in
- * translated code.  If @host_pc is not in translated code, the
- * function returns false; otherwise @data is loaded.
- * This is the same unwind info as given to restore_state_to_opc.
- */
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
-
-/**
- * cpu_restore_state:
- * @cpu: the cpu context
- * @host_pc: the host pc within the translation
- * @return: true if state was restored, false otherwise
- *
- * Attempt to restore the state for a fault occurring in translated
- * code. If @host_pc is not in translated code no state is
- * restored and the function returns false.
- */
-bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
-
-G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
-G_NORETURN void cpu_loop_exit(CPUState *cpu);
-G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
-G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
-
 /**
  * cpu_loop_exit_requested:
  * @cpu: The CPU state to be tested
-- 
2.34.1


