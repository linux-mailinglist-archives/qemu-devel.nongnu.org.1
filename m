Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BFA718BA1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4T60-0006XP-De; Wed, 31 May 2023 17:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5y-0006VX-EE; Wed, 31 May 2023 17:11:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5w-0001FI-M2; Wed, 31 May 2023 17:11:02 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-96f588bc322so915066166b.1; 
 Wed, 31 May 2023 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685567458; x=1688159458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIjTjeEt/jRjqtxQwTcOBu8ecexcgkV84jSNcf6bKZc=;
 b=bry9Lzaap6tOdchuZeUIdZhZs4fQmTHUuJ8qXkZUm7KVgKgKKaBFEwgAf+F3JUchyV
 fmm0Y+VgkDaF5QlaVlMZi4Kmx4hA5184w9OHbC00OFOiehQfrUCcUYPGL642k5VF1uBH
 jxl3GsvomFNQrDBvm0+Bry3iLGnweA7Vm1Gu9hvk0CexTjL8gPlz+lByOfUDdR0+1cyE
 tZrMqzsWJYqqt8lDcKQTM18tRMHHEpMIBMKynQpvM9pnZGVE7mNfvdxkWkdAsxfYOJcA
 M1/3HlCHyYUdxVwwWDh+YA74sh+yeTnHyt+2C6sjZEU0vI9uZ0V4Z275hO8B5b4UCJAD
 2Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685567458; x=1688159458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mIjTjeEt/jRjqtxQwTcOBu8ecexcgkV84jSNcf6bKZc=;
 b=TxcMrNAd8APb9Y1VBLCICZ7F7jV6s6dKKkumGYOjg7bVFN74BefFb6zmudcNBSwahE
 +ks5nbVV7BrJXU2FWM2nx3CTN6Kqj5kE30JFgcy+dOoywYWJMsaeNAirQlZ8qAifK34V
 awYU/TOc+URmGahtvfCAwfwBWxwXOaTVKW95/niZbY1zzsj3qsRMZgT63/MKkEqMTtTw
 LiDTwP4q10zTIjwcjL3RNmVTYt4vcjxjsK672JA8jjswAiTsOAujrKxsfa2LV+gvbhTx
 W5bl0Bj5LSkjwkbipXnaw2GedbWZ/VL+ZqUX6NHUBOJzo51zyeaMhEaP08yWRBCJyeV2
 R4mw==
X-Gm-Message-State: AC+VfDyeZYMgZFNQ0QlVB8viEKe0hrwqnKbCYe2Nk/3J2P3/3ifc5OUh
 vUCn5qsW4G2DOnR7nfmMF5IvSGi3B8k=
X-Google-Smtp-Source: ACHHUZ7FjvRdPLuwKR8biqu5gwlLo8Zfq1Q9YMjdUzsI+i1FxPU3saK+faZD/AW5D+DX5UIp6mDuRw==
X-Received: by 2002:a17:907:7e8d:b0:961:be96:b0e7 with SMTP id
 qb13-20020a1709077e8d00b00961be96b0e7mr6643583ejc.48.1685567458258; 
 Wed, 31 May 2023 14:10:58 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-159-078.78.54.pool.telefonica.de. [78.54.159.78])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm9463054ejv.137.2023.05.31.14.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 14:10:57 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 5/7] hw/ide: Extract bmdma_status_writeb()
Date: Wed, 31 May 2023 23:10:41 +0200
Message-Id: <20230531211043.41724-6-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
References: <20230531211043.41724-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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

Every TYPE_PCI_IDE device performs the same not-so-trivial bit manipulation by
copy'n'paste code. Extract this into bmdma_status_writeb(), mirroring
bmdma_cmd_writeb().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/hw/ide/pci.h | 1 +
 hw/ide/cmd646.c      | 2 +-
 hw/ide/pci.c         | 5 +++++
 hw/ide/piix.c        | 2 +-
 hw/ide/sii3112.c     | 6 ++----
 hw/ide/via.c         | 2 +-
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index 74c127e32f..1ff469de87 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -58,6 +58,7 @@ struct PCIIDEState {
 
 void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d);
 void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
+void bmdma_status_writeb(BMDMAState *bm, uint32_t val);
 extern MemoryRegionOps bmdma_addr_ioport_ops;
 void pci_ide_create_devs(PCIDevice *dev);
 
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index a094a6e12a..cabe9048b1 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -144,7 +144,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
         cmd646_update_irq(pci_dev);
         break;
     case 2:
-        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+        bmdma_status_writeb(bm, val);
         break;
     case 3:
         if (bm == &bm->pci_dev->bmdma[0]) {
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 4cf1e9c679..0b26a4ce9f 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -318,6 +318,11 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
     bm->cmd = val & 0x09;
 }
 
+void bmdma_status_writeb(BMDMAState *bm, uint32_t val)
+{
+    bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+}
+
 static uint64_t bmdma_addr_read(void *opaque, hwaddr addr,
                                 unsigned width)
 {
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a32f7ccece..47e0b474c3 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -76,7 +76,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
         bmdma_cmd_writeb(bm, val);
         break;
     case 2:
-        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+        bmdma_status_writeb(bm, val);
         break;
     }
 }
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 5dd3d03c29..63dc4a0494 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -149,8 +149,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
         break;
     case 0x02:
     case 0x12:
-        d->i.bmdma[0].status = (val & 0x60) | (d->i.bmdma[0].status & 1) |
-                               (d->i.bmdma[0].status & ~val & 6);
+        bmdma_status_writeb(&d->i.bmdma[0], val);
         break;
     case 0x04 ... 0x07:
         bmdma_addr_ioport_ops.write(&d->i.bmdma[0], addr - 4, val, size);
@@ -165,8 +164,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
         break;
     case 0x0a:
     case 0x1a:
-        d->i.bmdma[1].status = (val & 0x60) | (d->i.bmdma[1].status & 1) |
-                               (d->i.bmdma[1].status & ~val & 6);
+        bmdma_status_writeb(&d->i.bmdma[1], val);
         break;
     case 0x0c ... 0x0f:
         bmdma_addr_ioport_ops.write(&d->i.bmdma[1], addr - 12, val, size);
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 91253fa4ef..fff23803a6 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -75,7 +75,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
         bmdma_cmd_writeb(bm, val);
         break;
     case 2:
-        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+        bmdma_status_writeb(bm, val);
         break;
     default:;
     }
-- 
2.40.1


