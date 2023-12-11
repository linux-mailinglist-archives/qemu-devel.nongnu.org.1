Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D580D4A9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:53:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkS9-0003C9-QO; Mon, 11 Dec 2023 12:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VEx3ZQwKCvsqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com>)
 id 1rCkS7-0003At-SU
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:52:23 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VEx3ZQwKCvsqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com>)
 id 1rCkS6-0000Ww-Ba
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:52:23 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-db53c05f802so4684382276.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702317141; x=1702921941; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=gV/TlsuRpJmOMn/Z8XrWKUKCWp3WXIvgILxZ0hGnxKY=;
 b=DQughC9xgUU8yomAYIkB308ISojCkSsp51sWhzsz99X3YxBjddqtcC5pUaOXeb0VPy
 CPuKshQim1q5F8609//T28clTFqnSjevnX1ojMAJ4v7rDT1xc2h3MD6lp+9MGklPXVob
 xcAltPDHvL0Dk55SxWJxoR5ptC8Imgrdpj0QeI2HugXfrd2J9RB7vBt0BGMydvni3+w3
 eB2H52R6ApATkU3xqArljQ5UY4ZZcvyjL4fn2eOyzxJTBxJZaeMcpo5E+kNULK5bb01z
 gsgYmEQqi2h/FwjrGYCJoH7GFYZx4uJ9mbrcypxzrAc4ue0bOFoltk/pqQqqSu9r1BwN
 okaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317141; x=1702921941;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gV/TlsuRpJmOMn/Z8XrWKUKCWp3WXIvgILxZ0hGnxKY=;
 b=ctz3jwAZjJ3w0ojUBSJWWFijtVN5y7iUoEHg1vpH8UzWApjDEXkkpcCRJMJUVFBgQW
 Z/+L3LQnIHkAzIGqcJQaHcQkbuHFRelnd5MnoExq6Zb4IChMh1mjFIL+WXQqYmBfHzVu
 3nGJigTNR6HaoNR/nG7QO70cugn5+uA+X6pXBfTJFlkVSY4o9JWA6DyfQ7jKhaC6vCfw
 fsIZXeQfBzXvlU+rqKgQnvkGWqqmSLU+8XApSVnItQyuqOXTeVvSDsAw68IbFw8bBolP
 WDFrAMM4CDacUtlA7dc+PfxH0dYB/yRB/1AlBJ/RP9laFp26dYlVyr/rvb1Phqfe2GKK
 QQAg==
X-Gm-Message-State: AOJu0YxjHSq8Xy6N8Oy4uuo5k714sFceWTOieWkcuCXTyydvfiaJXsQB
 Lz9t6IraLh4O+TM5Cyi+JUO1Uwr5VsQ/ffzVni4=
X-Google-Smtp-Source: AGHT+IEozli0Q0A9b4ZRGWBaK3IqRPoe5UugGF5ppERKdGuxwPgU+6klgqa22uSvLlB4oGYZ84hbI2qwKDN8DZh6hs4=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:ae11:0:b0:db5:38c8:2b19 with SMTP
 id a17-20020a25ae11000000b00db538c82b19mr66424ybj.5.1702317140923; Mon, 11
 Dec 2023 09:52:20 -0800 (PST)
Date: Mon, 11 Dec 2023 17:52:05 +0000
In-Reply-To: <20231211175215.3216667-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231211175215.3216667-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211175215.3216667-3-nabihestefan@google.com>
Subject: [PATCH v7 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3VEx3ZQwKCvsqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Change-Id: I64ab900bc8bd7c379a11d86f2b8dcfccb49e66ab
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


