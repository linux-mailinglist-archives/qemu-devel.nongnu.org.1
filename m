Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B37D361B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutfd-0005H7-OI; Mon, 23 Oct 2023 08:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfb-0005Gs-7p
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:31 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfZ-0001yo-A7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:31 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so2948922e87.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698062667; x=1698667467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBRg/xWgCss1UGZUfw8fCOy1EN72mXuHqKEUcF2OZBs=;
 b=lqmLmEGeEkCmJwtpgk1yC1daQZ82v/pANO3YpI6SXOXPHInfIJ+V8OMHTKhC1D+qF7
 UH3mnKKUCr+vQ7SI3X6Qhe9wYTr7pN9Oz3WpxQNYpVz8pN+2s/VX8PH86O4QOj2qGjux
 zxU3EVO7Z0ZCuTiq0TEpJxg0UBCZugmbtiq50bwlrzU5t3AbleKh1ERZh56+5kIiEyJr
 5Mm7pg4UsloyoHtTujHnwaWpDLXCem+zEHxBTmUDz6tPMbe51sB0VUN5qgYeDEPF49B1
 esxKXomYvn3WiiJ4B9N51nLZ+HWFrAp6LzUlZd+xZff22vTqgPHMBS4iFIFKINAxh6gp
 zTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062667; x=1698667467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBRg/xWgCss1UGZUfw8fCOy1EN72mXuHqKEUcF2OZBs=;
 b=xPRdo/XDeZyuS51qmrMofaHNOCOmhQlW4fc/Am8ofTptP5F6WqbvcuANeH0IUQmhXv
 DW/SsxPq+7yLfSn5BWQgtNAvnOChowkV+1gFBwoonIAz6UAuf4K4mZcqsdQstaz7JELi
 rbTpf/bHq91EHbz7GxsD3Chx23fki+R+hjzf9fIsiB825ptKLgpgMtwZ7d+5EDX6M8DF
 grM4XGpmiavhufI5lHH/D6WCLhGC34RmX0df2KnAkzXOJVspxJAUHFPO5wtaeR3FKubd
 rJ+QuNUFl/m2siBW6ymg8sKlTCnU0rvuLW+svM2E6GByC2QVO8DiNUfuWWLPggkvkT32
 GjQg==
X-Gm-Message-State: AOJu0YwskmCbaa+9Yb7RvbPc+e86AEdbwt9+SafrkC3Daqe6ekEG1duK
 eUrVADdjReWCBgFVRDEXOsOyhrsrEGbFBPBMcPk=
X-Google-Smtp-Source: AGHT+IGeNAYWV+0zPUzUEfrYdtPX/j3lG6COB3igbMvk3hl9fbHq1w1wNE6inA0rpoD/q5gQzJzv1g==
X-Received: by 2002:a2e:81cc:0:b0:2c0:2ef8:9716 with SMTP id
 s12-20020a2e81cc000000b002c02ef89716mr6630409ljg.1.1698062667212; 
 Mon, 23 Oct 2023 05:04:27 -0700 (PDT)
Received: from localhost.localdomain (adsl-69.109.242.226.tellas.gr.
 [109.242.226.69]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm13819506wmh.11.2023.10.23.05.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:04:25 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
Subject: [PATCH v13 06/11] virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
Date: Mon, 23 Oct 2023 15:03:23 +0300
Message-Id: <d0d19928691f9375bfd83388806786cb7b161301.1698062525.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x130.google.com
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
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/audio/trace-events |  1 +
 hw/audio/virtio-snd.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index db48ff04fe..3badcab2e8 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -47,6 +47,7 @@ virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
+virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %"PRIu32
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e6791de6c6..084890e52b 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -287,6 +287,38 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
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
+                               sizeof(virtio_snd_pcm_set_params));
+
+    if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_set_params));
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
@@ -534,6 +566,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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


