Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE67CF4B1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPuY-0004bd-2Q; Thu, 19 Oct 2023 06:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPuS-0004Ob-Hq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPuQ-0003aY-PO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso3713739f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709941; x=1698314741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Dc2qtj2MgmkWqtMYcxbrR9J4IPhJeoNB5Ml6dCxKWk=;
 b=VwdvKpUqjBmg0dzRTi+A0bkPt64RYn4PZJneo8xMDMBLWQ/xpFjuewL02A7xkO5LSB
 mBS7PTfADlgRxSSME29ZrqFmCwIU+sTObj5NqEklB8OSlVEx56fiRCuNuJk+kxWTWHSf
 Mh4WZo+N3iBzMnfLQtTNGfTedvkcBDW/DOFBzOyjmMFh1+FgqrFSg7YPGUTSIjaXhkNd
 P8GTa+NjvyrtTjeyBpNB5FVSbdI9H/l72sbxKkoq7zH09CjwYWEJBgm5EnBE7uhQ+5Qp
 JhrkAcsapPBcfNgqnI0YDpCBXbpR+ZogZtQyaXTd4Kiyf4gbedPz0j9vjW49ps350uAp
 2DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709941; x=1698314741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Dc2qtj2MgmkWqtMYcxbrR9J4IPhJeoNB5Ml6dCxKWk=;
 b=nTGEHXy0pZUcGnLPUVJYEjXBrJ/Q97NwaSzGI6d9bZVW3T+wP3W38VWVP/Oa13KdEL
 3ydUZ/aMeCWH0aEv/F2iF2v5uknWdckxUv0E+xpi8zJN2IyH2d6ULM1Y3Dr/ECv0rjuc
 m/XWVYST7ickMz0jNpee26k8nt/TW0Sdis2NElwUk6Wv3RcdNC8k5kIHcIKfMSDpzU5o
 rLA6ZA/tU6DKuTVNfHMyVKmBYogKo408NMdsx6JK0kKzwy8SfuK0YYNS3nossjOMcnm5
 lpvyu2LJgmpKGT4Pv3tV5YfMCB6HHKWYlRXiq9/0xajTQgGoz29r1un6NUi25tQCnhl7
 twsg==
X-Gm-Message-State: AOJu0Yy9pQl/tN38e8CnFxANiPa1UmdtMXduH4QHvD9NJhSDnU8cRihT
 /3d1P8OH5P4clPhJWoHucD6jn8S9eYGfnmGkLrA=
X-Google-Smtp-Source: AGHT+IHqmYNVNCiuqXLUrm0gKMlVYf+5dG4X5o2sJX5V8vHcjr6HfTOa3QR8aG/KHKeFYjiK47obPA==
X-Received: by 2002:a05:6000:a1d:b0:316:f24b:597a with SMTP id
 co29-20020a0560000a1d00b00316f24b597amr1810022wrb.46.1697709941274; 
 Thu, 19 Oct 2023 03:05:41 -0700 (PDT)
Received: from localhost.localdomain (adsl-141.37.6.162.tellas.gr.
 [37.6.162.141]) by smtp.gmail.com with ESMTPSA id
 d13-20020a5d538d000000b003232d122dbfsm4110307wrv.66.2023.10.19.03.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:05:40 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v12 08/11] virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
Date: Thu, 19 Oct 2023 13:03:52 +0300
Message-Id: <aacaedc61924928532aa79491378530223f5c954.1697709630.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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

Handle the PCM release control request, which is necessary for flushing
pending sound IO. No IO is handled yet so currently it only replies to
the request.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/audio/trace-events |  1 +
 hw/audio/virtio-snd.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 3badcab2e8..33e24d0011 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -51,6 +51,7 @@ virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS cal
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
+virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index aa4a193508..25ab78f102 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -541,6 +541,52 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     stream->active = start;
 }
 
+/*
+ * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
+ * a stream.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_release(VirtIOSound *s,
+                                          virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id;
+    VirtIOSoundPCMStream *stream;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               sizeof(virtio_snd_hdr),
+                               &stream_id,
+                               sizeof(stream_id));
+
+    if (msg_sz != sizeof(stream_id)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(stream_id));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    stream_id = le32_to_cpu(stream_id);
+    trace_virtio_snd_handle_pcm_release(stream_id);
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (stream == NULL) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        error_report("already released stream %"PRIu32, stream_id);
+        virtio_error(VIRTIO_DEVICE(s),
+                     "already released stream %"PRIu32,
+                     stream_id);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -594,7 +640,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_prepare(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_RELEASE:
-        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+        virtio_snd_handle_pcm_release(s, cmd);
         break;
     case VIRTIO_SND_R_CHMAP_INFO:
         qemu_log_mask(LOG_UNIMP,
-- 
2.39.2


