Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F271A7CFCE3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU89-0007Rt-SK; Thu, 19 Oct 2023 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU84-0007P5-MR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU82-0000Uy-6w
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYh//+UpSrN6kDA92jv+M1BuDh+/qH7Cfxyqscd0nfA=;
 b=D1DoiW4o8zY5kZdSJ15PSRjixHmuXr05H38zsGulvRT9cnxXQz1d7mzI3spYP2uJT3EO2j
 95n41BXdS9dVTh9XqghXF/VlcQuzVulI7LpaIV+zl4mrICBZhiNoKicYhmj8D+YTgcQ3O+
 iDJhR13gj4XlmiRmwFXnBYqtb4cWUvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-APuC0QntNnWAhJdPgizY2Q-1; Thu, 19 Oct 2023 10:35:45 -0400
X-MC-Unique: APuC0QntNnWAhJdPgizY2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 370A08EB36A;
 Thu, 19 Oct 2023 14:35:45 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06523C15BB8;
 Thu, 19 Oct 2023 14:35:41 +0000 (UTC)
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
Subject: [RFC PATCH 18/18] virtio_net: register incremental migration handlers
Date: Thu, 19 Oct 2023 16:34:55 +0200
Message-Id: <20231019143455.2377694-19-eperezma@redhat.com>
In-Reply-To: <20231019143455.2377694-1-eperezma@redhat.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This way VirtIONet can detect when the incoming migration starts.

While registering in the backend (nc->peer) seems more logical, we need
nic dma address space, and we cannot get it from the backend.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
This could be done in vhost_vdpa or VirtIODevice struct, but future
series will add state restore through CVQ so it's easier to start in
VirtIONEt directly.  If we need to make this more generic, we can move
to VirtIODevice and expose callbacks from VirtIONet class.

Also, the pointer may not be the best id, but there are not a lot of
things initialized in n.
---
 hw/net/virtio-net.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 29e33ea5ed..470338fa7c 100644
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
@@ -3808,9 +3809,27 @@ static void virtio_net_device_unrealize(DeviceState *dev)
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
+static const SaveVMHandlers savevm_virtio_net_handlers = {
+    .load_setup = virtio_net_load_setup,
+};
+
+
 static void virtio_net_instance_init(Object *obj)
 {
     VirtIONet *n = VIRTIO_NET(obj);
+    g_autoptr(GString) id = g_string_new(NULL);
 
     /*
      * The default config_size is sizeof(struct virtio_net_config).
@@ -3822,6 +3841,10 @@ static void virtio_net_instance_init(Object *obj)
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


