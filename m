Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7207A5C50
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVvk-0001w9-I3; Tue, 19 Sep 2023 04:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiVvh-0001vE-AW
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:17:57 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiVvf-0008Io-M2
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:17:57 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-770ef334b4fso239693085a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695111474; x=1695716274; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6XmqpxXe+pFJEvymDTF8JR4Ea1fwE1Z3SOQg5pG66Q=;
 b=RAk3UhOJ7hkacWnHA/FYfkNsC2TTFrlH1AtoeKE0fRQpAW/UaevPKGYrsDSzbyf9L8
 INRef6KI3bo1iyBHQxToK0/u+owksYDOardWOuxyWZ/ByXghhTLvR+iTdMyD7IUKraFY
 csJYEFZ/7mlZ7E1NtnpgDg0PcTCqsnsjmbRrPldjmN+WxsQ3N9jXU4VyVkR/3UYPDN3c
 iqOWzVd1qAYMXZzxDowpEPKx+U6TwJWQwzzmtPNSxqnv5fvivG4HUwdPjQBQY9pxknrZ
 NhMi6kfX7JYiUE+/lWs5ncl9a1x4qAA46ZoWQFaKuDnmzUKvdYYGfm18U7AMM3/aPtOz
 UD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695111474; x=1695716274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6XmqpxXe+pFJEvymDTF8JR4Ea1fwE1Z3SOQg5pG66Q=;
 b=M8mVY1Hw/dqD3y08P9OIuKFXDpz+quBIo4pr6krr/GqYT1ubDkYDG7i+EsyvhwoV10
 f0vRAXEPBPG0D0dPTXSqZOxUote0p04bFbrzzGWMugJPcynClnRz8Gt9sVgdKI477IId
 KHekAff0p+Kae0qFf7AGFUChUWoBhIZoMucO16LWWCfX64xwMeWLZfsPUP/qJp1/H6iI
 EJANRyMorvg1dppYah6eSToglmVJpqrYEAq2dMdXR2Rep3OGI4/TP6GivwxIOxaNq6dV
 FLlOYo7C/msG+zVpk84j30+sdCWsRkeMzrqhGZDbUNVQbl6E5UaGhi8z9mXFLh9c3und
 OJSg==
X-Gm-Message-State: AOJu0Yxo2fvA92YBTTx8uvYOHeqXUM/5Tx6zHRW3wQhk2yi/u7T4gykU
 nWJFOhyNV9GW2D+w0ooNjs6D6budI+DM0aGaqsg=
X-Google-Smtp-Source: AGHT+IFrojAXgVVGst6JFQ0C2v6XMWIlWUwMMsKEePdzd+QZppOC/bSo9UUG0gwct+RD/tgsIxswtt+y5ED36ahcmWw=
X-Received: by 2002:a05:620a:2a15:b0:767:c30:517 with SMTP id
 o21-20020a05620a2a1500b007670c300517mr2947653qkp.3.1695111474434; Tue, 19 Sep
 2023 01:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-6-ray.huang@amd.com>
In-Reply-To: <20230915111130.24064-6-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Sep 2023 12:17:43 +0400
Message-ID: <CAJ+F1CK6_vDhh_=2kvHXkba8HYTvTuCP9ov-xW9EJ76SB4toWQ@mail.gmail.com>
Subject: Re: [QEMU PATCH v5 05/13] virtio-gpu: Configure context init for
 virglrenderer
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72f.google.com
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

On Fri, Sep 15, 2023 at 6:16=E2=80=AFPM Huang Rui <ray.huang@amd.com> wrote=
:
>
> Configure context init feature flag for virglrenderer.
>
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>
> V4 -> V5:
>     - Inverted patch 5 and 6 because we should configure
>       HAVE_VIRGL_CONTEXT_INIT firstly. (Philippe)
>
>  meson.build | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1..ff20d3c249 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1068,6 +1068,10 @@ if not get_option('virglrenderer').auto() or have_=
system or have_vhost_user_gpu
>                                         prefix: '#include <virglrenderer.=
h>',
>                                         dependencies: virgl))
>    endif
> +  config_host_data.set('HAVE_VIRGL_CONTEXT_INIT',
> +                       cc.has_function('virgl_renderer_context_create_wi=
th_flags',
> +                                       prefix: '#include <virglrenderer.=
h>',
> +                                       dependencies: virgl))

Move it under the "if virgl.found()" block above.

I suggest to name it after what is actually checked:
HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS for ex

>  endif
>  blkio =3D not_found
>  if not get_option('blkio').auto() or have_block
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

