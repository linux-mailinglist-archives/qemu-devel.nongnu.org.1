Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1A8249A5
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:36:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUQL-0003E9-Dt; Thu, 04 Jan 2024 15:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQJ-0003Dr-4e
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:39 -0500
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQH-0004KK-DC
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:38 -0500
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
 by mailout12.t-online.de (Postfix) with SMTP id 93C4A2134C;
 Thu,  4 Jan 2024 21:34:34 +0100 (CET)
Received: from linpower.localnet ([93.236.158.98]) by fwd71.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rLUQC-2fhLBB0; Thu, 4 Jan 2024 21:34:32 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 5051E2001C7; Thu,  4 Jan 2024 21:34:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 05/10] hw/audio/virtio-sound: return correct command response
 size
Date: Thu,  4 Jan 2024 21:34:17 +0100
Message-Id: <20240104203422.12308-5-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704400472-E626F957-4DBA4646/0/0 CLEAN NORMAL
X-TOI-MSGID: 3cec086b-da06-42a1-be0f-d300390acd78
Received-SPF: pass client-ip=194.25.134.22;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout12.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The payload size returned by command VIRTIO_SND_R_PCM_INFO is
wrong. The code in process_cmd() assumes that all commands
return only a virtio_snd_hdr payload, but some commands like
VIRTIO_SND_R_PCM_INFO may return an additional payload.

Add a zero initialized payload_size variable to struct
virtio_snd_ctrl_command to allow for additional payloads.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 7 +++++--
 include/hw/audio/virtio-snd.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index a2817a64b5..9f3269d72b 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -262,12 +262,13 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
         memset(&pcm_info[i].padding, 0, 5);
     }
 
+    cmd->payload_size = sizeof(virtio_snd_pcm_info) * count;
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     iov_from_buf(cmd->elem->in_sg,
                  cmd->elem->in_num,
                  sizeof(virtio_snd_hdr),
                  pcm_info,
-                 sizeof(virtio_snd_pcm_info) * count);
+                 cmd->payload_size);
 }
 
 /*
@@ -805,7 +806,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                  0,
                  &cmd->resp,
                  sizeof(virtio_snd_hdr));
-    virtqueue_push(cmd->vq, cmd->elem, sizeof(virtio_snd_hdr));
+    virtqueue_push(cmd->vq, cmd->elem,
+                   sizeof(virtio_snd_hdr) + cmd->payload_size);
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
@@ -856,6 +858,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         cmd->elem = elem;
         cmd->vq = vq;
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+        /* implicit cmd->payload_size = 0; */
         QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     }
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index d1a68444d0..d6e08bd30d 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -210,6 +210,7 @@ struct virtio_snd_ctrl_command {
     VirtQueue *vq;
     virtio_snd_hdr ctrl;
     virtio_snd_hdr resp;
+    size_t payload_size;
     QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
 };
 #endif
-- 
2.35.3


