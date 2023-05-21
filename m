Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B1A70AD93
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:17:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0h2Z-0000dK-C2; Sun, 21 May 2023 07:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2W-0000aO-BI; Sun, 21 May 2023 07:15:52 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2U-0004kg-Lw; Sun, 21 May 2023 07:15:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-510f3db1cd8so5069527a12.1; 
 Sun, 21 May 2023 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684667748; x=1687259748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jb9/PH3+ROUueEJCvRpM/20RsfD2Ir+RnGDElnLm8gY=;
 b=MUPchkRsKsRB1nMdVGCTfm/0cQAotglufMB0JWqijFNpmqv8qNFNQ/QIpMv/UpQZn6
 FSjRZK6AqIM7yv4/qjIMjyLq622FetZWGuRGshzwWyl7lqvGcCMuvG27Q5w6eg3FeLRC
 y083CLXpmciycYcWfPWDC6sjNnPopQVBZ86f+qi9+Gs80QNuPNtOO83HWiVYC8iduQkP
 AjzDYFrAossGQyD5p5o1yDQn24M8UpElZ/ylTwKsU8prNx0Kb8HRLPeOeWOIli3om3/i
 C6CznTJrndnpdUY1qENyOYeUJS0EyImvvGONpro3Upt6Unmle1SeljfrvifykiW2F/gP
 MOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684667748; x=1687259748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jb9/PH3+ROUueEJCvRpM/20RsfD2Ir+RnGDElnLm8gY=;
 b=hmL79mSzLoTkevhVYsxA4x4wsWU/l17Q9CEo1Co4iRlQfDoZNIwzeqIOI7PJ/dLkt0
 FzDepmmWk9LdUnfAAAx9phyW15u4In34wBVI3CgOTYF/KV2ZeGrYbPAUvVIpPfQKm+N2
 Lrx8e6RQOanwJ3sdzspRzsZP3pyiOK6w0mXazsP7qR/ynryuoMcw64VWeE1gQMPraeeQ
 NJFoTNYQZx20WFic26qlC5DXCPxm6WLu5AUvu4F+lDeXOKedto8r+iGp0QsGwesI9Vuo
 i7RN/phLQh7nTPmSjvcsZgRAF9xhdSJ9ytg/y8R6WXl9JqS7Xi3VGiueE+e7TqW5QBwK
 My3w==
X-Gm-Message-State: AC+VfDwPNikcsDEeVZsugvp940EvYtFZpmryKMvuua61VX1sR48fnIOh
 KdfQ3UeD+StwDeSyCeU5AekrvTVq1bw=
X-Google-Smtp-Source: ACHHUZ6sY9Qrz72hoslKouqWcK6LlLFsRQ8ROwB0XCOZ1kBFVME4vyCKC6nB6tucs6+Hvaqu2mV32g==
X-Received: by 2002:aa7:c619:0:b0:50b:d18c:620a with SMTP id
 h25-20020aa7c619000000b0050bd18c620amr5636852edq.25.1684667748337; 
 Sun, 21 May 2023 04:15:48 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056402124500b0050dfb9fc499sm1757123edw.39.2023.05.21.04.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 04:15:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 5/6] hw/ide: Extract bmdma_status_writeb()
Date: Sun, 21 May 2023 13:15:33 +0200
Message-Id: <20230521111534.207973-6-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521111534.207973-1-shentey@gmail.com>
References: <20230521111534.207973-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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
index 4cf1e9c679..b258fd2f50 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -318,6 +318,11 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
     bm->cmd = val & 0x09;
 }
 
+void bmdma_status_writeb(BMDMAState *bm, uint32_t val)
+{
+    bm->status = (val & 0x60) | (bm->status & BM_STATUS_DMAING) | (bm->status & ~val & 0x06);
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


