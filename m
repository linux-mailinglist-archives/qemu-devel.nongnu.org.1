Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B682B500
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:03:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0K6-0001xg-7L; Thu, 11 Jan 2024 14:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0K4-0001xY-J7
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0K2-0002Lp-Dm
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704999753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQKcPkY6/W3EsLgkAEJ6imao+rgKnctifkMPjHMrgNY=;
 b=ZYi4jdQujvpFesC1bqcwJ2lUKrDwrWBhgVour2h8eoVvSNeZJ+1XgUYr84l/PDg6FZANdf
 1DwsFyu/W/HiZRfjGNl8GRiKQ/ISTEeoGIV40Cjr9Laa/fmVUdWhQItYnjnhXryfQCliN8
 OMeKWUv3QHyFyEQo4zUW4NbUD1M9MsE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-X8wHvCKHMbOjfGxl6mSmaQ-1; Thu, 11 Jan 2024 14:02:28 -0500
X-MC-Unique: X8wHvCKHMbOjfGxl6mSmaQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49EC18314F1;
 Thu, 11 Jan 2024 19:02:28 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FBAA492BF0;
 Thu, 11 Jan 2024 19:02:26 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>
Subject: [PATCH 1/6] vdpa: check for iova tree initialized at net_client_start
Date: Thu, 11 Jan 2024 20:02:17 +0100
Message-Id: <20240111190222.496695-2-eperezma@redhat.com>
In-Reply-To: <20240111190222.496695-1-eperezma@redhat.com>
References: <20240111190222.496695-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

To map the guest memory while it is migrating we need to create the
iova_tree, as long as the destination uses x-svq=on. Checking to not
override it.

The function vhost_vdpa_net_client_stop clear it if the device is
stopped. If the guest starts the device again, the iova tree is
recreated by vhost_vdpa_net_data_start_first or vhost_vdpa_net_cvq_start
if needed, so old behavior is kept.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3726ee5d67..e11b390466 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -341,7 +341,9 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
-    if (v->shadow_vqs_enabled) {
+
+    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
+    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
         v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
                                                    v->shared->iova_range.last);
     }
-- 
2.39.3


