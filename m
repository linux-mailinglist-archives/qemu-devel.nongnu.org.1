Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B524790AEC
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfKg-000112-4f; Sun, 03 Sep 2023 01:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHj-0002pY-6I
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHg-0001mi-TG
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d6so3206545ad.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717467; x=1694322267;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=742GFhBpf1pg2BKTTUHd5JgdDLCS73N6xC6sRLNFg04=;
 b=yncTJHdTguLt3RrWuDmGdvr466qtetyKZ3Fc1hTUbBf+uzKPZoSakaczmRO9UFjx7T
 YAaEr9XKcO0d3xsVhE0wgSfOOhoZoMXBW6025dKkZrgC1Me8sUyUqkd4kfz8zPK/foqB
 saArMxmWI0OflzAYKhpXzDaDmSCI05xETtViE/kqSQr/JeVzXmlelI+Y8IoMpoX8qR9+
 giJOLKfgm2o98UjTzekWeM13gTGOLL4v7tvJd5130wKjDAQvrNvx7oIq1nMWGiELNBiX
 zo/Pv0zB9ZB/XT8oabRHDV9W5NFqVz72vu5kalTRgnPLSIMVaosjW4KRrtDGvI1H2SN2
 595A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717467; x=1694322267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=742GFhBpf1pg2BKTTUHd5JgdDLCS73N6xC6sRLNFg04=;
 b=BC7HMWhj2fyP39PlIWb40u60PkYBuU/mt6Q64k9bNPJR3jvy154VGTl0jxqT+1w1Wk
 UpAougMiRafd+jhww261kepaKuLcmPiuw5hsTGPP6H1qGIqH1voUIUIrtwFHoUUf+8BU
 fqsR1Xyr5jOIPOL8oHRSP7rXKEh8duG6XwskGl7U+WfPFElJEJQllloxJxWT58uRg+Ze
 5JeswHEx64w53rs8yA9CR/7mruev/7ELYnjH46+OQ8akUtpwiEu76JtfMGbu8CnZbob0
 N2CXppyBk2FxQHe2HciSmQQVTT1Vi77UbEwIhJ1Y4MbPDcMhBqVE6HxzBf62+Y0TsUBw
 bbWA==
X-Gm-Message-State: AOJu0YwLeHg4jHwe/TFhIEJgebOJnF0bp6QN7TvuhTlmKEzw63UX8uVD
 dnHXZCBYirKct8MzIyjN/SjJ+A==
X-Google-Smtp-Source: AGHT+IEQb9KHrw2JPaQuCaiV96lH6czm1v9noctCBc0Qy4j+5leFGdYLhaW23Ou3syO/vtSbCC5vWw==
X-Received: by 2002:a17:903:2352:b0:1bc:1b01:8961 with SMTP id
 c18-20020a170903235200b001bc1b018961mr9208581plh.1.1693717467515; 
 Sat, 02 Sep 2023 22:04:27 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:04:27 -0700 (PDT)
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
Subject: [PATCH v6 14/18] cpu: Call plugin hooks only when ready
Date: Sun,  3 Sep 2023 14:03:22 +0900
Message-ID: <20230903050338.35256-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903050338.35256-1-akihiko.odaki@daynix.com>
References: <20230903050338.35256-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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
2.42.0


