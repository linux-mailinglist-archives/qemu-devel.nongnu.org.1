Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE1814EB3
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 18:30:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEBzh-00064I-RQ; Fri, 15 Dec 2023 12:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzg-00063r-Ag
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBze-00013z-TO
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702661338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xu9uAi/L9igDhJPMWJIKSWJK94/KRBv9cgJhMWV0nE=;
 b=KvPPDGjPy7tXyeSPTWQpfaC/CvfpDQRtLFyakvzXERieGr+CDaCed63zkf38vM3FVA6w4y
 eiOOJxw2SDY2JCqU8YLdkiwqN384zDmkg9qmTz4AwGz8qmzZlIX4GuehFQ8MQ43Z9PFnkZ
 Y+JFWjZYWAAq48KAXOb6bCDTwdnp1F4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-rqjG7ErbML66UvTNPqbMkg-1; Fri, 15 Dec 2023 12:28:55 -0500
X-MC-Unique: rqjG7ErbML66UvTNPqbMkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CEE585A58B;
 Fri, 15 Dec 2023 17:28:54 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E554040C6EB9;
 Fri, 15 Dec 2023 17:28:52 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH for 9.0 11/12] vdpa: add vhost_vdpa_net_switchover_ack_needed
Date: Fri, 15 Dec 2023 18:28:29 +0100
Message-Id: <20231215172830.2540987-12-eperezma@redhat.com>
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

Use migration switchover ack capability to make sure QEMU has mapped all
the guest memory to the device before the source stops the VM and
attempts to complete the migration.

All net vdpa devices support this early map of guest memory, so return
always true.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/net/net.h | 2 ++
 net/vhost-vdpa.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 68282dde31..f8c65dcb86 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -73,6 +73,7 @@ typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
 /* This can be called before start & pair, so get also the peer */
 typedef int (NetMigrationLoadSetup)(NetClientState *, struct NICState *);
 typedef int (NetMigrationLoadCleanup)(NetClientState *, struct NICState *);
+typedef bool (NetMigrationSwichoverAckNeeded)(const NetClientState *);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -104,6 +105,7 @@ typedef struct NetClientInfo {
     NetCheckPeerType *check_peer_type;
     NetMigrationLoadSetup *load_setup;
     NetMigrationLoadCleanup *load_cleanup;
+    NetMigrationSwichoverAckNeeded *load_switchover_ack_needed;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7d4a99878e..9aa958c4f1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -437,12 +437,18 @@ static int vhost_vdpa_net_load_cleanup(NetClientState *nc, NICState *nic)
                              n->parent_obj.status & VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
+static bool vhost_vdpa_net_switchover_ack_needed(const NetClientState *nc)
+{
+    return true;
+}
+
 static NetClientInfo net_vhost_vdpa_info = {
         .type = NET_CLIENT_DRIVER_VHOST_VDPA,
         .size = sizeof(VhostVDPAState),
         .receive = vhost_vdpa_receive,
         .start = vhost_vdpa_net_data_start,
         .load = vhost_vdpa_net_data_load,
+        .load_switchover_ack_needed = vhost_vdpa_net_switchover_ack_needed,
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
-- 
2.39.3


