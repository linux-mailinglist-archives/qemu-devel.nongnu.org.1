Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1717C4B38
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTHQ-0001Lz-0e; Wed, 11 Oct 2023 03:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHM-0001Ht-2v
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:12 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHI-00060W-AW
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:11 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c88b46710bso35807325ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007907; x=1697612707;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpWOFvYMQFpcS1OA9qVK9BdW3N+KSH4Z6aCyq4NfX2g=;
 b=LsJH3HNhaR/JBI34VdvaVlwX35HFfYTXcE/SXeWOx6l06qV+O8OKg+kSOarmT0BCzD
 /690AAptP7C4P/0ImtGvwxhg2YgBSfOEc6L0UNdPzwFHxtfoQr0E+VvebnnokoN87jsf
 4bDbq9Gyfx94Ww7btFi7oPu6Az6PU9YEny5lEWEbNYvQCMaQLlKj6vDATkKd10tefKXJ
 43p9T3MicoBNSFySou2qozJdf4BybLyUeG2BrzMjKOPwDd3Wt27FFVgw0F5/6cyMw6nC
 CmG9NwiD8Yk5rlgtz3wW5p9NkHPiHlgMdjokiinqsR5hvveH24BMHxy+YiuWqOkCvcab
 HOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007907; x=1697612707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpWOFvYMQFpcS1OA9qVK9BdW3N+KSH4Z6aCyq4NfX2g=;
 b=IaRSnJGqFn0kAqvYRvw131ZsBQ3pAaPwQPFWRHR5iD/SlX0mM0jSD+EAsqctDoxhiL
 R7ExK+dusHkbVbFMBCSL5iN+KJdKxdREDGAsxx1VWg1vwNw0Y+FAAGgCWPIS3m+0BMbY
 M609E6HPtcCGf2BZVLJsQRMKwujVJ5IUYs1MFJBffjItd3CHKmgiOel7of5cRmNuzpH9
 hG2sI0pKDoGn1ymBPcr6RmDfOgIWVMeeikW5z4RiamqSi++TI34w9Zcw2FoZCIDJXjVy
 4NS1E3+1Fk/MSGb6mnAx7+bOBDFd08LRzG1GbmJo9F12mSLvZ+oW2AjJjySWX39BUmlk
 V0Wg==
X-Gm-Message-State: AOJu0YyuOJoFt6Q8zK1+mUE6XtL7MMON7GsdzWYtKJYBET13FK12Qup7
 i0vRST3znqEcYboiC2NH3Zkryg==
X-Google-Smtp-Source: AGHT+IH9Qs3lRAI+K1otRrs0ctExI2GxJq5T+rmZM2s0E+PzZx65pmIiWhHQ2mA7Uo1YFd/gNQZ8LA==
X-Received: by 2002:a17:902:f7cf:b0:1c6:1c80:5663 with SMTP id
 h15-20020a170902f7cf00b001c61c805663mr15920738plw.41.1697007907055; 
 Wed, 11 Oct 2023 00:05:07 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 p10-20020a170902eaca00b001b8a85489a3sm13088198pld.262.2023.10.11.00.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:05:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v9 18/23] cpu: Call plugin hooks only when ready
Date: Wed, 11 Oct 2023 16:03:04 +0900
Message-ID: <20231011070335.14398-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

The initialization and exit hooks will not affect the state of vCPU
outside TCG context, but they may depend on the state of vCPU.
Therefore, it's better to call plugin hooks after the vCPU state is
fully initialized and before it gets uninitialized.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 cpu-target.c         | 11 -----------
 hw/core/cpu-common.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 658d179582..7acb65fd39 100644
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
index 0767714048..9805d2c301 100644
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
2.42.0


