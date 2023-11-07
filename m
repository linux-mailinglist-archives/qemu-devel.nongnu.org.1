Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5AB7E41CE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0K-0004Tr-Hk; Tue, 07 Nov 2023 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N02-0004GF-GZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:14 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzw-0007bk-VE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:13 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso7247857e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367047; x=1699971847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtDpNZGc7bpiPdq3AvEGwADJunLb29I37B0SspqL8mk=;
 b=jAq1zHgVNomIUNYWFsRslqsJp/z8QqpxKSjDjPZnJ2zNX1dWVxwf+DJogxQNUMbNxG
 no7zJD6V5d938UXIbdhL7ZgNqD5P6h8qHUi4Ux0Vz7en5K9gVSMbXejrE/kzYthUzFLs
 /BOsul3TvoWxH3HEuqUIiUCTXc8ypNUSr/yR3amzAyphuENusZL16b6yHJnjd8Wlt6dW
 l03zFNRnSw3QyljmZGDAKKMUqXY3bOtRW2cY3P7ozlogH4fpMxKIHIy5nw6sAp6yH6W2
 mDWYI2v0v+q+o0duaMS8563tjQn1iol4aOuqhcz0RwfANRSw1yaAdXOARpFeRNpHfwW8
 bVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367047; x=1699971847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtDpNZGc7bpiPdq3AvEGwADJunLb29I37B0SspqL8mk=;
 b=Veuq8fDVGTFE8Dw/PwGqxzJBZY85dMNJNc3ygg1a/sQ+T79YGIVb7DCZIdFP8oqd0X
 xiIDcgGELRh/auDno3W4+6q66KE8q06bhsiPEV9o4oogogIMoYscWb3TdScUZopnbtOU
 0LRR8kD9mIqe2Y3kT4qY5TxJNQcuG3qAlnNqIDYhmWgiUfQ/bsqJQ0SyqN1JAObsHJ0c
 FCxGa6fgVJl2QpJunld4ZoB2d19CEGmjrC4F3tWVyH+7m32zG/U9VhV3CNn9WFy4Jktp
 9f/qvrB3tcAaYIP4JKbIaTQ2WbTPUckmSqsTPPJ0Wg1tNieaeZmG8nPx/vEVuFAcuMCS
 +BKQ==
X-Gm-Message-State: AOJu0YwQyRj3+WTdkSVVvHdvWfZ3SCC6z9x6yD4omApgkoVw6o9HaFOY
 1Va4hqTtCbEoVVncxMrAHgmtCw==
X-Google-Smtp-Source: AGHT+IE03XZ9iSIcJzaUdtGRjAZF9pH2QqmGqwEAcVTF99Awdh5aDcxYkQW8/wYPgG1DDcHk+rP/OA==
X-Received: by 2002:a05:6512:1085:b0:509:458a:6c1 with SMTP id
 j5-20020a056512108500b00509458a06c1mr15561705lfg.19.1699367047239; 
 Tue, 07 Nov 2023 06:24:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x4-20020adfdd84000000b0032fb0e2087asm2492340wrl.82.2023.11.07.06.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:24:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 989BB5F790;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/23] cpu: Call plugin hooks only when ready
Date: Tue,  7 Nov 2023 14:23:42 +0000
Message-Id: <20231107142354.3151266-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The initialization and exit hooks will not affect the state of vCPU
outside TCG context, but they may depend on the state of vCPU.
Therefore, it's better to call plugin hooks after the vCPU state is
fully initialized and before it gets uninitialized.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231025093128.33116-16-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-12-alex.bennee@linaro.org>

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
index bab8942c30..0acfed4c0f 100644
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
2.39.2


