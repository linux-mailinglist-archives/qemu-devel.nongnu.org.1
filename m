Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957DF7B345F
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEC6-0000Yt-AW; Fri, 29 Sep 2023 10:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBz-0000Ab-A9
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBv-0004Kr-BB
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40528376459so145390445e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996599; x=1696601399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yl0ZpDqGt3cGSgbikZpZc/K/gvqYQBt6gy/E0jbe77I=;
 b=qWWeyLbbcFYVWg6P+4M4L8WHNpsX05oPwSN8GMMSNpR5vaAXKstgoD1Qdd08m3OpcA
 fww/HS3W5Snwv4VIkU+Q61jHNDPe3gXwGZZeqCbKS/KRTfz51UiT2DjISILArFoANPXf
 Cbu4Xn6GlH2ro6q0D4gmiwntbTloTbsDS35V1WCgRugiLUYMFrj0QCI9Vmwf223YEHW6
 R+mTaQoJk2JXS8FxPNOx8Xr3GiSByNd9YfTNKlhCkxqS4eFc1X3qTCWhoR9uJYplQbSJ
 C6E8uy5et3G3/rDRxOXkzLF2Rdk1DWEisvN4fpIPs1IoP2+6le4hbUuOGjUnm2RG17tk
 aaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996599; x=1696601399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yl0ZpDqGt3cGSgbikZpZc/K/gvqYQBt6gy/E0jbe77I=;
 b=IvLx4K3paC5l4CSpKS64W/EvH+Io6N6N2SOu3pCX2ifCSSBadgxXKG7fRC6Fz5Z2Zk
 xtSJNAHxprSiRnJxIpGiuZwAL2dnsmoc+QIBnCcW/ZGYmhL5Cqs1kCmtHwx2dHuqh5Uj
 iKlF8uTm7JhoKzfSkRh2a8JUFheJIl6xTe2kWH+XP4PEgyhKGziApaHTsMrMsViLLzYQ
 yF2PD8JySI+TuG7EFim+U2HmdSwP9uHgE+Oz0L/DxRU63ZzTeN2+ujkpHyGm2jlqSZq9
 J46oFfq0UMBSnGzlY+/RSI0X3+Mc0Fh+TmWF8POx41OZRbwZtUCzh27niVHVYGjYhzLq
 HjWw==
X-Gm-Message-State: AOJu0Yw1/ndsO3cgQcsmpbzHJfLhnTuKNUNBgikNE1jbbDm9iLbAfEEH
 hu4BpQUfoJhx832ZxLha3z+jW/OQo3fydyjELu8=
X-Google-Smtp-Source: AGHT+IFtUQS7YvGqLKSHT5mp2KptJ6K7k1dQLoRdg8kU6y0gu6bj01IrfGv5X4a3m++qmk9fyL8ytg==
X-Received: by 2002:a05:600c:207:b0:3fe:f74c:b4f6 with SMTP id
 7-20020a05600c020700b003fef74cb4f6mr4034032wmi.17.1695996599021; 
 Fri, 29 Sep 2023 07:09:59 -0700 (PDT)
Received: from localhost.localdomain (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b004030e8ff964sm1505232wmj.34.2023.09.29.07.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:09:58 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v10 08/11] virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
Date: Fri, 29 Sep 2023 17:08:28 +0300
Message-Id: <b50c94decce76e55c38f7fec44f6a9aacc9d89b6.1695996196.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 48 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f70cde4f01..60ab62a80d 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -167,6 +167,7 @@ virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS cal
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
+virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 8ed0e9b130..8cc910e0b9 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
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


