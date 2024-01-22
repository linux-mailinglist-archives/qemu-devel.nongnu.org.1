Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D83835CE0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 09:42:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRpry-0006Nh-0V; Mon, 22 Jan 2024 03:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rRprh-0006Ke-Ge
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:41:10 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rRprg-0005ih-1A
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:41:09 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-429915eefa5so20662671cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 00:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705912867; x=1706517667; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTpqQpK/d1Oo7SY8Sg/cqZiMJrn3HKctPhkhbjrYtMo=;
 b=ehB6PjFPkNkL+HJyABKHQNoovd65mF7exILOAGTRYgfq9HpRwHEkWhDv8/QdV2jprs
 F7usq2byVWNeo6ZUTc4FmJqbtzAsF/qhMebwyrbEU/mG8ZsI+0Vu7ewQQKRp6mUhdlw1
 2cM3vP3PYUqVfW5ZoJPNjWQmvadaZVk0Go8FTzSJfFt7PcFJK40dhMRQ31NH2qjlMsT6
 2FYZdylrJiEtdFkHWr7l05vkuAZle2h5CHPBfaMJdbp3FmKUAFUs3FxOiYXMIjrZv+q2
 Idzg4tTiXfPGHf0KHsWc4im01geK72pfxwPXzbJ9qb3Ez3ckkwCs+nOsGC2vhuMws50n
 I2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705912867; x=1706517667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTpqQpK/d1Oo7SY8Sg/cqZiMJrn3HKctPhkhbjrYtMo=;
 b=FGZjw1GUNXbvWAj6RjQbrkNRP/1w1XSI+z0ESxUGh+1IHvBZRaezP/JEmqEfnuuRgB
 S22gHj6RCSctEP2ZVLyFlXUTkev9WNFMtuaz2sYMhrjgUCMH5O8Gy6Ie1Q9aBIQgpT+R
 LBcFyeo8Qp/ub05V/WVCJpCZYEgLgQ5UuhSLG+uuPmlPlR+eKHdsBRcyK90eGluTx78L
 3u3Xi4qwa3KOFK7FLNMr88LkZP2Nok5IkPydnxBESJ/QYXm4R5shaYKXlLwkNdfLySZD
 kMqvGTI+eolZqlWEpjp5YHjSgUZogO3ycRFn9C/OzkmyPL3mwd+wEDFKok/+RJ8s7kp6
 QwaA==
X-Gm-Message-State: AOJu0Ywl/KrNJU/soimMbzh6xMLMpc7m5yrV6kLzzEZMrm+FExoCGTaX
 d3thlNGB8/Q0gP5EgxjeLSduT08i/HmClv2BaVUD1HzIop/rVPhbtYXHj42rCosjuqmPWPUdOMq
 tVgEKaZ6FSR/kobhwtIk6kY8v+/Y=
X-Google-Smtp-Source: AGHT+IEB7lX+uTdHnTvkc1I8j+qaG7n110SJWwctbMnGcJNrdphRLtwroJWXhdd4i+5+Rp8vwqc/kmiHkHSuxJMkWJY=
X-Received: by 2002:ac8:5acb:0:b0:42a:3090:e7fb with SMTP id
 d11-20020ac85acb000000b0042a3090e7fbmr4607281qtd.3.1705912867022; Mon, 22 Jan
 2024 00:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
 <20240120003013.1829757-3-vivek.kasireddy@intel.com>
In-Reply-To: <20240120003013.1829757-3-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jan 2024 12:40:56 +0400
Message-ID: <CAJ+F1CJ2TC+jMjGovWo==CAJJz0RKdo-=UG-3h92uJf7OOUNaw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] ui/spice: Enable gl=on option for non-local or
 remote clients
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
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

On Sat, Jan 20, 2024 at 4:54=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
> Newer versions of Spice server should be able to accept dmabuf
> fds from Qemu for clients that are connected via the network.
> In other words, when this option is enabled, Qemu would share
> a dmabuf fd with Spice which would encode and send the data
> associated with the fd to a client that could be located on
> a different machine.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  include/ui/spice-display.h | 1 +
>  ui/spice-core.c            | 4 ++++
>  ui/spice-display.c         | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
> index e1a9b36185..f4922dd74b 100644
> --- a/include/ui/spice-display.h
> +++ b/include/ui/spice-display.h
> @@ -151,6 +151,7 @@ struct SimpleSpiceCursor {
>  };
>
>  extern bool spice_opengl;
> +extern bool remote_client;
>
>  int qemu_spice_rect_is_empty(const QXLRect* r);
>  void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 13bfbe4e89..3b9a54685f 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -849,9 +849,13 @@ static void qemu_spice_init(void)
>  #ifdef HAVE_SPICE_GL
>      if (qemu_opt_get_bool(opts, "gl", 0)) {
>          if ((port !=3D 0) || (tls_port !=3D 0)) {
> +#if SPICE_SERVER_VERSION >=3D 0x000f03 /* release 0.15.3 */

(ok, we should wait for the Spice series to be merged)


> +            remote_client =3D 1;
> +#else
>              error_report("SPICE GL support is local-only for now and "
>                           "incompatible with -spice port/tls-port");
>              exit(1);
> +#endif
>          }
>          egl_init(qemu_opt_get(opts, "rendernode"), DISPLAYGL_MODE_ON, &e=
rror_fatal);
>          spice_opengl =3D 1;
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 6eb98a5a5c..384b8508d4 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -29,6 +29,7 @@
>  #include "ui/spice-display.h"
>
>  bool spice_opengl;
> +bool remote_client;
>
>  int qemu_spice_rect_is_empty(const QXLRect* r)
>  {
> --
> 2.39.2
>
>


--
Marc-Andr=C3=A9 Lureau

