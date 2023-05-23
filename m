Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BD570DD08
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:52:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTL-0007dv-Q9; Tue, 23 May 2023 08:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTJ-0007at-TN
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RT9-00059e-Pa
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f608074b50so16432015e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846202; x=1687438202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqWNsbArYu1VYA7jPglcF2LkuoAj2XAQgpWQZ9CCyOA=;
 b=w47vTED2VaVJyJNYqiWWQ4Q7YIKGBblmcpZx2SgGoPuaNXsRcMewQlkNFveWFIp2lN
 Oi7S+H2PesqDcvStuVV7VxCQm1FIt1lrfynWb24MT3u08MlR2WNxZHXA/m1HmDHbCOMM
 sey0EZszOdAZwZd28DFKc3ELvZPEm+NyUbtH59uA6MizbTUU2naeFl/FSRjrloA8DLxW
 9UQ+cWMwOFUEessSfM8AJmqAVAVY2wslBFH5Me/6x0QLTdUm099GM39+uq44doGkFcoQ
 tYbT4epI76TxeIFB0O+P/cUPo9O/27w36E4F/b86DafeiiuUpyac40/2lbNgXKGbkPy8
 bF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846202; x=1687438202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqWNsbArYu1VYA7jPglcF2LkuoAj2XAQgpWQZ9CCyOA=;
 b=R/bgO/QTt3rAC2IXfDZ2PsAQL8WVA6ZNonUQv9+ASr3F6sbqiNUo5u3o7/Jttz62B6
 /86iKnPd/moalhOrW3ZeqqQU1P8XTTBm+1FH+M2IlJuzvYoUxmyL+Z0RxAIw+VgbbO5W
 sc8yjHnlmFTOPm4mG2vHGpxuqmKbBfWQ6GFRFV/1EeuAc8trtI76czOQPqTZi1kBjYDI
 LT5//v8Q5TklqOGiNLpmexIiHw1KaA11z1YYUkAP/W0fQtK9cn4KnpBpzXu800HNXnCE
 Wpt9lJcb/47Iu/28RTvGajjLme/QrqRl/Ar0hEU8im/f9JRFsOQXeII9NymaQNN4UCLS
 mOig==
X-Gm-Message-State: AC+VfDy29JIl1wX4IGzYSOWMtkc7zxZniIHbrfP3F/BNQVtxKcFvH97z
 NXxpnKlRs34d/r8FmfCvthLTgA==
X-Google-Smtp-Source: ACHHUZ4sgX3oqPR75I1pHYMd6vCkpFXPLSeQhyOWH4IMQp3FUOJokcRxZhQ+BiNydPTi2kn7X9DtSQ==
X-Received: by 2002:a1c:f614:0:b0:3f5:d0b8:4a53 with SMTP id
 w20-20020a1cf614000000b003f5d0b84a53mr10552864wmc.34.1684846201991; 
 Tue, 23 May 2023 05:50:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d56c7000000b0030630120e56sm10943460wrw.57.2023.05.23.05.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2BF7D1FFBD;
 Tue, 23 May 2023 13:50:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 02/10] trace-events: remove the remaining vcpu trace events
Date: Tue, 23 May 2023 13:49:52 +0100
Message-Id: <20230523125000.3674739-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523125000.3674739-1-alex.bennee@linaro.org>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
Message-Id: <20230503091756.1453057-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230505155336.137393-3-alex.bennee@linaro.org>
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


