Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ECC814EC8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 18:31:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEBzf-00063V-NH; Fri, 15 Dec 2023 12:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBze-00062r-CL
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzc-00013k-Rj
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702661336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tqw/FyexJjxhr7V573lIi8oVZJ1Sk7xeFTx0dhtnqn0=;
 b=K3LmVmRL/XeDnssO+JiqKV9wGOzGwKHXUs8HebcSd5HTG+E5h5lXAqmFWOyYjE/g16NVlm
 1wM2anuogC/8lf1UjAALw39rBO5M3oDo7Os3brwSKjN4yXmIqCPOggr9xsDWgZBjsEJppZ
 uap530LNQxfOjN31beAvAw7S6CalF18=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-kCfdJIMKOQmr0w2usnM9qA-1; Fri, 15 Dec 2023 12:28:53 -0500
X-MC-Unique: kCfdJIMKOQmr0w2usnM9qA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5D92185A783;
 Fri, 15 Dec 2023 17:28:52 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 096B740C6EB9;
 Fri, 15 Dec 2023 17:28:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH for 9.0 10/12] vdpa: add vhost_vdpa_net_load_setup NetClient
 callback
Date: Fri, 15 Dec 2023 18:28:28 +0100
Message-Id: <20231215172830.2540987-11-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-1-eperezma@redhat.com>
References: <20231215172830.2540987-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

So the vDPA backend knows when a migration incoming starts.  NicState
argument is needed so we can get the dma address space.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
RFC v2:
* Solve git conflict with .set_steering_ebpf
* Fix x-svq=on use case which did not allocated iova_tree.
---
 include/net/net.h |  6 ++++++
 net/vhost-vdpa.c  | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index ffbd2c8d56..68282dde31 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -42,6 +42,7 @@ typedef struct NICConf {
 
 /* Net clients */
 
+struct NICState;
 typedef void (NetPoll)(NetClientState *, bool enable);
 typedef bool (NetCanReceive)(NetClientState *);
 typedef int (NetStart)(NetClientState *);
@@ -69,6 +70,9 @@ typedef void (SocketReadStateFinalize)(SocketReadState *rs);
 typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
+/* This can be called before start & pair, so get also the peer */
+typedef int (NetMigrationLoadSetup)(NetClientState *, struct NICState *);
+typedef int (NetMigrationLoadCleanup)(NetClientState *, struct NICState *);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -98,6 +102,8 @@ typedef struct NetClientInfo {
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
+    NetMigrationLoadSetup *load_setup;
+    NetMigrationLoadCleanup *load_cleanup;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e11b390466..7d4a99878e 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -406,6 +406,37 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
     }
 }
 
+static int vhost_vdpa_net_load_setup(NetClientState *nc, NICState *nic)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    VirtIONet *n = qemu_get_nic_opaque(&nic->ncs[0]);
+    VhostVDPAShared *shared = s->vhost_vdpa.shared;
+    int r;
+
+    if (s->always_svq) {
+        /* iova tree is needed because of SVQ */
+        shared->iova_tree = vhost_iova_tree_new(shared->iova_range.first,
+                                                shared->iova_range.last);
+    }
+
+    r = vhost_vdpa_load_setup(shared, n->parent_obj.dma_as);
+    if (unlikely(r < 0)) {
+        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
+                        vhost_iova_tree_delete);
+    }
+
+    return r;
+}
+
+static int vhost_vdpa_net_load_cleanup(NetClientState *nc, NICState *nic)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    VirtIONet *n = qemu_get_nic_opaque(&nic->ncs[0]);
+
+    return vhost_vdpa_load_cleanup(s->vhost_vdpa.shared,
+                             n->parent_obj.status & VIRTIO_CONFIG_S_DRIVER_OK);
+}
+
 static NetClientInfo net_vhost_vdpa_info = {
         .type = NET_CLIENT_DRIVER_VHOST_VDPA,
         .size = sizeof(VhostVDPAState),
@@ -418,6 +449,8 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
+        .load_setup = vhost_vdpa_net_load_setup,
+        .load_cleanup = vhost_vdpa_net_load_cleanup,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
-- 
2.39.3


