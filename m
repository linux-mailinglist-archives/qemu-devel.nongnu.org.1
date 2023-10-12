Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E127C63DD
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4J-0004EY-Lm; Thu, 12 Oct 2023 00:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqn4H-000467-Ma
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:01 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqn4E-0002b5-Nu
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:01 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c16bc71e4cso6378141fa.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697083977; x=1697688777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNXd/6GPgJXQ92iTYms/9+W0zMbeXRjR7NXBD4ayeB0=;
 b=kGDkRmaQwCYp6j2jJH7aTXzacgKnjUGg7OjRcP6+P3+OXsPR4aTYHJM84+EEQZqG8s
 gGxbNd8N0SNO1Wb5J/tTuZxF0rftGL7uRU0bsEJfJezT6TpGtaWxn17D2T31jGL0/0pD
 Iz6PP22Rcnonca1KKJK98a+lFXWUJ2xqhyt6t0uYXEyuL/4Q3vWS1VDFBuHm53K9CNMu
 QQ4s+XjBi/mOBcUwHIceof26jidwFIc/xXj5QYW7Q19pD01lLDksOXcPBUGfYzfmyXNP
 YRKefmJNxRMyNFWUIUyfepcW6JX3PHxk3SdpKTdfndmr6DwRh2PhoppCdYU6qqCY97u8
 Wkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083977; x=1697688777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNXd/6GPgJXQ92iTYms/9+W0zMbeXRjR7NXBD4ayeB0=;
 b=cWV3ig6ssSngaxyt7zY6GOhTPsrXxA1bU0KlcMrSAZ5rd4rUTMBmV3wiys5+rpP+aF
 rNlDqiwxlhxnIrozIHUYjiKzcXMxPdwalzQfHP1ehv65xaY/z8OeY40lMxYKr2SGIbud
 1rb3tfVFkdPs2BFCCXbCZdKNFNGzm8mZd5ij9jg51z/m5/lRUvG2iYIqbp8Ryl8FECJy
 PqElz+j4FCyQh4omuu8RP+Pwa6DTPd4Snh9jfNUve9so+bcK+WD3vhHrSPt2iwcS1r23
 2SxWxBHd5AiTUAiJt9P7PNPwnVGxF+d7LwSQ5Ees4wcSneD1dvjvBOePkMop4ElErc0v
 4kFQ==
X-Gm-Message-State: AOJu0YzXhOz332h4c45U25l78BuaPIyuqgHUsouuR1YcgacKg+zsgTID
 /zDZgjbVqTOpgg6HQgebOl0ImToKgbQY/5U1fGHzeA==
X-Google-Smtp-Source: AGHT+IEnTQLk81ojBci2sWeVbUkUe+v9iLPUQ9kh+/8FbKhmY3QRypfcbu3LKAb25honpNMi3WeKKw==
X-Received: by 2002:a2e:b165:0:b0:2c0:23d3:daee with SMTP id
 a5-20020a2eb165000000b002c023d3daeemr20366292ljm.39.1697083976706; 
 Wed, 11 Oct 2023 21:12:56 -0700 (PDT)
Received: from m1x-phil.lan (dcs23-h01-176-173-173-31.dsl.sta.abo.bbox.fr.
 [176.173.173.31]) by smtp.gmail.com with ESMTPSA id
 qb40-20020a1709077ea800b009b9af27d98csm9145791ejc.132.2023.10.11.21.12.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 21:12:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/pci-host/sh_pcic: Replace magic value by proper
 definition
Date: Thu, 12 Oct 2023 06:12:37 +0200
Message-ID: <20231012041237.22281-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041237.22281-1-philmd@linaro.org>
References: <20231012041237.22281-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/sh_pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 580e273d96..4edebced5e 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -40,7 +40,7 @@ struct SHPCIState {
     PCIHostState parent_obj;
 
     PCIDevice *dev;
-    qemu_irq irq[4];
+    qemu_irq irq[PCI_NUM_PINS];
     MemoryRegion memconfig_p4;
     MemoryRegion memconfig_a7;
     MemoryRegion isa;
@@ -131,7 +131,8 @@ static void sh_pcic_host_realize(DeviceState *dev, Error **errp)
                                      s->irq,
                                      get_system_memory(),
                                      get_system_io(),
-                                     PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
+                                     PCI_DEVFN(0, 0), PCI_NUM_PINS,
+                                     TYPE_PCI_BUS);
     memory_region_init_io(&s->memconfig_p4, OBJECT(s), &sh_pci_reg_ops, s,
                           "sh_pci", 0x224);
     memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
-- 
2.41.0


