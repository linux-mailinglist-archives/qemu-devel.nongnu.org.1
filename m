Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7377E65D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 18:28:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWJN0-0004eY-80; Wed, 16 Aug 2023 12:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWJMt-0004dB-DN
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:27:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWJMr-0005pm-0t
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:27:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68879c7f5easo996635b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692203251; x=1692808051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QKXYA/unXvJ21h5G46LAyvoXNN/dpDZXMSW6PifdaOI=;
 b=qLcGYm4XVa6F60ZcnZpp1xhKx2Whi0zAH8n5j7o2rd3gTDs77zvoYXqjcWkcBBabuE
 SXB11MlA0mG7iUXrwwV4UBC8j9vBepE7r9z0ugs6sxP6UZld0FPrLJHQQ6kz1Xd3PQPP
 7CJYOojuSPMJj50Ol+44sWrxGg9bUwinTOdccK9FmdslaCzI3h7oFwwDaew1uvBfosXE
 GPNLpkGutC9rlp1qToNNtUBE1tyuS3u/BcKIpS+SWCtfdJTzWCpiSex1BjPoRijaYMOO
 bXkZbJeqBmZAZobO791dAPt6ktSPPuyY+8pPK4K8WtdFI+l82tpRbfDl2PgSYxKbXH3X
 JSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692203251; x=1692808051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QKXYA/unXvJ21h5G46LAyvoXNN/dpDZXMSW6PifdaOI=;
 b=dw/KL0KuSQGbC+HByfpNiDJf8KthsLsMlsAT3oy9OECL5VyUc11GbegbzAxREyQriB
 0OV6J/V7y6lpiUnCFXDeMMJj8tDQBY1cPcYXDIxvTFiVpDxfrXs21EkLaq1dBl2vtKvN
 +1aVmP6xBp0c9Wwi5mQAd3EsUil4sGWSm1w9lPGluO1VXKzF+66Poq7C3am1uKXUhr77
 nTeCJ00LdVQK7x81fr5VWuM0lizHoC3eHaIF1gLGztp8kA7CGdhbVUcrzJW36V0ZoctB
 70nHA0e3VPd3/x/j+Pjj7fIm8aSRcoyQctxx3X+pHx0wbZLOgTgsH3u1zm4kHJahBrAy
 C8Bg==
X-Gm-Message-State: AOJu0YyyT8+aVS1ZSrxnfbWch+YldUWG4mSXVxWURApWb62dIgdJPRaM
 bsmlTHIYVG/1Eoey++uhr++7naCGhWmG/KaACUQ=
X-Google-Smtp-Source: AGHT+IEVTkOhwaVk4m3TlS+FchD7zGKPWsC6MzSpnYPvGeb5jHzXh+eqnWx9CbtWoVH9+QL752ZBCg==
X-Received: by 2002:a05:6a20:7faa:b0:13d:7aa3:aa72 with SMTP id
 d42-20020a056a207faa00b0013d7aa3aa72mr2796827pzj.5.1692203251593; 
 Wed, 16 Aug 2023 09:27:31 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 e24-20020aa78c58000000b006829969e3b0sm11209906pfd.85.2023.08.16.09.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 09:27:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] target/riscv: Allocate itrigger timers only once
Date: Thu, 17 Aug 2023 01:27:13 +0900
Message-ID: <20230816162717.44125-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
---
 target/riscv/debug.h |  3 ++-
 target/riscv/cpu.c   |  8 +++++++-
 target/riscv/debug.c | 15 ++++++++++++---
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index c471748d5a..7edc31e7cc 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -143,7 +143,8 @@ void riscv_cpu_debug_excp_handler(CPUState *cs);
 bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
-void riscv_trigger_init(CPURISCVState *env);
+void riscv_trigger_realize(CPURISCVState *env);
+void riscv_trigger_reset(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
 void riscv_itrigger_update_priv(CPURISCVState *env);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e12b6ef7f6..3bc3f96a58 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -904,7 +904,7 @@ static void riscv_cpu_reset_hold(Object *obj)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
-        riscv_trigger_init(env);
+        riscv_trigger_reset(env);
     }
 
     if (kvm_enabled()) {
@@ -1475,6 +1475,12 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
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
index 75ee1c4971..1c44403205 100644
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
+void riscv_trigger_reset(CPURISCVState *env)
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


