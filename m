Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D5174A2C7
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 19:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHSQN-0006gl-Hn; Thu, 06 Jul 2023 13:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHSQI-0006eK-Qs
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:05:42 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHSQH-0001MS-7m
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:05:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbd33a573cso10280985e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688663139; x=1691255139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAnvI5Kaq2Mz02gDA0MtWIWvJJDUeYFa5i6Y59oqKIQ=;
 b=aOSqGKfasdpLIjs4siU1/vSFDIDO2YdKPsLNBGBMWYx6MjXpX+E3o98abSALVK3EiV
 rFT4HwYiubJ1lzuOa3KGKLCjOkg6liQy6fYixn2cR0Zk5kwpYMp+/e3YuhyYzGAYv7h+
 HY3JCam56+NFsu/Pv6oPzdPtrdoBUpvS73PM1H0amdhST5bcDepgNJrq3xi4E/3GAqBO
 C44qW6HerNzLQ8E7jVMD/4ZW9QbA9EuSUkaOF2sHqO1XraJMLzN5V2BLmwlL5UdFkKtf
 0gAVru94OPRb+MAZ35aikT1NOqaUSFffuAASMpM/H3ThloBt9yZWOCAy/3L7y69btDSZ
 WNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688663139; x=1691255139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAnvI5Kaq2Mz02gDA0MtWIWvJJDUeYFa5i6Y59oqKIQ=;
 b=Mc7HICjUcF3T2tOh2UnHp6n0xZ00Gxs0Ha6TsbFiROrzsZ9cjz6dgxQm+gyFzRdGAa
 4h77OGCUAtDrML7z0o2VSyuTv8k0wslfpp3CEDtZ7roXlbt6UWm2Za5x+4DgsxzXDYVD
 KmCaTfB7RFn92Bot9V3ST+LqGeQVGjfPeel8y7nDtFkUkJIxMcBgvnH+9WWGgKY6HncE
 RRmO7PEcwxGI0Vexc5/80HvnqQkiL7ZC3TpJZGMvSxhwvcjEeKPS7pguHwHe/e0sz8XN
 QIk6lW7CnTmv9JOKhEJoVG9FjP+6vF6Kmwg64w+ROd9yaXwmdE1/oLhVEUyCB1Sn2Hdb
 VcCg==
X-Gm-Message-State: ABy/qLZMtop+YPu2WSsl/oql5ueQjDhxv66vBXgo0AkLkj5FT2TiBbyv
 +TYv6aklHHSaedTzczXfhSnwp1fNStW7vznElW99YQ==
X-Google-Smtp-Source: APBJJlE7ST4W9aExJTHNUdHsBE1iB+SpIezXJejXdT+Hc3fq/HLceNsB8An4bciqYEimm0O62FWwCg==
X-Received: by 2002:a7b:cb97:0:b0:3fa:93b0:a69c with SMTP id
 m23-20020a7bcb97000000b003fa93b0a69cmr1789323wmi.24.1688663139508; 
 Thu, 06 Jul 2023 10:05:39 -0700 (PDT)
Received: from stoup.quadriga.com ([95.152.217.99])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c021800b003fbfa6066acsm71888wmi.40.2023.07.06.10.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 10:05:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com, peterz@infradead.org, arnd@arndb.de,
 naresh.kamboju@linaro.org, anders.roxell@linaro.org,
 daniel.diaz@linaro.org, ben.copeland@linaro.org, pbonzini@redhat.com
Subject: [PATCH 1/2] accel/tcg: Split out cpu_exec_longjmp_cleanup
Date: Thu,  6 Jul 2023 18:05:36 +0100
Message-Id: <20230706170537.95959-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706170537.95959-1-richard.henderson@linaro.org>
References: <20230706170537.95959-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Share the setjmp cleanup between cpu_exec_step_atomic
and cpu_exec_setjmp.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ba1890a373..31aa320513 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -526,6 +526,23 @@ static void cpu_exec_exit(CPUState *cpu)
     }
 }
 
+static void cpu_exec_longjmp_cleanup(CPUState *cpu)
+{
+    /* Non-buggy compilers preserve this; assert the correct value. */
+    g_assert(cpu == current_cpu);
+
+#ifdef CONFIG_USER_ONLY
+    clear_helper_retaddr();
+    if (have_mmap_lock()) {
+        mmap_unlock();
+    }
+#endif
+    if (qemu_mutex_iothread_locked()) {
+        qemu_mutex_unlock_iothread();
+    }
+    assert_no_pages_locked();
+}
+
 void cpu_exec_step_atomic(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -568,16 +585,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         cpu_tb_exec(cpu, tb, &tb_exit);
         cpu_exec_exit(cpu);
     } else {
-#ifdef CONFIG_USER_ONLY
-        clear_helper_retaddr();
-        if (have_mmap_lock()) {
-            mmap_unlock();
-        }
-#endif
-        if (qemu_mutex_iothread_locked()) {
-            qemu_mutex_unlock_iothread();
-        }
-        assert_no_pages_locked();
+        cpu_exec_longjmp_cleanup(cpu);
     }
 
     /*
@@ -1023,20 +1031,7 @@ static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
 {
     /* Prepare setjmp context for exception handling. */
     if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
-        /* Non-buggy compilers preserve this; assert the correct value. */
-        g_assert(cpu == current_cpu);
-
-#ifdef CONFIG_USER_ONLY
-        clear_helper_retaddr();
-        if (have_mmap_lock()) {
-            mmap_unlock();
-        }
-#endif
-        if (qemu_mutex_iothread_locked()) {
-            qemu_mutex_unlock_iothread();
-        }
-
-        assert_no_pages_locked();
+        cpu_exec_longjmp_cleanup(cpu);
     }
 
     return cpu_exec_loop(cpu, sc);
-- 
2.34.1


