Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921F37923B8
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXUB-0002u7-Ep; Tue, 05 Sep 2023 10:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXU9-0002tl-TU
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:56:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXU7-0005fI-O7
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:56:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so24534005e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693925813; x=1694530613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2K7Dxy2K8CwrBt/sLg+giXPMeT4e/F4Re5CMN6L3iEU=;
 b=i3y7EOkVAHEv47Mk8BKRdye7+BnYbPIiO2rhok5Gv8rweU95kfklBqRHZK6tG60R3O
 0N65du/362TKfHY151WtWy86BPBWFsH3lBQhRDKP3DkPvUvSorzIKF++CfJ44LRPef1G
 ktpTTYn1glTybcKl0m9TynoRipo+m+Sj3jl0P7/aSI2Dz4q/yLd8ccOxpITdJF9JKRQ6
 87yXNCtpt5IaA5hIjdFa0hnqPQFeRtcZA8amnguxkHrMNCT8tMWXh3PXYa/Uh0DsSghc
 JIWLzCAFM48e9mDQRBLq3kBAGUbRLREX0qvblLKsUcpWcx4bQYOAk/pZX7kas8+qZdwX
 3poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693925813; x=1694530613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2K7Dxy2K8CwrBt/sLg+giXPMeT4e/F4Re5CMN6L3iEU=;
 b=MsV89+ir6H6K0wG9x43A9UiXd1fVCXKQqa7Z0PNwtF0ZFDGhpLZi43nxtUJbSjTe8Y
 wIGppPE1IONgVpdKWiOb900mj5fWwKQ+ffQN8OsrR3vw9bTkCchuCOjguqsPpZhLM1z2
 THqsEGxPuGuaFUaFqZYb3gjXGwOoVzZaXMsoZwZKLwI72r/8emjE4J/TMkwnzNwhryql
 jAhGHGytMcM/8/RbGQKwmcHA/I+c1MoTX+cWmu6NvF3+jR34pU4szK+pnmFsyRO55tnA
 8ld52OLCA2K1y0emEm58cRo5I8wDsh5F5WBPObLSaO9DpFrSVDiRosR8EFieNW2rj8ou
 CFHQ==
X-Gm-Message-State: AOJu0Yym0OyJ1WBYDXSxu2xRuU5Kyt1w+olAiCk7POdvFLHJ8Y0swDlL
 IZ1Dv5FwTyHtwR+y8R9AVjBq+BeZWyjBiZmngvw=
X-Google-Smtp-Source: AGHT+IFq64pFLQK02CcI45JjdTV4Ch+q151eewLLGVHjpQqmJ0CTq6FMreXryYg+oG0OLZjjLZCzLg==
X-Received: by 2002:a1c:7905:0:b0:3fe:1b4e:c484 with SMTP id
 l5-20020a1c7905000000b003fe1b4ec484mr2935wme.5.1693925813433; 
 Tue, 05 Sep 2023 07:56:53 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 f22-20020a7bc8d6000000b00401c9228bf7sm17072083wml.18.2023.09.05.07.56.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 07:56:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/intc/arm_gicv3: Simplify gicv3_class_name() logic
Date: Tue,  5 Sep 2023 16:56:51 +0200
Message-ID: <20230905145651.8199-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Simplify gicv3_class_name() logic. No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/arm_gicv3_common.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 2ebf880ead..8863f06b67 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -612,13 +612,12 @@ type_init(register_types)
 
 const char *gicv3_class_name(void)
 {
-    if (kvm_irqchip_in_kernel()) {
-        return "kvm-arm-gicv3";
-    } else {
-        if (kvm_enabled()) {
+    if (kvm_enabled()) {
+        if (!kvm_irqchip_in_kernel()) {
             error_report("Userspace GICv3 is not supported with KVM");
             exit(1);
         }
-        return "arm-gicv3";
+        return "kvm-arm-gicv3";
     }
+    return "arm-gicv3";
 }
-- 
2.41.0


