Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D217A8F2A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 00:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj5Wk-0002N2-Gn; Wed, 20 Sep 2023 18:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3sW8LZQwKCuwbOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com>)
 id 1qj5We-0002Ki-Bf
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:28 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3sW8LZQwKCuwbOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com>)
 id 1qj5Wc-00088P-Ee
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:28 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d859ac9ea15so527986276.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695248305; x=1695853105; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=v+jL/EHZmjvEfkrTfTVsZdX3fbKb/vDDuBbS7XAe73w=;
 b=RtV5JPILUPVMCc7+rnmBzv6OehKvDia5qeOHZvz8lAzoj7uH9DUOOUejC8J6cBeJ/e
 mnBM0BxUdVzmMkiY70V6RnYu130MNkSbZ+tXaQSJVoNrrHu1z9Nzx8cqod5MhSK94CWA
 aqEjeTCXW/orgMm2nZHEEaQkJb/ByDCTNMFxzPE0UZ+y2h4FP6fi+nXLoWE/0lbIcu1L
 XHrVJhdfwzvLsGTILlsARzluIJxoln2+viYE1isYxNU3hiAq2aJvzwU/XdO/JKOkgboD
 13syaLdQPWzguh7trkWJ43LlEkT/8TbprmT8gY5VrucAjHOxf5n6coUzcDcBo6O0hUnp
 jO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695248305; x=1695853105;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v+jL/EHZmjvEfkrTfTVsZdX3fbKb/vDDuBbS7XAe73w=;
 b=BztlJnQ0fn6/IApeGRWWJQIHZc+VbI+O4nAYGiLPHV7VAxfBOtFlX1fvCApU7V2muO
 COB93O+VTfRNkESGEDuGNHy8B3IeF/hXqRsOHCEofrmbeXIUMC6Qe0UIG5o3geCHQ8YA
 EFBeyE1cRHJQhsPLfPcYKXxuUIqpbbinSOWnDDIU3Q88p+jXyTC5ANCcJtisJme77oDI
 CaOVVMrqKcP6alnwhG6ubISit4c+qLBPy7QniOshioka5IOx8lnB7jHubcQveV486EgI
 YXdxCbYX9heOV3kNQnqPDaTAynaMBInQnqck3PcIXlpy7Wf4Gl7oc0UjNHHwxzVz57rX
 Wh4A==
X-Gm-Message-State: AOJu0YyDuDjdjebxF4ceTe8W+6QDzvQYKVKgv9BTy8wM956l4pA+TUs6
 UnUYkosAcXeA5ZKruiUaytjI8s1aEY951vx6vTc=
X-Google-Smtp-Source: AGHT+IGnhJ/Xlpm24BSR2Q/fhgXwIG2yVyqiM0nKd7PONEa2y7MCACrDd6GheRH0oUuRSZ3KhGKHycLAbqVWrnBmG1E=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:100c:b0:d40:932e:f7b1 with
 SMTP id w12-20020a056902100c00b00d40932ef7b1mr70165ybt.7.1695248305350; Wed,
 20 Sep 2023 15:18:25 -0700 (PDT)
Date: Wed, 20 Sep 2023 22:18:10 +0000
In-Reply-To: <20230920221819.1106029-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230920221819.1106029-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920221819.1106029-3-nabihestefan@google.com>
Subject: [PATCH v2 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3sW8LZQwKCuwbOPWVSghSTObUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--nabihestefan.bounces.google.com;
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
2.42.0.459.ge4e396fd5e-goog


