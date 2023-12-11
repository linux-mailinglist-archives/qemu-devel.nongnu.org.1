Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AEC80D3CF
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:31:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCk6w-0000es-OC; Mon, 11 Dec 2023 12:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Hkd3ZQwKCrsobcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com>)
 id 1rCk6p-0000bv-IN
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:30:24 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Hkd3ZQwKCrsobcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com>)
 id 1rCk6j-0004kR-Fa
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:30:23 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5caf61210e3so53120027b3.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702315807; x=1702920607; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=czz3Zfvoxdae3NXNp3p/OgH+zhwbT8/Zm49O7RMD/rA=;
 b=qm/u8byVWgv419YbW5MgZToNmO0JL2ImAus7P5F0KC8JCCn++ZvIFTmQtz9nwxSHfW
 5AaNIw+iowLFAJE02srD+48f0cVqdpidbc3FVzhehdkvVhbcvfoMXeFJmTKQVLnxVVZ1
 /CiX5ex3u3xYmJ8uocMCY3WlfrHcEJu7fmH7NmSwpBR1i58YJHFcKz8fJybmhkwMEu1a
 Y8iugP0oQgAJN2A1H65x4z5whHgFM68DadCxeSHNzesheOY54MvTFccTWhrSH5pi/meB
 kbHj9Woz/zB8cgpsVslgrHdIUITYZmRUw4PwGCtQgL5iN66g9Q6WJU2vbok7cIGaD0+y
 WC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702315807; x=1702920607;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=czz3Zfvoxdae3NXNp3p/OgH+zhwbT8/Zm49O7RMD/rA=;
 b=IoADRKUPzODwg/YuDTpUpoMmKo+rKqvXKA3vQqYgIJqijl20U88dEZ0A+6p1vMUM13
 4Hym5IDyZlCQv72RMULUqAU3dUrTahI6WRxIr0pk2BLSx35Blm01xiIpRcG+cp34OgXJ
 PT64T4sjAXxwX6Qu4FWVfdV2moMUCm1f6EdJqZkn0zdb6lLTW6q/6RuHeIa9niEQG2cs
 auNiBYs/ZnXuzEOFcyKX8d1c5MasEf7pUKj8Iob+T97GEv9YRc4m/6Z5SWeuqv1Ve8bK
 z11r5lnZMITxMFor60We6K4tC5dPOIqBV7J2WauuW0cyedXGiodchDq3tFQbNthese3s
 0ddA==
X-Gm-Message-State: AOJu0Ywg7G134Ck5JtcK+ZvwgZ3j+7xd51T20CUF7fWEF9KYIfUZ/3Lp
 zFfa1D4xSOmzBJWIzEFhehGwUlt2g3mfO/Bocg4=
X-Google-Smtp-Source: AGHT+IFy+PTEMU8eChwzYhg7Nr7VOOOdWofkIwVpsSAtNRPwjSlArMJIkcQvVJe4ChlS7R5sYRQxZ9BF1NkogvwHnlk=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:891:b0:5de:7c16:1f18 with
 SMTP id cd17-20020a05690c089100b005de7c161f18mr48277ywb.0.1702315806726; Mon,
 11 Dec 2023 09:30:06 -0800 (PST)
Date: Mon, 11 Dec 2023 17:29:43 +0000
In-Reply-To: <20231211172953.3164357-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231211172953.3164357-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211172953.3164357-3-nabihestefan@google.com>
Subject: [PATCH v6 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3Hkd3ZQwKCrsobcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01,
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
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
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
2.43.0.472.g3155946c3a-goog


