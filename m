Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31C79E81E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgP4z-0006I1-PK; Wed, 13 Sep 2023 08:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qgP4y-0006Gg-In
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qgP4w-0005HE-Aj
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694608484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XVw4GRxatcpQqAJGImKIhxIW8psWIf1dgl4ffg5nHtY=;
 b=N67q0yvNFQH1p/MI3wkNGYcRlVdl7EI0jBn2xrz/rhqWlVZO3TOAZmHUYFFu+fJBsq8VZ4
 uJPZEP53AUI6Q4sbmXI7j/uOa8HEWQdoHS6D3wtnZUR8pkBmpPUBdZnB45BBiSjDiFu8Td
 ff0UIdiZcNu9mZDne3tb7gZC9l+cb5g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-OZlGsEwZPJ2whcvfa2HdsQ-1; Wed, 13 Sep 2023 08:34:41 -0400
X-MC-Unique: OZlGsEwZPJ2whcvfa2HdsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5968993F354;
 Wed, 13 Sep 2023 12:34:13 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18B0F40C6EC0;
 Wed, 13 Sep 2023 12:34:10 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Yang <leiyang@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, yama@redhat.com,
 Hawkins Jiawei <yin31149@gmail.com>, Cindy Lu <lulu@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Dragos Tatulea <dtatulea@nvidia.com>, si-wei.liu@oracle.com,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
Date: Wed, 13 Sep 2023 14:34:08 +0200
Message-Id: <20230913123408.2819185-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Not zeroing it causes a SIGSEGV if the live migration is cancelled, at
net device restart.

This is caused because CVQ tries to reuse the iova_tree that is present
in the first vhost_vdpa device at the end of vhost_vdpa_net_cvq_start.
As a consequence, it tries to access an iova_tree that has been already
free.

Fixes: 00ef422e9fbf ("vdpa net: move iova tree creation from init to start")
Reported-by: Yanhui Ma <yama@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 34202ca009..1714ff4b11 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -385,6 +385,8 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
     dev = s->vhost_vdpa.dev;
     if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
         g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_delete);
+    } else {
+        s->vhost_vdpa.iova_tree = NULL;
     }
 }
 
-- 
2.39.3


