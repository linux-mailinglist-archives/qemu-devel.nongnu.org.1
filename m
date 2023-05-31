Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E6718BA9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:13:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4T5v-0006SX-UA; Wed, 31 May 2023 17:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5u-0006S1-BZ; Wed, 31 May 2023 17:10:58 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5s-0001EP-S3; Wed, 31 May 2023 17:10:58 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-973f78329e3so719875466b.3; 
 Wed, 31 May 2023 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685567454; x=1688159454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAglph6l2Iect/DEGB+rq6Jjk5c3mTKMPl5jFgPSj6Q=;
 b=KabZ4+3zjlZPsSYZJr88hBxfP9uTZ1Y9EuiJaYNWtKMVZ/zkmseV1wjlt83fjqO7x2
 jm+NMFQi9p2I43fy0+P9wAkCDMF8/6ThfArgoLhR1KGWzW21G8GPIfTcavf7xEGPcGyB
 LG8XOYt7YhQZn5nylunvxye9MDCV0xldlmifV6wugzEH1p5dS+Y90c76H/eBmbBSdpLY
 7RHOzEAQ/Nlm+5ehe7OtN7YJonNknoQ8WRMQvP/Q8vcA4UbwKl19eu8HE+dPd8fgTjWN
 /scL+MTNlnQY2Om0rPFuB7P2mss3GXqeGFVrxWSA+Y7VmxeBihSjFn/ik2NwcBr2XgbB
 sREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685567454; x=1688159454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAglph6l2Iect/DEGB+rq6Jjk5c3mTKMPl5jFgPSj6Q=;
 b=kF7jUNVrBdIWkPXaDLfp5mCyeEzoN3Ah3YARADjTzpCD0DgdR3kEq/Tf40kejL2wjh
 XegizdcDSjG6ADtA3Nkocf7a94EhTyaoqrvLs1xli67rypVhcPSYTIQK7ZrMkTFkLpFB
 HanwpRzZifuLl6AWAljTI+Oi9N9IQOJnZBk1LEgLJAsQL5F59DoXkELK2sUJ4wUGkL7P
 SuseWsXqcoSZQmUkmAzjnzhe/KgO1kEMBGnIiOd+KY6dyI7FrTtp2WLUpddWAU/dXhmB
 TJYcuq2nFtPvMDIjjm8xh6H0VPiMBVBUaqPu+bqFwI/MO0AUpwnu57T5GgMS8We/IlNi
 Ou+Q==
X-Gm-Message-State: AC+VfDwiay7/mjcwimHGxb2KGBbu+5YRnnDbL5tdihqvVkr3vX8uGf5U
 zTf8nomrE7fiMjgBQmFxXx8KU9OISbQ=
X-Google-Smtp-Source: ACHHUZ5q7y4Cek+l5DvWEy2vk8eGMdMANyVnLCkLKWVR2/GG7PJgCV6i+Ir7YvjBrHsEKuq8EqJCiw==
X-Received: by 2002:a17:907:961a:b0:973:91f7:5092 with SMTP id
 gb26-20020a170907961a00b0097391f75092mr8891483ejc.2.1685567453614; 
 Wed, 31 May 2023 14:10:53 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-159-078.78.54.pool.telefonica.de. [78.54.159.78])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm9463054ejv.137.2023.05.31.14.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 14:10:53 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v3 1/7] hw/ide/pci: Expose legacy interrupts as named GPIOs
Date: Wed, 31 May 2023 23:10:37 +0200
Message-Id: <20230531211043.41724-2-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
References: <20230531211043.41724-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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


