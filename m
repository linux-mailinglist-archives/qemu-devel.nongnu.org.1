Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 344468CF7B4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 05:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQdo-0005Dh-UO; Sun, 26 May 2024 23:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBQdn-0005DX-FP
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:03:15 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBQdl-0002Ip-S6
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716778991;
 bh=u3lPt4dfSywaRiWn1iJk8KCTSQnwKkF0pZSAepAV4MA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NGu2nTsIi9NY3PFL7Onp8HE2j/sYMjzMmm9QWtbPUXGpG/8XKETlFQpWiWTpjn1Rh
 2+Q9lc2KFEzfIm86/UCdYehAkx3MwfV/dmjHnuD2+kCEQXAb3jgHaeG2xqDRSUwPlU
 LBwkWesFe+jEaEG0pdAKk1VbCQxYU0zsTwyEzJPjd0yuXhdpa46vg1o1cUQQKAGsEI
 61ehwlR5VP1nLmvl3PNi6sYgsLmDgOVh3EmHSC6mvKjvILZZFbQXzgA20AeWbTwIAx
 GgaMmXlMGbH4SfHEuikQzSbCI6j4YtynCj7iQ1Z2tUanvaMjfSKGgU1vOA5pY/jgs5
 tI1UlJCvP+lbQ==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id D5BBB37820A7;
 Mon, 27 May 2024 03:03:09 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v13 06/13] virtio-gpu: Support context-init feature with
 virglrenderer
Date: Mon, 27 May 2024 06:02:26 +0300
Message-ID: <20240527030233.3775514-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Huang Rui <ray.huang@amd.com>

Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
feature flags. Expose this feature and support creating virglrenderer
context with flags using context_id if libvirglrenderer is new enough.

Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c    |  4 ++++
 hw/display/virtio-gpu-virgl.c | 20 ++++++++++++++++++--
 meson.build                   |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 7978b2985e17..9822d79c5e81 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -140,6 +140,10 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
         virtio_gpu_virgl_get_num_capsets(g);
 
+#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
+    g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
+#endif
+
     virtio_gpu_device_realize(qdev, errp);
 }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 66c4aab9b283..4b2d4a643e30 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -106,8 +106,24 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
     trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
                                     cc.debug_name);
 
-    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
-                                  cc.debug_name);
+    if (cc.context_init) {
+        if (!virtio_gpu_context_init_enabled(g->parent_obj.conf)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: context_init disabled",
+                          __func__);
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return;
+        }
+
+#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
+        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
+                                                 cc.context_init,
+                                                 cc.nlen,
+                                                 cc.debug_name);
+        return;
+#endif
+    }
+
+    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name);
 }
 
 static void virgl_cmd_context_destroy(VirtIOGPU *g,
diff --git a/meson.build b/meson.build
index de97d2426bde..65fddfbbc3a7 100644
--- a/meson.build
+++ b/meson.build
@@ -2310,6 +2310,7 @@ config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 if virgl.version().version_compare('>=1.0.0')
   config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
+  config_host_data.set('HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS', 1)
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
-- 
2.44.0


