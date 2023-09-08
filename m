Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 862357981DC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUee-0008Pg-MC; Fri, 08 Sep 2023 02:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUec-0008EB-8Q
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeY-0007wt-Lt
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so15458095ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153257; x=1694758057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BtKiY4lAmSAzTij8lSOcl0A+RCHDkyDwuH2ARMSmck=;
 b=bRSXjN5KHIptPtcEarMuQhMarGF2qwUbjrIBzBrtP6R//iHbIrLDXs9a8ZZ0Ue085O
 cxv3Q6uCa1i+c3LC+5rzIR1+sFjMgH3BXd7DATocaG+5Vu3aYno5vr/GvlR0VNbpgs8U
 KUE/FGdpcvEinbIwGFz9iqwXveBWHxvlGvEhJ/olMm+LsLDy439KJNXPnMLha+ir8Goi
 mvCV+HR2+iukt5lks/cCA92VkD29ikEUMh7Ee2Ej9WlEYg2+SGwysK4vZE9J+0190gfc
 rn0ZBBKh8Q+o3ZMux/odpaxq4IppDVVVrUS8phhvW/RJ5DCklv97R5xba4IB22iBLeOy
 nr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153257; x=1694758057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BtKiY4lAmSAzTij8lSOcl0A+RCHDkyDwuH2ARMSmck=;
 b=DjTqVgiKiaLoTfcRYm2jmkpaeV3wBk9soAMUjVkbqc3wIzO91DS/Vn9nSqKh5O+M3g
 G1Nppz8hgf5Zewm8Gm1Er1SwbD6IxHX1i9jbMLMtOaJX9o9X0btCv0CZMkumf4ja48nJ
 WH7NgTFo7Z/IrJv6I7RtCr4XLHrbCKHv9CPG/lf/7dyQ9SebHXCMWKMk25nNQXnN00Sw
 xECnCT/hmiiy5IQGzpqyWComohygMtKzMgcYGWvgyUyXKUprCXYd0toNGz+RoP9djEO4
 WyToi8fHkUD8HCtNgNgIfOZ3PtdZvNH4cvbv+KXgo6x+GJsQXCmjFppvgIgYpWYsF0LA
 QvHg==
X-Gm-Message-State: AOJu0Yzozfi3EcVdq5LfGJ1AbCCXYFqr1aIxT38O7wc2o/czQ2iQc0WJ
 gNdCpGbhY6kHq/6Pw21NXZQVzPEcokMc4qxj
X-Google-Smtp-Source: AGHT+IEtGzk3ZXoYBuFnVsCODJr5pbDWTseufTMVZosJwV2G0QWeUi0vA1Evs2kqndh+b+29oyiTBg==
X-Received: by 2002:a17:902:74c8:b0:1c3:2ee6:3811 with SMTP id
 f8-20020a17090274c800b001c32ee63811mr1873587plt.8.1694153257034; 
 Thu, 07 Sep 2023 23:07:37 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/65] target/riscv: Allocate itrigger timers only once
Date: Fri,  8 Sep 2023 16:04:08 +1000
Message-ID: <20230908060431.1903919-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

riscv_trigger_init() had been called on reset events that can happen
several times for a CPU and it allocated timers for itrigger. If old
timers were present, they were simply overwritten by the new timers,
resulting in a memory leak.

Divide riscv_trigger_init() into two functions, namely
riscv_trigger_realize() and riscv_trigger_reset() and call them in
appropriate timing. The timer allocation will happen only once for a
CPU in riscv_trigger_realize().

Fixes: 5a4ae64cac ("target/riscv: Add itrigger support when icount is enabled")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230818034059.9146-1-akihiko.odaki@daynix.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.h |  3 ++-
 target/riscv/cpu.c   |  8 +++++++-
 target/riscv/debug.c | 15 ++++++++++++---
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index c471748d5a..5794aa6ee5 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -143,7 +143,8 @@ void riscv_cpu_debug_excp_handler(CPUState *cs);
 bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
-void riscv_trigger_init(CPURISCVState *env);
+void riscv_trigger_realize(CPURISCVState *env);
+void riscv_trigger_reset_hold(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
 void riscv_itrigger_update_priv(CPURISCVState *env);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bf0912014e..f227c7664e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -926,7 +926,7 @@ static void riscv_cpu_reset_hold(Object *obj)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
-        riscv_trigger_init(env);
+        riscv_trigger_reset_hold(env);
     }
 
     if (kvm_enabled()) {
@@ -1525,6 +1525,12 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     riscv_cpu_register_gdb_regs_for_features(cs);
 
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.debug) {
+        riscv_trigger_realize(&cpu->env);
+    }
+#endif
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 75ee1c4971..ddd46b2d3e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -903,7 +903,17 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
-void riscv_trigger_init(CPURISCVState *env)
+void riscv_trigger_realize(CPURISCVState *env)
+{
+    int i;
+
+    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                              riscv_itrigger_timer_cb, env);
+    }
+}
+
+void riscv_trigger_reset_hold(CPURISCVState *env)
 {
     target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
     int i;
@@ -928,7 +938,6 @@ void riscv_trigger_init(CPURISCVState *env)
         env->tdata3[i] = 0;
         env->cpu_breakpoint[i] = NULL;
         env->cpu_watchpoint[i] = NULL;
-        env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                              riscv_itrigger_timer_cb, env);
+        timer_del(env->itrigger_timer[i]);
     }
 }
-- 
2.41.0


