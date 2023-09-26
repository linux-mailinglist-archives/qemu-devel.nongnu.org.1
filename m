Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B527AEFFA
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAIc-00008y-Ka; Tue, 26 Sep 2023 11:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qlAID-0008T7-J1
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:48:09 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qlAI5-000563-Fj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:48:09 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-418025bf4d6so35576531cf.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695743278; x=1696348078; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ai7lXObMnxhy9bvcI1TdDQKhjFvW7gMIHhLHtjwCfUk=;
 b=UtzzHXsR7pohhGY7jEqlrQyIh/RSiLJD2D1zotvRnK8MSwj090atUQsVhzBKk+NFxC
 5hm73GnSmme6McSScTFyTokSukVICVY13MVnEl6LM0IksTACwp8l9bWD3DxRxlcwIyx/
 +hem1UulzaflWqAF96TPGqN/ejdx/cgoFZd3c+bQRluvlNbjTWgTtOyHYDvLHMJLIx90
 fPgBb4jKFw0cdJom0BMLX/dJexKiMn3j5AlizqgERzTr2u5e+/kYurVJnE5MlomZ0/jO
 /tXcQcKIxwUMobhmTLEuxIfQQmVZ4Efh8Esr6xPt8PIsNCkk1Ej/XCgI4jgiQ2hpbaOB
 ZYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695743278; x=1696348078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ai7lXObMnxhy9bvcI1TdDQKhjFvW7gMIHhLHtjwCfUk=;
 b=NE1QutqQ7Pa6mcvhVbkWt9rXiV1WDtyZcGaH24vW6NTaR5GwC0O74vASAqqFre5NXx
 PdfXQgXIMGkvlKOmuenjWyhFBws3OflauvvuaFK/3q91rkU7rujbyPNebsSduDNsvvs9
 oRNYkmbHAF2nYHy2Vi0qXckcecuyfuDagc9Y1lluxYCa3Y6yV/23yXNKlvRHt2l1f8sS
 27teP/rg88lMpeJwfmWolvGRAEhwhkSWnyFwb9RqVPGRPUsgX7ZMMoLhhQAbbn5NhLKh
 CZ3mug8FUlSsIYt5nOOEPoZkRWZKLtWseSER4mIGgGo2JRWea5/5OmLjIQKBI9oQgVQo
 OFFw==
X-Gm-Message-State: AOJu0YwSsatZrPxhe31ikyMmn093fB59T3g46Uhl0ySN+wrqyPPMV9ki
 W8nq8kwa9dlTWtPYlpcMB/TWQWd7ZirP55kwhjg=
X-Google-Smtp-Source: AGHT+IF6VXNydP5P20fLyuAbLEAuC2BZO/lleuAqIeE8P+DYgH3J1iQO6A93c54oDPD9Sr3oHdxXA3fUdJnDvXEu/Bk=
X-Received: by 2002:a05:622a:1007:b0:406:9466:6962 with SMTP id
 d7-20020a05622a100700b0040694666962mr10211672qte.61.1695743278361; Tue, 26
 Sep 2023 08:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230926144149.715750-1-pbonzini@redhat.com>
In-Reply-To: <20230926144149.715750-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Sep 2023 19:47:47 +0400
Message-ID: <CAJ+F1CK95hk-5BUiU2JyE4Y7J9z8KS305r_B391prjVLp9m=UQ@mail.gmail.com>
Subject: Re: [PATCH] make-release: do not ship dtc sources
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

On Tue, Sep 26, 2023 at 6:43=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> A new enough libfdt is included in all of Debian 11, Ubuntu 20.04
> and MSYS2.  It has also been included for several minor releases
> in Fedora and openSUSE Leap, as well as in CentOS.  Therefore
> there is no need anymore to ship the sources together with the QEMU
> tarballs.
>
> Keep the wrap file so that it can be used with --enable-download,
> but do not ship the sources anymore with either archive-source.sh
> or make-release.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build               | 3 +++
>  scripts/archive-source.sh | 2 +-
>  scripts/make-release      | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 5139db2ff7c..81430ce2348 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3070,6 +3070,9 @@ if fdt_required.length() > 0 or fdt_opt =3D=3D 'ena=
bled'
>    endif
>
>    if fdt_opt in ['enabled', 'auto', 'system']
> +    if get_option('wrap_mode') =3D=3D 'nodownload'
> +      fdt_opt =3D 'system'
> +    endif
>      fdt =3D cc.find_library('fdt', required: fdt_opt =3D=3D 'system')
>      if fdt.found() and cc.links('''
>         #include <libfdt.h>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 48996304910..65af8063e4b 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -26,7 +26,7 @@ sub_file=3D"${sub_tdir}/submodule.tar"
>  # independent of what the developer currently has initialized
>  # in their checkout, because the build environment is completely
>  # different to the host OS.
> -subprojects=3D"dtc keycodemapdb libvfio-user berkeley-softfloat-3 berkel=
ey-testfloat-3"
> +subprojects=3D"keycodemapdb libvfio-user berkeley-softfloat-3 berkeley-t=
estfloat-3"
>  sub_deinit=3D""
>
>  function cleanup() {
> diff --git a/scripts/make-release b/scripts/make-release
> index c5db87b3f91..9c570b87f4a 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -17,7 +17,7 @@ if [ $# -ne 2 ]; then
>  fi
>
>  # Only include wraps that are invoked with subproject()
> -SUBPROJECTS=3D"dtc libvfio-user keycodemapdb berkeley-softfloat-3 berkel=
ey-testfloat-3"
> +SUBPROJECTS=3D"libvfio-user keycodemapdb berkeley-softfloat-3 berkeley-t=
estfloat-3"
>
>  src=3D"$1"
>  version=3D"$2"
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

