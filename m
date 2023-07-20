Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A975AEE6
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTE4-0004yC-Lv; Thu, 20 Jul 2023 08:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTE1-0004y1-QD
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:57:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTDy-0003w8-Pl
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:57:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso620543f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689857860; x=1690462660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GUOlfB9l85q5a53c+XK/NwPyEKzoSvERns9bPLnNf3c=;
 b=VThPNAE3R4W3pJ1XfSFp5sZZ+GofZjZZzZQw1Q5G/aGDfIPPMuwBO5/0H2sk1wHK70
 tCniRPIsnnWnN0XTB3ruQq9u99omToSdPfZCtWOpKf91NFcXvGzvEW4GJ4unp8EPywTJ
 hAetQwTKfYPF7fWLWbZI1TG4ehQPmmf2FkibjRnKXMKtdIyQDdX+P5T2a6CKdbc+gv30
 OgIR92drm/FUgcUjlp3gbIotuFN4kGYOxCDvekwsgNxJwmZ48pAPXOyzj7tXuhCpY+0i
 kfiFadnqHj+niXJI6Enj6yWLlEJquRExgBT/HacjwGvSiBJjQ5nM8DTY/MRiVmTS8FZV
 lEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689857860; x=1690462660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUOlfB9l85q5a53c+XK/NwPyEKzoSvERns9bPLnNf3c=;
 b=E6S/qjSmAVZ+JHT/uFIu+jSVQJHyMtFkCCdFLK0kAXRjSjSFxqvGi9QnK0r1VqvWuB
 ELrjVjuZUSBfDsN2iRPQBSAKqwWQRodGYED6xh3xOmXnlEmHxDhG856C78KskXdek5NX
 L991hVP7/XJ0TZ7WWpTgzB/p0atK9rrrRYlRkFgzRecWiBVtYf51E5K8/TCt0pmcMEAm
 bH7c4cIe+6SbjBRvfRRjGfwgR3au+DC7FqGaL94Ydmgh4w0Hmc/KevuRpXQTefoxukKf
 TkLoOFTPu/TtkuOvmcnNMh3+eh+JaNjjbYUCmdWwgCCmkUde9mT62Z2gE3/NMTQAjRBR
 klZQ==
X-Gm-Message-State: ABy/qLZ2oEgcg9xvaoAcnEvnRZAQ67pWfFZpNN+Kw6MtFJWo9HlNrkTD
 V2w8AnL8QrLSz4tqyE7X5aa7plI/zRVdpa44VE4qCnmz
X-Google-Smtp-Source: APBJJlH0wB1LNBUqjXW5KitQiADMDD8aB1NQBgrEe8KU1gdHT3mDLSYM5Ly1NWh125hGhftS9jzoSQ==
X-Received: by 2002:adf:f245:0:b0:314:1a63:be9a with SMTP id
 b5-20020adff245000000b003141a63be9amr2116588wrp.26.1689857860326; 
 Thu, 20 Jul 2023 05:57:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-41.37.6.162.tellas.gr.
 [37.6.162.41]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b003063a92bbf5sm1294816wrs.70.2023.07.20.05.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 05:57:39 -0700 (PDT)
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
Subject: [PATCH v4 00/12] Add VIRTIO sound card
Date: Thu, 20 Jul 2023 15:57:01 +0300
Message-Id: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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

This patch series adds an audio device implementing the recent virtio 
sound spec (1.2) and a corresponding PCI wrapper device.

Main differences with v3 patch [^v3]
<cover.1689692765.git.manos.pitsidianakis@linaro.org>:
- Addressed review style comments.
- Split patches for easier review.

[^v3]: 
https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/

Emmanouil Pitsidianakis (12):
  Add virtio-sound device stub
  Add virtio-sound-pci device
  virtio-sound: handle control messages and streams
  virtio-sound: set PCM stream parameters
  virtio-sound: prepare PCM streams
  virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
  virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
  virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
  virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
  virtio-sound: handle VIRTIO_SND_PCM_RELEASE
  virtio-sound: implement audio output (TX)
  virtio-sound: implement audio capture (RX)

 MAINTAINERS                    |    6 +
 hw/virtio/Kconfig              |    5 +
 hw/virtio/meson.build          |    2 +
 hw/virtio/trace-events         |   20 +
 hw/virtio/virtio-snd-pci.c     |   91 +++
 hw/virtio/virtio-snd.c         | 1298 ++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h           |    1 +
 include/hw/virtio/virtio-snd.h |  157 ++++
 softmmu/qdev-monitor.c         |    1 +
 9 files changed, 1581 insertions(+)
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

Range-diff against v3:
 1:  93c763e275 <  -:  ---------- Add virtio-sound device
 -:  ---------- >  1:  ae372de565 Add virtio-sound device stub
 2:  36373d92fa !  2:  5cde5472ea Add virtio-sound-pci device
    @@
      ## Metadata ##
    -Author: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
    +Author: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## Commit message ##
         Add virtio-sound-pci device
     
         This patch adds a PCI wrapper device for the virtio-sound device.
    +    It is necessary to instantiate a virtio-snd device in a guest.
    +    All sound logic will be added to the virtio-snd device in the following
    +    commits.
     
    -    To test this, you'll need a >=5.13 kernel compiled with
    -    CONFIG_SND_VIRTIO=y, which at the time of writing most distros have off
    -    by default.
    +    To add this device with a guest, you'll need a >=5.13 kernel compiled
    +    with CONFIG_SND_VIRTIO=y, which at the time of writing most distros have
    +    off by default.
     
         Use with following flags in the invocation:
     
    @@ Commit message
     
         Pulseaudio:
           -audio driver=pa,model=virtio-sound
    +      or
    +      -audio driver=pa,model=virtio-sound,server=/run/user/1000/pulse/native
         sdl:
           -audio driver=sdl,model=virtio-sound
         coreaudio (macos/darwin):
           -audio driver=coreaudio,model=virtio-sound
         etc.
     
    -    You can use speaker-test from alsa-tools to play noise, sines, or
    -    WAV files.
    -
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/meson.build ##
    @@ hw/virtio/virtio-snd-pci.c (new)
     +{
     +    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(vpci_dev);
     +    DeviceState *vdev = DEVICE(&dev->vdev);
    -+    VirtIOSound *vsnd = VIRTIO_SND(&dev->vdev);
    -+
    -+    /*
    -+     * According to spec, non-legacy virtio PCI devices are always little
    -+     * endian
    -+     */
    -+    vsnd->virtio_access_is_big_endian = false;
    -+
     +
     +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
    -+
     +    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
    -+
     +    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
     +}
     +
 -:  ---------- >  3:  dc65cac2f4 virtio-sound: handle control messages and streams
 -:  ---------- >  4:  bbd1799fc9 virtio-sound: set PCM stream parameters
 -:  ---------- >  5:  68a13c4385 virtio-sound: prepare PCM streams
 -:  ---------- >  6:  f267d41957 virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
 -:  ---------- >  7:  5939a6161e virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
 -:  ---------- >  8:  8f78d3a132 virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
 -:  ---------- >  9:  d2b3854084 virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
 -:  ---------- > 10:  4e14b2d129 virtio-sound: handle VIRTIO_SND_PCM_RELEASE
 -:  ---------- > 11:  a6a0f07c7a virtio-sound: implement audio output (TX)
 3:  8d432c85a2 ! 12:  1abb69dd05 Implement audio capture in virtio-snd device
    @@
      ## Metadata ##
    -Author: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
    +Author: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## Commit message ##
    -    Implement audio capture in virtio-snd device
    +    virtio-sound: implement audio capture (RX)
    +
    +    To perform audio capture we duplicate the TX logic of the previous
    +    commit with the following difference: we receive data from the QEMU
    +    audio backend and write it in the virt queue IO buffers the guest sends
    +    to QEMU. When they are full (i.e. they have `period_bytes` amount of
    +    data) or when recording stops in QEMU's audio backend, the buffer is
    +    returned to the guest by notifying it.
     
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/trace-events ##
    -@@ hw/virtio/trace-events: virtio_snd_handle_pcm_set_params(int stream) "VIRTIO_SND_PCM_SET_PARAMS called f
    - virtio_snd_handle_pcm_start_stop(const char *code, int stream) "%s called for stream %d"
    - virtio_snd_handle_pcm_release(int stream) "VIRTIO_SND_PCM_RELEASE called for stream %d"
    +@@ hw/virtio/trace-events: virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PR
      virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
    + virtio_snd_handle_event(void) "event queue callback called"
    + virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
     -virtio_snd_handle_xfer(void) "tx/rx queue callback called"
     +virtio_snd_handle_tx_xfer(void) "tx queue callback called"
    -+virtio_snd_handle_rx_xfer(void) "rx queue callback called"
    - virtio_snd_handle_event(void) "event queue callback called"
    - virtio_snd_realize(void *snd) "snd %p: realize"
    - virtio_snd_unrealize(void *snd) "snd %p: unrealize"
    ++virtio_snd_handle_rx_xfer(void) "tx queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
     @@
    - #define VIRTIO_SOUND_VM_VERSION 1
      
    + #define VIRTIO_SOUND_VM_VERSION 1
      #define VIRTIO_SOUND_JACK_DEFAULT 0
     -#define VIRTIO_SOUND_STREAM_DEFAULT 1
     +#define VIRTIO_SOUND_STREAM_DEFAULT 2
      #define VIRTIO_SOUND_CHMAP_DEFAULT 0
    - 
      #define VIRTIO_SOUND_HDA_FN_NID 0
    -@@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
    - }
      
    + static void virtio_snd_pcm_out_cb(void *data, int available);
      static void virtio_snd_process_cmdq(VirtIOSound *s);
     -static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
    +-static uint32_t
    +-virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
    +-                          VirtQueue *vq,
    +-                          VirtQueueElement *element,
    +-                          bool read);
     +static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
     +static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
    - static void virtio_snd_pcm_out_cb(void *data, int available);
    --static uint32_t virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
     +static void virtio_snd_pcm_in_cb(void *data, int available);
     +static uint32_t virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
    -                                           VirtQueue *vq,
    --                                          VirtQueueElement *element,
    --                                          bool read);
    -+                                          VirtQueueElement *element);
    ++                                     VirtQueue *vq,
    ++                                     VirtQueueElement *element);
     +static uint32_t virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
    -+                                          VirtQueue *vq,
    -+                                          VirtQueueElement *element);
    ++                                    VirtQueue *vq,
    ++                                    VirtQueueElement *element);
      
    - /*
    -  * Get a specific stream from the virtio sound card device.
    + static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
    +                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
     @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
    +                                          virtio_snd_pcm_out_cb,
                                               &as);
    - 
          } else {
     -        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
    --        /*
    --         * stream->voice.in = AUD_open_in(&s->card,
    --         *                                stream->voice.in,
    --         *                                "virtio_snd_card",
    --         *                                stream,
    --         *                                virtio_snd_input_cb,
    --         *                                &as);
    --         */
     +        stream->voice.in = AUD_open_in(&s->card,
     +                                        stream->voice.in,
     +                                        "virtio_snd_card",
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +            AUD_set_active_in(stream->voice.in, start);
              }
          } else {
    -         error_report("Invalid stream id: %d", req.stream_id);
    +         error_report("Invalid stream id: %"PRIu32, req.stream_id);
     @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
               */
              virtio_snd_process_cmdq(stream->s);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
       * @vdev: VirtIOSound device
       * @vq: tx virtqueue
       */
    --static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
    +-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
     +static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
      {
          VirtIOSound *s = VIRTIO_SND(vdev);
          VirtIOSoundPCMStream *stream = NULL;
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
          virtio_snd_pcm_xfer hdr;
          virtio_snd_pcm_status resp = { 0 };
      
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_xfer(VirtIODevice *vdev, V
      
          for (;;) {
              elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
                  goto tx_err;
              }
      
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_xfer(VirtIODevice *vdev, V
                  resp.status = VIRTIO_SND_S_OK;
                  iov_from_buf(elem->in_sg,
     @@ hw/virtio/virtio-snd.c: tx_err:
    -     virtio_notify(VIRTIO_DEVICE(s), vq);
      }
      
    -+/*
    + /*
    +- * Stub buffer virtqueue handler.
     + * The rx virtqueue handler. Makes the buffers available to their respective
     + * streams for consumption.
    -+ *
    -+ * @vdev: VirtIOSound device
    +  *
    +  * @vdev: VirtIOSound device
    +- * @vq: virtqueue
     + * @vq: tx virtqueue
    -+ */
    +  */
    +-static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
     +static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     +{
     +    VirtIOSound *s = VIRTIO_SND(vdev);
    @@ hw/virtio/virtio-snd.c: tx_err:
     +     */
     +    virtio_notify(VIRTIO_DEVICE(s), vq);
     +}
    -+
    -+
    + 
      static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                                   Error **errp)
    - {
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
          virtio_snd_common_realize(dev,
                                    virtio_snd_handle_ctrl,
                                    virtio_snd_handle_event,
    --                              virtio_snd_handle_xfer,
    +-                              virtio_snd_handle_tx,
     -                              virtio_snd_handle_xfer,
     +                              virtio_snd_handle_tx_xfer,
     +                              virtio_snd_handle_rx_xfer,
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     -    VirtIOSoundPCMBlock *next;
     +    uint32_t sz;
     +    virtio_snd_pcm_status resp = { 0 };
    -+    int size;
    ++    size_t size;
      
          WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     -        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +                        MIN(stream->period_bytes - block->offset, available));
     +                block->offset += size;
     +                block->size += size;
    -+                if (size == 0 || block->size == stream->period_bytes) {
    ++                if (size == 0 || block->size >= stream->period_bytes) {
     +                    resp.status = VIRTIO_SND_S_OK;
     +                     sz = iov_from_buf(block->elem->in_sg,
     +                                  block->elem->in_num,
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +                                     block->elem->in_num,
     +                                     sz,
     +                                     &block->data,
    -+                                     block->size);
    ++                                     MIN(stream->period_bytes, block->size));
     +                    }
     +                    virtqueue_push(block->vq,
     +                            block->elem,

base-commit: 2c27fdc7a626408ee2cf30d791aa0b63027c7404
-- 
2.39.2


