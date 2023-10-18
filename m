Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F67CD89D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38N-0001Dp-0S; Wed, 18 Oct 2023 05:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt381-0000V6-Af
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37x-0003UD-8V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qw04L3rz4xbh;
 Wed, 18 Oct 2023 20:46:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qvy3dvtz4xbC;
 Wed, 18 Oct 2023 20:46:06 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/22] vfio/common: Move VFIO reset handler registration to a
 group agnostic function
Date: Wed, 18 Oct 2023 11:45:20 +0200
Message-ID: <20231018094531.733211-12-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Move the reset handler registration/unregistration to a place that is not
group specific. vfio_[get/put]_address_space are the best places for that
purpose.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 56cfe94d97779b539dbb15d88f2968c377d16bae..019da387d239cd005ab38577a68f35a013c98587 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1909,6 +1909,10 @@ static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
     space->as = as;
     QLIST_INIT(&space->containers);
 
+    if (QLIST_EMPTY(&vfio_address_spaces)) {
+        qemu_register_reset(vfio_reset_handler, NULL);
+    }
+
     QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
 
     return space;
@@ -1920,6 +1924,9 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
         QLIST_REMOVE(space, list);
         g_free(space);
     }
+    if (QLIST_EMPTY(&vfio_address_spaces)) {
+        qemu_unregister_reset(vfio_reset_handler, NULL);
+    }
 }
 
 /*
@@ -2385,10 +2392,6 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
         goto close_fd_exit;
     }
 
-    if (QLIST_EMPTY(&vfio_group_list)) {
-        qemu_register_reset(vfio_reset_handler, NULL);
-    }
-
     QLIST_INSERT_HEAD(&vfio_group_list, group, next);
 
     return group;
@@ -2417,10 +2420,6 @@ static void vfio_put_group(VFIOGroup *group)
     trace_vfio_put_group(group->fd);
     close(group->fd);
     g_free(group);
-
-    if (QLIST_EMPTY(&vfio_group_list)) {
-        qemu_unregister_reset(vfio_reset_handler, NULL);
-    }
 }
 
 struct vfio_device_info *vfio_get_device_info(int fd)
-- 
2.41.0


