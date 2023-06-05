Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F296772331E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 00:25:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6IdJ-000055-FS; Mon, 05 Jun 2023 18:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6IdH-0008VN-LG
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6IdF-0006Cv-1o
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f70fc4682aso47462395e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686003895; x=1688595895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+n5+QMgZVR0DsKuYLRLa0zum6v0eHEZ5kn5puaUvVbM=;
 b=a+DRdN2hB/8iZzCgCSuKEuDPAn7W5ZMTV547E5ruJ4Oz6GkNLA/MdRGygZfv/pNn4t
 m9eU9tAlSFkbLQIhFSgMOVaA43tXYlamDICUEp6RtN3vgWWDRwMzbIdMcgI6d1/qEECM
 xBMj7dzICGqbZQEWobcTHT3Qb2PnkXxcOhvPeRBpCBOljbkMILYBgue3nNj0gHFKzeBZ
 ytdck/ViRTUgfikQKpfsep8WGRP02onQ6kwsVem4oTvzlCX9H3K4mRUcpwsF77BhiNk8
 4YTRUrtSHxZTQeBxazkhYCs1U/eO8cLBs4Az1WknvHMPFZJFP1Bd4Ud3gnM7kpyRvsy4
 va0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686003895; x=1688595895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+n5+QMgZVR0DsKuYLRLa0zum6v0eHEZ5kn5puaUvVbM=;
 b=S8QpfdWSoktMDp+1sxOQDgvmEBttkywNNbz/fmvwh9OmrF+PfQHebXyMNrrfCaqDEa
 NXHMhgn9jOMZyecvfNDiqtAYlFnDnTBDuCum39ewO/E7gSNtn/JjNg9KmvFNcUBM+3nE
 ANp38OiKGz8Aie4Xlyj18ELxo3a0tCX9Zq0BBs16YqzXT7UrgY9DiLLou8FDHFPniLwc
 QRNL/4ORESVzz9ggISmVl6LRK4MoC6IR2Mg+d/F/qeHKSMGNEP6e8y3o833Kx0qusrYC
 lNX5G/r6AabcqOUEttgA8y4Jr20CTSPTOHEpByXj8J8P6pjZLieoVwgoRVxcdoFnxY8M
 83Gw==
X-Gm-Message-State: AC+VfDyINFuoZNz+T7mJ2OtesIu6Ue4InH9YH2i3298TjPVVS9cuOEXn
 QODhRRrfT0em24l7sNrVOaoWeBEI2XOO6qZ63r0=
X-Google-Smtp-Source: ACHHUZ4sk7nMUvGGqQOFpFVABTiuVLEk26aSHokk9GIarrwtfWrV+PnJFf2fzX/Rbn0Fp9jKqQSYdA==
X-Received: by 2002:a1c:770d:0:b0:3f4:2452:9669 with SMTP id
 t13-20020a1c770d000000b003f424529669mr393924wmi.0.1686003895518; 
 Mon, 05 Jun 2023 15:24:55 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 cx14-20020a056000092e00b003078681a1e8sm10846530wrb.54.2023.06.05.15.24.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 15:24:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 6/9] accel/tcg: Check for USER_ONLY definition instead
 of SOFTMMU one
Date: Tue,  6 Jun 2023 00:24:17 +0200
Message-Id: <20230605222420.14776-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605222420.14776-1-philmd@linaro.org>
References: <20230605222420.14776-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Invert some if() ladders for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal.h | 6 +++---
 accel/tcg/cpu-exec.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index 24f225cac7..65380ccb42 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -17,10 +17,10 @@
  * memory related structures are protected with mmap_lock.
  * In !user-mode we use per-page locks.
  */
-#ifdef CONFIG_SOFTMMU
-#define assert_memory_lock()
-#else
+#ifdef CONFIG_USER_ONLY
 #define assert_memory_lock() tcg_debug_assert(have_mmap_lock())
+#else
+#define assert_memory_lock()
 #endif
 
 #if defined(CONFIG_SOFTMMU) && defined(CONFIG_DEBUG_TCG)
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1cf4f1fa22..cf07e6740f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -563,7 +563,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         cpu_tb_exec(cpu, tb, &tb_exit);
         cpu_exec_exit(cpu);
     } else {
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
         clear_helper_retaddr();
         if (have_mmap_lock()) {
             mmap_unlock();
@@ -1020,7 +1020,7 @@ static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
         /* Non-buggy compilers preserve this; assert the correct value. */
         g_assert(cpu == current_cpu);
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
         clear_helper_retaddr();
         if (have_mmap_lock()) {
             mmap_unlock();
-- 
2.38.1


