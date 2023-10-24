Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 340AE7D5838
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKDI-000166-2W; Tue, 24 Oct 2023 12:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKDD-00011g-Lw
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:25:00 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKDB-0000zP-D4
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:59 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507c78d258fso6721532e87.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164695; x=1698769495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gSUEVnjZ5l3XM9Uz+TU/GJi2M4pExdkC8HE+Bw6uwA=;
 b=BSehJHHYXjzIKnTrwYxxvjHAsmtU06w5GrCUw4B0edLizOCISK5d0dxs1v+uVL9FYZ
 +/0CXluzyw40vNcsCsVk5kUxY67BoAlV4dPWR0LfDLPy0/F9W96XHJeNtS+mjE3tKBHB
 GU4aiKWHJLW/HtkbPxWXno3/GhxpeyWHYAUJAi7IzX2TJ7T1IMpQAmpYtTAN6unsyRVV
 R3YgLmdecop1UE2EAyOSfSbjl1Qv739WF3HGvmxQiXvjrMqHi4Xrh1ybZ+GE9fBII5wL
 lzTFpo7xMu728IZgjHRutcQr+zJZDMm+WwTJIP6bp9jM0ezSyQurPOjqOee4BG6jMzXa
 LqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164695; x=1698769495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gSUEVnjZ5l3XM9Uz+TU/GJi2M4pExdkC8HE+Bw6uwA=;
 b=QZ1EhJHsxe1rpgm3yvZAOVK41qQUrrSjcjXmv+nraAFOE+UxIC8wclJlEui/r+zMZY
 eYhRVJEqh2jZyl+f5RkEBaqWDoMXStHeLskD/UEG1wXBj6fQs5SKKIa70E5yIzZsu4bb
 p8XPfJ08K98HH0HJPEmu1yXedNOrXF5K5+Fkp84qAKbKvJN3eZmDK8lBBarY7OBt4fuD
 TEPytWWhSlecJpaoMJXl/72jlHvic6ErRhyxKtXyWnsFyeO8iZhr8+UU+C2sjyqqDI72
 j85/x44bgyj3J8ePpuwV4/ks0R9JIxLPNKPjCNrykuAxPzWrOVDhpBETWrHOAcNaDpQU
 P7Lw==
X-Gm-Message-State: AOJu0YxcSczO9rG71FjUJ9cIrvHi9du5qf1e7d0PQ2Hvcf1iA0dwH+FW
 Jw+j1RjE0MZiRlSuByE7TvCjeOXtsV0MfccZl14=
X-Google-Smtp-Source: AGHT+IHrM5J8QlJnYxwiHEVghUD6e6L2jwP7xvjHpWJNTf2IGRjtPvu6KukWlQjSLfBICws7euhSMA==
X-Received: by 2002:a05:6512:baa:b0:500:acf1:b432 with SMTP id
 b42-20020a0565120baa00b00500acf1b432mr10873478lfv.63.1698164695601; 
 Tue, 24 Oct 2023 09:24:55 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 b24-20020a05600c06d800b004064e3b94afsm17039304wmn.4.2023.10.24.09.24.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:24:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/11] hw/arm/aspeed: Introduce TYPE_ASPEED10X0_SOC
Date: Tue, 24 Oct 2023 18:24:16 +0200
Message-ID: <20231024162423.40206-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TYPE_ASPEED10X0_SOC inherits from TYPE_ASPEED_SOC.
In few commits we'll add more fields, but to keep
review process simple, don't add any yet.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  7 +++++++
 hw/arm/aspeed_ast10x0.c     | 26 +++++++++++++-------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 8adff70072..dcb43a4ecd 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -101,6 +101,13 @@ struct AspeedSoCState {
 #define TYPE_ASPEED_SOC "aspeed-soc"
 OBJECT_DECLARE_TYPE(AspeedSoCState, AspeedSoCClass, ASPEED_SOC)
 
+struct Aspeed10x0SoCState {
+    AspeedSoCState parent;
+};
+
+#define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)
+
 struct AspeedSoCClass {
     DeviceClass parent_class;
 
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 649b3b13c1..1c15bf422f 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -435,18 +435,18 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
     sc->get_irq = aspeed_soc_ast1030_get_irq;
 }
 
-static const TypeInfo aspeed_soc_ast1030_type_info = {
-    .name          = "ast1030-a1",
-    .parent        = TYPE_ASPEED_SOC,
-    .instance_size = sizeof(AspeedSoCState),
-    .instance_init = aspeed_soc_ast1030_init,
-    .class_init    = aspeed_soc_ast1030_class_init,
-    .class_size    = sizeof(AspeedSoCClass),
+static const TypeInfo aspeed_soc_ast10x0_types[] = {
+    {
+        .name           = TYPE_ASPEED10X0_SOC,
+        .parent         = TYPE_ASPEED_SOC,
+        .instance_size  = sizeof(Aspeed10x0SoCState),
+        .abstract       = true,
+    }, {
+        .name           = "ast1030-a1",
+        .parent         = TYPE_ASPEED10X0_SOC,
+        .instance_init  = aspeed_soc_ast1030_init,
+        .class_init     = aspeed_soc_ast1030_class_init,
+    },
 };
 
-static void aspeed_soc_register_types(void)
-{
-    type_register_static(&aspeed_soc_ast1030_type_info);
-}
-
-type_init(aspeed_soc_register_types)
+DEFINE_TYPES(aspeed_soc_ast10x0_types)
-- 
2.41.0


