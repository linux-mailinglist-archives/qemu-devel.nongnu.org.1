Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6FA44F4B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 22:54:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn2rZ-00085P-Ro; Tue, 25 Feb 2025 16:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tn2rW-00084U-UC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tn2rV-0006Tm-CB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740520388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTtuhwimcKqz9Odxd4C4v3D31RvzvNQhyYgN69Yc2p8=;
 b=M3vx48xaJgCF+/vW17YwYyy2vxMiNw2daCP2cVsPJk/2c3n9iU7cXuYlzkC7yy1hH0lSoh
 /O4Lf+A7Qamc2+GDMp/e8PtYj5YVBkREyC92fJTEz+RCJxKmurGZtqX86nFZZSezOHLVPP
 jnrJgDy8Yf0XwJpKcrlt6tgJp/lzYPU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-CiHBGS-tM8GtpMuztDXByA-1; Tue,
 25 Feb 2025 16:53:05 -0500
X-MC-Unique: CiHBGS-tM8GtpMuztDXByA-1
X-Mimecast-MFC-AGG-ID: CiHBGS-tM8GtpMuztDXByA_1740520384
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C4061800570; Tue, 25 Feb 2025 21:53:04 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.77])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 618023000199; Tue, 25 Feb 2025 21:53:01 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: [PATCH v2 3/5] vfio/pci: Delete local pm_cap
Date: Tue, 25 Feb 2025 14:52:27 -0700
Message-ID: <20250225215237.3314011-4-alex.williamson@redhat.com>
In-Reply-To: <20250225215237.3314011-1-alex.williamson@redhat.com>
References: <20250225215237.3314011-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is now redundant to PCIDevice.pm_cap.

Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c | 9 ++++-----
 hw/vfio/pci.h | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1a4a0b4b15b4..eab8974e9b48 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2215,7 +2215,6 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
         break;
     case PCI_CAP_ID_PM:
         vfio_check_pm_reset(vdev, pos);
-        vdev->pm_cap = pos;
         ret = pci_pm_init(pdev, pos, errp) >= 0;
         /*
          * PCI-core config space emulation needs write access to the power
@@ -2412,17 +2411,17 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
     vfio_disable_interrupts(vdev);
 
     /* Make sure the device is in D0 */
-    if (vdev->pm_cap) {
+    if (pdev->pm_cap) {
         uint16_t pmcsr;
         uint8_t state;
 
-        pmcsr = vfio_pci_read_config(pdev, vdev->pm_cap + PCI_PM_CTRL, 2);
+        pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
         state = pmcsr & PCI_PM_CTRL_STATE_MASK;
         if (state) {
             pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
-            vfio_pci_write_config(pdev, vdev->pm_cap + PCI_PM_CTRL, pmcsr, 2);
+            vfio_pci_write_config(pdev, pdev->pm_cap + PCI_PM_CTRL, pmcsr, 2);
             /* vfio handles the necessary delay here */
-            pmcsr = vfio_pci_read_config(pdev, vdev->pm_cap + PCI_PM_CTRL, 2);
+            pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
             state = pmcsr & PCI_PM_CTRL_STATE_MASK;
             if (state) {
                 error_report("vfio: Unable to power on device, stuck in D%d",
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c166680abb..d638c781f6f1 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -160,7 +160,6 @@ struct VFIOPCIDevice {
     int32_t bootindex;
     uint32_t igd_gms;
     OffAutoPCIBAR msix_relo;
-    uint8_t pm_cap;
     uint8_t nv_gpudirect_clique;
     bool pci_aer;
     bool req_enabled;
-- 
2.48.1


