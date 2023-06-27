Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A543773FC60
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Le-0008RV-27; Tue, 27 Jun 2023 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LY-0008Qr-FA
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LV-000727-Dg
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0bYTYfFNy191Us+7zaIahk+6tXlpMlw0OvE6VEHBQE=;
 b=SogHWtzbXzWm6KUrcix/6j/zwg6qBnUBOQV/JO3KvlrOl+q+NJMDzoL6R/4Vioi4248qZ5
 aW2hAy2LYPItgwK6ijiifcyjgwmqWxasZzKtN2x+LnhoRKTwivttoaaI+YdGVG6koRh7X5
 GB2bZiOXHbs8QShHwxc9rDE9Jm7+RKo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-6tPuwoJvNSK1Zidh8XR_JQ-1; Tue, 27 Jun 2023 09:02:53 -0400
X-MC-Unique: 6tPuwoJvNSK1Zidh8XR_JQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1616E80006E;
 Tue, 27 Jun 2023 13:02:49 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF4547AD4B;
 Tue, 27 Jun 2023 13:02:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 08/33] virtio-gpu: Make non-gl display updates work again when
 blob=true
Date: Tue, 27 Jun 2023 15:02:05 +0200
Message-ID: <20230627130231.1614896-9-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

In the case where the console does not have gl capability, and
if blob is set to true, make sure that the display updates still
work. Commit e86a93f55463 accidentally broke this by misplacing
the return statement (in resource_flush) causing the updates to
be silently ignored.

Fixes: e86a93f55463 ("virtio-gpu: splitting one extended mode guest fb into n-scanouts")
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230623060454.3749910-1-vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index af31018ab0..506cda944d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -498,6 +498,8 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     struct virtio_gpu_resource_flush rf;
     struct virtio_gpu_scanout *scanout;
     pixman_region16_t flush_region;
+    bool within_bounds = false;
+    bool update_submitted = false;
     int i;
 
     VIRTIO_GPU_FILL_CMD(rf);
@@ -518,13 +520,28 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
                 rf.r.x < scanout->x + scanout->width &&
                 rf.r.x + rf.r.width >= scanout->x &&
                 rf.r.y < scanout->y + scanout->height &&
-                rf.r.y + rf.r.height >= scanout->y &&
-                console_has_gl(scanout->con)) {
-                dpy_gl_update(scanout->con, 0, 0, scanout->width,
-                              scanout->height);
+                rf.r.y + rf.r.height >= scanout->y) {
+                within_bounds = true;
+
+                if (console_has_gl(scanout->con)) {
+                    dpy_gl_update(scanout->con, 0, 0, scanout->width,
+                                  scanout->height);
+                    update_submitted = true;
+                }
             }
         }
-        return;
+
+        if (update_submitted) {
+            return;
+        }
+        if (!within_bounds) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: flush bounds outside scanouts"
+                          " bounds for flush %d: %d %d %d %d\n",
+                          __func__, rf.resource_id, rf.r.x, rf.r.y,
+                          rf.r.width, rf.r.height);
+            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+            return;
+        }
     }
 
     if (!res->blob &&
-- 
2.41.0


