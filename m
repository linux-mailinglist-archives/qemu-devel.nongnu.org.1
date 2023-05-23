Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D470E5FF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y12-00013k-Cd; Tue, 23 May 2023 15:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y10-00012E-1d; Tue, 23 May 2023 15:49:50 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y0w-00047I-Pi; Tue, 23 May 2023 15:49:49 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-96f588bc322so881525466b.1; 
 Tue, 23 May 2023 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871381; x=1687463381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAglph6l2Iect/DEGB+rq6Jjk5c3mTKMPl5jFgPSj6Q=;
 b=jQcFQDuo/fZbsmjG/ZF6zr39kWuhwTbMI6+1qdhgbfw/4O35jxeQCax7b+5YzBRnYR
 hsZ/tyNLHzoGTc56nFSES/IVS0P+tKxZ/LQP72tUWeIsJ0vcGmV6dYJXytI+59l4CH2R
 x0m24zR4yMKE5SxSGmUhJ3RFX7mOrStkCz02K3uHjfEpjk/SUst8iDd85t6Xk2b822Yp
 wAtC2GOYZBMUbNwTx3XnuHlv6/ILTuDPqj9LYSbwj/F9szM2IR6hywwFhmQgX0w0aFil
 Y7f5TgPOVg4nlis+K9fLbXgB+1AzSpmySFJ7gzIWfG8do/aeIDId6dk/Zi595WY5ErTI
 Rq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871381; x=1687463381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAglph6l2Iect/DEGB+rq6Jjk5c3mTKMPl5jFgPSj6Q=;
 b=lZD2GeckdqMNxeqDQ4msncMyr867iAbLwaDXhJXJelIy06FEXz+nC2QLowBMpj9akZ
 jQ8fTkbombotlRhk39hSx1kK+RQFbpFmyfX8r3PSjSmym388gP6hh4EbaBPeS6WrvEKH
 6gHfX36Q7CV80CCvTzvjLlLnubh+NpeO/9JgBsSJ0BXwAz68hQfPvVIaKO3Y0XCXLs7C
 ODT3VuQcLURGj/Jgteksyl2naRVT7HrLq4T5RrMy61E70pIP6apKuYz0+ZSglf+QeNyI
 WZbtKKTuAk6Tr8NNlc3hCZgXvoOjSRIxCHwDsCi8PNW1ugMsLsLhAU1g4jtEBAzqxRRb
 jA/g==
X-Gm-Message-State: AC+VfDymmAOoR+DX/u2eA9A4qfmbeJ4tOfA0lbI1CIn7ludCMoB2qJTU
 rqe877L5U0ekWU+mp/YcAZ0mIhwIogE=
X-Google-Smtp-Source: ACHHUZ5CAtsE7FtSL888zrzeO+0BS0c2m15A4pjuchy5OLljIw+YH72gLtE1+NSN1TRjKbT1suqfCg==
X-Received: by 2002:a17:907:608f:b0:8aa:a9fe:a3fc with SMTP id
 ht15-20020a170907608f00b008aaa9fea3fcmr19121307ejc.8.1684871380660; 
 Tue, 23 May 2023 12:49:40 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b0096f641a4c01sm4800593eji.179.2023.05.23.12.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:49:40 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, John Snow <jsnow@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 1/6] hw/ide/pci: Expose legacy interrupts as named GPIOs
Date: Tue, 23 May 2023 21:49:25 +0200
Message-Id: <20230523194930.124352-2-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523194930.124352-1-shentey@gmail.com>
References: <20230523194930.124352-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Exposing the legacy IDE interrupts as GPIOs allows them to be connected in the
parent device through qdev_connect_gpio_out(), i.e. without accessing private
data of TYPE_PCI_IDE.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
2.40.1


