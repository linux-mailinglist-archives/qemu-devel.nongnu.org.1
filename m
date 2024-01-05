Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE5C8256EC
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:45:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmMQ-0004bJ-TN; Fri, 05 Jan 2024 10:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMN-0004a6-RQ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:43:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMM-00037b-37
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:43:47 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e37524fafso8903105e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469423; x=1705074223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIbpZfgL2GdYvVTJqmdprGQ276jFAcijx1XENXuPWGk=;
 b=kddC/ty8CGTqJHmRGxs5FvNNFEcQOb84m/dtAls4cZS1vrL72cla8RnZUPhDu3FA1v
 lMTAVCyoqh1Y0/EoZHyj99u9DFo+r3/9zUWrziuMajrFA7rXHyC6TkhAmCqMBVNXQGf9
 cRd6dNbmVOFeoHoGbPzAGq2zf0RjwODlvjOEZhOHqn/zDMYmVjx1UE49AQjF/vKqFK9M
 BsD1bAbq52gGJa1nAQTxzhWrjbqQjjpux2nS8ItoEaKDttlSMi80sqc5dLgYiNm1Covs
 Yg3K0ae3Bfhld5h0lIlslHeZUMqbMPfsBwwko4051LsiGfGcn5lBEywalkEEDCqlZjte
 OWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469423; x=1705074223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kIbpZfgL2GdYvVTJqmdprGQ276jFAcijx1XENXuPWGk=;
 b=fhfQ3moP49wyo5RmYoLD2Eho7FhBQTPbPSc4P8IivwgXm/D2MLdsx7ArJw6ntdVdHb
 3xBQ8CnQKC/PZTLKoPEtGvpczdzduZg4mjacLHSfzQrUlyLst+Cv091SrC9lnqh3yr7S
 FkqUT6bXJaGypsCY1W2MObk2dyloXKcR3QtpWAmYEq0Pua+qwROM23pVJU/v4HXESWoZ
 pYHTbo7BlDp304PSOs1MJb5VZlf3v93L3L6Nwz+Q9iYQSGMdTABV3R7Ky7Ht/NC5slI0
 xqFtfhXJCqzrtiPabEpWFAL7PUG0U7SD0jpdLJV2hc/MAvaHWJVx/FnW9wX2iehPX3Yc
 qriQ==
X-Gm-Message-State: AOJu0YwFyXf30I274fUxVTYf3OQutnPFptrYVlf1jZm4DoY6NgyiDGGQ
 UrjZgFVMJSQTWcib4KbxY5+cILXf9OU16Hlr1dNASGGJhsU=
X-Google-Smtp-Source: AGHT+IFNSGg21WHACL8WVEdlAMnB0moS6tkcRS+hCip3mongDPrSWiboIOw7D6dWHnEcdVKHsqBwug==
X-Received: by 2002:a05:600c:4e8f:b0:40d:9238:df50 with SMTP id
 f15-20020a05600c4e8f00b0040d9238df50mr1269643wmq.81.1704469423467; 
 Fri, 05 Jan 2024 07:43:43 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 u14-20020a05600c19ce00b0040d5ae2906esm1929189wmq.30.2024.01.05.07.43.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:43:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/71] cpu: Add generic cpu_list()
Date: Fri,  5 Jan 2024 16:41:59 +0100
Message-ID: <20240105154307.21385-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

Add generic cpu_list() to replace the individual target's implementation
in the subsequent commits. Currently, there are 3 targets with no cpu_list()
implementation: microblaze and nios2. With this applied, those two targets
switch to the generic cpu_list().

[gshan@gshan q]$ ./build/qemu-system-microblaze -cpu ?
Available CPUs:
  microblaze-cpu

[gshan@gshan q]$ ./build/qemu-system-nios2 -cpu ?
Available CPUs:
  nios2-cpu

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231114235628.534334-7-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/main.c |  5 +----
 cpu-target.c    | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index e6014f517e..4de226d211 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -378,10 +378,7 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "cpu")) {
             cpu_model = argv[optind++];
             if (is_help_option(cpu_model)) {
-                /* XXX: implement xxx_cpu_list for targets that still miss it */
-#if defined(cpu_list)
-                cpu_list();
-#endif
+                list_cpus();
                 exit(1);
             }
         } else if (!strcmp(r, "B")) {
diff --git a/cpu-target.c b/cpu-target.c
index 6f4afc1dbc..5eecd7ea2d 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -24,6 +24,7 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "migration/vmstate.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
@@ -283,12 +284,34 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
+#ifndef cpu_list
+static void cpu_list_entry(gpointer data, gpointer user_data)
+{
+    CPUClass *cc = CPU_CLASS(OBJECT_CLASS(data));
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+    g_autofree char *model = cpu_model_from_type(typename);
+
+    if (cc->deprecation_note) {
+        qemu_printf("  %s (deprecated)\n", model);
+    } else {
+        qemu_printf("  %s\n", model);
+    }
+}
+
+static void cpu_list(void)
+{
+    GSList *list;
+
+    list = object_class_get_list_sorted(TYPE_CPU, false);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, cpu_list_entry, NULL);
+    g_slist_free(list);
+}
+#endif
+
 void list_cpus(void)
 {
-    /* XXX: implement xxx_cpu_list for targets that still miss it */
-#if defined(cpu_list)
     cpu_list();
-#endif
 }
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.41.0


