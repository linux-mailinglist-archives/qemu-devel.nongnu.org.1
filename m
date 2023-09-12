Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E6F79CECF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0wx-0001Ov-H9; Tue, 12 Sep 2023 06:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg0wv-0001Dt-8u
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:48:53 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg0wr-0003Ve-Lq
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:48:52 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-57354433a7dso3005299eaf.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694515728; x=1695120528; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut4GhdLuVGLYwwhJYgj2JulBz7ypsLoyPJNAe5KGtHo=;
 b=T7tFOJuPM6pPUB02mc5+BzqceeXhSUM98eTKUI82qtPmRXVm4pDzoI/UcyExY2DlV1
 mrdRZQyenjcOvN0ICT75AIem7NTCirikPaG8gKUxUZWNUAtX7tuJFsgSosH0LuHyBYsc
 jq3458hbjD/ojcV6bFYJcAaMwo5k8cTTUIeDBaYUJBAsJJXiAi2fOyVeTX7ZApzS8QXO
 1dTPQQWAHGozE2Nx/l2cqRPMmMHE+t61U+eHWhJ+8n6FEE8/TdmV1pKlBNak9JfSsOT/
 rB0RVGAK9cN+wBQi7dqfYm+/qCHaRJQ8X/fP3mGoWrcwYqgjfXgxVqhdSSFB0P4PlrJ/
 apWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694515728; x=1695120528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ut4GhdLuVGLYwwhJYgj2JulBz7ypsLoyPJNAe5KGtHo=;
 b=wAHVZ5UY7U1F8SAkGYtR9DhboEheEx7/CpGsOauVy8NQh4MeuUeOqB0qdrum1dwiaP
 nyAbKriQKnDfkwjw+nSRYHhgditw/nqWYxiUzUTmR1s8ucS9E62NboYmRTVVdzaVfl7c
 q0ntpw3sOiUvJ0d3MXdGy5O8VZ4KDEr6oO2U6Vk9Yq8Y7eXsUQrbVeZPrHcbg873CzC8
 ZVARxJMX2qbjfFSs1qJMYfXWQ1o8Ot89rxi7qIzn7pE6oJGAnbguK1htibByKQLjcl9w
 AjxnIzXX7otOn30fkNPCyD0v4MK/VJYTh74Y6QA6DtWTKn5FI4I9iGUo7Gza139O/s3g
 5pfw==
X-Gm-Message-State: AOJu0YxtujYM46rLDxsSYzZdTI+ZFaIjBY7wyZht0yLtJzpAqR92FIei
 jIdnIgV3Ox5IuCPX9isuiaPPzo0EyvHVCuqI7MM=
X-Google-Smtp-Source: AGHT+IEtadzc8eOaarlnAJsQXclY69cWq5KdflxBAca2Wb9z4tjXLnBO+YvwCuB+FupoQyt+WZ/4Ayz+P/sbMmG1bfY=
X-Received: by 2002:a05:6870:42d1:b0:1c8:d72a:d6b4 with SMTP id
 z17-20020a05687042d100b001c8d72ad6b4mr12790990oah.2.1694515728295; Tue, 12
 Sep 2023 03:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230911215435.4156314-1-stefanha@redhat.com>
 <430ea775-678f-e5ac-d548-6556dcf54e06@linaro.org>
In-Reply-To: <430ea775-678f-e5ac-d548-6556dcf54e06@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 06:48:36 -0400
Message-ID: <CAJSP0QUiTQVuq3OhVcZmHjmChDJtVFhH8YmEZQmHBfTAWhESwQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix gcc cvq_isolated uninitialized variable warning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc30.google.com
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

On Tue, 12 Sept 2023 at 02:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> On 11/9/23 23:54, Stefan Hajnoczi wrote:
> > gcc 13.2.1 emits the following warning:
> >
> >    net/vhost-vdpa.c: In function =E2=80=98net_vhost_vdpa_init.constprop=
=E2=80=99:
> >    net/vhost-vdpa.c:1394:25: error: =E2=80=98cvq_isolated=E2=80=99 may =
be used uninitialized [-Werror=3Dmaybe-uninitialized]
> >     1394 |         s->cvq_isolated =3D cvq_isolated;
> >          |         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> >    net/vhost-vdpa.c:1355:9: note: =E2=80=98cvq_isolated=E2=80=99 was de=
clared here
> >     1355 |     int cvq_isolated;
> >          |         ^~~~~~~~~~~~
> >    cc1: all warnings being treated as errors
> >
> > Cc: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   net/vhost-vdpa.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 34202ca009..7eaee841aa 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -1352,7 +1352,7 @@ static NetClientState *net_vhost_vdpa_init(NetCli=
entState *peer,
> >       VhostVDPAState *s;
> >       int ret =3D 0;
> >       assert(name);
> > -    int cvq_isolated;
> > +    int cvq_isolated =3D 0;
> >
> >       if (is_datapath) {
> >           nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, device=
,
>
> Alternatively:
>
> -- >8 --
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 34202ca009..218fe0c305 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1352,13 +1352,12 @@ static NetClientState
> *net_vhost_vdpa_init(NetClientState *peer,
>       VhostVDPAState *s;
>       int ret =3D 0;
>       assert(name);
> -    int cvq_isolated;
>
>       if (is_datapath) {
>           nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
>                                    name);
>       } else {
> -        cvq_isolated =3D vhost_vdpa_probe_cvq_isolation(vdpa_device_fd,
> features,
> +        int cvq_isolated =3D
> vhost_vdpa_probe_cvq_isolation(vdpa_device_fd, features,
>                                                         queue_pair_index
> * 2,
>                                                         errp);
>           if (unlikely(cvq_isolated < 0)) {
> @@ -1391,7 +1390,7 @@ static NetClientState
> *net_vhost_vdpa_init(NetClientState *peer,
>
>           s->vhost_vdpa.shadow_vq_ops =3D &vhost_vdpa_net_svq_ops;
>           s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
> -        s->cvq_isolated =3D cvq_isolated;
> +        s->cvq_isolated =3D true;

This is incorrect because the return value of
vhost_vdpa_probe_cvq_isolation() is -errno for errors, 0 for no cvq
isolation, and 1 for cvq isolation. A variable is still needed to
distinguish between no cvq isolation and cvq isolation.

>
> ---
>
> Whichever you prefer:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>

