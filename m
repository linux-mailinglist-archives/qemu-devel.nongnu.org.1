Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515267A1D94
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7Bl-0002VI-GU; Fri, 15 Sep 2023 07:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qh7Bg-0002UH-0T
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:40:40 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qh7Bd-0002yf-5Z
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:40:39 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d8195078f69so1633611276.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694778035; x=1695382835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JHXYu4Ur6dLU/HP4NvzLACJ8yHhL6lfseAh2wl1O/M=;
 b=nIe8wWVOUdz/YB22jySw7fXthIju4bf3pgvaXGt97tGNIqgNm3K3bM8bJsapfE+4xN
 k+b6YElx4ZNNwTaqREHBOJk+9a7ovC92b/lzIIlLgqz/Jsf4TIvMADjAbmWRWTDEd5kS
 XAE8PYNL7QSh3V3NUUqk8RUYzJDF+Xch246r/Hox81SFAU+7GfhwOUtzmoFAin8q/Kjh
 IHRtCBGrfl34b2NGNjNust6u+Z3ZMctKtKciAdrgTB9soG0qaLh66YnqLGkIbPejRV+Z
 ouohtKQl9fp3JP1f3POmse3tiPJacOCDyWDRFEWAbZTKSRHOMkaERWBodKsK4lBXtaAp
 Wpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694778035; x=1695382835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JHXYu4Ur6dLU/HP4NvzLACJ8yHhL6lfseAh2wl1O/M=;
 b=kMXV99dZPKcSe5cei2uJZss7qBZiKnA/SMZIQSHZ/qztL+iDzl4Bh8GJr2fWd3dt1X
 1DVVFhR7ICRFbfT0nPbdF2eJR2VVlbzdQ/NOh+531EdlSUJQY7HSwe2fNpig3zzGm8/9
 +X7xjHP39wTnQaAEvTrtdeJtWdw3xKTFXtPCAEqegMQdSZ9av2OXthwkNjUbge5SnhX2
 F8zBkjkxZHUHAwZFIXwrj7Jd3rRcpvI4a3ha4I2iMeSgqVAurvUFxBs6A/SSpTKeS48r
 PKw6dt6XAr4qrvxS15WtLdjUvWgUgrhKAw2g29NASZv2qncEVWB2yq9PTRQNWyaFQQre
 saYQ==
X-Gm-Message-State: AOJu0YwmFRmUTFYnv0ZvQPQG2QbRwZ1rXr0PZWqEKtnApWiXmQZPhtUz
 uM6KYSmSMWoc33YxMO3oPvM38YFHugiEcHOtkOw=
X-Google-Smtp-Source: AGHT+IG+lfDv6XzLoI/CpSSDJAC5ChXew44fv95k3EyPaMEoSDQU6zn54qLNcY5+laefj+9IeH+5GIj0mWW+/9XGGcg=
X-Received: by 2002:a25:109:0:b0:d7f:362:1d9a with SMTP id
 9-20020a250109000000b00d7f03621d9amr1186702ybb.2.1694778034914; 
 Fri, 15 Sep 2023 04:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230914013151.805363-1-Ken.Xue@amd.com>
In-Reply-To: <20230914013151.805363-1-Ken.Xue@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Sep 2023 15:40:23 +0400
Message-ID: <CAJ+F1C+hXgnZdDX1iWEPwrqhQNjbyzrwJMfvfqNVYvunAWzEhg@mail.gmail.com>
Subject: Re: [PATCH] ui: add XBGR8888 and ABGR8888 in drm_format_pixman_map
To: Ken Xue <Ken.Xue@amd.com>
Cc: qemu-devel@nongnu.org, pierre-eric.pelloux-prayer@amd.com, Hui.Yu@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb2e.google.com
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

On Thu, Sep 14, 2023 at 9:26=E2=80=AFAM Ken Xue <Ken.Xue@amd.com> wrote:
>
> Android uses XBGR8888 and ABGR8888 as default scanout buffer, But qemu
> does not support them for qemu_pixman_to_drm_format conversion within
> virtio_gpu_create_dmabuf for virtio gpu.
>
> so, add those 2 formats into drm_format_pixman_map.
>
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/qemu-pixman.h | 4 ++++
>  ui/qemu-pixman.c         | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> index 51f870932791..e587c48b1fde 100644
> --- a/include/ui/qemu-pixman.h
> +++ b/include/ui/qemu-pixman.h
> @@ -32,6 +32,8 @@
>  # define PIXMAN_LE_r8g8b8     PIXMAN_b8g8r8
>  # define PIXMAN_LE_a8r8g8b8   PIXMAN_b8g8r8a8
>  # define PIXMAN_LE_x8r8g8b8   PIXMAN_b8g8r8x8
> +# define PIXMAN_LE_a8b8g8r8   PIXMAN_r8g8b8a8
> +# define PIXMAN_LE_x8b8g8r8   PIXMAN_r8g8b8x8
>  #else
>  # define PIXMAN_BE_r8g8b8     PIXMAN_b8g8r8
>  # define PIXMAN_BE_x8r8g8b8   PIXMAN_b8g8r8x8
> @@ -45,6 +47,8 @@
>  # define PIXMAN_LE_r8g8b8     PIXMAN_r8g8b8
>  # define PIXMAN_LE_a8r8g8b8   PIXMAN_a8r8g8b8
>  # define PIXMAN_LE_x8r8g8b8   PIXMAN_x8r8g8b8
> +# define PIXMAN_LE_a8b8g8r8   PIXMAN_a8b8g8r8
> +# define PIXMAN_LE_x8b8g8r8   PIXMAN_x8b8g8r8
>  #endif
>
>  #define QEMU_PIXMAN_COLOR(r, g, b)                                      =
         \
> diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
> index be00a96340d3..b43ec38bf0e9 100644
> --- a/ui/qemu-pixman.c
> +++ b/ui/qemu-pixman.c
> @@ -96,7 +96,9 @@ static const struct {
>  } drm_format_pixman_map[] =3D {
>      { DRM_FORMAT_RGB888,   PIXMAN_LE_r8g8b8   },
>      { DRM_FORMAT_ARGB8888, PIXMAN_LE_a8r8g8b8 },
> -    { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 }
> +    { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 },
> +    { DRM_FORMAT_XBGR8888, PIXMAN_LE_x8b8g8r8 },
> +    { DRM_FORMAT_ABGR8888, PIXMAN_LE_a8b8g8r8 },
>  };
>
>  pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format)
>
> base-commit: 9a8af699677cdf58e92ff43f38ea74bbe9d37ab0
> --
> 2.35.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

