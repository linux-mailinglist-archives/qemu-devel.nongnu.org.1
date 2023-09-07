Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7137972BA
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeElp-0003bZ-SD; Thu, 07 Sep 2023 09:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qeElk-0003Hj-Qd
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qeElf-0001zv-AE
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694092194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUZxSl4An47JbOfOhTSXOOqWYORY/nAKrrT8ECMTMSk=;
 b=PjTZqtSRgRwOTCeKCxYwkBVuKzfbHOOWYxrSHTTU54Ojjm9qzTKffkcMHaEjiWPFcDbbT/
 1jJDih/hEzcMkRBDZ56eHybXRrFubb9kw/u8C4pPUCQnXGga+Fn655gz/Hf+SRwqONA4Cs
 NBkyRRVjH9iI2qvtqzhf1Kyukw4k6Co=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-WeesAbg8NtCSfE8rQNyA0g-1; Thu, 07 Sep 2023 09:09:53 -0400
X-MC-Unique: WeesAbg8NtCSfE8rQNyA0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C192C3822566
 for <qemu-devel@nongnu.org>; Thu,  7 Sep 2023 13:09:52 +0000 (UTC)
Received: from localhost (unknown [10.39.208.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA5511460FE5;
 Thu,  7 Sep 2023 13:09:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 3/5] virtio-gpu: move scanout restoration to post_load
Date: Thu,  7 Sep 2023 17:09:34 +0400
Message-ID: <20230907130936.767722-4-marcandre.lureau@redhat.com>
In-Reply-To: <20230907130936.767722-1-marcandre.lureau@redhat.com>
References: <20230907130936.767722-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

As we are going to introduce an extra subsection for "blob" resources,
scanout have to be restored after.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index a58cb68f1c..6ebf98ca0e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1271,7 +1271,6 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
-    struct virtio_gpu_scanout *scanout;
     uint32_t resource_id, pformat;
     void *bits = NULL;
     int i;
@@ -1339,6 +1338,17 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 
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
@@ -1521,6 +1531,7 @@ static const VMStateDescription vmstate_virtio_gpu = {
         } /* device */,
         VMSTATE_END_OF_LIST()
     },
+    .post_load = virtio_gpu_post_load,
 };
 
 static Property virtio_gpu_properties[] = {
-- 
2.41.0


