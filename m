Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30D75B662
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:16:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYBe-0004L7-8z; Thu, 20 Jul 2023 14:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBJ-0004Dm-QY
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBG-0003I3-O4
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nag6baYm1KG8EZBPsQkKS/2lJrXvwaihqgRRI4ssZX8=;
 b=dhs0iUJbeqFqq/xqo/nOrHKxGPhatKk33+YPRrfQ4AhC6NbnQVuiSHKyEgNjdgPQCy9kvi
 7Fdt0mqthXaXYAJXBeFQIrThwciimpF2x5po08kjZ09MhTBWMCwo9wwTYlJqMD/GBmo6AD
 ehNjp+N2B3mdy/Sq4tab/WfGsshO1HY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-o2SLo1nhMSC3D4TIvPaW6g-1; Thu, 20 Jul 2023 14:15:07 -0400
X-MC-Unique: o2SLo1nhMSC3D4TIvPaW6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79D851C04356;
 Thu, 20 Jul 2023 18:15:06 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28D012166B25;
 Thu, 20 Jul 2023 18:15:05 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Subject: [RFC PATCH 02/12] vhost: add vhost_restart_queue_op
Date: Thu, 20 Jul 2023 20:14:49 +0200
Message-Id: <20230720181459.607008-3-eperezma@redhat.com>
In-Reply-To: <20230720181459.607008-1-eperezma@redhat.com>
References: <20230720181459.607008-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

So different vhost backends can perform custom actions at queue restart.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-backend.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 37e05fa1f9..651402af10 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -135,6 +135,8 @@ typedef void (*vhost_reset_status_op)(struct vhost_dev *dev);
 
 typedef void (*vhost_reset_queue_op)(struct vhost_dev *dev, int idx);
 
+typedef int (*vhost_restart_queue_op)(struct vhost_dev *dev, int idx);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -184,6 +186,7 @@ typedef struct VhostOps {
     vhost_set_config_call_op vhost_set_config_call;
     vhost_reset_status_op vhost_reset_status;
     vhost_reset_queue_op vhost_reset_queue;
+    vhost_restart_queue_op vhost_restart_queue;
 } VhostOps;
 
 int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
-- 
2.39.3


