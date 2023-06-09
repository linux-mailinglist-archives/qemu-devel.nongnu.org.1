Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1472A29D
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hD8-0000xc-L6; Fri, 09 Jun 2023 14:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD1-0000wW-MS; Fri, 09 Jun 2023 14:51:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD0-0002pa-6a; Fri, 09 Jun 2023 14:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+zG1+zsLiApFxKVTbKvT2753to4bpAB1vEbcK9znN+g=; b=B+0HE1CDZ+DGeWLRZ4z+KAWMfa
 onPUEe3Nn8pp5lhL3LNwLGYWUSy5qyKABfOsqt9eUIXbRts6MbcoOWPC0EgIUiYm4SrUQ5Ay0jCOB
 V+sU4dfjm5ylpSfztxHnl5rYi3HyvUxRd5+h8y5cPrpg+baCoWd5odPYJuleDWlm+TqVvJNLBoHcy
 WrsyJDx4qS0+dgYdNqEUPn5jrOQuvxiarPC8vbmWDxe0z2XpWLCq2U8xv47Z4Qkrb9YRxGTPpE/xL
 wvY8DWjXzUBwMnqYKabfVla0E+AjhEh1RyOl5SIFlhqMbRZY/ur4dy90xOZRgSiM8jfmAw6XTC+qM
 u1VcrICj8kvG3Bi7L7VnLLdemyJnB9y4lbZOJ9oK3W/R6mG1itNs5oW+I/2T0Scc+q46fVxJqSsU5
 d4FCLncoTkz4N93EWQQ2UCllyjs7aW7JO85QGZY79yvjxV8kZ8AL5ygTbG9kwvOY5jWY9+A/Op0L4
 e5knnH0BPAt89r/JrbnzOH2PlaHynstSp3tmC+9sWqWgqxMFySL1geOmknDgjwFSsVg9jNN6KhuR2
 3JVoqt5RO/kj7MWf8uoiDCK8Vm2JbN3jdRT2op7uSzv32+0e2wSZ4X0sw8IIs+zD0gKcQA7ClE6Xo
 +/m6kMabjFJZzhwJIxOmnOn1w+mElvssvHGvxQONw=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hCq-0000p5-4p; Fri, 09 Jun 2023 19:51:32 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, shentey@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Date: Fri,  9 Jun 2023 19:51:15 +0100
Message-Id: <20230609185119.691152-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/5] cmd646: checkpatch fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/cmd646.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index a68357c1c5..20f1e41d57 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -96,7 +96,7 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr,
         return ((uint64_t)1 << (size * 8)) - 1;
     }
 
-    switch(addr & 3) {
+    switch (addr & 3) {
     case 0:
         val = bm->cmd;
         break;
@@ -133,7 +133,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
     }
 
     trace_bmdma_write_cmd646(addr, val);
-    switch(addr & 3) {
+    switch (addr & 3) {
     case 0:
         bmdma_cmd_writeb(bm, val);
         break;
@@ -144,7 +144,8 @@ static void bmdma_write(void *opaque, hwaddr addr,
         cmd646_update_irq(pci_dev);
         break;
     case 2:
-        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+        bm->status = (val & 0x60) | (bm->status & 1) |
+                     (bm->status & ~val & 0x06);
         break;
     case 3:
         if (bm == &bm->pci_dev->bmdma[0]) {
@@ -167,7 +168,7 @@ static void bmdma_setup_bar(PCIIDEState *d)
     int i;
 
     memory_region_init(&d->bmdma_bar, OBJECT(d), "cmd646-bmdma", 16);
-    for(i = 0;i < 2; i++) {
+    for (i = 0; i < 2; i++) {
         bm = &d->bmdma[i];
         memory_region_init_io(&bm->extra_io, OBJECT(d), &cmd646_bmdma_ops, bm,
                               "cmd646-bmdma-bus", 4);
@@ -255,7 +256,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
 
     pci_conf[PCI_CLASS_PROG] = 0x8f;
 
-    pci_conf[CNTRL] = CNTRL_EN_CH0; // enable IDE0
+    pci_conf[CNTRL] = CNTRL_EN_CH0; /* enable IDE0 */
     if (d->secondary) {
         /* XXX: if not enabled, really disable the seconday IDE controller */
         pci_conf[CNTRL] |= CNTRL_EN_CH1; /* enable IDE1 */
@@ -289,7 +290,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
 
     /* TODO: RST# value should be 0 */
-    pci_conf[PCI_INTERRUPT_PIN] = 0x01; // interrupt on pin 1
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt on pin 1 */
 
     qdev_init_gpio_in(ds, cmd646_set_irq, 2);
     for (i = 0; i < 2; i++) {
-- 
2.30.2


