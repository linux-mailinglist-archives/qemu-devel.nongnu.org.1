Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D60777C5C
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:38:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iX-0005OR-Oz; Thu, 10 Aug 2023 11:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7iT-0005JU-M5
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7iO-0003EB-KA
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691681803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yC7Gi8MdqujrMqjsXf1KLit2ElA40mQsftTm2Eu2lPE=;
 b=JjXnR1e5C1RzcWcjvJtJrJ+KSb8xQlSdNGN1IL9Gp8BcCRn2kCf8lFCeT0RlMmb1GGyAgg
 EvUIom4MjjEwygihfyMdX+nBlSOuMl1w9WTj8J4Osor2wvQ+gSn1/qYOSMul4vvX4zuQ72
 lx20AUdspsUQS5AMi7tF86eGOh8DxF4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-Lp8tZX_hOQyZn-nM_u-ZmQ-1; Thu, 10 Aug 2023 11:36:38 -0400
X-MC-Unique: Lp8tZX_hOQyZn-nM_u-ZmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49CFE1C0782D;
 Thu, 10 Aug 2023 15:36:35 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 855C52166B25;
 Thu, 10 Aug 2023 15:36:32 +0000 (UTC)
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
Subject: [PATCH v2 5/5] vdpa: remove net cvq migration blocker
Date: Thu, 10 Aug 2023 17:36:11 +0200
Message-Id: <20230810153611.3410882-6-eperezma@redhat.com>
In-Reply-To: <20230810153611.3410882-1-eperezma@redhat.com>
References: <20230810153611.3410882-1-eperezma@redhat.com>
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


