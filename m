Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D26FA9C23A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 10:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Eis-0002sW-9W; Fri, 25 Apr 2025 04:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Eip-0002rV-I6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Eim-0003EQ-Fe
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cxLXqQWGxONyUm7QCDXODzWCXomUnP/zkxG1RLXQw0=;
 b=drNVJDjGa/L5btoe9ftvVymWvDRtCc8RxIybVoZGIywd/6Cj8fXRnqZrIgZelsdsJ8mOmg
 mIlVV2rKWHAGPASJIO6s5irBOvnIYrWA/2bj8XIqAy6s1+Y1Xtbk5TEbTNigi+nc/KbfG3
 CFG4qwrUXuvgf2ZbugxolCllVLegcbQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-Z8SBxffyOLKKa2Zsql1lAQ-1; Fri,
 25 Apr 2025 04:47:37 -0400
X-MC-Unique: Z8SBxffyOLKKa2Zsql1lAQ-1
X-Mimecast-MFC-AGG-ID: Z8SBxffyOLKKa2Zsql1lAQ_1745570856
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85D1F1800877; Fri, 25 Apr 2025 08:47:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93BAE30001A2; Fri, 25 Apr 2025 08:47:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 13/50] vfio: Move VFIOHostDMAWindow definition into spapr.c
Date: Fri, 25 Apr 2025 10:46:06 +0200
Message-ID: <20250425084644.102196-14-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

VFIOHostDMAWindow is only used in file "spapr.c". Move it there.

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-9-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-10-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 7 -------
 hw/vfio/spapr.c               | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 528eafadf9f2886d567584c45cc3fc749ef8ddd7..83b1f7be805998c00f02d5b264a4171b51c1d55c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -69,13 +69,6 @@ typedef struct VFIOContainer {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
 
-typedef struct VFIOHostDMAWindow {
-    hwaddr min_iova;
-    hwaddr max_iova;
-    uint64_t iova_pgsizes;
-    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
-} VFIOHostDMAWindow;
-
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
 typedef struct VFIOIOASHwpt {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 7e5cb95f6a48ff87a0fddd62f9c3c297b790049d..f21955a3442b956bdcb2964b0042a12e2ac8a03d 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -22,6 +22,13 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+typedef struct VFIOHostDMAWindow {
+    hwaddr min_iova;
+    hwaddr max_iova;
+    uint64_t iova_pgsizes;
+    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
+} VFIOHostDMAWindow;
+
 typedef struct VFIOSpaprContainer {
     VFIOContainer container;
     MemoryListener prereg_listener;
-- 
2.49.0


