Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD71974E12D
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzOg-0005YW-8h; Mon, 10 Jul 2023 18:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOQ-0005IL-K8
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:30:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOK-0002EV-Jv
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:30:05 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so5910067f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028198; x=1691620198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvLt4SnnoFbS9lrbdOB+CQ2d7RCt4t40/o8unofp3lw=;
 b=vsz61TZdVk8RdSKNNseEZK+enFJcn54ttNB409F5B1gqsipW5xi1wbtO4v7sI2gxXJ
 g4WKdBrilbPHnfQI9EH9E6JaRS9fyGTlM4+F32wMk3dE6a6j+ka0ZRdDC7wd7e1DBdPk
 bSkpYpDpUiSwxHccZVrbuw6kiJRCRSZ2cL6Z/6JNpuYnI2BugbNxz82HKR0MEUJ2tAzB
 nIaSg37pQx//AMYEi09eczT1x+Vh91zxWS0EL3s+732+n9aTfXMnFCAvYOum3zm8HQV3
 0AwCl+9v3Ocu4DcovrV4dqwuPjHi2AvsTroUBVMddF/GOBjMEtLGkajZGmnstw/9gwtH
 88Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028198; x=1691620198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PvLt4SnnoFbS9lrbdOB+CQ2d7RCt4t40/o8unofp3lw=;
 b=B/wubosVsUny8iEDXemGyyEcq3pRtGDZNNVx+KxOOkC4jrT4tmslM3cMWB/9uSwbmS
 +2QjdCG+uOGSswV2uvrd6itSsM9UQEPRJrxDdIT4N80JsiaFD9Qv0rywE83Yd2hUsmoK
 UCwF1X+Eg++lqchgt/txSq0hfWpQnvuKB39PmjlEJo9vZQQwdmZSfkk7xpHxqZWpV8H+
 UowpWLHYsbnUY4feWfYRkbjjDM/2VX7ALP0ZvIfCUIxqTgp4ef0WyFS/vgwcM71vVld1
 6Y4E3kYmBeE3fiGpoaTQi0/yARRKR8y3Y0AVZQD9pLxZe8CVZ/Az6pvP4oN9tgvweDER
 9liQ==
X-Gm-Message-State: ABy/qLatAY7+v+loETgs8YC/TBjpWbCDIDcnsNvouEKvvGMb8hCocyDm
 K+NxlD4Yv81jsxmgtrgMHqTV44ej9aSJkbfETHzuog==
X-Google-Smtp-Source: APBJJlErZMDKd+rit8woU/2vUaLNlATQlpTf/PDf1QkAzyevlzAxKPwgZbyPZK+sp/1ZQnEwYZjKbg==
X-Received: by 2002:a05:6000:549:b0:314:1e69:f4b3 with SMTP id
 b9-20020a056000054900b003141e69f4b3mr15824458wrf.63.1689028198725; 
 Mon, 10 Jul 2023 15:29:58 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 h25-20020a1ccc19000000b003fbcf032c55sm11455140wmb.7.2023.07.10.15.29.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 42/44] hw/ide: Extract bmdma_status_writeb()
Date: Tue, 11 Jul 2023 00:26:09 +0200
Message-Id: <20230710222611.50978-43-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Every TYPE_PCI_IDE device performs the same not-so-trivial bit manipulation by
copy'n'paste code. Extract this into bmdma_status_writeb(), mirroring
bmdma_cmd_writeb().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230531211043.41724-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.38.1


