Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E3A711C2
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Mar 2025 08:58:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLaq-0003cw-E9; Wed, 26 Mar 2025 03:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZq-0001lp-8k
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZo-0006Ma-9p
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMaTOPOFZ0gMWzIT7PkD6Nk+9uA8rHmJ3KckpsI7+8M=;
 b=P1sG03qTLf6qmYt1aE4zSJSSexgpO+WKE6owlc8EcKuBkREWmG6aucdSggxSdBLbIQ/zQH
 nhD8EjttFUlZ1iowYDI6HXKimZndB9tK++yzKmucx5XCtrPHi0vJWJBLfV0Y4ZgW/nDuYx
 OunsosTnPqseCd8dL64Va9X0yl4Y51s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-ETUviCZIPNK2jLizGqFvvQ-1; Wed,
 26 Mar 2025 03:53:22 -0400
X-MC-Unique: ETUviCZIPNK2jLizGqFvvQ-1
X-Mimecast-MFC-AGG-ID: ETUviCZIPNK2jLizGqFvvQ_1742975601
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64E6E195606E; Wed, 26 Mar 2025 07:53:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDD5C19560AB; Wed, 26 Mar 2025 07:53:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 29/37] vfio: Rename
 vfio_devices_all_dirty_tracking_started()
Date: Wed, 26 Mar 2025 08:51:14 +0100
Message-ID: <20250326075122.1299361-30-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Also rename vfio_devices_all_device_dirty_tracking_started() while at
it and use the prefix 'vfio_container_devices_' for routines simply
looping over the container's device list.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 3 ++-
 hw/vfio/common.c                      | 2 +-
 hw/vfio/container-base.c              | 6 +++---
 hw/vfio/container.c                   | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 04c87fe48bed75aa281a13f75a36e345036a9163..d00db365991aabf7fdee0c9306197920d9524ed8 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -89,7 +89,8 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp);
-bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
+bool vfio_container_dirty_tracking_is_started(
+    const VFIOContainerBase *bcontainer);
 bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 85dedcbe5933c55c6fc25015d3701aba43b381a4..fae8756ade1f85c29a8567adef87135ee111baba 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -56,7 +56,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
+    if (!vfio_container_dirty_tracking_is_started(bcontainer)) {
         return false;
     }
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 7f11aad339e713ea09123f361425370d87762950..7121f68464b144bc397a3bccc36743b65232273c 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -141,7 +141,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static bool vfio_devices_all_device_dirty_tracking_started(
+static bool vfio_container_devices_dirty_tracking_is_started(
     const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
@@ -155,10 +155,10 @@ static bool vfio_devices_all_device_dirty_tracking_started(
     return true;
 }
 
-bool vfio_devices_all_dirty_tracking_started(
+bool vfio_container_dirty_tracking_is_started(
     const VFIOContainerBase *bcontainer)
 {
-    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+    return vfio_container_devices_dirty_tracking_is_started(bcontainer) ||
            bcontainer->dirty_pages_started;
 }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7436388a73a424b11e6bad9ce80b86c3792242dd..e827ae9167b780ec9776ab98974245defb57590d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -137,7 +137,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
+    if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
-- 
2.49.0


