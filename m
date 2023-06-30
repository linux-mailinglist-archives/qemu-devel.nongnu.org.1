Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED34A7444EF
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 00:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFMjM-00013o-6v; Fri, 30 Jun 2023 18:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qFMjK-00013f-UE
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 18:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qFMjF-0005ZA-Nk
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 18:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688164596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dEyD3iHgilQFlIPg2fAFXZ/xWzZgJDycfhkwmW5Zyx0=;
 b=bYXOR5fM8HdPKr8xysZBB2I0KKZ8CsaForMZ/Z1KiqVqEkz7GIpafFtgy2J9PjdIWMcbzz
 gxd+3J1Px09bTEtm2dCfUDXME1fqM1YNXlFXy3JHPHWouapvhX+jTNLQBp05oKy9S4izGw
 Rusy4JhDc4tJD51vQweE6ABCVW5JEec=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-jBggILtUNJ-g_D3uoDl9fw-1; Fri, 30 Jun 2023 18:36:34 -0400
X-MC-Unique: jBggILtUNJ-g_D3uoDl9fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 089E73C0ED41
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 22:36:34 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.17.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B62602166B2D;
 Fri, 30 Jun 2023 22:36:33 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	clg@redhat.com
Subject: [PATCH] hw/vfio/pci-quirks: Sanitize capability pointer
Date: Fri, 30 Jun 2023 16:36:08 -0600
Message-Id: <20230630223608.650555-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Coverity reports a tained scalar when traversing the capabilities
chain (CID 1516589).  In practice I've never seen a device with a
chain so broken as to cause an issue, but it's also pretty easy to
sanitize.

Fixes: f6b30c1984f7 ("hw/vfio/pci-quirks: Support alternate offset for GPUDirect Cliques")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 0ed2fcd53152..f4ff83680572 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1530,6 +1530,12 @@ const PropertyInfo qdev_prop_nv_gpudirect_clique = {
     .set = set_nv_gpudirect_clique_id,
 };
 
+static bool is_valid_std_cap_offset(uint8_t pos)
+{
+    return (pos >= PCI_STD_HEADER_SIZEOF &&
+            pos <= (PCI_CFG_SPACE_SIZE - PCI_CAP_SIZEOF));
+}
+
 static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -1563,7 +1569,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
      */
     ret = pread(vdev->vbasedev.fd, &tmp, 1,
                 vdev->config_offset + PCI_CAPABILITY_LIST);
-    if (ret != 1 || !tmp) {
+    if (ret != 1 || !is_valid_std_cap_offset(tmp)) {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
         return -EINVAL;
     }
@@ -1575,7 +1581,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
             d4_conflict = true;
         }
         tmp = pdev->config[tmp + PCI_CAP_LIST_NEXT];
-    } while (tmp);
+    } while (is_valid_std_cap_offset(tmp));
 
     if (!c8_conflict) {
         pos = 0xC8;
-- 
2.40.1


