Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55D736622
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh6-0003pO-5g; Tue, 20 Jun 2023 04:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh2-0003oI-CM
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:28 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgy-00067a-Fd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:27 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51a3e6a952aso5254855a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249582; x=1689841582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogodEHMvGs+jdKhtwTqfSiSIlFeubpJ1YnGuLMjQdzc=;
 b=npToVQfjywIhrYyeZ9m2JXHCn+m8B7dP/wv+/6Icg2enmbO9GDs0U2wzhEe7ACDs6o
 CiQw7dkLzBId8ZvN0b1oIZa2pEv4+fOp/hMDuY2j5mI75cYwj/AXr+Y1/Pw3wYrR05nA
 xnlkVyMkmcrLGkmy22Wj2JuFvft9TnNJDYukMrGYvgg7DFwie0Nm8U62WIRVJBF6apAC
 qEiWbstWJysABBD4h7saTF5HT6R0I48GnN1eMFR61r4j7ngB0LNdNURzYsss63Q5Fg9M
 I8PECQ5Hx3pseEfTn6bIVTL4p6T3wa6xTwaFvdywGTyfn1vW2ivh57kG/YkWHUPezUWd
 VIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249582; x=1689841582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogodEHMvGs+jdKhtwTqfSiSIlFeubpJ1YnGuLMjQdzc=;
 b=ZJb2kWU7JNbasXTpEhzagAUw4gUsRzZUA2Z/Ig3WzruSlDhdHtfLul/U7dSvm/Lfcd
 XSuif4D8VGSjFskog4ubSzVfASb1f9wvaAIGWBRFMPUyijNYhjoUaUzBe6OURqfjADSi
 xVIaQohajlU7FqIz8FIq/H9gNN+lWM6Jzn+ojW9oL5+xOFE00KGmiQnCXlTASPo0zlys
 59bkE5lK6H9AdNdvzgyOFnrTv4470ND5rLEWcUwLnBvuUNn0l0GYagyBqv3MrjasMJLB
 COgmfhCy/h/AalXWU/kKTGCHvBZMPTVABhzWpyWy3jgPZDYHN5Yvr6TShi51h9KUZJbW
 dlcg==
X-Gm-Message-State: AC+VfDx02UGv73/kFgy50SZMZ2WJsCtMorOkYGcaZuYNJvxrZ/JjOznO
 Ds3HS5K+qfzJJ1Oi2BJhlz56AG/F6P5lb+CCoqihBv0L
X-Google-Smtp-Source: ACHHUZ5dgkJyTts01QNmSgApI2jGPyr33HnFzcEmMhPD3z8WyY8KsSNWZycdvqIL8RgEtU3g3Xl81g==
X-Received: by 2002:a17:907:16a1:b0:988:d1d5:cd5b with SMTP id
 hc33-20020a17090716a100b00988d1d5cd5bmr3703353ejc.75.1687249582599; 
 Tue, 20 Jun 2023 01:26:22 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/16] accel/tcg: Check for USER_ONLY definition instead of
 SOFTMMU one
Date: Tue, 20 Jun 2023 10:26:04 +0200
Message-Id: <20230620082611.770620-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
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

Invert some if() ladders for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230613133347.82210-7-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index ebc1db03d7..c0ab00385f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -566,7 +566,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         cpu_tb_exec(cpu, tb, &tb_exit);
         cpu_exec_exit(cpu);
     } else {
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
         clear_helper_retaddr();
         if (have_mmap_lock()) {
             mmap_unlock();
@@ -1023,7 +1023,7 @@ static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
         /* Non-buggy compilers preserve this; assert the correct value. */
         g_assert(cpu == current_cpu);
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
         clear_helper_retaddr();
         if (have_mmap_lock()) {
             mmap_unlock();
-- 
2.34.1


