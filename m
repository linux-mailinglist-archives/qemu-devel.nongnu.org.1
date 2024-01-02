Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9375821B24
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:44:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKdBJ-00068p-3c; Tue, 02 Jan 2024 06:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKdBH-00068L-0t
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:43:35 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKdBF-0005hX-Ej
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:43:34 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42831bbf750so1122121cf.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 03:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704195812; x=1704800612; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRWEY18VciRq+byvwMCRJuF5oX/xWtKPpJhz2/bbeoM=;
 b=mohXKSHUx6E5bBIAoFM4haXKfQdyTLJGC1kt2uHnyqyjWLCt149dz87MUjq+pcjstz
 njXex3Hb2iJm/PyPhTBc0tuOZNMT0bRD4CEyu2CIthKdu79kZ01H2Kq+a1EClCx2IgBQ
 MomuRT+D+IT543UEeBeR4dUUfCvH+TwtzPJ6gQYcD1e8mUGQOLtIQYJWyHbAb24Ggonc
 pl+48vb7vZ0m0HbF3047iLVXnpxsn+8zKr5sWiCujhB3fQMruxCdXHRUM3oPmnJWQZDH
 pL9wBuo0H4fvV4JDwRXC6MT5ZNd/XIKU9E3t60rDbc/WlVueMBYWedr5p3OnxIIvSS2x
 z1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704195812; x=1704800612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRWEY18VciRq+byvwMCRJuF5oX/xWtKPpJhz2/bbeoM=;
 b=b4HGHL7V2KXoWpPTshpYy2Z0XTmwCdIV+DrAIMSmWC2p8vh4rHZ3Bygj1vJ8AwUo/I
 UKxQCfkGV2Xb7/qHz6oA8GDH9n4fooKZAWgP+aW+rHAecyP4Z0i+oqwJiyFArJggx9k7
 hIwpyp6M0Otnzw3ONBy05hnMwp6dCotw20iYZ/rz3NTi/KyRaJ3cMHsMkZ0VabWkU2cB
 CTEqw6R1BrLI/1IVs8AR/XRSl/9TdvTvWSEfaBpBXKMAb9Zr4Cd1AA5amgNCEMJh34m2
 2UQ/k2PTCKdguLSMcXMVpKPNO8RE2MWncDTS9z3/bE5FinIKxNQBaXQ1lpPdDtDXi8dR
 gj5A==
X-Gm-Message-State: AOJu0YwspD7DSlrynUr/xxkGDFknDn5/SlRC4e2wOPIoW4zF+2ztMbdu
 9gsU4sVz0pj0B5bERcn/OPIXl/G9HD2mxP67Wk4=
X-Google-Smtp-Source: AGHT+IElUCV1tBN7z3T8PqF76mDlw2yI+JJQJrvkY3fbF7Kd8h10J0xQcAoWiSbWqyJXU4H5PkT7ziqveKo2VLi0OMk=
X-Received: by 2002:ac8:5844:0:b0:428:3018:7ee7 with SMTP id
 h4-20020ac85844000000b0042830187ee7mr918581qth.77.1704195812322; Tue, 02 Jan
 2024 03:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-4-ray.huang@amd.com>
In-Reply-To: <20231219075320.165227-4-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2024 15:43:20 +0400
Message-ID: <CAJ+F1CJ7cH3v9vXy+g-2ANZ1MowprW451dhzSDdsSn=P+c7LFg@mail.gmail.com>
Subject: Re: [PATCH v6 03/11] virtio-gpu: Support context init feature with
 virglrenderer
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Tue, Dec 19, 2023 at 11:54=E2=80=AFAM Huang Rui <ray.huang@amd.com> wrot=
e:
>
> Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
> feature flags.
> We would like to enable the feature with virglrenderer, so add to create
> virgl renderer context with flags using context_id when valid.
>
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>
> Changes in v6:
> - Handle the case while context_init is disabled.
> - Enable context_init by default.
>
>  hw/display/virtio-gpu-virgl.c | 13 +++++++++++--
>  hw/display/virtio-gpu.c       |  4 ++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 8bb7a2c21f..5bbc8071b2 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -106,8 +106,17 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
>      trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>                                      cc.debug_name);
>
> -    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
> -                                  cc.debug_name);
> +#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
> +    if (cc.context_init && virtio_gpu_context_init_enabled(g->parent_obj=
.conf)) {
> +        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
> +                                                 cc.context_init,
> +                                                 cc.nlen,
> +                                                 cc.debug_name);
> +        return;
> +    }
> +#endif
> +
> +    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name)=
;
>  }
>
>  static void virgl_cmd_context_destroy(VirtIOGPU *g,
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index b016d3bac8..8b2f4c6be3 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1619,6 +1619,10 @@ static Property virtio_gpu_properties[] =3D {
>      DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>      DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> +#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
> +    DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,
> +                    VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED, true),
> +#endif

Does it make sense to make this configurable? If the context to be
created asked for a capset id but the one created doesn't respect it,
what's the outcome?

It looks like it should instead set cmd->error.

--=20
Marc-Andr=C3=A9 Lureau

