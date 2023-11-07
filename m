Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DEF7E3879
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2n-0002Bc-JN; Tue, 07 Nov 2023 05:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2R-0001ZZ-M5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2P-0002S9-Qs
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfauttJPTH7CDsS+NAXMawCTCDD51QjLsLHnUx3iJuI=;
 b=YPakE+ncNHk0ltHar3jNnKO4175j7rzmDfaiVXhlY1R13EqNEgPOYCbGFJJM6wiIDLCUOe
 v/3z3PNEXESKV3YNm4ccMhqFoTPGdCtzM1JiOhAxsmPIMovnVpft8LimI4Ufy8X8LggbWl
 EDGr4CT7z3uel/Nm9/M0shA+xy8p07U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-LAb3jlnRP6iXm8Bz4TdWtQ-1; Tue, 07 Nov 2023 05:10:23 -0500
X-MC-Unique: LAb3jlnRP6iXm8Bz4TdWtQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so34960775e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351821; x=1699956621;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vfauttJPTH7CDsS+NAXMawCTCDD51QjLsLHnUx3iJuI=;
 b=DBeLaWkpMgH5DU+5S0OaGX9VZVaEf4aJnEVW4UQqCZhI4QD6PazE1lOg8MvcDt4a80
 PCkmaCs8kmA/yHfhsWsDjVpCod1ryAPmk+xJtp8+eqg6R2M8ZaimzEIBR5SS0fNo8VPQ
 7DBibhKmjg0jy9PX0lfESEWQjm+HACmtEVc8Gh/vWPoV/RFXFea6F6DUxGaRzqzqgBHr
 F6SAS2dIi7ZaVjj9de7EoCtkSHT9tQNaR8K+YnTpe9oxuonVAhJmPu+Ab2nOUVGsdnhB
 KFeNRYOl92QhHKXv4GhqFBiviI2IXcb3qBCWuxknwZ8R+axFBhO55vuTcRL/TeCrWE2J
 xvSA==
X-Gm-Message-State: AOJu0YyA++PDx8jHpprVJz6PFjmRg6erksEAkCK1WOiNB/ols04xcu10
 zTZunh9DjebtRq9EvppIybb/UvvP9kQyyjjSs5KOlWJyISZZ20Czcx/tk2v5rx3sgvmge0EMmlU
 dcjBTqJzW+bCsDPhhDkdtvZB9VnescD6JPfaxgReiZRXVjSzJqdHbifpwF+NOVblOPUHR
X-Received: by 2002:a05:600c:3112:b0:408:575e:f24f with SMTP id
 g18-20020a05600c311200b00408575ef24fmr1890507wmo.28.1699351820959; 
 Tue, 07 Nov 2023 02:10:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Uw61O8rfpuU4IEFMR97wIED55tgJcYp6TK5WuxBE5rcwy+LZhLHEz1UJbloOwAWCmGpv9g==
X-Received: by 2002:a05:600c:3112:b0:408:575e:f24f with SMTP id
 g18-20020a05600c311200b00408575ef24fmr1890483wmo.28.1699351820588; 
 Tue, 07 Nov 2023 02:10:20 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 fl17-20020a05600c0b9100b004097881d5f0sm12440561wmb.29.2023.11.07.02.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:19 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 11/63] virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
Message-ID: <0ff05dd209f153f037a48e4039a033885b9ab5e3.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
of each requested PCM stream.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <5ecea6ba2fb0e3957d7d90bc4dbac521a3d1f678.1698062525.git.manos.pitsidianakis@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 hw/audio/trace-events |  1 +
 2 files changed, 83 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 4eae76f638..fd0c50de6e 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -157,6 +157,86 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
         : &s->pcm->pcm_params[stream_id];
 }
 
+/*
+ * Handle the VIRTIO_SND_R_PCM_INFO request.
+ * The function writes the info structs to the request element.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_info(VirtIOSound *s,
+                                       virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id, start_id, count, size;
+    virtio_snd_pcm_info val;
+    virtio_snd_query_info req;
+    VirtIOSoundPCMStream *stream = NULL;
+    g_autofree virtio_snd_pcm_info *pcm_info = NULL;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &req,
+                               sizeof(virtio_snd_query_info));
+
+    if (msg_sz != sizeof(virtio_snd_query_info)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_query_info));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    start_id = le32_to_cpu(req.start_id);
+    count = le32_to_cpu(req.count);
+    size = le32_to_cpu(req.size);
+
+    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
+        sizeof(virtio_snd_hdr) + size * count) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        error_report("pcm info: buffer too small, got: %zu, needed: %zu",
+                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
+                sizeof(virtio_snd_pcm_info));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    pcm_info = g_new0(virtio_snd_pcm_info, count);
+    for (uint32_t i = 0; i < count; i++) {
+        stream_id = i + start_id;
+        trace_virtio_snd_handle_pcm_info(stream_id);
+        stream = virtio_snd_pcm_get_stream(s, stream_id);
+        if (!stream) {
+            error_report("Invalid stream id: %"PRIu32, stream_id);
+            cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+            return;
+        }
+        val = stream->info;
+        val.hdr.hda_fn_nid = cpu_to_le32(val.hdr.hda_fn_nid);
+        val.features = cpu_to_le32(val.features);
+        val.formats = cpu_to_le64(val.formats);
+        val.rates = cpu_to_le64(val.rates);
+        /*
+         * 5.14.6.6.2.1 Device Requirements: Stream Information The device MUST
+         * NOT set undefined feature, format, rate and direction values. The
+         * device MUST initialize the padding bytes to 0.
+         */
+        pcm_info[i] = val;
+        memset(&pcm_info[i].padding, 0, 5);
+    }
+
+    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+    iov_from_buf(cmd->elem->in_sg,
+                 cmd->elem->in_num,
+                 sizeof(virtio_snd_hdr),
+                 pcm_info,
+                 sizeof(virtio_snd_pcm_info) * count);
+}
+
 /*
  * Set the given stream params.
  * Called by both virtio_snd_handle_pcm_set_params and during device
@@ -404,6 +484,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
     case VIRTIO_SND_R_PCM_INFO:
+        virtio_snd_handle_pcm_info(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_START:
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 122d1403ef..6def414f96 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -48,6 +48,7 @@ virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
+virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
-- 
MST


