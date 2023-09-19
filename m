Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CCB7A5D56
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWdL-0002ru-0m; Tue, 19 Sep 2023 05:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiWd9-0002qL-55
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:02:52 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiWd6-0003eU-8c
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:02:50 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4136bfb3220so33838911cf.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695114167; x=1695718967; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ND+2Cd2f8q8DTCVTY8iiypxhEp8aFLppxW2F9VQBRQ4=;
 b=SBED2toWqV9+yYr80rYw3R/n5y6BBc/L70lyz9EEG1/nNEXdmC4ihQZne+NRu+R+wf
 CAoZ/fnx6baCysNSl5TLmK7oUcQ/l/WKoh9lS49Iho4SkTp6gcfqUkYwfedmut5qfLxR
 LkU8T9hOE2P4yVqea3KaNS+TVhaAAMtOaIz2V+YSErNhVZ1+moUxXao0XnAvzJjoa6nF
 OsHo98RNP2hKZEmKzXaiKCux8guVzLblydZiRDetAFRGlLai9ypfPBDxMqD0IiBH83DF
 5zAsP21g07sT2u47NEYC3dEvP7OfTSeDE6K2JLkAVWx4ni2RORGf5wiyw4QHWk5A+ubG
 yuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695114167; x=1695718967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ND+2Cd2f8q8DTCVTY8iiypxhEp8aFLppxW2F9VQBRQ4=;
 b=wG1jx/3zaDq+cmo8YPuNI61wn2kK0kfyLtRx249a4KVXTFH6+ptnGYIrvzlC/Hs0th
 AI/V9j3cbC6wJpk3laag1moIVm8w8oVJLfAevLL0bW5V6/THzOLZJTojD1QB1QA+rSVY
 B2Fz0yf5oUx294Di98Jipxeq16rD079ih8T7e0cGz7XxOE/PcAxONr//IChtiGsDS4Rm
 3XNo69usH3UqTJoV6uwZAbL8Sb2qEkyYuwsQLv4vdr2H2dEkql9mmhErRCmzXnoMMZaS
 iVDnwP8uaxvKi6PK7L90S+ZkCF83KMmTWa2YQkk6XAvbox8etmvySiL8dz3+DJhcgSmC
 H5kg==
X-Gm-Message-State: AOJu0YxsFxwFEISV8xPtlKOSvJFdaA7d1psxBKsUUERFAORQ710G7YsW
 hnQRH8qSWWVd91aC5CDTvo+yMrd1Kyyfjy1WSro=
X-Google-Smtp-Source: AGHT+IGChCz4TECfH811U/m/F4mFC9MdWzVWs4DMJgpjYjtS/oH22r6seHdiRpej/iz1PIscZ6RnbPplDdc39F2tjEA=
X-Received: by 2002:a05:622a:1ba4:b0:412:6f:9ead with SMTP id
 bp36-20020a05622a1ba400b00412006f9eadmr12961809qtb.14.1695114167189; Tue, 19
 Sep 2023 02:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-12-ray.huang@amd.com>
In-Reply-To: <20230915111130.24064-12-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Sep 2023 13:02:36 +0400
Message-ID: <CAJ+F1CJ8R7j_1k3yC2GsdN_v8CsOQ7R+=n_0CCzFW98tWrSLhA@mail.gmail.com>
Subject: Re: [QEMU PATCH v5 11/13] virtio-gpu: Support Venus capset
To: Huang Rui <ray.huang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Albert Esteve <aesteve@redhat.com>, ernunes@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Fri, Sep 15, 2023 at 3:14=E2=80=AFPM Huang Rui <ray.huang@amd.com> wrote=
:
>
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>
> Add support for the Venus capset, which enables Vulkan support through
> the Venus Vulkan driver for virtio-gpu.
>
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>
> V4 -> V5:
>     - Send kernel patch to define VIRTIO_GPU_CAPSET_VENUS and will use
>       another patch to sync up linux headers. (Akihiko)
>     - https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd=
.com/

Ok but in the meantime, you should have that header update patch in
the series too, otherwise we can't compile it :)

thanks

>
>  hw/display/virtio-gpu-virgl.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 8a017dbeb4..7f95490e90 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -437,6 +437,11 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>          virgl_renderer_get_cap_set(resp.capset_id,
>                                     &resp.capset_max_version,
>                                     &resp.capset_max_size);
> +    } else if (info.capset_index =3D=3D 2) {
> +        resp.capset_id =3D VIRTIO_GPU_CAPSET_VENUS;
> +        virgl_renderer_get_cap_set(resp.capset_id,
> +                                   &resp.capset_max_version,
> +                                   &resp.capset_max_size);
>      } else {
>          resp.capset_max_version =3D 0;
>          resp.capset_max_size =3D 0;
> @@ -901,10 +906,18 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>
>  int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>  {
> -    uint32_t capset2_max_ver, capset2_max_size;
> +    uint32_t capset2_max_ver, capset2_max_size, num_capsets;
> +    num_capsets =3D 1;
> +
>      virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> -                              &capset2_max_ver,
> -                              &capset2_max_size);
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    num_capsets +=3D capset2_max_ver ? 1 : 0;
> +
> +    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    num_capsets +=3D capset2_max_size ? 1 : 0;
>
> -    return capset2_max_ver ? 2 : 1;
> +    return num_capsets;
>  }
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

