Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238077CCBF5
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:14:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspTT-0008Bt-Qx; Tue, 17 Oct 2023 15:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspSz-0007ZN-NS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:10:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspSx-00027U-S1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:10:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c8a1541233so38680025ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697569854; x=1698174654;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD/+KjPjtz2Km+8KJY7IRJQ+1wNJcewyU1Hou20qfyQ=;
 b=WupmmfhfO8Gi2pJIU6a+N3yJQ7fKP8wIxSFdLEgUWr/l+LN2VJ5A1u3BgVSd19RR95
 OzrkvlkHS5qwcTliALws7JFbZTdpLvMLVs2QjZ8wntLuHQ6ugpHrKJFRcZoA9+pIvgz9
 k0FY4gSRXqKxZ3t0ew3IOLLQAS+5x91OoIEgLdgu7Av3C481BS0u+jamv1YOjoSKrd1f
 LCLQ/BKLoi4bPtM4GoE0nB0g/GpbXP+UcNunT2ajAqr71as1NHwnN5Mn7mli1bKDk8Gh
 ZTxaeQzx6lSNNa9xQteagJjvWFhe7SYe+cMMaMy0HyUUF7g9z8B1ZNAjMDAwogDyM4qV
 D7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569854; x=1698174654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD/+KjPjtz2Km+8KJY7IRJQ+1wNJcewyU1Hou20qfyQ=;
 b=rKfVrMESEZT/BLvOi7b/j1QEenP2qGv9wQmXHBGO7/LPdye3x/J3TKBgFKIFDWY+ba
 UxpeYn0/syqek0jSrwbnOKbp6B4JtUp5hJ4oViV6aOHFyMC42xTFeB2cE2p9nhNDJhSb
 hxSVCdSnly6ZovzxcRHVPaHNzCFHEtCelvngzqb8DvMLRAu59KBoo3ynzFFgZEZyIRQE
 d01rWWoRsa24z/iyDc965f2GeA36ScOuXcCYi4L+mYSWDqhh5X0iKQLo+zdAxNDNAR7S
 yx3iUubc7uouCD4QjIERhdvRcZTQulrJwtkf8/AtR7sjET4i0OHuFHotP5CpCDQVpkIR
 MLkg==
X-Gm-Message-State: AOJu0YxtCWt7T9Yv5sIV36MF6mPpjmelBeGkfLk/+qKhJSD1nabWQE88
 7CJ/55PmkoGfOIjkQgBYx87YFw==
X-Google-Smtp-Source: AGHT+IHWfBkQEYpkMnzc4Kev9pGujQ3qTAI6y7Gxp0nK0QfCBoGLpDXqkV0P50DmPO1hcDPZvAZKMA==
X-Received: by 2002:a17:902:dac6:b0:1ca:4ad7:682f with SMTP id
 q6-20020a170902dac600b001ca4ad7682fmr3470210plx.26.1697569854326; 
 Tue, 17 Oct 2023 12:10:54 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 t9-20020a1709028c8900b001b896d0eb3dsm1942527plo.8.2023.10.17.12.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 12:10:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v13 15/18] cpu: Call plugin hooks only when ready
Date: Wed, 18 Oct 2023 04:09:25 +0900
Message-ID: <20231017190931.16211-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190931.16211-1-akihiko.odaki@daynix.com>
References: <20231017190931.16211-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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


