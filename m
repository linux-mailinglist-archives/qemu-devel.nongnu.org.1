Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4A713ABF
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Jab-0000YV-Rq; Sun, 28 May 2023 12:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaZ-0000Xe-CV; Sun, 28 May 2023 12:49:51 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaX-0003bC-US; Sun, 28 May 2023 12:49:51 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3980c92d8d6so1713617b6e.0; 
 Sun, 28 May 2023 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292587; x=1687884587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpYaRHDdhPCMmSwGgxX0nvTTRsD1eoJ1qxebdVyMKY4=;
 b=jwCTy1CzJ9y6+2CWzClKDkDwjKg9HC9puv0OsC0dc9CQHlscDB7wCZHoPAArZ61Yww
 sFadU65Nopy0d9FlvsRx+77xPT8MjHMSr/pNdRVbxoBjlWUCxgWU63FVMPg0ms5Y4fsA
 XzpNBMud5XMPJeqjiGCXwtwOVdFYpfW/mt5W7v2N5YtcsAS3rTTYTZk6keEQFRxeNrdF
 CzrouPyrBHMWVC9mzKzMdqEAnXUr+gPhqa7EASQdrhguTBGrlHjbwReE8Y2rOzhhvXbb
 63HWoeX8mor4QFqhK/uMENXPoj7tfjQqBy2CZWEXbgba5DL+k18A4plCzqF9rsNSWXtp
 ciFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292587; x=1687884587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bpYaRHDdhPCMmSwGgxX0nvTTRsD1eoJ1qxebdVyMKY4=;
 b=BIo5qZqX5CjAKodxGixzcriA1616FQT9s233PcRrUN31Dc65HBRpxuu5AaMQCl+BFS
 RupwYtAp7SPGPRRSKx2iR7gwDllpVq8t6BZFWeUg9xEZDI5WAKZsoABofMpVZ6nz3dTz
 8vsbGYpe7Iq6zFU87xGQCc4VuJWv0sqpOH5LReYEoK1ZctpFnPgvpsebjHtzBxxVKEBx
 YdjBXvNwN3Nhma2xsNuPDTo1Sw826KmK7M3HnuJisSET83NTIMd68y1sxD2nP9TDjnTI
 55oTI8C5WG6vCHt2efeyaKr9wO4Bj6MLWNj/Pm9SIm+bIozPQ1i1tgsJv2hPgFCjlNCx
 4/eg==
X-Gm-Message-State: AC+VfDxjmXnodgywYAMUTp3+c10jKI4bHq+qPJW0yfc+qGWklRnoaPjR
 HIflaG2xgtQz7TuCZ18ZifK3OPR51ww=
X-Google-Smtp-Source: ACHHUZ4dW3EbNVodpwHmLNYJbfCbh9EgV9Cygf8NvvNpvFHfyH5Cwjassp6XGh6Q2mkk80aX3SyEiQ==
X-Received: by 2002:a05:6808:1b2c:b0:398:26c5:558a with SMTP id
 bx44-20020a0568081b2c00b0039826c5558amr5093076oib.46.1685292587132; 
 Sun, 28 May 2023 09:49:47 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:46 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 05/10] hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
Date: Sun, 28 May 2023 13:49:17 -0300
Message-Id: <20230528164922.20364-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Commit cef2e7148e32 ("hw/isa/i82378: Remove intermediate IRQ forwarder")
passes s->cpu_intr to i8259_init() in i82378_realize() directly. However, s-
>cpu_intr isn't initialized yet since that happens after the south bridge's
pci_realize_and_unref() in board code. Fix this by initializing s->cpu_intr
before realizing the south bridge.

Fixes: cef2e7148e32 ("hw/isa/i82378: Remove intermediate IRQ forwarder")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230304114043.121024-4-shentey@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/prep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 4610abddbd..33bf232f8b 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -271,9 +271,11 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* PCI -> ISA bridge */
-    i82378_dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
+    i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
     qdev_connect_gpio_out(i82378_dev, 0,
                           qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
+    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
+
     sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
-- 
2.40.1


