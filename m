Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E89783C2F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:55:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYN9H-0005GR-IP; Tue, 22 Aug 2023 04:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN9C-0005G8-Im
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN9A-0000fR-Cb
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692694435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UyN3w0TLnWkcIkvdm4joeK/KlatGzDZvrp4yHcuTHyc=;
 b=dPJWw8wnNTrMhNWwbh9lGtkZ0dTzzMMjzI6KFioTAeKqnaXWoHZizBoI3W+0mHdOetFLBE
 GKehUFAlGru+6unnZqPoVoTEroM2InlEdid1gJYGCGufWbRy41SHrUKKVqgX/s0F5qDxBZ
 mGF7NW+f+sTkxkq5PPO+2v02evVQEN8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-px4NQ1QPPV24gHdY_lR0UA-1; Tue, 22 Aug 2023 04:53:48 -0400
X-MC-Unique: px4NQ1QPPV24gHdY_lR0UA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 419FA3827DF3;
 Tue, 22 Aug 2023 08:53:48 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E10B340D2843;
 Tue, 22 Aug 2023 08:53:45 +0000 (UTC)
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
Subject: [PATCH v3 5/5] vdpa: remove net cvq migration blocker
Date: Tue, 22 Aug 2023 10:53:30 +0200
Message-Id: <20230822085330.3978829-6-eperezma@redhat.com>
In-Reply-To: <20230822085330.3978829-1-eperezma@redhat.com>
References: <20230822085330.3978829-1-eperezma@redhat.com>
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

Now that we have add migration blockers if the device does not support
all the needed features, remove the general blocker applied to all net
devices with CVQ.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3bf60f9431..6bb56f7d94 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1413,18 +1413,6 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shadow_vq_ops = &vhost_vdpa_net_svq_ops;
         s->vhost_vdpa.shadow_vq_ops_opaque = s;
         s->cvq_isolated = cvq_isolated;
-
-        /*
-         * TODO: We cannot migrate devices with CVQ and no x-svq enabled as
-         * there is no way to set the device state (MAC, MQ, etc) before
-         * starting the datapath.
-         *
-         * Migration blocker ownership now belongs to s->vhost_vdpa.
-         */
-        if (!svq) {
-            error_setg(&s->vhost_vdpa.migration_blocker,
-                       "net vdpa cannot migrate with CVQ feature");
-        }
     }
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index, nvqs);
     if (ret) {
-- 
2.39.3


