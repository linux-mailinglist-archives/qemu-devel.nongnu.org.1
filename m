Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C52580B8D3
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:09:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5M-0005Oa-IX; Sat, 09 Dec 2023 23:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5B-0005Ml-Hi
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:29 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB56-00059Y-O4
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:19 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d075392ff6so25769155ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181175; x=1702785975;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PMYE3gFZYG33ULh4f7oSSVrAfsSD9fKgnhB0lKiY5bU=;
 b=We3s4uIFsjX06VuPuPbiRb3NBjTtMzyMRFnAm02NdJY9qFFXAzkhDaamr1Dw3v/9R5
 b+TbY+m6SIzKDofOpXElxfYh8kkEjWBW4qoPve4hu/iDNvBLVTSO3f/ZORV4EKPjGoWZ
 ePUCRqWljC9dkFE9YhcKxIMnD8phnVMbm/cxGIyHoBxaerPSWJTtrJen2Zu+siy+SVUo
 67Dy1hkaOJI06s636J9RK/y5FJNUvBavOHoE9jVfhSw3VZCmShghqSakKT7UPBsPNYTn
 fsohhDNfExCioergffPEcptPmivZ4ISGHFOIKMnmrYmZVW+LfH7MiCWFMOMJYoHlmjRz
 yl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181175; x=1702785975;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMYE3gFZYG33ULh4f7oSSVrAfsSD9fKgnhB0lKiY5bU=;
 b=GrrNl0s7mtF7hK79jYIMdxdVtbZAMk1wsSGn3XWFJvZKhfFzFelAKqFidPukXaTzXi
 QaVigvBIlwdoIFf+ogM1C3XYK+iX31N7pE4I5Sz+bj0+sLZjLN+rpfBvJIY2o5aFtY8R
 NmJRQQSciwUbMRDWH88BoYPex/Ses86h9nkrYgbEe2jGrQU/EF3umzxXW7ltHek47W91
 NP1N2kqa+teZLrQ7JG7JIKLqIi7vTXPFhUCeGZkWpsK6ACW41LtKFW7ckr06ATwn/2l+
 +jvDKcwKOi6L0U7KWHDLE7V3bamr+lhEHaUuC6HCPbHm+VHncGrUfUxom/7SAWZKDMQG
 CMpA==
X-Gm-Message-State: AOJu0YwKRl+QoG/DDS0FC2N9lSt0ehjCOFsDnwUXIY6jxI9caGawUAP7
 ghqMc0JcEreFY/7SEJLF2Ri4Jg==
X-Google-Smtp-Source: AGHT+IHsqiUmFvG+lXf6ed+k9qiD2IcEYs/C8eelTZiNArIahcS5z/dYMsgOQaO6zeLOURYXYuSp7w==
X-Received: by 2002:a17:902:d4ca:b0:1d0:6ffd:6108 with SMTP id
 o10-20020a170902d4ca00b001d06ffd6108mr3627335plg.42.1702181175289; 
 Sat, 09 Dec 2023 20:06:15 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 n2-20020a170902d2c200b001bf044dc1a6sm4103999plc.39.2023.12.09.20.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:44 +0900
Subject: [PATCH RFC v2 01/12] hw/pci: Initialize PCI multifunction after
 realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-1-b959e8a6dfaf@daynix.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
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

The device realization code may enable PCI multifunction for SR-IOV.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c49417abb2..4cf31128ba 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -940,8 +940,9 @@ static void pci_init_mask_bridge(PCIDevice *d)
                                PCI_PREF_RANGE_TYPE_MASK);
 }
 
-static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
+static void pci_init_multifunction(PCIDevice *dev, Error **errp)
 {
+    PCIBus *bus = pci_get_bus(dev);
     uint8_t slot = PCI_SLOT(dev->devfn);
     uint8_t func;
 
@@ -1140,7 +1141,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     PCIConfigReadFunc *config_read = pc->config_read;
     PCIConfigWriteFunc *config_write = pc->config_write;
-    Error *local_err = NULL;
     DeviceState *dev = DEVICE(pci_dev);
     PCIBus *bus = pci_get_bus(pci_dev);
     bool is_bridge = IS_PCI_BRIDGE(pci_dev);
@@ -1233,12 +1233,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     if (is_bridge) {
         pci_init_mask_bridge(pci_dev);
     }
-    pci_init_multifunction(bus, pci_dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        do_pci_unregister_device(pci_dev);
-        return NULL;
-    }
 
     if (!config_read)
         config_read = pci_default_read_config;
@@ -2122,6 +2116,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    pci_init_multifunction(pci_dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus

-- 
2.43.0


