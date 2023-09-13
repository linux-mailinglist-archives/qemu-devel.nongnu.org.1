Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534979E0DF
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKOS-0006Z3-Fu; Wed, 13 Sep 2023 03:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOQ-0006XQ-UF
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOO-0001pQ-8a
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso6116806f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590469; x=1695195269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5f9p2yLaM4HOXtC5rbPqbXserGQWzcV/yZ+TBd+a7AU=;
 b=e/eRaXFz39bIsz0CrLWiheTjpZX569p6M4ucUvnWBW5QvoAB9tzJ7bDDLVi3Txygqc
 NyrN89VTTEoQejxDE6h0AhIlSGwV1F+AWffRlmYqZwfSI6gtBJqMR7mpIiVI/fw3J8B4
 72avLQ4kpe0iWGnhcNKr4eTUGEQYVjl0tJYQQCoQ9xg4O828oQZNJvtJycqwccKil05f
 7i6pYiXOF2nhfAQHkY/sABePmTo9w4Zzx+dvdDWidA98Sox6IsIQHzYteoQX/WTCw9Cs
 QvSiz478QqAc1+a05JrFLPbgPnaOFspvYftLLcHaOjG6I4hdTBZskMAAUgrUfABfXch4
 4Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590469; x=1695195269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5f9p2yLaM4HOXtC5rbPqbXserGQWzcV/yZ+TBd+a7AU=;
 b=T5nplwHq8yJj9wAMSmvw5RltBesYbp7sdfnA3/9kSfHifUXqQ59l/zHbpacBtbMqd5
 FGqvI4YISDzxwjyLI0CieQOZwSmanU4Z+FyKcvhlLJW1GUlY0prpYwAChRLN0OKdTetQ
 NTbLcWpqsbBHzzROVyToaGQurffcg1/lsZqzquHKm04eGz+7uO/dZZjNo1H7Z+4DtTbM
 YSQaxEqLrBoJnB/XIqqXULhLa1hNBjfThXL73YSD2M6jvc3jhJ+xcjytDy9VBF2OPI7j
 l1kwAUdvTor6WPnMivctXYCgGm5yT69n+WSI4vteUKoQaxXejdQqccmyPsBbjp90naZx
 AGOg==
X-Gm-Message-State: AOJu0YyEOAVtsHCe0e2zj5o7S4UDqaQ5Wh3cLZuZebjx9nLY4Coh0PMT
 63kTGTXSFhKuhYT9okhNpya8hDOP8dKF63LUYrI=
X-Google-Smtp-Source: AGHT+IErJxsvc3N/tZFNAMJ4Laf097PGplWisMeCvEFVravCz/RkLXrSIQFzFT9qQC3yZqnQ2AXPEA==
X-Received: by 2002:adf:a39b:0:b0:317:67bf:337f with SMTP id
 l27-20020adfa39b000000b0031767bf337fmr1172885wrb.2.1694590469470; 
 Wed, 13 Sep 2023 00:34:29 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:28 -0700 (PDT)
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
Subject: [PATCH v9 07/12] virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
Date: Wed, 13 Sep 2023 10:33:14 +0300
Message-Id: <3680da4770ac7fd64b69d91618fb5ef9d35c8863.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
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

Handle the set parameters control request. It reconfigures a stream
based on a guest's preference if the values are valid and supported.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8eae1bf881..f70cde4f01 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -163,6 +163,7 @@ virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
+virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %"PRIu32
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 8b23a39499..29a70cd7e8 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -267,6 +267,32 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
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
+                               sizeof(req));
+
+    if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
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
@@ -506,6 +532,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_start_stop(s, cmd, false);
         break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
+        virtio_snd_handle_pcm_set_params(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
-- 
2.39.2


