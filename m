Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE97E25AC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:34:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzj0-0005sv-Cu; Mon, 06 Nov 2023 08:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziw-0005sk-NR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziu-0003mE-LW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXsr14z/1X1B5RZ0gb0GgVyyGQiIAYKmcIcbCGPQ5vA=;
 b=IEHHV94u5tVn3KbBmuBKuvSvsKmvFeY6j4aJ8sBjpszWAj3lRkRF2hjORwLB/CrzpS3yJM
 4hiRSJXfa0oOMHh0VGhuH6PCgImE7QP4/+LUx5ByECiP1aQ1Nngo5Z2idPc9UGoS4tGoIW
 CbDxSuvPKzZdirMExKzL9/kCr97FqlM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-sjFLCEECPjWFRcYDlY1KpA-1; Mon, 06 Nov 2023 08:32:56 -0500
X-MC-Unique: sjFLCEECPjWFRcYDlY1KpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84C0889C662
 for <qemu-devel@nongnu.org>; Mon,  6 Nov 2023 13:32:56 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73E632166B26;
 Mon,  6 Nov 2023 13:32:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 08/10] virtio-gpu: move scanout restoration to post_load
Date: Mon,  6 Nov 2023 17:32:17 +0400
Message-ID: <20231106133219.2173660-9-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

As we are going to introduce an extra subsection for "blob" resources,
scanout have to be restored after.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 hw/display/virtio-gpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 8efabae7ee..26065c6466 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1267,7 +1267,6 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
-    struct virtio_gpu_scanout *scanout;
     uint32_t resource_id, pformat;
     void *bits = NULL;
     int i;
@@ -1337,6 +1336,17 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 
     /* load & apply scanout state */
     vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
+
+    return 0;
+}
+
+static int virtio_gpu_post_load(void *opaque, int version_id)
+{
+    VirtIOGPU *g = opaque;
+    struct virtio_gpu_scanout *scanout;
+    struct virtio_gpu_simple_resource *res;
+    int i;
+
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
         /* FIXME: should take scanout.r.{x,y} into account */
         scanout = &g->parent_obj.scanout[i];
@@ -1520,6 +1530,7 @@ static const VMStateDescription vmstate_virtio_gpu = {
         } /* device */,
         VMSTATE_END_OF_LIST()
     },
+    .post_load = virtio_gpu_post_load,
 };
 
 static Property virtio_gpu_properties[] = {
-- 
2.41.0


