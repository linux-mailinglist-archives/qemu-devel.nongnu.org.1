Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1C67E09C2
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:03:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0Me-0001hU-WD; Fri, 03 Nov 2023 16:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0LK-0008OY-6m
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:37 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0L4-0005f9-BP
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:33 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso33394371fa.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699041615; x=1699646415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b88ySiChZ2erUB0s9VPiqeJUXsHB8fg3nHTqedran50=;
 b=Qxl4kBZiobhLr4Vg8JGFNrOiOOHKUo94SSxOPlWEmaVbnZBl0yAzHv8cN3KhRs4/2x
 63sukS6sHd/ispC89zPcgelTqPzH4HG7AT8opJL1ANvPj/G5K0ANPN2og6EiKJgCurgT
 Mn1rAq6h0U/AtZWHog76gbOeu9ALLkxL453T3nOOoCGa9zEKBpKFBs6tk65lw8jLfLrv
 /JwHwmbO4QvVIV8gBYD5krYNLBodPw5SxHk8htSuwl0YYnkJvvUR9bkGowiOr3LX9SYN
 MwQO0ZmYilCy/jwBsUqkvakweTy97l7wxvEex43lVR7EK0UrwZMyNa90T8Bs7iDDxBKF
 eNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699041615; x=1699646415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b88ySiChZ2erUB0s9VPiqeJUXsHB8fg3nHTqedran50=;
 b=h+aw+tLn84uexq9l6gLd/U1KCMmxZBQwDBWhGI9+NGnTFAuQ5j+txYLueOydF2b7n6
 9pr38J4YgQO1pbWdsUvjtqZ/KU0Hy4KW3+KNM1QPVbMvNh+PekpNuHyFi2ZRafPlFY01
 lEUyRWxWeYKMexOtuYZzOswnRSbaxDl4dPJOO7DzoKACPnMB8moQ50jRcAeG2RwwVawk
 SppIQk5m91IuLCbVWjBUb+3XkZMGiMT9weeiXSvWZXDsWIRW7lg5Nh8t/ejA0L5ZKw9A
 R9iHIiDN/cEm4RjzxvRFs2hK1Azz7NoO1iShvV3SEXisSi9HYOJ9bRGQizZV7J9aPLWS
 4SNg==
X-Gm-Message-State: AOJu0YwLz07MT+vMRVNx0T8IqwrlVg6mW1cTOf7vUowyIPSnug50vB93
 6rodweKpDxdFR46fGUSi/mmU2g==
X-Google-Smtp-Source: AGHT+IGAscildE8716X2KoAXReCDLhxyo9UDkVw6jKzk60tjzS0Oo+DGwtOEDgRY6oyqKLIqPC6rKw==
X-Received: by 2002:a05:651c:1310:b0:2c5:98b:8bdb with SMTP id
 u16-20020a05651c131000b002c5098b8bdbmr14643914lja.49.1699041615092; 
 Fri, 03 Nov 2023 13:00:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g23-20020a7bc4d7000000b004063cd8105csm3366511wmk.22.2023.11.03.13.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 13:00:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 22FDA65752;
 Fri,  3 Nov 2023 19:59:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Brian Cain <bcain@quicinc.com>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 22/29] cpu: Call plugin hooks only when ready
Date: Fri,  3 Nov 2023 19:59:49 +0000
Message-Id: <20231103195956.1998255-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103195956.1998255-1-alex.bennee@linaro.org>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The initialization and exit hooks will not affect the state of vCPU
outside TCG context, but they may depend on the state of vCPU.
Therefore, it's better to call plugin hooks after the vCPU state is
fully initialized and before it gets uninitialized.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231025093128.33116-16-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpu-target.c         | 11 -----------
 hw/core/cpu-common.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 79363ae370..00cd7f4d69 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -42,7 +42,6 @@
 #include "hw/core/accel-cpu.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
-#include "qemu/plugin.h"
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
@@ -143,11 +142,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* Wait until cpu initialization complete before exposing cpu. */
     cpu_list_add(cpu);
 
-    /* Plugin initialization must wait until cpu_index assigned. */
-    if (tcg_enabled()) {
-        qemu_plugin_vcpu_init_hook(cpu);
-    }
-
 #ifdef CONFIG_USER_ONLY
     assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
            qdev_get_vmsd(DEVICE(cpu))->unmigratable);
@@ -174,11 +168,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     }
 #endif
 
-    /* Call the plugin hook before clearing cpu->cpu_index in cpu_list_remove */
-    if (tcg_enabled()) {
-        qemu_plugin_vcpu_exit_hook(cpu);
-    }
-
     cpu_list_remove(cpu);
     /*
      * Now that the vCPU has been removed from the RCU list, we can call
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 2a2a6eb3eb..409397e2b5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -210,6 +210,11 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
+    /* Plugin initialization must wait until the cpu is fully realized. */
+    if (tcg_enabled()) {
+        qemu_plugin_vcpu_init_hook(cpu);
+    }
+
     /* NOTE: latest generic point where the cpu is fully realized */
 }
 
@@ -217,6 +222,11 @@ static void cpu_common_unrealizefn(DeviceState *dev)
 {
     CPUState *cpu = CPU(dev);
 
+    /* Call the plugin hook before clearing the cpu is fully unrealized */
+    if (tcg_enabled()) {
+        qemu_plugin_vcpu_exit_hook(cpu);
+    }
+
     /* NOTE: latest generic point before the cpu is fully unrealized */
     cpu_exec_unrealizefn(cpu);
 }
-- 
2.39.2


