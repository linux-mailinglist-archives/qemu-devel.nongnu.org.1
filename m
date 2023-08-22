Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58352784A26
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:19:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWu4-0004V5-M9; Tue, 22 Aug 2023 15:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWu2-0004Ua-5x
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:18:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWty-0000dj-OX
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:18:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c63cd4ec2so716802f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731932; x=1693336732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5uMup/4QSi52F2hGDlz94Vl/J8M6kjRUExr5Qd2J8M=;
 b=LyibpaHPC3k1sG64839atqxdOoZ0sn3vvOtAz7dVsAZcExnYdxnOHwGFcymUsk0FwK
 i5pkDzofp1ykOC0WvniExTvCDqVbkl+7SjLOmSMp5/4NVSVESPXAU1uv1RYTAIO67maG
 6GdYCrvF/hnw7LHnOsQbwcEO221nK3LxsfdQHF4UR2FrecwdF8bA5abixcnQo+NqnZCy
 gghIcXMt5sgkD96kBMW2j7LkePnLfqEeiEN7/T9aZCyVpur/TjhFhr0TXAjxTij5VwVH
 vqK/z6wsjEQNFpM1vqniqTQID5WD/73Q2mpom5zgFqpbMgJsyL/BwlQnrZ4JCXjsQ0Rd
 iSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731932; x=1693336732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y5uMup/4QSi52F2hGDlz94Vl/J8M6kjRUExr5Qd2J8M=;
 b=Y1LqlvHPMqbtJDu7+RwQ5HS9SjSFchlOVbPuvLhN426m8zlhTn55Hw6fmE6dVlGOiJ
 CuyUwaJXJvccO5P0moA4rubsjUhxv6e5DbHFJk2EpnFlO9pEGICRg7W/kQ1ENlO7PdI2
 2nrCdsjO5M5pFl0e23QRsfewu86u9EbiL0gGdOAPLXNEt+DSTRyxP+AEnEI07rplgnVx
 4JWeYohWCEWjJry77eJgT5s3cnCUCg4O0nT0EVUj+Xm0Pn50FlAq0oBm62gG2X8NSPpa
 ZQiB77kwsmvgSMWdKrc8dhsNCdV8hHLrr+3Y+ReQaeYy/gIPcZdgtQQODJAANMFvcnHx
 awgg==
X-Gm-Message-State: AOJu0YzK1zCM2gA2Faz8de0VOd225futx7VIHRVLeKa7geGdHSLMHmBX
 YA46XHoPU/IcK85/9DJF3h30jr4rY+RpWM+q5i4=
X-Google-Smtp-Source: AGHT+IHAcmGPSfE3C4aH6aDsW+I2ZPYQKlVSKaCAqfMK6N+ymtqMycT/FYtyIeBemaKqhFY9hdYGRg==
X-Received: by 2002:a5d:670d:0:b0:317:731c:4d80 with SMTP id
 o13-20020a5d670d000000b00317731c4d80mr6962909wru.24.1692731931921; 
 Tue, 22 Aug 2023 12:18:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:18:51 -0700 (PDT)
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
Subject: [PATCH v7 00/12] Add VIRTIO sound card
Date: Tue, 22 Aug 2023 22:18:23 +0300
Message-Id: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

v7 can be found online at:

https://github.com/epilys/qemu-virtio-snd/tree/virtio-snd-v7

Main differences with v6 patch series [^v6]
<cover.1692089917.git.manos.pitsidianakis@linaro.org>:

- Removed minor stale/duplicate code.
- Addressed [^v6] review comments.
  Notably, the audio driver name is now `virtio` instead of 
  `virtio-sound`.
- Fixed some invalid pointer logic.
- Fixed minor typos and updated documentation.

[^v6]: 
https://lore.kernel.org/qemu-devel/cover.1692089917.git.manos.pitsidianakis@linaro.org/

Previously:

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
  virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
  virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
  virtio-sound: handle VIRTIO_SND_PCM_RELEASE
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
 hw/virtio/virtio-snd.c             | 1307 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio-snd.h     |  155 ++++
 softmmu/qdev-monitor.c             |    1 +
 10 files changed, 1643 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

Range-diff against v6:
 1:  86f98e0b7d !  1:  1a8ffb08d6 Add virtio-sound device stub
    @@ hw/virtio/virtio-snd.c (new)
     +};
     +
     +static Property virtio_snd_properties[] = {
    -+    DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
     +    DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
     +                       VIRTIO_SOUND_JACK_DEFAULT),
     +    DEFINE_PROP_UINT32("streams", VirtIOSound, snd_conf.streams,
    @@ include/hw/virtio/virtio-snd.h (new)
     +#include "standard-headers/linux/virtio_ids.h"
     +#include "standard-headers/linux/virtio_snd.h"
     +
    -+#define TYPE_VIRTIO_SND "virtio-sound-device"
    ++#define TYPE_VIRTIO_SND "virtio-sound"
     +#define VIRTIO_SND(obj) \
     +        OBJECT_CHECK(VirtIOSound, (obj), TYPE_VIRTIO_SND)
     +
    @@ include/hw/virtio/virtio-snd.h (new)
     +/* jack remapping control request */
     +typedef struct virtio_snd_jack_remap virtio_snd_jack_remap;
     +
    -+typedef struct virtio_snd_jack virtio_snd_jack;
    -+
     +/*
     + * PCM CONTROL MESSAGES
     + */
 2:  8f996f9aed !  2:  a32cf5571b Add virtio-sound-pci device
    @@ Commit message
     
         Use with following flags in the invocation:
     
    -      -device virtio-sound-pci,disable-legacy=on
    -
    -    And an audio backend listed with `-audio driver=help` that works on
    -    your host machine, e.g.:
    -
         Pulseaudio:
    -      -audio driver=pa,model=virtio-sound
    +      -audio driver=pa,model=virtio
           or
    -      -audio driver=pa,model=virtio-sound,server=/run/user/1000/pulse/native
    +      -audio driver=pa,model=virtio,server=/run/user/1000/pulse/native
         sdl:
    -      -audio driver=sdl,model=virtio-sound
    +      -audio driver=sdl,model=virtio
         coreaudio (macos/darwin):
    -      -audio driver=coreaudio,model=virtio-sound
    +      -audio driver=coreaudio,model=virtio
         etc.
     
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
    @@ hw/virtio/virtio-snd-pci.c (new)
     + */
     +
     +#include "qemu/osdep.h"
    ++#include "qapi/error.h"
     +#include "hw/audio/soundhw.h"
     +#include "hw/virtio/virtio-pci.h"
     +#include "hw/virtio/virtio-snd.h"
    @@ hw/virtio/virtio-snd-pci.c (new)
     +/*
     + * virtio-snd-pci: This extends VirtioPCIProxy.
     + */
    -+#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci-base"
    -+DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SOUND_PCI,
    ++#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci"
    ++DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SND_PCI,
     +                         TYPE_VIRTIO_SND_PCI)
     +
     +struct VirtIOSoundPCI {
    @@ hw/virtio/virtio-snd-pci.c (new)
     +};
     +
     +static Property virtio_snd_pci_properties[] = {
    ++    DEFINE_AUDIO_PROPERTIES(VirtIOSoundPCI, vdev.card),
    ++    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
    ++                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
    ++    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
    ++                       DEV_NVECTORS_UNSPECIFIED),
     +    DEFINE_PROP_END_OF_LIST(),
     +};
     +
    -+static const char *audiodev_id;
    -+
    -+static int virtio_snd_init_pci(PCIBus *init_bus, const char *audiodev)
    -+{
    -+    audiodev_id = audiodev;
    -+    return 0;
    -+}
    -+
     +static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     +{
    -+    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(vpci_dev);
    ++    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(vpci_dev);
     +    DeviceState *vdev = DEVICE(&dev->vdev);
     +
    -+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
    -+    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
    -+    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
    ++    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
    ++        vpci_dev->nvectors = 2;
    ++    }
    ++
    ++    virtio_pci_force_virtio_1(vpci_dev);
    ++    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
     +}
     +
     +static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
     +{
     +    DeviceClass *dc = DEVICE_CLASS(klass);
     +    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
    -+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     +
    -+    vpciklass->realize = virtio_snd_pci_realize;
    ++    device_class_set_props(dc, virtio_snd_pci_properties);
    ++    dc->desc = "Virtio Sound";
     +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     +
    -+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
    -+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SND;
    -+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
    -+    pcidev_k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
    -+    device_class_set_props(dc, virtio_snd_pci_properties);
    ++    vpciklass->realize = virtio_snd_pci_realize;
     +}
     +
     +static void virtio_snd_pci_instance_init(Object *obj)
     +{
    -+    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(obj);
    ++    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(obj);
     +
     +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
     +                                TYPE_VIRTIO_SND);
     +}
     +
     +static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
    -+    .base_name     = TYPE_VIRTIO_SND_PCI,
    -+    .generic_name  = "virtio-sound-pci",
    ++    .generic_name  = TYPE_VIRTIO_SND_PCI,
     +    .instance_size = sizeof(VirtIOSoundPCI),
     +    .instance_init = virtio_snd_pci_instance_init,
     +    .class_init    = virtio_snd_pci_class_init,
     +};
     +
    ++/* Create a Virtio Sound PCI device, so '-audio driver,model=virtio' works. */
    ++static int virtio_snd_pci_init(PCIBus *bus, const char *audiodev)
    ++{
    ++    DeviceState *dev;
    ++
    ++    dev = qdev_new(TYPE_VIRTIO_SND_PCI);
    ++    qdev_prop_set_string(dev, "audiodev", audiodev);
    ++    qdev_realize_and_unref(dev, BUS(bus), &error_fatal);
    ++    return 0;
    ++}
    ++
     +static void virtio_snd_pci_register(void)
     +{
     +    virtio_pci_types_register(&virtio_snd_pci_info);
    -+    pci_register_soundhw("virtio-sound", "Virtio Sound Device",
    -+                         virtio_snd_init_pci);
    ++    pci_register_soundhw("virtio", "Virtio Sound", virtio_snd_pci_init);
     +}
     +
     +type_init(virtio_snd_pci_register);
     
    - ## include/hw/pci/pci.h ##
    -@@ include/hw/pci/pci.h: extern bool pci_available;
    - #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
    - #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
    - #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
    -+#define PCI_DEVICE_ID_VIRTIO_SND         0x1019
    - 
    - /*
    -  * modern virtio-pci devices get their id assigned automatically,
    -
      ## softmmu/qdev-monitor.c ##
     @@ softmmu/qdev-monitor.c: static const QDevAlias qdev_alias_table[] = {
          { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
 3:  66eac6c1e0 !  3:  3f43057c32 virtio-sound: handle control messages and streams
    @@ hw/virtio/virtio-snd.c: static uint64_t get_features(VirtIODevice *vdev, uint64_
     +
     +    pcm = g_new0(VirtIOSoundPCM, 1);
     +    pcm->snd = snd;
    -+
     +    pcm->streams = g_new0(VirtIOSoundPCMStream *, snd->snd_conf.streams);
    -+    pcm->pcm_params = g_new0(VirtIOSoundPCMParams *, snd->snd_conf.streams);
    -+    pcm->jacks = g_new0(virtio_snd_jack *, snd->snd_conf.jacks);
    ++    pcm->pcm_params = g_new0(VirtIOSoundPCMParams, snd->snd_conf.streams);
     +
     +    snd->pcm = pcm;
     +}
    @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_pcm_xfer virtio_snd_pc
     +
     +struct VirtIOSoundPCM {
     +    VirtIOSound *snd;
    -+    VirtIOSoundPCMParams **pcm_params;
    ++    VirtIOSoundPCMParams *pcm_params;
     +    VirtIOSoundPCMStream **streams;
    -+    virtio_snd_jack **jacks;
     +};
     +
     +struct VirtIOSoundPCMStream {
 4:  fbb22214f2 !  4:  34afff149a virtio-sound: set PCM stream parameters
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +                                                       uint32_t stream_id)
     +{
     +    return stream_id >= s->snd_conf.streams ? NULL
    -+        : s->pcm->pcm_params[stream_id];
    ++        : &s->pcm->pcm_params[stream_id];
     +}
     +
     +/*
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +    VirtIOSoundPCMParams *st_params;
     +    uint32_t stream_id = params->hdr.stream_id;
     +
    -+    if (stream_id > s->snd_conf.streams || !(s->pcm->pcm_params)) {
    ++    if (stream_id >= s->snd_conf.streams || !(s->pcm->pcm_params)) {
     +        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
     +        return VIRTIO_SND_S_BAD_MSG;
     +    }
     +
    -+    if (!s->pcm->pcm_params[stream_id]) {
    -+        s->pcm->pcm_params[stream_id] = g_new0(VirtIOSoundPCMParams, 1);
    -+    }
     +    st_params = virtio_snd_pcm_get_params(s, stream_id);
     +
    -+    st_params->features = params->features;
    -+    st_params->buffer_bytes = params->buffer_bytes;
    -+    st_params->period_bytes = params->period_bytes;
    -+
     +    if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
     +        error_report("Number of channels is not supported.");
     +        return VIRTIO_SND_S_NOT_SUPP;
     +    }
    -+    st_params->channels = params->channels;
    -+
     +    if (!(supported_formats & BIT(params->format))) {
     +        error_report("Stream format is not supported.");
     +        return VIRTIO_SND_S_NOT_SUPP;
     +    }
    -+    st_params->format = params->format;
    -+
     +    if (!(supported_rates & BIT(params->rate))) {
     +        error_report("Stream rate is not supported.");
     +        return VIRTIO_SND_S_NOT_SUPP;
     +    }
    -+    st_params->rate = params->rate;
    -+    st_params->period_bytes = params->period_bytes;
    ++
     +    st_params->buffer_bytes = params->buffer_bytes;
    ++    st_params->period_bytes = params->period_bytes;
    ++    st_params->features = params->features;
    ++    st_params->channels = params->channels;
    ++    st_params->format = params->format;
    ++    st_params->rate = params->rate;
     +
     +    return VIRTIO_SND_S_OK;
     +}
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +
     +    if (!s->pcm->streams ||
     +        !s->pcm->pcm_params ||
    -+        !s->pcm->pcm_params[stream_id]) {
    ++        stream_id >= s->snd_conf.streams) {
     +        return VIRTIO_SND_S_BAD_MSG;
     +    }
     +
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
      {
          VirtIODevice *vdev = VIRTIO_DEVICE(dev);
          VirtIOSound *vsnd = VIRTIO_SND(dev);
    -+    virtio_snd_pcm_set_params default_params;
    ++    virtio_snd_pcm_set_params default_params = { 0 };
     +    uint32_t status;
      
          virtio_snd_set_pcm(vsnd);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
      
     +    /* set default params for all streams */
     +    default_params.features = 0;
    -+    default_params.buffer_bytes = 8192;
    ++    default_params.buffer_bytes = 16384;
     +    default_params.period_bytes = 4096;
     +    default_params.channels = 2;
     +    default_params.format = VIRTIO_SND_PCM_FMT_S16;
    -+    default_params.rate = VIRTIO_SND_PCM_RATE_44100;
    ++    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
          vsnd->queues[VIRTIO_SND_VQ_CONTROL] = virtio_add_queue(vdev, 64, ctrl);
          vsnd->queues[VIRTIO_SND_VQ_EVENT] = virtio_add_queue(vdev, 64, evt);
          vsnd->queues[VIRTIO_SND_VQ_TX] = virtio_add_queue(vdev, 64, txq);
 5:  06f676e360 !  5:  0f433debd3 virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
       * Get params for a specific stream.
       *
     @@ hw/virtio/virtio-snd.c: static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(VirtIOSound *s,
    -         : s->pcm->pcm_params[stream_id];
    +         : &s->pcm->pcm_params[stream_id];
      }
      
     +/*
    @@ hw/virtio/virtio-snd.c: static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(V
     +        pcm_info[i - req.start_id].direction = stream->direction;
     +        pcm_info[i - req.start_id].channels_min = stream->channels_min;
     +        pcm_info[i - req.start_id].channels_max = stream->channels_max;
    -+
    -+        memset(&pcm_info[i].padding, 0, sizeof(pcm_info[i].padding));
     +    }
     +
     +    cmd->resp.code = VIRTIO_SND_S_OK;
 6:  d3102a0850 =  6:  70bb76519e virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
 7:  0cb3e8a3b5 =  7:  fb37cca76a virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
 8:  894b52532b =  8:  1e4bef953f virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
 9:  4aebc54222 =  9:  b1bc6e7c21 virtio-sound: handle VIRTIO_SND_PCM_RELEASE
10:  ab95cdd4ae ! 10:  fc27067092 virtio-sound: implement audio output (TX)
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound
     +    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
     +        stream->voice.out = AUD_open_out(&s->card,
     +                                         stream->voice.out,
    -+                                         "virtio_snd_card",
    ++                                         "virtio-sound.out",
     +                                         stream,
     +                                         virtio_snd_pcm_out_cb,
     +                                         &as);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
      /*
     - * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
     - * a stream.
    -+ * Returns the number of bytes that have not been passed to AUD_write yet.
    ++ * Returns the number of I/O messages that are being processed.
     + *
     + * @stream: VirtIOSoundPCMStream
     + */
    -+static size_t virtio_snd_pcm_get_pending_bytes(VirtIOSoundPCMStream *stream)
    ++static size_t virtio_snd_pcm_get_pending_io_msgs(VirtIOSoundPCMStream *stream)
     +{
     +    VirtIOSoundPCMBlock *block;
     +    VirtIOSoundPCMBlock *next;
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    -+            size += block->size;
    ++            size += 1;
     +        }
     +    }
     +    return size;
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s
              return;
          }
     +
    -+    if (virtio_snd_pcm_get_pending_bytes(stream)) {
    ++    if (virtio_snd_pcm_get_pending_io_msgs(stream)) {
     +        /*
     +         * virtio-v1.2-csd01, 5.14.6.6.5.1,
     +         * Device Requirements: Stream Release
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
     +        }
     +
     +        stream = s->pcm->streams[hdr.stream_id];
    -+        if (stream->direction == VIRTIO_SND_D_INPUT) {
    ++        if (stream->direction != VIRTIO_SND_D_OUTPUT) {
     +            goto tx_err;
     +        }
     +
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
                  g_free(vsnd->pcm->streams);
              }
     +        g_free(vsnd->pcm->pcm_params);
    -+        g_free(vsnd->pcm->jacks);
              g_free(vsnd->pcm);
              vsnd->pcm = NULL;
          }
    @@ include/hw/virtio/virtio-snd.h: struct VirtIOSoundPCMParams {
     +
      struct VirtIOSoundPCM {
          VirtIOSound *snd;
    -     VirtIOSoundPCMParams **pcm_params;
    +     VirtIOSoundPCMParams *pcm_params;
11:  5e8f423499 ! 11:  770e8b2fe7 virtio-sound: implement audio capture (RX)
    @@ hw/virtio/trace-events: virtio_snd_handle_code(uint32_t val, const char *code) "
      virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
     -virtio_snd_handle_xfer(void) "tx/rx queue callback called"
     +virtio_snd_handle_tx_xfer(void) "tx queue callback called"
    -+virtio_snd_handle_rx_xfer(void) "tx queue callback called"
    ++virtio_snd_handle_rx_xfer(void) "rx queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
     @@
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound
     -        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
     +        stream->voice.in = AUD_open_in(&s->card,
     +                                        stream->voice.in,
    -+                                        "virtio_snd_card",
    ++                                        "virtio-sound.in",
     +                                        stream,
     +                                        virtio_snd_pcm_in_cb,
     +                                        &as);
    @@ hw/virtio/virtio-snd.c: tx_err:
     +    VirtQueueElement *elem;
     +    size_t sz;
     +    virtio_snd_pcm_xfer hdr;
    ++    virtio_snd_pcm_status resp = { 0 };
     +
     +    trace_virtio_snd_handle_rx_xfer();
     +
    @@ hw/virtio/virtio-snd.c: tx_err:
     +        }
     +
     +        stream = s->pcm->streams[hdr.stream_id];
    -+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    -+            continue;
    ++        if (stream->direction != VIRTIO_SND_D_INPUT) {
    ++            goto rx_err;
     +        }
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     +            virtio_snd_pcm_read(stream, vq, elem);
     +        }
    ++        continue;
    ++
    ++rx_err:
    ++        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    ++            resp.status = VIRTIO_SND_S_BAD_MSG;
    ++            iov_from_buf(elem->in_sg,
    ++                         elem->in_num,
    ++                         0,
    ++                         &resp,
    ++                         sizeof(resp));
    ++        }
     +    }
     +
     +    /*
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +                        iov_from_buf(block->elem->in_sg,
     +                                     block->elem->in_num,
     +                                     sz,
    -+                                     &block->data,
    ++                                     block->data,
     +                                     MIN(stream->period_bytes, block->size));
     +                    }
     +                    virtqueue_push(block->vq,
12:  a3f2576f6a <  -:  ---------- docs/system: add basic virtio-snd documentation
 -:  ---------- > 12:  6bed902247 docs/system: add basic virtio-snd documentation

base-commit: b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa
-- 
2.39.2


