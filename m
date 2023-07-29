Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C1767E45
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 12:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhLL-0007oq-DG; Sat, 29 Jul 2023 06:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLE-0007oi-SN
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:38:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLC-000109-KE
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:38:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso32520225e9.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627108; x=1691231908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8jOdZtFpHowO+pX+WZC2txgRJ0j5tiFkLlVFdTRCEzc=;
 b=Qhu7WiPVfEU4PsTCCYF81vsf6XWA0uH1uuB/XToRxZPvtgjaHpihJ03l6VGpxjurF/
 Q/FOD1JxriVBXXfVzI147Vn/T5VCBtHN+USQYG3KLhj23E452YHrOk0p07KJJw3MxaUH
 YxLkycI+cOJ9DLBiGv2zi3RodveIP0qLcsWlFcFDAKwZ5Ks3bIyW7Om6rBmROYrj2A3R
 eleA2St85BIIB1UqERZrfVmbpBNe5eGZa3hbO2AKJ7jieqhB1ZLFnwHEfl0UtI50Sng6
 FLK5YKonXs1QP70AOewSXYN42Aqd49CW2hr9twlQJm/XUkqEvcvWX0NottB5SmSPUtEx
 kKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627108; x=1691231908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jOdZtFpHowO+pX+WZC2txgRJ0j5tiFkLlVFdTRCEzc=;
 b=earvHbWB7aGM8oYUiQYrbUCBMIXXLcl7jPBAT3Co4EdLfCNC5Bdcz0+bwbMlz0KbKn
 4xov9lGO2yDkgxifMJUCzlv92fklQuW/vbQi+7kr2OUMfUi6OreNAd4CVdUFV3j3S6jx
 5+wvSL7Y68ANTR4RwLnlGLNwbsjWFh2srf+hvY0+nnLwAr73PZ/MduwvTTqygVvFzf5c
 YV2DyWxtyrGesHKx5Wow1dxZ4gddewfPIK0y0uD4yKxQcOp0FA3dX6Cs4aRjkKQT+PwG
 4VkNE2QZDKM+fpPbuhl2674uA/48qECu79uQXqa7+LW7nuFlKo6a4RQXkL0oigm/loNQ
 ikMQ==
X-Gm-Message-State: ABy/qLYLjLdiOrhZrM9EhqzEYiuhZKPVVHICFuzzSVSW3finP4IXsog9
 CVe6lQTCDZryWNMxMEyr5NHPdGsNfIugHxl/G8UKIw==
X-Google-Smtp-Source: APBJJlFmBgkpzJXpoKQi/k3gHJFj263Wb1OEldysCNeCYOl99v+6JPLdNWECt/1cyl0GpG2hXpuozQ==
X-Received: by 2002:a1c:4c08:0:b0:3fe:ad4:27b4 with SMTP id
 z8-20020a1c4c08000000b003fe0ad427b4mr3603334wmf.27.1690627108308; 
 Sat, 29 Jul 2023 03:38:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:38:27 -0700 (PDT)
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
Subject: [PATCH v5 00/12] Add VIRTIO sound card
Date: Sat, 29 Jul 2023 13:36:52 +0300
Message-Id: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

https://github.com/epilys/qemu-virtio-snd/tree/sound-v6

Main differences with v4 patch [^v4]
<cover.1689857559.git.manos.pitsidianakis@linaro.org>:
- Use ERRP_GUARD() to propagate errors.
- Use virtio_add_feature() instead of XORing constants.
- Use %zu format specifier for size_t.

[^v4]: 
https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/

Previously:

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
 hw/virtio/virtio-snd.c         | 1300 ++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h           |    1 +
 include/hw/virtio/virtio-snd.h |  158 ++++
 softmmu/qdev-monitor.c         |    1 +
 9 files changed, 1584 insertions(+)
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

Range-diff against v4:
 1:  ae372de565 !  1:  899b9a06bb Add virtio-sound device stub
    @@ hw/virtio/virtio-snd.c (new)
     +     * Feature Bits
     +     * None currently defined.
     +     */
    ++    VirtIOSound *s = VIRTIO_SND(vdev);
    ++    features |= s->features;
    ++
     +    trace_virtio_snd_get_features(vdev, features);
    -+    return features | 1UL << VIRTIO_F_VERSION_1 | 1UL << VIRTIO_F_IN_ORDER;
    ++
    ++    return features;
     +}
     +
     +static void virtio_snd_common_realize(DeviceState *dev,
    @@ hw/virtio/virtio-snd.c (new)
     +    VirtIOSound *vsnd = VIRTIO_SND(dev);
     +
     +    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
    ++    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
     +
     +    /* set number of jacks and streams */
     +    if (vsnd->snd_conf.jacks > 8) {
    @@ hw/virtio/virtio-snd.c (new)
     +
     +static void virtio_snd_realize(DeviceState *dev, Error **errp)
     +{
    ++    ERRP_GUARD();
     +    VirtIOSound *vsnd = VIRTIO_SND(dev);
    -+    Error *err = NULL;
     +
     +    vsnd->vmstate =
     +        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
    @@ hw/virtio/virtio-snd.c (new)
     +                              virtio_snd_handle_queue,
     +                              virtio_snd_handle_queue,
     +                              virtio_snd_handle_queue,
    -+                              &err);
    -+    if (err != NULL) {
    -+        error_propagate(errp, err);
    -+        return;
    -+    }
    ++                              errp);
     +}
     +
     +static void virtio_snd_unrealize(DeviceState *dev)
    @@ include/hw/virtio/virtio-snd.h (new)
     +typedef struct VirtIOSound {
     +    VirtIODevice parent_obj;
     +    VirtQueue *queues[VIRTIO_SND_VQ_MAX];
    ++    uint64_t features;
     +    QEMUSoundCard card;
     +    VMChangeStateEntry *vmstate;
     +    virtio_snd_config snd_conf;
 2:  5cde5472ea =  2:  035be510f8 Add virtio-sound-pci device
 3:  dc65cac2f4 !  3:  e6a3624f89 virtio-sound: handle control messages and streams
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
      static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                                   Error **errp)
     @@ hw/virtio/virtio-snd.c: static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
    -     return features | 1UL << VIRTIO_F_VERSION_1 | 1UL << VIRTIO_F_IN_ORDER;
    +     return features;
      }
      
     +static void virtio_snd_set_pcm(VirtIOSound *snd)
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
     +    virtio_snd_set_pcm(vsnd);
     +
          virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
    +     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
      
    -     /* set number of jacks and streams */
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
          vsnd->queues[VIRTIO_SND_VQ_EVENT] = virtio_add_queue(vdev, 64, evt);
          vsnd->queues[VIRTIO_SND_VQ_TX] = virtio_add_queue(vdev, 64, txq);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
      
      static void
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    +     ERRP_GUARD();
          VirtIOSound *vsnd = VIRTIO_SND(dev);
    -     Error *err = NULL;
      
     +    vsnd->pcm = NULL;
          vsnd->vmstate =
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +                              virtio_snd_handle_event,
     +                              virtio_snd_handle_xfer,
     +                              virtio_snd_handle_xfer,
    -                               &err);
    -     if (err != NULL) {
    -         error_propagate(errp, err);
    --        return;
    -     }
    +                               errp);
      }
      
     +/*
    @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_pcm_xfer virtio_snd_pc
     +struct VirtIOSound {
          VirtIODevice parent_obj;
          VirtQueue *queues[VIRTIO_SND_VQ_MAX];
    +     uint64_t features;
     +    VirtIOSoundPCM *pcm;
          QEMUSoundCard card;
          VMChangeStateEntry *vmstate;
 4:  bbd1799fc9 =  4:  82c80e2ae4 virtio-sound: set PCM stream parameters
 5:  68a13c4385 =  5:  19d95e8411 virtio-sound: prepare PCM streams
 6:  f267d41957 !  6:  78777fb46f virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
    @@ hw/virtio/virtio-snd.c: static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(V
     +
     +    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
     +        sizeof(virtio_snd_hdr) + req.size * req.count) {
    -+        error_report("pcm info: buffer too small, got: %lu, needed: %lu",
    ++        error_report("pcm info: buffer too small, got: %zu, needed: %zu",
     +                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
     +                sizeof(virtio_snd_pcm_info));
     +        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
 7:  5939a6161e =  7:  7641e21ee8 virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
 8:  8f78d3a132 =  8:  48f9b776f5 virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
 9:  d2b3854084 =  9:  cdb8ab3ee2 virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
10:  4e14b2d129 = 10:  bbc11d0348 virtio-sound: handle VIRTIO_SND_PCM_RELEASE
11:  65442a1cd1 ! 11:  d5fb4b058c virtio-sound: implement audio output (TX)
    @@ Metadata
      ## Commit message ##
         virtio-sound: implement audio output (TX)
     
    -    Handle output IO messages in the receive (RX) virtqueue.
    +    Handle output IO messages in the transmit (TX) virtqueue.
     
         It allocates a VirtIOSoundPCMBlock for each IO message and copies the
         data buffer to it. When the IO buffer is written to the host's sound
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     -                              virtio_snd_handle_xfer,
     +                              virtio_snd_handle_tx,
                                    virtio_snd_handle_xfer,
    -                               &err);
    -     if (err != NULL) {
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    -     }
    +                               errp);
      }
      
     +/*
12:  aeb0caf7dc ! 12:  e2c30e2a21 virtio-sound: implement audio capture (RX)
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     -                              virtio_snd_handle_xfer,
     +                              virtio_snd_handle_tx_xfer,
     +                              virtio_snd_handle_rx_xfer,
    -                               &err);
    -     if (err != NULL) {
    -         error_propagate(errp, err);
    +                               errp);
    + }
    + 
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int available)
      }
      

base-commit: ccb86f079a9e4d94918086a9df18c1844347aff8
-- 
2.39.2


