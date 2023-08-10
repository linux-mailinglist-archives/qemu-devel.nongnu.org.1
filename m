Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A240777C4D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iB-00054F-Hb; Thu, 10 Aug 2023 11:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7iA-000547-2M
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7i8-00039a-K4
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691681787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMAt2ZsmbdUBosO7zCHbo8mU64fQnS6BC96Uul2Z9xI=;
 b=ZPg1svzGPn3zeN7GCFttl2ixiA/cznkXv1EmMNYWykl/8qVTw0OlHTaK/h7r8gnR+tGjiS
 +v3bbmH0+TKLia77ICU0dxaWaRgR+SQo58tGcMYlbcRTy4j2ivCzKgsQIX6bW7Mnyq3rWB
 M9J9Ia8GcMqUYRNHWdEw3lDqlCWsQYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-fW0G2tOMOuSmpo265dfh1g-1; Thu, 10 Aug 2023 11:36:22 -0400
X-MC-Unique: fW0G2tOMOuSmpo265dfh1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 224418DC66E;
 Thu, 10 Aug 2023 15:36:22 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D19E2166B25;
 Thu, 10 Aug 2023 15:36:18 +0000 (UTC)
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
Subject: [PATCH v2 1/5] vdpa: use first queue SVQ state for CVQ default
Date: Thu, 10 Aug 2023 17:36:07 +0200
Message-Id: <20230810153611.3410882-2-eperezma@redhat.com>
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

Previous to this patch the only way CVQ would be shadowed is if it does
support to isolate CVQ group or if all vqs were shadowed from the
beginning.  The second condition was checked at the beginning, and no
more configuration was done.

After this series we need to check if data queues are shadowed because
they are in the middle of the migration.  As checking if they are
shadowed already covers the previous case, let's just mimic it.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
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


