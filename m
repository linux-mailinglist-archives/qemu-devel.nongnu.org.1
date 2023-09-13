Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5215B79E0E0
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:35:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKOL-0006Wk-Gf; Wed, 13 Sep 2023 03:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOJ-0006WG-2Z
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:27 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOG-0001nr-Er
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:26 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-502a4f33440so7566233e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590462; x=1695195262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMdHZzU2bVfLP/wHPBKKO5ew98kVV+jbwy9eqAjWSeg=;
 b=rHetgWZFDvG8PED4SdtC62XA8yLFkWCnaM88KxcSMLEx5Qkzm2FzC3k45dESZ9dSy/
 0TWuvGXxs0Lf4bMIloENZl9uxEFWXGTWd4+US7x2cRu2qQmzaOAhsYzAQsrzICQftf1Y
 tgTEKDcooPn/ndr+yG26OyDnwsPYjYhPE2YbPoL9HOBgQwVQo3r0SZ9PBPg4qXebn/5c
 AWadd8DTWZU4nY3qPeIwCkmnJc/JCD/xPsWF9EcZO6ctY5sFAKIKw8ujh1L+KZc96OVG
 s7GdnDoLhXdNJlcwhKzH4sff/kGvYcDPApawoCChd5jgjmKrxfFbV2kg6UgljERt/Enh
 ZY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590462; x=1695195262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMdHZzU2bVfLP/wHPBKKO5ew98kVV+jbwy9eqAjWSeg=;
 b=HuF3Lc3GMV47XwzRgnRAcESubvm1qiXXZpic3LOWhSHdGq+aY1xQbNLs9qEpRBbEj/
 ky1CT/0p5Ss0F+PgAb2jXKYKRCQ1lgMIIMB3N7LWmAfFytYCPJaOXOzke5zdcjub1HfR
 ttRfRXKPU3c5KHPl2MCZc43ltM6wVtJOskc2DqbOyJLG7DcDd9k9JruzxenGiyViVNXi
 SJRuba+lxemv4vmWnseB8+X63G3nYDDMv0EBzNQ07sZ4paXp1qEUfF5iCCx5nYMula2P
 SnYGlpjCRvaLP9x8yLGe5uK7Mpc9AS7uLLFaqwQBCBqo3LKlDIuo1KZbcKCUzPsP5GC4
 R3Sg==
X-Gm-Message-State: AOJu0YxbYZ1Bo4b4J0FoPEJx06k+V3TChP5Qd2LPk5nUqLDxelohHlqi
 zaoK3LEQbCTmSuwEBXB90JsyBLZ23gDbUjy3NVI=
X-Google-Smtp-Source: AGHT+IG/CS62CWl+Cd93pbGofGXPBQSn60MPIK+nxKTig9A4yNchw1WM0zpOG/VYyzS3lT0aexLt4Q==
X-Received: by 2002:ac2:5f6f:0:b0:4fe:c98:789a with SMTP id
 c15-20020ac25f6f000000b004fe0c98789amr1294687lfc.37.1694590462122; 
 Wed, 13 Sep 2023 00:34:22 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:21 -0700 (PDT)
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
Subject: [PATCH v9 05/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
Date: Wed, 13 Sep 2023 10:33:12 +0300
Message-Id: <8fa541379820327a23a7cabaf5a0dd6fbe486a15.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12c.google.com
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
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8a223e36e9..3e619f778b 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -164,6 +164,7 @@ virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
+virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index dea4ce6305..fd7c3ff000 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -32,6 +32,21 @@
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
+static struct virtio_snd_info info_to_le32(struct virtio_snd_info val) {
+    val.hda_fn_nid = cpu_to_le32(val.hda_fn_nid);
+
+    return val;
+}
+
+static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_pcm_info val) {
+    val.hdr = info_to_le32(val.hdr);
+    val.features = cpu_to_le32(val.features);
+    val.formats = cpu_to_le64(val.formats);
+    val.rates = cpu_to_le64(val.rates);
+
+    return val;
+}
+
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
                                   | BIT(VIRTIO_SND_PCM_FMT_S16)
@@ -147,6 +162,65 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
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
+    virtio_snd_query_info req;
+    VirtIOSoundPCMStream *stream = NULL;
+    g_autofree virtio_snd_pcm_info *pcm_info = NULL;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &req,
+                               sizeof(req));
+
+    if (msg_sz != sizeof(virtio_snd_query_info)) {
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
+        pcm_info[i] = pcm_info_to_le32(stream->info);
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
@@ -387,6 +461,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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


