Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD69FBF89
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Dec 2024 16:18:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6eL-0007wj-VK; Tue, 24 Dec 2024 10:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6e5-0007Zp-Ir
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6e3-00045m-Sr
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5agplQuD+hZNb/x9xV92EqkAd3qW0GJYnlLX+uqSckg=;
 b=bBKcIc0NKq7fcviEftv+YVLvinWiQgEoafeHspXEm8WHYKIJhUpmtQoYYJ5ubPi1XDq9l8
 eSiIJ85QvEw1xgvV3ua1gRnHf9ppu1MRJAy2+QGcOrgLFlD+Xt+I9ed2t1asHlRZ6FtG5Q
 pUlZx5/04b/xB/l6fjcp3oQdaguYq3E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-3eTSJOs9NTi8aHoT-ua_Xw-1; Tue,
 24 Dec 2024 10:16:22 -0500
X-MC-Unique: 3eTSJOs9NTi8aHoT-ua_Xw-1
X-Mimecast-MFC-AGG-ID: 3eTSJOs9NTi8aHoT-ua_Xw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 806F619560A2; Tue, 24 Dec 2024 15:16:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC8653000197; Tue, 24 Dec 2024 15:16:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/17] vfio/migration: Rename vfio_devices_all_dirty_tracking()
Date: Tue, 24 Dec 2024 16:15:44 +0100
Message-ID: <20241224151547.386529-15-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

vfio_devices_all_dirty_tracking() is used to check if dirty page log
sync is needed. However, besides checking the dirty page tracking
status, it also checks the pre_copy_dirty_page_tracking flag.

Rename it to vfio_devices_log_sync_needed() which reflects its purpose
more accurately and makes the code clearer as there are already several
helpers with similar names.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Tested-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20241218134022.21264-5-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9b5524377ce01a0a982157b314ad60add371bac6..f7499a9b7447a7593198e1523c50858b70a8bd85 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -191,7 +191,7 @@ bool vfio_devices_all_dirty_tracking_started(
            bcontainer->dirty_pages_started;
 }
 
-static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
+static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -1364,7 +1364,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
         return;
     }
 
-    if (vfio_devices_all_dirty_tracking(bcontainer)) {
+    if (vfio_log_sync_needed(bcontainer)) {
         ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
         if (ret) {
             error_report_err(local_err);
-- 
2.47.1


