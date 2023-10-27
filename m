Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 404C77D9F1F
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 19:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwR3h-0006NW-8c; Fri, 27 Oct 2023 13:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3m_k7ZQwKCq4bOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com>)
 id 1qwR3f-0006Mv-Bj
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 13:55:43 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3m_k7ZQwKCq4bOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com>)
 id 1qwR3d-0007ik-Pi
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 13:55:43 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5acac8b6575so32197457b3.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698429340; x=1699034140; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LZ8ejjUSVdwA3spGYHLu7lgjcCQBfiNE1bIk+lCehGc=;
 b=kB8hRzVN1tatzPcaG5UCzQEHcB58aSD0m4ZVALs9LOOhJPOlCA1PirXfBX3XpMNgU0
 evy7I31RbdX5zeO8pr8yCHdMpURTsO2/z8ja9pbAPzAJdXJKPNosdV0Q0c3ZijqjbCDF
 HFOJD+FTKyfxIeGAF0GT9TDVV+ouqzPTLKIuCSK+n7IX2c6HxdClCuHFsK2cnNpzsE+A
 xE2OM0zSvCtRaXnFy8sTd09As/rerEuwNRgTnNqN6Z4eTMpX6UivYDq7bFvaSn3ym1XM
 v68/fl8tE91JbYmXJxam8IQxlwmMwJukDHE3do/vB+Vjne+idEIBL12jEvnyWpBP16hI
 YJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698429340; x=1699034140;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZ8ejjUSVdwA3spGYHLu7lgjcCQBfiNE1bIk+lCehGc=;
 b=rcE1JIiW651FFA53lJOqt11XrR+Lv2ZwaLM6PlvQGNRkOgYCizkZQSJC6SA8vBoESw
 hFUnuDKwVcNwQYROf5YYQVOin48+ZjtMrBLQmevpxivQa3PuagEGGa8dmkCfzWTW87PM
 k+q4ONoDLfYl2KuOnZXuN2XxE57YjyN3SLB3/8UIbby0S/Vk6TrgYHsuf1uxgoo7gJUg
 wXsc6VupY24yG2APkvHlSyjiEbqAE0W+J8xvL8/ulwdf1wee2MhDtne1N24EfnoNliKc
 fuYFUizj85cKpbh7jEpNXPgGX3gnWtl9VlOABI29bjQqnfxXIYwA7zmQhLybWozO7qar
 wXdg==
X-Gm-Message-State: AOJu0Yzuh+Mb3BssGFzLDR1awsv2xZFbNwVLl8Hea62r1DZkU0FSIfob
 yekrOGi9z0cbRZ4hrfTdKiY3asfhfF+Azq2dPzo=
X-Google-Smtp-Source: AGHT+IFYh0zn6TBSD4D5pm77w/jHoIYF8/xPPka1Zx7FF1+ek+K511277GlhG6M3VGYPRxKTaOcs23anPZouPPEcWHA=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:5785:0:b0:5a7:b95c:a58f with SMTP
 id l127-20020a815785000000b005a7b95ca58fmr171943ywb.1.1698429339781; Fri, 27
 Oct 2023 10:55:39 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:55:23 +0000
In-Reply-To: <20231027175532.3601297-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231027175532.3601297-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027175532.3601297-3-nabihestefan@google.com>
Subject: [PATCH v5 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3m_k7ZQwKCq4bOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

This patch wires the PCI mailbox module to Nuvoton SoC.

Change-Id: I9421ff6bc7d365b0559c0a1f6b98cfd24b6f2d9f
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 docs/system/arm/nuvoton.rst | 2 ++
 hw/arm/npcm7xx.c            | 3 ++-
 include/hw/arm/npcm7xx.h    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 0424cae4b0..e611099545 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -50,6 +50,8 @@ Supported devices
  * Ethernet controller (EMC)
  * Tachometer
  * Peripheral SPI controller (PSPI)
+ * BIOS POST code FIFO
+ * PCI Mailbox
 
 Missing devices
 ---------------
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c69e936669..c9e87162cb 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -86,7 +86,6 @@ enum NPCM7xxInterrupt {
     NPCM7XX_UART1_IRQ,
     NPCM7XX_UART2_IRQ,
     NPCM7XX_UART3_IRQ,
-    NPCM7XX_PECI_IRQ            = 6,
     NPCM7XX_PCI_MBOX_IRQ        = 8,
     NPCM7XX_KCS_HIB_IRQ         = 9,
     NPCM7XX_GMAC1_IRQ           = 14,
@@ -463,6 +462,8 @@ static void npcm7xx_init(Object *obj)
         object_initialize_child(obj, "pspi[*]", &s->pspi[i], TYPE_NPCM_PSPI);
     }
 
+    object_initialize_child(obj, "pci-mbox", &s->pci_mbox,
+                            TYPE_NPCM7XX_PCI_MBOX);
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
 }
 
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 273090ac60..cec3792a2e 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -105,6 +105,7 @@ struct NPCM7xxState {
     OHCISysBusState     ohci;
     NPCM7xxFIUState     fiu[2];
     NPCM7xxEMCState     emc[2];
+    NPCM7xxPCIMBoxState pci_mbox;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi[2];
 };
-- 
2.42.0.820.g83a721a137-goog


