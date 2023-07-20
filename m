Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3213D75B664
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:16:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYBo-0005I6-49; Thu, 20 Jul 2023 14:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBR-0004Kw-AC
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBP-0003Lr-Nu
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9CKyKCD2Asr59YwlxOKNQ11bPRWkSiQVn9Bq1tQZj4=;
 b=KLn7TfdEvq6fy0GnsWdkHZD2msllcmqxdmQ6GClw8AW9fmLfTobEYM/dyOhnXWKWzb6f5w
 bxUsRL0AfjVrG+9b8lZZlW4rcEwGeak8VtgvFYQfXyM0EqTYavwrQDr79uoM78bUIf+lY0
 PftdPFjZymcvZw6oq0ihLumJBZSFTeM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-qCsMew6hOeqEtO4NXk0sKQ-1; Thu, 20 Jul 2023 14:15:19 -0400
X-MC-Unique: qCsMew6hOeqEtO4NXk0sKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3032F3C01DF3;
 Thu, 20 Jul 2023 18:15:19 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CABA32166B25;
 Thu, 20 Jul 2023 18:15:17 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Subject: [RFC PATCH 10/12] vdpa: enable all vqs if the device support
 RING_RESET feature
Date: Thu, 20 Jul 2023 20:14:57 +0200
Message-Id: <20230720181459.607008-11-eperezma@redhat.com>
In-Reply-To: <20230720181459.607008-1-eperezma@redhat.com>
References: <20230720181459.607008-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

Prefer the ring reset approach against the late enable, as it is more
aligned with the standard.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 52415d7e0c..af83de92f8 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -840,8 +840,14 @@ static const VhostShadowVirtqueueOps vhost_vdpa_net_svq_ops = {
  */
 static bool vhost_vdpa_should_enable(const struct vhost_vdpa *v)
 {
+    VhostVDPAState *s = container_of(v, VhostVDPAState, vhost_vdpa);
     struct vhost_dev *dev = v->dev;
 
+    if (dev->features & VIRTIO_F_RING_RESET && !s->always_svq) {
+        /* Preventing dataplane processing exposing fake SVQ vring */
+        return true;
+    }
+
     if (!dev->vq_index_end % 2) {
         /* vDPA device does not have CVQ */
         return true;
-- 
2.39.3


