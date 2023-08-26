Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ACF7899D9
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 01:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa2dx-0000Sv-Rk; Sat, 26 Aug 2023 19:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa2dn-0000Rc-3i
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 19:24:28 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa2dj-00066Z-DY
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 19:24:26 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58caaedb20bso24528577b3.1
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693092262; x=1693697062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFn1LgnAzbXnHqrJlI8Dpzt3UFxqmFwBrMDqITY7sQE=;
 b=Ew9EnDlUHHms/ipkzxlKDVOGsHPeNYH7uZpGJZXtlcBMzC1fGyrjaV7yzboul975WT
 B1mY+QcBZWXr/fw6sOkepMJVKpZOrzio4gK+JH/F1SWn32p4scD46dP9WVnT+wY436so
 5KlujhSAg/RvAH7m1lVLysyV01rRbcmOt6ojTYSwxYIaU3FvtkOlLVH+/cbbSqOD3g/Z
 FuaRAP2P8NYU7rUG//fyHUh5rXqGaSuo5y0gGLxHaXBUMg46PrAGadtW/or5MMBKAZQ5
 Gu5gT4ls1he3wdkeVI7gqV0LyKehN8H58v5+xJgc8j9egU2Gc0PP4HEalYk5axzXFaHC
 K6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693092262; x=1693697062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFn1LgnAzbXnHqrJlI8Dpzt3UFxqmFwBrMDqITY7sQE=;
 b=Bo3jCwBFZfpU5FTZG3wf71Po74Rx9ep6O05wYChTt2M1TsXnC5XsiQq3lzKdyzkH5K
 xC0+wWynHK8ai1CHRlhZiMBhVNvtPUlWpzItcMfKCSG8O2kEV9EhhlK31ZPvGwdgPmwt
 79CacvDKej1/XwCXJsHAbDmvqwoFscnM6DM1QwS1HqPkqYXCZ4vNAJKCqMKo+XW2DFIi
 aiOKv7V8DZl1FGiR3pK+0xGIH4Lj3cozfyxPXuyV6sKChpQ1Z7alxwilKCtORxC08nfH
 Qbozmnu7d99V03hh1gZpsA3HwCeVsaq/u5aokne50+3QPg0DuELEQjrhNvzN2fsNj9x8
 u90g==
X-Gm-Message-State: AOJu0Ywjdt0cqfRf+7w3HkHEJFFgg/ttEsb3m/xrnolN2mQFl6HVhLUF
 8KUh1IYP6QzFTFGPLKkh7sRJWKfdYIfA21NbCXw=
X-Google-Smtp-Source: AGHT+IF0ZWF+CllHHpUl7iDv1bqKsb0PBEEpwJ/V9+u9EdIFYr8Nufmh5uny1rmSvQM2OWQb8TnDhw==
X-Received: by 2002:a0d:c182:0:b0:589:ad30:5f5 with SMTP id
 c124-20020a0dc182000000b00589ad3005f5mr18537517ywd.52.1693092262129; 
 Sat, 26 Aug 2023 16:24:22 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 u9-20020a63a909000000b005633311c70dsm4226472pge.32.2023.08.26.16.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 16:24:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 3/3] softmmu: Remove cpu_reloading_memory_map as unused
Date: Sat, 26 Aug 2023 16:24:15 -0700
Message-Id: <20230826232415.80233-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826232415.80233-1-richard.henderson@linaro.org>
References: <20230826232415.80233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h   |  1 -
 accel/tcg/cpu-exec-common.c | 30 ------------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 87dc9a752c..41788c0bdd 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -133,7 +133,6 @@ static inline void cpu_physical_memory_write(hwaddr addr,
 {
     cpu_physical_memory_rw(addr, (void *)buf, len, true);
 }
-void cpu_reloading_memory_map(void);
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               bool is_write);
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 9a5fabf625..7e35d7f4b5 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -33,36 +33,6 @@ void cpu_loop_exit_noexc(CPUState *cpu)
     cpu_loop_exit(cpu);
 }
 
-#if defined(CONFIG_SOFTMMU)
-void cpu_reloading_memory_map(void)
-{
-    if (qemu_in_vcpu_thread() && current_cpu->running) {
-        /* The guest can in theory prolong the RCU critical section as long
-         * as it feels like. The major problem with this is that because it
-         * can do multiple reconfigurations of the memory map within the
-         * critical section, we could potentially accumulate an unbounded
-         * collection of memory data structures awaiting reclamation.
-         *
-         * Because the only thing we're currently protecting with RCU is the
-         * memory data structures, it's sufficient to break the critical section
-         * in this callback, which we know will get called every time the
-         * memory map is rearranged.
-         *
-         * (If we add anything else in the system that uses RCU to protect
-         * its data structures, we will need to implement some other mechanism
-         * to force TCG CPUs to exit the critical section, at which point this
-         * part of this callback might become unnecessary.)
-         *
-         * This pair matches cpu_exec's rcu_read_lock()/rcu_read_unlock(), which
-         * only protects cpu->as->dispatch. Since we know our caller is about
-         * to reload it, it's safe to split the critical section.
-         */
-        rcu_read_unlock();
-        rcu_read_lock();
-    }
-}
-#endif
-
 void cpu_loop_exit(CPUState *cpu)
 {
     /* Undo the setting in cpu_tb_exec.  */
-- 
2.34.1


