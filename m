Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BED61913632
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jun 2024 23:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL8ho-0007UK-UY; Sat, 22 Jun 2024 17:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sL8hm-0007Tn-Ne
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 17:55:30 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sL8hl-0001BM-1t
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 17:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1719093326;
 bh=9SVZMqbye0mDP5C4Smqz3XUZKET3ljIGeJ/gBHHK0sk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UEOOzqr4ygE4RvwJVIAV644sSGWxIXhBmq/smafFqmmPJQeaPrwHsTdGm7EGBiuG8
 Y9U+RjBJcy7M9EwkDz/r4jfmyLgAEpknENwA6QayAKFYxPSo4NBuzsU0avRoaJXDJ0
 LhS6CqGTAPemxsl+26O9ZfjAkLH063T25vAg3bG+rsXk9Ndik4e08VEFmj5WqTtQcL
 EalPY/tm6kP+MMLXugE61AXJrpYB/6b7wOBaspdh5UGWtwIk0SCSTcyXpg37yIFuD/
 CkI7qVTnjVUVSPxKsni9jp2y1Q+pMM++iO/JA0ojNZwRWaHwAkM3q5PINggyuPneOs
 kRaEUQpITGrng==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8635C378213C;
 Sat, 22 Jun 2024 21:55:24 +0000 (UTC)
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
Subject: [PATCH v15 03/14] virtio-gpu: Move print_stats timer to VirtIOGPUGL
Date: Sun, 23 Jun 2024 00:55:00 +0300
Message-ID: <20240622215511.154763-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
References: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move print_stats timer to VirtIOGPUGL for consistency with
cmdq_resume_bh and fence_poll that are used only by GL device.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c  | 10 ++++++----
 include/hw/virtio/virtio-gpu.h |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 91dce90f9176..a63d1f540f04 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -574,6 +574,7 @@ static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
 static void virtio_gpu_print_stats(void *opaque)
 {
     VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
     if (g->stats.requests) {
         fprintf(stderr, "stats: vq req %4d, %3d -- 3D %4d (%5d)\n",
@@ -588,7 +589,7 @@ static void virtio_gpu_print_stats(void *opaque)
     } else {
         fprintf(stderr, "stats: idle\r");
     }
-    timer_mod(g->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
+    timer_mod(gl->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
 }
 
 static void virtio_gpu_fence_poll(void *opaque)
@@ -651,9 +652,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
                                   virtio_gpu_fence_poll, g);
 
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-        g->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                      virtio_gpu_print_stats, g);
-        timer_mod(g->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
+        gl->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                       virtio_gpu_print_stats, g);
+        timer_mod(gl->print_stats,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
     }
     return 0;
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index bc69fd78a440..7ff989a45a5c 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -196,7 +196,6 @@ struct VirtIOGPU {
     uint64_t hostmem;
 
     bool processing_cmdq;
-    QEMUTimer *print_stats;
 
     uint32_t inflight;
     struct {
@@ -232,6 +231,7 @@ struct VirtIOGPUGL {
     bool renderer_reset;
 
     QEMUTimer *fence_poll;
+    QEMUTimer *print_stats;
 };
 
 struct VhostUserGPU {
-- 
2.45.2


