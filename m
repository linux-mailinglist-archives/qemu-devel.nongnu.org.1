Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FBD7E3880
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J32-0002g1-9k; Tue, 07 Nov 2023 05:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2W-0001g6-B4
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2U-0002SW-EK
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvxEP4jiEV7WSUxXyqMVFGiE73KFR5mwnf3CNU3QYWg=;
 b=RQNPgw8Y5Osna5HBR64wGg2AcyYcTjPMUqvZzT/7EZRtSyGXzXu3iFpcE2Wmd8wVJjVQWy
 f5/eCSwTLcXr9gKSVciD+b4V1B1shWL3hwcB2tbcmJ8dBFFCnI3Rme+XIgtn0jAy4oCPJ3
 kkHUDF+tUaPMf6BTaFk/s7GmxU4xUWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-iXz2_lb3OuW_JIkKd1pGyw-1; Tue, 07 Nov 2023 05:10:27 -0500
X-MC-Unique: iXz2_lb3OuW_JIkKd1pGyw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408508aa81cso36211055e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351826; x=1699956626;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vvxEP4jiEV7WSUxXyqMVFGiE73KFR5mwnf3CNU3QYWg=;
 b=keGcVTVag8G229c+LSorKRp0VUvlTQ75zHu1FSjaGPu+0vWm8H5sCoA2vzSc8n2egZ
 0BUvTE1wg+B74CXvK/ojfeVpl1p3U8lSKuSYbUkwRHk0GG4Hh30u/19AZ8GJRyHvpeUS
 qBQEX31ElBI1Pw/CMohBCD0LvZ0isHU1rDrvrw6vjdTodQpKkBrOtfmGW5rNREpnDbA8
 sre9IF0fuyNY5A6K7ewoHpAs39YRSHTSb0bxWngUW0YP9xYII9RzLD/TjKdmFPIaO+I0
 m04UuMt5ZpMQUPqDLT1DrjnJZ9kXPdZo3FiFCTLtS5x72cEjZsYpq7kfsSWx+XOfoMB1
 ftWw==
X-Gm-Message-State: AOJu0YzYV5xflIH8IlkHhXPiLnUhQVPgBMi1Z/S7axoedebCovl8OZze
 ZHe7B6cViNNZRhLugHDxVbaW4Tdbacdqwr2z7qppioSh8MAYTxuo0q/Cf8KfBbaBpX+v2kOqCwK
 1IW0tDqytZuOqvNFeqyqf3Sw7utnegESPVqBIvazGwGGF/1i6MCLRWCsge4KjDhnVl3ea
X-Received: by 2002:a1c:6a17:0:b0:405:3955:5872 with SMTP id
 f23-20020a1c6a17000000b0040539555872mr1747344wmc.18.1699351826017; 
 Tue, 07 Nov 2023 02:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm13nbVnSFztb+F11kuXqCoJtyrEnpRPJ8MonH620o5B0P2TnbQT8iZ9v/UnvxXhtiuT3d6w==
X-Received: by 2002:a1c:6a17:0:b0:405:3955:5872 with SMTP id
 f23-20020a1c6a17000000b0040539555872mr1747320wmc.18.1699351825585; 
 Tue, 07 Nov 2023 02:10:25 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 c14-20020a05600c0a4e00b004030e8ff964sm15725829wmq.34.2023.11.07.02.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:24 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 12/63] virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
Message-ID: <fa131d4a8277ef3522384d33d3b6b7963b5e7de9.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Handle the start and stop control messages for a stream_id. This request
does nothing at the moment except for replying to it. Audio playback
or capture will be started/stopped here in follow-up commits.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <9657dbfe3cb4a48ceb033ceb5977dc08669dfefd.1698062525.git.manos.pitsidianakis@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 49 +++++++++++++++++++++++++++++++++++++++++--
 hw/audio/trace-events |  1 +
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fd0c50de6e..e6791de6c6 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -446,6 +446,47 @@ static const char *print_code(uint32_t code)
     #undef CASE
 };
 
+/*
+ * Handles VIRTIO_SND_R_PCM_START.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ * @start: whether to start or stop the device
+ */
+static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
+                                             virtio_snd_ctrl_command *cmd,
+                                             bool start)
+{
+    VirtIOSoundPCMStream *stream;
+    virtio_snd_pcm_hdr req;
+    uint32_t stream_id;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &req,
+                               sizeof(virtio_snd_pcm_hdr));
+
+    if (msg_sz != sizeof(virtio_snd_pcm_hdr)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_hdr));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    stream_id = le32_to_cpu(req.stream_id);
+    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
+            "VIRTIO_SND_R_PCM_STOP", stream_id);
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (stream == NULL) {
+        error_report("Invalid stream id: %"PRIu32, req.stream_id);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+    stream->active = start;
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -486,10 +527,14 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
     case VIRTIO_SND_R_PCM_INFO:
         virtio_snd_handle_pcm_info(s, cmd);
         break;
+    case VIRTIO_SND_R_PCM_START:
+        virtio_snd_handle_pcm_start_stop(s, cmd, true);
+        break;
+    case VIRTIO_SND_R_PCM_STOP:
+        virtio_snd_handle_pcm_start_stop(s, cmd, false);
+        break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
     case VIRTIO_SND_R_PCM_PREPARE:
-    case VIRTIO_SND_R_PCM_START:
-    case VIRTIO_SND_R_PCM_STOP:
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 6def414f96..db48ff04fe 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -49,6 +49,7 @@ virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
+virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
-- 
MST


