Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328C7982B5
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVFP-00051i-Iu; Fri, 08 Sep 2023 02:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVFB-0004xn-Qe
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVF9-0002lV-N3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694155526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQ+CCrvrEX5mAf2eXi5nlVsMwHKqdv7x1huinOxKLk4=;
 b=HvclQrfV+9+kPa//1VzyFhqMBMkjYh5Wc3IMCOkKek8NF1cWo8KgJFNauv6bhVCAPBFtlk
 C0AmKGpUpXZnel6OBxrzRu8Y3JMq4vJA4md+aLjvEUkTjgj3gM9I+hjfb9NE+gp9Xdv/Ii
 dX8P0X/iFw+3MKNCne/EYCFadsD5uDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-iVnqrkwfNYmudskOAfJUqA-1; Fri, 08 Sep 2023 02:45:21 -0400
X-MC-Unique: iVnqrkwfNYmudskOAfJUqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89428030A9;
 Fri,  8 Sep 2023 06:45:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBD711121314;
 Fri,  8 Sep 2023 06:45:18 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/17] virtio-net: Add USO flags to vhost support.
Date: Fri,  8 Sep 2023 14:44:53 +0800
Message-Id: <20230908064507.14596-4-jasowang@redhat.com>
In-Reply-To: <20230908064507.14596-1-jasowang@redhat.com>
References: <20230908064507.14596-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

From: Andrew Melnychenko <andrew@daynix.com>

New features are subject to check with vhost-user and vdpa.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vhost_net.c | 3 +++
 net/vhost-vdpa.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b958d6..57427a3 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -78,6 +78,9 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_RESET,
     VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_GUEST_USO4,
+    VIRTIO_NET_F_GUEST_USO6,
+    VIRTIO_NET_F_HOST_USO,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306..1dca37a 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -75,11 +75,14 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_GUEST_TSO4,
     VIRTIO_NET_F_GUEST_TSO6,
     VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_GUEST_USO4,
+    VIRTIO_NET_F_GUEST_USO6,
     VIRTIO_NET_F_HASH_REPORT,
     VIRTIO_NET_F_HOST_ECN,
     VIRTIO_NET_F_HOST_TSO4,
     VIRTIO_NET_F_HOST_TSO6,
     VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_HOST_USO,
     VIRTIO_NET_F_MQ,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
-- 
2.7.4


