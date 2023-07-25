Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E00761BCE
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:32:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJ57-0005Qh-Rk; Tue, 25 Jul 2023 10:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOJ4b-0005IT-G2
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:31:41 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOJ4Y-0003r0-Id
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:31:36 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-403a72df0a6so31588891cf.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690295493; x=1690900293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3BT2ndsT2lYwhhJvMMngLjE93k/WIsxAW+/wdto8eiA=;
 b=aWyfioGAE35BrCVlLtAnS+KgtyQRgllbIMw2ASWJ4GSLIZOyQl7vAOKsYtLvn6a9ma
 sOE+r6JM8/wNecfRXzOWBMRmRArNYvdtq3omDcRzX+O2Tger7MNrwxhPMcQik5w5Jdix
 Pf57i73p/m8YRzL/wp3ktv8ilPr7HVIgH+clbczo7l3WHnx3s9JTRgaQru/s51yk9OpS
 UADqbCmF0k+6AGWnfiZeFB3wsXUTBaSXFxi7OzV1KSTto8c+Z6vtLp5Kg8ghRODphXuy
 tub7Sms5MYdxTH+wilj9h73OijOfBILquXxS023Gz5RSqJPT4MdUH9AAJPLO2w2qBcBW
 Jizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690295493; x=1690900293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3BT2ndsT2lYwhhJvMMngLjE93k/WIsxAW+/wdto8eiA=;
 b=gRR5pJ53FaEWOSo8roSFLaaOGMgmhP/B/9HkNbNcmLE9hJ4+Be+chE2uxDVI89IEpn
 RZSjM1cfQdYokac4U+Bj/PZAjGTXND5iucoYneC+4MJkFLkyCFN/tOPhHkoKzFnBjC3J
 yRURK2AR1pO6e5J4ss7vP1RfVMyyA2kguxqEirPTObfR4AQuqDlrIdn2yjJrbGXCvKhU
 aGyXWQlNdeCXTGJCqx5U0Mg59rJcAj1shnDHtegQspc1akNY71h6o5xON4bLnHB/VjVD
 qeF9nPAnxXvWJwCQAI7c5y+mZvuFIYLJdZwI9lxHgARVSPi5lw7pW4kGC5MUJ86uvjXS
 uieQ==
X-Gm-Message-State: ABy/qLbgmxaIJO78zWdeNZkwFDwEiHCb8Wxl9eLDAHCqdVKTDamD8SPp
 gilcKpKAqRPz7+KI6HU0TBdggdFvjyBlI64ji9A=
X-Google-Smtp-Source: APBJJlEFWkG0MNIukdvrE8hbnPBj75VaMtaTxdGX63B//mJ+0MaORabw6idj71Jp3RdfPdqk58eWGWH3dtayajC5cy4=
X-Received: by 2002:ac8:5ac7:0:b0:403:8d17:aa31 with SMTP id
 d7-20020ac85ac7000000b004038d17aa31mr3697219qtd.58.1690295493524; Tue, 25 Jul
 2023 07:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
 <ae372de5659503e08b7c55ee2a76e9ca3038748d.1689857559.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <ae372de5659503e08b7c55ee2a76e9ca3038748d.1689857559.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Jul 2023 18:31:22 +0400
Message-ID: <CAJ+F1CJdbcsdHu8WmiDDS_q7ddcJ6RPOLe2XH_EBQkqJTtMw-Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] Add virtio-sound device stub
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, 
 Alex Bennee <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007504b60601509662"
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000007504b60601509662
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 20, 2023 at 4:58=E2=80=AFPM Emmanouil Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

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
>  include/hw/virtio/virtio-snd.h |  79 +++++++++++
>  6 files changed, 330 insertions(+)
>  create mode 100644 hw/virtio/virtio-snd.c
>  create mode 100644 include/hw/virtio/virtio-snd.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12e59b6b27..2bed60f9c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2245,6 +2245,12 @@ F: hw/virtio/virtio-mem-pci.h
>  F: hw/virtio/virtio-mem-pci.c
>  F: include/hw/virtio/virtio-mem.h
>
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
>
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
> @@ -31,6 +31,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK',
> if_true: files('vhost-vsock.c
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true:
> files('vhost-user-vsock.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true:
> files('virtio-rng.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true:
> files('virtio-mem.c'))
> +specific_virtio_ss.add(when: 'CONFIG_VIRTIO_SND', if_true:
> files('virtio-snd.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true:
> files('vhost-user-i2c.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true:
> files('vhost-user-rng.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true:
> files('vhost-user-gpio.c'))
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
> +virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams,
> uint32_t chmaps) "snd %p: get_config jacks=3D%"PRIu32" streams=3D%"PRIu32=
"
> chmaps=3D%"PRIu32""
> +virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks,
> uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t
> new_chmaps) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams
> from %"PRIu32"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
> +virtio_snd_get_features(void *vdev, uint64_t features) "snd %p:
> get_features 0x%"PRIx64
> +virtio_snd_vm_state_running(void) "vm state running"
> +virtio_snd_vm_state_stopped(void) "vm state stopped"
> +virtio_snd_realize(void *snd) "snd %p: realize"
> +virtio_snd_unrealize(void *snd) "snd %p: unrealize"
> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> new file mode 100644
> index 0000000000..e3f2156e5e
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
> + * <
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.ht=
ml#x1-52900014
> >
> + *
> + * Copyright (c) 2023 Emmanouil Pitsidianakis <
> manos.pitsidianakis@linaro.org>
> + * Copyright (C) 2019 OpenSynergy GmbH
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
> +    DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
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
> + *
> + * @vdev: VirtIOSound device
> + * @vq: virtqueue
> + */
> +static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *vq) {=
}
> +
> +static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
> +                             Error **errp)
> +{
> +    /*
> +     * virtio-v1.2-csd01, 5.14.3,
> +     * Feature Bits
> +     * None currently defined.
> +     */
> +    trace_virtio_snd_get_features(vdev, features);
> +    return features | 1UL << VIRTIO_F_VERSION_1 | 1UL <<
> VIRTIO_F_IN_ORDER;
>

../hw/virtio/virtio-snd.c: In function 'get_features':
../hw/virtio/virtio-snd.c:883:27: error: left shift count >=3D width of typ=
e
[-Werror=3Dshift-count-overflow]
  883 |     return features | 1UL << VIRTIO_F_VERSION_1 | 1UL <<
VIRTIO_F_IN_ORDER;
      |                           ^~
../hw/virtio/virtio-snd.c:883:55: error: left shift count >=3D width of typ=
e
[-Werror=3Dshift-count-overflow]
  883 |     return features | 1UL << VIRTIO_F_VERSION_1 | 1UL <<
VIRTIO_F_IN_ORDER;
      |                                                       ^~

--=20
Marc-Andr=C3=A9 Lureau

--0000000000007504b60601509662
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Jul 20, 2023 at 4:58=E2=80=AFPM Emman=
ouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org">ma=
nos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Add a new VIRTIO device for the virtio sound de=
vice id. Functionality<br>
will be added in the following commits.<br>
<br>
Signed-off-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidia=
nakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<=
br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0hw/virtio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A05 +<br>
=C2=A0hw/virtio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A01 +<br>
=C2=A0hw/virtio/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A09 ++<br>
=C2=A0hw/virtio/virtio-snd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 230 +++++++=
++++++++++++++++++++++++++<br>
=C2=A0include/hw/virtio/virtio-snd.h |=C2=A0 79 +++++++++++<br>
=C2=A06 files changed, 330 insertions(+)<br>
=C2=A0create mode 100644 hw/virtio/virtio-snd.c<br>
=C2=A0create mode 100644 include/hw/virtio/virtio-snd.h<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 12e59b6b27..2bed60f9c1 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2245,6 +2245,12 @@ F: hw/virtio/virtio-mem-pci.h<br>
=C2=A0F: hw/virtio/virtio-mem-pci.c<br>
=C2=A0F: include/hw/virtio/virtio-mem.h<br>
<br>
+virtio-snd<br>
+M: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.or=
g" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
+S: Supported<br>
+F: hw/virtio/virtio-snd*.c<br>
+F: include/hw/virtio/virtio-snd.h<br>
+<br>
=C2=A0nvme<br>
=C2=A0M: Keith Busch &lt;<a href=3D"mailto:kbusch@kernel.org" target=3D"_bl=
ank">kbusch@kernel.org</a>&gt;<br>
=C2=A0M: Klaus Jensen &lt;<a href=3D"mailto:its@irrelevant.dk" target=3D"_b=
lank">its@irrelevant.dk</a>&gt;<br>
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig<br>
index 92c9cf6c96..d6f20657b3 100644<br>
--- a/hw/virtio/Kconfig<br>
+++ b/hw/virtio/Kconfig<br>
@@ -17,6 +17,11 @@ config VIRTIO_PCI<br>
=C2=A0 =C2=A0 =C2=A0depends on PCI<br>
=C2=A0 =C2=A0 =C2=A0select VIRTIO<br>
<br>
+config VIRTIO_SND<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 default y<br>
+=C2=A0 =C2=A0 depends on VIRTIO<br>
+<br>
=C2=A0config VIRTIO_MMIO<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0select VIRTIO<br>
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build<br>
index 13e7c6c272..120d4bfa0a 100644<br>
--- a/hw/virtio/meson.build<br>
+++ b/hw/virtio/meson.build<br>
@@ -31,6 +31,7 @@ specific_virtio_ss.add(when: &#39;CONFIG_VHOST_VSOCK&#39;=
, if_true: files(&#39;vhost-vsock.c<br>
=C2=A0specific_virtio_ss.add(when: &#39;CONFIG_VHOST_USER_VSOCK&#39;, if_tr=
ue: files(&#39;vhost-user-vsock.c&#39;))<br>
=C2=A0specific_virtio_ss.add(when: &#39;CONFIG_VIRTIO_RNG&#39;, if_true: fi=
les(&#39;virtio-rng.c&#39;))<br>
=C2=A0specific_virtio_ss.add(when: &#39;CONFIG_VIRTIO_MEM&#39;, if_true: fi=
les(&#39;virtio-mem.c&#39;))<br>
+specific_virtio_ss.add(when: &#39;CONFIG_VIRTIO_SND&#39;, if_true: files(&=
#39;virtio-snd.c&#39;))<br>
=C2=A0specific_virtio_ss.add(when: &#39;CONFIG_VHOST_USER_I2C&#39;, if_true=
: files(&#39;vhost-user-i2c.c&#39;))<br>
=C2=A0specific_virtio_ss.add(when: &#39;CONFIG_VHOST_USER_RNG&#39;, if_true=
: files(&#39;vhost-user-rng.c&#39;))<br>
=C2=A0specific_virtio_ss.add(when: &#39;CONFIG_VHOST_USER_GPIO&#39;, if_tru=
e: files(&#39;vhost-user-gpio.c&#39;))<br>
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events<br>
index 7109cf1a3b..3ed7da35f2 100644<br>
--- a/hw/virtio/trace-events<br>
+++ b/hw/virtio/trace-events<br>
@@ -154,3 +154,12 @@ virtio_pmem_flush_done(int type) &quot;fsync return=3D=
%d&quot;<br>
=C2=A0virtio_gpio_start(void) &quot;start&quot;<br>
=C2=A0virtio_gpio_stop(void) &quot;stop&quot;<br>
=C2=A0virtio_gpio_set_status(uint8_t status) &quot;0x%x&quot;<br>
+<br>
+#virtio-snd.c<br>
+virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32=
_t chmaps) &quot;snd %p: get_config jacks=3D%&quot;PRIu32&quot; streams=3D%=
&quot;PRIu32&quot; chmaps=3D%&quot;PRIu32&quot;&quot;<br>
+virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint=
32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) &=
quot;snd %p: set_config jacks from %&quot;PRIu32&quot;-&gt;%&quot;PRIu32&qu=
ot;, streams from %&quot;PRIu32&quot;-&gt;%&quot;PRIu32&quot;, chmaps from =
%&quot;PRIu32&quot;-&gt;%&quot;PRIu32<br>
+virtio_snd_get_features(void *vdev, uint64_t features) &quot;snd %p: get_f=
eatures 0x%&quot;PRIx64<br>
+virtio_snd_vm_state_running(void) &quot;vm state running&quot;<br>
+virtio_snd_vm_state_stopped(void) &quot;vm state stopped&quot;<br>
+virtio_snd_realize(void *snd) &quot;snd %p: realize&quot;<br>
+virtio_snd_unrealize(void *snd) &quot;snd %p: unrealize&quot;<br>
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c<br>
new file mode 100644<br>
index 0000000000..e3f2156e5e<br>
--- /dev/null<br>
+++ b/hw/virtio/virtio-snd.c<br>
@@ -0,0 +1,230 @@<br>
+/*<br>
+ * VIRTIO Sound Device conforming to<br>
+ *<br>
+ * &quot;Virtual I/O Device (VIRTIO) Version 1.2<br>
+ * Committee Specification Draft 01<br>
+ * 09 May 2022&quot;<br>
+ *<br>
+ * &lt;<a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/vir=
tio-v1.2-csd01.html#x1-52900014" rel=3D"noreferrer" target=3D"_blank">https=
://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-5=
2900014</a>&gt;<br>
+ *<br>
+ * Copyright (c) 2023 Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.=
pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org<=
/a>&gt;<br>
+ * Copyright (C) 2019 OpenSynergy GmbH<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or<br>
+ * (at your option) any later version.=C2=A0 See the COPYING file in the<b=
r>
+ * top-level directory.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/iov.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;include/qemu/lockable.h&quot;<br>
+#include &quot;sysemu/runstate.h&quot;<br>
+#include &quot;trace.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/virtio/virtio-snd.h&quot;<br>
+<br>
+#define VIRTIO_SOUND_VM_VERSION 1<br>
+#define VIRTIO_SOUND_JACK_DEFAULT 0<br>
+#define VIRTIO_SOUND_STREAM_DEFAULT 1<br>
+#define VIRTIO_SOUND_CHMAP_DEFAULT 0<br>
+#define VIRTIO_SOUND_HDA_FN_NID 0<br>
+<br>
+static const VMStateDescription vmstate_virtio_snd_device =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_VIRTIO_SND,<br>
+=C2=A0 =C2=A0 .version_id =3D VIRTIO_SOUND_VM_VERSION,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,<br>
+};<br>
+<br>
+static const VMStateDescription vmstate_virtio_snd =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;virtio-sound&quot;,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,<br>
+=C2=A0 =C2=A0 .version_id =3D VIRTIO_SOUND_VM_VERSION,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_VIRTIO_DEVICE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 },<br>
+};<br>
+<br>
+static Property virtio_snd_properties[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;jacks&quot;, VirtIOSound, snd_conf.=
jacks,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VIRTIO_SOUND_JACK_DEFAULT),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;streams&quot;, VirtIOSound, snd_con=
f.streams,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VIRTIO_SOUND_STREAM_DEFAULT),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;chmaps&quot;, VirtIOSound, snd_conf=
.chmaps,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VIRTIO_SOUND_CHMAP_DEFAULT),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
+};<br>
+<br>
+static void<br>
+virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIOSound *s =3D VIRTIO_SND(vdev);<br>
+=C2=A0 =C2=A0 trace_virtio_snd_get_config(vdev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;snd_conf.jacks,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;snd_conf.streams,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;snd_conf.chmaps);<br>
+<br>
+=C2=A0 =C2=A0 memcpy(config, &amp;s-&gt;snd_conf, sizeof(s-&gt;snd_conf));=
<br>
+}<br>
+<br>
+static void<br>
+virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIOSound *s =3D VIRTIO_SND(vdev);<br>
+=C2=A0 =C2=A0 const virtio_snd_config *sndconfig =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (const virtio_snd_config *)config;<br>
+<br>
+<br>
+=C2=A0 =C2=A0trace_virtio_snd_set_config(vdev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;snd_conf.jacks,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sndconfig-&gt;jacks,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;snd_conf.streams,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sndconfig-&gt;streams,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;snd_conf.chmaps,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sndconfig-&gt;chmaps);<br>
+<br>
+=C2=A0 =C2=A0 memcpy(&amp;s-&gt;snd_conf, sndconfig, sizeof(s-&gt;snd_conf=
));<br>
+}<br>
+<br>
+/*<br>
+ * Queue handler stub.<br>
+ *<br>
+ * @vdev: VirtIOSound device<br>
+ * @vq: virtqueue<br>
+ */<br>
+static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *vq) {}<=
br>
+<br>
+static uint64_t get_features(VirtIODevice *vdev, uint64_t features,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* virtio-v1.2-csd01, 5.14.3,<br>
+=C2=A0 =C2=A0 =C2=A0* Feature Bits<br>
+=C2=A0 =C2=A0 =C2=A0* None currently defined.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 trace_virtio_snd_get_features(vdev, features);<br>
+=C2=A0 =C2=A0 return features | 1UL &lt;&lt; VIRTIO_F_VERSION_1 | 1UL &lt;=
&lt; VIRTIO_F_IN_ORDER;<br></blockquote><div><br></div><div>../hw/virtio/vi=
rtio-snd.c: In function &#39;get_features&#39;:<br>../hw/virtio/virtio-snd.=
c:883:27: error: left shift count &gt;=3D width of type [-Werror=3Dshift-co=
unt-overflow]<br>=C2=A0 883 | =C2=A0 =C2=A0 return features | 1UL &lt;&lt; =
VIRTIO_F_VERSION_1 | 1UL &lt;&lt; VIRTIO_F_IN_ORDER;<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ^~<br>../hw/virtio/virtio-snd.c:883:55: error: left s=
hift count &gt;=3D width of type [-Werror=3Dshift-count-overflow]<br>=C2=A0=
 883 | =C2=A0 =C2=A0 return features | 1UL &lt;&lt; VIRTIO_F_VERSION_1 | 1U=
L &lt;&lt; VIRTIO_F_IN_ORDER;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~ <br></div><div><br></div></div><span class=3D"g=
mail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signat=
ure">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000007504b60601509662--

