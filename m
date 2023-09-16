Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA27A32B1
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3o-0006OF-9u; Sat, 16 Sep 2023 17:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd34-0005D2-8h
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:54 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd30-0000Ub-QN
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:53 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c0d6fef60cso2057733a34.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900510; x=1695505310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzEQfKezgAt65j3pfMrIbIQsqXw7idxv2pPTvZtkhzo=;
 b=isuMucsfou+3yVWs8gno62tE3kXr+Kj4Cfp299AsL1Q3ZQ3Z7Ck+zXpBlZiK/mfNA+
 jWwjVgAii0eFkUICj9UE4nju12y/n5HICbDfjfEzaOQ9Z98uY1wgUXgJwQSCuXevNNWE
 MgGgo50CTAcsFlSNu4DfKCyUtDiFfcuNYSSSw5Ogq2WtoRcQ/inGAKrrz+6HHQETE1Sb
 fiRExmjfjTbKgY++IOeIdQWxYUU1dWVLypjgc9ES8vybZFdV58ESOxtH0OCPYUclo0KL
 crWZuyyFj332yjlOaALfDZi/hFxEE6xX+rC1AJarK2VL/Ke2tgmKurhKqF6L1wO4TrvY
 YamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900510; x=1695505310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzEQfKezgAt65j3pfMrIbIQsqXw7idxv2pPTvZtkhzo=;
 b=WkSVYS7vd39i0EySQe8xZ+6yuf4NV8ed90Nrapv39xnoUQf49ztkRaSFdle7ETtnMv
 bu5uuoAFxwZUUB0qzFuikfp5wlR4W0Vf/MbcOLFX2YOrWQeGtwXfgGpS9/T7S0BrtC8J
 GvTMbAqzZ2m8+iD2fL3U7PEvYaoZ0V2bsdhSxJXGrK1m6CmE5kfvqQTYKNSB0FuTx7WO
 TGlXguFFvbBZRnWXa+OF+10pyVYo0vti2zOAc9zVs+WuLO4436kK1+IXtnQhGQuE/VGb
 Cc0ZUXlDlEAk8IZyhx+a07J+QiQnUSn0DLOjwqaRYEw6smqtprYrqqAMQaa+IIGPVdto
 Yuhw==
X-Gm-Message-State: AOJu0YyQcX02i4fNnugVOIx4pVFJgpDId+mrNbXfToVN/zjmp7n74jlL
 FfzeSDIfq2YO4+xuHg9kRuwTchotXeiywyGJqfI=
X-Google-Smtp-Source: AGHT+IEqE6yoplzJsdu1U2Q9ZjxCQXm76AW1c0/cwUeiDA4ptHEwdPIf1EwO9HWzphpr1f7zXstQTQ==
X-Received: by 2002:a05:6358:430c:b0:129:d242:f782 with SMTP id
 r12-20020a056358430c00b00129d242f782mr6754060rwc.0.1694900509723; 
 Sat, 16 Sep 2023 14:41:49 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 25/39] exec: Move cpu_loop_foo() target agnostic functions
 to 'cpu-common.h'
Date: Sat, 16 Sep 2023 14:41:09 -0700
Message-Id: <20230916214123.525796-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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


