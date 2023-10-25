Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9D87D6133
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:31:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWSN-0005RR-Vl; Wed, 25 Oct 2023 01:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWS8-000508-AR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:12 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWS5-0001GE-M4
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cab2c24ecdso34619865ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698211748; x=1698816548;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkM2AOX0mfoMM+mEdrh8DDAgQYoEqlrVh9W0zpOY70M=;
 b=AS2fYGgSTkwKTkizJZH7WOMnpW4l3Xahtdrq2Ku6+TZhT+Ix8qfekySNhfdH6Lck6k
 nJETlroBS6vI7l7XCqr4uSuYk1X5Rg0ygi2a9wx/WAReWexQ+az3zbf+OsHLKkv8nbNZ
 OqdUNy/COa4Y/n4tMZrkC/IfofPo1j4UKpkrOs12nhfqvVuqSolYC9Rogz85aRuNJqTN
 yyegVjw00MnqeR+cD7HXVauan4sClsJ4+FGgLOLMwDgHj/18Ax3zFGf0fWUobxM4cVEb
 DAkCvfMi/+3zWDdHGAXuPyVv0SmdC5iqpYYE1zHHXv9Gtl1AedqGg62tOphSZiojQXYx
 9HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698211748; x=1698816548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkM2AOX0mfoMM+mEdrh8DDAgQYoEqlrVh9W0zpOY70M=;
 b=V8VhoQ9SysHbVfcul7QlToWw4LeYJF6uGWeh2YViSzxeNyBnItQjrzviKtIJPxpPKC
 S96J4seqxB5IKTxhhZMxCENxWvgK9KcZsBqEdv8RmCNLShZaCz5PPDxL9YruhMYsZbPr
 Jc720Y3jNDJsepTtk+YxD4kz16gExsTyzi2sXfPa6ed8nqiFaRdUVIPqnlnbTyP+Zj7u
 ESo+k3Np/S8QMRVHXinqnQghvPrZzkfpnOnyNzSjVayWzoVrj5CR52LsNtT2i+SpZwzt
 vE2T3wOmZrUwRpYqxKh2ozPCturLWU6B5LrdkqbYnI1VrMXW31vg5wNuKNhJO/qdoSso
 4vbQ==
X-Gm-Message-State: AOJu0Yzlm/+q599sLH70xExS8tcMMTuSj2Zq0r8UCPMiETq4UEDIjQM0
 EJpJWv18/P3rtVkwoygeA3ERKQ==
X-Google-Smtp-Source: AGHT+IGjlg2sR9A0p2Yu5MCceyzuNR+oXUWeGMbpG02mEKqj9CzqdbQNhhHSLPQRdv0PRa0SL5q45w==
X-Received: by 2002:a17:902:da83:b0:1c7:4973:7b34 with SMTP id
 j3-20020a170902da8300b001c749737b34mr13393836plx.50.1698211748012; 
 Tue, 24 Oct 2023 22:29:08 -0700 (PDT)
Received: from localhost ([157.82.204.207])
 by smtp.gmail.com with UTF8SMTPSA id
 f12-20020a17090274cc00b001b86492d724sm8253688plt.223.2023.10.24.22.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:29:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v15 15/19] cpu: Call plugin hooks only when ready
Date: Wed, 25 Oct 2023 14:27:37 +0900
Message-ID: <20231025052744.20697-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025052744.20697-1-akihiko.odaki@daynix.com>
References: <20231025052744.20697-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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


