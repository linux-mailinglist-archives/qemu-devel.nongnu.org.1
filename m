Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB1E7C6ECF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:10:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvQ5-0003We-NF; Thu, 12 Oct 2023 09:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvPg-0002lE-D2
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:41 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvPe-0005Kb-NU
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:40 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d18475ed4so798702a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697116057; x=1697720857;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD/+KjPjtz2Km+8KJY7IRJQ+1wNJcewyU1Hou20qfyQ=;
 b=aCbdGLBYqBSIM+467aSO8FyvjB/RKbTaoXqCtaIHPBIkXoXf0GUnWa8jmAoYXVX5ad
 gBRSeuWc88vn6K7IYyNzdrnkMWlDkLeQ5JU1XIjByZv8wMyP1O6mYjLwnlBEjgFb9rrf
 KEBrHmc0/ZKC1BdhBVcqiKKTVSX3Qtp8io+v3L56Aboa60trF4DDEDzXRtf5PHuN03u9
 xsf/HhH5CMcLrK6M0RhbWelFA74BQigVcE2EvVIQ/8vdAgxqtnlRdSbRosSlFdL1ajzl
 O1dSj0MwzxdDvvXjPBZGs0iwdJQPN3u16wF6kRb8fBJyQ16vXmOYv8aPn6oIlPt7oYmV
 HsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697116057; x=1697720857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD/+KjPjtz2Km+8KJY7IRJQ+1wNJcewyU1Hou20qfyQ=;
 b=sajF2K6h2nTkUdsaan+ao9+Jow6O1YoYAzxIddT3PZpM3cZLjYw0g0+dMr+SxG9Qpy
 tWL2L+jk/CNY98PoN4iA9i5edC+qIfm5vPD444yRC+aS3mzQxuLUl9woiFJ6r2qQTPjn
 HKrmydp94w7TTvz6SbvJlyzS7s0Vfr72GGfR5lfTvtLEbgvBIMyt+wXJEFhPAzxsj2pT
 HnbsStIMeqgX4bNjIjueubl/EjG21p0UxeRq1o/CEzj9qWSK3VFi9tLKDC+WCOzxql1g
 /QLTVf/BvWbJrb6Y9ltnaMP6zu1uOxdbKTK/+SCMfgno/nNu3+DRObCCP5RCIBHils50
 9tWQ==
X-Gm-Message-State: AOJu0Yy2wfbqQcTuliEVxMBb5YekszXRotLveOIkaB8+ur+kqzDpRR4I
 /byrKFpjBkd4GQLdfb7/svqICQ==
X-Google-Smtp-Source: AGHT+IFLIaDIwPMyGpVnaGgn76cSy8gegi1kqO8vjQ850bUiiKkVkOMSBvwiNseAD4LbJg4A9YgKhQ==
X-Received: by 2002:a17:90a:1549:b0:278:fe0e:4ffa with SMTP id
 y9-20020a17090a154900b00278fe0e4ffamr21462940pja.43.1697116057359; 
 Thu, 12 Oct 2023 06:07:37 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 in4-20020a17090b438400b0027654d389casm1772022pjb.54.2023.10.12.06.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:07:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v11 15/18] cpu: Call plugin hooks only when ready
Date: Thu, 12 Oct 2023 22:06:09 +0900
Message-ID: <20231012130616.7941-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012130616.7941-1-akihiko.odaki@daynix.com>
References: <20231012130616.7941-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
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


