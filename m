Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ABA9C350B
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Nov 2024 23:20:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAGHV-0003a6-6E; Sun, 10 Nov 2024 17:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tAGHT-0003Zj-Jr
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 17:19:39 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tAGHS-0008Lg-5S
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 17:19:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1731277167; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bRak+vU8VrwnUBTkftzvjuT64atu7D0suqyfBeEuqNLRLQzqRtTsgxNVMBBbbQRj8pK9bAuqswfOJJp7BngivI5Z/oqvo/0WkyrlbydzuPyiVaBul3dGCdpZyJMZxsAeimLk9tYSCEvz04OpLKEnMgW8bHkQKVbDOKKLk45oQOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731277167;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZKkj1ZhoGl9h72b5XKg/9foqAW3+vlixReRBYZ0DK24=; 
 b=dwQ5czkpY8ymzLxozQGPUufmaiVPFuIi0F/2F5/HdbTaOKZ8lPksz+5mfB2rFkq50uV+PFPS8mLXV10eHEKvHYmCAyeOvjchTfq7ZHgJBKFTWqqgLabq7ldw6okYQ2SVQyMfjFW1pxQBGdrNVumO+RKRiDdthsVrSY0AsEUlm0M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731277167; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ZKkj1ZhoGl9h72b5XKg/9foqAW3+vlixReRBYZ0DK24=;
 b=lBPaZ3AnANkWffuzmgFmptpaLTz56f4RIwZei1P2QWumlanG6EaNhPUSphyKt9hZ
 +9eFleeJL2lfhDzZXTtqts7UFYaqH5nsOLGmBzN3yTl3nnufPISsB0DV+e6tOFKIMuP
 AVSZBXezUM5tTEiulOcYoMj/ShYvF6aJe5SKdIG0=
Received: by mx.zohomail.com with SMTPS id 1731277165671380.5859505731843;
 Sun, 10 Nov 2024 14:19:25 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v4 3/5] virtio-gpu: Handle virgl fence creation errors
Date: Mon, 11 Nov 2024 01:18:35 +0300
Message-ID: <20241110221838.2241356-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Print out error messages when virgl fence creation fails to aid debugging
of the fence-related bugs.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index eedae7357f1a..a875c68a35e5 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -892,6 +892,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
     bool cmd_suspended = false;
+    int ret;
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
@@ -990,7 +991,17 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     }
 
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
-    virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
+
+    /*
+     * Unlike other virglrenderer functions, this one returns a positive
+     * error code.
+     */
+    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: virgl_renderer_create_fence error: %s",
+                      __func__, strerror(ret));
+    }
 }
 
 static void virgl_write_fence(void *opaque, uint32_t fence)
-- 
2.47.0


