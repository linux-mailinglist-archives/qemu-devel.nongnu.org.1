Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 814497CF4B0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:06:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPuX-0004XF-32; Thu, 19 Oct 2023 06:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPuK-0004Mn-L8
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPuI-0003X1-Ph
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so21622685e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709933; x=1698314733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaMUwlAFk/8pNhi3nAnIvzM+2D1leBGJUC574lMFALk=;
 b=JmY8JvB7lWxwwo3Aan9Gg/dkQSdfEoTnIgM7FX3mrAZ9JkoSrGkp71wy9L+QH0+044
 bXGQ2scU3+NRIJ8y8luUAMQ7egA1BmAMM79CcNxZ4fJ4Md+xw3SbDwNWDDLC9VuUaWNj
 mKSdd0FGJe4TV65cq17lh9CJdKTCkMeYujj/T5lq2L3wVA2wP7JSs/S1Bb4xlB2T3pcv
 4JOOoTM6RrY/OdPjQwIbsoCv+Qac2yXqDoUI+vhKVMgr6OkPCsDklg7bQraQIf/zDIFK
 b2B+pDGFc7BhKo5FZuPkTXN3Rs5uC+xufCI0+FogVArAv22oNFl51ZCSoCu//0VjzLfX
 REGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709933; x=1698314733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaMUwlAFk/8pNhi3nAnIvzM+2D1leBGJUC574lMFALk=;
 b=Q9A87Urm0lhh/F33vHmaZFRR3Odxooir2fIHe+tPwPlGtCpLoU/b3TO3iAKkxT9kdg
 9+jXUH1eTtrEUuJvF3Rn5OPGg5Vo2kaAolka+caIsTqxTOhpGLQzFU0gGOrsymjnvzUb
 v4jha/381GNiZvJEZsWIMSuNr3vjUYUApZZ+zbzSnmxCR08s3/JTnvPGYFY1p90sB3Wy
 knLjrFyZdjeQnjnEimnorT25PU/va1ppH3Ye86A74OLPI2ZWBshuPp/JaJ2A57a5tJgf
 K4xv2HneNDJfB78Zcc3qFOKYBesOvcQdiPAr5IPPERK16/I0fOYt7zrqqRvIa/3pVoOo
 3ciw==
X-Gm-Message-State: AOJu0YwzA6pfkHF5s9F1Hx+2XdBJXobA7IzigFqv7euvMHQAKZzw/DYB
 U0L4/6TSVg1yDWUIi7zJpD4v6//XAFQP+bLVxkY=
X-Google-Smtp-Source: AGHT+IFxvltCU7bj6qniLpiSZHg6PW0wKmUiusBRVoX8i8O2tkz0YiAn0vxkdUeEVjDglzp7bw/2ag==
X-Received: by 2002:a05:6000:11c9:b0:32d:9cd3:6a9d with SMTP id
 i9-20020a05600011c900b0032d9cd36a9dmr1087311wrx.25.1697709933090; 
 Thu, 19 Oct 2023 03:05:33 -0700 (PDT)
Received: from localhost.localdomain (adsl-141.37.6.162.tellas.gr.
 [37.6.162.141]) by smtp.gmail.com with ESMTPSA id
 d13-20020a5d538d000000b003232d122dbfsm4110307wrv.66.2023.10.19.03.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:05:32 -0700 (PDT)
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
Subject: [PATCH v12 06/11] virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
Date: Thu, 19 Oct 2023 13:03:50 +0300
Message-Id: <c1164fd288d3945fb94fa77f9eebda65a2236a68.1697709630.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index fc7269f263..8c8d26fd3c 100644
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


