Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2570F7E9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oik-0008I8-4c; Wed, 24 May 2023 09:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oie-0008D9-DN
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:40:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oia-0003m0-NJ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:39:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f60ec45314so7774185e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684935595; x=1687527595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5ff0sveshClrMNiLX5BqqtsMAT9oAoNb16IS+Sn9BA=;
 b=OfzewB13fnUOZVDiIm0/w8ZZnpqwUv6W6Ws4TeYehaZXCM7jEtv71WTvX80zn5haib
 HkoZGD1RdQXLrGD56Vxn6iteX+qYHGbkexFcQQ7wXKK7m7TeIic5x5omdm/pRF4UZ397
 1j+TDVkZUmEodhE8rO6pr/P15I4vJgBLZ9iV8i+ANcoCEFKCFA74VOKLAGfaZpLvRbao
 HEYYpYVfgc7pMhtck9kRzHALUdII1orEY4abiXIZKk1V03Wo7sykAFZSr7fjvmcpFJev
 cw/5GVnZH+koA71zdL96vab/CNtIqGl4g/F/V390AsYRp9WXzAlR1DN0KFRDjhPxMk2E
 7CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684935595; x=1687527595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5ff0sveshClrMNiLX5BqqtsMAT9oAoNb16IS+Sn9BA=;
 b=cKHGADCwn98o0EurBiiXD0dzqIXyKtv+fcc0DgZ/nfKDqWd8pDIVZHuMnmaQfUbDFU
 57yf8GbqZnA3H/tVODZjlcArnHWQSHUbJ5JZKb1N0+D/sjPoHpo2a1AbUbn+H2rrsj3g
 fyRoEKiatgZ53bYIiZgWaWg+4Y70x34RepwWtmH7kGS/BgtR+yMhaGk0b1hi6AEV8Ecj
 Y1ta9K1WMaUwxZhuBKRy5IUqGO1TXNSJXz3zCsXNzj3QKNfOOeTCVFSCIw84bw0WJ2kV
 XEUhgRUmf2GOvyiz2F43+Zv6aoUN7aO39AxSNYtlziyo4OyQM9jfTLqmcINHg8qQMU7W
 HcuQ==
X-Gm-Message-State: AC+VfDz5c9RWsE1arLbBLpNl3VjkkJMBVJ67sgub7I0ffZOkIRusnKvn
 YnSdsLloyn9P4nOS35V6ludCqA==
X-Google-Smtp-Source: ACHHUZ5JEE8daiuuSdGT3qfUAqtDbVDbli2+6RV1po9lOeHOX82G/AeH3HXgiADi5/r+1UjuOxPDwA==
X-Received: by 2002:a1c:7415:0:b0:3f6:2ee:698e with SMTP id
 p21-20020a1c7415000000b003f602ee698emr7527691wmc.7.1684935595358; 
 Wed, 24 May 2023 06:39:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a7bcc10000000b003f60fb2addbsm2430703wmh.44.2023.05.24.06.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 06:39:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2BD681FFBD;
 Wed, 24 May 2023 14:39:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 02/10] trace-events: remove the remaining vcpu trace events
Date: Wed, 24 May 2023 14:39:44 +0100
Message-Id: <20230524133952.3971948-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524133952.3971948-1-alex.bennee@linaro.org>
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-Id: <20230523125000.3674739-3-alex.bennee@linaro.org>
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


