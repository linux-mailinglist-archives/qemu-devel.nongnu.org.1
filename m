Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C427492491D
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 22:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOk0S-00060Z-6l; Tue, 02 Jul 2024 16:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzx-0005CP-00
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzv-0001mJ-88
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H7aKbBLrPfQyo8uVQsyzpZUHAgZT+25N0abSYuF1Pc4=;
 b=UmGfEWY5cpK7nZl3xz1J0kS1LGGiex2S+UVVBK1HjPW61iKWN8EqgIxIaVujhaBZR6j3C9
 1dyVWtOo7UcvEbReV+QMkmirkX6RYOK5ADymLFTnOnRmRFmKJE3XPcN2nLdq0/3uXW9DvN
 nxVfC6N2g39/Xtj5pbGoa/LVNit173c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-19BZqHw7MlyamNV7la6RtA-1; Tue, 02 Jul 2024 16:21:05 -0400
X-MC-Unique: 19BZqHw7MlyamNV7la6RtA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256c2a2e8dso31913865e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951663; x=1720556463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7aKbBLrPfQyo8uVQsyzpZUHAgZT+25N0abSYuF1Pc4=;
 b=M+Ynbu32pcfY6SZOZ23P6rgggbSx3YuAAyH7tPyndHOzlacmyfTbi5tZ7o7ALQaKa1
 j0PEXZtD3zAYQgR2xoJWsQUvKjs7Ezp0PLM/2zjzjGCtGWeWhL+QVI2y5ycswNC1tpMK
 YJqWSY/raHAUCzTpe5+N0YSiYpaKXxzWvo2vJAP7ezJCyQeZ7g8JWPlu7NpAk04/AYuT
 tau8xUirY2LhKJS+6hP6W7g/WXUkxZNbVXcgS1tje0Msu+aNQ09XAh8eOtRltV2SpPmz
 rBa0XdJ+lVH6IP8xVjIstmB+7OSyyXgERObaeaB0CczHcLmwHiO3uRUwDySfxrBqYE5c
 w+7g==
X-Gm-Message-State: AOJu0YzvcispGxQBd8yajFMsABhsVHqnFxB5nVWDvIVco8M5C1AYdlD0
 B+ri4J5h++xinZ2m6E2XnoTN62vjfJ9g3VqpnhcxEZn+vcpOIoiaxkg/vgAnAyfl0Q3+1y1cBP1
 iJobFURW2EDStFuoJ/aTjHhxrFrzZ/PUpwkSD7LIV8ZFD8MJ8QVGRcuW0qwIbPNt8HKBwGmjBhG
 w/KW3VgNB+oDszui8h/UyxtIF+PnQG/A==
X-Received: by 2002:a05:600c:5486:b0:425:63c0:db3 with SMTP id
 5b1f17b1804b1-4257a0217f5mr63814165e9.7.1719951663650; 
 Tue, 02 Jul 2024 13:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkihgR9kxVodfP1mC/9sAyuBxC6e5zEWTWJM03Rw4fp6WkHodbBM2pEPiWbwrClhL/HmlcQQ==
X-Received: by 2002:a05:600c:5486:b0:425:63c0:db3 with SMTP id
 5b1f17b1804b1-4257a0217f5mr63813945e9.7.1719951662991; 
 Tue, 02 Jul 2024 13:21:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55aeasm207607625e9.17.2024.07.02.13.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:21:02 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 87/88] pcie_sriov: Register VFs after migration
Message-ID: <42e0ab36dd4c9ae72e1b609929b9c2f7141405f7.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-9-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h | 2 ++
 hw/pci/pci.c                | 7 +++++++
 hw/pci/pcie_sriov.c         | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 5148c5b77d..c5d2d318d3 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
+void pcie_sriov_pf_post_load(PCIDevice *dev);
+
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e32a69f3fa..fa85f87b1c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -733,10 +733,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
     return !pci_is_express((PCIDevice *)opaque);
 }
 
+static int pci_post_load(void *opaque, int version_id)
+{
+    pcie_sriov_pf_post_load(opaque);
+    return 0;
+}
+
 const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index fae6acea4a..56523ab4e8 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -252,6 +252,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     }
 }
 
+void pcie_sriov_pf_post_load(PCIDevice *dev)
+{
+    if (dev->exp.sriov_cap) {
+        register_vfs(dev);
+    }
+}
+
 
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev)
-- 
MST


