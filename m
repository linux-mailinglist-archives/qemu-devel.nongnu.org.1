Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA7578F5EA
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqar-00040B-GX; Thu, 31 Aug 2023 18:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaj-0003ya-Gr
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:45 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqah-0002su-73
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:45 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9a5e1812378so157777566b.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522600; x=1694127400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQQ92YswPrJjLh8GJHh2K0OTvyaJRT2v7+qtQtVGLSE=;
 b=volQLzVT7NPtC6xojkdLJGx+wzd1RhzBa0sD7ExXP9huapP61zVcVYxu3kXCpqntiK
 U4M1jrWh5lphCRLly1h7XciVYBC0yznfylycrBMR8fLDKxcXPpxzfJsh8VZMApYETKVe
 cqIU8QPf4y63PLecbN+KPLMsTmCqOLCXDuOSt4FL2uP1sqMxgSF0o2x1pdSqcMNptGcn
 xu/DdFzhlCGU/P+/vEJqSUh9DGF43162II2zf/tylgvmclfjAjhCtlg7mhFuUHxzsdHO
 kEiQx38K4XS7kJes0g4839HGF+AnmETOHw+bigPlJO02EcIeE8VBbIrKYNmqfO/WvL8b
 I+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522600; x=1694127400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQQ92YswPrJjLh8GJHh2K0OTvyaJRT2v7+qtQtVGLSE=;
 b=HFUoofylk1GtyV5B4ra43Fb/iPX6g7b1NbEvNk/BQDLwVShcsKeDgpUt6aYrZFVuwt
 2cSrvOghY1dAKEO/BiLErjhWDfMQyOGi4+MfSjCouuCA0zVMoLXC6mEetV4wDUVoqNUM
 2K4/v3osb9NJgZm8bHMaXKbYyPk73ckpIBsrHy7fYVHYHMt9fhiPR4sNtnA8vAsrjzJW
 kY9Aa89vPySOq5Q/1gXrZZ90PRVMbsbo65HaHznGr/TwrK0QaFAJPPuU0i70IDyauFVM
 KHF/Y9hygq32O3qgIkAoF1ONNIT86auFrCdpM/0bwDBDDBcxnoCtjh9AOT2T07hiM5bE
 Sjhw==
X-Gm-Message-State: AOJu0Yyn99ydUOMnIsZXxTXnKMpQPrOUhdnvC3zbEQaXPK79WWsJckVD
 ZfnKdohONFFCFGxFGJswvfjHoYXkmbIszoMeDe4=
X-Google-Smtp-Source: AGHT+IEcPsq8pi3XCMZ6TscGTGrQTSFuXB+y/I1/w9mdm8JuHpC1QaaQOZO65N7QD1bI9AqihuV0ZA==
X-Received: by 2002:a17:907:2ce7:b0:9a1:bb8f:17d7 with SMTP id
 hz7-20020a1709072ce700b009a1bb8f17d7mr463648ejc.12.1693522600451; 
 Thu, 31 Aug 2023 15:56:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a1709064d8d00b0099bca8b9a31sm1240738eju.100.2023.08.31.15.56.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:56:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 05/11] hw/arm/virt: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:56:00 +0200
Message-ID: <20230831225607.30829-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Fix:

  hw/arm/virt.c:821:22: error: declaration shadows a local variable [-Werror,-Wshadow]
            qemu_irq irq = qdev_get_gpio_in(vms->gic,
                     ^
  hw/arm/virt.c:803:13: note: previous declaration is here
        int irq;
            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


