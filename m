Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD979E0E6
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKOM-0006Wz-Qp; Wed, 13 Sep 2023 03:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOL-0006Wr-Po
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOJ-0001og-A5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso372573f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590465; x=1695195265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6njOi68zbGvL6KzqRjSx0o3rVn5gIRXpguaMQKP411Q=;
 b=OjeM/hb/emuAs2BkuteFa5REAluTOAJyOAJwXSSeETbIGgrIyRW06fA9Zxfq6pm/M/
 R2jPc4VjADFUtXDG/n9f4SN/kmqjb1ruJzuqC2Fk+SvsJ6wugIR4emOsdsSQWh1BSr9C
 Q2uTffAAI31T/mAFqIHz486iLn13Qnacr9WyE4xEroe3xr5DEeFzOMGt//bK2uqzajrF
 yI3c+nc8YV+MmGDGyeC8uwzm2l6ivEoh+b8jRCkxek1Or7pnLSq+pssvfaeKeNqv5SdF
 4gdj8n0fPNN/dlQPggDZggcUohkMugAQScTh4IJoPTgIYuhB2NG5n62KWDBt0svMI5tA
 IOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590465; x=1695195265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6njOi68zbGvL6KzqRjSx0o3rVn5gIRXpguaMQKP411Q=;
 b=E6Q1iyrftMminrGPkaWHd58auPAuoa3HGbO1p5kedkTxOZVpDZ5+3p3FOmYN8FL5kg
 jyPqgHPEsKPBahc0hoDXtYEAoEEVnqgQcARFzBzz5FIAeXc4L1/8eO/jWPh3K4qMUHEm
 caa+VDnr6eoq7v2za9itvyOPK3OfYzmQmjxk7c21HVxKATzHIB9s13N+Tl2amp+LDxk7
 eA+g8r30nrbwCxz04eCi8ZGRKLu4KFp+wxcEvuggsvW8MT0/VNmy74GEcE37X01Z3LBE
 gaL3q/cvw7eLipSfs80KEcSjUOM9TqpHvsD+cVgaj3k14gyBe4fFs7+AmD/IMDsQQ/IA
 n0MQ==
X-Gm-Message-State: AOJu0YwFne3YMiY185FhfjRFdnjzgOY/D6SJZBDGJtI5ocmOiBJoYu23
 P5hicXuz+sKiKX9Jug8ApiCnBlBPyEgEjU6+Asg=
X-Google-Smtp-Source: AGHT+IHuULKBE0NRa0+RC8sQUIJA54BUZB+kkcWoIVL4lbGULfb9zR/vw1WTdj5nbWnhMzXB1+Hl6g==
X-Received: by 2002:a5d:6150:0:b0:319:6997:9432 with SMTP id
 y16-20020a5d6150000000b0031969979432mr1551278wrt.1.1694590465615; 
 Wed, 13 Sep 2023 00:34:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:25 -0700 (PDT)
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
Subject: [PATCH v9 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
Date: Wed, 13 Sep 2023 10:33:13 +0300
Message-Id: <c3bed88338dd7c2b6196d78427a6aaf0b6445b1b.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

Handle the start and stop control messages for a stream_id. This request
does nothing at the moment except for replying to it. Audio playback
or capture will be started/stopped here in follow-up commits.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 44 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3e619f778b..8eae1bf881 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -165,6 +165,7 @@ virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
+virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index fd7c3ff000..8b23a39499 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -426,6 +426,42 @@ static const char *print_code(uint32_t code)
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
+                               sizeof(req));
+
+    if (msg_sz != sizeof(virtio_snd_pcm_hdr)) {
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    stream_id = le32_to_cpu(req.stream_id);
+    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
+            "VIRTIO_SND_R_PCM_STOP", stream_id);
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
+        error_report("Invalid stream id: %"PRIu32, req.stream_id);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -463,10 +499,14 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
     case VIRTIO_SND_R_PCM_INFO:
         virtio_snd_handle_pcm_info(s, cmd);
         break;
-    case VIRTIO_SND_R_PCM_SET_PARAMS:
-    case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_START:
+        virtio_snd_handle_pcm_start_stop(s, cmd, true);
+        break;
     case VIRTIO_SND_R_PCM_STOP:
+        virtio_snd_handle_pcm_start_stop(s, cmd, false);
+        break;
+    case VIRTIO_SND_R_PCM_SET_PARAMS:
+    case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
-- 
2.39.2


