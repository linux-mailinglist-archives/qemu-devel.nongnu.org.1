Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB38249A4
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:36:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUQZ-0003Wl-He; Thu, 04 Jan 2024 15:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQS-0003SO-BA
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:48 -0500
Received: from mailout08.t-online.de ([194.25.134.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQQ-0004LQ-PU
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:48 -0500
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
 by mailout08.t-online.de (Postfix) with SMTP id 4DFC42EA7;
 Thu,  4 Jan 2024 21:34:45 +0100 (CET)
Received: from linpower.localnet ([93.236.158.98]) by fwd78.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rLUQO-3Xzwx70; Thu, 4 Jan 2024 21:34:44 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 5F9842001D2; Thu,  4 Jan 2024 21:34:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 10/10] hw/audio/virtio-sound: add placeholder for buffer write
 position
Date: Thu,  4 Jan 2024 21:34:22 +0100
Message-Id: <20240104203422.12308-10-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704400484-5E75E979-2A84A121/0/0 CLEAN NORMAL
X-TOI-MSGID: 4808f50d-700a-4bc4-a9ec-325450c8143d
Received-SPF: pass client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
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

When a running audio stream is migrated, on average half of a
recording stream buffer is lost or half of a playback stream
buffer is played twice. Add a placeholder for the write position
of the current stream buffer to the migrated data. Additional
program code is required to resolve the above issues. However,
the placeholder makes it possible to add code in a backwards and
forwards compatible way.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 2 ++
 include/hw/audio/virtio-snd.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 328ee54808..71281967bf 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -83,6 +83,7 @@ static const VMStateDescription vmstate_virtio_snd_stream = {
     .name = "virtio-sound-stream",
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(buf_wpos, VirtIOSoundPCMStream),
         VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
         VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
         VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
@@ -1434,6 +1435,7 @@ static int virtio_snd_post_load(VirtIODevice *vdev)
                 virtio_snd_pcm_set_active(stream, true);
             }
         }
+        stream->buf_wpos = 0;
     }
 
     for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 141e60e23c..d46204967a 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -127,6 +127,8 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_set_params params;
     uint32_t id;
     uint32_t state;
+    /* placeholder: write position in current VirtIOSoundPCMBuffer */
+    uint32_t buf_wpos;
     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
-- 
2.35.3


