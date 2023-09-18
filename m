Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F67A4768
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBiK-0002xc-DF; Mon, 18 Sep 2023 06:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBiI-0002wF-25
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:46 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBiG-0004Jo-5u
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c65820134so3858389f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695033762; x=1695638562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZeRMydDkG6M2arrXdQxyoLJFYtUvfDVk8wUBcDyUf4=;
 b=rvFfw7+DFMfZOpa4lyOgLD9yy2Elr4YEbIiGQKHzkwCRR8MqBhaTG7wHoU50GwFDEW
 htkRaOKoIephPHsLPMQwhyOjcQJoxGFU+v9ceO5k/Y58KSJ2vF6VZWY4zQcUMsYcZV6C
 N7Y1I3//ci9kCQeXKE+Uz6YfyHAwq7BLFfeGNPiqXpUBTidR/kF2YZ/cCdr5/enaG1Xi
 iufKtcpNkV3ZH2vYWW7NvHg6Hh0U7zWw8iysHgPmKZ9lfLK/OE6Jyxa/8si6R0Xkaps4
 NTCvgcwsmjf1TVP0MGLLt0RHXQr0ybt4jff7l6jxRHWVl+A+XgS2gv7oxWmShR1unfde
 nLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033762; x=1695638562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZeRMydDkG6M2arrXdQxyoLJFYtUvfDVk8wUBcDyUf4=;
 b=qPOHcj2MnkTDruJ11CIeADaSHaz4Z7W2KdPLtmdFKs35CM91qxVviH8u+ZkILX9vFi
 hL/X6t058WoLC6Y/PwfXA9yB/GzCf6KJLRDi4Ihq1RjPeFOZhFaK6vhAQWBmLlJdLTDO
 gfGMsWQH4UKJVOOfI4Fpfn6nQMWW19R+klX8tBJOcRmEG9/lSvJZZDvibNJUG0FazrUZ
 1lMvHU3lPE86t/CgNz5eqAc9i+2Q1culDJhbUBOqfX7xs80xjKZ0Pmh8LB2/Wi0Vw35k
 WzGn+1Pvy8YIwOmc7GiY+DCxvyBOfUdHmODm7mOMHc5hFfXj7civDeIulVXxighbLbsE
 fa3Q==
X-Gm-Message-State: AOJu0YzSvCoaWxXCoqVmYLE3donVZLSRx7XAMILsJnLZick/zIv4XF0O
 7Y+7qtBSMSXth5WcjGq3qUSYeylV1eOj2QwgzvWaoA==
X-Google-Smtp-Source: AGHT+IEpHrazoyYQn3hRj0X36qJX+O62tVXQ1t1LpKqi6uBrkeq5HjtXGFZ4jCxPOAvnKp0CPyLxTQ==
X-Received: by 2002:a5d:58e1:0:b0:319:79bb:980c with SMTP id
 f1-20020a5d58e1000000b0031979bb980cmr6614964wrd.64.1695033762316; 
 Mon, 18 Sep 2023 03:42:42 -0700 (PDT)
Received: from localhost.localdomain (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 q11-20020adff50b000000b0031c71693449sm12314748wro.1.2023.09.18.03.42.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 03:42:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alessandro Di Federico <ale@rev.ng>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/3] accel/tcg: Factor tcg_cpu_reset_hold() out
Date: Mon, 18 Sep 2023 12:41:52 +0200
Message-ID: <20230918104153.24433-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918104153.24433-1-philmd@linaro.org>
References: <20230918104153.24433-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Factor the TCG specific code from cpu_common_reset_hold() to
tcg_cpu_reset_hold() within tcg-accel-ops.c. Since this file
is sysemu specific, we can inline tcg_flush_softmmu_tlb(),
removing its declaration in "exec/cpu-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 2 --
 accel/stubs/tcg-stub.c    | 4 ----
 accel/tcg/tcg-accel-ops.c | 8 ++++++++
 accel/tcg/translate-all.c | 8 --------
 hw/core/cpu-common.c      | 5 -----
 5 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 1eff233565..d71b4d712d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -38,8 +38,6 @@ void cpu_list_lock(void);
 void cpu_list_unlock(void);
 unsigned int cpu_list_generation_id_get(void);
 
-void tcg_flush_softmmu_tlb(CPUState *cs);
-
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index a9e7a2d5b4..8a496a2a6f 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -22,10 +22,6 @@ void tlb_set_dirty(CPUState *cpu, vaddr vaddr)
 {
 }
 
-void tcg_flush_jmp_cache(CPUState *cpu)
-{
-}
-
 int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 748539f289..0882464d03 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -78,6 +78,13 @@ int tcg_cpus_exec(CPUState *cpu)
     return ret;
 }
 
+static void tcg_cpu_reset_hold(CPUState *cpu)
+{
+    tcg_flush_jmp_cache(cpu);
+
+    tlb_flush(cpu);
+}
+
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
@@ -206,6 +213,7 @@ static void tcg_accel_ops_init(AccelOpsClass *ops)
         }
     }
 
+    ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b2d4e22c17..0f3ed835cb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -801,11 +801,3 @@ void tcg_flush_jmp_cache(CPUState *cpu)
         qatomic_set(&jc->array[i].tb, NULL);
     }
 }
-
-/* This is a wrapper for common code that can not use CONFIG_SOFTMMU */
-void tcg_flush_softmmu_tlb(CPUState *cs)
-{
-#ifdef CONFIG_SOFTMMU
-    tlb_flush(cs);
-#endif
-}
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index b50bc22fb7..23040e0398 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -27,7 +27,6 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "exec/cpu-common.h"
-#include "exec/tb-flush.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
@@ -138,10 +137,6 @@ static void cpu_common_reset_hold(Object *obj)
     cpu->cflags_next_tb = -1;
 
     cpu_exec_reset_hold(cpu);
-    if (tcg_enabled()) {
-        tcg_flush_jmp_cache(cpu);
-        tcg_flush_softmmu_tlb(cpu);
-    }
 }
 
 static bool cpu_common_has_work(CPUState *cs)
-- 
2.41.0


