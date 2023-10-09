Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A13347BD672
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:11:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmIJ-0002Vw-2F; Mon, 09 Oct 2023 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qpmI1-0002Qn-W3
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qpmI0-0007hR-AH
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696842659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkBBMFe1LvmqRyuNX+I8XlM36EWj68kFcU/zlnPwIB4=;
 b=itFb9R8UGXMOXLjEL2+40jVp92TqpHpP5tGE2DNmZfAQa59WiRPEgxGoAPI8wHwu/MHzBY
 XTH6/w6YOQCLMPElMOluABwBKan4X8LsoqvSE0j3w+apXO3NQ5s8L6GuO2Fz/Mk8bfN2eY
 krKxTVD8uP1nUWhRT7Pv9yWTHPAe2Rw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-dAAgCCTPNpOs4V3ugpJecw-1; Mon, 09 Oct 2023 05:10:54 -0400
X-MC-Unique: dAAgCCTPNpOs4V3ugpJecw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5444E3800E9D;
 Mon,  9 Oct 2023 09:10:53 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9251A167F8;
 Mon,  9 Oct 2023 09:10:50 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
Subject: [PATCH v5 04/15] vfio/common: Propagate KVM_SET_DEVICE_ATTR error if
 any
Date: Mon,  9 Oct 2023 11:09:06 +0200
Message-ID: <20231009091035.433329-5-eric.auger@redhat.com>
In-Reply-To: <20231009091035.433329-1-eric.auger@redhat.com>
References: <20231009091035.433329-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

In the VFIO_SPAPR_TCE_v2_IOMMU container case, when
KVM_SET_DEVICE_ATTR fails, we currently don't propagate the
error as we do on the vfio_spapr_create_window() failure
case. Let's align the code. Take the opportunity to
reword the error message and make it more explicit.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

---
---
 hw/vfio/common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4e122fc4e4..c54a72ec80 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -878,11 +878,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
                 QLIST_FOREACH(group, &container->group_list, container_next) {
                     param.groupfd = group->fd;
                     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-                        error_report("vfio: failed to setup fd %d "
-                                     "for a group with fd %d: %s",
-                                     param.tablefd, param.groupfd,
-                                     strerror(errno));
-                        return;
+                        error_setg_errno(&err, errno,
+                                         "vfio: failed GROUP_SET_SPAPR_TCE for "
+                                         "KVM VFIO device %d and group fd %d",
+                                         param.tablefd, param.groupfd);
+                        goto fail;
                     }
                     trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
                 }
-- 
2.41.0


