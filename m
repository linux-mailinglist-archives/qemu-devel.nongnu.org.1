Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDB777C5A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iG-00055V-2Z; Thu, 10 Aug 2023 11:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7iD-00054u-Vn
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7iC-0003BX-JY
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691681791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxpPGPLDMO5xZOUjwE2cDDukLRE2ObLbXk8q8a/NOm8=;
 b=A6I0+Cr0KzqO5qqXKRA6crv5fpQYAvkSoEvGQcebkCcubjYtvNJO++AaQ3vtVTIjTkACKa
 hSwibkMX32mN11HKkHpNaWmO4D5pTmB1Rw00Do8Z+eW8yCh0cAuKasBh8usjI3Db8OLgQJ
 3oObkaD/D+vf78KSQsEJppfrKQCkUlM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-IL-DGxmxPnyV5DPE5nfZiw-1; Thu, 10 Aug 2023 11:36:30 -0400
X-MC-Unique: IL-DGxmxPnyV5DPE5nfZiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 490ED185A791;
 Thu, 10 Aug 2023 15:36:29 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C01A2166B25;
 Thu, 10 Aug 2023 15:36:25 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 si-wei.liu@oracle.com, Parav Pandit <parav@mellanox.com>,
 Gautam Dawar <gdawar@xilinx.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Hawkins Jiawei <yin31149@gmail.com>, Shannon Nelson <snelson@pensando.io>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v2 3/5] vdpa: rename vhost_vdpa_net_load to
 vhost_vdpa_net_cvq_load
Date: Thu, 10 Aug 2023 17:36:09 +0200
Message-Id: <20230810153611.3410882-4-eperezma@redhat.com>
In-Reply-To: <20230810153611.3410882-1-eperezma@redhat.com>
References: <20230810153611.3410882-1-eperezma@redhat.com>
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


