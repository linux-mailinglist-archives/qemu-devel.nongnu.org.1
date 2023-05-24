Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D5370F984
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:00:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxr-0006Mi-Ge; Wed, 24 May 2023 10:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxc-0006Ha-Bk
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxT-0006J3-G8
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6077660c6so9294215e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940360; x=1687532360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wrroi3k5iuAqhp3rZjOPVM512Ek393zKHUtZlhcG5AM=;
 b=FhIgSqyFLQVvdUM7l3cSO7l/VrYg8L70lkSforxW0whol7C2jzTrLB1QG30HayLf7o
 b/r8qXQpw8JRFDs1xYW+cTVGC41J9c91x90QYx5d1g/lp3nAVEQktdn7VHdeJFKluV6W
 hd15oxJpGV6Pb1NE/06IKrIOLrv0HybDMpE3C4M8qjBXAXZHIx/dMztjZ6l+ihoOZNHr
 P8OYPVig5Zntp6Hy5XQD1e48mR5sxc4ZAvownZw/JJXXXdPMs2bSr6fORqOMt+qp+NzP
 iBjYEOh6RIqwM9+qfuG3g3qbp+5Yg13kvQ+HEgpumKHJf1msZsWBXz9VKTzRWRqxqobu
 +nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940360; x=1687532360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wrroi3k5iuAqhp3rZjOPVM512Ek393zKHUtZlhcG5AM=;
 b=MibJ5dKx7BB+pUW72EoFTxOGLmRH3rrWU15A/M0pKWSpB4IDsCcv28ne+1AOHQ/yqe
 A34aM4SmTvnhxPQJXaY/yYrcuJAHhKJBOJOCRYPwYtumUe1DN6H7VkWSe31Zyg4xBOvO
 mpuR+KU+eWRn43tEmnxwP2z9uCIN0NCp3GN9p1aWU41Psk0KvlVCMU2+GYPxcVvgZDBK
 bG0LhCzpCORhVg9IJkb8e+ZqTNAkOhdt9tSgSyMFXMwb1WDr11JdKqeNpAeotcAuVCX+
 CyG4yNvU9yazJ3iuhpbBA691wz6vs4YToM/+C8ULPOkVXlH90cTBCcGWRfe1XkMbBvYB
 JfPg==
X-Gm-Message-State: AC+VfDxT9avJ/Tc6d0A0u0vMjaEnIRYFIXX87z/+nDH0Sun8Zb8cjnRA
 kGgH7jywRmDhQrVhoAn0HFRGSh3SslhaEjldnhCUFA==
X-Google-Smtp-Source: ACHHUZ5ozWGN/Z+mnhyMFSuRzHzutyJvtC6nONnFqMiXCu4Cdd/MzJID9f/kmSEcB5wbB7iZDzMtEA==
X-Received: by 2002:a05:600c:2244:b0:3f5:176:c398 with SMTP id
 a4-20020a05600c224400b003f50176c398mr5021wmm.31.1684940360379; 
 Wed, 24 May 2023 07:59:20 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b003f61177faffsm4636402wmq.0.2023.05.24.07.59.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/10] hw/arm/realview: Declare QOM types using DEFINE_TYPES()
 macro
Date: Wed, 24 May 2023 16:58:58 +0200
Message-Id: <20230524145906.33156-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524145906.33156-1-philmd@linaro.org>
References: <20230524145906.33156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. Replace
the type_init() / type_register_static() combination.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 50 ++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index a52ff35084..07a80d0de3 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -412,12 +412,6 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
 }
 
-static const TypeInfo realview_eb_type = {
-    .name = MACHINE_TYPE_NAME("realview-eb"),
-    .parent = TYPE_MACHINE,
-    .class_init = realview_eb_class_init,
-};
-
 static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -430,12 +424,6 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
 }
 
-static const TypeInfo realview_eb_mpcore_type = {
-    .name = MACHINE_TYPE_NAME("realview-eb-mpcore"),
-    .parent = TYPE_MACHINE,
-    .class_init = realview_eb_mpcore_class_init,
-};
-
 static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -446,12 +434,6 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
 }
 
-static const TypeInfo realview_pb_a8_type = {
-    .name = MACHINE_TYPE_NAME("realview-pb-a8"),
-    .parent = TYPE_MACHINE,
-    .class_init = realview_pb_a8_class_init,
-};
-
 static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -463,18 +445,24 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
 }
 
-static const TypeInfo realview_pbx_a9_type = {
-    .name = MACHINE_TYPE_NAME("realview-pbx-a9"),
-    .parent = TYPE_MACHINE,
-    .class_init = realview_pbx_a9_class_init,
+static const TypeInfo realview_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("realview-eb"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = realview_eb_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("realview-eb-mpcore"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = realview_eb_mpcore_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("realview-pb-a8"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = realview_pb_a8_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("realview-pbx-a9"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = realview_pbx_a9_class_init,
+    }
 };
 
-static void realview_machine_init(void)
-{
-    type_register_static(&realview_eb_type);
-    type_register_static(&realview_eb_mpcore_type);
-    type_register_static(&realview_pb_a8_type);
-    type_register_static(&realview_pbx_a9_type);
-}
-
-type_init(realview_machine_init)
+DEFINE_TYPES(realview_machine_types)
-- 
2.38.1


