Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F715A971DB
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 18:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G6N-00083x-1C; Tue, 22 Apr 2025 12:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5I-0006pZ-An
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5G-0004zx-9x
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Q0Z0CL8QF5QlkxY7j++h4LnzFHI7LHtzWuUVvrkmqE=;
 b=dBxB5p0BM4/HgMAVWlxjJy4ZW3RmGsL9MOiQ/djFg9NU2Y3FuZ51ZuZcu4X9FMzlxLyBuR
 fh9XZIR+DvVwqYuY9gFDjJyDRDi73ZOYK2uP/G46tQknQSEwBRbwJVXoU1HH+a7LZV/hX1
 TFiUPrcRGT6NnnjTuMz2k6iKv1/HDtQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-iF3inhvoOP-I_o7TCeThPw-1; Tue,
 22 Apr 2025 12:02:50 -0400
X-MC-Unique: iF3inhvoOP-I_o7TCeThPw-1
X-Mimecast-MFC-AGG-ID: iF3inhvoOP-I_o7TCeThPw_1745337769
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E162180087B; Tue, 22 Apr 2025 16:02:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D798618001DD; Tue, 22 Apr 2025 16:02:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 05/37] vfio: Make vfio_viommu_preset() static
Date: Tue, 22 Apr 2025 18:01:52 +0200
Message-ID: <20250422160224.199714-6-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

This routine is only used in file "migration.c". Move it there.

Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-6-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-6-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 1 -
 hw/vfio/common.c              | 5 -----
 hw/vfio/migration.c           | 5 +++++
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 32b816fa122aee00840c70d2e208310a845ad831..8bb206d755adab4efee32a173c920d9aa4833685 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -290,7 +290,6 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-bool vfio_viommu_preset(VFIODevice *vbasedev);
 void vfio_migration_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f78fff41639b83b82eeadf4e40b7ca2cf6bd64dd..a4ec60e018df7dc9bbbeac27120907b0f7bf2f83 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -66,11 +66,6 @@ int vfio_kvm_device_fd = -1;
  */
 
 
-bool vfio_viommu_preset(VFIODevice *vbasedev)
-{
-    return vbasedev->bcontainer->space->as != &address_space_memory;
-}
-
 bool vfio_device_state_is_running(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index db2525fcb926bd228ae2d4dca5eeb2de28041660..96d294794bc3056baa3b0b4e23488402db5de797 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1141,6 +1141,11 @@ bool vfio_migration_active(void)
     return true;
 }
 
+static bool vfio_viommu_preset(VFIODevice *vbasedev)
+{
+    return vbasedev->bcontainer->space->as != &address_space_memory;
+}
+
 /*
  * Return true when either migration initialized or blocker registered.
  * Currently only return false when adding blocker fails which will
-- 
2.49.0


