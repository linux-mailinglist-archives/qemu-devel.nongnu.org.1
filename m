Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA8078B8B6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiL2-0002XN-Cy; Mon, 28 Aug 2023 15:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiKj-0002RL-V4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:55:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiKf-0005BU-I4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:55:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c73c21113so3221484f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252527; x=1693857327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s8Spz0RsrzEba9uOHH1DyaCPM0yW8ykvDmlh9btq9kQ=;
 b=H3nlhYLVIxI35l04KFj0nxLmoE1t/L9Ppp6hhx7PhnVi7p3fskY0i+ycZLN7mkjexh
 LOFErbzLrPTxxL02ApjjF75zSKyWk5t61V49w3j/PS3KXCt4cnvH2IxQSOXuQjqLTU3b
 cGcLipnyLeYLYvXu03ZJDyodiuY9a3KQeZ/yuR4e/YFIzUy3rTNVFmA+XKNNS+2zrjCI
 u/UQfWEEqo+9djWW+nwUvKexuFTxaK6TpyxSAQCqe2fAQq7kRBu/gY/mdKIaicejtrN6
 F2CZFl2HyOlhWPt6xQzmKMeszlAsFhXq3gArik+lgC2tEf/V0XrCqNjxeqrMcH4GY2bN
 MLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252527; x=1693857327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s8Spz0RsrzEba9uOHH1DyaCPM0yW8ykvDmlh9btq9kQ=;
 b=VZO2lgDOa21hzdyItzRY20X6y9HZlQhvAg/mzBNaL5FmsWicCD/SGxRuFD+aUkeg6p
 NQJcTRgzZgdGfdijfYd0UfZ/ah6l0cbkchOPzR7IaZnPuK+sYV8fYKpYNOjG6JNZEdtC
 K8YLSbg+3sRR0p5xmHqC0iXLWCzxHSE0waCPmw0FFMpvuQ4vf6t2Io3Ban60ejbqyNYw
 t6i/BQlcL1cW3s01StfWvWjgSD5UhzcyNnK8Gd4uKjfPEmjY0GLKYwvLC3al7l8VFRs5
 htlNHadiN1/t3qL/QI91iz53FNjgjObrPL6enBbUL+FGsmWc5DnPT62CrDykwSOOP6o/
 nJBg==
X-Gm-Message-State: AOJu0Yy44K4CvgOKlfWQQnKU+1vDEWeiyK7JoUV4O4TEUm5/Plv0t7E4
 H/6AhuflNhpQ1a7UE0EBwThI0nFHUzQ8vdnNNws=
X-Google-Smtp-Source: AGHT+IF7Rozv43oyM4sP+fcEe8Qb06Xp8I3L/xD6OJHgNH9eOqlDcWBnXg02hfn4kXlCHa7iz9hAXA==
X-Received: by 2002:adf:a156:0:b0:31d:8fed:c527 with SMTP id
 r22-20020adfa156000000b0031d8fedc527mr3448526wrr.42.1693252526762; 
 Mon, 28 Aug 2023 12:55:26 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:55:26 -0700 (PDT)
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
Subject: [PATCH v8 00/12] Add VIRTIO sound card
Date: Mon, 28 Aug 2023 22:54:57 +0300
Message-Id: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

This patch series adds an audio device implementing the recent virtio 
sound spec (1.2) and a corresponding PCI wrapper device.

v8 can be found online at:

https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v8

Ref 69eb5f4fbae731f5fc05dea8a5f4b656e0de127f

Main differences with v7 patch series [^v7]
<cover.1692731646.git.manos.pitsidianakis@linaro.org>:

- Addressed [^v7] review comments.
  Functions that were called from more than one place for code re-use 
  are not created until they are actually needed.
- Fixed cases where block->offset was not respected in Playback

Previously:

[^v7]
https://lore.kernel.org/qemu-devel/cover.1692731646.git.manos.pitsidianakis@linaro.org/
[^v6]: 
https://lore.kernel.org/qemu-devel/cover.1692089917.git.manos.pitsidianakis@linaro.org/
[^v5]: 
https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/
[^v4]: 
https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/
[^v3]: 
https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/


Emmanouil Pitsidianakis (12):
  Add virtio-sound device stub
  Add virtio-sound-pci device
  virtio-sound: handle control messages and streams
  virtio-sound: set PCM stream parameters
  virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
  virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
  virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
  virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
  virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
  virtio-sound: implement audio output (TX)
  virtio-sound: implement audio capture (RX)
  docs/system: add basic virtio-snd documentation

 MAINTAINERS                        |    6 +
 docs/system/device-emulation.rst   |    1 +
 docs/system/devices/virtio-snd.rst |   49 ++
 hw/virtio/Kconfig                  |    5 +
 hw/virtio/meson.build              |    2 +
 hw/virtio/trace-events             |   20 +
 hw/virtio/virtio-snd-pci.c         |   97 +++
 hw/virtio/virtio-snd.c             | 1308 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio-snd.h     |  155 ++++
 softmmu/qdev-monitor.c             |    1 +
 10 files changed, 1644 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

Range-diff against v7:
 1:  1a8ffb08d6 !  1:  238de1757e Add virtio-sound device stub
    @@ Commit message
         Add a new VIRTIO device for the virtio sound device id. Functionality
         will be added in the following commits.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## MAINTAINERS ##
    @@ hw/virtio/virtio-snd.c (new)
     +#include "qemu/osdep.h"
     +#include "qemu/iov.h"
     +#include "qemu/log.h"
    ++#include "qemu/error-report.h"
     +#include "include/qemu/lockable.h"
     +#include "sysemu/runstate.h"
     +#include "trace.h"
    @@ hw/virtio/virtio-snd.c (new)
     +    return features;
     +}
     +
    -+static void virtio_snd_common_realize(DeviceState *dev,
    -+                                      VirtIOHandleOutput ctrl,
    -+                                      VirtIOHandleOutput evt,
    -+                                      VirtIOHandleOutput txq,
    -+                                      VirtIOHandleOutput rxq,
    -+                                      Error **errp)
    ++static void
    ++virtio_snd_vm_state_change(void *opaque, bool running,
    ++                                       RunState state)
     +{
    -+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    ++    if (running) {
    ++        trace_virtio_snd_vm_state_running();
    ++    } else {
    ++        trace_virtio_snd_vm_state_stopped();
    ++    }
    ++}
    ++
    ++static void virtio_snd_realize(DeviceState *dev, Error **errp)
    ++{
    ++    ERRP_GUARD();
     +    VirtIOSound *vsnd = VIRTIO_SND(dev);
    ++    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    ++
    ++    vsnd->vmstate =
    ++        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
    ++
    ++    trace_virtio_snd_realize(vsnd);
     +
     +    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
     +    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
    @@ hw/virtio/virtio-snd.c (new)
     +
     +    AUD_register_card("virtio-sound", &vsnd->card);
     +
    -+    vsnd->queues[VIRTIO_SND_VQ_CONTROL] = virtio_add_queue(vdev, 64, ctrl);
    -+    vsnd->queues[VIRTIO_SND_VQ_EVENT] = virtio_add_queue(vdev, 64, evt);
    -+    vsnd->queues[VIRTIO_SND_VQ_TX] = virtio_add_queue(vdev, 64, txq);
    -+    vsnd->queues[VIRTIO_SND_VQ_RX] = virtio_add_queue(vdev, 64, rxq);
    -+}
    -+
    -+static void
    -+virtio_snd_vm_state_change(void *, bool running, RunState)
    -+{
    -+    if (running) {
    -+        trace_virtio_snd_vm_state_running();
    -+    } else {
    -+        trace_virtio_snd_vm_state_stopped();
    -+    }
    -+}
    -+
    -+static void virtio_snd_realize(DeviceState *dev, Error **errp)
    -+{
    -+    ERRP_GUARD();
    -+    VirtIOSound *vsnd = VIRTIO_SND(dev);
    -+
    -+    vsnd->vmstate =
    -+        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
    -+
    -+    trace_virtio_snd_realize(vsnd);
    -+
    -+    virtio_snd_common_realize(dev,
    -+                              virtio_snd_handle_queue,
    -+                              virtio_snd_handle_queue,
    -+                              virtio_snd_handle_queue,
    -+                              virtio_snd_handle_queue,
    -+                              errp);
    ++    vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
    ++    vsnd->queues[VIRTIO_SND_VQ_EVENT] =
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
    ++    vsnd->queues[VIRTIO_SND_VQ_TX] =
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
    ++    vsnd->queues[VIRTIO_SND_VQ_RX] =
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
     +}
     +
     +static void virtio_snd_unrealize(DeviceState *dev)
 2:  a32cf5571b !  2:  8de966a86b Add virtio-sound-pci device
    @@ Commit message
           -audio driver=coreaudio,model=virtio
         etc.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/meson.build ##
 3:  3f43057c32 !  3:  e3e57dd125 virtio-sound: handle control messages and streams
    @@ Commit message
     
         The handler is process_cmd() which replies with VIRTIO_SND_S_NOT_SUPP.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/trace-events ##
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
      
      static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                                   Error **errp)
    -@@ hw/virtio/virtio-snd.c: static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
    -     return features;
    +@@ hw/virtio/virtio-snd.c: virtio_snd_vm_state_change(void *opaque, bool running,
    +     }
      }
      
     +static void virtio_snd_set_pcm(VirtIOSound *snd)
    @@ hw/virtio/virtio-snd.c: static uint64_t get_features(VirtIODevice *vdev, uint64_
     +    snd->pcm = pcm;
     +}
     +
    - static void virtio_snd_common_realize(DeviceState *dev,
    -                                       VirtIOHandleOutput ctrl,
    -                                       VirtIOHandleOutput evt,
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
    -     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    -     VirtIOSound *vsnd = VIRTIO_SND(dev);
    - 
    -+    virtio_snd_set_pcm(vsnd);
    -+
    -     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
    -     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
    - 
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
    -     vsnd->queues[VIRTIO_SND_VQ_EVENT] = virtio_add_queue(vdev, 64, evt);
    -     vsnd->queues[VIRTIO_SND_VQ_TX] = virtio_add_queue(vdev, 64, txq);
    -     vsnd->queues[VIRTIO_SND_VQ_RX] = virtio_add_queue(vdev, 64, rxq);
    -+    qemu_mutex_init(&vsnd->cmdq_mutex);
    -+    QTAILQ_INIT(&vsnd->cmdq);
    - }
    - 
    - static void
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    + static void virtio_snd_realize(DeviceState *dev, Error **errp)
    + {
          ERRP_GUARD();
          VirtIOSound *vsnd = VIRTIO_SND(dev);
    +     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
      
     +    vsnd->pcm = NULL;
          vsnd->vmstate =
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
      
          trace_virtio_snd_realize(vsnd);
      
    -     virtio_snd_common_realize(dev,
    --                              virtio_snd_handle_queue,
    --                              virtio_snd_handle_queue,
    --                              virtio_snd_handle_queue,
    --                              virtio_snd_handle_queue,
    -+                              virtio_snd_handle_ctrl,
    -+                              virtio_snd_handle_event,
    -+                              virtio_snd_handle_xfer,
    -+                              virtio_snd_handle_xfer,
    -                               errp);
    - }
    ++    virtio_snd_set_pcm(vsnd);
    ++
    +     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
    +     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
    + 
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    +     AUD_register_card("virtio-sound", &vsnd->card);
      
    +     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
    +-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
    +     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
    +-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_event);
    +     vsnd->queues[VIRTIO_SND_VQ_TX] =
    +-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
    +     vsnd->queues[VIRTIO_SND_VQ_RX] =
    +-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
    ++    qemu_mutex_init(&vsnd->cmdq_mutex);
    ++    QTAILQ_INIT(&vsnd->cmdq);
    ++}
    ++
     +/*
     + * Close the stream and free its resources.
     + *
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     + */
     +static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
     +{
    -+}
    -+
    + }
    + 
      static void virtio_snd_unrealize(DeviceState *dev)
      {
          VirtIODevice *vdev = VIRTIO_DEVICE(dev);
 4:  34afff149a !  4:  6b3f8d8206 virtio-sound: set PCM stream parameters
    @@ Commit message
         PCM parameters describe the sound card parameters that the guest's
         kernel sees as an ALSA device.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/virtio-snd.c ##
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     + * @params: The PCM params as defined in the virtio specification
     + */
     +static
    -+uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
    -+                                        virtio_snd_pcm_set_params *params)
    ++uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
    ++                                   virtio_snd_pcm_set_params *params)
     +{
     +    VirtIOSoundPCMParams *st_params;
     +    uint32_t stream_id = params->hdr.stream_id;
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     + * @s: VirtIOSound device
     + * @stream_id: stream id
     + */
    -+static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
    ++static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     +{
     +    audsettings as;
     +    VirtIOSoundPCMParams *params;
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
      /*
       * The actual processing done in virtio_snd_process_cmdq().
       *
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
    - {
    -     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    +     ERRP_GUARD();
          VirtIOSound *vsnd = VIRTIO_SND(dev);
    +     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     +    virtio_snd_pcm_set_params default_params = { 0 };
     +    uint32_t status;
      
    -     virtio_snd_set_pcm(vsnd);
    - 
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
    +     vsnd->pcm = NULL;
    +     vsnd->vmstate =
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
      
          AUD_register_card("virtio-sound", &vsnd->card);
      
     +    /* set default params for all streams */
     +    default_params.features = 0;
    -+    default_params.buffer_bytes = 16384;
    -+    default_params.period_bytes = 4096;
    ++    default_params.buffer_bytes = 8192;
    ++    default_params.period_bytes = 2048;
     +    default_params.channels = 2;
     +    default_params.format = VIRTIO_SND_PCM_FMT_S16;
     +    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
    -     vsnd->queues[VIRTIO_SND_VQ_CONTROL] = virtio_add_queue(vdev, 64, ctrl);
    -     vsnd->queues[VIRTIO_SND_VQ_EVENT] = virtio_add_queue(vdev, 64, evt);
    -     vsnd->queues[VIRTIO_SND_VQ_TX] = virtio_add_queue(vdev, 64, txq);
    -     vsnd->queues[VIRTIO_SND_VQ_RX] = virtio_add_queue(vdev, 64, rxq);
    +     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
    +         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
    +     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    +         virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
          qemu_mutex_init(&vsnd->cmdq_mutex);
          QTAILQ_INIT(&vsnd->cmdq);
    -+
    +-}
    + 
    +-/*
    +- * Close the stream and free its resources.
    +- *
    +- * @stream: VirtIOSoundPCMStream *stream
    +- */
    +-static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    +-{
     +    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
     +        default_params.hdr.stream_id = i;
    -+        status = virtio_snd_pcm_set_params_impl(vsnd, &default_params);
    ++        status = virtio_snd_set_pcm_params(vsnd, &default_params);
     +        if (status != VIRTIO_SND_S_OK) {
     +            error_setg(errp,
     +                       "Can't initalize stream params, device responded with %s.",
     +                       print_code(status));
     +            return;
     +        }
    -+        status = virtio_snd_pcm_prepare_impl(vsnd, i);
    ++        status = virtio_snd_pcm_prepare(vsnd, i);
     +        if (status != VIRTIO_SND_S_OK) {
     +            error_setg(errp,
     +                       "Can't prepare streams, device responded with %s.",
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
     +    }
      }
      
    - static void
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    -                               errp);
    - }
    - 
    --/*
    -- * Close the stream and free its resources.
    -- *
    -- * @stream: VirtIOSoundPCMStream *stream
    -- */
    --static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    --{
    --}
    --
      static void virtio_snd_unrealize(DeviceState *dev)
    - {
    -     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
              vsnd->pcm = NULL;
          }
 5:  0f433debd3 !  5:  974d88412d virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
    @@ Commit message
         Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
         of each requested PCM stream.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/trace-events ##
 6:  70bb76519e !  6:  ff6f132004 virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
    @@ Commit message
         does nothing at the moment except for replying to it. Audio playback
         or capture will be started/stopped here in follow-up commits.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/trace-events ##
    @@ hw/virtio/trace-events: virtio_snd_realize(void *snd) "snd %p: realize"
      virtio_snd_handle_event(void) "event queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
    -@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
    +@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
          return VIRTIO_SND_S_OK;
      }
      
 7:  fb37cca76a !  7:  993e6af394 virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
    @@ Metadata
     Author: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## Commit message ##
    -    virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
    +    virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
     
         Handle the set parameters control request. It reconfigures a stream
         based on a guest's preference if the values are valid and supported.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/trace-events ##
    @@ hw/virtio/trace-events: virtio_snd_vm_state_running(void) "vm state running"
      virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
     
      ## hw/virtio/virtio-snd.c ##
    -@@ hw/virtio/virtio-snd.c: uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
    +@@ hw/virtio/virtio-snd.c: uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
          return VIRTIO_SND_S_OK;
      }
      
    @@ hw/virtio/virtio-snd.c: uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
     +    }
     +
     +    trace_virtio_snd_handle_pcm_set_params(req.hdr.stream_id);
    -+    cmd->resp.code = virtio_snd_pcm_set_params_impl(s, &req);
    ++    cmd->resp.code = virtio_snd_set_pcm_params(s, &req);
     +}
     +
      /*
 8:  1e4bef953f !  8:  36ce5f4d63 virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
    @@ Commit message
         Handles the PCM prepare control request. It initializes a PCM stream
         when the guests asks for it.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/virtio-snd.c ##
    -@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
    +@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
          return VIRTIO_SND_S_OK;
      }
      
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound
     +                           sizeof(stream_id));
     +
     +    cmd->resp.code = sz == sizeof(uint32_t)
    -+                   ? virtio_snd_pcm_prepare_impl(s, stream_id)
    ++                   ? virtio_snd_pcm_prepare(s, stream_id)
     +                   : VIRTIO_SND_S_BAD_MSG;
     +}
     +
 9:  b1bc6e7c21 !  9:  30ad4bc665 virtio-sound: handle VIRTIO_SND_PCM_RELEASE
    @@ Metadata
     Author: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## Commit message ##
    -    virtio-sound: handle VIRTIO_SND_PCM_RELEASE
    +    virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
     
         Handle the PCM release control request, which is necessary for flushing
         pending sound IO. No IO is handled yet so currently it only replies to
         the request.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/trace-events ##
10:  fc27067092 ! 10:  c94a9c1e65 virtio-sound: implement audio output (TX)
    @@ Commit message
            releasing all IO messages back to the guest. This is how according to
            the spec the guest knows the release was successful.
     
    +    Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
    +    Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
    +    Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/trace-events ##
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_get_qemu_audsettings(audsettings
              qemu_mutex_destroy(&stream->queue_mutex);
              g_free(stream);
          }
    -@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
    +@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
          stream->positions[0] = VIRTIO_SND_CHMAP_FL;
          stream->positions[1] = VIRTIO_SND_CHMAP_FR;
      
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound
          stream->as = as;
          stream->desired_as = stream->as;
          qemu_mutex_init(&stream->queue_mutex);
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
    +                                              bool start)
    + {
    +     VirtIOSoundPCMStream *stream;
    ++    VirtIOSoundPCMBlock *block, *next;
    +     virtio_snd_pcm_hdr req;
    +     size_t sz = iov_to_buf(cmd->elem->out_sg,
    +                            cmd->elem->out_num,
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                  "VIRTIO_SND_R_PCM_STOP", req.stream_id);
      
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
     +            AUD_set_active_out(stream->voice.out, start);
     +        }
    ++        /* remove previous buffers. */
    ++        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    ++            QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    ++                virtqueue_push(block->vq,
    ++                               block->elem,
    ++                               sizeof(block->elem));
    ++                virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
    ++                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    ++                g_free(block);
    ++            }
    ++        }
     +    } else {
              error_report("Invalid stream id: %"PRIu32, req.stream_id);
              cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
       * Stub buffer virtqueue handler.
       *
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    -     virtio_snd_common_realize(dev,
    -                               virtio_snd_handle_ctrl,
    -                               virtio_snd_handle_event,
    --                              virtio_snd_handle_xfer,
    -+                              virtio_snd_handle_tx,
    -                               virtio_snd_handle_xfer,
    -                               errp);
    +     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
    +         virtio_add_queue(vdev, 64, virtio_snd_handle_event);
    +     vsnd->queues[VIRTIO_SND_VQ_TX] =
    +-        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_tx);
    +     vsnd->queues[VIRTIO_SND_VQ_RX] =
    +         virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
    +     qemu_mutex_init(&vsnd->cmdq_mutex);
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    +     }
      }
      
     +/*
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    -+            AUD_write(stream->voice.out, block->data, block->size);
    ++            AUD_write(stream->voice.out, block->data + block->offset, block->size);
     +            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
     +            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
     +            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
11:  770e8b2fe7 ! 11:  9a85da0dde virtio-sound: implement audio capture (RX)
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_close(VirtIOSoundPCMStream *s
              }
              qemu_mutex_destroy(&stream->queue_mutex);
              g_free(stream);
    -@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
    +@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
                                               virtio_snd_pcm_out_cb,
                                               &as);
          } else {
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +        } else {
     +            AUD_set_active_in(stream->voice.in, start);
              }
    -     } else {
    -         error_report("Invalid stream id: %"PRIu32, req.stream_id);
    +         /* remove previous buffers. */
    +         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s,
               */
              virtio_snd_process_cmdq(stream->s);
    @@ hw/virtio/virtio-snd.c: tx_err:
      static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                                   Error **errp)
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    -     virtio_snd_common_realize(dev,
    -                               virtio_snd_handle_ctrl,
    -                               virtio_snd_handle_event,
    --                              virtio_snd_handle_tx,
    --                              virtio_snd_handle_xfer,
    -+                              virtio_snd_handle_tx_xfer,
    -+                              virtio_snd_handle_rx_xfer,
    -                               errp);
    - }
    +     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
    +         virtio_add_queue(vdev, 64, virtio_snd_handle_event);
    +     vsnd->queues[VIRTIO_SND_VQ_TX] =
    +-        virtio_add_queue(vdev, 64, virtio_snd_handle_tx);
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_tx_xfer);
    +     vsnd->queues[VIRTIO_SND_VQ_RX] =
    +-        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
    ++        virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
    +     qemu_mutex_init(&vsnd->cmdq_mutex);
    +     QTAILQ_INIT(&vsnd->cmdq);
      
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int available)
      }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
      
          WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     -        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    --            AUD_write(stream->voice.out, block->data, block->size);
    +-            AUD_write(stream->voice.out, block->data + block->offset, block->size);
     -            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
     -            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
     -            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +{
     +    virtio_snd_pcm_flush(
     +            AUD_write(stream->voice.out,
    -+                              block->data,
    -+                              block->size);
    ++                      block->data + block->offset,
    ++                      block->size);
     +            );
     +}
     +
12:  6bed902247 = 12:  69eb5f4fba docs/system: add basic virtio-snd documentation

base-commit: 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4
-- 
2.39.2


