Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 280198C76D5
	for <lists+qemu-devel@lfdr.de>; Thu, 16 May 2024 14:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7aWH-0002xq-4v; Thu, 16 May 2024 08:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7aW0-0002ts-Pb
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7aVy-0001B2-FN
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715863637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PeASChGSSb0eRZptzkBSV5qpyEVJThv7BUKELIJ9ECA=;
 b=dFEBK7V6Pax7leX+fQlBleMuZzk771fX0+BHNzIF65GS94Qed7rrmS9KGtrfz8rX3WcG5n
 8MyxMIYBYE8fjcQBnEUp8M0C/4BlHNLHUCdBn9PjV/LxXXappFYqD7Jtd3xbFS4nil52i7
 LKMdhAObRwc1Gpm1dTIbIdR5osSPcfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-NIqrviK_OFmL7OoPcvjETg-1; Thu, 16 May 2024 08:47:13 -0400
X-MC-Unique: NIqrviK_OFmL7OoPcvjETg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8DE58016FF;
 Thu, 16 May 2024 12:47:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1007200B3A1;
 Thu, 16 May 2024 12:47:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 2/9] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
Date: Thu, 16 May 2024 14:46:51 +0200
Message-ID: <20240516124658.850504-3-clg@redhat.com>
In-Reply-To: <20240516124658.850504-1-clg@redhat.com>
References: <20240516124658.850504-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

This allows to update the Error argument of the VFIO log_global_start()
handler. Errors for container based logging will also be propagated to
qemu_savevm_state_setup() when the ram save_setup() handler is executed.
Also, errors from vfio_container_set_dirty_page_tracking() are now
collected and reported.

The vfio_set_migration_error() call becomes redundant in
vfio_listener_log_global_start(). Remove it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v7:

 - Commit log improvements (Eric)
 
 hw/vfio/common.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 485e53916491f1164d29e739fb7106c0c77df737..b5102f54a6474a50c6366e8fbce23812d55e384e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1027,7 +1027,8 @@ static void vfio_device_feature_dma_logging_start_destroy(
     g_free(feature);
 }
 
-static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
+static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
+                                          Error **errp)
 {
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
@@ -1038,6 +1039,7 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
     feature = vfio_device_feature_dma_logging_start_create(bcontainer,
                                                            &ranges);
     if (!feature) {
+        error_setg_errno(errp, errno, "Failed to prepare DMA logging");
         return -errno;
     }
 
@@ -1049,8 +1051,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
         ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
         if (ret) {
             ret = -errno;
-            error_report("%s: Failed to start DMA logging, err %d (%s)",
-                         vbasedev->name, ret, strerror(errno));
+            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
+                             vbasedev->name);
             goto out;
         }
         vbasedev->dirty_tracking = true;
@@ -1069,20 +1071,19 @@ out:
 static bool vfio_listener_log_global_start(MemoryListener *listener,
                                            Error **errp)
 {
+    ERRP_GUARD();
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
     int ret;
 
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
-        ret = vfio_devices_dma_logging_start(bcontainer);
+        ret = vfio_devices_dma_logging_start(bcontainer, errp);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
     }
 
     if (ret) {
-        error_report("vfio: Could not start dirty page tracking, err: %d (%s)",
-                     ret, strerror(-ret));
-        vfio_set_migration_error(ret);
+        error_prepend(errp, "vfio: Could not start dirty page tracking - ");
     }
     return !ret;
 }
@@ -1091,17 +1092,20 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    Error *local_err = NULL;
     int ret = 0;
 
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
         vfio_devices_dma_logging_stop(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
+                                                     &local_err);
     }
 
     if (ret) {
-        error_report("vfio: Could not stop dirty page tracking, err: %d (%s)",
-                     ret, strerror(-ret));
+        error_prepend(&local_err,
+                      "vfio: Could not stop dirty page tracking - ");
+        error_report_err(local_err);
         vfio_set_migration_error(ret);
     }
 }
-- 
2.45.0


