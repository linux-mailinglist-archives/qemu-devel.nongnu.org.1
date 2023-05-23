Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D047A70E600
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:51:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y13-00014z-L5; Tue, 23 May 2023 15:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y11-00012s-CE; Tue, 23 May 2023 15:49:51 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y0x-000489-SI; Tue, 23 May 2023 15:49:51 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-510b6a249a8so522017a12.0; 
 Tue, 23 May 2023 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871384; x=1687463384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lv55u1Phksy7vpvt5uQalm8ZH8vHXFG9KtnpUGBJcg=;
 b=RpMJ5FtPZ7B8kwXqY3otfz5525EUiocLP4TzEE8Lxi3LWqhnRl+FTWaU6yvJKUvuxh
 SEXTc29YrKIib/pcUXJpjGQcTkO29Gznz/4jmPD/1c54I2ansmZd0zA1ZL03IUrtOfPi
 SJAqdqnxd2bJ0QGyQO+rOz9A/64J+sTMB8ln8a+KUdjNy1kLzSYxRKcs6MmS/3HC95d5
 dDdxGbr++jNjX205T2pl0ncNRcGo94pbT6pT7YPPAHznPKsGPT9Sb6UsTaPm6h8XmTUN
 sTlOQdwyu5SrjAGC9md1dXfY56jTRXn71gAgrXd2wVQJqe7tDqPYbUDQFO7vmg7ebg5I
 DPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871384; x=1687463384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Lv55u1Phksy7vpvt5uQalm8ZH8vHXFG9KtnpUGBJcg=;
 b=DgqsPX/sAd/HctWQy2Q1PHfYerjBJnsqIkS7/SSxXR9EkPqS5W5ZkNJNyZ6zegC8P4
 6yWSrZgH1TdXx+bgdj02PtSf1/4qLDfWGjlO9wKmUk9zZGEWbvYmXZv+7KUJQmBsAHo5
 IcBEaaEa61n12gDH/WBegP1hk3vuwAHxEUnhbl/1B+WdchDH3QGP1YppuIgqhAZAAq87
 YLlLx007/msrIfsXupZIztYvtf8FeOrpyUJUSuC8ymiyadyn+XD19yKMdupilROmoTZd
 qA6gutHiMELmsj8gsCw2nPG2qjRG1VcTbgtCnf/CIJSwPK3Cm9EmCX3sUV9kpamhUsGI
 MW/Q==
X-Gm-Message-State: AC+VfDwtBkrY/ebDdlM07dZbDgSVCUeIsJzPwX6e/Na0o9ibWKfyMxtu
 Gx84mWAoYbY/Rs23ToiSYoyJBVB+e64=
X-Google-Smtp-Source: ACHHUZ7UwoB4XoIimm8xEOtTQT5M5eA54G1pJas2fVACF5ZuiurdSABuleM4qzUNuZQHZAsqcN/c9g==
X-Received: by 2002:a17:907:968c:b0:969:e55f:cca2 with SMTP id
 hd12-20020a170907968c00b00969e55fcca2mr18204111ejc.38.1684871384483; 
 Tue, 23 May 2023 12:49:44 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b0096f641a4c01sm4800593eji.179.2023.05.23.12.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:49:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, John Snow <jsnow@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 5/6] hw/ide: Extract bmdma_status_writeb()
Date: Tue, 23 May 2023 21:49:29 +0200
Message-Id: <20230523194930.124352-6-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523194930.124352-1-shentey@gmail.com>
References: <20230523194930.124352-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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


