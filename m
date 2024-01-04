Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044182499C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:35:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUQG-0003Cu-AR; Thu, 04 Jan 2024 15:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQD-0003Bz-AZ
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:33 -0500
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQA-0004Jd-Fg
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:33 -0500
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
 by mailout06.t-online.de (Postfix) with SMTP id 9FC4740A4;
 Thu,  4 Jan 2024 21:34:28 +0100 (CET)
Received: from linpower.localnet ([93.236.158.98]) by fwd76.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rLUQ4-38jvQP0; Thu, 4 Jan 2024 21:34:25 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 46F6420024C; Thu,  4 Jan 2024 21:34:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 02/10] hw/audio/virtio-sound: allocate all streams in advance
Date: Thu,  4 Jan 2024 21:34:14 +0100
Message-Id: <20240104203422.12308-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704400465-FA7FB94C-94D56E5B/0/0 CLEAN NORMAL
X-TOI-MSGID: 2315c63e-0cad-4633-816e-443161c0b59f
Received-SPF: pass client-ip=194.25.134.19;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout06.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It is much easier to migrate an array of structs than individual
structs that are accessed via a pointer to a pointer to an array
of pointers to struct, where some pointers can also be NULL.

For this reason, the audio streams are already allocated during
the realization phase and all stream variables that are constant
at runtime are initialised immediately after allocation. This is
a step towards being able to migrate the audio streams of the
virtio sound device after the next few patches.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 35 ++++++++++++++++++++++-------------
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 8344f61c64..36b1bb502c 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -447,11 +447,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        stream = g_new0(VirtIOSoundPCMStream, 1);
+        stream = &s->streams[stream_id];
         stream->active = false;
-        stream->id = stream_id;
         stream->pcm = s->pcm;
-        stream->s = s;
         QSIMPLEQ_INIT(&stream->queue);
         QSIMPLEQ_INIT(&stream->invalid);
 
@@ -463,14 +461,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     }
 
     virtio_snd_get_qemu_audsettings(&as, params);
-    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
-        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
-    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
-    stream->info.features = 0;
-    stream->info.channels_min = 1;
-    stream->info.channels_max = as.nchannels;
-    stream->info.formats = supported_formats;
-    stream->info.rates = supported_rates;
     stream->params = *params;
 
     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
@@ -1074,6 +1064,24 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
+    vsnd->streams = g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.streams);
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
+
+        stream->id = i;
+        stream->s = vsnd;
+        stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
+        stream->info.features = 0;
+        stream->info.formats = supported_formats;
+        stream->info.rates = supported_rates;
+        stream->info.direction =
+            i < vsnd->snd_conf.streams / 2 + (vsnd->snd_conf.streams & 1)
+            ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
+        stream->info.channels_min = 1;
+        stream->info.channels_max = 2;
+    }
+
     vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
     vsnd->pcm->snd = vsnd;
     vsnd->pcm->streams =
@@ -1314,14 +1322,13 @@ static void virtio_snd_unrealize(DeviceState *dev)
     qemu_del_vm_change_state_handler(vsnd->vmstate);
     trace_virtio_snd_unrealize(vsnd);
 
-    if (vsnd->pcm) {
+    if (vsnd->streams) {
         if (vsnd->pcm->streams) {
             for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
                 stream = vsnd->pcm->streams[i];
                 if (stream) {
                     virtio_snd_process_cmdq(stream->s);
                     virtio_snd_pcm_close(stream);
-                    g_free(stream);
                 }
             }
             g_free(vsnd->pcm->streams);
@@ -1329,6 +1336,8 @@ static void virtio_snd_unrealize(DeviceState *dev)
         g_free(vsnd->pcm->pcm_params);
         g_free(vsnd->pcm);
         vsnd->pcm = NULL;
+        g_free(vsnd->streams);
+        vsnd->streams = NULL;
     }
     AUD_remove_card(&vsnd->card);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index ea6315f59b..05b4490488 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -216,6 +216,7 @@ struct VirtIOSound {
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCM *pcm;
+    VirtIOSoundPCMStream *streams;
     QEMUSoundCard card;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-- 
2.35.3


