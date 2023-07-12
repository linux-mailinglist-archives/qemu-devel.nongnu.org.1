Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592C750610
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:29:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJY1I-0000Mc-OK; Wed, 12 Jul 2023 07:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qJY1A-0000KV-Pa
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:28:25 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qJY17-0008JK-4I
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:28:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b9cd6a0051so24759385ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 04:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689161299; x=1691753299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VpKQhHd/VFqWS0RsyM+OoF6OxbyIaaVUjA1go6bYLkg=;
 b=AyL2KliVr83Ud//MoBThU8edExD14H9/UY59x5DbqedP7F8pUmqqQtnESfNORTFHe7
 Qj1UX1cgUl1WCiLb9uFaKpua+SSzASAS+K5vZntV59i+KPjwirRcjuuWULuzWffyPb4m
 2aRsiCDXagzYc73gU9fYSdPOpirhjHfqicAyqKv26pVtixQ0NrvBGgpNsSg8lMsFhU2g
 /geFr8qWNF/NJBbWbD4Younu2kU1ODg8Rocj1xRFA0n9173nPscz3HTkzBW/OFYWn7Cq
 fI/THL8x+9Z3iJuVFapI6hOYjq1xW0L3NaIkPcU69ZGsFKbOpDOaSaSzKEE0m3NCC6Eg
 ysxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689161299; x=1691753299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VpKQhHd/VFqWS0RsyM+OoF6OxbyIaaVUjA1go6bYLkg=;
 b=MgJn/604W2Tiy3teW7Pn8pDklOhxy5EZwySOsSDFNNtCcqLEURW43SXESiNEuxYNPi
 q7EC6hzoN16a8xTttvgeRgBmo8kuGfFCYOiHHt3tU9V+UBCEo+Q6eEBqIFzjsnxUkMUQ
 CDbLD2bjfP0Nmf0knUlA0myvqyEZN5lOB2qHiARg1cdm+rcX6Gqtfem8a1aT3TRikSeV
 NMS1gHcaa3BHhko2dXR/7oYKOqXWQSahRbIM2YVbU3WITql47zFoGG1PEJnRL7OhIuTV
 RUazFI7z5vnC2eKpzmzm+2WroO/6U9wmPfpB/q+kQN3QcfGBLmip8VFcsDUEwiN6YrxN
 xwVw==
X-Gm-Message-State: ABy/qLahmiZ82D3CmvOa55iLMf9abYbONAD4JGrxctysMowgxdB2N6W6
 pezieLd/q7kuUyFba9a02WFldg==
X-Google-Smtp-Source: APBJJlH/ErCiLfMGG06GL9Qljk+pqSvt0BASOkaTP6mL//KoxX4SZvMzfUCcVTvH+V3iRjGMYoR8Yg==
X-Received: by 2002:a17:902:e5ce:b0:1b7:ed6a:d8a5 with SMTP id
 u14-20020a170902e5ce00b001b7ed6ad8a5mr16092149plf.61.1689161298998; 
 Wed, 12 Jul 2023 04:28:18 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 je11-20020a170903264b00b001b85a56597bsm3714766plb.185.2023.07.12.04.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 04:28:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] hw/pci: Warn when ARI/SR-IOV device has non-zero Function
 number
Date: Wed, 12 Jul 2023 20:27:32 +0900
Message-ID: <20230712112732.18617-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

Current SR/IOV implementations assume that hardcoded Function numbers
are always available and will not conflict. It is somewhat non-trivial
to make the Function numbers to use controllable to avoid Function
number conflicts so ensure there is only one PF to make the assumption
hold true.

Also warn when non-SR/IOV multifunction was attempted with ARI enabled;
ARI has the next Function number field register, and currently it's
hardcoded to 0, which prevents non-SR/IOV multifunction. It is
certainly possible to add a logic to determine the correct next Function
number according to the configuration, but it's not worth since all
ARI-capable devices are also SR/IOV devices, which do not support
multiple PFs as stated above.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 59 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 784c02a182..50359a0f3a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2124,23 +2124,48 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
-    /*
-     * A PCIe Downstream Port that do not have ARI Forwarding enabled must
-     * associate only Device 0 with the device attached to the bus
-     * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
-     * sec 7.3.1).
-     * With ARI, PCI_SLOT() can return non-zero value as the traditional
-     * 5-bit Device Number and 3-bit Function Number fields in its associated
-     * Routing IDs, Requester IDs and Completer IDs are interpreted as a
-     * single 8-bit Function Number. Hence, ignore ARI capable devices.
-     */
-    if (pci_is_express(pci_dev) &&
-        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
-        pcie_has_upstream_port(pci_dev) &&
-        PCI_SLOT(pci_dev->devfn)) {
-        warn_report("PCI: slot %d is not valid for %s,"
-                    " parent device only allows plugging into slot 0.",
-                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
+    if (pci_is_express(pci_dev)) {
+        /*
+         * A PCIe Downstream Port that do not have ARI Forwarding enabled must
+         * associate only Device 0 with the device attached to the bus
+         * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
+         * sec 7.3.1).
+         * With ARI, PCI_SLOT() can return non-zero value as the traditional
+         * 5-bit Device Number and 3-bit Function Number fields in its
+         * associated Routing IDs, Requester IDs and Completer IDs are
+         * interpreted as a single 8-bit Function Number. Hence, ignore ARI
+         * capable devices.
+         */
+        if (!pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
+            pcie_has_upstream_port(pci_dev) &&
+            PCI_SLOT(pci_dev->devfn)) {
+            warn_report("PCI: slot %d is not valid for %s,"
+                        " parent device only allows plugging into slot 0.",
+                        PCI_SLOT(pci_dev->devfn), pci_dev->name);
+        }
+
+        /*
+         * Current SR/IOV implementations assume that hardcoded Function numbers
+         * are always available. Ensure there is only one PF to make the
+         * assumption hold true.
+         */
+        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV) &&
+            PCI_FUNC(pci_dev->devfn)) {
+            warn_report("PCI: function %d is not valid for %s,"
+                        " currently PF can only be assigned to function 0.",
+                        PCI_FUNC(pci_dev->devfn), pci_dev->name);
+        }
+
+        /*
+         * ARI has the next Function number field register, and currently it's
+         * hardcoded to 0, which prevents non-SR/IOV multifunction.
+         */
+        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
+            !pci_is_vf(pci_dev) && (pci_dev->devfn & 0xff)) {
+            warn_report("PCI: function %d is not valid for %s,"
+                        " non-SR/IOV multifunction is not supported with ARI enabled.",
+                        pci_dev->devfn & 0xff, pci_dev->name);
+        }
     }
 
     if (pci_dev->failover_pair_id) {
-- 
2.41.0


