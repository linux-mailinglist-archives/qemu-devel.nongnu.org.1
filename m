Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 460A17C929C
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVWU-0004s1-Nj; Fri, 13 Oct 2023 23:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVWQ-0004lQ-K9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:41:02 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVWP-00051F-2P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:41:02 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-27d45f5658fso836418a91.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254860; x=1697859660;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD/+KjPjtz2Km+8KJY7IRJQ+1wNJcewyU1Hou20qfyQ=;
 b=wCeKx3koXyC4KsKD++Bgms45etFGz9cbmskAsSwGGdlViA1rHX/4mqPIowvZTG2KZr
 iT6YjxHwwMAm/pkbO1PCw/scq4QJD/hiRQR6+f+GOvNPvE/1z84c1RyoR83N6iqZCN8J
 dN+4tK9WJwHOAApgJi5HyaO1ANd79CKdBwSPSShvGgZmGzzqXreejvoa6sigjkh280Rv
 8zrYRGi4CCaet7I5U//OAGY6WfpfOak1/oncFn0KpxiYM6JBrgDUZG+ZOpcP7nXW4GsD
 CccAKdDzKqC9gD6rJgHC5uoUQE5G9SmiqEaxLomGkoZo/GKJByqAXzHwsZSFKAevwcSL
 hcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254860; x=1697859660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD/+KjPjtz2Km+8KJY7IRJQ+1wNJcewyU1Hou20qfyQ=;
 b=vwP68WULjjip8SRQS/IfCY9TkJn6Irt+sWvEretOjJFBo/D4p78J7SuBupOSpt+pTw
 7Ej1f6GTZ0R4o9qCsYODxVL/KybtKejPz+EOmkK4+rOMZahEXWKa9grRkEs9Radv3uKe
 KywzXvrRH25goK15kcBl5v3qDRxAMhAYnukgQfy9uqL2lB8xT+0OIY0SzAxJxHD0mbU6
 rbnJ+hXIdcrIrfRoOQ0weUQE9/LeR6vyZQz9U+C5crKVlKbzK3AJoCPQt3DTOII7Z2hT
 fdOPaoXnq/RYUMVtzJXFgP2/HfmwxTYgGmU/M5Y1yWgwA/QLG+DNr1/poXQKehDmnTqB
 hO1Q==
X-Gm-Message-State: AOJu0Yx3ZyR2gJUgLY5cBq47g6pxzfjqRb9cH4IxGpxR2sy6L7SVdKeC
 AJEjPPNje+vpY3KX/K38eO6cig==
X-Google-Smtp-Source: AGHT+IF0owpIu9eyIO4Amj5g1ZMYdtrZSyFIfwneqKbmBQLGn7akYbfNkDNEfrllb8VQ3oLbpClWQQ==
X-Received: by 2002:a17:90a:1992:b0:27d:2dde:5979 with SMTP id
 18-20020a17090a199200b0027d2dde5979mr4582088pji.5.1697254859863; 
 Fri, 13 Oct 2023 20:40:59 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 lt6-20020a17090b354600b00262eb0d141esm814118pjb.28.2023.10.13.20.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:40:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v12 15/18] cpu: Call plugin hooks only when ready
Date: Sat, 14 Oct 2023 12:39:34 +0900
Message-ID: <20231014033940.15679-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033940.15679-1-akihiko.odaki@daynix.com>
References: <20231014033940.15679-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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


