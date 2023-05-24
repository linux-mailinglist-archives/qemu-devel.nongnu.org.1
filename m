Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A046A70F989
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxt-0006X8-Vk; Wed, 24 May 2023 10:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxe-0006JD-Dc
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxc-0006PT-C4
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f607766059so11691865e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940371; x=1687532371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PydogO+S2zKNTlFPp3mMYMrTOfo1Vgivo42WoSUjgRg=;
 b=E7sOogTiv9Y4kFslJcA9lUcIb+HVt34jqG1gfk/jOyTxLEV/idizywt0a+uNW6kho5
 M7gCzXbtMw+WtVSvzp/HGH0ArrUmQ6RUpyjI1iv/lR3bMy0fW6h0C1HBTnURRqDHZUjh
 A4oIY4DdCkPDW42HLhvBToC1miDHYOa+9SVBlHOyoDq+CxBRKFc3YQ4us2naLZ4uJz2k
 FUvKwIHbpdUazrBribvg8ac6J+IWQICtb8bxKx05QurgjcMTo7nht98a5RQL+r8+iJcH
 /Wgnz1L7fYkQVLvqcJblMXfylARGUbN8nhLjL5sYd351K2usywllzODlPHBxMPsvTF6j
 e0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940371; x=1687532371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PydogO+S2zKNTlFPp3mMYMrTOfo1Vgivo42WoSUjgRg=;
 b=At69EO71kl/g8bk6+TZKa4u4l22UY3N1MNWy16AkqnZ2Q0049Z8jQVqKqCg+ye95ti
 LW2dlogeiS9N+uX5HwLnS/dSkwWyJ+f7y3ezHpHUbthu3JOWa0OTWgykT7Gcv4GyhVN2
 j9CpO8c8vo0xLIgU7+QljgNqyotwiAklV84puZxylKicnfVhXUd8jdxkCrzBOyDsk9Mb
 P3eh3AsWWfIkcNI22qkzhSxdF3eGoxcu8tBMqpBE6lO1P7q/KQrphUoFhwllG77NHxOd
 7bucTQiv4prV7by6QR50M0auM/LuhP6eVx1tutGNaLGuUvMt7TYppj925xkwvZwW/CbS
 kb5Q==
X-Gm-Message-State: AC+VfDxTwFCpczxNo5bxngkBBPHKHkYPolJvWhYB3O+WQ9Mg4fp4Ww20
 OyWAS+RdsO4An6VsQCttWa85SdvwxhLFMwcYxJi4lQ==
X-Google-Smtp-Source: ACHHUZ4eIOm1/DAMxuY08iVIOZMCFqrph49QZtfRXLfjhwaZNqKMsQYRorBKFD3zjRmvyNgu78J7Uw==
X-Received: by 2002:a7b:c411:0:b0:3f4:f7c2:d681 with SMTP id
 k17-20020a7bc411000000b003f4f7c2d681mr33149wmi.29.1684940370857; 
 Wed, 24 May 2023 07:59:30 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a1c7c0f000000b003f4268f51f5sm2670695wmc.0.2023.05.24.07.59.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/10] hw/arm/realview: Factor realview_common_class_init() out
Date: Wed, 24 May 2023 16:59:00 +0200
Message-Id: <20230524145906.33156-5-philmd@linaro.org>
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

Introduce realview_common_class_init() where we'll set
fields common to all Realview classes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index f0a8a93b08..6970e8a469 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -410,6 +410,13 @@ static void realview_pbx_a9_init(MachineState *machine)
     realview_init(machine, BOARD_PBX_A9);
 }
 
+static void realview_common_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->ignore_memory_transaction_failures = true;
+}
+
 static void realview_eb_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -417,7 +424,6 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM RealView Emulation Baseboard (ARM926EJ-S)";
     mc->init = realview_eb_init;
     mc->block_default_type = IF_SCSI;
-    mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
 }
 
@@ -429,7 +435,6 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     mc->init = realview_eb_mpcore_init;
     mc->block_default_type = IF_SCSI;
     mc->max_cpus = 4;
-    mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
 }
 
@@ -439,7 +444,6 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "ARM RealView Platform Baseboard for Cortex-A8";
     mc->init = realview_pb_a8_init;
-    mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
 }
 
@@ -450,7 +454,6 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM RealView Platform Baseboard Explore for Cortex-A9";
     mc->init = realview_pbx_a9_init;
     mc->max_cpus = 4;
-    mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
 }
 
@@ -475,6 +478,7 @@ static const TypeInfo realview_machine_types[] = {
         .name           = TYPE_REALVIEW_MACHINE,
         .parent         = TYPE_MACHINE,
         .class_size     = sizeof(RealviewMachineClass),
+        .class_init     = realview_common_class_init,
         .abstract       = true,
     }
 };
-- 
2.38.1


