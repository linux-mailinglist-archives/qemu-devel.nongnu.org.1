Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132747A0D9C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrX1-0007qs-ES; Thu, 14 Sep 2023 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrWz-0007qX-Pt
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrWx-0007Y7-3R
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:36 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52889bc61b6so1546038a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717853; x=1695322653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPNAVtdj61Dd1NsUTVG5W7vZpG0MSnrlxikP0a9bkyc=;
 b=hwf9dN1XiBHf4iQ7HLqcVWH/kHVlli89AYCXEfqIFJjBWlD8MIES8nF/fJ+zXIWIBA
 OYoWk2gwTMFiZh1GL58JdlGub6CKL1HbSdcmggDwuJt2Ti/PbEMlzXsKgJlhAHjLKy3q
 NUGyzwg3sup6qGB4PKBrrLI6XcLhABkkNkiKtSBlD+SDyWWpLNUpFrNYRpC7II1Qrb9m
 MlzcYKZ1z3uc/mQYs8hHsSdE9try4XqYzOu25IStELkgqEblBz/3OluInqauc8Eow5Y1
 R7zVNSCSBKE7VBu9/CTBlUN5cNxkkCuyy0HEnbCl5dvq0Yiwf8HWfoRYV6NibWQF5iTg
 w5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717853; x=1695322653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPNAVtdj61Dd1NsUTVG5W7vZpG0MSnrlxikP0a9bkyc=;
 b=DZctj64ikthrC1GQZ9cGb/yUZlgnvnfev0v0OfeiNIuZ+eOygQ93u48zfvhFAwlnJh
 x4IC+FOSPEhzx89CzVWGV4n0z56E4KFOaMb526l8qUUfTMNddtloe7W/GQdYcjEMpiGy
 g3Cut0hbX3xsDSBfBreaD779SAkY3TpLJXPb6BNfbkQqkDHTgdcabARnnKTkZWH5WD9n
 ZP7dRY5OTdCAVKwMN33UCaENQ7vES0/AsOB4QzEJq9xIWkp/zOjrOYdLpzPZeREGHQVC
 ViphhA623F6XxIv7lXZ+2pXrIRG2m8egDrUwbbYB2ET/a0++t1Yj5oc1ODCPuMRUyMKz
 rijg==
X-Gm-Message-State: AOJu0YzcKSk3+lKQ0OfkP1agqlqLe48PjU4jLSeWVGmhdQ8PQo2+X6hI
 f7lYx9eBoEMmIYQ5dfe+B0dey7LwDRtbxPR6SS0=
X-Google-Smtp-Source: AGHT+IEBHI2bnWjF/vO/vnRzYHHXrViIg1z0542VFhKQTp34itEBvMtALuwL4XqQAQX28yghg5wLRA==
X-Received: by 2002:a05:6402:517b:b0:51d:d4c3:6858 with SMTP id
 d27-20020a056402517b00b0051dd4c36858mr5669878ede.12.1694717853497; 
 Thu, 14 Sep 2023 11:57:33 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a056402078f00b0052f8c67a399sm1273708edy.37.2023.09.14.11.57.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:57:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/11] exec: Move cpu_loop_foo() target agnostic functions to
 'cpu-common.h'
Date: Thu, 14 Sep 2023 20:57:08 +0200
Message-ID: <20230914185718.76241-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

While these functions are not TCG specific, they are not target
specific. Move them to "exec/cpu-common.h" so their callers don't
have to be tainted as target specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


