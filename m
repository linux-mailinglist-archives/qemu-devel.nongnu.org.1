Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4474E1D5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzu3-0002qR-Do; Mon, 10 Jul 2023 19:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzu1-0002qE-7s
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIztz-00047f-Nd
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cm7m/d6NYZfBBMZKPgelKWyXoTCCqKJswESWtJrljJw=;
 b=DjfL1ThvNuLzEMPIbi9jE+jVdcsziSI/VGRp70ITP6qf3YzpEf362pygY8XuO46ejjjk/L
 LZpA34z7cwKOszTQqznssMPn36Ov7KRZ8PLzhuycJDRde7ak3giRh8uqLOEEqlEiMzHSsq
 4kviRaPck5JwhM2BlLIJx6n4bV5uy3I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-fvHJp3PkMJiXcbL7vAB0Tw-1; Mon, 10 Jul 2023 19:02:41 -0400
X-MC-Unique: fvHJp3PkMJiXcbL7vAB0Tw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-314275b653eso2720543f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030160; x=1691622160;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cm7m/d6NYZfBBMZKPgelKWyXoTCCqKJswESWtJrljJw=;
 b=JmWhIE4w/1ou7K05ICJAHnfwlzU2glaYBxCfIcbT7aqo6ZbDu4wAx5tZTBITE4iWCq
 UvJ2wuKmh5b46ttawxGBXLTdpk1MkEv9A4YwHejNtN1d4KnXiT2YfrJd1PRL/aIzzhcp
 kJEH8yhx7rY27gUQGy0F5sIidYgUgKUvc/FAnmd1+IV5Sm2fCJkfVsETPsh/f8I3pelr
 Dd+Quy7mn/GJaseG0GHarlPXowoica906oRaXHNeOq8BFAenQC530XNvuIfZLnP4DuxF
 26BDdNZRLBgh69f9gBGm2lZiQf8ynF12aBciRqfkB8d9PgAYK5j2EF86XsB7onWbJrW2
 zIhw==
X-Gm-Message-State: ABy/qLa2N2fyGPdJqv0QllYQkl2KWTiBNsGlYvj3A8r8tqiTDLndWO9H
 FgwtU4kg4uSPk3CjQzec3m/15w+AjuzUG0x/Zxg0zScyJF7RG5OF080Hvwx8fTbeNMULYAxSlqt
 OGIMJ9CFapjtXZRW+oRGTzOuNnprfV5n+9oFTa0MF53NA4icYZD9xZsIAtxDK+Xz+41vb
X-Received: by 2002:a5d:6649:0:b0:314:1443:7fbe with SMTP id
 f9-20020a5d6649000000b0031414437fbemr12713143wrw.36.1689030159899; 
 Mon, 10 Jul 2023 16:02:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGcKqnx2Ds9IOMRCPKdqxz9y183syGJ3LprG5Eqfs0zJMjHDWksESeQXRXJGx1qPsHS2Jf3Gw==
X-Received: by 2002:a5d:6649:0:b0:314:1443:7fbe with SMTP id
 f9-20020a5d6649000000b0031414437fbemr12713122wrw.36.1689030159598; 
 Mon, 10 Jul 2023 16:02:39 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f14-20020adfe90e000000b0030647449730sm578463wrm.74.2023.07.10.16.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:38 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Erico Nunes <ernunes@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 04/66] virtio-gpu: refactor generate_edid function to
 virtio_gpu_base
Message-ID: <ee3729d9b088a1988cd6b0a7738fad644fbbc415.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Erico Nunes <ernunes@redhat.com>

This functionality can be shared with upcoming use in vhost-user-gpu, so
move it to the shared file to avoid duplicating it.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230626164708.1163239-2-ernunes@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  2 ++
 hw/display/virtio-gpu-base.c   | 17 +++++++++++++++++
 hw/display/virtio-gpu.c        | 20 +-------------------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a5f8056ea..7ea8ae2bee 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -242,6 +242,8 @@ void virtio_gpu_base_reset(VirtIOGPUBase *g);
 void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
                         struct virtio_gpu_resp_display_info *dpy_info);
 
+void virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
+                                   struct virtio_gpu_resp_edid *edid);
 /* virtio-gpu.c */
 void virtio_gpu_ctrl_response(VirtIOGPU *g,
                               struct virtio_gpu_ctrl_command *cmd,
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index a29f191aa8..7ab7d08d0a 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -17,6 +17,7 @@
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "hw/display/edid.h"
 #include "trace.h"
 
 void
@@ -51,6 +52,22 @@ virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
     }
 }
 
+void
+virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
+                              struct virtio_gpu_resp_edid *edid)
+{
+    qemu_edid_info info = {
+        .width_mm = g->req_state[scanout].width_mm,
+        .height_mm = g->req_state[scanout].height_mm,
+        .prefx = g->req_state[scanout].width,
+        .prefy = g->req_state[scanout].height,
+        .refresh_rate = g->req_state[scanout].refresh_rate,
+    };
+
+    edid->size = cpu_to_le32(sizeof(edid->edid));
+    qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
+}
+
 static void virtio_gpu_invalidate_display(void *opaque)
 {
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 347e17d490..befa7d6d78 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -24,7 +24,6 @@
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/display/edid.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -207,23 +206,6 @@ void virtio_gpu_get_display_info(VirtIOGPU *g,
                              sizeof(display_info));
 }
 
-static void
-virtio_gpu_generate_edid(VirtIOGPU *g, int scanout,
-                         struct virtio_gpu_resp_edid *edid)
-{
-    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
-    qemu_edid_info info = {
-        .width_mm = b->req_state[scanout].width_mm,
-        .height_mm = b->req_state[scanout].height_mm,
-        .prefx = b->req_state[scanout].width,
-        .prefy = b->req_state[scanout].height,
-        .refresh_rate = b->req_state[scanout].refresh_rate,
-    };
-
-    edid->size = cpu_to_le32(sizeof(edid->edid));
-    qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
-}
-
 void virtio_gpu_get_edid(VirtIOGPU *g,
                          struct virtio_gpu_ctrl_command *cmd)
 {
@@ -242,7 +224,7 @@ void virtio_gpu_get_edid(VirtIOGPU *g,
     trace_virtio_gpu_cmd_get_edid(get_edid.scanout);
     memset(&edid, 0, sizeof(edid));
     edid.hdr.type = VIRTIO_GPU_RESP_OK_EDID;
-    virtio_gpu_generate_edid(g, get_edid.scanout, &edid);
+    virtio_gpu_base_generate_edid(VIRTIO_GPU_BASE(g), get_edid.scanout, &edid);
     virtio_gpu_ctrl_response(g, cmd, &edid.hdr, sizeof(edid));
 }
 
-- 
MST


