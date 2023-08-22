Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B4783C2D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:55:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYN90-0005EN-Qx; Tue, 22 Aug 2023 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN8z-0005EF-M5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN8w-0000dj-NH
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692694422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewp0BEGfM6EEnx38F/+2D1JCX20zKuYl9VPnAZOhv5U=;
 b=BZR8x3JnvfmNkcXfMreiYtiWbtOBaEyTJilfRL9hL1xrjnPlCgPYb3FhKUA8/VlQOZlqr/
 ro2XbuN1YdQA90Tk6rdXpvUBty7fHOdEmTLXrqAVQyuuUMkrFoDXOfuyPXAT5KWmtsrOnD
 +afhvtz0CLc1qXe2m7ciPYmpxXjHZEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-g8YjKZ3kNdCezU7c-8KuSw-1; Tue, 22 Aug 2023 04:53:38 -0400
X-MC-Unique: g8YjKZ3kNdCezU7c-8KuSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1B43101A528;
 Tue, 22 Aug 2023 08:53:37 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8161A40BC71B;
 Tue, 22 Aug 2023 08:53:35 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Shannon Nelson <snelson@pensando.io>,
 Stefano Garzarella <sgarzare@redhat.com>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gautam Dawar <gdawar@xilinx.com>,
 si-wei.liu@oracle.com, Zhu Lingshan <lingshan.zhu@intel.com>,
 Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>
Subject: [PATCH v3 1/5] vdpa: use first queue SVQ state for CVQ default
Date: Tue, 22 Aug 2023 10:53:26 +0200
Message-Id: <20230822085330.3978829-2-eperezma@redhat.com>
In-Reply-To: <20230822085330.3978829-1-eperezma@redhat.com>
References: <20230822085330.3978829-1-eperezma@redhat.com>
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

Previous to this patch the only way CVQ would be shadowed is if it does
support to isolate CVQ group or if all vqs were shadowed from the
beginning.  The second condition was checked at the beginning, and no
more configuration was done.

After this series we need to check if data queues are shadowed because
they are in the middle of the migration.  As checking if they are
shadowed already covers the previous case, let's just mimic it.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..a772540250 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -505,7 +505,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
 
     s0 = vhost_vdpa_net_first_nc_vdpa(s);
     v->shadow_data = s0->vhost_vdpa.shadow_vqs_enabled;
-    v->shadow_vqs_enabled = s->always_svq;
+    v->shadow_vqs_enabled = s0->vhost_vdpa.shadow_vqs_enabled;
     s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
 
     if (s->vhost_vdpa.shadow_data) {
-- 
2.39.3


