Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA511767E61
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 12:59:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhLr-0000QI-VX; Sat, 29 Jul 2023 06:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLq-0000IH-A6
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLo-00017o-Qp
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fde57684d7so28857075e9.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627147; x=1691231947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFgI0VBM4/EkVfi0Gwqqn06sAlissiVMCynNkPCR8Nw=;
 b=BQqUDW0cMVyPEmMlt6moWQscfs/eH1864sgjRKgMmSSJmweeMbRFiDmIRif9u5LhwS
 VeO/XqDy/pWzk+LuQRW4GdmDqumVDwcmtnXmNu6psG21I4uL28ahDOOVNw5iLp4N/dgB
 zMuxdP3recqXevtfdzJ3we3gerB7GJCZrR8Ep+0ojJSNZl+gP/He67wYJC3HCP9oCBWG
 3BeFXd5J+r2AXCZQm9J7hYWhLkVHRVVSojan+Sq2Isk07Tw4cLV75saU2V67V0gD2Chp
 9NsAT4CQLc9yAYNDMjY9BsguOd8dy4LU+sLHJ2XkO5GdtOuN76R27STtKLh/thJx8uvn
 rqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627147; x=1691231947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFgI0VBM4/EkVfi0Gwqqn06sAlissiVMCynNkPCR8Nw=;
 b=krInmvXvIwQPYi4odO2xQA7zEPdSoYroZVD6zAUaenSrhinO2vaSR8Jt9Y+RgLD+Wk
 pxM0LaEsMFwItb63umo24tjDQi7T+VDl9t0riUc77vt2iUiz97l23GsWuJwUFxuxo2kt
 dCwI2Hy2Hvn/fCRpz+5pPLFsVhVH59XlkN5lpAhp6WJNJPlH5sLYf6zPV7wMWJR1GEi+
 oDNrOHdkjG/3vdU4KUr58StIGp0tGgqFiqyx2Bb21rSqeRHrjfpJVkSnc7QfDcfm/s5x
 SAVzHXHIybsPNPgUwrV57teurYNMihnEy7JhRyMuQTiElK3t0IrW6sORZEcZQZfLeB/o
 W2RA==
X-Gm-Message-State: ABy/qLbN9CbDnG1y/MRQTHfuvptkFgbN27halK/s6amfiYpsplYYCk6H
 kK+BBkjN7rLikZu2syDd3kudARxWXie9qiXhslkOUw==
X-Google-Smtp-Source: APBJJlGm9YuGDZoHLsIEMuCdl/zLntfryizjtWr1gxLvcIY8feylagK/qlLDCRJ1wCN+i7EEtaHnrQ==
X-Received: by 2002:a1c:7416:0:b0:3fe:ad4:27b1 with SMTP id
 p22-20020a1c7416000000b003fe0ad427b1mr3086159wmc.28.1690627146926; 
 Sat, 29 Jul 2023 03:39:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:39:06 -0700 (PDT)
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
 "Alex Bennee" <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 07/12] virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
Date: Sat, 29 Jul 2023 13:36:59 +0300
Message-Id: <7641e21ee8e50dbcc045caed774082ecca455640.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index eccb156e44..c8adc7614c 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -402,6 +402,40 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
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
@@ -436,10 +470,14 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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


