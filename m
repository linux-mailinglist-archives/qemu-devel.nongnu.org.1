Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C25814EC1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 18:30:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEBzT-0005y6-Gm; Fri, 15 Dec 2023 12:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzQ-0005xT-PK
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzP-00011j-Bd
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702661321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiCsDaivPOvgkYPv1nwn65nD5kYXp+LU4DCyQMQzLN4=;
 b=NAKTkDavReJXxJZbooxaZkhlncn+ftGCkX/uq70ixE0/1FNftdjZBANHwmyp9DS89uF+vg
 Kfj3oP7ISJ2kGeDZ0e5NA/gwJP8s7q7B6m3fsTAE2l6D/lmrBllQTRVsEZo8Y15oABZhgp
 iLkvgKcarMetrAomMRrEHKcBwnZezEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-4CJwaGxNPV2hK98ZoeoDpw-1; Fri, 15 Dec 2023 12:28:38 -0500
X-MC-Unique: 4CJwaGxNPV2hK98ZoeoDpw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83D8F101A555;
 Fri, 15 Dec 2023 17:28:37 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC66F40C6EB9;
 Fri, 15 Dec 2023 17:28:35 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH for 9.0 02/12] vdpa: make batch_begin_once early return
Date: Fri, 15 Dec 2023 18:28:20 +0100
Message-Id: <20231215172830.2540987-3-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-1-eperezma@redhat.com>
References: <20231215172830.2540987-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prefer early return so it is easier to merge
vhost_vdpa_listener_begin_batch here and make iotlb baches begin and end
symmetrical.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index cc252fc2d8..bf9771870a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -160,11 +160,12 @@ static void vhost_vdpa_listener_begin_batch(VhostVDPAShared *s)
 
 static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
 {
-    if (s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
-        !s->iotlb_batch_begin_sent) {
-        vhost_vdpa_listener_begin_batch(s);
+    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
+        s->iotlb_batch_begin_sent) {
+        return;
     }
 
+    vhost_vdpa_listener_begin_batch(s);
     s->iotlb_batch_begin_sent = true;
 }
 
-- 
2.39.3


