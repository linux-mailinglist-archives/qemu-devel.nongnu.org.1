Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D082E72867E
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 19:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7JeW-0001vv-JU; Thu, 08 Jun 2023 13:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q7JeT-0001vF-Op
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 13:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q7JeR-0005y0-VT
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 13:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686246141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u5LgjMB5y4pKshPY30AOVJgIC7lXotxTgBEzhry4ApE=;
 b=Yh/rr9Hd7HMQtqep64gt1G9S7NV9RrNhX2JWGHjuJ9ydm1DYBkouoVl9qsrxmAgidPtjIg
 Oc3AlIrtAVX9alGWU37R156uAYl/3sMPHMbuPo4hznFoqktcXQK2GF3xPmXowAe4u423vF
 TNBsLIq1KG1pO3JZ4QIOLZ+DHoczlXA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-blh3zatsNj6ljOZ1tIkYIQ-1; Thu, 08 Jun 2023 13:42:20 -0400
X-MC-Unique: blh3zatsNj6ljOZ1tIkYIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B06A9801224
 for <qemu-devel@nongnu.org>; Thu,  8 Jun 2023 17:42:19 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.33.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6004A40CF8F6;
 Thu,  8 Jun 2023 17:42:19 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	clg@redhat.com
Subject: [PATCH] hw/vfio/pci-quirks: Support alternate offset for GPUDirect
 Cliques
Date: Thu,  8 Jun 2023 11:42:11 -0600
Message-Id: <20230608174211.3227138-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

NVIDIA Turing and newer GPUs implement the MSI-X capability at the offset
previously reserved for use by hypervisors to implement the GPUDirect
Cliques capability.  A revised specification provides an alternate
location.  Add a config space walk to the quirk to check for conflicts,
allowing us to fall back to the new location or generate an error at the
quirk setup rather than when the real conflicting capability is added
should there be no available location.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

The specification doesn't have a public home, but I've been given
permission to post it to the list.  Therefore I'll reply to this with
the document attached and update the link in a v2 posting once that's
available in the list archive.

 hw/vfio/pci-quirks.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f0147a050aaa..a10e775bbfa7 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1490,6 +1490,9 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
  * +---------------------------------+---------------------------------+
  *
  * https://lists.gnu.org/archive/html/qemu-devel/2017-08/pdfUda5iEpgOS.pdf
+ *
+ * Specification for Turning and later GPU architectures:
+ * <to be filled in for v2 posting>
  */
 static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
@@ -1530,7 +1533,9 @@ const PropertyInfo qdev_prop_nv_gpudirect_clique = {
 static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
-    int ret, pos = 0xC8;
+    int ret, pos;
+    bool c8_conflict = false, d4_conflict = false;
+    uint8_t tmp;
 
     if (vdev->nv_gpudirect_clique == 0xFF) {
         return 0;
@@ -1547,6 +1552,40 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
         return -EINVAL;
     }
 
+    /*
+     * Per the updated specification above, it's recommended to use offset
+     * D4h for Turing and later GPU architectures due to a conflict of the
+     * MSI-X capability at C8h.  We don't know how to determine the GPU
+     * architecture, instead we walk the capability chain to mark conflicts
+     * and choose one or error based on the result.
+     *
+     * NB. Cap list head in pdev->config is already cleared, read from device.
+     */
+    ret = pread(vdev->vbasedev.fd, &tmp, 1,
+                vdev->config_offset + PCI_CAPABILITY_LIST);
+    if (ret != 1 || !tmp) {
+        error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
+        return -EINVAL;
+    }
+
+    do {
+        if (tmp == 0xC8) {
+            c8_conflict = true;
+        } else if (tmp == 0xD4) {
+            d4_conflict = true;
+        }
+        tmp = pdev->config[tmp + PCI_CAP_LIST_NEXT];
+    } while (tmp);
+
+    if (!c8_conflict) {
+        pos = 0xC8;
+    } else if (!d4_conflict) {
+        pos = 0xD4;
+    } else {
+        error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid config space");
+        return -EINVAL;
+    }
+
     ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
     if (ret < 0) {
         error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: ");
-- 
2.39.2


