Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7908CA16422
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Jan 2025 23:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZdNP-00070E-80; Sun, 19 Jan 2025 17:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tZdN5-0006zw-Pj
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 17:02:19 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tZdN4-000894-4v
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 17:02:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1737324128; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MRQ/QeFcNdzX3mxRxOZXacjyQlkb9i+5RjFHRRlZXNAjA9/tQMIGXXZqIhuRHglCi9jwSdtilglUr32pHNfQdJIG55MG0Ipkc9xeI1AW91uaPgCpc1wjoNIhTHCAeiaVhG8BMjN6iKVI+RQbKmLpIQGntxJGbNUD05mA8Ynww1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1737324128;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HW/SVXd++zrp2EXkf7OYpiXf/n9KtTq7lxhzWAq632Y=; 
 b=fT2KOFz9ODrNJYzUq6lLlN//qx84kLk2eD6umHoALH9LXTNT3GWmg5AoUvi3mk2YP3blC+X2iXk99IhDMgqSd2L26HOCwKDW9Gdz9qa2Y05S2kYp2dzDo2vGRe9jyMzkSEKQVB/KhPezKOt5g4QBs3UxsqvbslCHmvv55SUynC8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737324128; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=HW/SVXd++zrp2EXkf7OYpiXf/n9KtTq7lxhzWAq632Y=;
 b=PlY4++jCt0Ek6qvm+6Vh3b9pdPY1oLXC7c/U3/1LbXWJPsP2GZm+C1jHXD+NJRI1
 00VhnIFncDZ4XAbwgdftWl5peKJzHzJeTBgQCvfKe51JCgC/9b9JzYknKD4jDwLsiGr
 iuohVnJSPZkfn4L2dWq8efBihr2HQBSZb89snvBE=
Received: by mx.zohomail.com with SMTPS id 1737324126354834.3132477106028;
 Sun, 19 Jan 2025 14:02:06 -0800 (PST)
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
Subject: [PATCH v5 3/8] virtio-gpu: Handle virgl fence creation errors
Date: Mon, 20 Jan 2025 01:00:45 +0300
Message-ID: <20250119220050.15167-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.024,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 145a0b387956..2eb6aaab4e84 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -872,6 +872,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
     bool cmd_suspended = false;
+    int ret;
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
@@ -970,7 +971,17 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
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
2.47.1


