Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C44477C56F6
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:36:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJQ-0000Cn-S3; Wed, 11 Oct 2023 10:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJK-0000By-N0
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:35:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJF-0005Jz-Ql
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:35:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so70800905e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034935; x=1697639735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YTS6EvrIj4LE4768Ftg7X6byBO9VxSHDRfQ26Xl/07c=;
 b=rxkyaz915fWSZgoH0R0WBlMXkf3UKyVDjDbU9bxAbHSRP5RM754vWZvY7o4ppVEGR0
 0q6tM+7wugZJS3NbF4xJs7c/mfGHqqKZFDNVv9bIgtBHZvePKDaDG23mxJFrYKFYJMY/
 p6apLbsOkJUsj4cO4OSg53XGLIKV17+2EA+3HsGcOvqtxSYUea1BZTh0pKpK+OBP1neb
 gDevsQeVCqZWuAZOW7wn9+eKnCw8nrkOYOq9D+ckB+isBUWL4egqOogfz/4TWcj40r0+
 XyqB8O6kBJPvryGLEBdd+bJoz70IbLGroi5chh8rhhmniU411HsKnuHKxJVy+WN+LD5o
 FdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034935; x=1697639735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YTS6EvrIj4LE4768Ftg7X6byBO9VxSHDRfQ26Xl/07c=;
 b=eiqSF/3HBZkZ2w/AO2jkjcO6U7Z9NGPHbzOxv3YfQIcFn5AP/JFU4XYdpKIBbE6d26
 WLgsDB3SJkKxlYiYcXgJB+8kQtlxOsq/M+6f6VDbJINsT17gPSXQMDkAXM/h+Xxf6eUn
 ZHHSrngth+oZfrUnrN02sxPVYW3rfi2TR0wRj8yBK2zGjBl0KDvSTOsEwRzUbEZRyLnl
 cOXSSm7urav7JjWzqnLkr/BA6iiReNd7YeKDS9m2PtKJjdNNMCy2KdC1WDYBHqMoxv3H
 owQZhDb3VCoaUaNyYMnPniiIpwC1gmTFYTZUptkxn0XQIeS5U2jnqK0L/dy1FYKEYpA+
 RRzw==
X-Gm-Message-State: AOJu0Yz7jf9jUjcg8CFMywXogH+ju3V9E9ytJ/P1LUXnfiZf2pmg6qpX
 nB1YjeR1gXF+wlAp71S7rz3yL45tBteNnLiiaAI=
X-Google-Smtp-Source: AGHT+IHzeBc2NKCWyKP6XLngKyc8tbOEX8iI+h7NesCco6vU9N3G/Rk/NqxetMr6MKWOHReHHQ0NCA==
X-Received: by 2002:a05:600c:21d1:b0:406:53ab:a9af with SMTP id
 x17-20020a05600c21d100b0040653aba9afmr20023296wmj.10.1697034934516; 
 Wed, 11 Oct 2023 07:35:34 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:35:33 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Google-Original-From: Manos Pitsidianakis <manos@pitsidianak.is>
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
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v11 00/11] Add VIRTIO sound card
Date: Wed, 11 Oct 2023 17:34:45 +0300
Message-Id: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

This patch series adds an audio device implementing the recent virtio 
sound spec (1.2) and a corresponding PCI wrapper device.

v11 can be found online at:

https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v11

Ref 885b01fe272541fdab5583780d4c3a59bfd8e734

Main differences with v10 patch series [^v10]
<cover.1695996196.git.manos.pitsidianakis@linaro.org>:

- Rebased against upstream, which has minor changes to the AUD_* API.
- Fixed noise in playback because of invalid bounds when accessing the 
  audio data in the VirtQueueElement.
- Refactor invalid I/O message queue flushing into separate function.
- Removed attempt to write unwritten bytes to QEMU sound backend when 
  flushing: it should only happen when the stream STARTs.
- Set latency_bytes to buffer size when returning TX I/O message because 
  it happens immediately after writing the last bytes to the QEMU 
  backend, therefore there might be up to <buffer size> bytes to be 
  played before all the buffer data has finished playing.
- Addressed [^v10] review comments:
  - Refactored VirtIOSoundPCMBuffer return code into a function instead 
    of using goto labels in output/input audio callbacks. (Suggested by 
    <philmd@linaro.org>)

Previously:

[^v10]: 
https://lore.kernel.org/qemu-devel/cover.1695996196.git.manos.pitsidianakis@linaro.org/
[^v9]: 
https://lore.kernel.org/qemu-devel/cover.1694588927.git.manos.pitsidianakis@linaro.org/
[^v8]: 
https://lore.kernel.org/qemu-devel/cover.1693252037.git.manos.pitsidianakis@linaro.org/
[^v7]: 
https://lore.kernel.org/qemu-devel/cover.1692731646.git.manos.pitsidianakis@linaro.org/
[^v6]: 
https://lore.kernel.org/qemu-devel/cover.1692089917.git.manos.pitsidianakis@linaro.org/
[^v5]: 
https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/
[^v4]: 
https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/
[^v3]: 
https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/

Emmanouil Pitsidianakis (11):
  Add virtio-sound device stub
  Add virtio-sound-pci device
  virtio-sound: handle control messages and streams
  virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
  virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
  virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
  virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
  virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
  virtio-sound: implement audio output (TX)
  virtio-sound: implement audio capture (RX)
  docs/system: add basic virtio-snd documentation

 MAINTAINERS                              |    7 +
 docs/system/device-emulation.rst         |    1 +
 docs/system/devices/virtio-snd.rst (new) |   49 +
 hw/virtio/Kconfig                        |    5 +
 hw/virtio/meson.build                    |    2 +
 hw/virtio/trace-events                   |   20 +
 hw/virtio/virtio-snd-pci.c (new)         |   93 ++
 hw/virtio/virtio-snd.c (new)             | 1409 ++++++++++++++++++++++
 include/hw/virtio/virtio-snd.h (new)     |  235 ++++
 system/qdev-monitor.c                    |    1 +
 10 files changed, 1822 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

Range-diff against v10:
 1:  6e7bdf6dda !  1:  03ecf1f615 Add virtio-sound device stub
    @@ hw/virtio/virtio-snd.c (new)
     +        return;
     +    }
     +
    -+    AUD_register_card("virtio-sound", &vsnd->card);
    ++    AUD_register_card("virtio-sound", &vsnd->card, errp);
     +
     +    vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
     +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
 2:  82138b9c7d !  2:  ba49f45eb3 Add virtio-sound-pci device
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
      
      /*
     
    - ## softmmu/qdev-monitor.c ##
    -@@ softmmu/qdev-monitor.c: static const QDevAlias qdev_alias_table[] = {
    + ## system/qdev-monitor.c ##
    +@@ system/qdev-monitor.c: static const QDevAlias qdev_alias_table[] = {
          { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
          { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
          { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
 3:  c1a2cb0304 !  3:  5831b5cfa5 virtio-sound: handle control messages and streams
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
      
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
      
    -     AUD_register_card("virtio-sound", &vsnd->card);
    +     AUD_register_card("virtio-sound", &vsnd->card, errp);
      
     +    /* set default params for all streams */
     +    default_params.features = 0;
 4:  28b2ecfa1f =  4:  425cbc2986 virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
 5:  a52d20b2c3 =  5:  d1403721fa virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
 6:  25fbb2eb25 =  6:  68ac43df35 virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
 7:  9e8d9923ba =  7:  175e6fbe75 virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
 8:  b50c94decc =  8:  93a5b96b58 virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
 9:  4cbb908742 !  9:  34be52e56e virtio-sound: implement audio output (TX)
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
     +    if (!virtio_queue_ready(vq)) {
     +        return;
     +    }
    -+    trace_virtio_snd_handle_tx_xfer();
    ++    trace_virtio_snd_handle_xfer();
     +
     +    for (;;) {
     +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
     +        }
     +
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            size = iov_size(elem->out_sg, elem->out_num);
    ++            size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
     +
     +            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
     +            buffer->elem = elem;
    -+            buffer->stale = true;
    ++            buffer->populated = false;
     +            buffer->vq = vq;
     +            buffer->size = size;
    -+            buffer->offset = sizeof(virtio_snd_pcm_xfer);
    ++            buffer->offset = 0;
     +
     +            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
     +        }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
          }
      }
      
    ++static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
    ++                                    VirtIOSoundPCMBuffer *buffer)
    ++{
    ++    virtio_snd_pcm_status resp = { 0 };
    ++    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
    ++    resp.latency_bytes = cpu_to_le32((uint32_t)buffer->size);
    ++    iov_from_buf(buffer->elem->in_sg,
    ++                 buffer->elem->in_num,
    ++                 0,
    ++                 &resp,
    ++                 sizeof(virtio_snd_pcm_status));
    ++    virtqueue_push(buffer->vq,
    ++                   buffer->elem,
    ++                   sizeof(virtio_snd_pcm_status));
    ++    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
    ++    QSIMPLEQ_REMOVE(&stream->queue,
    ++                    buffer,
    ++                    VirtIOSoundPCMBuffer,
    ++                    entry);
    ++    virtio_snd_pcm_buffer_free(buffer);
    ++}
    ++
     +/*
     + * AUD_* output callback.
     + *
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +            }
     +            if (!stream->active) {
     +                /* Stream has stopped, so do not perform AUD_write. */
    -+                goto return_tx_buffer;
    ++                return_tx_buffer(stream, buffer);
    ++                continue;
     +            }
    -+            if (buffer->stale) {
    ++            if (!buffer->populated) {
     +                iov_to_buf(buffer->elem->out_sg,
     +                           buffer->elem->out_num,
    -+                           buffer->offset,
    ++                           sizeof(virtio_snd_pcm_xfer),
     +                           buffer->data,
     +                           buffer->size);
    -+                buffer->stale = false;
    ++                buffer->populated = true;
     +            }
     +            for (;;) {
     +                size = AUD_write(stream->voice.out,
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +                buffer->offset += size;
     +                available -= size;
     +                if (buffer->size < 1) {
    -+return_tx_buffer:
    -+                    virtio_snd_pcm_status resp = { 0 };
    -+                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
    -+                    resp.latency_bytes = 0;
    -+                    iov_from_buf(buffer->elem->in_sg,
    -+                                 buffer->elem->in_num,
    -+                                 0,
    -+                                 &resp,
    -+                                 sizeof(virtio_snd_pcm_status));
    -+                    virtqueue_push(buffer->vq,
    -+                                   buffer->elem,
    -+                                   sizeof(virtio_snd_pcm_status));
    -+                    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
    -+                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                    virtio_snd_pcm_buffer_free(buffer);
    ++                    return_tx_buffer(stream, buffer);
     +                    break;
     +                }
     +                if (!available) {
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     + *
     + * @stream: VirtIOSoundPCMStream *stream
     + */
    -+static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
    ++static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
     +{
    -+    VirtIOSoundPCMBuffer *buffer, *next;
    ++    VirtIOSoundPCMBuffer *buffer;
     +
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
    -+            AUD_write(stream->voice.out,
    -+                      buffer->data + buffer->offset,
    -+                      buffer->size);
    -+            virtqueue_push(buffer->vq,
    -+                           buffer->elem,
    -+                           sizeof(VirtQueueElement));
    -+            virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
    -+            QSIMPLEQ_REMOVE(&stream->queue,
    -+                            buffer,
    -+                            VirtIOSoundPCMBuffer,
    -+                            entry);
    -+            virtio_snd_pcm_buffer_free(buffer);
    ++        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
    ++            buffer = QSIMPLEQ_FIRST(&stream->queue);
    ++            return_tx_buffer(stream, buffer);
     +        }
     +    }
     +}
    @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_ctrl_command virtio_sn
     + *
     + * In the case of TX (i.e. playback) buffers, we defer reading the raw PCM data
     + * from the virtqueue until QEMU's sound backsystem calls the output callback.
    -+ * This is tracked by the `bool stale;` field, which is set to false when data
    -+ * has been read into our own buffer for consumption.
    ++ * This is tracked by the `bool populated;` field, which is set to true when
    ++ * data has been read into our own buffer for consumption.
     + *
     + * VirtIOSoundPCMBuffer has a dynamic size since it includes the raw PCM data
     + * in its allocation. It must be initialized and destroyed as follows:
    @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_ctrl_command virtio_sn
     +     */
     +    uint64_t offset;
     +    /* Used for the TX queue for lazy I/O copy from `elem` */
    -+    bool stale;
    ++    bool populated;
     +    /*
     +     * VirtIOSoundPCMBuffer is an unsized type because it ends with an array of
     +     * bytes. The size of `data` is determined from the I/O message's read-only
10:  992b0d5ff4 ! 10:  68f9e0f298 virtio-sound: implement audio capture (RX)
    @@ hw/virtio/virtio-snd.c
      
      static void virtio_snd_pcm_out_cb(void *data, int available);
      static void virtio_snd_process_cmdq(VirtIOSound *s);
    --static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
    -+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
    -+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
    + static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
     +static void virtio_snd_pcm_in_cb(void *data, int available);
      
      static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                        | BIT(VIRTIO_SND_PCM_FMT_U8)
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_get_qemu_audsettings(audsettings *as,
    + static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
      {
          if (stream) {
    ++        virtio_snd_pcm_flush(stream);
              if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
     -            virtio_snd_pcm_flush(stream);
    -+            virtio_snd_pcm_out_flush(stream);
                  AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
                  stream->voice.out = NULL;
     +        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
    -+            virtio_snd_pcm_in_flush(stream);
     +            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
     +            stream->voice.in = NULL;
              }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
              }
          } else {
              error_report("Invalid stream id: %"PRIu32, stream_id);
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s,
    -          *   are pending I/O messages for the specified stream ID.
    -          */
    -         trace_virtio_snd_pcm_stream_flush(stream_id);
    --        virtio_snd_pcm_flush(stream);
    -+        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
    -+            virtio_snd_pcm_out_flush(stream);
    -+        } else {
    -+            virtio_snd_pcm_in_flush(stream);
    -+        }
    -     }
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
    +     trace_virtio_snd_handle_event();
    + }
      
    -     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
    ++static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
    ++{
    ++    VirtIOSoundPCMBuffer *buffer = NULL;
    ++    VirtIOSoundPCMStream *stream = NULL;
    ++    virtio_snd_pcm_status resp = { 0 };
    ++    VirtIOSound *vsnd = VIRTIO_SND(vdev);
    ++    bool any = false;
    ++
    ++    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
    ++        stream = vsnd->pcm->streams[i];
    ++        if (stream) {
    ++            any = false;
    ++            WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    ++                while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
    ++                    buffer = QSIMPLEQ_FIRST(&stream->invalid);
    ++                    if (buffer->vq != vq) {
    ++                        break;
    ++                    }
    ++                    any = true;
    ++                    resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    ++                    iov_from_buf(buffer->elem->in_sg,
    ++                                 buffer->elem->in_num,
    ++                                 0,
    ++                                 &resp,
    ++                                 sizeof(virtio_snd_pcm_status));
    ++                    virtqueue_push(vq,
    ++                                   buffer->elem,
    ++                                   sizeof(virtio_snd_pcm_status));
    ++                    QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
    ++                    virtio_snd_pcm_buffer_free(buffer);
    ++                }
    ++                if (any) {
    ++                    /*
    ++                     * Notify vq about virtio_snd_pcm_status responses.
    ++                     * Buffer responses must be notified separately later.
    ++                     */
    ++                    virtio_notify(vdev, vq);
    ++                }
    ++            }
    ++        }
    ++    }
    ++}
    ++
    + /*
    +  * The tx virtqueue handler. Makes the buffers available to their respective
    +  * streams for consumption.
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
       * @vdev: VirtIOSound device
       * @vq: tx virtqueue
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
      {
          VirtIOSound *s = VIRTIO_SND(vdev);
          VirtIOSoundPCMStream *stream = NULL;
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
    +     VirtQueueElement *elem;
    +     size_t msg_sz, size;
    +     virtio_snd_pcm_xfer hdr;
    +-    virtio_snd_pcm_status resp = { 0 };
    +     uint32_t stream_id;
    +     /*
    +      * If any of the I/O messages are invalid, put them in stream->invalid and
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
    +     if (!virtio_queue_ready(vq)) {
    +         return;
    +     }
    +-    trace_virtio_snd_handle_xfer();
    ++    trace_virtio_snd_handle_tx_xfer();
    + 
    +     for (;;) {
    +         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     @@ hw/virtio/virtio-snd.c: tx_err:
    +     }
    + 
    +     if (must_empty_invalid_queue) {
    +-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    +-            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
    +-                buffer = QSIMPLEQ_FIRST(&stream->invalid);
    +-
    +-                resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    +-                iov_from_buf(buffer->elem->in_sg,
    +-                             buffer->elem->in_num,
    +-                             0,
    +-                             &resp,
    +-                             sizeof(virtio_snd_pcm_status));
    +-                virtqueue_push(vq, buffer->elem, sizeof(virtio_snd_pcm_status));
    +-                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
    +-                virtio_snd_pcm_buffer_free(buffer);
    +-            }
    +-            /*
    +-             * Notify vq about virtio_snd_pcm_status responses.
    +-             * Buffer responses must be notified separately later.
    +-             */
    +-            virtio_notify(vdev, vq);
    +-        }
    ++        empty_invalid_queue(vdev, vq);
    +     }
      }
      
      /*
    @@ hw/virtio/virtio-snd.c: tx_err:
       *
       * @vdev: VirtIOSound device
     - * @vq: virtqueue
    -+ * @vq: tx virtqueue
    ++ * @vq: rx virtqueue
       */
     -static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
     +static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
    @@ hw/virtio/virtio-snd.c: tx_err:
     +    VirtQueueElement *elem;
     +    size_t msg_sz, size;
     +    virtio_snd_pcm_xfer hdr;
    -+    virtio_snd_pcm_status resp = { 0 };
     +    uint32_t stream_id;
     +    /*
     +     * if any of the I/O messages are invalid, put them in stream->invalid and
    @@ hw/virtio/virtio-snd.c: tx_err:
     +    }
     +
     +    if (must_empty_invalid_queue) {
    -+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
    -+                buffer = QSIMPLEQ_FIRST(&stream->invalid);
    -+
    -+                resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    -+                iov_from_buf(buffer->elem->in_sg,
    -+                             buffer->elem->in_num,
    -+                             0,
    -+                             &resp,
    -+                             sizeof(virtio_snd_pcm_status));
    -+                virtqueue_push(vq, buffer->elem, sizeof(virtio_snd_pcm_status));
    -+                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
    -+                virtio_snd_pcm_buffer_free(buffer);
    -+            }
    -+            /*
    -+             * Notify vq about virtio_snd_pcm_status responses.
    -+             * Buffer responses must be notified separately later.
    -+             */
    -+            virtio_notify(vdev, vq);
    -+        }
    ++        empty_invalid_queue(vdev, vq);
     +    }
     +}
      
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
          qemu_mutex_init(&vsnd->cmdq_mutex);
          QTAILQ_INIT(&vsnd->cmdq);
      
    -@@ hw/virtio/virtio-snd.c: return_tx_buffer:
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int available)
      }
      
      /*
     - * Flush all buffer data from this stream's queue into the driver's virtual
     - * queue.
    ++ * Flush all buffer data from this input stream's queue into the driver's
    ++ * virtual queue.
    ++ *
    ++ * @stream: VirtIOSoundPCMStream *stream
    ++ */
    ++static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
    ++                                    VirtIOSoundPCMBuffer *buffer)
    ++{
    ++    virtio_snd_pcm_status resp = { 0 };
    ++    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
    ++    resp.latency_bytes = 0;
    ++    /* Copy data -if any- to guest */
    ++    iov_from_buf(buffer->elem->in_sg,
    ++                 buffer->elem->in_num,
    ++                 0,
    ++                 buffer->data,
    ++                 buffer->size);
    ++    iov_from_buf(buffer->elem->in_sg,
    ++                 buffer->elem->in_num,
    ++                 buffer->size,
    ++                 &resp,
    ++                 sizeof(virtio_snd_pcm_status));
    ++    virtqueue_push(buffer->vq,
    ++                   buffer->elem,
    ++                   sizeof(virtio_snd_pcm_status) + buffer->size);
    ++    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
    ++    QSIMPLEQ_REMOVE(&stream->queue,
    ++                    buffer,
    ++                    VirtIOSoundPCMBuffer,
    ++                    entry);
    ++    virtio_snd_pcm_buffer_free(buffer);
    ++}
    ++
    ++
    ++/*
     + * AUD_* input callback.
    -  *
    -- * @stream: VirtIOSoundPCMStream *stream
    ++ *
     + * @data: VirtIOSoundPCMStream stream
     + * @available: number of bytes that can be read with AUD_read()
    -  */
    --static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
    ++ */
     +static void virtio_snd_pcm_in_cb(void *data, int available)
    - {
    --    VirtIOSoundPCMBuffer *buffer, *next;
    ++{
     +    VirtIOSoundPCMStream *stream = data;
     +    VirtIOSoundPCMBuffer *buffer;
    -+    virtio_snd_pcm_status resp = { 0 };
     +    size_t size;
    - 
    -     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    --        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
    --            AUD_write(stream->voice.out,
    --                      buffer->data + buffer->offset,
    --                      buffer->size);
    --            virtqueue_push(buffer->vq,
    --                           buffer->elem,
    --                           sizeof(VirtQueueElement));
    --            virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
    --            QSIMPLEQ_REMOVE(&stream->queue,
    --                            buffer,
    --                            VirtIOSoundPCMBuffer,
    --                            entry);
    --            virtio_snd_pcm_buffer_free(buffer);
    ++
    ++    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     +        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
     +            buffer = QSIMPLEQ_FIRST(&stream->queue);
     +            if (!virtio_queue_ready(buffer->vq)) {
    @@ hw/virtio/virtio-snd.c: return_tx_buffer:
     +            }
     +            if (!stream->active) {
     +                /* Stream has stopped, so do not perform AUD_read. */
    -+                goto return_rx_buffer;
    ++                return_rx_buffer(stream, buffer);
    ++                continue;
     +            }
     +
     +            for (;;) {
    @@ hw/virtio/virtio-snd.c: return_tx_buffer:
     +                buffer->size += size;
     +                available -= size;
     +                if (buffer->size >= stream->params.period_bytes) {
    -+return_rx_buffer:
    -+                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
    -+                    resp.latency_bytes = 0;
    -+                    /* Copy data -if any- to guest */
    -+                    iov_from_buf(buffer->elem->in_sg,
    -+                                 buffer->elem->in_num,
    -+                                 0,
    -+                                 buffer->data,
    -+                                 buffer->size);
    -+                    iov_from_buf(buffer->elem->in_sg,
    -+                                 buffer->elem->in_num,
    -+                                 buffer->size,
    -+                                 &resp,
    -+                                 sizeof(resp));
    -+                    virtqueue_push(buffer->vq,
    -+                                   buffer->elem,
    -+                                   sizeof(virtio_snd_pcm_status) +
    -+                                    buffer->size);
    -+                    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
    -+                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                    virtio_snd_pcm_buffer_free(buffer);
    ++                    return_rx_buffer(stream, buffer);
     +                    break;
     +                }
     +                if (!available) {
    @@ hw/virtio/virtio-snd.c: return_tx_buffer:
     +            if (!available) {
     +                break;
     +            }
    -         }
    -     }
    - }
    - 
    -+#define virtio_snd_pcm_flush(AUD_CB)                                         \
    -+    VirtIOSoundPCMBuffer *buffer;                                            \
    -+    virtio_snd_pcm_status resp = { 0 };                                      \
    -+    unsigned int len = 0;                                                    \
    -+    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);                              \
    -+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {                             \
    -+        while (!QSIMPLEQ_EMPTY(&stream->queue)) {                            \
    -+            buffer = QSIMPLEQ_FIRST(&stream->queue);                         \
    -+            do {                                                             \
    -+                AUD_CB;                                                      \
    -+            } while (0)                                                      \
    -+            ;                                                                \
    -+            virtqueue_push(buffer->vq, buffer->elem, len);                   \
    -+            virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);             \
    -+            QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);                     \
    -+            virtio_snd_pcm_buffer_free(buffer);                              \
    -+        }                                                                    \
    ++        }
     +    }
    -+
    -+
    -+/*
    -+ * Flush all buffer data from this output stream's queue into the driver's
    -+ * virtual queue.
    -+ *
    -+ * @stream: VirtIOSoundPCMStream *stream
    -+ */
    -+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream)
    -+{
    -+    /*
    -+     * We should flush the buffers as soon as possible, because it is a
    -+     * time-sensitive operation.
    -+     *
    -+     * TODO: find out if copying leftover flushed data to an intermediate
    -+     * buffer is a good approach.
    -+     */
    -+    size_t written;
    -+    virtio_snd_pcm_flush(
    -+            if (stream->active && buffer->stale) {
    -+                iov_to_buf(buffer->elem->out_sg,
    -+                           buffer->elem->out_num,
    -+                           buffer->offset,
    -+                           buffer->data,
    -+                           buffer->size);
    -+                buffer->stale = false;
    -+            }
    -+            if (stream->active)
    -+                while (buffer->size > 0) {
    -+                    written = AUD_write(stream->voice.out,
    -+                                        buffer->data + buffer->offset,
    -+                                        buffer->size);
    -+                    if (written < 1) {
    -+                        break;
    -+                    }
    -+                    buffer->size -= written;
    -+                    buffer->offset += written;
    -+                }
    -+            len = sizeof(virtio_snd_pcm_status);
    -+            iov_from_buf(buffer->elem->in_sg,
    -+                         buffer->elem->in_num,
    -+                         0,
    -+                         &resp,
    -+                         sizeof(virtio_snd_pcm_status));
    -+            );
     +}
     +
     +/*
    -+ * Flush all buffer data from this input stream's queue into the driver's
    ++ * Flush all buffer data from this output stream's queue into the driver's
     + * virtual queue.
    -+ *
    -+ * @stream: VirtIOSoundPCMStream *stream
    -+ */
    -+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream)
    -+{
    -+    virtio_snd_pcm_flush(
    -+            len = sizeof(virtio_snd_pcm_status) + buffer->size;
    -+            iov_from_buf(buffer->elem->in_sg,
    -+                         buffer->elem->in_num,
    -+                         0,
    -+                         buffer->data,
    -+                         buffer->size);
    -+            iov_from_buf(buffer->elem->in_sg,
    -+                         buffer->elem->in_num,
    -+                         buffer->size,
    -+                         &resp,
    -+                         sizeof(virtio_snd_pcm_status));
    -+            );
    -+}
    -+
    - static void virtio_snd_unrealize(DeviceState *dev)
    +  *
    +  * @stream: VirtIOSoundPCMStream *stream
    +  */
    + static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
      {
    -     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    +     VirtIOSoundPCMBuffer *buffer;
    ++    void (*cb)(VirtIOSoundPCMStream *, VirtIOSoundPCMBuffer *) =
    ++        (stream->info.direction == VIRTIO_SND_D_OUTPUT) ? return_tx_buffer :
    ++        return_rx_buffer;
    + 
    +     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    +         while (!QSIMPLEQ_EMPTY(&stream->queue)) {
    +             buffer = QSIMPLEQ_FIRST(&stream->queue);
    +-            return_tx_buffer(stream, buffer);
    ++            cb(stream, buffer);
    +         }
    +     }
    + }
11:  b720e00121 = 11:  885b01fe27 docs/system: add basic virtio-snd documentation

base-commit: cea3ea670fe265421131aad90c36fbb87bc4d206
-- 
2.39.2


