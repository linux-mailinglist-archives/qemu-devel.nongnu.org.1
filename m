Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D13F97F4F94
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:32:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s0k-0004G7-Lr; Wed, 22 Nov 2023 13:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0X-0004CY-A4
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:32 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0T-0004c5-Cq
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:27 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50aabfa1b75so5530504e87.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677883; x=1701282683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wy7RMjyw0Q7UvKTe0+LJtz1uxwDhQNO7f4wPUgjAVa0=;
 b=X/N2pG9lvUgkzAyVafcIfDSH3kl94n168w6rSTYGGgxal59bvr3EFeOYHTPjjIikQl
 X8ClOBhFLsaSzayYkEyAitAbt8EVtaLnUHdHSDBlcOSjjW3OFsNdUnVKUenoo0fcqJie
 /pPOQAkRXkEKWPZjy8E7o0gJ5h0F24GltRWrMiAn1dwbzlhiBWXxIQMBwuNNbAFsI2ZJ
 ZLAp/bRd93QBOKPFZCa+U6P7sFoRq6VmIC0CZ5RULXUS0GrF+qx9O5y+VAZgBeHYsP3l
 2kF408HSeoGrIRdn0X9nBsQ+49dzXO69KFSJBdXbob4d2TtqcvYUygBqRmcCc3UpEWAF
 thkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677883; x=1701282683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wy7RMjyw0Q7UvKTe0+LJtz1uxwDhQNO7f4wPUgjAVa0=;
 b=k8fQAw8dIDdUWsYtqmefhq8xekmW3TIoRIfkN5SAa6qhzoYgDuyoADwxds41B7nu2t
 gd9xiEmGPhuBGY78sRqXJHyBLsVWvGkeHbqwzj4rZmzccZn7deUwwE+3F/gqY56IQy/w
 FZfZhe3R6q6+TKaQjo+cPMC6TDlB4WbpyXsTzol8ovWoBnZG5wn4xjIuMGogiXkRousR
 L9OTnGZsfkLCkchPjSQgIZzIkC3ez9pCX4505qt4uQk7dY5Bkwpy20VpmuHu6ReTUYrs
 o6g87xMUTMWCUKub/z/rEh6hHKBsMdgcaznAmApObLY2H0olt/FMd6pxtQGrfKzi++s3
 02Hw==
X-Gm-Message-State: AOJu0YxXn3tIimw82hXXIt92UWxjCpcAbteCoahdbJTxpAlzh14KYP0b
 pWVstOl7JEaN64LxKzvLMnTFd+/TEBU0rqoCs9w=
X-Google-Smtp-Source: AGHT+IEmMQjXUiyiLKGtUufCPQsRblLgydZGbL1JsNZSAIzcHo454I3CyBFJaRr1B79zPj8koxrWfA==
X-Received: by 2002:a05:6512:158e:b0:507:a766:ad27 with SMTP id
 bp14-20020a056512158e00b00507a766ad27mr3346315lfb.16.1700677883188; 
 Wed, 22 Nov 2023 10:31:23 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 n17-20020a5d6b91000000b003140f47224csm67155wrx.15.2023.11.22.10.31.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-9.0 06/11] hw/arm/bcm2836: Simplify use of 'reset-cbar'
 property
Date: Wed, 22 Nov 2023 19:30:42 +0100
Message-ID: <20231122183048.17150-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

bcm2836_realize() is called by

 - bcm2836_class_init() which sets:

    bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a7")

 - bcm2837_class_init() which sets:

    bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a53")

Both Cortex-A7 / A53 have the ARM_FEATURE_CBAR set. If it isn't,
then this is a programming error: use &error_abort.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 6986b71cb4..055c909e95 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -132,10 +132,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
-        if (!object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
-                                     bc->peri_base, errp)) {
-            return;
-        }
+        object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
+                                bc->peri_base, &error_abort);
 
         /* start powered off if not enabled */
         if (!object_property_set_bool(OBJECT(&s->cpu[n].core),
-- 
2.41.0


