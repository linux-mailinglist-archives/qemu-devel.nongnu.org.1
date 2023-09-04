Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18610791B2D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:14:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCCk-0002o0-Tr; Mon, 04 Sep 2023 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCd-0002hv-Ek
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:27 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCb-0007XZ-9x
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:27 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c4923195dso250222266b.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844003; x=1694448803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNPPdU1CGcusx0u924J/XsX1Bvc+NbZUFtzocy+B04M=;
 b=iI/gjPg5YC9lf+lJZE/YZFoOKeIgHxt0kqREw0hBNgvKNLxXV6Oq0Ngg9J/eU+uuKl
 OMjo8ECrTPGdPoTGMo7Cmdnt3KjSfsB2YaLe8He6gwmyYo2I2BtesPkCC+q43kqoN/XF
 sqytf1iwj2RwobE20Jw1r/O2pG99VudebmcqsZUxalLbJcS+N5vHkPcirp52eShCRByi
 VpXm3C4NOYS4GQDoc3PR86/LGsrhQJbkPHB1pTkIXjn3DNklgfSL6IO3iZqLRXYTTy3N
 D8Zn9Nv3xK8+nHKf1ZXNPt5qyQmF98WW/A+6WrMpNJQPYFotyEhA1JRFTmJdfeu2Tea3
 /mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844003; x=1694448803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNPPdU1CGcusx0u924J/XsX1Bvc+NbZUFtzocy+B04M=;
 b=IGJdQw8/oI6TRFmVzxa6r2KFZBqA6CZarM3/SIRNH9F57+3iuXBQBDeq7UvECOYx6s
 0hiRxeSTXrfPqRkLmuzINi2hNPso4jV1sLmTKQX1iqp9HNm/V+QyPevLtdeUwmzFl/iK
 iR0enFbU9KpbPvctO9Fe/pZbsX3RzGivv9gZQZWcGelSurc4FtvHvc+WZpEdiC5vY8zE
 hiwaqzvJ52d5FECco+oI90UhnU7wDSy/a2npilrqSPRdrq7mQ61TgCAz6D47T5/acgA/
 zPA/EfaPF6pDL4ibSJpZQuH9t8EL3XZurCEDuzPpKTDlPEEcRaylITIeWmx6v2qr7jeP
 06Ww==
X-Gm-Message-State: AOJu0YxDoENlrYA+fAOWYVnS5Tm9EkQ6n10+OlNo53N9BjZ6ft1zB/NU
 lC9Fe/d4VD0dOHJhtW58Ha9m8f328ICsqNw8sU0=
X-Google-Smtp-Source: AGHT+IHzFpN4kack+GOrPGq1qv+QK15GpnX1odeAaOzSct5HdzpfopUoOjLS6wP7J3Zl0ILiJ3Szqw==
X-Received: by 2002:a17:907:2ccb:b0:9a1:e293:987e with SMTP id
 hg11-20020a1709072ccb00b009a1e293987emr8525152ejc.50.1693844003111; 
 Mon, 04 Sep 2023 09:13:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a170906951700b0099d0a8ccb5fsm6383573ejx.152.2023.09.04.09.13.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 08/22] hw/arm/virt: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:20 +0200
Message-ID: <20230904161235.84651-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
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

Fix:

  hw/arm/virt.c:821:22: error: declaration shadows a local variable [-Werror,-Wshadow]
            qemu_irq irq = qdev_get_gpio_in(vms->gic,
                     ^
  hw/arm/virt.c:803:13: note: previous declaration is here
        int irq;
            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a13c658bbf..32a964b572 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -800,7 +800,6 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     for (i = 0; i < smp_cpus; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
         int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
-        int irq;
         /* Mapping from the output timer irq lines from the CPU to the
          * GIC PPI inputs we use for the virt board.
          */
@@ -811,7 +810,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
         };
 
-        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+        for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
                                   qdev_get_gpio_in(vms->gic,
                                                    ppibase + timer_irq[irq]));
-- 
2.41.0


