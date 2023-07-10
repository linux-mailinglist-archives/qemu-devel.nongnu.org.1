Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1134274E132
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzO1-00040f-Uc; Mon, 10 Jul 2023 18:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzO0-00040F-GV
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNz-0002Cl-10
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fc02a92dcfso32946725e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028177; x=1691620177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cspC1pmJKd9x8KtL27yFisUZgwn8qgFbFWAuYt1IY7s=;
 b=JiNtlaFeHEnKDsRcmcT6meSyxoB5WgFk+yv3FTb2RSh2U7kL2afNGN2XxUh4/gShy+
 wHnDxz/7233TjSALL6uBb9oGyPYB+XEfX9HnIxWNsqyvDEjdan+NvZniU6H4cLlSIPPu
 0wXgzP3XcAuzU7/t9R2h8LWjKNxNRBxSBvb7uSFnmtpdBTv3xqqP3vcpSPMgy6mEd40K
 tmnXLbhW6afvmGjaBr1YH83o6ihQkvvpXotMTeclY2iv/Lh1QIlHjfXhQIuEbDfsqAT4
 a5CIy+ECKpFyt0jf8EsyyK0Hn/P6BjEv4vvXn4IJgyD4sSCiAYMcn9uVl73wtN/nec8a
 73NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028177; x=1691620177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cspC1pmJKd9x8KtL27yFisUZgwn8qgFbFWAuYt1IY7s=;
 b=csKLWbPSS7PZneMszHkeHApxWGnRQJWrRnPn4P7EPPfdDFyo6FQ+bzJaWXhyLB7Coi
 f8MRcfDecFKHuO1WSu4gBPguND8P9PXNL0ypSUqG5uHTtbBDFZURPUU2vHrUb0aPK2Xu
 8E1vgDvP1Nd0sHLS/hV59/1P94qhUwzMJoMtS7aXNVXK8r18Pye5ll7jZzADROhhLkx8
 Qn+SeFULMJp/PbCso5+tyVli+WmqQSE6rRnR68lohPePfvoTGAiz8EDRQ+N6a+bkiKtk
 bO0elLtI3MHSGHnXxT8v3kuPr5YGlCLzujdGoy4R0plnLg1+zlhVl969VXRHuDAGEgXE
 wAEg==
X-Gm-Message-State: ABy/qLZiHJjtIDPZfI7CS/sOr4NG5Od3cFrUiNprZ8ZoK+sast/FKrmj
 UDjfJ0lojp/Otj9lSSQmaJ4HKa2ccaPnOO92rVv8qg==
X-Google-Smtp-Source: APBJJlE/LfBVlxp27QPgokF2T4yAiY2mlRsnorEQcQ0o0jt6MDydkXOpIUoYg28cVzkqM9V9F22hwA==
X-Received: by 2002:a1c:f713:0:b0:3fb:adc0:609b with SMTP id
 v19-20020a1cf713000000b003fbadc0609bmr13258048wmh.13.1689028177270; 
 Mon, 10 Jul 2023 15:29:37 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c444600b003fbb1ce274fsm20965127wmn.0.2023.07.10.15.29.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 38/44] hw/ide/pci: Expose legacy interrupts as named GPIOs
Date: Tue, 11 Jul 2023 00:26:05 +0200
Message-Id: <20230710222611.50978-39-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Exposing the legacy IDE interrupts as GPIOs allows them to be connected in the
parent device through qdev_connect_gpio_out(), i.e. without accessing private
data of TYPE_PCI_IDE.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20230531211043.41724-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index fc9224bbc9..9a5a7089d4 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -522,10 +522,19 @@ void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d)
     bm->pci_dev = d;
 }
 
+static void pci_ide_init(Object *obj)
+{
+    PCIIDEState *d = PCI_IDE(obj);
+
+    qdev_init_gpio_out_named(DEVICE(d), d->isa_irq, "isa-irq",
+                             ARRAY_SIZE(d->isa_irq));
+}
+
 static const TypeInfo pci_ide_type_info = {
     .name = TYPE_PCI_IDE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIIDEState),
+    .instance_init = pci_ide_init,
     .abstract = true,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-- 
2.38.1


