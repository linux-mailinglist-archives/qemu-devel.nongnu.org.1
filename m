Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3CD75B656
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYBL-0004DK-OV; Thu, 20 Jul 2023 14:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBG-0004CZ-MX
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBE-0003HJ-6r
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8f4eu9n15Kw63ow2RmMKDIC50OvvS8TO7HOPVAUm5P8=;
 b=P5Cw2Xn/NY4MEjCjbIamTtCdJUJEW1Kj0Zofb4VWwaYvo97fcksCxiJ/3f0j+hYt+WciOW
 xB3CgzvbB2fjNvtGcWEG6ZHOjwDZ3oT2UmkJtmZLwNwN0xwEuD8RHKl3WwaYiq3GAORXtg
 RhROBaEmBSizvZ/dlAT6OinY8+MrLc0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-G4igimKGNB6CjPl4WvApKA-1; Thu, 20 Jul 2023 14:15:08 -0400
X-MC-Unique: G4igimKGNB6CjPl4WvApKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 147A32804601;
 Thu, 20 Jul 2023 18:15:08 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6FDA2166B25;
 Thu, 20 Jul 2023 18:15:06 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Subject: [RFC PATCH 03/12] vhost_net: Use ops->vhost_restart_queue in
 vhost_net_virtqueue_restart
Date: Thu, 20 Jul 2023 20:14:50 +0200
Message-Id: <20230720181459.607008-4-eperezma@redhat.com>
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

Actually use vhost_restart_queue operation at restart.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/net/vhost_net.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b958d6363..416b7d8132 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -608,14 +608,16 @@ int vhost_net_virtqueue_restart(VirtIODevice *vdev, NetClientState *nc,
         goto err_start;
     }
 
-    if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
+    if (vhost_ops->vhost_restart_queue) {
+        r = vhost_ops->vhost_restart_queue(&net->dev, idx);
+    } else if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
         file.index = idx;
         file.fd = net->backend;
         r = vhost_net_set_backend(&net->dev, &file);
-        if (r < 0) {
-            r = -errno;
-            goto err_start;
-        }
+    }
+    if (r < 0) {
+        r = -errno;
+        goto err_start;
     }
 
     return 0;
-- 
2.39.3


