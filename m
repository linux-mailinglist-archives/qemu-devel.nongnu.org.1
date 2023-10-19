Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3C7CF4A7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPuX-0004Zt-M6; Thu, 19 Oct 2023 06:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPuG-0004ME-IS
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPuC-0003T5-Bf
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32dd70c5401so561357f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709925; x=1698314725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnwk/PHBexC4efCyWAjluAS2ymjQpgJcvzF12v69po8=;
 b=VUebwOLP3pEYJJ4m6iL5CP0Iogzh2y4mVl3tAtViCAfvI5mjcHeojh7YdFSwXR0M8/
 Cwgh9AJbtdRIu0CgBOTGpb0J234s9te9gXLelUHehcdP5+pAzlFYITaqEfwTPTHP2mU6
 8IcL5BNhsewKlknbpi4a3U0pgF0rObHmlQlFRVQ30dJJXA5YLv+Tegwo47wEo+LWd/r8
 XkDFnhKb60CmbpgoZsia1u6H3u7CqKCNp8VuVmoIt14iOj9Cb0u48RtiPL4LL72s7Cys
 2Tf3icjok/Bl6cKYpv+fvKhWsYBiW5TsGXod5Dj/uzJKQ+Q0gaRI0+ryf+1tXIGCEw9U
 viAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709925; x=1698314725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnwk/PHBexC4efCyWAjluAS2ymjQpgJcvzF12v69po8=;
 b=iXcXBf+Ro8N0/SLzhcYoUDDf2kCaPjTS0fb7BsgJ1VhkAsfJBsNPuCuk6gxKt2V1f2
 vAQ4BE7VdGi8YMHQFe19F12w2b37Qw6y/SSLP6Zz/OWO2V6qL88T0qmsmGjCeH+hfqDy
 oLeAo3EUqVfMqxp33NwAfnDMPxYIGmTcuWIx+c/5cB3SjiGObRM/UV7wkB5AIjqEVIC8
 wmPXM7IaWO5FoPveanu1oxk9NK6y4x0Tq1RTv7/BIQdmk+MMh9UVlF5BuwVOzVozG7wI
 qXS/v9TftaTpl7D916FKUjrxAhM5K9TZTId7V1c0aA/cYf9Kpv28WTfuTAmktjrCUQCq
 Om0Q==
X-Gm-Message-State: AOJu0Yz5YethseXE97OsBE01imsAf/DawafFvAhlE5De6pFmxgKBgr3m
 SB0MsI2BEbeeDfKLy0dzDgKQokjyapeOy/LoYs8=
X-Google-Smtp-Source: AGHT+IG4ZKpTD9yZQL+WicC9TeqY5OQGER1R6vZ9Q3qalSksa04Zh12is3tVb9g+BUjiAHQfgVhucg==
X-Received: by 2002:a05:6000:80e:b0:32d:1258:dc98 with SMTP id
 bt14-20020a056000080e00b0032d1258dc98mr1315587wrb.11.1697709925398; 
 Thu, 19 Oct 2023 03:05:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-141.37.6.162.tellas.gr.
 [37.6.162.141]) by smtp.gmail.com with ESMTPSA id
 d13-20020a5d538d000000b003232d122dbfsm4110307wrv.66.2023.10.19.03.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:05:24 -0700 (PDT)
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
Subject: [PATCH v12 04/11] virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
Date: Thu, 19 Oct 2023 13:03:48 +0300
Message-Id: <7996f4eb6d2aefa06278e64301fc52dbd82cc701.1697709630.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
of each requested PCM stream.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/audio/trace-events |  1 +
 hw/audio/virtio-snd.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

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
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 4a802467c5..b8d065feb2 100644
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
-- 
2.39.2


