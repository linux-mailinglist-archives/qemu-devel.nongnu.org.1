Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FC180F326
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:36:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5gP-0006xF-IP; Tue, 12 Dec 2023 11:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5g7-0006XC-1b
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:18 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fm-0007gL-1j
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:11 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-551d13f6752so566251a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398712; x=1703003512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XiepaygppBbcW3Zh+1TG9/b3hf0ew+z06xur2FyhJl8=;
 b=Dqw7Q3uJoPAZ4v1OJbh1N9hj+Q2bjph7UyX2cqKuUVgvbQ7l99qeYiJzzpIw3DN9QX
 K5u1u2ZHECbLmucb5uhRSYM/ShNZyM6CrCzXQuPrlimQd+WrfhhUWwhQmV8cPIifASZd
 exPMeNV8/Pek8dDaWrlfTvz/qZ56rXFp5mpege8KzGFfqsiAH83nvBogLBsDnIApiVUK
 O3yT0P00Bgw+XyrJQOtOhHRzyK8H5g+uwaRUivGyXvPHgDQQFhPGuH3N/yN3T7XHNEHE
 4bB8JXOuSW9616RiKKuB+NXhfracBnoxq+quvkJocnyd62vyNji0qy+Rmz1N7mzmWlQb
 GeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398712; x=1703003512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XiepaygppBbcW3Zh+1TG9/b3hf0ew+z06xur2FyhJl8=;
 b=uXNmM+awAqj0s78xUdEXzPqmH9BDpiJi+926DdoAhqrsE4OD8pNPbLu68exi5Mald6
 tEDQdywAtMohukjxJApM4nvpZ0SjX16NHRsoKWhqw3xdVN+MlZFepmpLGqh7Xj13Iwfz
 GCT4PyJ7d4kma7ek+n6ELzTIudUUFNihRuYvUp/N/6Lrh5nIIHO0Lgwiif+xqTjEFVzC
 8vauXRFFfLkEfjDpcXRcOAALOlf46aOLe1hl5e1aqwf4+l79OmQxz9CUxA21SGllL8Ux
 2YYA6Oi9r6T/B2XhXjEPZi7QXXDgCbWdxk9aIZoHLMzbUzywSuVqjs8mIeUufSIEjEzw
 qqDA==
X-Gm-Message-State: AOJu0YwsUNczAjW4nucm+rk2tApoij3GHqgBPq/PD6b9vupWrnLHFkSj
 PMtJDSqbLDG2e0C7Kbt6uBf43CXCMf+Gg/mq0GY=
X-Google-Smtp-Source: AGHT+IEGJB1Kg+vrsX7qnSQDbyV5YTp8wo+VFKkjcLN/23vK5gDSX5GaOg4/fO3vujamRqj2ti7JGg==
X-Received: by 2002:a17:907:7b82:b0:a1a:f475:2ebf with SMTP id
 ne2-20020a1709077b8200b00a1af4752ebfmr4042581ejc.59.1702398712107; 
 Tue, 12 Dec 2023 08:31:52 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 uv6-20020a170907cf4600b00a1e443bc037sm6569803ejc.147.2023.12.12.08.31.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:31:51 -0800 (PST)
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
Subject: [PATCH 18/33] hw/cpu/arm: Replace A15MPPrivState by CortexMPPrivState
Date: Tue, 12 Dec 2023 17:29:18 +0100
Message-ID: <20231212162935.42910-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

A15MPPrivState doesn't contain anything else but its parent,
CortexMPPrivState. Remove it in favor of the parent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/aspeed_soc.h    | 2 +-
 include/hw/arm/fsl-imx6ul.h    | 2 +-
 include/hw/arm/fsl-imx7.h      | 2 +-
 include/hw/cpu/cortex_mpcore.h | 5 -----
 hw/cpu/a15mpcore.c             | 2 +-
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index e0663ab50d..2f51d78e22 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -108,7 +108,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2400SoCState, ASPEED2400_SOC)
 struct Aspeed2600SoCState {
     AspeedSoCState parent;
 
-    A15MPPrivState a7mpcore;
+    CortexMPPrivState a7mpcore;
     ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */
 };
 
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 5ed22004d1..b37d544319 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -68,7 +68,7 @@ struct FslIMX6ULState {
 
     /*< public >*/
     ARMCPU             cpu;
-    A15MPPrivState     a7mpcore;
+    CortexMPPrivState  a7mpcore;
     IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
     IMXEPITState       epit[FSL_IMX6UL_NUM_EPITS];
     IMXGPIOState       gpio[FSL_IMX6UL_NUM_GPIOS];
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 87faee33c2..a6f3a96029 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -68,7 +68,7 @@ struct FslIMX7State {
 
     /*< public >*/
     ARMCPU             cpu[FSL_IMX7_NUM_CPUS];
-    A15MPPrivState     a7mpcore;
+    CortexMPPrivState  a7mpcore;
     IMXGPTState        gpt[FSL_IMX7_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX7_NUM_GPIOS];
     IMX7CCMState       ccm;
diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index 73627bc415..7822d5cbc4 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -117,10 +117,5 @@ struct A9MPPrivState {
 };
 
 #define TYPE_A15MPCORE_PRIV "a15mpcore_priv"
-OBJECT_DECLARE_SIMPLE_TYPE(A15MPPrivState, A15MPCORE_PRIV)
-
-struct A15MPPrivState {
-    CortexMPPrivState parent_obj;
-};
 
 #endif
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index ecd04b7af1..87b0786781 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -125,7 +125,7 @@ static const TypeInfo a15mp_types[] = {
     {
         .name           = TYPE_A15MPCORE_PRIV,
         .parent         = TYPE_CORTEX_MPCORE_PRIV,
-        .instance_size  = sizeof(A15MPPrivState),
+        .instance_size  = sizeof(CortexMPPrivState),
         .class_init     = a15mp_priv_class_init,
     },
 };
-- 
2.41.0


