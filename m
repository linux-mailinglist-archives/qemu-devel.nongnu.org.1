Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1B787748
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZERH-0007I9-1l; Thu, 24 Aug 2023 13:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZERE-0007Hv-1U
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:48:08 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZERA-0004YX-Ra
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:48:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c615eb6feso21725f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692899283; x=1693504083;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYRIBQcKp6Mz2ikeqjY+PHNUYX4u6K/3/EdQ4x4H33w=;
 b=Q/8x5cd1qN+OvhDc0VECGyrTqWwz+iRC0SsTwOWCVSsA4F+9JBp9zI3BKJsHRvagmK
 OwIXi3lxVW+9deobGHDBPBg9F/F+QI4vvVnYY+PkUgsrh+xAgpOe+OfcVd86rl7MQG2G
 QP0YV8DOP41zJLviGnX8AxjoyhxaZSjn8rTK+xISu0TYWVQJsMIW08JmAWErudtIKVpr
 4XEwtqSqIffijB0idf2FJ7aSk6hZ0KCB4P8YTAWcDta43/WJOwth7nwbAY3g0KwOnl4z
 rBNN2bWCTohZMWliWsxjxp80cGKPSmptRqNW/AF3MtoD1ufkmTrs3RrdIaFDg4l0Nl1u
 o74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692899283; x=1693504083;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sYRIBQcKp6Mz2ikeqjY+PHNUYX4u6K/3/EdQ4x4H33w=;
 b=Riu3NOA/tHiRB/7GTrfZSvcxRQSVrc9/+4/xvQpW5dZk8diugH8DVkVRVJmGS6TIEy
 XRN09fuspegdm3TkRfqFlxkNLnBqFiKKT/asHa6b9JysNkoKrL6sphx8KCU5SFGoJn4P
 pp8jiTvLA4MdZM/ECplUAI0j56AOlYHz36sP8Gye5ykMLHZs7GKbvOCxX6Qvp5FEeVqO
 haOc8EKBavalsC5mTIh4t8tgYuhXIL6yOQhJfVERBRMNzsmj7dfmz52nRz8Y0jEjfcx0
 2J6J1Ny4nRPm/yNt/+lpHEERyjM3cmVdnnXnItqxZabSiGFdiBVq/3hkKpEzGxNDcbQP
 F9+Q==
X-Gm-Message-State: AOJu0YwZe3FERMulDrg3nNKrQKKSzZuYG7MM8zqxSLZdElO+dLBZg24E
 Up8hRjlJUjI9wmz0VuTaqAtPYw==
X-Google-Smtp-Source: AGHT+IGl1ENTSe5PQprQEPGA4/XMtHHkKuLfwFr/VnNKJS5U6fSIEMWnlZp5n6njyZhtABjY+4reOw==
X-Received: by 2002:adf:e482:0:b0:317:7eec:5e9d with SMTP id
 i2-20020adfe482000000b003177eec5e9dmr11788912wrm.16.1692899283045; 
 Thu, 24 Aug 2023 10:48:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a056000136100b003180027d67asm22567865wrz.19.2023.08.24.10.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 10:48:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 217901FFBB;
 Thu, 24 Aug 2023 18:48:02 +0100 (BST)
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
 <1a8ffb08d6357b3b83109dabc7430490b2a0e05e.1692731646.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>, =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 01/12] Add virtio-sound device stub
Date: Thu, 24 Aug 2023 18:44:21 +0100
In-reply-to: <1a8ffb08d6357b3b83109dabc7430490b2a0e05e.1692731646.git.manos.pitsidianakis@linaro.org>
Message-ID: <87o7iwfi25.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add a new VIRTIO device for the virtio sound device id. Functionality
> will be added in the following commits.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  MAINTAINERS                    |   6 +
>  hw/virtio/Kconfig              |   5 +
>  hw/virtio/meson.build          |   1 +
>  hw/virtio/trace-events         |   9 ++
>  hw/virtio/virtio-snd.c         | 230 +++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-snd.h |  78 +++++++++++
>  6 files changed, 329 insertions(+)
>  create mode 100644 hw/virtio/virtio-snd.c
>  create mode 100644 include/hw/virtio/virtio-snd.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6111b6b4d9..ba365d621c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2245,6 +2245,12 @@ F: hw/virtio/virtio-mem-pci.h
>  F: hw/virtio/virtio-mem-pci.c
>  F: include/hw/virtio/virtio-mem.h
>=20=20
> +virtio-snd
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +S: Supported
> +F: hw/virtio/virtio-snd*.c
> +F: include/hw/virtio/virtio-snd.h
> +
>  nvme
>  M: Keith Busch <kbusch@kernel.org>
>  M: Klaus Jensen <its@irrelevant.dk>
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 92c9cf6c96..d6f20657b3 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -17,6 +17,11 @@ config VIRTIO_PCI
>      depends on PCI
>      select VIRTIO
>=20=20
> +config VIRTIO_SND
> +    bool
> +    default y
> +    depends on VIRTIO
> +
>  config VIRTIO_MMIO
>      bool
>      select VIRTIO
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 13e7c6c272..120d4bfa0a 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -31,6 +31,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_t=
rue: files('vhost-vsock.c
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('=
vhost-user-vsock.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio=
-rng.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio=
-mem.c'))
> +specific_virtio_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio=
-snd.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vh=
ost-user-i2c.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vh=
ost-user-rng.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('v=
host-user-gpio.c'))
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 7109cf1a3b..3ed7da35f2 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -154,3 +154,12 @@ virtio_pmem_flush_done(int type) "fsync return=3D%d"
>  virtio_gpio_start(void) "start"
>  virtio_gpio_stop(void) "stop"
>  virtio_gpio_set_status(uint8_t status) "0x%x"
> +
> +#virtio-snd.c
> +virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint=
32_t chmaps) "snd %p: get_config jacks=3D%"PRIu32" streams=3D%"PRIu32" chma=
ps=3D%"PRIu32""
> +virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, ui=
nt32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps)=
 "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PRIu32=
"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
> +virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_feat=
ures 0x%"PRIx64
> +virtio_snd_vm_state_running(void) "vm state running"
> +virtio_snd_vm_state_stopped(void) "vm state stopped"
> +virtio_snd_realize(void *snd) "snd %p: realize"
> +virtio_snd_unrealize(void *snd) "snd %p: unrealize"
> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> new file mode 100644
> index 0000000000..0498e660a5
> --- /dev/null
> +++ b/hw/virtio/virtio-snd.c
> @@ -0,0 +1,230 @@
> +/*
> + * VIRTIO Sound Device conforming to
> + *
> + * "Virtual I/O Device (VIRTIO) Version 1.2
> + * Committee Specification Draft 01
> + * 09 May 2022"
> + *
> + * <https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd=
01.html#x1-52900014>
> + *
> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linar=
o.org>
> + * Copyright (C) 2019 OpenSynergy GmbH

Given its based on OpenSynergies patches we probably should bring their
s-o-b's across or add Based-on: references in the commit messages.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/iov.h"
> +#include "qemu/log.h"
> +#include "include/qemu/lockable.h"
> +#include "sysemu/runstate.h"
> +#include "trace.h"
> +#include "qapi/error.h"
> +#include "hw/virtio/virtio-snd.h"
> +
> +#define VIRTIO_SOUND_VM_VERSION 1
> +#define VIRTIO_SOUND_JACK_DEFAULT 0
> +#define VIRTIO_SOUND_STREAM_DEFAULT 1
> +#define VIRTIO_SOUND_CHMAP_DEFAULT 0
> +#define VIRTIO_SOUND_HDA_FN_NID 0
> +
> +static const VMStateDescription vmstate_virtio_snd_device =3D {
> +    .name =3D TYPE_VIRTIO_SND,
> +    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> +    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> +};
> +
> +static const VMStateDescription vmstate_virtio_snd =3D {
> +    .name =3D "virtio-sound",
> +    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> +    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static Property virtio_snd_properties[] =3D {
> +    DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
> +                       VIRTIO_SOUND_JACK_DEFAULT),
> +    DEFINE_PROP_UINT32("streams", VirtIOSound, snd_conf.streams,
> +                       VIRTIO_SOUND_STREAM_DEFAULT),
> +    DEFINE_PROP_UINT32("chmaps", VirtIOSound, snd_conf.chmaps,
> +                       VIRTIO_SOUND_CHMAP_DEFAULT),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void
> +virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    trace_virtio_snd_get_config(vdev,
> +                                s->snd_conf.jacks,
> +                                s->snd_conf.streams,
> +                                s->snd_conf.chmaps);
> +
> +    memcpy(config, &s->snd_conf, sizeof(s->snd_conf));
> +}
> +
> +static void
> +virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    const virtio_snd_config *sndconfig =3D
> +        (const virtio_snd_config *)config;
> +
> +
> +   trace_virtio_snd_set_config(vdev,
> +                               s->snd_conf.jacks,
> +                               sndconfig->jacks,
> +                               s->snd_conf.streams,
> +                               sndconfig->streams,
> +                               s->snd_conf.chmaps,
> +                               sndconfig->chmaps);
> +
> +    memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
> +}
> +
> +/*
> + * Queue handler stub.

"Temporary queue handler stub"? seeing as it disappears once everything
is complete.

> + *
> + * @vdev: VirtIOSound device
> + * @vq: virtqueue
> + */
> +static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue
> *vq) {}
> +
> +static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
> +                             Error **errp)
> +{
> +    /*
> +     * virtio-v1.2-csd01, 5.14.3,
> +     * Feature Bits
> +     * None currently defined.
> +     */
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    features |=3D s->features;
> +
> +    trace_virtio_snd_get_features(vdev, features);
> +
> +    return features;
> +}
> +
> +static void virtio_snd_common_realize(DeviceState *dev,
> +                                      VirtIOHandleOutput ctrl,
> +                                      VirtIOHandleOutput evt,
> +                                      VirtIOHandleOutput txq,
> +                                      VirtIOHandleOutput rxq,
> +                                      Error **errp)
> +{

Why split this off from _realize? It only ever has one caller.

> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> +
> +    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
> +    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
> +
> +    /* set number of jacks and streams */
> +    if (vsnd->snd_conf.jacks > 8) {
> +        error_setg(errp,
> +                   "Invalid number of jacks: %"PRIu32,
> +                   vsnd->snd_conf.jacks);
> +        return;
> +    }
> +    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
> +        error_setg(errp,
> +                   "Invalid number of streams: %"PRIu32,
> +                    vsnd->snd_conf.streams);
> +        return;
> +    }
> +
> +    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
> +        error_setg(errp,
> +                   "Invalid number of channel maps: %"PRIu32,
> +                   vsnd->snd_conf.chmaps);
> +        return;
> +    }
> +
> +    AUD_register_card("virtio-sound", &vsnd->card);
> +
> +    vsnd->queues[VIRTIO_SND_VQ_CONTROL] =3D virtio_add_queue(vdev, 64, c=
trl);
> +    vsnd->queues[VIRTIO_SND_VQ_EVENT] =3D virtio_add_queue(vdev, 64, evt=
);
> +    vsnd->queues[VIRTIO_SND_VQ_TX] =3D virtio_add_queue(vdev, 64, txq);
> +    vsnd->queues[VIRTIO_SND_VQ_RX] =3D virtio_add_queue(vdev, 64, rxq);
> +}
> +
> +static void
> +virtio_snd_vm_state_change(void *, bool running, RunState)
> +{
> +    if (running) {
> +        trace_virtio_snd_vm_state_running();
> +    } else {
> +        trace_virtio_snd_vm_state_stopped();
> +    }
> +}
> +
> +static void virtio_snd_realize(DeviceState *dev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> +
> +    vsnd->vmstate =3D
> +        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsn=
d);
> +
> +    trace_virtio_snd_realize(vsnd);
> +
> +    virtio_snd_common_realize(dev,
> +                              virtio_snd_handle_queue,
> +                              virtio_snd_handle_queue,
> +                              virtio_snd_handle_queue,
> +                              virtio_snd_handle_queue,
> +                              errp);
> +}
> +
> +static void virtio_snd_unrealize(DeviceState *dev)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> +
> +    qemu_del_vm_change_state_handler(vsnd->vmstate);
> +    virtio_del_queue(vdev, 0);
> +
> +    trace_virtio_snd_unrealize(vsnd);
> +
> +    AUD_remove_card(&vsnd->card);
> +    virtio_cleanup(vdev);
> +}
> +
> +
> +static void virtio_snd_reset(VirtIODevice *vdev) {}
> +
> +static void virtio_snd_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> +
> +
> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> +    device_class_set_props(dc, virtio_snd_properties);
> +
> +    dc->vmsd =3D &vmstate_virtio_snd;
> +    vdc->vmsd =3D &vmstate_virtio_snd_device;
> +    vdc->realize =3D virtio_snd_realize;
> +    vdc->unrealize =3D virtio_snd_unrealize;
> +    vdc->get_config =3D virtio_snd_get_config;
> +    vdc->set_config =3D virtio_snd_set_config;
> +    vdc->get_features =3D get_features;
> +    vdc->reset =3D virtio_snd_reset;
> +    vdc->legacy_features =3D 0;
> +}
> +
> +static const TypeInfo virtio_snd_types[] =3D {
> +    {
> +      .name          =3D TYPE_VIRTIO_SND,
> +      .parent        =3D TYPE_VIRTIO_DEVICE,
> +      .instance_size =3D sizeof(VirtIOSound),
> +      .class_init    =3D virtio_snd_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(virtio_snd_types)
> diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-sn=
d.h
> new file mode 100644
> index 0000000000..b3c0e6f079
> --- /dev/null
> +++ b/include/hw/virtio/virtio-snd.h
> @@ -0,0 +1,78 @@
> +/*
> + * VIRTIO Sound Device conforming to
> + *
> + * "Virtual I/O Device (VIRTIO) Version 1.2
> + * Committee Specification Draft 01
> + * 09 May 2022"
> + *
> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linar=
o.org>
> + * Copyright (C) 2019 OpenSynergy GmbH
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#ifndef QEMU_VIRTIO_SOUND_H
> +#define QEMU_VIRTIO_SOUND_H
> +
> +#include "hw/virtio/virtio.h"
> +#include "audio/audio.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_snd.h"
> +
> +#define TYPE_VIRTIO_SND "virtio-sound"
> +#define VIRTIO_SND(obj) \
> +        OBJECT_CHECK(VirtIOSound, (obj), TYPE_VIRTIO_SND)
> +
> +/* CONFIGURATION SPACE */
> +
> +typedef struct virtio_snd_config virtio_snd_config;
> +
> +/* COMMON DEFINITIONS */
> +
> +/* common header for request/response*/
> +typedef struct virtio_snd_hdr virtio_snd_hdr;
> +
> +/* event notification */
> +typedef struct virtio_snd_event virtio_snd_event;
> +
> +/* common control request to query an item information */
> +typedef struct virtio_snd_query_info virtio_snd_query_info;
> +
> +/* JACK CONTROL MESSAGES */
> +
> +typedef struct virtio_snd_jack_hdr virtio_snd_jack_hdr;
> +
> +/* jack information structure */
> +typedef struct virtio_snd_jack_info virtio_snd_jack_info;
> +
> +/* jack remapping control request */
> +typedef struct virtio_snd_jack_remap virtio_snd_jack_remap;
> +
> +/*
> + * PCM CONTROL MESSAGES
> + */
> +typedef struct virtio_snd_pcm_hdr virtio_snd_pcm_hdr;
> +
> +/* PCM stream info structure */
> +typedef struct virtio_snd_pcm_info virtio_snd_pcm_info;
> +
> +/* set PCM stream params */
> +typedef struct virtio_snd_pcm_set_params virtio_snd_pcm_set_params;
> +
> +/* I/O request header */
> +typedef struct virtio_snd_pcm_xfer virtio_snd_pcm_xfer;
> +
> +/* I/O request status */
> +typedef struct virtio_snd_pcm_status virtio_snd_pcm_status;
> +
> +typedef struct VirtIOSound {
> +    VirtIODevice parent_obj;
> +    VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> +    uint64_t features;
> +    QEMUSoundCard card;
> +    VMChangeStateEntry *vmstate;
> +    virtio_snd_config snd_conf;
> +} VirtIOSound;
> +#endif

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

