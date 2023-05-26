Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 813AE712B35
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ahf-0002xZ-ND; Fri, 26 May 2023 12:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahc-0002vj-5T
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahZ-0002Fq-Fj
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6042d610fso10801185e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120044; x=1687712044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWrBsFMGiSuanAAhdh6yQ0xzGyZ5a0S2x2yI+CVJb+k=;
 b=CXaN3nqdxMFNhhzkBhPGUfw0G7gCS/+k+EVEaKFN5dhThaMCxh9jNi7PIQnN6bKZRM
 jeys/SESP1Pbo675WpyKHSs7V2TUMrhUmrfbxTiugWAfQc9lo0ibzNpJy7iNMs5QTh7o
 QNIF+Y115cwces+YVxM2E0cxzy1YmQss/0Gn6jaB7r7MB7vQxXFO2u26EY0/gbTnMgKL
 5bHOjPUSA+YFIPgOYsj0KjXaeo0pCmuGUZ5k90DkfgikgzoFVc8anW2BG6Z6wqpHY65R
 5pABYKQVX+zyoS4Wr6VQWj8hS/899jwuBj6IPAhyboPp/0jOMZli9XoTlns2w7As2Fvn
 yQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120044; x=1687712044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWrBsFMGiSuanAAhdh6yQ0xzGyZ5a0S2x2yI+CVJb+k=;
 b=UDkExkiQvizJXXRczKHA3f0m84vETr8DFmfTn2AdsVqgLHN5B2qu5rhvrsYrWEKDrQ
 4261QTHKruZ53s6W9TDkopZHKSQKwSVhuwlqplwM+uVA/fqkhsCC7zgc41GdAeswSN5w
 89jqOxIKOVLzdlI1+qwN0cged5n/exFVnN7XO0bkhluBuEp7f5tJL8E850PGSzJuXLzV
 PJSnJXQM8UqjNPZwPn2cVDWrk3mMmPLVMqoS9ijpCdE6Xdq+QrsdNLJ+hguysEsKC6Ko
 KKd7fdQ0Sn7y/3qPRsO9+8MEGhlZPi5kmAZhE0jHtS7rHJveV8bnGzhPB6NUp9d0X/Rj
 vtjw==
X-Gm-Message-State: AC+VfDwJ6YwNBWy8Gd+U0W1GRrqn1x9zlE563j3qrdHy9IzEQyAUhhZP
 h0trVxrh+12YXiuNHzxpQqFDnw==
X-Google-Smtp-Source: ACHHUZ6ONuEIQcdQzWu0iAYPaLWQApgh+dBv8YZzzcdfC3rCbwhdYfv7X40vyVuMEk3zahO4fRuY2g==
X-Received: by 2002:a05:600c:2308:b0:3f6:1377:8b15 with SMTP id
 8-20020a05600c230800b003f613778b15mr1986965wmo.21.1685120043969; 
 Fri, 26 May 2023 09:54:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c225200b003f60a446fe5sm5783211wmm.29.2023.05.26.09.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:54:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A09F1FFBD;
 Fri, 26 May 2023 17:54:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 02/11] trace-events: remove the remaining vcpu trace events
Date: Fri, 26 May 2023 17:53:52 +0100
Message-Id: <20230526165401.574474-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526165401.574474-1-alex.bennee@linaro.org>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

While these are all in helper functions being designated vcpu events
complicates the removal of the dynamic vcpu state code. TCG plugins
allow you to instrument vcpu_[init|exit|idle].

We rename cpu_reset and make it a normal trace point.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230524133952.3971948-3-alex.bennee@linaro.org>
---
 hw/core/cpu-common.c   |  4 ++--
 trace/control-target.c |  1 -
 trace/control.c        |  2 --
 hw/core/trace-events   |  3 +++
 trace-events           | 31 -------------------------------
 5 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 5ccc3837b6..951477a7fd 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -32,7 +32,7 @@
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include "trace/trace-root.h"
+#include "trace.h"
 #include "qemu/plugin.h"
 
 CPUState *cpu_by_arch_id(int64_t id)
@@ -113,7 +113,7 @@ void cpu_reset(CPUState *cpu)
 {
     device_cold_reset(DEVICE(cpu));
 
-    trace_guest_cpu_reset(cpu);
+    trace_cpu_reset(cpu->cpu_index);
 }
 
 static void cpu_common_reset_hold(Object *obj)
diff --git a/trace/control-target.c b/trace/control-target.c
index c0c1e2310a..a10752924b 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -144,5 +144,4 @@ void trace_init_vcpu(CPUState *vcpu)
             }
         }
     }
-    trace_guest_cpu_enter(vcpu);
 }
diff --git a/trace/control.c b/trace/control.c
index 6c77cc6318..d24af91004 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -277,8 +277,6 @@ void trace_fini_vcpu(CPUState *vcpu)
     TraceEventIter iter;
     TraceEvent *ev;
 
-    trace_guest_cpu_exit(vcpu);
-
     trace_event_iter_init_all(&iter);
     while ((ev = trace_event_iter_next(&iter)) != NULL) {
         if (trace_event_is_vcpu(ev) &&
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 56da55bd71..2cf085ac66 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -29,3 +29,6 @@ clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', %"PRIu64"Hz->%"PRI
 clock_propagate(const char *clk) "'%s'"
 clock_update(const char *clk, const char *src, uint64_t hz, int cb) "'%s', src='%s', val=%"PRIu64"Hz cb=%d"
 clock_set_mul_div(const char *clk, uint32_t oldmul, uint32_t mul, uint32_t olddiv, uint32_t div) "'%s', mul: %u -> %u, div: %u -> %u"
+
+# cpu-common.c
+cpu_reset(int cpu_index) "%d"
diff --git a/trace-events b/trace-events
index 691c3533e4..dd318ed1af 100644
--- a/trace-events
+++ b/trace-events
@@ -54,34 +54,3 @@ qmp_job_resume(void *job) "job %p"
 qmp_job_complete(void *job) "job %p"
 qmp_job_finalize(void *job) "job %p"
 qmp_job_dismiss(void *job) "job %p"
-
-
-### Guest events, keep at bottom
-
-
-## vCPU
-
-# trace/control-target.c
-
-# Hot-plug a new virtual (guest) CPU
-#
-# Mode: user, softmmu
-# Targets: all
-vcpu guest_cpu_enter(void)
-
-# trace/control.c
-
-# Hot-unplug a virtual (guest) CPU
-#
-# Mode: user, softmmu
-# Targets: all
-vcpu guest_cpu_exit(void)
-
-# hw/core/cpu.c
-
-# Reset the state of a virtual (guest) CPU
-#
-# Mode: user, softmmu
-# Targets: all
-vcpu guest_cpu_reset(void)
-
-- 
2.39.2


