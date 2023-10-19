Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBC7CFCF8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:39:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7l-0006pC-Gx; Thu, 19 Oct 2023 10:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7k-0006ob-0i
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7i-0000N1-He
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TtI1/7mXSdwyIYgaG5r3zTLrequ93X4VfvtMc/V9V2A=;
 b=bT/hvWgV2gYuvCnwdBRuCIOXP8tMWy8LxlUBKZ4BqA04EfTk7BztRnUMPh9MjYUCBF/Mbe
 xprshc2y+TqGpbzJm0jyNJs3qGjmo/UOosCpWjOiKfErIARA1v34WXZFSbm1nY35oAxCzZ
 A8NhzaBxnuXlpLTVTbWCuUoRhtlc1wY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-bfAvH8m4OPasuuNRnO4bdg-1; Thu, 19 Oct 2023 10:35:40 -0400
X-MC-Unique: bfAvH8m4OPasuuNRnO4bdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C63210201E6;
 Thu, 19 Oct 2023 14:35:39 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16F7BC1596D;
 Thu, 19 Oct 2023 14:35:36 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, si-wei.liu@oracle.com,
 Gautam Dawar <gdawar@xilinx.com>
Subject: [RFC PATCH 16/18] vdpa: add vhost_vdpa_net_load_setup NetClient
 callback
Date: Thu, 19 Oct 2023 16:34:53 +0200
Message-Id: <20231019143455.2377694-17-eperezma@redhat.com>
In-Reply-To: <20231019143455.2377694-1-eperezma@redhat.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

So the vDPA backend knows when a migration incoming starts.  NicState
argument is needed so we can get the dma address space.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/net/net.h |  4 ++++
 net/vhost-vdpa.c  | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 2fb1c9181c..e0ecf85bf6 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -42,6 +42,7 @@ typedef struct NICConf {
 
 /* Net clients */
 
+struct NICState;
 typedef void (NetPoll)(NetClientState *, bool enable);
 typedef bool (NetCanReceive)(NetClientState *);
 typedef int (NetStart)(NetClientState *);
@@ -69,6 +70,8 @@ typedef void (SocketReadStateFinalize)(SocketReadState *rs);
 typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
+/* This can be called before start & pair, so get also the peer */
+typedef int (NetMigrationLoadSetup)(NetClientState *, struct NICState *);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -98,6 +101,7 @@ typedef struct NetClientInfo {
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
+    NetMigrationLoadSetup *load_setup;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 31df7e91a1..507cb946d2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -396,6 +396,15 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
     }
 }
 
+static int vhost_vdpa_net_load_setup(NetClientState *nc, NICState *nic)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    VirtIONet *n = qemu_get_nic_opaque(&nic->ncs[0]);
+
+    vhost_vdpa_load_setup(s->vhost_vdpa.shared, n->parent_obj.dma_as);
+    return 0;
+}
+
 static NetClientInfo net_vhost_vdpa_info = {
         .type = NET_CLIENT_DRIVER_VHOST_VDPA,
         .size = sizeof(VhostVDPAState),
@@ -407,6 +416,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
+        .load_setup = vhost_vdpa_net_load_setup,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
-- 
2.39.3


