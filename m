Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5256573FC81
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8MD-0000Du-0V; Tue, 27 Jun 2023 09:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M9-0000CT-HD
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M7-0007FT-Ue
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2DB3fSv0+8FOOeaX0YiKDuyrQVyrwaEPbaOAx2cOHc=;
 b=hMSqaOdwotCkhtkVIMfNY5TxPE5pBUD8C7cqMaYPnR5blbyuCCiQA/Ptf1FTS/zC5ho9Q9
 YjZUhrPbIFaFdDImkjNYAAOofvtgMEH66KC9/OqXjvqS02QFT8yIvZXwYhFlQy21y6nPfH
 2uUdJh8SMsRiEAAn+fIfwNZcDmda6do=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-j_NBXPwBO2SYMs1cbHD0HA-1; Tue, 27 Jun 2023 09:03:36 -0400
X-MC-Unique: j_NBXPwBO2SYMs1cbHD0HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5DF90ED2D;
 Tue, 27 Jun 2023 13:03:33 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C81DBF5CC6;
 Tue, 27 Jun 2023 13:03:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 29/33] virtio-gpu-virgl: teach it to get the QEMU EGL display
Date: Tue, 27 Jun 2023 15:02:26 +0200
Message-ID: <20230627130231.1614896-30-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

virgl offers a few features that require to have access to the
underlying EGLDisplay. This is the case for the D3D texture sharing support.

The API callback is merged for virgl 1.0:
https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1113

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-18-marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 1c47603d40..9831c482e5 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -18,9 +18,17 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 
+#include "ui/egl-helpers.h"
+
 #include <virglrenderer.h>
 
-static struct virgl_renderer_callbacks virtio_gpu_3d_cbs;
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
+static void *
+virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
+{
+    return qemu_egl_display;
+}
+#endif
 
 static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
                                          struct virtio_gpu_ctrl_command *cmd)
@@ -608,6 +616,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
 
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
+    if (qemu_egl_display) {
+        virtio_gpu_3d_cbs.version = 4;
+        virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
+    }
+#endif
+
     ret = virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         error_report("virgl could not be initialized: %d", ret);
-- 
2.41.0


