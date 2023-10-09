Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278EF7BD55A
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:38:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpllp-00072P-1f; Mon, 09 Oct 2023 04:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qplln-00071n-6z
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qplll-0001kW-MM
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696840660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/lz86oE0J2Pi8F+Oi/gEX4kdk9mCx7n4qEF91OApOLI=;
 b=IgGn4oIlSPdnQOCxhSbBwM5VDsN6so7+OydGVVwbHg0dJQ8VKPd6M1uNU8oBdnyN0Y5UFe
 7BGCQejMGFymYbYoVoAUl3fzXOxshkC7PH0TQGtp2ji5Rjv1YBnMJQKsWm6OYpgbCytWVg
 MXa0DwluFXJtlmBm6SyX0UvE8kCUT38=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-N-PZzRxJOrqxRfVXVXSEvQ-1; Mon, 09 Oct 2023 04:37:28 -0400
X-MC-Unique: N-PZzRxJOrqxRfVXVXSEvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAF061C0BB42
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 08:37:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE7F1C154CF;
 Mon,  9 Oct 2023 08:37:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
Date: Mon,  9 Oct 2023 10:37:25 +0200
Message-ID: <20231009083726.30301-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 v2: Renamed the variable to something more unique

 contrib/vhost-user-gpu/vugpu.h          | 8 ++++----
 contrib/vhost-user-gpu/vhost-user-gpu.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index 509b679f03..654c392fbb 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -164,12 +164,12 @@ struct virtio_gpu_ctrl_command {
 };
 
 #define VUGPU_FILL_CMD(out) do {                                \
-        size_t s;                                               \
-        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
+        size_t vugpufillcmd_s_ =                                \
+            iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
                        &out, sizeof(out));                      \
-        if (s != sizeof(out)) {                                 \
+        if (vugpufillcmd_s_ != sizeof(out)) {                   \
             g_critical("%s: command size incorrect %zu vs %zu", \
-                       __func__, s, sizeof(out));               \
+                       __func__, vugpufillcmd_s_, sizeof(out)); \
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


