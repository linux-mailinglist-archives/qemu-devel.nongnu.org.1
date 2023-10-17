Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F6F7CCA75
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsoY3-0004rf-Br; Tue, 17 Oct 2023 14:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cc4uZQwKCvgsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1qsoY0-0004q4-Pp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:12:04 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cc4uZQwKCvgsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1qsoXz-0006vf-4E
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:12:04 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d9c6ab06242so654695276.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697566321; x=1698171121; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=fpTYqbzbpK0KwCDIcxLgpCv/rd2lgYasN8Y7y7lzZh8=;
 b=0EJ7vdvddHz7J3ZP3g1KPANgxYBmdk7flFMCc5JjSDHHdA2Dd7DRTEOiPdZrks83C9
 YQVFNDpFXXyySG//EMfk55oakbfUNp59cETkcAEB6RJFvfEM8DmQDukbeCaZD2KzlP07
 TFRjXPVieESlEq+ha0AR0NnRjSHBXh4yABH1yNMf1GbHgX7domfyo87Ou5mmnhcsHqy0
 MRqHYu3qvHeC9853vJ6oqBhd1Ulb1PMwUq6veRYQ1pC1bMeJksBLlUPTdKzUAd2YvM5b
 AkVYUuPPYRifSwPBH6HfeoHWybiIyrkZCpnhs4s6ujqatxKoJUYX+M4Y+jliJm3WyW7p
 dbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697566321; x=1698171121;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fpTYqbzbpK0KwCDIcxLgpCv/rd2lgYasN8Y7y7lzZh8=;
 b=gUNPx3kiLAIeo2m9fT4F+NWYj2iB3l8LVMkwBciO2C8rl1xvg8WGLSJ2/V0Ax1GUL8
 bpcu2+uhi0g0ZkkZmEdPElGBj+H8T2h9bCYsFMCCo/VJ5yZ1/SfBxijM0UmCstFNO8u7
 or9e+xtk913mfVM577hiqFe3yoY9tMW37d/+CKfvGjdu2CPLnm6gr/xNr7QIfUmVe9jd
 F+7s8Lb9mdNJFX4Bpc3Wlzitfe8qoe+yYOcgi+J50N9zeJPTBYCxqGwBt6GPYKRrA7gY
 TPUCLMljMpaeYLxshsMUNzCe1u9ks8wP4neICvUjOBR62SsVRJ+3jcjHGM1IATi51RIN
 oOqA==
X-Gm-Message-State: AOJu0YxgQtiWCEmW/t0iHJQKB0KEwZi1tQtAoY6OFwOkeCEaNxY/pB2x
 1EWD6gUBhs6blIDcbfM66BliyaJV6mvZrYJSzrM=
X-Google-Smtp-Source: AGHT+IHieHGHgSAr/xOv/g3rYWuXtz4mJ7k80vqmP7qlkgvdAGvcef0IiBjrsFw5V2kEZYwuIqH4tKCkCEP19r7NREo=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:4e09:0:b0:d9b:341a:ba5d with SMTP
 id c9-20020a254e09000000b00d9b341aba5dmr60656ybb.13.1697566321193; Tue, 17
 Oct 2023 11:12:01 -0700 (PDT)
Date: Tue, 17 Oct 2023 18:11:43 +0000
In-Reply-To: <20231017181152.201887-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231017181152.201887-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017181152.201887-3-nabihestefan@google.com>
Subject: [PATCH 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3cc4uZQwKCvgsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Google-Rebase-Count: 5
Google-Bug-Id: 262938292
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Change-Id: Ifd858a7ed760557faa15a7a1cef66b2056f06e2e
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
2.42.0.655.g421f12c284-goog


