Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C8C821CA1
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 14:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKeta-0004bw-VL; Tue, 02 Jan 2024 08:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKetZ-0004bj-2t
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 08:33:25 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKetX-0001BE-Lx
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 08:33:24 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-427f4407624so33949541cf.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704202402; x=1704807202; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEwnovX2NIh6Wxa8+hZ77jwuvVFwPUA/9RKw8czw9Dc=;
 b=mTQfFbGXMvtkPGdbg0QSIyln7x/50JfJgF93LHRtKptrvQBI643eQMFEm5EcefbUAa
 ++KSulCZGEwDWAhKd4wC1wJ5jXjTwjTUOP1NQj0FqY0MQ5c0dENo8fqn3EI4schbIebz
 wNDCOzIrli8hRQ3d+J05fQPezEQQ1uSesODEYPZQA6U4EFwORQhu5+DhocAr+f2hOwXp
 h7wa5IwF7cQ+p5JQxPt6Q6YQSvnN/pOzjarB84MmQu0ArRkaNUl8abxfdL0dIdbuI6O7
 YStWcof2UvYHbCXUqFk1JXmCFZEZ2Ximt08nekSFY9Dy3FEvwOebZyW/srOZNHHZbkye
 cnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704202402; x=1704807202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEwnovX2NIh6Wxa8+hZ77jwuvVFwPUA/9RKw8czw9Dc=;
 b=h7aXBZ+PPsugW9gRqILxBs9EqCOxBiDuxS8d2oHc2YvbBQx/L8NcOopuE+B3DrkYHw
 Qfwnrmp2EMQY6srnY5ze36cyhwE+ExwEYnSgos9JhTkBAHidwya0y1pf7VqpF72KYMCc
 pgA3R0g+jHUcN+A/3AkWgNjPflI+3asrtNh98+tk6kfenq9B6gjWC1mpjKoHzcMRRqnn
 u/TmDVMFxrLP+hFQRzQJRYcBsMi1zIehmMpMfA1zaexrhC1MP3LVJCCF+laFQ2oJ5Kcm
 CTswEVzyuje3gsCIv9cs1+nIzgR2m2htKCkl/KtIOwt16Xq/xtbm8gCUjxDxy1oMp4CV
 6dig==
X-Gm-Message-State: AOJu0YxYHeF+QxdHscO8yJ4vOvTVCW6lwhL00m7kzDaNLJfbdMdS13L+
 u3b6VtzhQpn3ezKJlxz1f7jnQQzrxd6aVoQYnMo=
X-Google-Smtp-Source: AGHT+IG0KAjA8lZc5pB7ytIHUlKTzRKAF2WkhpKmMjlwxjZAZ3KCwdr3O3fCHbhBkW143mphlYO3eRUjo88cG0q5eDM=
X-Received: by 2002:a05:622a:6107:b0:428:1915:60de with SMTP id
 hg7-20020a05622a610700b00428191560demr6063368qtb.18.1704202402558; Tue, 02
 Jan 2024 05:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-11-ray.huang@amd.com>
In-Reply-To: <20231219075320.165227-11-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2024 17:33:11 +0400
Message-ID: <CAJ+F1C+gQ7kwAD=Tv7uAgKtgA57wPkZcE_zadAogtMUEFUmFnQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/11] virtio-gpu: Initialize Venus
To: Huang Rui <ray.huang@amd.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Dec 19, 2023 at 11:55=E2=80=AFAM Huang Rui <ray.huang@amd.com> wrot=
e:
>
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>
> Request Venus when initializing VirGL.
>
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>
> Changes in v6:
> - Remove the unstable API flags check because virglrenderer is already 1.=
0.
> - Squash the render server flag support into "Initialize Venus".
>
>  hw/display/virtio-gpu-virgl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index f35a751824..c523a6717a 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -964,6 +964,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      }
>  #endif
>
> +#ifdef VIRGL_RENDERER_VENUS
> +    flags |=3D VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
> +#endif
> +

I wonder if it's a good idea to initialize venus by default. It
doesn't seem to require vulkan during initialization, but this may
evolve. Make it optional?

>      ret =3D virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>      if (ret !=3D 0) {
>          error_report("virgl could not be initialized: %d", ret);
> --
> 2.25.1
>


--=20
Marc-Andr=C3=A9 Lureau

