Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128E783C28
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYN99-0005Fb-Pi; Tue, 22 Aug 2023 04:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN96-0005FE-5z
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN93-0000ef-Fm
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692694428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gfDQ2tI0ZC7+szCsKrwlOBQ2RFocR05VSdrNf+Fia7I=;
 b=FIlsX64/FunPt87DAzqBteDXD/EFqVWZLxdrd9lDYPBsL+kJnZWE2YiFwLBtAWgwlTEexW
 TdQHmsmgK6XIG7O1mCNVm59P3t2QFPR/vNVRl1AldB0pdSxHm80ZQCsn96O8lxvsvMZS6l
 0y5spoE4ETIKE1lf79tr3mNP8fPfF4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-HZy_PUwiNq2Sr5mzxtxpBg-1; Tue, 22 Aug 2023 04:53:43 -0400
X-MC-Unique: HZy_PUwiNq2Sr5mzxtxpBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AEC0101A528;
 Tue, 22 Aug 2023 08:53:43 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD9AA40D2843;
 Tue, 22 Aug 2023 08:53:40 +0000 (UTC)
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
Subject: [PATCH v3 3/5] vdpa: rename vhost_vdpa_net_load to
 vhost_vdpa_net_cvq_load
Date: Tue, 22 Aug 2023 10:53:28 +0200
Message-Id: <20230822085330.3978829-4-eperezma@redhat.com>
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

Next patches will add the corresponding data load.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a772540250..9251351b4b 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -965,7 +965,7 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
     return 0;
 }
 
-static int vhost_vdpa_net_load(NetClientState *nc)
+static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
     struct vhost_vdpa *v = &s->vhost_vdpa;
@@ -1004,7 +1004,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .size = sizeof(VhostVDPAState),
     .receive = vhost_vdpa_receive,
     .start = vhost_vdpa_net_cvq_start,
-    .load = vhost_vdpa_net_load,
+    .load = vhost_vdpa_net_cvq_load,
     .stop = vhost_vdpa_net_cvq_stop,
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
-- 
2.39.3


