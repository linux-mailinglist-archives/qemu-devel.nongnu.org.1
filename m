Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9377C9FB
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 11:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVq2S-0005Tu-Pt; Tue, 15 Aug 2023 05:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2P-0005TW-7p
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:29 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2M-0005BV-VA
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:28 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so82534801fa.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692090505; x=1692695305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfZ6ccS7yYdH05D/Qu6gWwHEQj65tZstj8zum7MsCto=;
 b=uhk60319sjiJaIRP7UGhU23aD1S4yGXyVGFWThapyTSq5OJdtz6Srv/UrbyYbrNY4l
 am0aiEbElWPrmi85vyMgbiUfYUsa/gLWzKZJ2d5+ZbBQ6mFTHiYzZBK+Y1wHvyfNB9HC
 vMecTDoRnrbA0AS9bophy5rA5fo8ZhpH+DO5M5HjlVbcUhIKlVMfy2MlceW0bykHm6v/
 ZhFSbkpolaP6AiI2k5w1l31e/iqTCHcBkSTlSfdCzH963fv2ZDalG4tg2O5mCbYvOc8X
 UfMNDBOsn/ZQmWDCtamQFDq2ns0DpzoH9gfzdjzJvEMfJjsBuXdFPY9V8oip3Jkc+2Me
 YLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692090505; x=1692695305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfZ6ccS7yYdH05D/Qu6gWwHEQj65tZstj8zum7MsCto=;
 b=la8RyZROMHFsYTJKk105cBhXoJc0H9kVQyqIYIVJfp9C2fDDneozGL6pD0EQHfeaze
 A6HsYYk0O9DkOWqrHCP5iUH0wyzwbIIxlme/+GHDkmR+w4Ap8fM0nn2bjxArjYw+v1eK
 b3j2m6hVUb62VPB98RjXIHxnGZVEZUWcS1Drs7kw4n3elebZ2znGHsBSTJ9gzpzCsjde
 8atO5XN8EG6UD7GgHCXN35K5SfWV/+e/hOFkJlLau9hIST9EHJHrAW6LSbdPTv1HRTkM
 bw9csn6oBKD+S3jEgdbp7Dkexi1/I8DUXkvtxywZKiyhGEv9Lyshp9x5zsoYXuoj5pkI
 idGg==
X-Gm-Message-State: AOJu0YzOBtekkwtM6KGOOFbo7VfBTDSCVDRcTSoS+GhYWNdCZ9//p6u1
 mzMSiYxA5N1fzutxMfaSZPWkrt3iIAVZjajx3E8=
X-Google-Smtp-Source: AGHT+IGHADAUu41s9HaL3NvwNFlPesvURWCZFLLhH/gBdDR9MAQo4iJFQvNDub+NVeeKL9UTDInUCQ==
X-Received: by 2002:a2e:6e06:0:b0:2b9:5695:d10d with SMTP id
 j6-20020a2e6e06000000b002b95695d10dmr7654865ljc.36.1692090505255; 
 Tue, 15 Aug 2023 02:08:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-56.37.6.0.tellas.gr. [37.6.0.56])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fe505319ffsm19774707wmk.18.2023.08.15.02.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 02:08:24 -0700 (PDT)
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
Subject: [PATCH v6 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
Date: Tue, 15 Aug 2023 12:07:11 +0300
Message-Id: <d3102a08509b77a37c686e68ae3712b46938815b.1692089917.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22b.google.com
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
index c75014233e..8fbad8f07f 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -417,6 +417,40 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
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
@@ -451,10 +485,14 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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


