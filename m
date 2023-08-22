Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C2C784A2B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:20:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWuX-0005AU-CO; Tue, 22 Aug 2023 15:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuV-00055h-Ll
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:27 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuT-0000qg-Dm
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4119156f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731963; x=1693336763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOHRGLYMFXPpa/XGyUmK2+XxNZ7RwjgiK7nGsq6Whug=;
 b=jaX9Lp5H5K68Atwxvr4dCOlPggBTMpMjZxAq8Kbm0Hq6vg+ZKAUjWOyMmV3geJ/iAN
 9ZzAaM2T/k0q3TSWBoXmhZ7dHA1ocwmNyjAVihnbAi6HHJAcnFU8sSucihay46ssjeqc
 zreN/CBGIeFr1fZmHlvuASN8PJ5npaWuFyHO1A8BpMNYSRi4H953DxKdK5li8BrJhw8U
 tXRXyavmKMb6eSNNABZ8VjHhMZ/F4NYexDpKimuBze8ETwEIjo1vL/j3dUrtD+Gm3vUP
 4peZXITAkmbB2hSClfp1ntGqb/7ipwVfoszPqQ3aeRwoII0HBoRlzUkcggjE33PdsdNT
 IhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731963; x=1693336763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOHRGLYMFXPpa/XGyUmK2+XxNZ7RwjgiK7nGsq6Whug=;
 b=cNlKiiNIEdajd5WnVrRnCJ5q1l2aX+nED2bdSJ9HyLaTn+20UyNWFI7VYAMPgEf/E1
 eHS8y3Qv80bTJrhZYJ9Gmzcaplj1+DZ4FiVy4wLURqvme2f25WNOZKnXPcUS2OMvr941
 fsqIrodouMd4UCV2mOjnQr0iNxVYw2pAGNCsDfy3ZQ/N14Pce8ElGrwmn+SK0fHoBfRV
 alhvbcH1QB4LB2fvixx/yBW7NI+YkaiEiGsU60MfCUeRlXKwkwYts0iUe5e9PiHroe10
 UrBzNUDZjalbsJFmh4Bnm9r3toMTgVvyFNH2A2B5kVVz9P23SAIrVTYzlK1YwX584Ffv
 qN2w==
X-Gm-Message-State: AOJu0Yz3vscYU8n0EXISgucDpGZLh9Dud0Y4YWAahnwSm32ihMUpzLN0
 RkQIVVDl0t9Cyxo60btxVBkp44tJnz5xTAEByys=
X-Google-Smtp-Source: AGHT+IE7jnv0SRTiAs7cgtZpKgs7Pd5h8BjF2/cjI7AHV7ytr2W6gEaGv0iQ8fJInLVKkul6OkkLpA==
X-Received: by 2002:adf:cd86:0:b0:30f:c5b1:23ef with SMTP id
 q6-20020adfcd86000000b0030fc5b123efmr6885760wrj.41.1692731963561; 
 Tue, 22 Aug 2023 12:19:23 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:19:23 -0700 (PDT)
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
Subject: [PATCH v7 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
Date: Tue, 22 Aug 2023 22:18:29 +0300
Message-Id: <70bb76519e2dff529f27c015ceca0a2d63c1346c.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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
index 59b648b509..6946309e40 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -407,6 +407,40 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
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
@@ -441,10 +475,14 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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


