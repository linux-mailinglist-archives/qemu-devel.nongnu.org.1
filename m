Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9807BCCD8
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 09:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNm6-00023i-GZ; Sun, 08 Oct 2023 03:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qpNm2-00023R-Lf
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 03:00:23 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qpNm1-0002FF-0n
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 03:00:22 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4180d962b68so25492881cf.1
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696748419; x=1697353219; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jghLhfj95axCoXGxeyB4pj9E4g04S/5sfFYS+vQBjbo=;
 b=IQP6WtRmiHCBA5GqbLgNbS7qP0hUtPrKKHn6aaxpssQ0iBGK12taPyTLrcQTHAibvp
 wFANyY2IEGHvyMz0fjKP7gtQA8fkZdqsdiWK4eEqYgwV7UngJdGbNALHLz4Lf4+pWK5u
 dhLmmEtvVTOBf1FwfhvSo3trOeJT9QvJD4G5bl3RBgH3tNvDJ2+f0+uajo6QT+y0qTir
 VFoxfoOPoLMnGmXc2DsZkiff53IkjSeODXjyzeEpvuHpFimr5kB5Pas4QNt5p3fwqgJb
 irBTPSr+TMjGn8JvJFv2ty/0HmfHRJj+lyImCaS1idlpcwasAM7uySkddO04UB8uGJLs
 mvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696748419; x=1697353219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jghLhfj95axCoXGxeyB4pj9E4g04S/5sfFYS+vQBjbo=;
 b=ZJOUS2Tpin1MtUNFFSeEGzj9DwTGJ/ddP+6sGlyJCcM5KmMb3YPCpEBqoTecGrptdx
 hPORMXvGJw3cqIvWfWfH3WWxJlQlh45Row94dD00D9INqRVyVYfvQ5CIHAZ+YB9CH995
 UwFXq9sdD2tjCNazv84GUKgIb3ZXcp3HZ/wtzOVKu5mRyRKUhf4N2KzU5gfhDM43Lm7G
 tCDFSkyvDa4igpjAAevV/epLkZQuv0/3x/YFxWuBYC7g4ctaF1APszQIc9dyHELmS82t
 T/Eg4LNQusY6AmU2PBuh5PfwZbl7jH4RZ/bxxMMSM9qUAWwJPEAaqUPYvcakAPmtrSPb
 KOCQ==
X-Gm-Message-State: AOJu0YzDbLhMZi2Y3aokvCEldMFaSj2Lzj7KdKPWg6k4RdcDiDE1eA5W
 1rSiToqGAIv0RF9lyA6Bd+kBgzvH+0iC/infn60=
X-Google-Smtp-Source: AGHT+IEtr5LLsOCrz+Ol/S627KASqIGnjMpltPdscYtFjvqZQa+UK0ey39BWqJ4oGhan2bGh5l1CeEsZWhiotZJY99E=
X-Received: by 2002:a05:622a:1452:b0:419:4d9f:9516 with SMTP id
 v18-20020a05622a145200b004194d9f9516mr16746216qtx.34.1696748419044; Sun, 08
 Oct 2023 00:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231006164508.536406-1-thuth@redhat.com>
In-Reply-To: <20231006164508.536406-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 8 Oct 2023 11:00:07 +0400
Message-ID: <CAJ+F1CLWT8-3TUAj8PHCCMU3e7xwaB+w_uZMGkiHFB08E-q1YQ@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/virtio-gpu: Fix compiler warning when compiling
 with -Wshadow
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
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

On Fri, Oct 6, 2023 at 8:46=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> Avoid using trivial variable names in macros, otherwise we get
> the following compiler warning when compiling with -Wshadow=3Dlocal:
>
> In file included from ../../qemu/hw/display/virtio-gpu-virgl.c:19:
> ../../home/thuth/devel/qemu/hw/display/virtio-gpu-virgl.c:
>  In function =E2=80=98virgl_cmd_submit_3d=E2=80=99:
> ../../qemu/include/hw/virtio/virtio-gpu.h:228:16: error: declaration of =
=E2=80=98s=E2=80=99
>  shadows a previous local [-Werror=3Dshadow=3Dcompatible-local]
>   228 |         size_t s;
>       |                ^
> ../../qemu/hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of mac=
ro
>  =E2=80=98VIRTIO_GPU_FILL_CMD=E2=80=99
>   215 |     VIRTIO_GPU_FILL_CMD(cs);
>       |     ^~~~~~~~~~~~~~~~~~~
> ../../qemu/hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declarati=
on
>  is here
>   213 |     size_t s;
>       |            ^
> cc1: all warnings being treated as errors
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/hw/virtio/virtio-gpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 390c4642b8..8b7e3faf01 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -225,13 +225,13 @@ struct VhostUserGPU {
>  };
>
>  #define VIRTIO_GPU_FILL_CMD(out) do {                                   =
\
> -        size_t s;                                                       =
\
> -        s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,        =
  \
> +        size_t s_;                                                      =
\
> +        s_ =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,       =
  \
>                         &out, sizeof(out));                              =
\
> -        if (s !=3D sizeof(out)) {                                       =
  \
> +        if (s_ !=3D sizeof(out)) {                                      =
  \
>              qemu_log_mask(LOG_GUEST_ERROR,                              =
\
>                            "%s: command size incorrect %zu vs %zu\n",    =
\
> -                          __func__, s, sizeof(out));                    =
\
> +                          __func__, s_, sizeof(out));                   =
\
>              return;                                                     =
\
>          }                                                               =
\
>      } while (0)
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

