Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9F7D66E3
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaGC-0006p0-Ez; Wed, 25 Oct 2023 05:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaGA-0006hI-CU
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:33:06 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaG8-0002V0-J6
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:33:06 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27d329a704bso3746342a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698226383; x=1698831183;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkM2AOX0mfoMM+mEdrh8DDAgQYoEqlrVh9W0zpOY70M=;
 b=oPxKanRs2gcXwE7VZn3kers8IZbQ6ZicNS6ujay8l+USnc6tIbf7a26+5yOPD7xOi6
 qtAncZjiiFVu2ctOUTBBYpV2300fZyLTMVVlFsYGL45D58MXHCg6hRvbC5ytWxBXSInM
 6qdHpBVjIN3z54Dn67QQvQlIw2jjiRcQak98pXgTzylpOYCE5XN7W7XUCJdWeeQJ796d
 rPQpWVVu3zny7baUiGvCmR/TFl5/mmCgXPWnCuBEhAS/YubUV66PA+Z49Vxep6QtSH7H
 nzXe7l5Cu81qoNyWhMVCHkpk2ztHqR3j3t7m4mzAIcQDWLUHG7dVnL8j7t3oqwofuUCg
 3ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698226383; x=1698831183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkM2AOX0mfoMM+mEdrh8DDAgQYoEqlrVh9W0zpOY70M=;
 b=v1eOqbvht43GDK4eWiIHFJiAl+CvJWAvafevWTIRISEwQMU3iHG+wzv6q/KeJNgpdd
 Q/n17eIwquMm18VsUnuZfar0F58EL8qOjCHL4hmFiAppkaXmtlvsbclMrmEpW889TfNN
 fhWUxVl5IifE3iPaUMgmHYprNxJRwCBKMOZ/q4uxV7xbw1aKexc1f+FzgNlwAvkz2mRK
 2Bx3p6JTlw0pJyQiRHoskMdLitqUh6/RqlVKYSbQwv5N5zsMRvlIdm17KzujZVRosqBB
 TJuhx7xSRLgn/8kHEzC+4Nx7NqrgxRmw83EObVv50Gk2tpJ5hCM5xGdGhh70IgaMw6gK
 BzLA==
X-Gm-Message-State: AOJu0YxKd9BC9McEmmOiL2nHdo2bBpg8jAxHSIZyyJNBfh6Ps57Zv7Li
 LGsP/RLLjUYLZpmhMrhGcsePWQ==
X-Google-Smtp-Source: AGHT+IHo8swSRRCovP2C4P4TpDATsnOcz9EYDlQXFyGpyvqXas8e56Cb0zBYj8yxyi26x7f9FR4TUw==
X-Received: by 2002:a17:90b:3949:b0:27c:ef18:d270 with SMTP id
 oe9-20020a17090b394900b0027cef18d270mr11282263pjb.20.1698226383135; 
 Wed, 25 Oct 2023 02:33:03 -0700 (PDT)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 pd11-20020a17090b1dcb00b0027cf7818fb6sm10310803pjb.37.2023.10.25.02.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:33:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v16 15/18] cpu: Call plugin hooks only when ready
Date: Wed, 25 Oct 2023 18:31:15 +0900
Message-ID: <20231025093128.33116-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025093128.33116-1-akihiko.odaki@daynix.com>
References: <20231025093128.33116-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


