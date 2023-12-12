Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418280F2B0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:31:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5es-0001dG-0u; Tue, 12 Dec 2023 11:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eg-0001Jm-4x
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:47 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5ed-0007P3-65
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:45 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1f653e3c3dso609298566b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398640; x=1703003440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjt6Wlk39I28ykvvxAfjim08zez2NFi+ssDQvlNXSBg=;
 b=HZhUe0aA5zKXofYritihmc156kAvslduCKYM090IfTH1s/RNXRnS1qqfzqJEC/enXY
 2fxVypcFCSRT9nf5uUU2OKjU0B/WaC5iKAgh3UWEpfYwiBBUEE8U/4kRHjCVUd8vtkrD
 n0kwTPYMLP9fbCw33pll19CXHlMnFbywUKrwP7K4u6YRlHEE0Yk3EAk38bxPNPNE93YA
 4wfZNEH0ccGQ+zIYEAIQ7M2n0+V+XvcdNhy47PZlzPyL8VqMWV26JLDEEmSV/VaWv3Lt
 lWwVusj6XVzofxx3DVpfBrT1bEeS2/iPYCU45+9aXMtHzRVggqzrAVB2ZAJTmU0Xzfvg
 j8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398640; x=1703003440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjt6Wlk39I28ykvvxAfjim08zez2NFi+ssDQvlNXSBg=;
 b=lgKo+ahT8cJfu1qFEAOiaLFTTj13GiS9TZjQ5e4DXisGlUbLxvoO1GgzK1NxyF4eWq
 dmqSE0q0kYO6xgNzvvz1Fj+/AOazFU4fypPuCTl64Tp1HoXwB2rXvWEqQT2e6eyJLrD6
 R7O01LVFxNDEmpyHqny3vlcxluI0SHWyHWzT/dPehnb2B8Cf4ZVXhjoML27uu+pP8PeU
 E+3bhVoMkGFuZHZx1zCWYW+49qdpXM6NLAcGogiGmiSB9UrnnQJCivWJMYU8EOc1kaLp
 vRGFvn9TtuYx9Jmbn87DLQFLW+sF0f0/i7xGCsrLmVKLBdfss5nEC2rrYlAY8kOpXsFD
 zjBQ==
X-Gm-Message-State: AOJu0YxRXai8RyHYNJuy0WrBVwqL4dKvGdrSTG8Jho+3t1X8GrZ8JKbl
 ca5fxlZchX1gReJogZwfx4bVJA1T4ijlpGI5hNA=
X-Google-Smtp-Source: AGHT+IGLtDHDdLPeVypC8ZM20Oj1MeVcIRgGuxjTqKU9B75xo+mLSKSdDmZpXYa7wtb6TnEHFRnfEw==
X-Received: by 2002:a17:906:225b:b0:a00:152a:1efa with SMTP id
 27-20020a170906225b00b00a00152a1efamr1843142ejr.3.1702398639820; 
 Tue, 12 Dec 2023 08:30:39 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 rr17-20020a170907899100b00a1d457954d6sm6462970ejc.75.2023.12.12.08.30.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:30:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/33] hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES()
 macro
Date: Tue, 12 Dec 2023 17:29:08 +0100
Message-ID: <20231212162935.42910-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/a15mpcore.c       | 21 +++++++++------------
 hw/cpu/a9mpcore.c        | 21 +++++++++------------
 hw/cpu/arm11mpcore.c     | 21 +++++++++------------
 hw/cpu/realview_mpcore.c | 21 +++++++++------------
 4 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index a40f142128..c2ee985fb4 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -164,17 +164,14 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
     /* We currently have no saveable state */
 }
 
-static const TypeInfo a15mp_priv_info = {
-    .name  = TYPE_A15MPCORE_PRIV,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size  = sizeof(A15MPPrivState),
-    .instance_init = a15mp_priv_initfn,
-    .class_init = a15mp_priv_class_init,
+static const TypeInfo a15mp_types[] = {
+    {
+        .name           = TYPE_A15MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(A15MPPrivState),
+        .instance_init  = a15mp_priv_initfn,
+        .class_init     = a15mp_priv_class_init,
+    },
 };
 
-static void a15mp_register_types(void)
-{
-    type_register_static(&a15mp_priv_info);
-}
-
-type_init(a15mp_register_types)
+DEFINE_TYPES(a15mp_types)
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index d03f57e579..6b5ce01246 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -178,17 +178,14 @@ static void a9mp_priv_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, a9mp_priv_properties);
 }
 
-static const TypeInfo a9mp_priv_info = {
-    .name          = TYPE_A9MPCORE_PRIV,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(A9MPPrivState),
-    .instance_init = a9mp_priv_initfn,
-    .class_init    = a9mp_priv_class_init,
+static const TypeInfo a9mp_types[] = {
+    {
+        .name           = TYPE_A9MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  =  sizeof(A9MPPrivState),
+        .instance_init  = a9mp_priv_initfn,
+        .class_init     = a9mp_priv_class_init,
+    },
 };
 
-static void a9mp_register_types(void)
-{
-    type_register_static(&a9mp_priv_info);
-}
-
-type_init(a9mp_register_types)
+DEFINE_TYPES(a9mp_types)
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 89c4e35143..74f44434de 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -153,17 +153,14 @@ static void mpcore_priv_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, mpcore_priv_properties);
 }
 
-static const TypeInfo mpcore_priv_info = {
-    .name          = TYPE_ARM11MPCORE_PRIV,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(ARM11MPCorePriveState),
-    .instance_init = mpcore_priv_initfn,
-    .class_init    = mpcore_priv_class_init,
+static const TypeInfo arm11mp_types[] = {
+    {
+        .name           = TYPE_ARM11MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(ARM11MPCorePriveState),
+        .instance_init  = mpcore_priv_initfn,
+        .class_init     = mpcore_priv_class_init,
+    },
 };
 
-static void arm11mpcore_register_types(void)
-{
-    type_register_static(&mpcore_priv_info);
-}
-
-type_init(arm11mpcore_register_types)
+DEFINE_TYPES(arm11mp_types)
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 7480b38d1a..b140888618 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -114,17 +114,14 @@ static void mpcore_rirq_class_init(ObjectClass *klass, void *data)
     dc->realize = realview_mpcore_realize;
 }
 
-static const TypeInfo mpcore_rirq_info = {
-    .name          = TYPE_REALVIEW_MPCORE_RIRQ,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(mpcore_rirq_state),
-    .instance_init = mpcore_rirq_init,
-    .class_init    = mpcore_rirq_class_init,
+static const TypeInfo realview_mpcore_types[] = {
+    {
+        .name           = TYPE_REALVIEW_MPCORE_RIRQ,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(mpcore_rirq_state),
+        .instance_init  = mpcore_rirq_init,
+        .class_init     = mpcore_rirq_class_init,
+    },
 };
 
-static void realview_mpcore_register_types(void)
-{
-    type_register_static(&mpcore_rirq_info);
-}
-
-type_init(realview_mpcore_register_types)
+DEFINE_TYPES(realview_mpcore_types)
-- 
2.41.0


