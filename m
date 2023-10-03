Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 055AB7B6BD1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngV1-0006zR-Fh; Tue, 03 Oct 2023 10:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qngUy-0006zI-9c
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:35:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qngUv-0008Ir-LN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:35:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3248aa5cf4eso1061319f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696343739; x=1696948539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtfGGHmNOVM3+yqxf6YhhvxViRd/PwT7bRvU2YLTWw0=;
 b=I1IlH2sZDkDPdAJqy84Xzfunr/8keDevcDwxE2nyvxWPMKZvWiipgiqYzAgGorVNl/
 qaEwBgsw+Hts+mLFNGR3Y3MW3KVwH1Czrtlndko13dkDJmI1yPao2IJU6tvW380zuEoX
 R/qPNtfawQB74t8fuw1W5wIovXtJryUFVMd2RMKTeEcWLgxhOxbHSiO2oJ8Wdm+Te9Cb
 LhbjU5NRQWlzDoX6S9rj0E/3QiPo4R1qFmtpLZykJIfCRxFCxWAk6rimbegYSJGZIbLc
 eGqtHzRx61A4nL9azW4dqsdQV6JgIjCwoe9vaP4Ee3G9NXRkP+5jxLjeukpCcun5Ew1T
 sbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696343739; x=1696948539;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jtfGGHmNOVM3+yqxf6YhhvxViRd/PwT7bRvU2YLTWw0=;
 b=Jo1oaMS4OHDhIoduAUNGXaOyhczLTLeh3w2S8bw+nh2PycqJueTX18BoPglym7EFnX
 12azKfLTlTb4UFtm3bx/iyv+/dKlVu+OKAXsWieNAGVodiTEhdKKol2jTDwt3UC91/md
 yTp5y01m8LYNLJskL9Lhexi+ttuokpmPDu9srgHCbetHTq3Xq43C1+flk1OXjO7mdrpd
 aeUqODIdAlbkm4r9l3YvNGELUoCoZLW2XKdZXjvwqFoNeu4AfLCtG3hi6TFmn3awTYaQ
 ahMh6TXXtjDrgPyfSM+jrvGpHXwZTsVUcGUsovZhum+zDircdw+Hj3MJEI2fh6emyago
 94Zg==
X-Gm-Message-State: AOJu0YxuO961vXKADVHS0CoOt3rp7L4E5JWGCSFmwfGK52A9015TBydK
 UOuF16DnQBm/nULEtgfsHXHGkQ==
X-Google-Smtp-Source: AGHT+IFY5CaVAd9bVIyahcLYR5C2BsIoxUjh2sF6CYO7Bzzv+SiGyPEE6alE3iEXPWJzxPo4s+QL+g==
X-Received: by 2002:adf:ea8f:0:b0:320:4cf:5b50 with SMTP id
 s15-20020adfea8f000000b0032004cf5b50mr14523501wrm.5.1696343739239; 
 Tue, 03 Oct 2023 07:35:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y9-20020adfd089000000b0031aef72a021sm1718392wrh.86.2023.10.03.07.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 07:35:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E173B1FFBB;
 Tue,  3 Oct 2023 15:35:37 +0100 (BST)
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
 <6e7bdf6dda10d11fd21aefff25d52fa35d054b6c.1695996196.git.manos.pitsidianakis@linaro.org>
 <20231003101214-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>, Igor Skalkin
 <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v10 01/11] Add virtio-sound device stub
Date: Tue, 03 Oct 2023 15:34:44 +0100
In-reply-to: <20231003101214-mutt-send-email-mst@kernel.org>
Message-ID: <87ttr7hiyu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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


"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Sep 29, 2023 at 05:08:21PM +0300, Emmanouil Pitsidianakis wrote:
>> Add a new VIRTIO device for the virtio sound device id. Functionality
>> will be added in the following commits.
>>=20
>> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d=
9c7b40a8e603f4da92471
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
>> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
>> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>  MAINTAINERS                    |   6 +
>>  hw/virtio/Kconfig              |   5 +
>>  hw/virtio/meson.build          |   1 +
>>  hw/virtio/trace-events         |   9 ++
>>  hw/virtio/virtio-snd.c         | 223 +++++++++++++++++++++++++++++++++
>
>
> Why isn't this under hw/virtio and not under hw/audio?

Most of our virtio devices are under hw/virtio although we have a random
selection of other virtio devices elsewhere in the tree.

>
>
>>  include/hw/virtio/virtio-snd.h |  79 ++++++++++++
>>  6 files changed, 323 insertions(+)
>>  create mode 100644 hw/virtio/virtio-snd.c
>>  create mode 100644 include/hw/virtio/virtio-snd.h
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 355b1960ce..81ca61e90b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2241,6 +2241,12 @@ F: hw/virtio/virtio-mem-pci.h
>>  F: hw/virtio/virtio-mem-pci.c
>>  F: include/hw/virtio/virtio-mem.h
>>=20=20
>> +virtio-snd
>> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> +S: Supported
>> +F: hw/virtio/virtio-snd*.c
>> +F: include/hw/virtio/virtio-snd.h
>> +
>>  nvme
>>  M: Keith Busch <kbusch@kernel.org>
>>  M: Klaus Jensen <its@irrelevant.dk>
>> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
>> index 92c9cf6c96..d6f20657b3 100644
>> --- a/hw/virtio/Kconfig
>> +++ b/hw/virtio/Kconfig
>> @@ -17,6 +17,11 @@ config VIRTIO_PCI
>>      depends on PCI
>>      select VIRTIO
>>=20=20
>> +config VIRTIO_SND
>> +    bool
>> +    default y
>> +    depends on VIRTIO
>> +
>>  config VIRTIO_MMIO
>>      bool
>>      select VIRTIO
>> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>> index 13e7c6c272..120d4bfa0a 100644
>> --- a/hw/virtio/meson.build
>> +++ b/hw/virtio/meson.build
>> @@ -31,6 +31,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_=
true: files('vhost-vsock.c
>>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files(=
'vhost-user-vsock.c'))
>>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virti=
o-rng.c'))
>>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virti=
o-mem.c'))
>> +specific_virtio_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virti=
o-snd.c'))
>>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('v=
host-user-i2c.c'))
>>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('v=
host-user-rng.c'))
>>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('=
vhost-user-gpio.c'))
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index 7109cf1a3b..3ed7da35f2 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -154,3 +154,12 @@ virtio_pmem_flush_done(int type) "fsync return=3D%d"
>>  virtio_gpio_start(void) "start"
>>  virtio_gpio_stop(void) "stop"
>>  virtio_gpio_set_status(uint8_t status) "0x%x"
>> +
>> +#virtio-snd.c
>> +virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uin=
t32_t chmaps) "snd %p: get_config jacks=3D%"PRIu32" streams=3D%"PRIu32" chm=
aps=3D%"PRIu32""
>> +virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, u=
int32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps=
) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PRIu3=
2"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
>> +virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_fea=
tures 0x%"PRIx64
>> +virtio_snd_vm_state_running(void) "vm state running"
>> +virtio_snd_vm_state_stopped(void) "vm state stopped"
>> +virtio_snd_realize(void *snd) "snd %p: realize"
>> +virtio_snd_unrealize(void *snd) "snd %p: unrealize"
>> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
>> new file mode 100644
>> index 0000000000..a8204e8a02
>> --- /dev/null
>> +++ b/hw/virtio/virtio-snd.c
>> @@ -0,0 +1,223 @@
>> +/*
>> + * VIRTIO Sound Device conforming to
>> + *
>> + * "Virtual I/O Device (VIRTIO) Version 1.2
>> + * Committee Specification Draft 01
>> + * 09 May 2022"
>> + *
>> + * <https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-cs=
d01.html#x1-52900014>
>> + *
>> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@lina=
ro.org>
>> + * Copyright (C) 2019 OpenSynergy GmbH
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * (at your option) any later version.  See the COPYING file in the
>> + * top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/iov.h"
>> +#include "qemu/log.h"
>> +#include "qemu/error-report.h"
>> +#include "include/qemu/lockable.h"
>> +#include "sysemu/runstate.h"
>> +#include "trace.h"
>> +#include "qapi/error.h"
>> +#include "hw/virtio/virtio-snd.h"
>> +#include "hw/core/cpu.h"
>> +
>> +#define VIRTIO_SOUND_VM_VERSION 1
>> +#define VIRTIO_SOUND_JACK_DEFAULT 0
>> +#define VIRTIO_SOUND_STREAM_DEFAULT 1
>> +#define VIRTIO_SOUND_CHMAP_DEFAULT 0
>> +#define VIRTIO_SOUND_HDA_FN_NID 0
>> +
>> +static const VMStateDescription vmstate_virtio_snd_device =3D {
>> +    .name =3D TYPE_VIRTIO_SND,
>> +    .version_id =3D VIRTIO_SOUND_VM_VERSION,
>> +    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
>> +};
>> +
>> +static const VMStateDescription vmstate_virtio_snd =3D {
>> +    .name =3D "virtio-sound",
>> +    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
>> +    .version_id =3D VIRTIO_SOUND_VM_VERSION,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_VIRTIO_DEVICE,
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +static Property virtio_snd_properties[] =3D {
>> +    DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
>> +    DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
>> +                       VIRTIO_SOUND_JACK_DEFAULT),
>> +    DEFINE_PROP_UINT32("streams", VirtIOSound, snd_conf.streams,
>> +                       VIRTIO_SOUND_STREAM_DEFAULT),
>> +    DEFINE_PROP_UINT32("chmaps", VirtIOSound, snd_conf.chmaps,
>> +                       VIRTIO_SOUND_CHMAP_DEFAULT),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void
>> +virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
>> +{
>> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
>> +    trace_virtio_snd_get_config(vdev,
>> +                                s->snd_conf.jacks,
>> +                                s->snd_conf.streams,
>> +                                s->snd_conf.chmaps);
>> +
>> +    memcpy(config, &s->snd_conf, sizeof(s->snd_conf));
>> +}
>> +
>> +static void
>> +virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
>> +{
>> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
>> +    const virtio_snd_config *sndconfig =3D
>> +        (const virtio_snd_config *)config;
>> +
>> +
>> +   trace_virtio_snd_set_config(vdev,
>> +                               s->snd_conf.jacks,
>> +                               sndconfig->jacks,
>> +                               s->snd_conf.streams,
>> +                               sndconfig->streams,
>> +                               s->snd_conf.chmaps,
>> +                               sndconfig->chmaps);
>> +
>> +    memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
>> +}
>> +
>> +/*
>> + * Queue handler stub.
>> + *
>> + * @vdev: VirtIOSound device
>> + * @vq: virtqueue
>> + */
>> +static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *vq) =
{}
>> +
>> +static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
>> +                             Error **errp)
>> +{
>> +    /*
>> +     * virtio-v1.2-csd01, 5.14.3,
>> +     * Feature Bits
>> +     * None currently defined.
>> +     */
>> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
>> +    features |=3D s->features;
>> +
>> +    trace_virtio_snd_get_features(vdev, features);
>> +
>> +    return features;
>> +}
>> +
>> +static void
>> +virtio_snd_vm_state_change(void *opaque, bool running,
>> +                                       RunState state)
>> +{
>> +    if (running) {
>> +        trace_virtio_snd_vm_state_running();
>> +    } else {
>> +        trace_virtio_snd_vm_state_stopped();
>> +    }
>> +}
>> +
>> +static void virtio_snd_realize(DeviceState *dev, Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> +
>> +    vsnd->vmstate =3D
>> +        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vs=
nd);
>> +
>> +    trace_virtio_snd_realize(vsnd);
>> +
>> +    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
>> +    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
>> +
>> +    /* set number of jacks and streams */
>> +    if (vsnd->snd_conf.jacks > 8) {
>> +        error_setg(errp,
>> +                   "Invalid number of jacks: %"PRIu32,
>> +                   vsnd->snd_conf.jacks);
>> +        return;
>> +    }
>> +    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
>> +        error_setg(errp,
>> +                   "Invalid number of streams: %"PRIu32,
>> +                    vsnd->snd_conf.streams);
>> +        return;
>> +    }
>> +
>> +    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
>> +        error_setg(errp,
>> +                   "Invalid number of channel maps: %"PRIu32,
>> +                   vsnd->snd_conf.chmaps);
>> +        return;
>> +    }
>> +
>> +    AUD_register_card("virtio-sound", &vsnd->card);
>> +
>> +    vsnd->queues[VIRTIO_SND_VQ_CONTROL] =3D
>> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
>> +    vsnd->queues[VIRTIO_SND_VQ_EVENT] =3D
>> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
>> +    vsnd->queues[VIRTIO_SND_VQ_TX] =3D
>> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
>> +    vsnd->queues[VIRTIO_SND_VQ_RX] =3D
>> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
>> +}
>> +
>> +static void virtio_snd_unrealize(DeviceState *dev)
>> +{
>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
>> +
>> +    qemu_del_vm_change_state_handler(vsnd->vmstate);
>> +    trace_virtio_snd_unrealize(vsnd);
>> +
>> +    AUD_remove_card(&vsnd->card);
>> +    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
>> +    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
>> +    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
>> +    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_RX]);
>> +    virtio_cleanup(vdev);
>> +}
>> +
>> +
>> +static void virtio_snd_reset(VirtIODevice *vdev) {}
>> +
>> +static void virtio_snd_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
>> +
>> +
>> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>> +    device_class_set_props(dc, virtio_snd_properties);
>> +
>> +    dc->vmsd =3D &vmstate_virtio_snd;
>> +    vdc->vmsd =3D &vmstate_virtio_snd_device;
>> +    vdc->realize =3D virtio_snd_realize;
>> +    vdc->unrealize =3D virtio_snd_unrealize;
>> +    vdc->get_config =3D virtio_snd_get_config;
>> +    vdc->set_config =3D virtio_snd_set_config;
>> +    vdc->get_features =3D get_features;
>> +    vdc->reset =3D virtio_snd_reset;
>> +    vdc->legacy_features =3D 0;
>> +}
>> +
>> +static const TypeInfo virtio_snd_types[] =3D {
>> +    {
>> +      .name          =3D TYPE_VIRTIO_SND,
>> +      .parent        =3D TYPE_VIRTIO_DEVICE,
>> +      .instance_size =3D sizeof(VirtIOSound),
>> +      .class_init    =3D virtio_snd_class_init,
>> +    }
>> +};
>> +
>> +DEFINE_TYPES(virtio_snd_types)
>> diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-s=
nd.h
>> new file mode 100644
>> index 0000000000..934e854a80
>> --- /dev/null
>> +++ b/include/hw/virtio/virtio-snd.h
>> @@ -0,0 +1,79 @@
>> +/*
>> + * VIRTIO Sound Device conforming to
>> + *
>> + * "Virtual I/O Device (VIRTIO) Version 1.2
>> + * Committee Specification Draft 01
>> + * 09 May 2022"
>> + *
>> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@lina=
ro.org>
>> + * Copyright (C) 2019 OpenSynergy GmbH
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * (at your option) any later version.  See the COPYING file in the
>> + * top-level directory.
>> + */
>> +
>> +#ifndef QEMU_VIRTIO_SOUND_H
>> +#define QEMU_VIRTIO_SOUND_H
>> +
>> +#include "hw/virtio/virtio.h"
>> +#include "audio/audio.h"
>> +#include "standard-headers/linux/virtio_ids.h"
>> +#include "standard-headers/linux/virtio_snd.h"
>> +
>> +#define TYPE_VIRTIO_SND "virtio-sound"
>> +#define VIRTIO_SND(obj) \
>> +        OBJECT_CHECK(VirtIOSound, (obj), TYPE_VIRTIO_SND)
>> +
>> +/* CONFIGURATION SPACE */
>> +
>> +typedef struct virtio_snd_config virtio_snd_config;
>> +
>> +/* COMMON DEFINITIONS */
>> +
>> +/* common header for request/response*/
>> +typedef struct virtio_snd_hdr virtio_snd_hdr;
>> +
>> +/* event notification */
>> +typedef struct virtio_snd_event virtio_snd_event;
>> +
>> +/* common control request to query an item information */
>> +typedef struct virtio_snd_query_info virtio_snd_query_info;
>> +
>> +/* JACK CONTROL MESSAGES */
>> +
>> +typedef struct virtio_snd_jack_hdr virtio_snd_jack_hdr;
>> +
>> +/* jack information structure */
>> +typedef struct virtio_snd_jack_info virtio_snd_jack_info;
>> +
>> +/* jack remapping control request */
>> +typedef struct virtio_snd_jack_remap virtio_snd_jack_remap;
>> +
>> +/*
>> + * PCM CONTROL MESSAGES
>> + */
>> +typedef struct virtio_snd_pcm_hdr virtio_snd_pcm_hdr;
>> +
>> +/* PCM stream info structure */
>> +typedef struct virtio_snd_pcm_info virtio_snd_pcm_info;
>> +
>> +/* set PCM stream params */
>> +typedef struct virtio_snd_pcm_set_params virtio_snd_pcm_set_params;
>> +
>> +/* I/O request header */
>> +typedef struct virtio_snd_pcm_xfer virtio_snd_pcm_xfer;
>> +
>> +/* I/O request status */
>> +typedef struct virtio_snd_pcm_status virtio_snd_pcm_status;
>> +
>> +typedef struct VirtIOSound {
>> +    VirtIODevice parent_obj;
>> +
>> +    VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>> +    uint64_t features;
>> +    QEMUSoundCard card;
>> +    VMChangeStateEntry *vmstate;
>> +    virtio_snd_config snd_conf;
>> +} VirtIOSound;
>> +#endif
>> --=20
>> 2.39.2


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

