Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD5AF627A
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 21:12:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hM-0007aJ-4J; Wed, 02 Jul 2025 15:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gA-0006Pn-DY
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2g4-00037d-MZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso28435585e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482764; x=1752087564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v6+HYr/42Y/Iowg1uUW2qQvLw8fBzoanUujYKDMrhU=;
 b=ZWjrDgclhXIHlO1yGxVcGYkwJ80zkON8ZPi2KoiwVDaUaA7z4/lGnVKs+7SWKDt1rr
 gLl7XGHkoU9q/4H5hj25jUl1TznE31YA/jfjDd5Z6v5Hf4AhsPcbGGSV4HP9zicaJIeu
 fq1pAr/2b3srGTLlDsAU4RAsVfv/6/5FDEEtmgsP9eoX3V6A5HJC6bYJjNo2sfyejfGg
 Y8UhWZqZtVaAzbK5n3q+10WHAo+88d6bWTsAF0rah+KuxwhArHVOMd65rzurOcPfrZC0
 ik8z5m5UusMdyaagDw/2VWnSKb+b5S0xE6zBOwF6pQXhcoIg/7MB3vzN+uPK5iVjwtrQ
 SkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482764; x=1752087564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v6+HYr/42Y/Iowg1uUW2qQvLw8fBzoanUujYKDMrhU=;
 b=HMMtUTZC9hwlJgdknzpIqmetSlByubWOH4GRJpNO9iGLOPbt0bSzceqyFye+0i7BjG
 7snHHtUhLajOwSxNJtwhvSv4kNN2160CZCl0+22JO1MqF4PnkeNf5F3SkYLi2Wrd2k4K
 ga2tGfSwS0v/3COlWrjcsXT6C7SEomI41yLih26cyMlG/YkqPuS+oz8KxEsaTb/GFXAW
 e28o5AfRmv+jIAc7ANRfqkGCGxQ7r22ggkA2KBE4XucfxpQViPjmW4M0+XYpnHXxnpZp
 S2mQksC7qynrDBbrbGyXZOETSODr067yKd/JFbBJ8dZxK6L7U3+1WiK/tSB4pmGBTeYx
 pUsg==
X-Gm-Message-State: AOJu0YzQk97W81qZ/6n4P+U3K4R7fNkbwp/M1VJEyFCikPvZzMXlM7mP
 AJnKhk4p7e9y4nHDwF4g5fmdACAxe3VLUAosLwS6CEnKT74AVHQE0lG99Lxc8PnuvWrSjwtzpr7
 ewyQs
X-Gm-Gg: ASbGncuvPKnEyEBS8ZSShZ4/iqdd+vgZzaUwKLMmCfJ5jNth2pJfycUZvEiMm0bMvOH
 ei34j7f3Y8COP6GG6DJ7Ywonnt47y2wowiGliWbTWCXJUfXfBFXVCOtS7YbCumf9bd+Pcy5nwWt
 Ihyv4+Eh/gRBowBfbKS/e6ljN2WaCkc7mVhbnrErIYDN5YEREfGepOqp1EAJV5culH5AOyoI1mt
 K4VySMSm1OcnNniMwxitCtaY7nSgSupjXWQlY0uoWl9AJJZPgrjuuAnGX+o0Nh1yyZ5I+MW/lpx
 bkr2Zx4Oizn87N38Mdk55Uy3JdQ1BMrd5zt4/l9bf46WQaBwnX7W34za17vkIXfeafoMopzdpTK
 ryqnQTs3ZEoJGXB8INiRSEan7RhidFRxUFPW5
X-Google-Smtp-Source: AGHT+IF92yCtpbCa/GlbZCvS4gUjgiWWbFQHRh6UqSRXqLv1qxzo569DrotJrBw1XQu2WijXSqjDCw==
X-Received: by 2002:adf:9cc1:0:b0:3a6:d349:1b52 with SMTP id
 ffacd0b85a97d-3b32cb34489mr266240f8f.21.1751482764536; 
 Wed, 02 Jul 2025 11:59:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e62144sm16972934f8f.92.2025.07.02.11.59.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 49/65] accel/tcg: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Wed,  2 Jul 2025 20:53:11 +0200
Message-ID: <20250702185332.43650-50-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.h |  3 +--
 accel/tcg/tcg-accel-ops-mttcg.c | 16 +---------------
 accel/tcg/tcg-accel-ops.c       |  3 ++-
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8ffa7a9a9fe..8bf2452c886 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -13,7 +13,6 @@
 /* kick MTTCG vCPU thread */
 void mttcg_kick_vcpu_thread(CPUState *cpu);
 
-/* start an mttcg vCPU thread */
-void mttcg_start_vcpu_thread(CPUState *cpu);
+void *mttcg_cpu_thread_routine(void *arg);
 
 #endif /* TCG_ACCEL_OPS_MTTCG_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 462be7596b9..96ce065eb59 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -61,7 +61,7 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
  * current CPUState for a given thread.
  */
 
-static void *mttcg_cpu_thread_fn(void *arg)
+void *mttcg_cpu_thread_routine(void *arg)
 {
     MttcgForceRcuNotifier force_rcu;
     CPUState *cpu = arg;
@@ -128,17 +128,3 @@ void mttcg_kick_vcpu_thread(CPUState *cpu)
 {
     cpu_exit(cpu);
 }
-
-void mttcg_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    tcg_vcpu_thread_precreate(cpu);
-
-    /* create a thread per vCPU with TCG (MTTCG) */
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
-             cpu->cpu_index);
-
-    qemu_thread_create(cpu->thread, thread_name, mttcg_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 861996649b7..4931e536beb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -204,7 +204,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     AccelOpsClass *ops = ac->ops;
 
     if (qemu_tcg_mttcg_enabled()) {
-        ops->create_vcpu_thread = mttcg_start_vcpu_thread;
+        ops->cpu_thread_routine = mttcg_cpu_thread_routine;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
@@ -222,6 +222,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
 
     ops->cpu_common_realize = tcg_exec_realizefn;
     ops->cpu_common_unrealize = tcg_exec_unrealizefn;
+    ops->thread_precreate = tcg_vcpu_thread_precreate;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
-- 
2.49.0


