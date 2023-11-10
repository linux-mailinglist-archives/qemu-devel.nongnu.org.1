Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D847E79FD
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 09:12:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1MbZ-0006C1-SE; Fri, 10 Nov 2023 03:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r1MbX-00068g-O6
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r1MbU-0005zh-Tq
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699603859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hmuVvK4HAM6KfyCPk18Axnq2ITLlTdNtdjgzJQRckg=;
 b=UpihVS63sIyy3YYoAjVnlMrJdBo/E72icEIKSHaQLh1eF1wF83Y7tDRHlvziJ+LLgJA1ZX
 qeO3/W82KlqjhFKty9XjEVM3OqYKfnVoCYm1hlpTjThCbA4EsLoM7Sv0cJkLdyC2j2Fp9S
 4VQKlWoszmsiVpu0y5d5x+d/ua2ZL9Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-l21sWaTVPQ2Bvy2CTvn2Ww-1; Fri, 10 Nov 2023 03:10:58 -0500
X-MC-Unique: l21sWaTVPQ2Bvy2CTvn2Ww-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9dd58f582a0so141066666b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 00:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699603856; x=1700208656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hmuVvK4HAM6KfyCPk18Axnq2ITLlTdNtdjgzJQRckg=;
 b=WL61sYhmso4zquJrUGB7HIo0My9tzHnegdlpPZigCaQB9372snLXoVDAyvRo5Fh8YO
 VSs8jlg1MMCJXPDMQukymXgmfiBaHoN5fYdtWoHGTnxP7aSRRZcsS5traqlal3lss3EH
 z/SIwtdHAAVnJdotGuX3Q9O+uk8HT4JMG4f2VUOUp5u4k2YJ89fIWy2eGoDZ9YI+ZByl
 N0JmgpT8qai354c0AFde+EiVm04sslgbAiswRGQVs5tOBOOkzC9qbEhzY4AqirCVM8In
 uD2cGKbenHIONP1YjnFaeeHXfWSLXRgNoJ6SO4NfsM/togHyDoZpZZ9ZNODRhBBSeGp5
 TgqA==
X-Gm-Message-State: AOJu0YxwPQ4BBYMPj6Bwlr8eCTngvBiameUHBfUHTk/8vreWksjecPfg
 5YsMmemt9rvIcROnUrYaBhtX2czcMRZZAYiPdY0hwQsYuSYPPlpbBRHz214DGZ4Injj2zLqB3EU
 ItI4tMJ24GAjF1qBjENd1hXdalHZRGeKQdTTaZPo=
X-Received: by 2002:a50:c352:0:b0:53e:782f:cfa6 with SMTP id
 q18-20020a50c352000000b0053e782fcfa6mr5194639edb.37.1699603855963; 
 Fri, 10 Nov 2023 00:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/OFH2FZB6Gjp9eX3mweEYVFMzd5UlhC9m0CKkmy9iKtKhGuy/hNOvZtpXV8hDplzCsv8DvSDh8iDCYteeRNo=
X-Received: by 2002:a50:c352:0:b0:53e:782f:cfa6 with SMTP id
 q18-20020a50c352000000b0053e782fcfa6mr5194625edb.37.1699603855631; Fri, 10
 Nov 2023 00:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20231108133719.113217-1-marcandre.lureau@redhat.com>
In-Reply-To: <20231108133719.113217-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Nov 2023 12:10:44 +0400
Message-ID: <CAMxuvaxtia3Bnojgm4Txx8AkT1EjA6_hF=Yj=N1a42AnjJmLmQ@mail.gmail.com>
Subject: Re: [PATCH] ui/console: fix default VC when there are no display
To: qemu-devel@nongnu.org, gmaglione@redhat.com
Cc: pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Nov 8, 2023 at 5:37=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> When display is "none", we may still have remote displays (I think it
> would be simpler if VNC/Spice were regular display btw). Return the
> default VC then, and set them up to fix a regression when using remote
> display and it used the TTY instead.
>
> Fixes: commit 1bec1cc0d ("ui/console: allow to override the default VC")
> Reported-by: German Maglione <gmaglione@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

German, did you file an issue on gitlab? Could you check/test this patch?

thanks

> ---
>  system/vl.c  |  4 +++-
>  ui/console.c | 14 ++++++++------
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index bd7fad770b..8c522a07da 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1359,6 +1359,7 @@ static void qemu_setup_display(void)
>              dpy.type =3D DISPLAY_TYPE_NONE;
>  #if defined(CONFIG_VNC)
>              vnc_parse("localhost:0,to=3D99,id=3Ddefault");
> +            display_remote++;
>  #endif
>          }
>      }
> @@ -1391,7 +1392,8 @@ static void qemu_create_default_devices(void)
>          }
>      }
>
> -    if (nographic || (!vc && !is_daemonized() && isatty(STDOUT_FILENO)))=
 {
> +    if (nographic ||
> +        ((!display_remote || !vc) && !is_daemonized() && isatty(STDOUT_F=
ILENO))) {
>          if (default_parallel) {
>              add_device_config(DEV_PARALLEL, "null");
>          }
> diff --git a/ui/console.c b/ui/console.c
> index 8e688d3569..f08c8365b0 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1679,19 +1679,21 @@ void qemu_display_init(DisplayState *ds, DisplayO=
ptions *opts)
>
>  const char *qemu_display_get_vc(DisplayOptions *opts)
>  {
> +#ifdef CONFIG_PIXMAN
> +    const char *vc =3D "vc:80Cx24C";
> +#else
> +    const char *vc =3D NULL;
> +#endif
> +
>      assert(opts->type < DISPLAY_TYPE__MAX);
>      if (opts->type =3D=3D DISPLAY_TYPE_NONE) {
> -        return NULL;
> +        return vc;
>      }
>      assert(dpys[opts->type] !=3D NULL);
>      if (dpys[opts->type]->vc) {
>          return dpys[opts->type]->vc;
> -    } else {
> -#ifdef CONFIG_PIXMAN
> -        return "vc:80Cx24C";
> -#endif
>      }
> -    return NULL;
> +    return vc;
>  }
>
>  void qemu_display_help(void)
> --
> 2.41.0
>


