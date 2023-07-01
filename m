Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A7744783
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 09:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUcS-0007b9-BE; Sat, 01 Jul 2023 03:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcQ-0007ZQ-8l
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:02:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcO-0000li-Od
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:02:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b801e6ce85so16866125ad.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688194923; x=1690786923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2mzoJtKETatATbk1+/Lk4f6WvlDPSXraYC64PqRpAQ=;
 b=0qP14O4/qof6fYZsfI8PXvNOjFolOAPo1Z5XU5N17C1TzKravC80JFzf+NmQBl+jwH
 jM3c/q3pF1LVkySB2USIK64Oa2Doga3Dbe/30qIj7ylYH+ufJkVIdzPtyc1Ya37rvzps
 k/Gf+qXlKUkaKMbBcYxDFrvrwBkuMef6O2/nARsDwilM5dGR2tVRkwOUIHkylX4SRASV
 hWUczWH1JiKCUOQPfy7tmzx3UA5fjsCn5B6rO6SaIjh90O7CVyd0BxfnXy5r7BT8H0on
 J6VmHgssADYwaIl8jZ9GhcWbhljZYPOR54aHj/zy3F1rQkOvpLPUj9K0zwMxst9TjJp6
 dMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194923; x=1690786923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2mzoJtKETatATbk1+/Lk4f6WvlDPSXraYC64PqRpAQ=;
 b=ZNJ6U4NEoYisxNgOMBqcotq3AUlUAtCYloLzv1lDtESiVgBuaj5UYZzFGZh4LlHMHB
 EnBgTyO7wF6hNQ9Qs13I+c5e6kZOCyFqwRLec6ftY5Vxwxj9ncg9dVVx2uWSra+kCcrp
 Zloethq7pIooDNd+eGhoJN/rB3O2vvMZjwpLYkx3cY6/qlF/NEyKPr69Kqnk7SwIxrrM
 Lc/s5/ExFXU3sfegCP4Z9GOlPjZNSDtkNqx7CcfMfJZwtCzVppIRmExvFueDyNUIkilt
 P0uMLx32R/upOvN8hGQqkFu8HJdU+45KJjtVziPP6JZwjkxA2B1DX3MOrGlAKm8Oscmo
 Wl6Q==
X-Gm-Message-State: ABy/qLY1b1S1U0bc19mTmLCw7gJbSLffFHh83AdCkaEJqy6V6B8aR/dO
 o4c0j4Yhnu/xpTsY7ZI+kZnRqK07yrQkbdVMEEU=
X-Google-Smtp-Source: APBJJlFNPvXGJgruhXipND3fFTGyw7GUw7v/Ke0TKlh7VaT2/WrnOA2z8IewwW2+SsMefhYqOY3llg==
X-Received: by 2002:a17:902:d4ca:b0:1b8:656f:76e7 with SMTP id
 o10-20020a170902d4ca00b001b8656f76e7mr7173201plg.23.1688194923158; 
 Sat, 01 Jul 2023 00:02:03 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jd4-20020a170903260400b001b1920cffdasm5592452plb.204.2023.07.01.00.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jul 2023 00:02:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 4/4] pci: Compare function number and ARI next function number
Date: Sat,  1 Jul 2023 16:01:22 +0900
Message-ID: <20230701070133.24877-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701070133.24877-1-akihiko.odaki@daynix.com>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The function number must be lower than the next function number
advertised with ARI.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e2eb4c3b4a..568665ee42 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2059,6 +2059,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     Error *local_err = NULL;
     bool is_default_rom;
     uint16_t class_id;
+    uint16_t ari;
+    uint16_t nextfn;
 
     /*
      * capped by systemd (see: udev-builtin-net_id.c)
@@ -2121,6 +2123,19 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (pci_is_express(pci_dev)) {
+        ari = pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI);
+        if (ari) {
+            nextfn = (pci_get_long(pci_dev->config + ari + PCI_ARI_CAP) >> 8) & 0xff;
+            if (nextfn && (pci_dev->devfn & 0xff) >= nextfn) {
+                error_setg(errp, "PCI: function number %u is not lower than ARI next function number %u",
+                           pci_dev->devfn & 0xff, nextfn);
+                pci_qdev_unrealize(DEVICE(pci_dev));
+                return;
+            }
+        }
+    }
+
     if (pci_dev->failover_pair_id) {
         if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
             error_setg(errp, "failover primary device must be on "
-- 
2.41.0


