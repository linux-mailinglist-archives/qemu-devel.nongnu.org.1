Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B0E7BD595
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplu9-0000CA-IQ; Mon, 09 Oct 2023 04:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qplu3-0000Ba-K5
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qplu2-0003St-1r
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696841172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1B0u+UfC1gMHAKNIWlo1uUL0Pp/WvI+e98ZtzaG2Zgc=;
 b=XTN2fV7ptu9gv7PW+JzgKzLOFnXJ5mJVCWkGgk4SNCJ6XOUvYz+GouOqEh4OyWeEzZ4HQ8
 hZ47qFRQhCj0tTHCnzXre7A/xnp/gyYOI5RvBsSPMCjYuJFpCVK0TyoIyssE81JBzak3aH
 2/5ZkVjmT9C6gRDPKubzE4aygiV+Usg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-5mdvUrnvNOaKRv41WdL6Jg-1; Mon, 09 Oct 2023 04:46:01 -0400
X-MC-Unique: 5mdvUrnvNOaKRv41WdL6Jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B799681B13F
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 08:46:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0D5F140E962;
 Mon,  9 Oct 2023 08:45:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2] hw/virtio/virtio-gpu: Fix compiler warning when compiling
 with -Wshadow
Date: Mon,  9 Oct 2023 10:45:59 +0200
Message-ID: <20231009084559.41427-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Avoid using trivial variable names in macros, otherwise we get
the following compiler warning when compiling with -Wshadow=local:

In file included from ../../qemu/hw/display/virtio-gpu-virgl.c:19:
../../home/thuth/devel/qemu/hw/display/virtio-gpu-virgl.c:
 In function ‘virgl_cmd_submit_3d’:
../../qemu/include/hw/virtio/virtio-gpu.h:228:16: error: declaration of ‘s’
 shadows a previous local [-Werror=shadow=compatible-local]
  228 |         size_t s;
      |                ^
../../qemu/hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of macro
 ‘VIRTIO_GPU_FILL_CMD’
  215 |     VIRTIO_GPU_FILL_CMD(cs);
      |     ^~~~~~~~~~~~~~~~~~~
../../qemu/hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declaration
 is here
  213 |     size_t s;
      |            ^
cc1: all warnings being treated as errors

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Renamed the variable to something even less trivial

 include/hw/virtio/virtio-gpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 390c4642b8..4739fa4689 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -225,13 +225,13 @@ struct VhostUserGPU {
 };
 
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
-        size_t s;                                                       \
-        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
+        size_t virtiogpufillcmd_s_ =                                    \
+            iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
                        &out, sizeof(out));                              \
-        if (s != sizeof(out)) {                                         \
+        if (virtiogpufillcmd_s_ != sizeof(out)) {                       \
             qemu_log_mask(LOG_GUEST_ERROR,                              \
                           "%s: command size incorrect %zu vs %zu\n",    \
-                          __func__, s, sizeof(out));                    \
+                          __func__, virtiogpufillcmd_s_, sizeof(out));  \
             return;                                                     \
         }                                                               \
     } while (0)
-- 
2.41.0


