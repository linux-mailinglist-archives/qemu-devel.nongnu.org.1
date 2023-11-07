Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A177E38A9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:17:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J34-00037F-Tv; Tue, 07 Nov 2023 05:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2a-0001ow-EU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2Y-0002Ss-Lb
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5krSj5ww4PPaYbWf+2x/83yOHdPFHALqGPbTo+C3zcI=;
 b=RfYUksef+mDFawM2SJoZtHZ02gIe13sLE6N8+IcYvydqLEz/NuAXT7htoGwT48fAUN8bww
 B22lSP7nAvqnULLlH5mmD/2KxaE3rHAzB6PLQk/4nZo3uO9b7GhVxsP7fJF16t3ep7ZQGh
 dhyDIPNKIwd9H+VwEBlIrLBPWPoZzYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-s7pqoJyOPTSI7nU3GM7ImQ-1; Tue, 07 Nov 2023 05:10:32 -0500
X-MC-Unique: s7pqoJyOPTSI7nU3GM7ImQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4092164ed09so32748055e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351831; x=1699956631;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5krSj5ww4PPaYbWf+2x/83yOHdPFHALqGPbTo+C3zcI=;
 b=NgL3ON1ANebVQb/Od3WtiNA+ct/fVtuJ4GwnVXRCX9e/tW4xQOvUUQ4jSKHmvBWqur
 4CzBNAtk9+kyVfc5tIMRXrsLFUTQbUynKCAE4PlAGGS/f4h2WpF7VfhU2+nrZx/OfSqh
 J6Zdp/mIcBMz20NDTF/PI7yRmjGOuPLMTEzUXmQLHuipL8gq++GWziXY8kixBVTnEVwP
 jCcFbCTy5K2awxEyUlPtz1ZviwRrz0NdLgRaB42WDqrhfchUPTnUvdPtIsWBLDiAM4ZV
 Bw0IL0uMq6CQyH6QG3+IiVTovXa3AQNn5rWO5xhmi+GaOYOuoIJjJ0fVhSGyPp7ITdhc
 h5ew==
X-Gm-Message-State: AOJu0YypHlt/Vslu202Oy/SPRxCNu00USrGffhb3Pz7naiv2joefnT7B
 BBnQr1fyMJTZnUKt+SQxDRzKixARl3p/XSicf4xcKpgEyxtc4NBRH/OJYP0dbH+QcYaVXdDnknU
 9g4Lopdtw3oI85H/10Usb0+3B/PBdi/m5P1y+rTaVy78Y3FJKBUS3jZnyNgk+HfFCi94H
X-Received: by 2002:a05:600c:3b0c:b0:405:36d7:4579 with SMTP id
 m12-20020a05600c3b0c00b0040536d74579mr1789549wms.28.1699351830773; 
 Tue, 07 Nov 2023 02:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzZWVZlv7KRbcYmr0khXER3w18YmFC9cbiHf9oXxzUb+V5HyuZsBHdg/mn9/kGht05Unp2gg==
X-Received: by 2002:a05:600c:3b0c:b0:405:36d7:4579 with SMTP id
 m12-20020a05600c3b0c00b0040536d74579mr1789508wms.28.1699351829907; 
 Tue, 07 Nov 2023 02:10:29 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c358600b004053a6b8c41sm14891490wmq.12.2023.11.07.02.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:29 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 13/63] virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
Message-ID: <64704ce04b0a62184d49f899e7f300f67480a2a6.1699351720.git.mst@redhat.com>
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

Handle the set parameters control request. It reconfigures a stream
based on a guest's preference if the values are valid and supported.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <d0d19928691f9375bfd83388806786cb7b161301.1698062525.git.manos.pitsidianakis@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 34 ++++++++++++++++++++++++++++++++++
 hw/audio/trace-events |  1 +
 2 files changed, 35 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e6791de6c6..084890e52b 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -287,6 +287,38 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
+/*
+ * Handles the VIRTIO_SND_R_PCM_SET_PARAMS request.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
+                                             virtio_snd_ctrl_command *cmd)
+{
+    virtio_snd_pcm_set_params req = { 0 };
+    uint32_t stream_id;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &req,
+                               sizeof(virtio_snd_pcm_set_params));
+
+    if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_set_params));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+    stream_id = le32_to_cpu(req.hdr.stream_id);
+    trace_virtio_snd_handle_pcm_set_params(stream_id);
+    cmd->resp.code = virtio_snd_set_pcm_params(s, stream_id, &req);
+}
+
 /*
  * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FMT_*
  */
@@ -534,6 +566,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_start_stop(s, cmd, false);
         break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
+        virtio_snd_handle_pcm_set_params(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index db48ff04fe..3badcab2e8 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -47,6 +47,7 @@ virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
+virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %"PRIu32
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
-- 
MST


