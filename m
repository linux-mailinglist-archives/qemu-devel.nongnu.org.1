Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546297CFD05
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7s-0006qn-MY; Thu, 19 Oct 2023 10:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7q-0006qX-FV
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7p-0000OB-59
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDLdKyNP9No2g22DSvv6irP4xqho45GAssWca3qUyLc=;
 b=R807o3l7FD287/E/VCZDNIOGj4TsNj4qczQCuTJc/LCDMf+TfuJwX7esd3O9TiHdNuaYnO
 Qubo8edQVyxR7eW3OpKyBOjQkRFK86sQoS4CFfCUK4sDSPBKGsWjtKIGrPi0ZQzXydixyw
 JJdkzzt37qRRAikuTMZtNVpauAAS8oA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-WgrF4veDMiWUiv-xOxkXJQ-1; Thu, 19 Oct 2023 10:35:42 -0400
X-MC-Unique: WgrF4veDMiWUiv-xOxkXJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF6363C025C6;
 Thu, 19 Oct 2023 14:35:41 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89502C15BBC;
 Thu, 19 Oct 2023 14:35:39 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, si-wei.liu@oracle.com,
 Gautam Dawar <gdawar@xilinx.com>
Subject: [RFC PATCH 17/18] vdpa: use shadow_data instead of first device
 v->shadow_vqs_enabled
Date: Thu, 19 Oct 2023 16:34:54 +0200
Message-Id: <20231019143455.2377694-18-eperezma@redhat.com>
In-Reply-To: <20231019143455.2377694-1-eperezma@redhat.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Previously we trusted vq_index == 0 will be started first. By the end of
this series this might not be true, so let's check proper shadow_data
for this.
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index bfbe4673af..1f2ef953f6 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -802,7 +802,7 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
         return 0;
     }
 
-    if (v->shadow_vqs_enabled) {
+    if (v->shared->shadow_data) {
         if ((v->acked_features ^ features) == BIT_ULL(VHOST_F_LOG_ALL)) {
             /*
              * QEMU is just trying to enable or disable logging. SVQ handles
@@ -1353,7 +1353,7 @@ static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
                                      struct vhost_log *log)
 {
     struct vhost_vdpa *v = dev->opaque;
-    if (v->shadow_vqs_enabled || !vhost_vdpa_first_dev(dev)) {
+    if (v->shared->shadow_data || !vhost_vdpa_first_dev(dev)) {
         return 0;
     }
 
-- 
2.39.3


