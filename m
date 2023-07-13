Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EFA751F77
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:06:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu85-0002Qn-DS; Thu, 13 Jul 2023 07:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qJu83-0002QD-07
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:04:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qJu7z-000633-4e
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:04:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbf7fbe722so5095005e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689246292; x=1691838292;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CbQF8XPOqJdmQIcvM8BpUvpXKBooIWInX+MFRQMbGY8=;
 b=GjP1U/yqUGK4tFCLLXdXGOpFWw/DQSts05xjdXuoa4ym9KMkBMyI/gbpDirnk5tJC9
 8HH3IzVqFosVDx3lTBtnIgEVs48NQN0xdogLaWz2yuPLVA7vLbnZdW48kizRVtXu8cwl
 ONb+nXNUlMShCzWjJb+mniOdD2TcPsU5v4UPr5uJ9KuABmaTi2ayFpQBmr/M6beOVx4s
 uV+UQwRYb5IuWUIsM9iz+j96+rHgak7uQOAUkdY5rfsrEasW4cZqgo4NGIbMGusTvJS5
 owHBTN+96Qqw/FKk1tb0PniWSz2KM70YFVhEwx/83FIs82fJD2aGxaKADaRnHXUdN6zy
 onBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689246292; x=1691838292;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CbQF8XPOqJdmQIcvM8BpUvpXKBooIWInX+MFRQMbGY8=;
 b=a/+nUfxOhZi4KexJVxP9K6IGiX3HSj9uADaH9LmNPRihzqPLgs6QNMnSkPonbfIh+5
 v4RTfG4eXbP3rf6w8NKCLcE/T5l7BhnWLjveN3dnp4z0RXEx4ImtrxOcZLBc5MKH8vyM
 uSqKI4vtRoWSJd7EIG/Ep86e8XfNidtDXyi5A52STxnYJqAv/qwu3+jm6nSpR5XKI87U
 e3nIhgQK8WKelDPHrlbAX4MiYPqZsJsLxT3Dy//jjnMCim3AdrKsIhGftme/1EEO9xjv
 Ceh8uPz8tW2/71u1uk/vj1KZQkIEP2/DbIXr4XwuMJVkxHB1rvCiEulbBXqKOUTFNpav
 xDsw==
X-Gm-Message-State: ABy/qLZxPZRhaHKci/Qjds9rSkKIZHx+Y9mGg8mzrz2briUDCED7gyOb
 60F1mI54IH5sIYkDFjsuZQtT9uNuEw8HJzgJJR/Ey5PR
X-Google-Smtp-Source: APBJJlGrN+/vwP1hQx3rIPssA4VqK7x933iU1Mbc1acIge5/mEG3bOicdGIdiuk9HIXUi4DvRt+SUw==
X-Received: by 2002:a1c:4b0b:0:b0:3fa:8519:d323 with SMTP id
 y11-20020a1c4b0b000000b003fa8519d323mr1423190wma.5.1689246292375; 
 Thu, 13 Jul 2023 04:04:52 -0700 (PDT)
Received: from meli.delivery (adsl-124.37.6.2.tellas.gr. [37.6.2.124])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a1cf30e000000b003fbb25da65bsm7522810wmq.30.2023.07.13.04.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 04:04:51 -0700 (PDT)
Date: Thu, 13 Jul 2023 14:00:40 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 0/3] Add VIRTIO sound card
User-Agent: meli 0.7.3
References: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
Message-ID: <xqes1.ursoa6rc1qb6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

Ping

Patch series on patchew: 
https://patchew.org/QEMU/cover.1686238728.git.manos.pitsidianakis@linaro.org/

Patch series on lore:
https://lore.kernel.org/qemu-devel/cover.1686238728.git.manos.pitsidianakis@linaro.org/


On Thu, 08 Jun 2023 18:56, Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
>This patch series adds an audio device implementing the recent virtio 
>sound spec (1.2) and a corresponding PCI wrapper device.
>
>Main differences with v1 patch 
><20230526204845.673031-1-manos.pitsidianakis@linaro.org>:
>
>- Split virtio-snd and virtio-snd-pci devices to two commits
>- Added audio capture support
>
>Known problems (On pipewire at least):
>
>- Stereo recording results in one channel with the recording + a ticking 
>  kind of artifact and one channel that has no artifacts, just the 
>  recording.
>
>Manos Pitsidianakis (3):
>  Add virtio-sound device
>  Add virtio-sound-pci device
>  Implement audio capture in virtio-snd device
>
> MAINTAINERS                    |    6 +
> hw/virtio/Kconfig              |    5 +
> hw/virtio/meson.build          |    2 +
> hw/virtio/trace-events         |   22 +
> hw/virtio/virtio-snd-pci.c     |  102 +++
> hw/virtio/virtio-snd.c         | 1290 ++++++++++++++++++++++++++++++++
> include/hw/pci/pci.h           |    1 +
> include/hw/virtio/virtio-snd.h |  194 +++++
> softmmu/qdev-monitor.c         |    1 +
> 9 files changed, 1623 insertions(+)
> create mode 100644 hw/virtio/virtio-snd-pci.c
> create mode 100644 hw/virtio/virtio-snd.c
> create mode 100644 include/hw/virtio/virtio-snd.h
>
>Range-diff against v1:
>1:  652c7d2d01 ! 1:  95d564fc1f Add virtio-sound and virtio-sound-pci devices
>    @@ Metadata
>     Author: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>     
>      ## Commit message ##
>    -    Add virtio-sound and virtio-sound-pci devices
>    +    Add virtio-sound device
>     
>         This patch adds an audio device implementing the recent virtio sound
>    -    spec (1.2) and a corresponding PCI wrapper device.
>    +    spec (1.2).
>     
>         PCM functionality is implemented, and jack[0], chmaps[1] messages are
>    -    at the moment ignored.
>    -
>    -    To test this, you'll need a >6.0 kernel compiled with the virtio-snd
>    -    flag enabled, which distros have off by default.
>    -
>    -    Use with following flags in the invocation:
>    -
>    -      -device virtio-sound-pci,disable-legacy=on
>    -
>    -    And an audio backend listed with `-audio driver=help` that works on
>    -    your host machine, e.g.:
>    -
>    -    Pulseaudio:
>    -      -audio driver=pa,model=virtio-sound,server=/run/user/1000/pulse/native
>    -    sdl:
>    -      -audio driver=sdl,model=virtio-sound
>    -    coreaudio:
>    -      -audio driver=coreaudio,model=virtio-sound
>    -    etc.
>    -
>    -    You can use speaker-test from alsa-tools to play noise, sines, or
>    -    WAV files.
>    +    at the moment left unimplemented.
>     
>         PS2: This patch was based on a draft patch posted by OpenSynergy in 2019. [2]
>     
>    @@ Commit message
>         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
>         Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
>     
>    + ## MAINTAINERS ##
>    +@@ MAINTAINERS: F: hw/virtio/virtio-mem-pci.h
>    + F: hw/virtio/virtio-mem-pci.c
>    + F: include/hw/virtio/virtio-mem.h
>    + 
>    ++virtio-snd
>    ++M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>    ++S: Supported
>    ++F: hw/virtio/virtio-snd*.c
>    ++F: include/hw/virtio/virtio-snd.h
>    ++
>    + nvme
>    + M: Keith Busch <kbusch@kernel.org>
>    + M: Klaus Jensen <its@irrelevant.dk>
>    +
>      ## hw/virtio/Kconfig ##
>     @@ hw/virtio/Kconfig: config VIRTIO_PCI
>          depends on PCI
>    @@ hw/virtio/Kconfig: config VIRTIO_PCI
>          select VIRTIO
>     
>      ## hw/virtio/meson.build ##
>    -@@ hw/virtio/meson.build: virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pc
>    - virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'))
>    - virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
>    - virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
>    -+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd-pci.c'))
>    - virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
>    - 
>    - specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
>     @@ hw/virtio/meson.build: softmmu_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
>      softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
>      softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('virtio-stub.c'))
>    @@ hw/virtio/trace-events: virtio_pmem_flush_done(int type) "fsync return=%d"
>     +virtio_snd_handle_pcm_info(int stream) "VIRTIO_SND_R_PCM_INFO called for stream %d"
>     +virtio_snd_handle_pcm_set_params(int stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %d"
>     +virtio_snd_handle_pcm_start_stop(const char *code, int stream) "%s called for stream %d"
>    -+virtio_snd_handle_pcm_release(int stream) "VIRTIO_SND_PCM_RELEASE called for stream %id"
>    ++virtio_snd_handle_pcm_release(int stream) "VIRTIO_SND_PCM_RELEASE called for stream %d"
>     +virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
>     +virtio_snd_handle_xfer(void) "tx/rx queue callback called"
>    -+virtio_snd_handle_xfer_elem(const char * k) "xfer handled in virtio_snd_pcm_%s"
>     +virtio_snd_handle_event(void) "event queue callback called"
>    -+virtio_snd_cpu_is_stopped(void *snd, int size) "snd %p: cpu is stopped, dropping %d bytes"
>     +virtio_snd_realize(void *snd) "snd %p: realize"
>    -+virtio_snd_unrealize(void *snd) "snd %p: realize"
>    ++virtio_snd_unrealize(void *snd) "snd %p: unrealize"
>     +virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_features 0x%"PRIx64
>     +virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32_t chmaps) "snd %p: get_config jacks=%d streams=%d chmaps=%d"
>     +virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) "snd %p: set_config jacks from %d->%d, streams from %d->%d, chmaps from %d->%d"
>    @@ hw/virtio/trace-events: virtio_pmem_flush_done(int type) "fsync return=%d"
>     +virtio_snd_vm_state_stopped(void) "vm state stopped"
>     +virtio_snd_handle_code(int val, const char *code) "ctrl code msg val = %d == %s"
>     
>    - ## hw/virtio/virtio-snd-pci.c (new) ##
>    -@@
>    -+/*
>    -+ * VIRTIO Sound Device PCI Bindings
>    -+ *
>    -+ * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
>    -+ *
>    -+ * This work is licensed under the terms of the GNU GPL, version 2 or
>    -+ * (at your option) any later version.  See the COPYING file in the
>    -+ * top-level directory.
>    -+ */
>    -+
>    -+#include "qemu/osdep.h"
>    -+#include "hw/audio/soundhw.h"
>    -+#include "hw/virtio/virtio-pci.h"
>    -+#include "hw/virtio/virtio-snd.h"
>    -+
>    -+typedef struct VirtIOSoundPCI VirtIOSoundPCI;
>    -+
>    -+/*
>    -+ * virtio-snd-pci: This extends VirtioPCIProxy.
>    -+ */
>    -+#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci-base"
>    -+DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SOUND_PCI,
>    -+                         TYPE_VIRTIO_SND_PCI)
>    -+
>    -+struct VirtIOSoundPCI {
>    -+    VirtIOPCIProxy parent;
>    -+    VirtIOSound vdev;
>    -+};
>    -+
>    -+static Property virtio_snd_pci_properties[] = {
>    -+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
>    -+    DEFINE_PROP_END_OF_LIST(),
>    -+};
>    -+
>    -+static const char *audiodev_id;
>    -+
>    -+static int virtio_snd_init_pci(PCIBus *init_bus, const char *audiodev)
>    -+{
>    -+    audiodev_id = audiodev;
>    -+    return 0;
>    -+}
>    -+
>    -+static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>    -+{
>    -+    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(vpci_dev);
>    -+    DeviceState *vdev = DEVICE(&dev->vdev);
>    -+    VirtIOSound *vsnd = VIRTIO_SND(&dev->vdev);
>    -+
>    -+    /*
>    -+     * According to spec, non-legacy virtio PCI devices are always little
>    -+     * endian
>    -+     */
>    -+    vsnd->virtio_access_is_big_endian = false;
>    -+
>    -+
>    -+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
>    -+
>    -+
>    -+    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
>    -+    AUD_register_card ("virtio-sound", &dev->vdev.card);
>    -+
>    -+    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
>    -+}
>    -+
>    -+static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
>    -+{
>    -+    DeviceClass *dc = DEVICE_CLASS(klass);
>    -+    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
>    -+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>    -+
>    -+    vpciklass->realize = virtio_snd_pci_realize;
>    -+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>    -+
>    -+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
>    -+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SND;
>    -+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
>    -+    pcidev_k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
>    -+    device_class_set_props(dc, virtio_snd_pci_properties);
>    -+}
>    -+
>    -+static void virtio_snd_pci_instance_init(Object *obj)
>    -+{
>    -+    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(obj);
>    -+
>    -+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>    -+                                TYPE_VIRTIO_SND);
>    -+}
>    -+
>    -+static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
>    -+    .base_name     = TYPE_VIRTIO_SND_PCI,
>    -+    .generic_name  = "virtio-sound-pci",
>    -+    .instance_size = sizeof(VirtIOSoundPCI),
>    -+    .instance_init = virtio_snd_pci_instance_init,
>    -+    .class_init    = virtio_snd_pci_class_init,
>    -+};
>    -+
>    -+static void virtio_snd_pci_register(void)
>    -+{
>    -+    virtio_pci_types_register(&virtio_snd_pci_info);
>    -+    pci_register_soundhw("virtio-sound", "Virtio Sound Device",
>    -+                         virtio_snd_init_pci);
>    -+}
>    -+
>    -+type_init(virtio_snd_pci_register);
>    -
>      ## hw/virtio/virtio-snd.c (new) ##
>     @@
>     +/*
>    @@ hw/virtio/virtio-snd.c (new)
>     +#define VIRTIO_SOUND_STREAM_DEFAULT 1
>     +#define VIRTIO_SOUND_CHMAP_DEFAULT 0
>     +
>    -+#define VIRTIO_SOUND_HDA_FN_NID_OUT 0
>    -+#define VIRTIO_SOUND_HDA_FN_NID_IN 1
>    ++#define VIRTIO_SOUND_HDA_FN_NID 0
>     +
>     +static const VMStateDescription vmstate_virtio_snd_device = {
>     +    .name = TYPE_VIRTIO_SND,
>    @@ hw/virtio/virtio-snd.c (new)
>     +uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
>     +                                       virtio_snd_pcm_set_params *params)
>     +{
>    ++    uint32_t supported_formats, supported_rates;
>    ++    VirtIOSoundPCMParams *st_params;
>     +    uint32_t stream_id = params->hdr.stream_id;
>    ++
>     +    if (stream_id > s->snd_conf.streams || !(s->pcm->pcm_params)) {
>     +        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
>     +        return VIRTIO_SND_S_BAD_MSG;
>    @@ hw/virtio/virtio-snd.c (new)
>     +    if (!s->pcm->pcm_params[stream_id]) {
>     +        s->pcm->pcm_params[stream_id] = g_new0(VirtIOSoundPCMParams, 1);
>     +    }
>    -+    VirtIOSoundPCMParams *st_params = virtio_snd_pcm_get_params(s, stream_id);
>    ++    st_params = virtio_snd_pcm_get_params(s, stream_id);
>     +
>     +    st_params->features = params->features;
>     +    st_params->buffer_bytes = params->buffer_bytes;
>    @@ hw/virtio/virtio-snd.c (new)
>     +    }
>     +    st_params->channels = params->channels;
>     +
>    -+    uint32_t supported_formats = 1 << VIRTIO_SND_PCM_FMT_S8
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_U8
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_S16
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_U16
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_S32
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_U32
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
>    -+
>    -+    uint32_t supported_rates = 1 << VIRTIO_SND_PCM_RATE_5512
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_8000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_11025
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_16000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_22050
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_32000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_44100
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_48000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_64000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_88200
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_96000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_176400
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_192000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_384000;
>    ++    supported_formats = 1 << VIRTIO_SND_PCM_FMT_S8
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_U8
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_S16
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_U16
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_S32
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_U32
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
>    ++
>    ++    supported_rates = 1 << VIRTIO_SND_PCM_RATE_5512
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_8000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_11025
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_16000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_22050
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_32000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_44100
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_48000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_64000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_88200
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_96000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_176400
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_192000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_384000;
>     +
>     +    if (!(supported_formats & (1 << params->format))) {
>     +        error_report("Stream format is not supported.");
>    @@ hw/virtio/virtio-snd.c (new)
>     +    st_params->rate = params->rate;
>     +    st_params->period_bytes = params->period_bytes;
>     +    st_params->buffer_bytes = params->buffer_bytes;
>    ++
>     +    return VIRTIO_SND_S_OK;
>     +}
>     +
>    @@ hw/virtio/virtio-snd.c (new)
>     +{
>     +    virtio_snd_pcm_set_params req;
>     +    uint32_t sz;
>    ++
>     +    sz = iov_to_buf(cmd->elem->out_sg,
>     +                    cmd->elem->out_num,
>     +                    0,
>    @@ hw/virtio/virtio-snd.c (new)
>     +
>     +    trace_virtio_snd_handle_pcm_set_params(req.hdr.stream_id);
>     +    cmd->resp.code = virtio_snd_pcm_set_params_impl(s, &req);
>    ++
>     +    return;
>     +}
>     +
>    @@ hw/virtio/virtio-snd.c (new)
>     +static void virtio_snd_get_qemu_audsettings(audsettings *as,
>     +                                            VirtIOSoundPCMParams *params)
>     +{
>    -+    as->nchannels = params->channels;
>    ++    as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
>     +    as->fmt = virtio_snd_get_qemu_format(params->format);
>     +    as->freq = virtio_snd_get_qemu_freq(params->rate);
>     +    as->endianness = AUDIO_HOST_ENDIANNESS;
>    @@ hw/virtio/virtio-snd.c (new)
>     + */
>     +static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
>     +{
>    ++    audsettings as;
>    ++    uint32_t supported_formats, supported_rates;
>    ++    VirtIOSoundPCMParams *params;
>    ++    VirtIOSoundPCMStream *stream;
>    ++
>     +    if (!s->pcm->streams
>     +            || !s->pcm->pcm_params
>     +            || !s->pcm->pcm_params[stream_id]) {
>     +        return VIRTIO_SND_S_BAD_MSG;
>     +    }
>     +
>    -+    uint32_t supported_formats = 1 << VIRTIO_SND_PCM_FMT_S8
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_U8
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_S16
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_U16
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_S32
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_U32
>    -+                                 | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
>    -+
>    -+    uint32_t supported_rates = 1 << VIRTIO_SND_PCM_RATE_5512
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_8000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_11025
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_16000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_22050
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_32000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_44100
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_48000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_64000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_88200
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_96000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_176400
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_192000
>    -+                               | 1 << VIRTIO_SND_PCM_RATE_384000;
>    -+
>    -+    VirtIOSoundPCMParams *params = virtio_snd_pcm_get_params(s, stream_id);
>    ++    supported_formats = 1 << VIRTIO_SND_PCM_FMT_S8
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_U8
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_S16
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_U16
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_S32
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_U32
>    ++                      | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
>    ++
>    ++    supported_rates = 1 << VIRTIO_SND_PCM_RATE_5512
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_8000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_11025
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_16000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_22050
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_32000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_44100
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_48000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_64000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_88200
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_96000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_176400
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_192000
>    ++                    | 1 << VIRTIO_SND_PCM_RATE_384000;
>    ++
>    ++    params = virtio_snd_pcm_get_params(s, stream_id);
>     +    assert(params);
>     +
>    -+    VirtIOSoundPCMStream *stream = g_new0(VirtIOSoundPCMStream, 1);
>    ++    virtio_snd_get_qemu_audsettings(&as, params);
>    ++
>    ++    stream = g_new0(VirtIOSoundPCMStream, 1);
>     +
>    ++    stream->id = stream_id;
>     +    stream->pcm = s->pcm;
>     +    stream->direction = stream_id < s->snd_conf.streams / 2 +
>     +        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
>    -+    stream->info.hdr.hda_fn_nid = stream->direction == VIRTIO_SND_D_OUTPUT ?
>    -+        VIRTIO_SOUND_HDA_FN_NID_OUT : VIRTIO_SOUND_HDA_FN_NID_IN;
>    ++    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>     +    stream->features = 0;
>     +    stream->channels_min = 1;
>    -+    stream->channels_max = AUDIO_MAX_CHANNELS;
>    ++    stream->channels_max = as.nchannels;
>     +    stream->formats = supported_formats;
>     +    stream->rates = supported_rates;
>     +    stream->s = s;
>    @@ hw/virtio/virtio-snd.c (new)
>     +    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
>     +    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
>     +
>    -+    audsettings as;
>    -+    virtio_snd_get_qemu_audsettings(&as, params);
>     +
>     +    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
>     +        stream->voice.out = AUD_open_out(&s->card,
>    @@ hw/virtio/virtio-snd.c (new)
>     +    stream->desired_as = stream->as;
>     +    qemu_mutex_init(&stream->queue_mutex);
>     +    QSIMPLEQ_INIT(&stream->queue);
>    ++
>     +    s->pcm->streams[stream_id] = stream;
>     +
>     +    return VIRTIO_SND_S_OK;
>    @@ hw/virtio/virtio-snd.c (new)
>     +                                             virtio_snd_ctrl_command *cmd,
>     +                                             bool start)
>     +{
>    ++    VirtIOSoundPCMStream *stream;
>     +    virtio_snd_pcm_hdr req;
>     +    size_t sz;
>     +
>    @@ hw/virtio/virtio-snd.c (new)
>     +    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
>     +            "VIRTIO_SND_R_PCM_STOP", req.stream_id);
>     +
>    -+    VirtIOSoundPCMStream *stream = virtio_snd_pcm_get_stream(s, req.stream_id);
>    ++    stream = virtio_snd_pcm_get_stream(s, req.stream_id);
>     +
>     +    if (stream) {
>     +        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
>    @@ hw/virtio/virtio-snd.c (new)
>     +}
>     +
>     +/*
>    -+ * Releases the resources allocated to a stream. Seperated from the handler
>    -+ * so that the code can be reused in the unrealize function.
>    -+ * Returns the response status code. (VIRTIO_SND_S_*).
>    ++ * Releases the buffer resources allocated to a stream. Seperated from the
>    ++ * handler so that the code can be reused in the unrealize function. Returns
>    ++ * the response status code. (VIRTIO_SND_S_*).
>     + *
>     + * @stream: VirtIOSoundPCMStream stream
>     + * @stream_id: stream id
>    @@ hw/virtio/virtio-snd.c (new)
>     +static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
>     +                                            uint32_t stream_id)
>     +{
>    ++    assert(stream->s->pcm->streams[stream_id] == stream);
>    ++
>     +    if (virtio_snd_pcm_get_pending_bytes(stream)) {
>     +        /*
>     +         * virtio-v1.2-csd01, 5.14.6.6.5.1,
>    @@ hw/virtio/virtio-snd.c (new)
>     +        virtio_snd_pcm_flush(stream);
>     +    }
>     +
>    -+    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
>    -+        AUD_close_out(&stream->s->card, stream->voice.out);
>    -+    } else {
>    -+        AUD_close_in(&stream->s->card, stream->voice.in);
>    -+    }
>    -+
>    -+    assert(stream->s->pcm->streams[stream_id] == stream);
>    -+
>     +    return VIRTIO_SND_S_OK;
>     +}
>     +
>    @@ hw/virtio/virtio-snd.c (new)
>     +{
>     +    uint32_t stream_id;
>     +    size_t sz;
>    ++    VirtIOSoundPCMStream *stream;
>     +
>     +    sz = iov_to_buf(cmd->elem->out_sg, cmd->elem->out_num,
>     +            sizeof(virtio_snd_hdr), &stream_id, sizeof(stream_id));
>    @@ hw/virtio/virtio-snd.c (new)
>     +
>     +    trace_virtio_snd_handle_pcm_release(stream_id);
>     +
>    -+    VirtIOSoundPCMStream *stream = virtio_snd_pcm_get_stream(s, stream_id);
>    ++    stream = virtio_snd_pcm_get_stream(s, stream_id);
>     +    if (!stream) {
>     +        error_report("already released stream %d", stream_id);
>     +        virtio_error(VIRTIO_DEVICE(s), "already released stream %d", stream_id);
>    @@ hw/virtio/virtio-snd.c (new)
>     +
>     +    switch (cmd->ctrl.code) {
>     +    case VIRTIO_SND_R_JACK_INFO:
>    -+        /*
>    -+         * Unimplemented
>    -+         * virtio_snd_handle_jack_info(s, cmd);
>    -+         */
>    -+        break;
>     +    case VIRTIO_SND_R_JACK_REMAP:
>    -+        /*
>    -+         * Unimplemented
>    -+         * virtio_snd_handle_jack_remap(s, cmd);
>    -+         */
>    ++        qemu_log_mask(LOG_UNIMP,
>    ++                     "virtio_snd: jack functionality is unimplemented.");
>     +        break;
>     +    case VIRTIO_SND_R_PCM_INFO:
>     +        virtio_snd_handle_pcm_info(s, cmd);
>    @@ hw/virtio/virtio-snd.c (new)
>     +        virtio_snd_handle_pcm_release(s, cmd);
>     +        break;
>     +    case VIRTIO_SND_R_CHMAP_INFO:
>    ++        qemu_log_mask(LOG_UNIMP,
>    ++                     "virtio_snd: chmap info functionality is unimplemented.");
>     +        trace_virtio_snd_handle_chmap_info();
>     +        break;
>     +    default:
>    @@ hw/virtio/virtio-snd.c (new)
>     + */
>     +static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
>     +{
>    ++    qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented.");
>     +    trace_virtio_snd_handle_event();
>     +}
>     +
>    @@ hw/virtio/virtio-snd.c (new)
>     +    VirtQueueElement *elem;
>     +    size_t sz;
>     +    virtio_snd_pcm_xfer hdr;
>    ++    virtio_snd_pcm_status resp = { 0 };
>     +
>     +    trace_virtio_snd_handle_xfer();
>     +
>    @@ hw/virtio/virtio-snd.c (new)
>     +                    elem,
>     +                    hdr.stream_id == VIRTIO_SND_D_INPUT);
>     +
>    -+            virtio_snd_pcm_status resp = { 0 };
>     +            resp.status = VIRTIO_SND_S_OK;
>     +            sz = iov_from_buf(elem->in_sg,
>     +                    elem->in_num,
>    @@ hw/virtio/virtio-snd.c (new)
>     +    VirtIOSoundPCMStream *stream = data;
>     +    VirtIOSoundPCMBlock *block;
>     +    VirtIOSoundPCMBlock *next;
>    ++    int size;
>     +
>     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>     +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
>    -+            int size = MIN(block->size, available);
>    -+
>     +            for (;;) {
>    ++                size = MIN(block->size, available);
>     +                size = AUD_write(stream->voice.out,
>     +                        block->data + block->offset,
>     +                        size);
>    @@ hw/virtio/virtio-snd.c (new)
>     +                            sizeof(block->elem));
>     +                    virtio_notify(VIRTIO_DEVICE(stream->s),
>     +                            block->vq);
>    -+                    QSIMPLEQ_REMOVE(&stream->queue,
>    -+                            block,
>    -+                            VirtIOSoundPCMBlock,
>    -+                            entry);
>    ++                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
>    ++                    g_free(block);
>     +                    available -= size;
>     +                    break;
>     +                }
>    @@ hw/virtio/virtio-snd.c (new)
>     +{
>     +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     +    VirtIOSound *vsnd = VIRTIO_SND(dev);
>    ++    VirtIOSoundPCMStream *stream;
>     +
>     +    qemu_del_vm_change_state_handler(vsnd->vmstate);
>     +    virtio_del_queue(vdev, 0);
>    @@ hw/virtio/virtio-snd.c (new)
>     +    trace_virtio_snd_unrealize(vsnd);
>     +
>     +    for (int i = VIRTIO_SND_D_OUTPUT; i <= VIRTIO_SND_D_INPUT; i++) {
>    -+        VirtIOSoundPCMStream *stream = vsnd->pcm->streams[i];
>    -+
>    ++        stream = vsnd->pcm->streams[i];
>     +        virtio_snd_pcm_close(stream);
>    -+
>     +        g_free(stream);
>     +    }
>     +
>    @@ hw/virtio/virtio-snd.c (new)
>     +        sizeof(virtio_snd_pcm_xfer);
>     +    assert(size <= stream->period_bytes);
>     +
>    -+    trace_virtio_snd_handle_xfer_elem(read ? "read" : "write");
>    -+
>    -+    fragment = g_malloc(sizeof(VirtIOSoundPCMBlock) + size);
>    ++    fragment = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
>     +    fragment->elem = element;
>     +    fragment->vq = vq;
>     +    fragment->size = size;
>    @@ hw/virtio/virtio-snd.c (new)
>     +
>     +type_init(virtio_snd_register);
>     
>    - ## include/hw/pci/pci.h ##
>    -@@ include/hw/pci/pci.h: extern bool pci_available;
>    - #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
>    - #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>    - #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
>    -+#define PCI_DEVICE_ID_VIRTIO_SND         0x1019
>    - 
>    - /*
>    -  * modern virtio-pci devices get their id assigned automatically,
>    -
>      ## include/hw/virtio/virtio-snd.h (new) ##
>     @@
>     +/*
>    @@ include/hw/virtio/virtio-snd.h (new)
>     +typedef struct VirtIOSoundPCMStream {
>     +    VirtIOSoundPCM *pcm;
>     +    struct virtio_snd_pcm_info info;
>    ++    uint32_t id;
>     +    uint32_t buffer_bytes;
>     +    uint32_t period_bytes;
>     +    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
>    @@ include/hw/virtio/virtio-snd.h (new)
>     +  }
>     +};
>     +#endif
>    -
>    - ## softmmu/qdev-monitor.c ##
>    -@@ softmmu/qdev-monitor.c: static const QDevAlias qdev_alias_table[] = {
>    -     { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
>    -     { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
>    -     { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
>    -+    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},
>    -     { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
>    -     { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
>    -     { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },
>-:  ---------- > 2:  db527bc9a1 Add virtio-sound-pci device
>-:  ---------- > 3:  4c130f066d Implement audio capture in virtio-snd device
>-- 
>2.39.2
>

