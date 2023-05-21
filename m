Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A896F70AD90
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:16:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0h2S-0000WP-Qk; Sun, 21 May 2023 07:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2R-0000Vf-79; Sun, 21 May 2023 07:15:47 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2P-0004jY-NY; Sun, 21 May 2023 07:15:46 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-96aae59bbd6so932144666b.3; 
 Sun, 21 May 2023 04:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684667743; x=1687259743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAglph6l2Iect/DEGB+rq6Jjk5c3mTKMPl5jFgPSj6Q=;
 b=ZjuzuFpf71SNdeKiDws5Fbsg7adakweYwEH3+FTXJh93RWs+4esBaoxLeK6Y/WiqXI
 PmueZZCAErKKko9gOsV4lAubq6yqJjZN0LxOgTI46WHiZ51r8nTJVP3Kotp9/SGPJMKl
 IyD7rGoQSvXn06qp03WBvKjCvaf9+atg2hp+zkqFIA4W0Kk1j2ny3aSypTCdMQqDp8Lo
 XER8lDPSDKRjbx6CTfm47HdUOlCzrUnRvvrmcZLwt2B3SyHIg+PUhdW965Df98qALL7P
 sImacXChhuB/cWp1rndzSk66zGpgkN80ofSFDd0ZHLkq93yAHzPepY49F5IJFLK92+49
 xeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684667743; x=1687259743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAglph6l2Iect/DEGB+rq6Jjk5c3mTKMPl5jFgPSj6Q=;
 b=bj0h1WCu+Veg7EUvLjzm3IPIyOrwzqkvKhX39+UV4+pS7nCUEzXG3PSnHp8uZVw59h
 IDOmbY1Dl1twwiCFdEjiQDcifsLQEpw29AYOjLtFkbPKukXmViXAXY5/ZiNDeXv3iXsG
 TpY1KZvultbtA+KJIFtW2fkR7LjNuyIdkLgj5oiuCkrM33RIB4LSf1cuHln4YeJ/Hd50
 /g0o+wKZrIVWERvdQxr+xy4Utbb+CXBqZNpKkwfXJxZ3e608QWOAh4kw9KryjYCd2Mlb
 6TmYKR0lwt0Cw0rkNaalaBZ4TLHm7TbzC035E9ZEDKRAde8LQr5AfMMai7yVQtNugO+E
 5iEQ==
X-Gm-Message-State: AC+VfDy8FW08hiEr3nJ57QzKviS7dnkAsAZzoC/F223bqESbV0JbYPl0
 8/8CT1pago6ZQBTTNGstlS/tWDlfCMQ=
X-Google-Smtp-Source: ACHHUZ5G8/lcMU8ddsv4yHSq/o0u80ZRY62moHgRN+8ALcefnCsBLGbjzfdKDJsn49S96eb6YPKgjA==
X-Received: by 2002:a17:907:1c1b:b0:96f:905e:e090 with SMTP id
 nc27-20020a1709071c1b00b0096f905ee090mr5516177ejc.35.1684667743131; 
 Sun, 21 May 2023 04:15:43 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056402124500b0050dfb9fc499sm1757123edw.39.2023.05.21.04.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 04:15:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 1/6] hw/ide/pci: Expose legacy interrupts as named GPIOs
Date: Sun, 21 May 2023 13:15:29 +0200
Message-Id: <20230521111534.207973-2-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521111534.207973-1-shentey@gmail.com>
References: <20230521111534.207973-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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


