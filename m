Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1FAF12E2
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 13:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvAw-0001Nj-QR; Wed, 02 Jul 2025 06:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWvAu-0001NK-UP
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:58:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWvAt-00056T-3z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:58:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cf214200so35298325e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453924; x=1752058724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzVknBoggUzvrFjLbxqW22UiKdqh6179CfLQfmp2lsQ=;
 b=fmkf6hDwir7WDU4V1T2YM7Mzev1yHE0+q1Kza3dFDQwi7YC+Ja1RhXjNb5btke0xEP
 m53nGcIOzjV+hzTLfJxCEmgDQjyb43v+MjS/sDuzG57NkcaeK+Rz96ERT/G4nSnpV1wA
 HiyPOAhoVpOsunOajRNJ+PJYuW/2NcoqMTKt7U4GbrLH9i0u4ljx1idMZIIT2KTJF4NO
 OSVVzmX4Qw8HhGTKslrYtsxyyhg6UkV+ntqZ5RGBL3chbnl5MZOFRh98yHMGffldE/kx
 SkUvfHP2ZrPei0ddaNjIUYu9SaDBZ86G6RbinfEMwTJaFuucBSmPI+x2EdA/JoCC9FWd
 Nx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453924; x=1752058724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzVknBoggUzvrFjLbxqW22UiKdqh6179CfLQfmp2lsQ=;
 b=DNC5cBo933AKizoTHjBpIRVG1k9C8KN0iVdcvWJgri2mm47jodhMmr3+LgYO3CGwUf
 XBnKRrOoyd/EoEAuMXCGmZ0muHYkrXmNo7ui3b+MCWWY2k41mSCZlQ4xR3qOidcC18XJ
 DLPPMTn95V7zIy6YAr1jimtIoGDExvBdifUUAZy+wHwgARfrel+wgxrq+lRz8NZ7NSq/
 0PKmkEoQ/NAgiaVH3U96GpXkdffXI4AIUgF4vMwgCQnWM0MyEC4QvNzDv62W+ikJFjAT
 aBJ9Ylk8qdWFiRjvJum8BwZyRswee22SgUt1xPa1SmkKDRYqrsuyFZlN8+y/ibNmHqUU
 KXFw==
X-Gm-Message-State: AOJu0YzuZjhTu31VZ6RFdOaFwyVJ9Jl7aeCYTXp7360goo7dvKYNGBnT
 WNBLjf9Y9AfP+hFg2xr0zYIvjsPMYNZg78sLnIUDRQG1CQ8p0vmKNq3E5yIo2fpxkXs=
X-Gm-Gg: ASbGncuJ1Ky7isI0VeNUfH44uQKflK8My0s34F0RCQ9/5RVQEzWf/lO1vtLwnH2Ekrk
 zg2xiYa/0euAVxrhITtOBLxL+YeXHeuuf/24PHtEGCMpPUBD7qEgdWZo7kdjBwqsPr2NcFatM3/
 Mfn4IwL8LGqox2S7mfhgR91KWEOKQUfYX4MflAIWJG+bWSUsaTYjKIKI53KleHPgW2GTGeLUWzM
 WmgniOam7+KQqpnyrE/oslazBPpNXwB5TiODEZNMPzr0q3tCrebVuwFzR7jE2UEC1OnNjgn5vPA
 bC1r8zDimg+43Tx39qmJE7SOab9HN8mNm3SmRh79fXwEU0VeOba12devxXRRwLs=
X-Google-Smtp-Source: AGHT+IH4hsey9RMBeln4M932+vNmEuXhJS1tsfEx9ImiADM/cG498BhURof73Z5fsUXBNkYfOlgIEg==
X-Received: by 2002:a05:600c:c09b:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-454a36dd959mr21034115e9.2.1751453923545; 
 Wed, 02 Jul 2025 03:58:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a1914d10sm85103655e9.4.2025.07.02.03.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:58:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 369135F936;
 Wed, 02 Jul 2025 11:49:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yiwei Zhang <zzyiwei@gmail.com>, qemu-stable@nongnu.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 15/15] virtio-gpu: support context init multiple timeline
Date: Wed,  2 Jul 2025 11:49:55 +0100
Message-ID: <20250702104955.3778269-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Yiwei Zhang <zzyiwei@gmail.com>

Venus and later native contexts have their own fence context along with
multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
the flags must be dispatched to be created on the target context. Fence
signaling also has to be handled on the specific timeline within that
target context.

Before this change, venus fencing is completely broken if the host
driver doesn't support implicit fencing with external memory objects.
Frames can go backwards along with random artifacts on screen if the
host driver doesn't attach an implicit fence to the render target. The
symptom could be hidden by certain guest wsi backend that waits on a
venus native VkFence object for the actual payload with limited present
modes or under special configs. e.g. x11 mailbox or xwayland.

After this change, everything related to venus fencing starts making
sense. Confirmed this via guest and host side perfetto tracing.

Cc: qemu-stable@nongnu.org
Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20250518152651.334115-1-zzyiwei@gmail.com>
[AJB: remove version history from commit message]
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20250627112512.1880708-16-alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 145a0b3879..94ddc01f91 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -970,6 +970,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     }
 
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
+#if VIRGL_VERSION_MAJOR >= 1
+    if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
+        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
+                                            VIRGL_RENDERER_FENCE_FLAG_MERGEABLE,
+                                            cmd->cmd_hdr.ring_idx,
+                                            cmd->cmd_hdr.fence_id);
+        return;
+    }
+#endif
     virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
 }
 
@@ -983,6 +992,11 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
          * the guest can end up emitting fences out of order
          * so we should check all fenced cmds not just the first one.
          */
+#if VIRGL_VERSION_MAJOR >= 1
+        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
+            continue;
+        }
+#endif
         if (cmd->cmd_hdr.fence_id > fence) {
             continue;
         }
@@ -997,6 +1011,29 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
     }
 }
 
+#if VIRGL_VERSION_MAJOR >= 1
+static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
+                                      uint32_t ring_idx, uint64_t fence_id) {
+    VirtIOGPU *g = opaque;
+    struct virtio_gpu_ctrl_command *cmd, *tmp;
+
+    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
+        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX &&
+            cmd->cmd_hdr.ctx_id == ctx_id && cmd->cmd_hdr.ring_idx == ring_idx &&
+            cmd->cmd_hdr.fence_id <= fence_id) {
+            trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
+            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
+            QTAILQ_REMOVE(&g->fenceq, cmd, next);
+            g_free(cmd);
+            g->inflight--;
+            if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
+                trace_virtio_gpu_dec_inflight_fences(g->inflight);
+            }
+        }
+    }
+}
+#endif
+
 static virgl_renderer_gl_context
 virgl_create_context(void *opaque, int scanout_idx,
                      struct virgl_renderer_gl_ctx_param *params)
@@ -1031,11 +1068,18 @@ static int virgl_make_context_current(void *opaque, int scanout_idx,
 }
 
 static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
+#if VIRGL_VERSION_MAJOR >= 1
+    .version             = 3,
+#else
     .version             = 1,
+#endif
     .write_fence         = virgl_write_fence,
     .create_gl_context   = virgl_create_context,
     .destroy_gl_context  = virgl_destroy_context,
     .make_current        = virgl_make_context_current,
+#if VIRGL_VERSION_MAJOR >= 1
+    .write_context_fence = virgl_write_context_fence,
+#endif
 };
 
 static void virtio_gpu_print_stats(void *opaque)
-- 
2.47.2


