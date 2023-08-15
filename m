Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFECB77CA02
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 11:09:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVq2f-0005WO-VA; Tue, 15 Aug 2023 05:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2e-0005Vn-62
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:44 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2b-0005Df-Tr
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:43 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b9ab1725bbso77669901fa.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692090520; x=1692695320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lregqkac0xiXvtlEubI5QCmYVi6e3C87aRY0v8pgm98=;
 b=I+Iqar7BsM3c59ZcZxvGiZuNULeWNeMw12Mo8h67VDeHxMdX2yMHavPUtHhDbvdSWj
 e/SW+erEzL1RLJ26LnoZQUQcDaMY6ZjS8Z4s5SJGbyJzwECpx2jlVKBzeEQT/c5y1J+S
 +WqR+I5FoJ+uvFKtRETiRIjFVSNazAm+Iu/PtLQG2Rzw+RbKiezAeaKfG6aXac37boQ0
 eyliQJrw+U1o+HuAUCb7iAJHRAJ42sixGv+1fXc0Vg+JcWt98eZKvgxXdf6TV+rdNTbs
 BQqv0ydfcfaQfNyDNXMFauUFSEUQe10f6t8rnWWfZk6fmQDuGKkQ79jFrqdvO8DBUOgt
 lZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692090520; x=1692695320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lregqkac0xiXvtlEubI5QCmYVi6e3C87aRY0v8pgm98=;
 b=S7t2yN1mudwFqHU/nZY2mFdYaSo38+5DYWMMD9z2xtdyDFnzIeRmjAWbQLbmeClx+9
 muY3aGYewdWgYfuCYx45Job4Xkw1TsyAr5sAQG0IyIQ2mnL9aw4SIbbI+SU7fRhTlYa8
 CsTxBBaR8tfuLFxCEUD+n3Gqksf0ZmFZSMx8rMSzBF5FCJaqxNxw4XQHUwMD7sVmBqRc
 aX4LMcOld0q208bGnG/RrbZRqr/sJDDFLRZnxgdLlsbS0RssrxQemjlDRZQX+i4H2zwR
 +nfxDOBIDbJJS3WXSjBHl3elZRQZjHs4EO5tprYP1xooXs42ZSIREG6ZZXiknc8lIAoy
 Ur0g==
X-Gm-Message-State: AOJu0Yzk0uArMcTdYtWTPk8II9snwKKjc4dBr9thu91BDbV9nrEiSirQ
 lo08coWRuGY48fsh07fKJ5wUtObYnJxU8rGNjPk=
X-Google-Smtp-Source: AGHT+IElIBDfj1pyyNJZKtwJDJ0/bSx0S1hwLVJyn8HiG5uu+5aiok+o9mXQoIln3SQ4g+XsuPhWWw==
X-Received: by 2002:a2e:9f41:0:b0:2b9:4413:864e with SMTP id
 v1-20020a2e9f41000000b002b94413864emr8093059ljk.53.1692090520035; 
 Tue, 15 Aug 2023 02:08:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-56.37.6.0.tellas.gr. [37.6.0.56])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fe505319ffsm19774707wmk.18.2023.08.15.02.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 02:08:39 -0700 (PDT)
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
Subject: [PATCH v6 09/12] virtio-sound: handle VIRTIO_SND_PCM_RELEASE
Date: Tue, 15 Aug 2023 12:07:14 +0300
Message-Id: <4aebc542229f0f16fe4f6293defc242b525513e0.1692089917.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x233.google.com
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

Handle the PCM release control request, which is necessary for flushing
pending sound IO. No IO is handled yet so currently it only replies to
the request.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f70cde4f01..60ab62a80d 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -167,6 +167,7 @@ virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS cal
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
+virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index f314b6270f..61e6b8ceea 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -496,6 +496,42 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     }
 }
 
+/*
+ * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
+ * a stream.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_release(VirtIOSound *s,
+                                          virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id;
+    VirtIOSoundPCMStream *stream;
+    size_t sz = iov_to_buf(cmd->elem->out_sg,
+                           cmd->elem->out_num,
+                           sizeof(virtio_snd_hdr),
+                           &stream_id,
+                           sizeof(stream_id));
+    if (sz != sizeof(uint32_t)) {
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+
+    trace_virtio_snd_handle_pcm_release(stream_id);
+
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
+        error_report("already released stream %"PRIu32, stream_id);
+        virtio_error(VIRTIO_DEVICE(s),
+                     "already released stream %"PRIu32,
+                     stream_id);
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+    cmd->resp.code = VIRTIO_SND_S_OK;
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -543,7 +579,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_prepare(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_RELEASE:
-        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
+        virtio_snd_handle_pcm_release(s, cmd);
         break;
     case VIRTIO_SND_R_CHMAP_INFO:
         qemu_log_mask(LOG_UNIMP,
-- 
2.39.2


