Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE42C7B6D0E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhJd-0000Kc-6l; Tue, 03 Oct 2023 11:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qnhJS-0000KF-L3
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:27:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qnhJP-0000zM-N1
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:27:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so9939375e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696346862; x=1696951662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehTSX5OxsLAU9MlUczIrg++mVZ1acPTRXi4ETi5A8Rs=;
 b=L+XOnmLlVs292SyomFB+NSX24BIFaQ5wg+f+3UOs6m543V+pKv7z8OMldHvnswLS53
 ljcvdU21EsNBUflOAqBhiA79fT2kPFhGEswChMY2J7TEEESSZNg/q/qME3Mj0p8tV+gL
 m5rclIN+hbN3/nnMKAiMiOTuBYYkS5gQi4V4tOLHJnA4YQw5lY0OIX90A8+etCSBsGl2
 mth3HaZl1+M75s63xilGLkrP0IgFyODd+WyzZmlacCmTTcIrp3LsHOWz+WscXIBafsnZ
 4ZeNckxyVY+xKUTGzY8D9c8sk6hGFptydWJcKDbf/wwIv3VnXwCvx8WG4bPK5sp1gO1e
 dwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696346862; x=1696951662;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ehTSX5OxsLAU9MlUczIrg++mVZ1acPTRXi4ETi5A8Rs=;
 b=P59rN74LLGyH5Kr2qHh2iNzFszMH5HRqr8qD3lpIBAQtGC+rFUfyfy2U3J+T2Jyy2X
 JQ/V1o9iELbnwTHpsbeus7JFTao3E3TUTqtI9CN8hx1hPvHGCtqNvghCdqZPakZfzWyw
 vtLP6z1wodFreyJQJR5IWRjqGf0axzU1eCXammoSxVAdZmcSpck2UOtsWeju/mq4eThq
 gGHAp1qL0XbP9Mpysm33OfOf1rH1O+YIjK9oweeMH851IW2XmAucDXTJ/8kIOTnSaUXI
 bLzAfEzbl99a3K327wMWUoKzV0qPBWIEJqPblajmubKg8kKaWo3OFjOWcffJiuVFbMSs
 XjQg==
X-Gm-Message-State: AOJu0Ywvoo642Wb19dSReeausz+/9Lz/SvrRuApvHI6W8pKefuLywAbu
 rMZm5RBXYDFmE9WSQk2pb6YFUSADYz3sOp4NUsA=
X-Google-Smtp-Source: AGHT+IGFGpp8fNj4TVaMoWAm3+EOhlgsZgTNvjmBuGj6mUA70OgwltBCrYt1ocjsqslCaHy+y9y8XQ==
X-Received: by 2002:a05:600c:b5a:b0:406:3c2b:8639 with SMTP id
 k26-20020a05600c0b5a00b004063c2b8639mr11897400wmr.30.1696346861533; 
 Tue, 03 Oct 2023 08:27:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a7bce98000000b00403b63e87f2sm1522000wmj.32.2023.10.03.08.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 08:27:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 949471FFBB;
 Tue,  3 Oct 2023 16:27:40 +0100 (BST)
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
 <6e7bdf6dda10d11fd21aefff25d52fa35d054b6c.1695996196.git.manos.pitsidianakis@linaro.org>
 <20231003101214-mutt-send-email-mst@kernel.org>
 <87ttr7hiyu.fsf@linaro.org>
 <20231003104217-mutt-send-email-mst@kernel.org>
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
Date: Tue, 03 Oct 2023 16:26:45 +0100
In-reply-to: <20231003104217-mutt-send-email-mst@kernel.org>
Message-ID: <87pm1vhgk3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

> On Tue, Oct 03, 2023 at 03:34:44PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>=20
>> > On Fri, Sep 29, 2023 at 05:08:21PM +0300, Emmanouil Pitsidianakis wrot=
e:
>> >> Add a new VIRTIO device for the virtio sound device id. Functionality
>> >> will be added in the following commits.
>> >>=20
>> >> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b=
90d9c7b40a8e603f4da92471
>> >> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
>> >> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
>> >> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.or=
g>
>> >> ---
>> >>  MAINTAINERS                    |   6 +
>> >>  hw/virtio/Kconfig              |   5 +
>> >>  hw/virtio/meson.build          |   1 +
>> >>  hw/virtio/trace-events         |   9 ++
>> >>  hw/virtio/virtio-snd.c         | 223 +++++++++++++++++++++++++++++++=
++
>> >
>> >
>> > Why isn't this under hw/virtio and not under hw/audio?
>>=20
>> Most of our virtio devices are under hw/virtio although we have a random
>> selection of other virtio devices elsewhere in the tree.
>
>
> That's because there wasn't anywhere to put them.
> Not the case for audio.
> Although, I just missed the cases of gpio and i2c -
> I think we should move them.
>
> virtio maintainers can't be a experts on all areas.
> We need to locate virtio devices appropriately so they
> get attention from appropriate maintainers.

Arguably for the vhost-user devices most of the code is VirtIO specific
because the internals are handled outside of QEMU. Of course this case
is different although there is a vhost-user-sound coming as well in my
next series.

>
>
>> >
>> >
>> >>  include/hw/virtio/virtio-snd.h |  79 ++++++++++++
>> >>  6 files changed, 323 insertions(+)
>> >>  create mode 100644 hw/virtio/virtio-snd.c
>> >>  create mode 100644 include/hw/virtio/virtio-snd.h
>> >>=20
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index 355b1960ce..81ca61e90b 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -2241,6 +2241,12 @@ F: hw/virtio/virtio-mem-pci.h
>> >>  F: hw/virtio/virtio-mem-pci.c
>> >>  F: include/hw/virtio/virtio-mem.h
>> >>=20=20
>> >> +virtio-snd
>> >> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> >> +S: Supported
>> >> +F: hw/virtio/virtio-snd*.c
>> >> +F: include/hw/virtio/virtio-snd.h
>> >> +
>> >>  nvme
>> >>  M: Keith Busch <kbusch@kernel.org>
>> >>  M: Klaus Jensen <its@irrelevant.dk>
>> >> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
>> >> index 92c9cf6c96..d6f20657b3 100644
>> >> --- a/hw/virtio/Kconfig
>> >> +++ b/hw/virtio/Kconfig
>> >> @@ -17,6 +17,11 @@ config VIRTIO_PCI
>> >>      depends on PCI
>> >>      select VIRTIO
>> >>=20=20
>> >> +config VIRTIO_SND
>> >> +    bool
>> >> +    default y
>> >> +    depends on VIRTIO
>> >> +
>> >>  config VIRTIO_MMIO
>> >>      bool
>> >>      select VIRTIO
>> >> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>> >> index 13e7c6c272..120d4bfa0a 100644
>> >> --- a/hw/virtio/meson.build
>> >> +++ b/hw/virtio/meson.build
>> >> @@ -31,6 +31,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', =
if_true: files('vhost-vsock.c
>> >>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: fil=
es('vhost-user-vsock.c'))
>> >>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('vi=
rtio-rng.c'))
>> >>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('vi=
rtio-mem.c'))
>> >> +specific_virtio_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('vi=
rtio-snd.c'))
>> >>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files=
('vhost-user-i2c.c'))
>> >>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files=
('vhost-user-rng.c'))
>> >>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: file=
s('vhost-user-gpio.c'))
>> >> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> >> index 7109cf1a3b..3ed7da35f2 100644
>> >> --- a/hw/virtio/trace-events
>> >> +++ b/hw/virtio/trace-events
>> >> @@ -154,3 +154,12 @@ virtio_pmem_flush_done(int type) "fsync return=
=3D%d"
>> >>  virtio_gpio_start(void) "start"
>> >>  virtio_gpio_stop(void) "stop"
>> >>  virtio_gpio_set_status(uint8_t status) "0x%x"
>> >> +
>> >> +#virtio-snd.c
>> >> +virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, =
uint32_t chmaps) "snd %p: get_config jacks=3D%"PRIu32" streams=3D%"PRIu32" =
chmaps=3D%"PRIu32""
>> >> +virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks=
, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chm=
aps) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PR=
Iu32"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
>> >> +virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_=
features 0x%"PRIx64
>> >> +virtio_snd_vm_state_running(void) "vm state running"
>> >> +virtio_snd_vm_state_stopped(void) "vm state stopped"
>> >> +virtio_snd_realize(void *snd) "snd %p: realize"
>> >> +virtio_snd_unrealize(void *snd) "snd %p: unrealize"
>> >> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
>> >> new file mode 100644
>> >> index 0000000000..a8204e8a02
>> >> --- /dev/null
>> >> +++ b/hw/virtio/virtio-snd.c
>> >> @@ -0,0 +1,223 @@
>> >> +/*
>> >> + * VIRTIO Sound Device conforming to
>> >> + *
>> >> + * "Virtual I/O Device (VIRTIO) Version 1.2
>> >> + * Committee Specification Draft 01
>> >> + * 09 May 2022"
>> >> + *
>> >> + * <https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2=
-csd01.html#x1-52900014>
>> >> + *
>> >> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@l=
inaro.org>
>> >> + * Copyright (C) 2019 OpenSynergy GmbH
>> >> + *
>> >> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> >> + * (at your option) any later version.  See the COPYING file in the
>> >> + * top-level directory.
>> >> + */
>> >> +
>> >> +#include "qemu/osdep.h"
>> >> +#include "qemu/iov.h"
>> >> +#include "qemu/log.h"
>> >> +#include "qemu/error-report.h"
>> >> +#include "include/qemu/lockable.h"
>> >> +#include "sysemu/runstate.h"
>> >> +#include "trace.h"
>> >> +#include "qapi/error.h"
>> >> +#include "hw/virtio/virtio-snd.h"
>> >> +#include "hw/core/cpu.h"
>> >> +
>> >> +#define VIRTIO_SOUND_VM_VERSION 1
>> >> +#define VIRTIO_SOUND_JACK_DEFAULT 0
>> >> +#define VIRTIO_SOUND_STREAM_DEFAULT 1
>> >> +#define VIRTIO_SOUND_CHMAP_DEFAULT 0
>> >> +#define VIRTIO_SOUND_HDA_FN_NID 0
>> >> +
>> >> +static const VMStateDescription vmstate_virtio_snd_device =3D {
>> >> +    .name =3D TYPE_VIRTIO_SND,
>> >> +    .version_id =3D VIRTIO_SOUND_VM_VERSION,
>> >> +    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
>> >> +};
>> >> +
>> >> +static const VMStateDescription vmstate_virtio_snd =3D {
>> >> +    .name =3D "virtio-sound",
>> >> +    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
>> >> +    .version_id =3D VIRTIO_SOUND_VM_VERSION,
>> >> +    .fields =3D (VMStateField[]) {
>> >> +        VMSTATE_VIRTIO_DEVICE,
>> >> +        VMSTATE_END_OF_LIST()
>> >> +    },
>> >> +};
>> >> +
>> >> +static Property virtio_snd_properties[] =3D {
>> >> +    DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
>> >> +    DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
>> >> +                       VIRTIO_SOUND_JACK_DEFAULT),
>> >> +    DEFINE_PROP_UINT32("streams", VirtIOSound, snd_conf.streams,
>> >> +                       VIRTIO_SOUND_STREAM_DEFAULT),
>> >> +    DEFINE_PROP_UINT32("chmaps", VirtIOSound, snd_conf.chmaps,
>> >> +                       VIRTIO_SOUND_CHMAP_DEFAULT),
>> >> +    DEFINE_PROP_END_OF_LIST(),
>> >> +};
>> >> +
>> >> +static void
>> >> +virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
>> >> +{
>> >> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
>> >> +    trace_virtio_snd_get_config(vdev,
>> >> +                                s->snd_conf.jacks,
>> >> +                                s->snd_conf.streams,
>> >> +                                s->snd_conf.chmaps);
>> >> +
>> >> +    memcpy(config, &s->snd_conf, sizeof(s->snd_conf));
>> >> +}
>> >> +
>> >> +static void
>> >> +virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
>> >> +{
>> >> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
>> >> +    const virtio_snd_config *sndconfig =3D
>> >> +        (const virtio_snd_config *)config;
>> >> +
>> >> +
>> >> +   trace_virtio_snd_set_config(vdev,
>> >> +                               s->snd_conf.jacks,
>> >> +                               sndconfig->jacks,
>> >> +                               s->snd_conf.streams,
>> >> +                               sndconfig->streams,
>> >> +                               s->snd_conf.chmaps,
>> >> +                               sndconfig->chmaps);
>> >> +
>> >> +    memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
>> >> +}
>> >> +
>> >> +/*
>> >> + * Queue handler stub.
>> >> + *
>> >> + * @vdev: VirtIOSound device
>> >> + * @vq: virtqueue
>> >> + */
>> >> +static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *v=
q) {}
>> >> +
>> >> +static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
>> >> +                             Error **errp)
>> >> +{
>> >> +    /*
>> >> +     * virtio-v1.2-csd01, 5.14.3,
>> >> +     * Feature Bits
>> >> +     * None currently defined.
>> >> +     */
>> >> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
>> >> +    features |=3D s->features;
>> >> +
>> >> +    trace_virtio_snd_get_features(vdev, features);
>> >> +
>> >> +    return features;
>> >> +}
>> >> +
>> >> +static void
>> >> +virtio_snd_vm_state_change(void *opaque, bool running,
>> >> +                                       RunState state)
>> >> +{
>> >> +    if (running) {
>> >> +        trace_virtio_snd_vm_state_running();
>> >> +    } else {
>> >> +        trace_virtio_snd_vm_state_stopped();
>> >> +    }
>> >> +}
>> >> +
>> >> +static void virtio_snd_realize(DeviceState *dev, Error **errp)
>> >> +{
>> >> +    ERRP_GUARD();
>> >> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
>> >> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> >> +
>> >> +    vsnd->vmstate =3D
>> >> +        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change,=
 vsnd);
>> >> +
>> >> +    trace_virtio_snd_realize(vsnd);
>> >> +
>> >> +    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
>> >> +    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
>> >> +
>> >> +    /* set number of jacks and streams */
>> >> +    if (vsnd->snd_conf.jacks > 8) {
>> >> +        error_setg(errp,
>> >> +                   "Invalid number of jacks: %"PRIu32,
>> >> +                   vsnd->snd_conf.jacks);
>> >> +        return;
>> >> +    }
>> >> +    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
>> >> +        error_setg(errp,
>> >> +                   "Invalid number of streams: %"PRIu32,
>> >> +                    vsnd->snd_conf.streams);
>> >> +        return;
>> >> +    }
>> >> +
>> >> +    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
>> >> +        error_setg(errp,
>> >> +                   "Invalid number of channel maps: %"PRIu32,
>> >> +                   vsnd->snd_conf.chmaps);
>> >> +        return;
>> >> +    }
>> >> +
>> >> +    AUD_register_card("virtio-sound", &vsnd->card);
>> >> +
>> >> +    vsnd->queues[VIRTIO_SND_VQ_CONTROL] =3D
>> >> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
>> >> +    vsnd->queues[VIRTIO_SND_VQ_EVENT] =3D
>> >> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
>> >> +    vsnd->queues[VIRTIO_SND_VQ_TX] =3D
>> >> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
>> >> +    vsnd->queues[VIRTIO_SND_VQ_RX] =3D
>> >> +        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
>> >> +}
>> >> +
>> >> +static void virtio_snd_unrealize(DeviceState *dev)
>> >> +{
>> >> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> >> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
>> >> +
>> >> +    qemu_del_vm_change_state_handler(vsnd->vmstate);
>> >> +    trace_virtio_snd_unrealize(vsnd);
>> >> +
>> >> +    AUD_remove_card(&vsnd->card);
>> >> +    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
>> >> +    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
>> >> +    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
>> >> +    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_RX]);
>> >> +    virtio_cleanup(vdev);
>> >> +}
>> >> +
>> >> +
>> >> +static void virtio_snd_reset(VirtIODevice *vdev) {}
>> >> +
>> >> +static void virtio_snd_class_init(ObjectClass *klass, void *data)
>> >> +{
>> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> >> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
>> >> +
>> >> +
>> >> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>> >> +    device_class_set_props(dc, virtio_snd_properties);
>> >> +
>> >> +    dc->vmsd =3D &vmstate_virtio_snd;
>> >> +    vdc->vmsd =3D &vmstate_virtio_snd_device;
>> >> +    vdc->realize =3D virtio_snd_realize;
>> >> +    vdc->unrealize =3D virtio_snd_unrealize;
>> >> +    vdc->get_config =3D virtio_snd_get_config;
>> >> +    vdc->set_config =3D virtio_snd_set_config;
>> >> +    vdc->get_features =3D get_features;
>> >> +    vdc->reset =3D virtio_snd_reset;
>> >> +    vdc->legacy_features =3D 0;
>> >> +}
>> >> +
>> >> +static const TypeInfo virtio_snd_types[] =3D {
>> >> +    {
>> >> +      .name          =3D TYPE_VIRTIO_SND,
>> >> +      .parent        =3D TYPE_VIRTIO_DEVICE,
>> >> +      .instance_size =3D sizeof(VirtIOSound),
>> >> +      .class_init    =3D virtio_snd_class_init,
>> >> +    }
>> >> +};
>> >> +
>> >> +DEFINE_TYPES(virtio_snd_types)
>> >> diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virti=
o-snd.h
>> >> new file mode 100644
>> >> index 0000000000..934e854a80
>> >> --- /dev/null
>> >> +++ b/include/hw/virtio/virtio-snd.h
>> >> @@ -0,0 +1,79 @@
>> >> +/*
>> >> + * VIRTIO Sound Device conforming to
>> >> + *
>> >> + * "Virtual I/O Device (VIRTIO) Version 1.2
>> >> + * Committee Specification Draft 01
>> >> + * 09 May 2022"
>> >> + *
>> >> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@l=
inaro.org>
>> >> + * Copyright (C) 2019 OpenSynergy GmbH
>> >> + *
>> >> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> >> + * (at your option) any later version.  See the COPYING file in the
>> >> + * top-level directory.
>> >> + */
>> >> +
>> >> +#ifndef QEMU_VIRTIO_SOUND_H
>> >> +#define QEMU_VIRTIO_SOUND_H
>> >> +
>> >> +#include "hw/virtio/virtio.h"
>> >> +#include "audio/audio.h"
>> >> +#include "standard-headers/linux/virtio_ids.h"
>> >> +#include "standard-headers/linux/virtio_snd.h"
>> >> +
>> >> +#define TYPE_VIRTIO_SND "virtio-sound"
>> >> +#define VIRTIO_SND(obj) \
>> >> +        OBJECT_CHECK(VirtIOSound, (obj), TYPE_VIRTIO_SND)
>> >> +
>> >> +/* CONFIGURATION SPACE */
>> >> +
>> >> +typedef struct virtio_snd_config virtio_snd_config;
>> >> +
>> >> +/* COMMON DEFINITIONS */
>> >> +
>> >> +/* common header for request/response*/
>> >> +typedef struct virtio_snd_hdr virtio_snd_hdr;
>> >> +
>> >> +/* event notification */
>> >> +typedef struct virtio_snd_event virtio_snd_event;
>> >> +
>> >> +/* common control request to query an item information */
>> >> +typedef struct virtio_snd_query_info virtio_snd_query_info;
>> >> +
>> >> +/* JACK CONTROL MESSAGES */
>> >> +
>> >> +typedef struct virtio_snd_jack_hdr virtio_snd_jack_hdr;
>> >> +
>> >> +/* jack information structure */
>> >> +typedef struct virtio_snd_jack_info virtio_snd_jack_info;
>> >> +
>> >> +/* jack remapping control request */
>> >> +typedef struct virtio_snd_jack_remap virtio_snd_jack_remap;
>> >> +
>> >> +/*
>> >> + * PCM CONTROL MESSAGES
>> >> + */
>> >> +typedef struct virtio_snd_pcm_hdr virtio_snd_pcm_hdr;
>> >> +
>> >> +/* PCM stream info structure */
>> >> +typedef struct virtio_snd_pcm_info virtio_snd_pcm_info;
>> >> +
>> >> +/* set PCM stream params */
>> >> +typedef struct virtio_snd_pcm_set_params virtio_snd_pcm_set_params;
>> >> +
>> >> +/* I/O request header */
>> >> +typedef struct virtio_snd_pcm_xfer virtio_snd_pcm_xfer;
>> >> +
>> >> +/* I/O request status */
>> >> +typedef struct virtio_snd_pcm_status virtio_snd_pcm_status;
>> >> +
>> >> +typedef struct VirtIOSound {
>> >> +    VirtIODevice parent_obj;
>> >> +
>> >> +    VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>> >> +    uint64_t features;
>> >> +    QEMUSoundCard card;
>> >> +    VMChangeStateEntry *vmstate;
>> >> +    virtio_snd_config snd_conf;
>> >> +} VirtIOSound;
>> >> +#endif
>> >> --=20
>> >> 2.39.2
>>=20
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

