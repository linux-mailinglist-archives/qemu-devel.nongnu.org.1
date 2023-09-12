Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525BF79C7EF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:16:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxaC-0003Bb-IC; Tue, 12 Sep 2023 03:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxa9-0003B7-EH
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxa6-0006fO-5B
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fbb10dec7so1742459b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502785; x=1695107585;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=742GFhBpf1pg2BKTTUHd5JgdDLCS73N6xC6sRLNFg04=;
 b=0kGpxa3xPDvLo1n9ZnPi4pW6rA0+DLTtaiVsk3VMx+2B96K1L+aLmTuizmWYZFElsN
 JgJZUBRv8+/F44TREZpkDF6bmgkRYJVae7tM6F7qzwG7plFbttlTXJLcz7YHcrvndvn6
 YRw9+mOxnXR1Dj+sXA4unvF50R+Hm3oOLqt2FESCEbfBtQMtTw8ShE33SZ1rK1zvcYkl
 9+fs0Ii1TLv8Hx7ra6R6uCjoDh41zhTYUFWVUteUYrvuCksMkHF979ot1rcfB5waTlKL
 VpqkP8sIU3WXseavrQSf9M08w1NVrYxzozakyZ8RX7usFisNaraDQT4jdwd4NBH6rBjE
 a5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502785; x=1695107585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=742GFhBpf1pg2BKTTUHd5JgdDLCS73N6xC6sRLNFg04=;
 b=qnNGTRUvnws1p1pxX5g8T4NSn7Ff9F6kHX7+trKQXwGevj2I9poEi9Yf3beqU/8eKQ
 +wh0/t2qz0OgW6wgy5Hm5+/mg92Yy4TwtRwgnHPBXhMSkYTiSnrSiedOA0UZ3WhzPjB2
 U71PlKtYyvHffjRklJGhnbKiinPzsltg5IcS+X+QcGQam8gVIcQGNaMR4Kf31iF0NmVn
 JxBlB+3DGns2oCdwjJZT9rlphl8QvlmbPLgYO4uXx+EIISD2wxeS3leLMqIlg92EpBwF
 us9Y0IznxQxfkchUoPN8YQ6yUP+27X/Tao8vYVTBCYb2iesbfjyubTSH+ng0Wf+CzLO+
 QIxw==
X-Gm-Message-State: AOJu0Yxhn7KZJS5ZRK0uON5TDaXdZ42mheKqzt81UuhP/HdIO+vctBg0
 n5DEYZciAo4rm9LES4sQIX8rr+xeQ+QFHq8lYj4=
X-Google-Smtp-Source: AGHT+IGq66jeVsH6sSj2LVMrqzLU2ma0yVFfb6+UtSbehYqZavofSKf7LGYoxz7MAYdkWlobnSIi8A==
X-Received: by 2002:a05:6a00:1d0e:b0:68f:c215:a825 with SMTP id
 a14-20020a056a001d0e00b0068fc215a825mr4379036pfx.12.1694502783484; 
 Tue, 12 Sep 2023 00:13:03 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:13:03 -0700 (PDT)
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
Subject: [PATCH v7 14/18] cpu: Call plugin hooks only when ready
Date: Tue, 12 Sep 2023 16:12:00 +0900
Message-ID: <20230912071206.30751-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071206.30751-1-akihiko.odaki@daynix.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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


