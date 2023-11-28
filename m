Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E92E7FB857
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:45:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7vZC-0006om-JF; Tue, 28 Nov 2023 05:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r7vZA-0006nb-3H
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r7vZ7-0005hA-En
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701168214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wj2KOCSd3gkqmbd2ClDeaOLOq55F9jaRkAO+a/H8Y0M=;
 b=QQQIOYOUtdGr0o7ptCRwlXVzp02reWtPAZnw5VmwsBBTuTsB3LPsy+mNjSK65M5VclWFG1
 v1xQ+/ofCwdM/wCaX3h37rtLcbyqc4XW0vdDt7yg7yAlXGicrZqHnpLZCBQ0w3Mygc5K45
 drXwq1b4vlxi2b7FSZXgE9fbTucKDLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-KUyxP7KWMa26lB9DH_zD5w-1; Tue, 28 Nov 2023 05:43:33 -0500
X-MC-Unique: KUyxP7KWMa26lB9DH_zD5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A559481D871;
 Tue, 28 Nov 2023 10:43:32 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70FFE20268D7;
 Tue, 28 Nov 2023 10:43:30 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gautam Dawar <gdawar@xilinx.com>, Jason Wang <jasowang@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, yin31149@gmail.com,
 Shannon Nelson <shannon.nelson@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Yajun Wu <yajunw@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Lei Yang <leiyang@redhat.com>,
 si-wei.liu@oracle.com
Subject: [RFC PATCH v2 10/10] virtio_net: register incremental migration
 handlers
Date: Tue, 28 Nov 2023 11:43:03 +0100
Message-Id: <20231128104303.3314000-11-eperezma@redhat.com>
In-Reply-To: <20231128104303.3314000-1-eperezma@redhat.com>
References: <20231128104303.3314000-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

This way VirtIONet can detect when the incoming migration starts.

While registering in the backend (nc->peer) seems more logical, we need
nic dma address space, and we cannot get it from the backend.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
This could be done in vhost_vdpa or VirtIODevice struct, but future
series will add state restore through CVQ so it's easier to start in
VirtIONet directly.  If we need to make this more generic, we can move
to VirtIODevice and expose callbacks from VirtIONet class.

Also, the pointer may not be the best id, but there are not a lot of
things initialized in n.
---
 hw/net/virtio-net.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 80c56f0cfc..374d0b4ec8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -38,6 +38,7 @@
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "migration/register.h"
 #include "standard-headers/linux/ethtool.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
@@ -3810,9 +3811,39 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
+static int virtio_net_load_setup(QEMUFile *f, void *opaque)
+{
+    VirtIONet *n = opaque;
+    NetClientState *nc = qemu_get_subqueue(n->nic, 0);
+
+    if (nc->peer->info->load_setup) {
+        return nc->peer->info->load_setup(nc->peer, n->nic);
+    }
+
+    return 0;
+}
+
+static int virtio_net_load_cleanup(void *opaque)
+{
+    VirtIONet *n = opaque;
+    NetClientState *nc = qemu_get_subqueue(n->nic, 0);
+
+    if (nc->peer->info->load_cleanup) {
+        return nc->peer->info->load_cleanup(nc->peer, n->nic);
+    }
+
+    return 0;
+}
+
+static const SaveVMHandlers savevm_virtio_net_handlers = {
+    .load_setup = virtio_net_load_setup,
+    .load_cleanup = virtio_net_load_cleanup,
+};
+
 static void virtio_net_instance_init(Object *obj)
 {
     VirtIONet *n = VIRTIO_NET(obj);
+    g_autoptr(GString) id = g_string_new(NULL);
 
     /*
      * The default config_size is sizeof(struct virtio_net_config).
@@ -3824,6 +3855,10 @@ static void virtio_net_instance_init(Object *obj)
                                   DEVICE(n));
 
     ebpf_rss_init(&n->ebpf_rss);
+
+    g_string_printf(id, "%p", n);
+    register_savevm_live(id->str, VMSTATE_INSTANCE_ID_ANY, 1,
+                         &savevm_virtio_net_handlers, n);
 }
 
 static int virtio_net_pre_save(void *opaque)
-- 
2.39.3


