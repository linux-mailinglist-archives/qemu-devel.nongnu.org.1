Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2970D556
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MX3-0002i2-Rc; Tue, 23 May 2023 03:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWz-0002PP-7n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWx-0004JM-BU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2SVbg8Fse81c0Z/JWWiObGm3CoQ9K/k4epLAU8RkkA=;
 b=YbFrHDn5HApHuWpPl6cBqoXkFbE7GmpKaWh8xaxwg9tIl5ctVdKxg3wRWcnxcHFZoeucNb
 7+1IchqbIQDBSEqs0i4i6dQ029SLSKl1rMXYL0XPiiFW/6M5OLHRqJBFR4hB/mXPNvGacu
 R6UOIutfFm1UjhoE8TFQ2/umue/2cWc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-qQhcJ0D8ODmBA3xQOoiXQw-1; Tue, 23 May 2023 03:34:01 -0400
X-MC-Unique: qQhcJ0D8ODmBA3xQOoiXQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAD7C3C0C887;
 Tue, 23 May 2023 07:34:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AB292166B26;
 Tue, 23 May 2023 07:33:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 26/50] igb: Share common VF constants
Date: Tue, 23 May 2023 15:32:14 +0800
Message-Id: <20230523073238.54236-27-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The constants need to be consistent between the PF and VF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb.c        | 10 +++++-----
 hw/net/igb_common.h |  8 ++++++++
 hw/net/igbvf.c      |  7 -------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index 51a7e91..1c989d7 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -433,16 +433,16 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_ari_init(pci_dev, 0x150, 1);
 
-    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, "igbvf",
+    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
         IGB_VF_OFFSET, IGB_VF_STRIDE);
 
-    pcie_sriov_pf_init_vf_bar(pci_dev, 0,
+    pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
-        16 * KiB);
-    pcie_sriov_pf_init_vf_bar(pci_dev, 3,
+        IGBVF_MMIO_SIZE);
+    pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MSIX_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
-        16 * KiB);
+        IGBVF_MSIX_SIZE);
 
     igb_init_net_peer(s, pci_dev, macaddr);
 
diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index 69ac490..f2a9065 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -28,6 +28,14 @@
 
 #include "igb_regs.h"
 
+#define TYPE_IGBVF "igbvf"
+
+#define IGBVF_MMIO_BAR_IDX  (0)
+#define IGBVF_MSIX_BAR_IDX  (3)
+
+#define IGBVF_MMIO_SIZE     (16 * 1024)
+#define IGBVF_MSIX_SIZE     (16 * 1024)
+
 #define defreg(x) x = (E1000_##x >> 2)
 #define defreg_indexed(x, i) x##i = (E1000_##x(i) >> 2)
 #define defreg_indexeda(x, i) x##i##_A = (E1000_##x##_A(i) >> 2)
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 70beb7a..284ea61 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -50,15 +50,8 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-#define TYPE_IGBVF "igbvf"
 OBJECT_DECLARE_SIMPLE_TYPE(IgbVfState, IGBVF)
 
-#define IGBVF_MMIO_BAR_IDX  (0)
-#define IGBVF_MSIX_BAR_IDX  (3)
-
-#define IGBVF_MMIO_SIZE     (16 * 1024)
-#define IGBVF_MSIX_SIZE     (16 * 1024)
-
 struct IgbVfState {
     PCIDevice parent_obj;
 
-- 
2.7.4


