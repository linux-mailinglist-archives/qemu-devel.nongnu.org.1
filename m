Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F727BBDDF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 19:36:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoojZ-0001vy-2N; Fri, 06 Oct 2023 13:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoojW-0001p6-R0
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoojV-0007Im-C7
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696613723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OclEu3br9n16/XIQQq5NSIfhvW5neFcQqoafhedNswo=;
 b=G2Xm+3LnbQaNVXTb2CPdJXRnxYllT7W+ixW0SsnYbcN32Qk2nis8D94FadGuiJDQ3BOZEI
 EmygOEOYtdC3NxbAMSIW7w93sU/mIwM+PYMCf33IISbHdlBu9omFvmQpoklj708M4oZPPm
 cOprhxjvyCCOfYCQiMYTNcmovN+6Zfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-685-ckaH65K_M4WN7RZ2EuHFqg-1; Fri, 06 Oct 2023 13:35:21 -0400
X-MC-Unique: ckaH65K_M4WN7RZ2EuHFqg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E11C800045
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 17:35:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AB73492C37;
 Fri,  6 Oct 2023 17:35:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] contrib/vhost-user-gpu: Fix compiler warning when compiling
 with -Wshadow
Date: Fri,  6 Oct 2023 19:35:18 +0200
Message-ID: <20231006173518.539085-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Rename some variables to avoid compiler warnings when compiling
with -Wshadow=local.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 contrib/vhost-user-gpu/vugpu.h          | 8 ++++----
 contrib/vhost-user-gpu/vhost-user-gpu.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index 509b679f03..5cede45134 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -164,12 +164,12 @@ struct virtio_gpu_ctrl_command {
 };
 
 #define VUGPU_FILL_CMD(out) do {                                \
-        size_t s;                                               \
-        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
+        size_t s_;                                              \
+        s_ = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0, \
                        &out, sizeof(out));                      \
-        if (s != sizeof(out)) {                                 \
+        if (s_ != sizeof(out)) {                                \
             g_critical("%s: command size incorrect %zu vs %zu", \
-                       __func__, s, sizeof(out));               \
+                       __func__, s_, sizeof(out));              \
             return;                                             \
         }                                                       \
     } while (0)
diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index aa304475a0..bb41758e34 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -834,7 +834,7 @@ vg_resource_flush(VuGpu *g,
                 .width = width,
                 .height = height,
             };
-            pixman_image_t *i =
+            pixman_image_t *img =
                 pixman_image_create_bits(pixman_image_get_format(res->image),
                                          msg->payload.update.width,
                                          msg->payload.update.height,
@@ -842,11 +842,11 @@ vg_resource_flush(VuGpu *g,
                                                       payload.update.data),
                                          width * bpp);
             pixman_image_composite(PIXMAN_OP_SRC,
-                                   res->image, NULL, i,
+                                   res->image, NULL, img,
                                    extents->x1, extents->y1,
                                    0, 0, 0, 0,
                                    width, height);
-            pixman_image_unref(i);
+            pixman_image_unref(img);
             vg_send_msg(g, msg, -1);
             g_free(msg);
         }
-- 
2.41.0


