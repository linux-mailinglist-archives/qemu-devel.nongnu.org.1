Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2077CB0E5
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 19:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQy8-0003xV-JP; Mon, 16 Oct 2023 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qsQxn-0003pm-Qe
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 13:01:08 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qsQxi-0000zX-PN
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 13:01:07 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9be3b66f254so401246466b.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1697475658; x=1698080458;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CECr3R7l9X0fzW2sz6jBGmGM27qaeqeVydCyXSY1P/M=;
 b=iei0YPtseMwyCIN6+RxBrm0RL7U3P6dHztZlBOO/iMfYg97kLwI2rSW6tV3/u2qM4B
 FaQI2oX/gJ7+y6L2dZ35eR4rJMxurCpHEobXt10QLCVhKaPb5mNeAgW1ZSvvPavP5HYi
 Cg4JwCvJLFRcifz6RxIyN4f8QXx97ug3Ercb+/hF9zM780pRFoRGNg2Ve20QjGeT8a7n
 XlIRgNyspDhvkXM7a95sq1bTBETYFAgoojuPB6eztxCS7xzDKRdrk6BYk0JrxCIMz4uY
 TGMxssEzwrWE1pxe3+0IE1WKt5zoINuvdtPIA03GLc2ZRJ8L0nrcgz97giE4oAe3E16A
 IRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697475658; x=1698080458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CECr3R7l9X0fzW2sz6jBGmGM27qaeqeVydCyXSY1P/M=;
 b=oxlg8/h7UATizBIx/eKj7F2BpRjdNCjvLyYUz7GWU2uY+RgBp3d5cOgRkfYc+2499G
 mTgLnIDeGM4ezLT7tRJbyIqQtMmWeda3LfiE9B7kl7EKfl5UoSAaVBlwBnE0UGH/4jqW
 VJj1lViq9hJwMzADHp9HtVUgLNS/ZJbk28ag/3p27capJenV1hztWpMooL7OZyJGG0In
 PcclJorakBvOGPKgTPHRVPKKQk34TEypKiIbSa5j+NR7arsTQf13xWJzjK36x60JxXU6
 xgVTceQkE0bPIYbZYkDDlOBv+jWrBWYr7JcFBroeAuOZP0ptImYIkZ9X23FFYBSnlkDi
 5JXg==
X-Gm-Message-State: AOJu0YwBBfkyAPQ4ovAThLO2osUuKVuBrbFD2CZEvZ+rezYlLD1TOOB3
 RY2lDLweuSmnJ0oRHcsBiYJStRfykfbrfjTDmAGCugL1q0mt/FXyl1s=
X-Google-Smtp-Source: AGHT+IFm1eg2YJZyBojB0Bn3SDZHiEmRNCVU8Mj9pzL142pj9f2lsxD07+f6Llq5WlxhSoCoxtpOfUYQy1Dx76cFC+Q=
X-Received: by 2002:a17:907:77c9:b0:9b2:6d09:847c with SMTP id
 kz9-20020a17090777c900b009b26d09847cmr27562730ejc.10.1697475658257; Mon, 16
 Oct 2023 10:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231016161053.39150-1-thuth@redhat.com>
In-Reply-To: <20231016161053.39150-1-thuth@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 16 Oct 2023 11:00:46 -0600
Message-ID: <CANCZdfquj7K6ED0SWC1v+wQOPLmXYVBbf4n37gS0nEuGemaaGA@mail.gmail.com>
Subject: Re: [PATCH] tests/vm/freebsd: Add additional library paths for libfdt
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Kyle Evans <kevans@freebsd.org>, 
 Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: multipart/alternative; boundary="000000000000a040b50607d859f6"
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000a040b50607d859f6
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 16, 2023, 10:11 AM Thomas Huth <thuth@redhat.com> wrote:

> libfdt is installed in /usr/local on FreeBSD, and since this
> library does not have a pkg-config file, we have to specify the
> paths manually. This way we can avoid that Meson has to recompile
> the dtc subproject each time.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/vm/freebsd | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index ac51376c82..b581bd17fb 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -38,8 +38,9 @@ class FreeBSDVM(basevm.BaseVM):
>          cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
>          mkdir src build; cd src;
>          tar -xf /dev/vtbd1;
> -        cd ../build
> -        ../src/configure --python=python3.9 {configure_opts};
> +        cd ../build;
> +        ../src/configure --python=python3.9
> --extra-ldflags=-L/usr/local/lib \
> +                         --extra-cflags=-I/usr/local/include
> {configure_opts};
>          gmake --output-sync -j{jobs} {target} {verbose};
>      """
>
> --
> 2.41.0
>
>

--000000000000a040b50607d859f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Oct 16, 2023, 10:11 AM Thomas Huth &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">libfdt is installed in /usr/local on FreeBSD, and=
 since this<br>
library does not have a pkg-config file, we have to specify the<br>
paths manually. This way we can avoid that Meson has to recompile<br>
the dtc subproject each time.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/vm/freebsd | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: Warner Lo=
sh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
diff --git a/tests/vm/freebsd b/tests/vm/freebsd<br>
index ac51376c82..b581bd17fb 100755<br>
--- a/tests/vm/freebsd<br>
+++ b/tests/vm/freebsd<br>
@@ -38,8 +38,9 @@ class FreeBSDVM(basevm.BaseVM):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd $(mktemp -d /home/qemu/qemu-test.XXXXX=
X);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir src build; cd src;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar -xf /dev/vtbd1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cd ../build<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ../src/configure --python=3Dpython3.9 {configu=
re_opts};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cd ../build;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ../src/configure --python=3Dpython3.9=C2=A0 --=
extra-ldflags=3D-L/usr/local/lib \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0--extra-cflags=3D-I/usr/local/include {configure_opts};<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gmake --output-sync -j{jobs} {target} {ve=
rbose};<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div></div>

--000000000000a040b50607d859f6--

