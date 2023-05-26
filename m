Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C571298D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ZQF-0003pl-2o; Fri, 26 May 2023 11:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q2ZQD-0003pd-7Y
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q2ZQ5-0003MZ-Ig
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685115116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25QPWRUap87P8qT0SKZ7bty4YrGO74WAbW2+RZPm14I=;
 b=e/XlFzyenRepBv6z7Qd9PffAuADxS5RFzWxy4a240O+XIjvqmhO0mZ2KgpEQT1h5JnzmBr
 qpjvSC214HrLQxj4wSI+6qMm8xW3nIwwDW622undHXUCacn3FvJKlBZsv4Hdgt0ySYDyQT
 n1UWUk93IHnPpzF+0uiwEp7GNb4ei00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-Th7Wt7CFMB-pm8froIaVUw-1; Fri, 26 May 2023 11:31:51 -0400
X-MC-Unique: Th7Wt7CFMB-pm8froIaVUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD4EE8015D8;
 Fri, 26 May 2023 15:31:50 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27F3040D1B66;
 Fri, 26 May 2023 15:31:48 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com,
 Shannon Nelson <snelson@pensando.io>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Cindy Lu <lulu@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 Jason Wang <jasowang@redhat.com>, Liuxiangdong <liuxiangdong5@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, alvaro.karsz@solid-run.com,
 Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH v4 1/2] vdpa: return errno in vhost_vdpa_get_vring_group error
Date: Fri, 26 May 2023 17:31:42 +0200
Message-Id: <20230526153143.470745-2-eperezma@redhat.com>
In-Reply-To: <20230526153143.470745-1-eperezma@redhat.com>
References: <20230526153143.470745-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We need to tell in the caller, as some errors are expected in a normal
workflow.  In particular, parent drivers in recent kernels with
VHOST_BACKEND_F_IOTLB_ASID may not support vring groups.  In that case,
-ENOTSUP is returned.

This is the case of vp_vdpa in Linux 6.2.

Next patches in this series will use that information to know if it must
abort or not.  Also, next patches return properly an errp instead of
printing with error_report.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 37cdc84562..3fb833fe76 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -362,6 +362,14 @@ static NetClientInfo net_vhost_vdpa_info = {
         .check_peer_type = vhost_vdpa_check_peer_type,
 };
 
+/**
+ * Get vring virtqueue group
+ *
+ * @device_fd  vdpa device fd
+ * @vq_index   Virtqueue index
+ *
+ * Return -errno in case of error, or vq group if success.
+ */
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index)
 {
     struct vhost_vring_state state = {
@@ -370,6 +378,7 @@ static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index)
     int r = ioctl(device_fd, VHOST_VDPA_GET_VRING_GROUP, &state);
 
     if (unlikely(r < 0)) {
+        r = -errno;
         error_report("Cannot get VQ %u group: %s", vq_index,
                      g_strerror(errno));
         return r;
-- 
2.31.1


