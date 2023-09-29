Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE87B345C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:11:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEC0-00005x-7y; Fri, 29 Sep 2023 10:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBv-0008Qj-Ix
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBp-0004KO-3j
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so39971185e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996595; x=1696601395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOeEdvV6DAkfUxJlnz6FZNvOuMxe5esBNld1PloY0FI=;
 b=NthAk8UMjZTOW+X1m7o6cavio8Ppf9XkfuauREuydI60QK9NLSlfQqT2Aj7qCkY6mv
 jGPs1OWBjET0cqogkIjtHcgGz8xJbZPTo7yhI3UvTwrbdqyQNpVP0ED2LbONduZGAaFO
 sc2agi3BwC3M90UiRAYCZChujPs7PBuiWET9J8OynvGKUKeC0IUZoZfpJAwCizuJ4Wq+
 U9fNc1Zgl1/Uy0MyciC3arl1H/fHgL46uWtF3rFvdz0Xhk5x1S8hDLHW0yky2zoGhmxy
 bRTj5sC9xZ+codgpU2mhH/3d5hIKKRrZQtd6T57urxc73piQCSxVhqqKtXDR6GVhN+gv
 3jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996595; x=1696601395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UOeEdvV6DAkfUxJlnz6FZNvOuMxe5esBNld1PloY0FI=;
 b=DS28avqeGMBPGP/z5A7pjBN3vZIpH7VaHxXW3ZpN4nukiRXyb60fGeKjYOGn0bVlXW
 o/hnBjxP0cW7rp/K+HfEW7MCwMg5lCtxZPghqCmF+rzEYu0a438Y0Uvsu/NMwLy7te/+
 q4X8u423UzZvHtj5FyJWaOzUOhEeQ0QnUuce3zUqzoLvAIYsKN2/Nay/UtdPDR7aRm6f
 FOfove5JLagqEvr2bpMHCzgdQAr4JMHmVgjwa+P8UBG6Y+65Rzr8pxy0CpUVCdLnRH68
 HVMHALvMG9I4i91YXAIBZqe2H+0CjyrKxgxj43yIKChOEJZRQkUNGSvd9NJlXw2oiFZ/
 DIzA==
X-Gm-Message-State: AOJu0YyWUq6xZLXboei/r0QTVtILsYYxdQNtUnqjQFNSh8UxR+7GxxRb
 hRhyG3gp2tdxkHL/TJJc0QKU+SH9/ceyfxzr8Qw=
X-Google-Smtp-Source: AGHT+IFfMSbRNIljZaFoXO4RWd7ptkpwYvO1tKsWsKX0J+JFR0EQ6cdkcwXtvbdqYBCElXVH+Lv0fA==
X-Received: by 2002:a05:6000:1106:b0:323:2f16:66ee with SMTP id
 z6-20020a056000110600b003232f1666eemr3534019wrw.71.1695996595347; 
 Fri, 29 Sep 2023 07:09:55 -0700 (PDT)
Received: from localhost.localdomain (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b004030e8ff964sm1505232wmj.34.2023.09.29.07.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:09:54 -0700 (PDT)
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
Subject: [PATCH v10 07/11] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Fri, 29 Sep 2023 17:08:27 +0300
Message-Id: <9e8d9923ba782fed4a34c53049548c1753604501.1695996196.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

Handles the PCM prepare control request. It initializes a PCM stream
when the guests asks for it.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/virtio-snd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 4b5cb6b01f..8ed0e9b130 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -478,6 +478,28 @@ static const char *print_code(uint32_t code)
     #undef CASE
 };
 
+/*
+ * Handles VIRTIO_SND_R_PCM_PREPARE.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
+                                          virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               sizeof(virtio_snd_hdr),
+                               &stream_id,
+                               sizeof(stream_id));
+
+    stream_id = le32_to_cpu(stream_id);
+    cmd->resp.code = msg_sz == sizeof(stream_id)
+                   ? virtio_snd_pcm_prepare(s, stream_id)
+                   : cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+}
+
 /*
  * Handles VIRTIO_SND_R_PCM_START.
  *
@@ -569,6 +591,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_set_params(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_PREPARE:
+        virtio_snd_handle_pcm_prepare(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
-- 
2.39.2


