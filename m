Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908D97804DF
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:41:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqJK-0003o7-Kv; Thu, 17 Aug 2023 23:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJI-0003na-HJ
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:04 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJG-00067H-Bf
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:04 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a1ebb85f99so311786b6e.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329881; x=1692934681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YE5sVXCWBz5XgKq4yhp9asZP+MEnSYD9sZjOQDA3Mhk=;
 b=li9Wx/Rg21y8AAnIuH0wfx2CS68X2aC5s5iAOsmQaNrqS2Vd24+oWBiPRDJhFxPTSq
 KXQVPA7Ly8YfEnKol8tGD0niFnugIgSp5m+H9gBpsHs4Zu3qW8jq+Di4G4stkY9RAAFx
 OWgZCjB/571Dr2CDla+CkNOuNQAxUJtuijej55sYSgbN2zyANNfjf5kRtKfhSgjtaRe1
 W7Z/LXEwjAw8IJ/dmAj1ReRAEqKvH6b9TkZaT+JAq4VFAxA7BCE9FxyhunEXwCto+ag1
 eMirzyhL7+uE5eXRZTrdIENpAp1M5li+blCvo8KdB2tVIA3OyTiakS07Nad+JvMqhw5I
 Kvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329881; x=1692934681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YE5sVXCWBz5XgKq4yhp9asZP+MEnSYD9sZjOQDA3Mhk=;
 b=FDy5mF1tPNEKfshnsHzLI3JjH5qw87kyyyD8S8f8J9kgEU5/0P3sOv62nwUpaHWHae
 ohbUB5/zU694Ous2o2UkMU44W8mLpZZgG0CMmzuS+cf4uyB9+kO09K7oszLo8Lh+mZ4d
 ohrI7Yu+nBM/LuMEbll8zRUKDEh+6gI7PuvUVB+lP0iuYHhaApNtKOAa3IyNwHWuZ/2p
 nElOBSVgrVG/z+OGaW0mo0XCXT2gDB1xtiHpaSEBIWnS5DnM8gw5YMlWV2KM6TqczowY
 7YmDSBJJ38GALBbFNfEcwMBYBwz9pBZaQ45X1k1qoH004Enzaf4HJtVCzAnUVHks1Z4c
 ES1A==
X-Gm-Message-State: AOJu0YwvZ62XjUIADp+fSJYnmw3LpJUMZCNfNoCIrlTszoMR8l+uKIG5
 U8Mn1fY80wfoURUpzGO9wMkhlwDkZ0aP6Dl3mTg=
X-Google-Smtp-Source: AGHT+IEH9yXhP2KvOe3f/aReKhjT+lTy2JrEBZRmEQFNbUK97EC8fZS1gVBAyvLSUsvi1OD4nrDgzA==
X-Received: by 2002:a05:6808:2a4a:b0:3a7:5d6e:dcf8 with SMTP id
 fa10-20020a0568082a4a00b003a75d6edcf8mr1586049oib.39.1692329881132; 
 Thu, 17 Aug 2023 20:38:01 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:38:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH RESEND v5 22/26] cpu: Call plugin hooks only when ready
Date: Fri, 18 Aug 2023 12:36:41 +0900
Message-ID: <20230818033648.8326-23-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x230.google.com
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

The initialization and exit hooks will not affect the state of vCPU,
but they may depend on the state of vCPU. Therefore, it's better to
call plugin hooks after the vCPU state is fully initialized and before
it gets uninitialized.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 cpu.c                | 11 -----------
 hw/core/cpu-common.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/cpu.c b/cpu.c
index 1c948d1161..2552c85249 100644
--- a/cpu.c
+++ b/cpu.c
@@ -42,7 +42,6 @@
 #include "hw/core/accel-cpu.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
-#include "qemu/plugin.h"
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
@@ -148,11 +147,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
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
@@ -179,11 +173,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
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
index ced66c2b34..be1544687e 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -209,6 +209,11 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
+    /* Plugin initialization must wait until the cpu is fully realized. */
+    if (tcg_enabled()) {
+        qemu_plugin_vcpu_init_hook(cpu);
+    }
+
     /* NOTE: latest generic point where the cpu is fully realized */
 }
 
@@ -216,6 +221,11 @@ static void cpu_common_unrealizefn(DeviceState *dev)
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
2.41.0


