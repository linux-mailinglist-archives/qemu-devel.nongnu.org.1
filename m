Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8363AA9C268
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 10:56:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EjP-00032K-9W; Fri, 25 Apr 2025 04:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ej2-00031D-Ei
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ej0-0003Fi-8Y
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1kju0YE1jFBrB2+SQ2vQoITxBXZYdxdIEJVgGH5MOk=;
 b=fFt0JBzoXJ+Kb4TViwKRY9kltMwH7Xkgpa3SVFF2kp6Ty0bGgsyHtwNuy91pIWxKVgcbOt
 S8V0CsZCWdIlmnL+Sf1jOePdlLTC4aBNVo20mt9Q0JuCYdxVEcGn0Mh9PT2ZmNs9mwUH35
 v2gJXhuWsCDX5aT01PKOCpMMfWl8o6M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-_bMWX7s3PLSSIR7JTtShCQ-1; Fri,
 25 Apr 2025 04:47:54 -0400
X-MC-Unique: _bMWX7s3PLSSIR7JTtShCQ-1
X-Mimecast-MFC-AGG-ID: _bMWX7s3PLSSIR7JTtShCQ_1745570873
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DB891800873; Fri, 25 Apr 2025 08:47:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BB6D30001A2; Fri, 25 Apr 2025 08:47:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 17/50] vfio: Make vfio_group_list static
Date: Fri, 25 Apr 2025 10:46:10 +0200
Message-ID: <20250425084644.102196-18-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

vfio_group_list is only used in file "container.c".

Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-13-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-14-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 2 --
 hw/vfio/container.c           | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bcdbc9de57dd11c2c93252b983ec4e4190a82fe5..d8063494757cf61a3019c321f5c1174099ccd74f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -146,9 +146,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
-typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
-extern VFIOGroupList vfio_group_list;
 extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bda1942662d1da24c3a47db0f4a389a2a0fbec7e..8a216b24b5dea630f3488ace73ecf04a7e7cf735 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -34,7 +34,8 @@
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
 
-VFIOGroupList vfio_group_list =
+typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
+static VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 
 static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
-- 
2.49.0


