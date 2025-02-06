Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA3A2A971
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 14:16:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1j1-0007Rc-1E; Thu, 06 Feb 2025 08:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1ic-00078Z-JG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1ib-0000CS-0e
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738847695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgtGN4QsOF8XaCWgrj+kwMaZMtpQDiettMvYvUpXuRc=;
 b=EmFaYhTya/sNPaVspNYPPOkSQjv3m3fBuslngx4ndKWCdmpfKwtoifgp66TXA1RMsceHs7
 Gb8czs4ejER+JeDsC5EdvmsH+3IF4ID9fkkFuX4jaT/3XzzBLpAYiRYyLn8Pi3cvbLaP5y
 M9ubPuZ10lmENNdmMzP3khFPj00Br9g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-XEtgE_wYOWSqTepMQL5upA-1; Thu,
 06 Feb 2025 08:14:54 -0500
X-MC-Unique: XEtgE_wYOWSqTepMQL5upA-1
X-Mimecast-MFC-AGG-ID: XEtgE_wYOWSqTepMQL5upA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AE2B1800874
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2025 13:14:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D1D830001AB; Thu,  6 Feb 2025 13:14:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 5/7] vfio: Improve error reporting when MMIO region mapping
 fails
Date: Thu,  6 Feb 2025 14:14:33 +0100
Message-ID: <20250206131438.1505542-6-clg@redhat.com>
In-Reply-To: <20250206131438.1505542-1-clg@redhat.com>
References: <20250206131438.1505542-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When the IOMMU address space width is smaller than the physical
address width, a MMIO region of a device can fail to map because the
region is outside the supported IOVA ranges of the VM. In this case,
PCI peer-to-peer transactions on BARs are not supported. This can
occur with the 39-bit IOMMU address space width, as can be the case on
some Intel consumer processors, or when using a vIOMMU device with
default settings.

The current error message is unclear, improve it and also change the
error report to a warning because it is a non fatal condition for the
VM. To prevent excessive log messages, restrict these recurring DMA
mapping errors to a single warning at runtime.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 62af1216fc5a9089fc718c2afe3a405d9381db32..4fca4c6166f761acceb7b57b52e379603ea53876 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -555,6 +555,18 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
+{
+    /*
+     * MMIO region mapping failures are not fatal but in this case PCI
+     * peer-to-peer transactions are broken.
+     */
+    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        error_append_hint(errp, "%s: PCI peer-to-peer transactions "
+                          "on BARs are not supported.\n", vbasedev->name);
+    }
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -670,7 +682,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
                    strerror(-ret));
         if (memory_region_is_ram_device(section->mr)) {
             /* Allow unexpected mappings not to be fatal for RAM devices */
-            error_report_err(err);
+            VFIODevice *vbasedev =
+                vfio_get_vfio_device(memory_region_owner(section->mr));
+            vfio_device_error_append(vbasedev, &err);
+            warn_report_err_once(err);
             return;
         }
         goto fail;
-- 
2.48.1


