Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E779E0DC
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKNt-0006SI-Bv; Wed, 13 Sep 2023 03:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKNq-0006S4-In
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:33:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKNl-0001ga-Ff
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:33:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401bbfc05fcso71299285e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590431; x=1695195231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dkW4iPfbXSyzWbRfSLqUePKqVuPZn2s0XGoKgd7WV84=;
 b=wYJPBjs2sK8Bn9viEczA8kLAuRrN7czCrhGHcIrIMcz0grQPcHme7LVyMmXqwUi1HQ
 e78mW1emFTFkjI2YnN+oN7Kg1oHtv2KUWn4cJweFfWrjTM50R0dj9OvARv+lPpqBHkb9
 6h4QH7YNRMgnOiYVmD1C6TLHWLD/RZnceSjFjBxmad8U5nT7R+2RUdiebkhYuALVcMEA
 FsrS8pTRPUOtP8LrZi3DDrNzESqkYWVilhMTZENTZ/SOmy8uk21RMb46Q7i0KLHbYMci
 FvnNJC27MzMH5+HN3O/s6OugDSb7TbM2Q30PGpgTc3az5ZAdABJyaIdCMXnE6/ANTlEs
 0d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590431; x=1695195231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dkW4iPfbXSyzWbRfSLqUePKqVuPZn2s0XGoKgd7WV84=;
 b=f5YRB+dlz9qUdQdBRyZKFgOoshFt2x9p2AG2fzzVUQDkckmV/bQ+zi02fVzvE3rtBg
 SxsZjBdO7GuLBO6yoeHXSZodUyet8hx0TeVIVfuAAUz/UfEeFBEzU5utjH8cV/0dG+WQ
 7C9vD2bM3hh2YKSQAct7rSnYegrDWjmdzBX0BJ49ZENa01emxP60WE3rh2kiIaY79IgM
 2VMIYLsnZzdjqmGfVjJ5/AiRqejDnEuE20wZZSv0o4emq6UbnS5sHn2QFSit8xRun2jo
 54TI9YD+Qqt3IcbIUY4RRu6Gp3aJEHKoJAyzHO/J+In14zJ+BwNzEeMFqYH0xcqQbuY9
 LbNg==
X-Gm-Message-State: AOJu0YwDnDxHYOlQ8HX2MhaipfjgrmVFU254vmU/qMgKzWZQkEIqH6As
 2ar7I0TErTkItIAnChLqJWtxQvP4y6fab/sivjk=
X-Google-Smtp-Source: AGHT+IEVxiJqGNeEQ+UvJhaTZcnzQRbnstDnvwaP0crJHMe7ktWv05n2J7Ixu/juqjfsES7B4/PzpA==
X-Received: by 2002:adf:e386:0:b0:31a:dc58:cdd9 with SMTP id
 e6-20020adfe386000000b0031adc58cdd9mr1380790wrm.60.1694590430551; 
 Wed, 13 Sep 2023 00:33:50 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:33:49 -0700 (PDT)
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
Subject: [PATCH v9 00/12] Add VIRTIO sound card
Date: Wed, 13 Sep 2023 10:33:07 +0300
Message-Id: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

v9 can be found online at:

https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v9

Ref 06e6b17186

Main differences with v8 patch series [^v8]
<cover.1693252037.git.manos.pitsidianakis@linaro.org>:

- Addressed [^v8] review comments.
- Add cpu_to_le32(_) and le32_to_cpu(_) conversions for messages from/to 
  the guest according to the virtio spec.
- Inlined some functions and types to reduce review complexity.
- Corrected the replies to IO messages; now both Playback and Capture 
  work correctly for me. (If you hear cracks in pulseaudio+guest, try 
  pipewire+guest).

Previously:

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
 docs/system/devices/virtio-snd.rst |   49 +
 hw/virtio/Kconfig                  |    5 +
 hw/virtio/meson.build              |    2 +
 hw/virtio/trace-events             |   20 +
 hw/virtio/virtio-snd-pci.c         |   93 ++
 hw/virtio/virtio-snd.c             | 1339 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio-snd.h     |  193 ++++
 softmmu/qdev-monitor.c             |    1 +
 10 files changed, 1709 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

Range-diff against v8:
 1:  238de1757e !  1:  5173e2c243 Add virtio-sound device stub
    @@ hw/virtio/virtio-snd.c (new)
     +#include "trace.h"
     +#include "qapi/error.h"
     +#include "hw/virtio/virtio-snd.h"
    ++#include "hw/core/cpu.h"
     +
     +#define VIRTIO_SOUND_VM_VERSION 1
     +#define VIRTIO_SOUND_JACK_DEFAULT 0
    @@ hw/virtio/virtio-snd.c (new)
     +};
     +
     +static Property virtio_snd_properties[] = {
    ++    DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
     +    DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
     +                       VIRTIO_SOUND_JACK_DEFAULT),
     +    DEFINE_PROP_UINT32("streams", VirtIOSound, snd_conf.streams,
    @@ hw/virtio/virtio-snd.c (new)
     +    VirtIOSound *vsnd = VIRTIO_SND(dev);
     +
     +    qemu_del_vm_change_state_handler(vsnd->vmstate);
    -+    virtio_del_queue(vdev, 0);
    -+
     +    trace_virtio_snd_unrealize(vsnd);
     +
     +    AUD_remove_card(&vsnd->card);
    ++    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
    ++    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
    ++    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
    ++    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_RX]);
     +    virtio_cleanup(vdev);
     +}
     +
    @@ include/hw/virtio/virtio-snd.h (new)
     +
     +typedef struct VirtIOSound {
     +    VirtIODevice parent_obj;
    ++
     +    VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     +    uint64_t features;
     +    QEMUSoundCard card;
 2:  8de966a86b !  2:  d2fdd5852d Add virtio-sound-pci device
    @@ hw/virtio/virtio-snd-pci.c (new)
     + */
     +
     +#include "qemu/osdep.h"
    ++#include "qom/object.h"
     +#include "qapi/error.h"
     +#include "hw/audio/soundhw.h"
     +#include "hw/virtio/virtio-pci.h"
     +#include "hw/virtio/virtio-snd.h"
     +
    -+typedef struct VirtIOSoundPCI VirtIOSoundPCI;
    -+
     +/*
     + * virtio-snd-pci: This extends VirtioPCIProxy.
     + */
     +#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci"
    -+DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SND_PCI,
    -+                         TYPE_VIRTIO_SND_PCI)
    ++OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSoundPCI, VIRTIO_SND_PCI)
     +
     +struct VirtIOSoundPCI {
    -+    VirtIOPCIProxy parent;
    ++    VirtIOPCIProxy parent_obj;
    ++
     +    VirtIOSound vdev;
     +};
     +
     +static Property virtio_snd_pci_properties[] = {
    -+    DEFINE_AUDIO_PROPERTIES(VirtIOSoundPCI, vdev.card),
     +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
     +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
    -+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
    -+                       DEV_NVECTORS_UNSPECIFIED),
    ++    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
     +    DEFINE_PROP_END_OF_LIST(),
     +};
     +
    @@ hw/virtio/virtio-snd-pci.c (new)
     +    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(vpci_dev);
     +    DeviceState *vdev = DEVICE(&dev->vdev);
     +
    -+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
    -+        vpci_dev->nvectors = 2;
    -+    }
    -+
     +    virtio_pci_force_virtio_1(vpci_dev);
     +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
     +}
    @@ hw/virtio/virtio-snd-pci.c (new)
     +/* Create a Virtio Sound PCI device, so '-audio driver,model=virtio' works. */
     +static int virtio_snd_pci_init(PCIBus *bus, const char *audiodev)
     +{
    -+    DeviceState *dev;
    -+
    -+    dev = qdev_new(TYPE_VIRTIO_SND_PCI);
    -+    qdev_prop_set_string(dev, "audiodev", audiodev);
    -+    qdev_realize_and_unref(dev, BUS(bus), &error_fatal);
    ++    DeviceState *vdev = NULL;
    ++    VirtIOSoundPCI *dev = NULL;
    ++
    ++    vdev = qdev_new(TYPE_VIRTIO_SND_PCI);
    ++    assert(vdev);
    ++    dev = VIRTIO_SND_PCI(vdev);
    ++    qdev_prop_set_string(DEVICE(&dev->vdev), "audiodev", audiodev);
    ++    qdev_realize_and_unref(vdev, BUS(bus), &error_fatal);
     +    return 0;
     +}
     +
 3:  e3e57dd125 !  3:  8e07c6dcae virtio-sound: handle control messages and streams
    @@ hw/virtio/trace-events: virtio_snd_vm_state_running(void) "vm state running"
     +virtio_snd_handle_event(void) "event queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
    -@@
    - #define VIRTIO_SOUND_CHMAP_DEFAULT 0
    - #define VIRTIO_SOUND_HDA_FN_NID 0
    +@@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
    +     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
    + }
      
    ++static void
    ++virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
    ++{
    ++    g_free(cmd->elem);
    ++    g_free(cmd);
    ++}
    ++
     +static const char *print_code(uint32_t code)
     +{
     +    #define CASE(CODE)            \
    @@ hw/virtio/virtio-snd.c
     +    #undef CASE
     +};
     +
    - static const VMStateDescription vmstate_virtio_snd_device = {
    -     .name = TYPE_VIRTIO_SND,
    -     .version_id = VIRTIO_SOUND_VM_VERSION,
    -@@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
    - }
    - 
    - /*
    -- * Queue handler stub.
    ++/*
     + * The actual processing done in virtio_snd_process_cmdq().
     + *
     + * @s: VirtIOSound device
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +static inline void
     +process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
     +{
    -+    size_t sz = iov_to_buf(cmd->elem->out_sg,
    -+                           cmd->elem->out_num,
    -+                           0,
    -+                           &cmd->ctrl,
    -+                           sizeof(cmd->ctrl));
    -+    if (sz != sizeof(cmd->ctrl)) {
    ++    uint32_t code;
    ++    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
    ++                               cmd->elem->out_num,
    ++                               0,
    ++                               &cmd->ctrl,
    ++                               sizeof(cmd->ctrl));
    ++
    ++    if (msg_sz != sizeof(cmd->ctrl)) {
     +        qemu_log_mask(LOG_GUEST_ERROR,
     +                "%s: virtio-snd command size incorrect %zu vs \
    -+                %zu\n", __func__, sz, sizeof(cmd->ctrl));
    ++                %zu\n", __func__, msg_sz, sizeof(cmd->ctrl));
     +        return;
     +    }
     +
    -+    trace_virtio_snd_handle_code(cmd->ctrl.code,
    -+                                 print_code(cmd->ctrl.code));
    ++    code = le32_to_cpu(cmd->ctrl.code);
    ++
    ++    trace_virtio_snd_handle_code(code, print_code(code));
     +
    -+    switch (cmd->ctrl.code) {
    ++    switch (code) {
     +    case VIRTIO_SND_R_JACK_INFO:
     +    case VIRTIO_SND_R_JACK_REMAP:
     +        qemu_log_mask(LOG_UNIMP,
    -+                     "virtio_snd: jack functionality is unimplemented.");
    -+        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
    ++                     "virtio_snd: jack functionality is unimplemented.\n");
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     +        break;
     +    case VIRTIO_SND_R_PCM_INFO:
     +    case VIRTIO_SND_R_PCM_SET_PARAMS:
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +    case VIRTIO_SND_R_PCM_START:
     +    case VIRTIO_SND_R_PCM_STOP:
     +    case VIRTIO_SND_R_PCM_RELEASE:
    -+        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     +        break;
     +    case VIRTIO_SND_R_CHMAP_INFO:
     +        qemu_log_mask(LOG_UNIMP,
    -+                     "virtio_snd: chmap info functionality is unimplemented.");
    ++                     "virtio_snd: chmap info functionality is unimplemented.\n");
     +        trace_virtio_snd_handle_chmap_info();
    -+        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     +        break;
     +    default:
     +        /* error */
    -+        error_report("virtio snd header not recognized: %"PRIu32,
    -+                     cmd->ctrl.code);
    -+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    ++        error_report("virtio snd header not recognized: %"PRIu32, code);
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +    }
     +
     +    iov_from_buf(cmd->elem->in_sg,
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +
     +            QTAILQ_REMOVE(&s->cmdq, cmd, next);
     +
    -+            g_free(cmd);
    ++            virtio_snd_ctrl_cmd_free(cmd);
     +        }
     +        qatomic_set(&s->processing_cmdq, false);
     +    }
     +}
     +
    -+/*
    + /*
    +- * Queue handler stub.
     + * The control message handler. Pops an element from the control virtqueue,
     + * and stores them to VirtIOSound's cmdq queue and finally calls
     + * virtio_snd_process_cmdq() for processing.
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +        cmd = g_new0(virtio_snd_ctrl_command, 1);
     +        cmd->elem = elem;
     +        cmd->vq = vq;
    -+        cmd->resp.code = VIRTIO_SND_S_OK;
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     +        QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
     +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     +    }
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     + */
     +static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
     +{
    -+    qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented.");
    ++    qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented.\n");
     +    trace_virtio_snd_handle_event();
     +}
     +
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
      
      static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                                   Error **errp)
    -@@ hw/virtio/virtio-snd.c: virtio_snd_vm_state_change(void *opaque, bool running,
    -     }
    - }
    - 
    -+static void virtio_snd_set_pcm(VirtIOSound *snd)
    -+{
    -+    VirtIOSoundPCM *pcm;
    -+
    -+    pcm = g_new0(VirtIOSoundPCM, 1);
    -+    pcm->snd = snd;
    -+    pcm->streams = g_new0(VirtIOSoundPCMStream *, snd->snd_conf.streams);
    -+    pcm->pcm_params = g_new0(VirtIOSoundPCMParams, snd->snd_conf.streams);
    -+
    -+    snd->pcm = pcm;
    -+}
    -+
    - static void virtio_snd_realize(DeviceState *dev, Error **errp)
    - {
    -     ERRP_GUARD();
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
          VirtIOSound *vsnd = VIRTIO_SND(dev);
          VirtIODevice *vdev = VIRTIO_DEVICE(dev);
      
    @@ hw/virtio/virtio-snd.c: virtio_snd_vm_state_change(void *opaque, bool running,
      
          trace_virtio_snd_realize(vsnd);
      
    -+    virtio_snd_set_pcm(vsnd);
    ++    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
    ++    vsnd->pcm->snd = vsnd;
    ++    vsnd->pcm->streams = g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
    ++    vsnd->pcm->pcm_params = g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
     +
          virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
          virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +    VirtIOSoundPCMStream *stream;
      
          qemu_del_vm_change_state_handler(vsnd->vmstate);
    -     virtio_del_queue(vdev, 0);
    - 
          trace_virtio_snd_unrealize(vsnd);
      
     +    if (vsnd->pcm) {
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +            }
     +            g_free(vsnd->pcm->streams);
     +        }
    ++        g_free(vsnd->pcm->pcm_params);
     +        g_free(vsnd->pcm);
     +        vsnd->pcm = NULL;
     +    }
          AUD_remove_card(&vsnd->card);
    -     virtio_cleanup(vdev);
    ++    qemu_mutex_destroy(&vsnd->cmdq_mutex);
    +     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
    +     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
    +     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
      }
      
      
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +        while (!QTAILQ_EMPTY(&s->cmdq)) {
     +            cmd = QTAILQ_FIRST(&s->cmdq);
     +            QTAILQ_REMOVE(&s->cmdq, cmd, next);
    -+            g_free(cmd);
    ++            virtio_snd_ctrl_cmd_free(cmd);
     +        }
     +    }
     +}
    @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_pcm_xfer virtio_snd_pc
     +
     +typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
     +
    -+typedef struct VirtIOSoundPCMParams VirtIOSoundPCMParams;
    -+
     +typedef struct VirtIOSoundPCM VirtIOSoundPCM;
     +
    -+/* Stream params */
    -+struct VirtIOSoundPCMParams {
    -+    uint32_t features;
    -+    uint32_t buffer_bytes;          /* size of hardware buffer in bytes */
    -+    uint32_t period_bytes;          /* size of hardware period in bytes */
    -+    uint8_t channels;
    -+    uint8_t format;
    -+    uint8_t rate;
    -+};
    -+
     +struct VirtIOSoundPCM {
     +    VirtIOSound *snd;
    -+    VirtIOSoundPCMParams *pcm_params;
    ++    virtio_snd_pcm_set_params *pcm_params;
     +    VirtIOSoundPCMStream **streams;
     +};
     +
    ++/*
    ++ * PCM stream state machine.
    ++ * -------------------------
    ++ *
    ++ * 5.14.6.6.1 PCM Command Lifecycle
    ++ * ================================
    ++ *
    ++ * A PCM stream has the following command lifecycle:
    ++ * - `SET PARAMETERS`
    ++ *   The driver negotiates the stream parameters (format, transport, etc) with
    ++ *   the device.
    ++ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.
    ++ * - `PREPARE`
    ++ *   The device prepares the stream (allocates resources, etc).
    ++ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`, `START`,
    ++ *   `RELEASE`. Output only: the driver transfers data for pre-buffing.
    ++ * - `START`
    ++ *   The device starts the stream (unmute, putting into running state, etc).
    ++ *   Possible valid transitions: `STOP`.
    ++ *   The driver transfers data to/from the stream.
    ++ * - `STOP`
    ++ *   The device stops the stream (mute, putting into non-running state, etc).
    ++ *   Possible valid transitions: `START`, `RELEASE`.
    ++ * - `RELEASE`
    ++ *   The device releases the stream (frees resources, etc).
    ++ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.
    ++ *
    ++ * +---------------+ +---------+ +---------+ +-------+ +-------+
    ++ * | SetParameters | | Prepare | | Release | | Start | | Stop  |
    ++ * +---------------+ +---------+ +---------+ +-------+ +-------+
    ++ *         |-             |           |          |         |
    ++ *         ||             |           |          |         |
    ++ *         |<             |           |          |         |
    ++ *         |------------->|           |          |         |
    ++ *         |<-------------|           |          |         |
    ++ *         |              |-          |          |         |
    ++ *         |              ||          |          |         |
    ++ *         |              |<          |          |         |
    ++ *         |              |--------------------->|         |
    ++ *         |              |---------->|          |         |
    ++ *         |              |           |          |-------->|
    ++ *         |              |           |          |<--------|
    ++ *         |              |           |<-------------------|
    ++ *         |<-------------------------|          |         |
    ++ *         |              |<----------|          |         |
    ++ *
    ++ * CTRL in the VirtIOSound device
    ++ * ==============================
    ++ *
    ++ * The control messages that affect the state of a stream arrive in the
    ++ * `virtio_snd_handle_ctrl()` queue callback and are of type `struct
    ++ * virtio_snd_ctrl_command`. They are stored in a queue field in the device
    ++ * type, `VirtIOSound`. This allows deferring the CTRL request completion if
    ++ * it's not immediately possible due to locking/state reasons.
    ++ *
    ++ * The CTRL message is finally handled in `process_cmd()`.
    ++ */
     +struct VirtIOSoundPCMStream {
     +    VirtIOSoundPCM *pcm;
     +    virtio_snd_pcm_info info;
    ++    virtio_snd_pcm_set_params params;
     +    uint32_t id;
    -+    uint32_t buffer_bytes;
    -+    uint32_t period_bytes;
     +    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     +    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     +    VirtIOSound *s;
    -+    uint32_t features; /* 1 << VIRTIO_SND_PCM_F_XXX */
    -+    uint64_t formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
    -+    uint64_t rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
    -+    uint8_t direction;
    -+    uint8_t channels_min;
    -+    uint8_t channels_max;
     +    bool flushing;
     +    audsettings as;
    -+    audsettings desired_as;
     +    union {
     +        SWVoiceIn *in;
     +        SWVoiceOut *out;
    @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_pcm_xfer virtio_snd_pc
     +
     +struct VirtIOSound {
          VirtIODevice parent_obj;
    + 
          VirtQueue *queues[VIRTIO_SND_VQ_MAX];
          uint64_t features;
     +    VirtIOSoundPCM *pcm;
 4:  6b3f8d8206 !  4:  7413b85f08 virtio-sound: set PCM stream parameters
    @@ hw/virtio/virtio-snd.c
     +                                | BIT(VIRTIO_SND_PCM_RATE_192000)
     +                                | BIT(VIRTIO_SND_PCM_RATE_384000);
     +
    - static const char *print_code(uint32_t code)
    - {
    -     #define CASE(CODE)            \
    -@@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
    -     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
    + static const VMStateDescription vmstate_virtio_snd_device = {
    +     .name = TYPE_VIRTIO_SND,
    +     .version_id = VIRTIO_SOUND_VM_VERSION,
    +@@ hw/virtio/virtio-snd.c: virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
    +     g_free(cmd);
      }
      
     +/*
    -+ * Get params for a specific stream.
    ++ * Get a specific stream from the virtio sound card device.
    ++ * Returns NULL if @stream_id is invalid or not allocated.
     + *
     + * @s: VirtIOSound device
     + * @stream_id: stream id
     + */
    -+static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(VirtIOSound *s,
    ++static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
     +                                                       uint32_t stream_id)
     +{
    ++    return stream_id >= s->snd_conf.streams ? NULL :
    ++        s->pcm->streams[stream_id];
    ++}
    ++
    ++/*
    ++ * Get params for a specific stream.
    ++ *
    ++ * @s: VirtIOSound device
    ++ * @stream_id: stream id
    ++ */
    ++static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
    ++                                                            uint32_t stream_id)
    ++{
     +    return stream_id >= s->snd_conf.streams ? NULL
     +        : &s->pcm->pcm_params[stream_id];
     +}
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     + */
     +static
     +uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
    ++                                   uint32_t stream_id,
     +                                   virtio_snd_pcm_set_params *params)
     +{
    -+    VirtIOSoundPCMParams *st_params;
    -+    uint32_t stream_id = params->hdr.stream_id;
    ++    virtio_snd_pcm_set_params *st_params;
     +
     +    if (stream_id >= s->snd_conf.streams || !(s->pcm->pcm_params)) {
     +        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
    -+        return VIRTIO_SND_S_BAD_MSG;
    ++        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +    }
     +
     +    st_params = virtio_snd_pcm_get_params(s, stream_id);
     +
     +    if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
     +        error_report("Number of channels is not supported.");
    -+        return VIRTIO_SND_S_NOT_SUPP;
    ++        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     +    }
     +    if (!(supported_formats & BIT(params->format))) {
     +        error_report("Stream format is not supported.");
    -+        return VIRTIO_SND_S_NOT_SUPP;
    ++        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     +    }
     +    if (!(supported_rates & BIT(params->rate))) {
     +        error_report("Stream rate is not supported.");
    -+        return VIRTIO_SND_S_NOT_SUPP;
    ++        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     +    }
     +
    -+    st_params->buffer_bytes = params->buffer_bytes;
    -+    st_params->period_bytes = params->period_bytes;
    -+    st_params->features = params->features;
    ++    st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
    ++    st_params->period_bytes = le32_to_cpu(params->period_bytes);
    ++    st_params->features = le32_to_cpu(params->features);
     +    st_params->channels = params->channels;
     +    st_params->format = params->format;
     +    st_params->rate = params->rate;
     +
    -+    return VIRTIO_SND_S_OK;
    ++    return cpu_to_le32(VIRTIO_SND_S_OK);
     +}
     +
     +/*
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     + * params.
     + */
     +static void virtio_snd_get_qemu_audsettings(audsettings *as,
    -+                                            VirtIOSoundPCMParams *params)
    ++                                            virtio_snd_pcm_set_params *params)
     +{
     +    as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
     +    as->fmt = virtio_snd_get_qemu_format(params->format);
     +    as->freq = virtio_snd_get_qemu_freq(params->rate);
    -+    as->endianness = AUDIO_HOST_ENDIANNESS;
    ++    as->endianness = target_words_bigendian() ? 1 : 0;
     +}
     +
     +/*
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     + */
     +static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
     +{
    -+    if (stream) {
    -+        qemu_mutex_destroy(&stream->queue_mutex);
    -+        g_free(stream);
    -+    }
     +}
     +
     +/*
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     +{
     +    audsettings as;
    -+    VirtIOSoundPCMParams *params;
    ++    virtio_snd_pcm_set_params *params;
     +    VirtIOSoundPCMStream *stream;
     +
     +    if (!s->pcm->streams ||
     +        !s->pcm->pcm_params ||
     +        stream_id >= s->snd_conf.streams) {
    -+        return VIRTIO_SND_S_BAD_MSG;
    ++        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +    }
     +
     +    params = virtio_snd_pcm_get_params(s, stream_id);
     +    if (!params) {
    -+        return VIRTIO_SND_S_BAD_MSG;
    ++        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +    }
     +
    -+    virtio_snd_get_qemu_audsettings(&as, params);
    -+
    -+    virtio_snd_pcm_close(s->pcm->streams[stream_id]);
    ++    stream = virtio_snd_pcm_get_stream(s, stream_id);
    ++    virtio_snd_pcm_close(stream);
    ++    if (!stream) {
    ++        stream = g_new0(VirtIOSoundPCMStream, 1);
    ++        stream->id = stream_id;
    ++        stream->pcm = s->pcm;
    ++        stream->s = s;
    ++        qemu_mutex_init(&stream->queue_mutex);
    ++        QSIMPLEQ_INIT(&stream->queue);
     +
    -+    stream = g_new0(VirtIOSoundPCMStream, 1);
    ++        s->pcm->streams[stream_id] = stream;
    ++    }
     +
    -+    stream->id = stream_id;
    -+    stream->pcm = s->pcm;
    -+    stream->direction = stream_id < s->snd_conf.streams / 2 +
    ++    virtio_snd_get_qemu_audsettings(&as, params);
    ++    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
     +        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
     +    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
    -+    stream->features = 0;
    -+    stream->channels_min = 1;
    -+    stream->channels_max = as.nchannels;
    -+    stream->formats = supported_formats;
    -+    stream->rates = supported_rates;
    -+    stream->s = s;
    ++    stream->info.features = 0;
    ++    stream->info.channels_min = 1;
    ++    stream->info.channels_max = as.nchannels;
    ++    stream->info.formats = supported_formats;
    ++    stream->info.rates = supported_rates;
     +
    -+    stream->buffer_bytes = params->buffer_bytes;
    -+    stream->period_bytes = params->period_bytes;
    ++    stream->params.buffer_bytes = params->buffer_bytes;
    ++    stream->params.period_bytes = params->period_bytes;
     +
     +    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
     +    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
    -+
     +    stream->as = as;
    -+    stream->desired_as = stream->as;
    -+    qemu_mutex_init(&stream->queue_mutex);
    -+    QSIMPLEQ_INIT(&stream->queue);
     +
    -+    s->pcm->streams[stream_id] = stream;
    -+
    -+    return VIRTIO_SND_S_OK;
    ++    return cpu_to_le32(VIRTIO_SND_S_OK);
     +}
     +
    - /*
    -  * The actual processing done in virtio_snd_process_cmdq().
    -  *
    + static const char *print_code(uint32_t code)
    + {
    +     #define CASE(CODE)            \
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
          ERRP_GUARD();
          VirtIOSound *vsnd = VIRTIO_SND(dev);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     -static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
     -{
     +    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
    -+        default_params.hdr.stream_id = i;
    -+        status = virtio_snd_set_pcm_params(vsnd, &default_params);
    -+        if (status != VIRTIO_SND_S_OK) {
    ++        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
    ++        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
     +            error_setg(errp,
     +                       "Can't initalize stream params, device responded with %s.",
     +                       print_code(status));
     +            return;
     +        }
     +        status = virtio_snd_pcm_prepare(vsnd, i);
    -+        if (status != VIRTIO_SND_S_OK) {
    ++        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
     +            error_setg(errp,
     +                       "Can't prepare streams, device responded with %s.",
     +                       print_code(status));
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
      
      static void virtio_snd_unrealize(DeviceState *dev)
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
    -         vsnd->pcm = NULL;
    -     }
    -     AUD_remove_card(&vsnd->card);
    -+    qemu_mutex_destroy(&vsnd->cmdq_mutex);
    -     virtio_cleanup(vdev);
    - }
    - 
    +                 if (stream) {
    +                     virtio_snd_process_cmdq(stream->s);
    +                     virtio_snd_pcm_close(stream);
    ++                    qemu_mutex_destroy(&stream->queue_mutex);
    +                     g_free(stream);
    +                 }
    +             }
 5:  974d88412d <  -:  ---------- virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
 -:  ---------- >  5:  8fa5413798 virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
 6:  ff6f132004 !  6:  c3bed88338 virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
    @@ hw/virtio/trace-events: virtio_snd_realize(void *snd) "snd %p: realize"
      virtio_snd_handle_event(void) "event queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
    -@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
    -     return VIRTIO_SND_S_OK;
    - }
    +@@ hw/virtio/virtio-snd.c: static const char *print_code(uint32_t code)
    +     #undef CASE
    + };
      
     +/*
     + * Handles VIRTIO_SND_R_PCM_START.
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, u
     +{
     +    VirtIOSoundPCMStream *stream;
     +    virtio_snd_pcm_hdr req;
    -+    size_t sz = iov_to_buf(cmd->elem->out_sg,
    -+                           cmd->elem->out_num,
    -+                           0,
    -+                           &req,
    -+                           sizeof(req));
    -+    if (sz != sizeof(virtio_snd_pcm_hdr)) {
    -+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    ++    uint32_t stream_id;
    ++    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
    ++                               cmd->elem->out_num,
    ++                               0,
    ++                               &req,
    ++                               sizeof(req));
    ++
    ++    if (msg_sz != sizeof(virtio_snd_pcm_hdr)) {
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +        return;
     +    }
     +
    -+    cmd->resp.code = VIRTIO_SND_S_OK;
    ++    stream_id = le32_to_cpu(req.stream_id);
    ++    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     +    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
    -+            "VIRTIO_SND_R_PCM_STOP", req.stream_id);
    -+
    -+    stream = virtio_snd_pcm_get_stream(s, req.stream_id);
    ++            "VIRTIO_SND_R_PCM_STOP", stream_id);
    ++    stream = virtio_snd_pcm_get_stream(s, stream_id);
     +    if (!stream) {
     +        error_report("Invalid stream id: %"PRIu32, req.stream_id);
    -+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +    }
     +}
     +
    @@ hw/virtio/virtio-snd.c: process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd
     +    case VIRTIO_SND_R_PCM_SET_PARAMS:
     +    case VIRTIO_SND_R_PCM_PREPARE:
          case VIRTIO_SND_R_PCM_RELEASE:
    -         cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
    +         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
              break;
 7:  993e6af394 !  7:  3680da4770 virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
    @@ hw/virtio/trace-events: virtio_snd_vm_state_running(void) "vm state running"
     
      ## hw/virtio/virtio-snd.c ##
     @@ hw/virtio/virtio-snd.c: uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
    -     return VIRTIO_SND_S_OK;
    +     return cpu_to_le32(VIRTIO_SND_S_OK);
      }
      
     +/*
    @@ hw/virtio/virtio-snd.c: uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     +static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
     +                                             virtio_snd_ctrl_command *cmd)
     +{
    -+    virtio_snd_pcm_set_params req;
    -+    size_t sz = iov_to_buf(cmd->elem->out_sg,
    -+                           cmd->elem->out_num,
    -+                           0,
    -+                           &req,
    -+                           sizeof(req));
    -+    if (sz != sizeof(virtio_snd_pcm_set_params)) {
    -+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    ++    virtio_snd_pcm_set_params req = { 0 };
    ++    uint32_t stream_id;
    ++    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
    ++                               cmd->elem->out_num,
    ++                               0,
    ++                               &req,
    ++                               sizeof(req));
    ++
    ++    if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +        return;
     +    }
    -+
    -+    trace_virtio_snd_handle_pcm_set_params(req.hdr.stream_id);
    -+    cmd->resp.code = virtio_snd_set_pcm_params(s, &req);
    ++    stream_id = le32_to_cpu(req.hdr.stream_id);
    ++    trace_virtio_snd_handle_pcm_set_params(stream_id);
    ++    cmd->resp.code = virtio_snd_set_pcm_params(s, stream_id, &req);
     +}
     +
      /*
    @@ hw/virtio/virtio-snd.c: process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd
     +        break;
          case VIRTIO_SND_R_PCM_PREPARE:
          case VIRTIO_SND_R_PCM_RELEASE:
    -         cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
    +         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
 8:  36ce5f4d63 !  8:  6029975cf9 virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
    @@ Commit message
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/virtio/virtio-snd.c ##
    -@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
    -     return VIRTIO_SND_S_OK;
    - }
    +@@ hw/virtio/virtio-snd.c: static const char *print_code(uint32_t code)
    +     #undef CASE
    + };
      
     +/*
     + * Handles VIRTIO_SND_R_PCM_PREPARE.
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, u
     +                                          virtio_snd_ctrl_command *cmd)
     +{
     +    uint32_t stream_id;
    -+    size_t sz = iov_to_buf(cmd->elem->out_sg,
    -+                           cmd->elem->out_num,
    -+                           sizeof(virtio_snd_hdr),
    -+                           &stream_id,
    -+                           sizeof(stream_id));
    ++    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
    ++                               cmd->elem->out_num,
    ++                               sizeof(virtio_snd_hdr),
    ++                               &stream_id,
    ++                               sizeof(stream_id));
     +
    -+    cmd->resp.code = sz == sizeof(uint32_t)
    ++    stream_id = le32_to_cpu(stream_id);
    ++    cmd->resp.code = msg_sz == sizeof(uint32_t)
     +                   ? virtio_snd_pcm_prepare(s, stream_id)
    -+                   : VIRTIO_SND_S_BAD_MSG;
    ++                   : cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +}
     +
      /*
    @@ hw/virtio/virtio-snd.c: process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd
     +        virtio_snd_handle_pcm_prepare(s, cmd);
     +        break;
          case VIRTIO_SND_R_PCM_RELEASE:
    -         cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
    +         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
              break;
 9:  30ad4bc665 !  9:  25c904de1d virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +{
     +    uint32_t stream_id;
     +    VirtIOSoundPCMStream *stream;
    -+    size_t sz = iov_to_buf(cmd->elem->out_sg,
    -+                           cmd->elem->out_num,
    -+                           sizeof(virtio_snd_hdr),
    -+                           &stream_id,
    -+                           sizeof(stream_id));
    -+    if (sz != sizeof(uint32_t)) {
    -+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    ++    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
    ++                               cmd->elem->out_num,
    ++                               sizeof(virtio_snd_hdr),
    ++                               &stream_id,
    ++                               sizeof(stream_id));
    ++
    ++    if (msg_sz != sizeof(uint32_t)) {
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +        return;
     +    }
     +
    ++    stream_id = le32_to_cpu(stream_id);
     +    trace_virtio_snd_handle_pcm_release(stream_id);
    -+
     +    stream = virtio_snd_pcm_get_stream(s, stream_id);
     +    if (!stream) {
     +        error_report("already released stream %"PRIu32, stream_id);
     +        virtio_error(VIRTIO_DEVICE(s),
     +                     "already released stream %"PRIu32,
     +                     stream_id);
    -+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    ++        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +        return;
     +    }
    -+    cmd->resp.code = VIRTIO_SND_S_OK;
    ++    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     +}
     +
      /*
    @@ hw/virtio/virtio-snd.c: process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd
              virtio_snd_handle_pcm_prepare(s, cmd);
              break;
          case VIRTIO_SND_R_PCM_RELEASE:
    --        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
    +-        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     +        virtio_snd_handle_pcm_release(s, cmd);
              break;
          case VIRTIO_SND_R_CHMAP_INFO:
10:  c94a9c1e65 ! 10:  d17866a331 virtio-sound: implement audio output (TX)
    @@ hw/virtio/trace-events: virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_S
     +virtio_snd_handle_xfer(void) "tx/rx queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
    -@@
    - #define VIRTIO_SOUND_CHMAP_DEFAULT 0
    - #define VIRTIO_SOUND_HDA_FN_NID 0
    +@@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_pcm_info val) {
    +     return val;
    + }
      
     +static void virtio_snd_pcm_out_cb(void *data, int available);
     +static void virtio_snd_process_cmdq(VirtIOSound *s);
     +static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
    -+static uint32_t
    -+virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
    -+                          VirtQueue *vq,
    -+                          VirtQueueElement *element,
    -+                          bool read);
     +
      static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                        | BIT(VIRTIO_SND_PCM_FMT_U8)
                                        | BIT(VIRTIO_SND_PCM_FMT_S16)
    +@@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
    +     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
    + }
    + 
    ++static void
    ++virtio_snd_pcm_block_free(VirtIOSoundPCMBlock *block)
    ++{
    ++    g_free(block->elem);
    ++    g_free(block);
    ++}
    ++
    + static void
    + virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
    + {
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_get_qemu_audsettings(audsettings *as,
       */
      static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
      {
     +    VirtIOSoundPCMBlock *block, *next;
     +
    -     if (stream) {
    ++    if (stream) {
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     +            QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
     +                virtqueue_push(block->vq,
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_get_qemu_audsettings(audsettings
     +                virtio_notify(VIRTIO_DEVICE(stream->s),
     +                        block->vq);
     +                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                g_free(block);
    ++                virtio_snd_pcm_block_free(block);
     +            }
     +        }
    -+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    ++        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
     +            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
     +            stream->voice.out = NULL;
     +        }
    -         qemu_mutex_destroy(&stream->queue_mutex);
    -         g_free(stream);
    -     }
    ++    }
    + }
    + 
    + /*
     @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
    -     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
          stream->positions[1] = VIRTIO_SND_CHMAP_FR;
    +     stream->as = as;
      
    -+    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    ++    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
     +        stream->voice.out = AUD_open_out(&s->card,
     +                                         stream->voice.out,
     +                                         "virtio-sound.out",
     +                                         stream,
     +                                         virtio_snd_pcm_out_cb,
     +                                         &as);
    ++        AUD_set_volume_out(stream->voice.out, 0, 255, 255);
     +    } else {
     +        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
     +    }
     +
    -     stream->as = as;
    -     stream->desired_as = stream->as;
    -     qemu_mutex_init(&stream->queue_mutex);
    +     return cpu_to_le32(VIRTIO_SND_S_OK);
    + }
    + 
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                                   bool start)
      {
          VirtIOSoundPCMStream *stream;
     +    VirtIOSoundPCMBlock *block, *next;
          virtio_snd_pcm_hdr req;
    -     size_t sz = iov_to_buf(cmd->elem->out_sg,
    -                            cmd->elem->out_num,
    +     uint32_t stream_id;
    +     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
    -             "VIRTIO_SND_R_PCM_STOP", req.stream_id);
    - 
    -     stream = virtio_snd_pcm_get_stream(s, req.stream_id);
    +     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
    +     trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
    +             "VIRTIO_SND_R_PCM_STOP", stream_id);
    ++
    +     stream = virtio_snd_pcm_get_stream(s, stream_id);
     -    if (!stream) {
    +-        error_report("Invalid stream id: %"PRIu32, req.stream_id);
     +    if (stream) {
    -+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    ++        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
     +            AUD_set_active_out(stream->voice.out, start);
     +        }
     +        /* remove previous buffers. */
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +                               sizeof(block->elem));
     +                virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
     +                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                g_free(block);
    ++                virtio_snd_pcm_block_free(block);
     +            }
     +        }
     +    } else {
    -         error_report("Invalid stream id: %"PRIu32, req.stream_id);
    -         cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    ++        error_report("Invalid stream id: %"PRIu32, stream_id);
    +         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
          }
      }
      
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     + *
     + * @stream: VirtIOSoundPCMStream
     + */
    -+static size_t virtio_snd_pcm_get_pending_io_msgs(VirtIOSoundPCMStream *stream)
    ++static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
     +{
     +    VirtIOSoundPCMBlock *block;
     +    VirtIOSoundPCMBlock *next;
    -+    size_t size = 0;
    ++    size_t count = 0;
     +
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    -+            size += 1;
    ++            count += 1;
     +        }
     +    }
    -+    return size;
    ++    return count;
     +}
     +
     +/*
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
       * @s: VirtIOSound device
       * @cmd: The request command queue element from VirtIOSound cmdq field
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s,
    -         cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    +         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
              return;
          }
     +
    -+    if (virtio_snd_pcm_get_pending_io_msgs(stream)) {
    ++    if (virtio_snd_pcm_get_io_msgs_count(stream)) {
     +        /*
     +         * virtio-v1.2-csd01, 5.14.6.6.5.1,
     +         * Device Requirements: Stream Release
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s
     +        virtio_snd_pcm_flush(stream);
     +    }
     +
    -     cmd->resp.code = VIRTIO_SND_S_OK;
    +     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
      }
      
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
     +{
     +    VirtIOSound *s = VIRTIO_SND(vdev);
     +    VirtIOSoundPCMStream *stream = NULL;
    ++    VirtIOSoundPCMBlock *block;
     +    VirtQueueElement *elem;
    -+    size_t sz;
    ++    size_t msg_sz, size;
     +    virtio_snd_pcm_xfer hdr;
     +    virtio_snd_pcm_status resp = { 0 };
    ++    uint32_t stream_id;
     +
     +    trace_virtio_snd_handle_xfer();
     +
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
     +            break;
     +        }
     +        /* get the message hdr object */
    -+        sz = iov_to_buf(elem->out_sg,
    ++        msg_sz = iov_to_buf(elem->out_sg,
     +                        elem->out_num,
     +                        0,
     +                        &hdr,
     +                        sizeof(hdr));
    -+        if (sz != sizeof(hdr)
    -+            || hdr.stream_id >= s->snd_conf.streams
    -+            || !s->pcm->streams[hdr.stream_id]) {
    ++        if (msg_sz != sizeof(hdr)) {
    ++            goto tx_err;
    ++        }
    ++        stream_id = le32_to_cpu(hdr.stream_id);
    ++
    ++        if (stream_id >= s->snd_conf.streams
    ++            || !s->pcm->streams[stream_id]) {
     +            goto tx_err;
     +        }
     +
    -+        stream = s->pcm->streams[hdr.stream_id];
    -+        if (stream->direction != VIRTIO_SND_D_OUTPUT) {
    ++        stream = s->pcm->streams[stream_id];
    ++        if (!stream || stream->info.direction != VIRTIO_SND_D_OUTPUT) {
     +            goto tx_err;
     +        }
     +
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            virtio_snd_pcm_read_write(stream,
    -+                    vq,
    -+                    elem,
    -+                    hdr.stream_id == VIRTIO_SND_D_INPUT);
    ++            size = iov_size(elem->out_sg, elem->out_num) -
    ++                sizeof(virtio_snd_pcm_xfer);
    ++            block = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
    ++            block->elem = elem;
    ++            block->vq = vq;
    ++            block->size = size;
    ++            block->offset = 0;
     +
    -+            resp.status = VIRTIO_SND_S_OK;
    -+            iov_from_buf(elem->in_sg,
    -+                         elem->in_num,
    -+                         0,
    -+                         &resp,
    -+                         sizeof(resp));
    ++            iov_to_buf(elem->out_sg,
    ++                    elem->out_num,
    ++                    sizeof(virtio_snd_pcm_xfer),
    ++                    block->data,
    ++                    size);
    ++
    ++            QSIMPLEQ_INSERT_TAIL(&stream->queue, block, entry);
     +        }
     +        continue;
     +
     +tx_err:
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            resp.status = VIRTIO_SND_S_BAD_MSG;
    ++            resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +            iov_from_buf(elem->in_sg,
     +                         elem->in_num,
     +                         0,
     +                         &resp,
     +                         sizeof(resp));
    ++            virtqueue_push(vq, elem, sizeof(elem));
    ++            break;
     +        }
     +    }
     +
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +{
     +    VirtIOSoundPCMStream *stream = data;
     +    VirtIOSoundPCMBlock *block;
    -+    VirtIOSoundPCMBlock *next;
     +    size_t size;
     +
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    ++        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
    ++            block = QSIMPLEQ_FIRST(&stream->queue);
    ++
     +            for (;;) {
    -+                size = MIN(block->size, available);
     +                size = AUD_write(stream->voice.out,
    -+                        block->data + block->offset,
    -+                        size);
    ++                                 block->data + block->offset,
    ++                                 MIN(block->size, available));
    ++                assert(size <= MIN(block->size, available));
    ++                if (size == 0) {
    ++                    /* break out of both loops */
    ++                    available = 0;
    ++                    break;
    ++                }
     +                block->size -= size;
     +                block->offset += size;
    ++                available -= size;
     +                if (!block->size) {
    ++                    virtio_snd_pcm_status resp = { 0 };
    ++                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
    ++                    resp.latency_bytes = 0;
    ++                    iov_from_buf(block->elem->in_sg,
    ++                                 block->elem->in_num,
    ++                                 0,
    ++                                 &resp,
    ++                                 sizeof(resp));
     +                    virtqueue_push(block->vq,
    -+                            block->elem,
    -+                            sizeof(block->elem));
    -+                    virtio_notify(VIRTIO_DEVICE(stream->s),
    -+                            block->vq);
    ++                                   block->elem,
    ++                                   sizeof(block->elem));
    ++                    virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
     +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                    g_free(block);
    -+                    available -= size;
    ++                    virtio_snd_pcm_block_free(block);
     +                    break;
     +                }
     +
    -+                available -= size;
     +                if (!available) {
     +                    break;
     +                }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
      static void virtio_snd_unrealize(DeviceState *dev)
      {
          VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
    -             }
    -             g_free(vsnd->pcm->streams);
    -         }
    -+        g_free(vsnd->pcm->pcm_params);
    -         g_free(vsnd->pcm);
    -         vsnd->pcm = NULL;
    -     }
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
    - }
    - 
    - 
    -+static uint32_t
    -+virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
    -+                          VirtQueue *vq,
    -+                          VirtQueueElement *element,
    -+                          bool read)
    -+{
    -+    VirtIOSoundPCMBlock *fragment;
    -+    size_t size = iov_size(element->out_sg, element->out_num) -
    -+        sizeof(virtio_snd_pcm_xfer);
    -+
    -+    fragment = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
    -+    fragment->elem = element;
    -+    fragment->vq = vq;
    -+    fragment->size = size;
    -+    fragment->offset = 0;
    -+
    -+    iov_to_buf(element->out_sg, element->out_num,
    -+               sizeof(virtio_snd_pcm_xfer),
    -+               fragment->data,
    -+               size);
    -+
    -+    QSIMPLEQ_INSERT_TAIL(&stream->queue, fragment, entry);
    -+
    -+    return fragment->size;
    -+}
    -+
    - static void virtio_snd_reset(VirtIODevice *vdev)
    - {
    -     VirtIOSound *s = VIRTIO_SND(vdev);
     
      ## include/hw/virtio/virtio-snd.h ##
    -@@ include/hw/virtio/virtio-snd.h: typedef struct VirtIOSoundPCMParams VirtIOSoundPCMParams;
    +@@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
      
      typedef struct VirtIOSoundPCM VirtIOSoundPCM;
      
     +typedef struct VirtIOSoundPCMBlock VirtIOSoundPCMBlock;
     +
    - /* Stream params */
    - struct VirtIOSoundPCMParams {
    -     uint32_t features;
    -@@ include/hw/virtio/virtio-snd.h: struct VirtIOSoundPCMParams {
    -     uint8_t rate;
    - };
    - 
     +struct VirtIOSoundPCMBlock {
     +    QSIMPLEQ_ENTRY(VirtIOSoundPCMBlock) entry;
     +    VirtQueueElement *elem;
    @@ include/hw/virtio/virtio-snd.h: struct VirtIOSoundPCMParams {
     +
      struct VirtIOSoundPCM {
          VirtIOSound *snd;
    -     VirtIOSoundPCMParams *pcm_params;
    +     virtio_snd_pcm_set_params *pcm_params;
11:  9a85da0dde ! 11:  9dd07311d7 virtio-sound: implement audio capture (RX)
    @@ hw/virtio/virtio-snd.c
      #define VIRTIO_SOUND_CHMAP_DEFAULT 0
      #define VIRTIO_SOUND_HDA_FN_NID 0
      
    +@@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_pcm_info val) {
    + 
      static void virtio_snd_pcm_out_cb(void *data, int available);
      static void virtio_snd_process_cmdq(VirtIOSound *s);
     -static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
    --static uint32_t
    --virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
    --                          VirtQueue *vq,
    --                          VirtQueueElement *element,
    --                          bool read);
     +static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
     +static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
     +static void virtio_snd_pcm_in_cb(void *data, int available);
    -+static uint32_t virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
    -+                                     VirtQueue *vq,
    -+                                     VirtQueueElement *element);
    -+static uint32_t virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
    -+                                    VirtQueue *vq,
    -+                                    VirtQueueElement *element);
      
      static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                        | BIT(VIRTIO_SND_PCM_FMT_U8)
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    -         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    +         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
                  AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
                  stream->voice.out = NULL;
    -+        } else if (stream->direction == VIRTIO_SND_D_INPUT) {
    ++        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
     +            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
     +            stream->voice.in = NULL;
              }
    -         qemu_mutex_destroy(&stream->queue_mutex);
    -         g_free(stream);
    +     }
    + }
     @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
    -                                          virtio_snd_pcm_out_cb,
                                               &as);
    +         AUD_set_volume_out(stream->voice.out, 0, 255, 255);
          } else {
     -        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
     +        stream->voice.in = AUD_open_in(&s->card,
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, u
     +                                        &as);
          }
      
    -     stream->as = as;
    +     return cpu_to_le32(VIRTIO_SND_S_OK);
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
          if (stream) {
    -         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    +         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
                  AUD_set_active_out(stream->voice.out, start);
     +        } else {
     +            AUD_set_active_in(stream->voice.in, start);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s
              virtio_snd_process_cmdq(stream->s);
              trace_virtio_snd_pcm_stream_flush(stream_id);
     -        virtio_snd_pcm_flush(stream);
    -+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    ++        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
     +            virtio_snd_pcm_out_flush(stream);
     +        } else {
     +            virtio_snd_pcm_in_flush(stream);
     +        }
          }
      
    -     cmd->resp.code = VIRTIO_SND_S_OK;
    +     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
       * @vdev: VirtIOSound device
       * @vq: tx virtqueue
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
          VirtIOSound *s = VIRTIO_SND(vdev);
          VirtIOSoundPCMStream *stream = NULL;
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
    -     virtio_snd_pcm_xfer hdr;
          virtio_snd_pcm_status resp = { 0 };
    +     uint32_t stream_id;
      
     -    trace_virtio_snd_handle_xfer();
     +    trace_virtio_snd_handle_tx_xfer();
      
          for (;;) {
              elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
    -             goto tx_err;
    -         }
    - 
    -+        assert(hdr.stream_id != VIRTIO_SND_D_INPUT);
    -         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    --            virtio_snd_pcm_read_write(stream,
    -+            virtio_snd_pcm_write(stream,
    -                     vq,
    --                    elem,
    --                    hdr.stream_id == VIRTIO_SND_D_INPUT);
    -+                    elem);
    - 
    -             resp.status = VIRTIO_SND_S_OK;
    -             iov_from_buf(elem->in_sg,
     @@ hw/virtio/virtio-snd.c: tx_err:
      }
      
    @@ hw/virtio/virtio-snd.c: tx_err:
     +{
     +    VirtIOSound *s = VIRTIO_SND(vdev);
     +    VirtIOSoundPCMStream *stream = NULL;
    ++    VirtIOSoundPCMBlock *block;
     +    VirtQueueElement *elem;
    -+    size_t sz;
    ++    size_t msg_sz, size;
     +    virtio_snd_pcm_xfer hdr;
     +    virtio_snd_pcm_status resp = { 0 };
    ++    uint32_t stream_id;
     +
     +    trace_virtio_snd_handle_rx_xfer();
     +
    @@ hw/virtio/virtio-snd.c: tx_err:
     +            break;
     +        }
     +        /* get the message hdr object */
    -+        sz = iov_to_buf(elem->out_sg,
    -+                        elem->out_num,
    -+                        0,
    -+                        &hdr,
    -+                        sizeof(hdr));
    -+        if (sz != sizeof(hdr)
    -+            || hdr.stream_id >= s->snd_conf.streams
    -+            || !s->pcm->streams[hdr.stream_id]) {
    -+            continue;
    ++        msg_sz = iov_to_buf(elem->out_sg,
    ++                            elem->out_num,
    ++                            0,
    ++                            &hdr,
    ++                            sizeof(hdr));
    ++        if (msg_sz != sizeof(hdr)) {
    ++            goto rx_err;
     +        }
    ++        stream_id = le32_to_cpu(hdr.stream_id);
     +
    -+        stream = s->pcm->streams[hdr.stream_id];
    -+        if (stream->direction != VIRTIO_SND_D_INPUT) {
    ++        if (stream_id >= s->snd_conf.streams
    ++            || !s->pcm->streams[stream_id]) {
    ++            goto rx_err;
    ++        }
    ++
    ++        stream = s->pcm->streams[stream_id];
    ++        if (!stream || stream->info.direction != VIRTIO_SND_D_INPUT) {
     +            goto rx_err;
     +        }
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            virtio_snd_pcm_read(stream, vq, elem);
    ++            size = iov_size(elem->in_sg, elem->in_num) -
    ++                sizeof(virtio_snd_pcm_status);
    ++            block = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
    ++            block->elem = elem;
    ++            block->vq = vq;
    ++            block->size = 0;
    ++            block->offset = 0;
    ++            QSIMPLEQ_INSERT_TAIL(&stream->queue, block, entry);
     +        }
     +        continue;
     +
     +rx_err:
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            resp.status = VIRTIO_SND_S_BAD_MSG;
    ++            resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +            iov_from_buf(elem->in_sg,
     +                         elem->in_num,
     +                         0,
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +    VirtIOSoundPCMStream *stream = data;
          VirtIOSoundPCMBlock *block;
     -    VirtIOSoundPCMBlock *next;
    -+    uint32_t sz;
     +    virtio_snd_pcm_status resp = { 0 };
     +    size_t size;
      
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +
     +            for (;;) {
     +                size = AUD_read(stream->voice.in,
    -+                        block->data + block->offset,
    -+                        MIN(stream->period_bytes - block->offset, available));
    -+                block->offset += size;
    ++                        block->data + block->size,
    ++                        MIN(available, (stream->params.period_bytes - block->size)));
    ++                if (!size) {
    ++                    available = 0;
    ++                    break;
    ++                }
     +                block->size += size;
    -+                if (size == 0 || block->size >= stream->period_bytes) {
    -+                    resp.status = VIRTIO_SND_S_OK;
    -+                     sz = iov_from_buf(block->elem->in_sg,
    -+                                  block->elem->in_num,
    -+                                  0,
    -+                                  &resp,
    -+                                  sizeof(resp));
    -+
    ++                available -= size;
    ++                if (block->size >= stream->params.period_bytes) {
    ++                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
    ++                    resp.latency_bytes = 0;
     +                    /* Copy data -if any- to guest */
    -+                    if (block->size) {
    -+                        iov_from_buf(block->elem->in_sg,
    -+                                     block->elem->in_num,
    -+                                     sz,
    -+                                     block->data,
    -+                                     MIN(stream->period_bytes, block->size));
    -+                    }
    ++                    iov_from_buf(block->elem->in_sg,
    ++                                 block->elem->in_num,
    ++                                 0,
    ++                                 block->data,
    ++                                 stream->params.period_bytes);
    ++                    iov_from_buf(block->elem->in_sg,
    ++                                 block->elem->in_num,
    ++                                 block->size,
    ++                                 &resp,
    ++                                 sizeof(resp));
     +                    virtqueue_push(block->vq,
    -+                            block->elem,
    -+                            sizeof(block->elem));
    ++                                   block->elem,
    ++                                   sizeof(block->elem));
     +                    virtio_notify(VIRTIO_DEVICE(stream->s),
    -+                            block->vq);
    ++                                  block->vq);
     +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                    g_free(block);
    -+                    available -= size;
    ++                    virtio_snd_pcm_block_free(block);
     +                    break;
     +                }
    -+
    -+                available -= size;
     +                if (!available) {
     +                    break;
     +                }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +#define virtio_snd_pcm_flush(AUD_CB)                                    \
     +    VirtIOSoundPCMBlock *block;                                         \
     +    VirtIOSoundPCMBlock *next;                                          \
    ++    virtio_snd_pcm_status resp = { 0 };                                 \
    ++    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);                         \
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {                        \
     +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {     \
     +            do {                                                        \
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +                            block,                                      \
     +                            VirtIOSoundPCMBlock,                        \
     +                            entry);                                     \
    ++            virtio_snd_pcm_block_free(block);                           \
     +        }                                                               \
     +    }                                                                   \
     +
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     + */
     +static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream)
     +{
    ++    /* We should flush the buffers as soon as possible, because it is a
    ++     * time-sensitive operation.
    ++     *
    ++     * TODO: find out if copying leftover flushed data to an intermediate
    ++     * buffer is a good approach.
    ++     */
     +    virtio_snd_pcm_flush(
    -+            AUD_write(stream->voice.out,
    -+                      block->data + block->offset,
    -+                      block->size);
    ++            iov_from_buf(block->elem->in_sg,
    ++                         block->elem->in_num,
    ++                         0,
    ++                         &resp,
    ++                         sizeof(resp));
     +            );
     +}
     +
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +    virtio_snd_pcm_flush(
     +            iov_from_buf(block->elem->in_sg,
     +                         block->elem->in_num,
    -+                         sizeof(virtio_snd_pcm_info),
    ++                         0,
     +                         block->data,
    -+                         block->offset);
    ++                         block->size);
    ++            iov_from_buf(block->elem->in_sg,
    ++                         block->elem->in_num,
    ++                         block->size,
    ++                         &resp,
    ++                         sizeof(resp));
     +            );
     +}
     +
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
      {
          VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
    - 
    - 
    - static uint32_t
    --virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
    -+virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
    -                           VirtQueue *vq,
    --                          VirtQueueElement *element,
    --                          bool read)
    -+                          VirtQueueElement *element)
    - {
    -     VirtIOSoundPCMBlock *fragment;
    -     size_t size = iov_size(element->out_sg, element->out_num) -
    -@@ hw/virtio/virtio-snd.c: virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
    -     return fragment->size;
    +     virtio_cleanup(vdev);
      }
      
    -+static uint32_t
    -+virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
    -+                          VirtQueue *vq,
    -+                          VirtQueueElement *element)
    -+{
    -+    VirtIOSoundPCMBlock *fragment;
    -+
    -+    fragment = g_malloc0(sizeof(VirtIOSoundPCMBlock) + stream->period_bytes);
    -+    fragment->elem = element;
    -+    fragment->vq = vq;
    -+    fragment->size = 0;
    -+    fragment->offset = 0;
    -+
    -+    QSIMPLEQ_INSERT_TAIL(&stream->queue, fragment, entry);
    -+
    -+    return fragment->size;
    -+}
    -+
    +-
      static void virtio_snd_reset(VirtIODevice *vdev)
      {
          VirtIOSound *s = VIRTIO_SND(vdev);
12:  69eb5f4fba = 12:  0a1db7cf6e docs/system: add basic virtio-snd documentation

base-commit: 9ef497755afc252fb8e060c9ea6b0987abfd20b6
-- 
2.39.2


