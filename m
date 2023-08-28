Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA378B8C2
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiLg-0002wC-Bv; Mon, 28 Aug 2023 15:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLE-0002ji-QU
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLB-0005I3-AE
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso3242727f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252559; x=1693857359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLbGivM6XWtOKnvA29FP7ntnj9cDBWoBlxm5aItbgjU=;
 b=M56R1wjEu+ISvUXaLLTdnhlfdz0FulAPgGXulRFe+J3BHWYPYClYBq1WrZ57/WMTs7
 lC3Awias8HhceBPYbPOimSXWLzU6l32MDnYI4+ZCsbCwcnRiYREynVh4zHziTEAR0jLp
 RXHoDK/1rWYXeY90UMqjEjcCnjG4tx1Xw/JfkAdSKci6ikutQjqZf/1wauaTWpAZUf6l
 MSMfH0uyr6A3/FDA0QCLUTl2BVel7vhSZVKkvrtYeO/Ac+/4bqD/pI0I+gh1Nfn5MuAS
 NkjIROaZSXjS9fzyLH2yxQSvTe5Xbh+h+FWtlcPjjKp8ut5UKUxDVDPGI9MAlQjGi0yz
 b5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252559; x=1693857359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLbGivM6XWtOKnvA29FP7ntnj9cDBWoBlxm5aItbgjU=;
 b=jYRXjdT1lAiIIaLH9yqxs1lDlUvmAZfimmaDYg6nu92N6oAB0lu6jjY0yv1LZpkWk8
 qqZTAFK3Qb1wAHK0Bp6Oq4ysEnQI85l8PIJvU3kCbLp3BkGFuu5FPZet3jLabE4F4XaB
 571gGLv6pdz6Crxa0VM+wO4jaW4dqK+sOTmCTsdN45auXCS//bq37+QmNgmezhtRb2hx
 lugSnQvfd/gGZyKMmqdhjTzanYIg4E3RrZz7vzl9AfP3JhEMx3XCOiSZIp9rVylJb45n
 7bbiR2VwU5RmS6c+oB4ga4XICPZLGKVTimEbdTQtwSfcZyPgNsdg84+/VRow7/P334BL
 sYXQ==
X-Gm-Message-State: AOJu0YyLSc1H/VOfYe5subS9qH/ywihUZfPrkXSOlH5YCfOWLw/nT3LA
 jUS2S3S5LGLM8uSTxp6tZkwqy6q4N1GN5JhbsIk=
X-Google-Smtp-Source: AGHT+IGh4XG3vJdCe4iq3aK+28U5YrvF0dI+cQdjRN8y7sMAa83w6S2Z1bApNlM5JYCWdKormmQCeA==
X-Received: by 2002:adf:f30b:0:b0:31c:70b0:426b with SMTP id
 i11-20020adff30b000000b0031c70b0426bmr10656897wro.63.1693252559342; 
 Mon, 28 Aug 2023 12:55:59 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:55:58 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
Date: Mon, 28 Aug 2023 22:55:03 +0300
Message-Id: <ff6f1320047826fa9260ab4c461873b2460cc350.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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
 hw/virtio/virtio-snd.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

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
index ab82c786f2..ae014d946c 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -408,6 +408,40 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     return VIRTIO_SND_S_OK;
 }
 
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
+    size_t sz = iov_to_buf(cmd->elem->out_sg,
+                           cmd->elem->out_num,
+                           0,
+                           &req,
+                           sizeof(req));
+    if (sz != sizeof(virtio_snd_pcm_hdr)) {
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+
+    cmd->resp.code = VIRTIO_SND_S_OK;
+    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
+            "VIRTIO_SND_R_PCM_STOP", req.stream_id);
+
+    stream = virtio_snd_pcm_get_stream(s, req.stream_id);
+    if (!stream) {
+        error_report("Invalid stream id: %"PRIu32, req.stream_id);
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+    }
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -442,10 +476,14 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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
         cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
         break;
-- 
2.39.2


