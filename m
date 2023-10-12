Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 810997C64E6
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoae-0003QS-66; Thu, 12 Oct 2023 01:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoac-0003Ou-S6
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:50:30 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoab-0007U9-Am
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:50:30 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5859d13f73dso417308a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089828; x=1697694628;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD/+KjPjtz2Km+8KJY7IRJQ+1wNJcewyU1Hou20qfyQ=;
 b=dIO/W4BjFD19mIlu9qM+2puV0FJii65oSuZJpBzO7xPVbCHKPd06U7e/6E5k84PEJ0
 lq0y6CxBiWHbaMa9WC6SLw84R9V+6F3kvda1WPNJTUBylFOD5xljlVxUvXu0BzJA7BTi
 hltAIJ/QkxNotXVXqlZRqu007urlDAdcB+z1MCj9WyPgh3zk3p9cAfs3GJeDV7HxCw2G
 z9jPjwezdXbnwUS1ckYMkgbgz4ZrkPxwbxOPDZNUFXazhB6fffewAy+6kJgybZ92q+YK
 JS3QyRmNhAbLGL4ohzURJyYSQeNm6A3hgnsWs942fcoYzPaSl2TkKNbsh1fm+TSq1g98
 AubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089828; x=1697694628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD/+KjPjtz2Km+8KJY7IRJQ+1wNJcewyU1Hou20qfyQ=;
 b=RoGkrvJwgPRYf0p3wEMbrT2FXysYskbIrAWl4ANitTwW0NBPSxKVrX6dlBV5Y90Wq/
 gNyG69wcY1lp0VXLAxdQ7lSadA9Q9ozAC0l8NxtOyUIHD1Gkn9AsqTH6O4aNHaO0vdkv
 mo7V5i+obM6kxJkziiWAfkvDc+ujJ3EN/gpK0PEm1A+npHDpq1W+xUCjJ+nLVPQEY3rK
 oAlK/h5yuAp9xvMJIVcBTm6PkrUDk2zhVW57qn8viADh5+A64m9rTZwwpfjFs81bPb9j
 dN0THcvlOh90Tt2WSc1VpFuOe0hjj9cv9ukXLieLObijSNDt4Aeuc67ZZIUWHfLt3vsa
 j/2A==
X-Gm-Message-State: AOJu0YzDO95E5GSs3yGMQBX1pV20f3nZfa8L6/LwsaLcyCBHu6/YFehh
 hJjJfSrnm0Rh4BauCj+M4ywQ3A==
X-Google-Smtp-Source: AGHT+IFSxXqY4yjfnWPkA6xejVmUKnaz5J1xAJ0ZFfo0Wo3AsFCl2LO0iSNNY2ewfCADrwOUhuPSAA==
X-Received: by 2002:a05:6a20:9694:b0:15e:707c:904 with SMTP id
 hp20-20020a056a20969400b0015e707c0904mr17662852pzc.24.1697089828113; 
 Wed, 11 Oct 2023 22:50:28 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 c4-20020a170902d48400b001c74df14e6fsm924283plg.284.2023.10.11.22.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:50:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 15/18] cpu: Call plugin hooks only when ready
Date: Thu, 12 Oct 2023 14:48:54 +0900
Message-ID: <20231012054902.38447-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012054902.38447-1-akihiko.odaki@daynix.com>
References: <20231012054902.38447-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
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
2.42.0


