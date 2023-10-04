Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E447B8414
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:47:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo44j-00072y-GK; Wed, 04 Oct 2023 11:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo44h-00072L-Dl
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo44c-0006js-LM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696434366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Byv+IlEVz1nwlsFs4D0Lg2VE0zwZKtxjj8ChQsStrNc=;
 b=O7JSqRL3COp+3JLMrZRCO7Up2ACMy+E7qhqkfGiBJO1yKebzaP0BNx7APRhWjfeAywVgnV
 1cMxjljH0kulX6JEuffhcObzaguWjRNHhIwOgQ0QLhyDWGrK2/jmFUDXwmeK7unkRWv1zy
 Qc8F9HAoP9unffOv3iWnYaCe960gqaw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-axbnQDNAO-64hNskoQwk8Q-1; Wed, 04 Oct 2023 11:46:02 -0400
X-MC-Unique: axbnQDNAO-64hNskoQwk8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 420552825E8D;
 Wed,  4 Oct 2023 15:46:01 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A58640C6EC0;
 Wed,  4 Oct 2023 15:45:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
Subject: [PATCH v4 11/15] vfio/common: Move VFIO reset handler registration to
 a group agnostic function
Date: Wed,  4 Oct 2023 17:43:58 +0200
Message-ID: <20231004154518.334760-12-eric.auger@redhat.com>
In-Reply-To: <20231004154518.334760-1-eric.auger@redhat.com>
References: <20231004154518.334760-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Move the reset handler registration/unregistration to a place that is not
group specific. vfio_[get/put]_address_space are the best places for that
purpose.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 56cfe94d97..019da387d2 100644
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


