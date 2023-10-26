Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C067D7C97
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 07:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvtKY-0005z0-8i; Thu, 26 Oct 2023 01:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qvtKW-0005ys-Ee
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:54:52 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qvtKU-0002M3-Qo
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:54:52 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so613856e87.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 22:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1698299689; x=1698904489;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nyCzLL/llvF68HgcFLBhILTQwvO5BpIHHJFA5CEUEtQ=;
 b=USEnRYBUdILqgmKq5/gU1TDIOuV4PMwu2kmv1Bv/t1EzHreT6mzoVKGxnLd4WWkHx6
 idHUy4j/SGKcefohsFI2LYNDlkwAFttrdOH6JH2R2Xey348sja1mYvciJx/Mvgtd3qZ1
 xj9hfjkmixqjF37DGNUmNlEWcNe/wGBaJDZwXFJzwRQABTQb2rKC+yiHDtBExHfntEGs
 XpyfpwQvvzbd69aRogDp6a5FZbCY9dE1KJ7Gtqqq/E5G5LIFe3Ri93utp8oWqxhUVfil
 kBwYuhDi0NxgKnn82XHqgKbxp6XzgZaYhXIs4wtye7iX7PRB/KtUQZQOW340CXMICOHK
 TqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698299689; x=1698904489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nyCzLL/llvF68HgcFLBhILTQwvO5BpIHHJFA5CEUEtQ=;
 b=FJUBvKfvOBGH4CTAhIZ1Xf/rwUh/2w5dpsdM3HGe4mscFoZWdKBKXVa4rHNQSsX9Tk
 2bDW2uXpX1tn5mERgDalrWM4x+pAHoPEesEXNxynpbXq4Du8zJHqzjlnDRpITW7XjZoB
 aitA7KBnRgdVfuMu1JxbOmpFCDF9mRBpDvMVnZSwJpIS7OWbl7A/dLuQTQiVW8xZ4vc/
 sjUpyRZAilbJADVHt+Bn+TUyRjZeisctY88tOw6Ppq0Ln032mAo09XxQ16lgdLLfVXCv
 Dj1B43G1cKSgeqvJiI+Ju0pc4u/JKADYm1WUCt8M9/AYH0kNpFiH50irXcJQBrVfdVgD
 7FpQ==
X-Gm-Message-State: AOJu0YzhKXsopFZ4H/M6euJg8NwYC7W1xfwjJmfGFKUmXUJbXM0qC+ps
 mcnqEfsMFM7PvS1HdkC7KprnZRjszA4qCnyXtK6OsA==
X-Google-Smtp-Source: AGHT+IEew9l7UVTmjBTcJzCEo8c6NRFkGPnMmncvsfCywVKW026zLM+dkR0sPjkq+YD8d31GxbG/CUlpMFkn4WWOJwg=
X-Received: by 2002:a19:2d5d:0:b0:4f8:77db:1d9e with SMTP id
 t29-20020a192d5d000000b004f877db1d9emr12274673lft.12.1698299688603; Wed, 25
 Oct 2023 22:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231026053115.2066744-1-armbru@redhat.com>
In-Reply-To: <20231026053115.2066744-1-armbru@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 25 Oct 2023 23:54:37 -0600
Message-ID: <CANCZdfrdZDY=ndd_RGdWMb5qtZ8+vQJUOQrA=We2X8gF6yzBOQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Enable -Wshadow=local
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Brian Cain <bcain@quicinc.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a9712a060898358d"
Received-SPF: none client-ip=2a00:1450:4864:20::12b;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12b.google.com
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

--000000000000a9712a060898358d
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 25, 2023, 11:31 PM Markus Armbruster <armbru@redhat.com> wrote:

> Requires Brian's pull request and two patches from Thomas to compile:
>
>     [PULL 0/2] hex queue - GETPC() fixes, shadowing fixes
>     [PATCH v2] block/snapshot: Fix compiler warning with -Wshadow=local
>     [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
>
> Stefan, the PR was posted a week ago; anything blocking it?
>
> Warner, I believe not waiting for your cleanup of bsd-user is fine.
> Please holler if it isn't.
>

If it's not enabled by default for Clang, then sure. It's only one small
change at this point, but i was ill for a few weeks (much longer than i
thought I'd be) and am still catching up.

Warner

 <20231019021733.2258592-1-bcain@quicinc.com>

> Based-on: <20231023175038.111607-1-thuth@redhat.com>
> Based-on: <20231024092220.55305-1-thuth@redhat.com>
>
> Markus Armbruster (1):
>   meson: Enable -Wshadow=local
>
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> --
> 2.41.0
>
>

--000000000000a9712a060898358d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 25, 2023, 11:31 PM Markus Armbruster &lt;<=
a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Requires Brian&#39;s pull request and two=
 patches from Thomas to compile:<br>
<br>
=C2=A0 =C2=A0 [PULL 0/2] hex queue - GETPC() fixes, shadowing fixes<br>
=C2=A0 =C2=A0 [PATCH v2] block/snapshot: Fix compiler warning with -Wshadow=
=3Dlocal<br>
=C2=A0 =C2=A0 [PATCH v2] migration/ram: Fix compilation with -Wshadow=3Dloc=
al<br>
<br>
Stefan, the PR was posted a week ago; anything blocking it?<br>
<br>
Warner, I believe not waiting for your cleanup of bsd-user is fine.<br>
Please holler if it isn&#39;t.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">If it&#39;s not enabled by default for Clang,=
 then sure. It&#39;s only one small change at this point, but i was ill for=
 a few weeks (much longer than i thought I&#39;d be) and am still catching =
up.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Warner</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">=C2=A0&lt;<a href=3D"mailto:202310190=
21733.2258592-1-bcain@quicinc.com" target=3D"_blank" rel=3D"noreferrer">202=
31019021733.2258592-1-bcain@quicinc.com</a>&gt;</div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Based-on: &lt;<a href=3D"mailto:20231023175038.111607-1-thuth@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">20231023175038.111607-1-thuth@redhat.co=
m</a>&gt;<br>
Based-on: &lt;<a href=3D"mailto:20231024092220.55305-1-thuth@redhat.com" ta=
rget=3D"_blank" rel=3D"noreferrer">20231024092220.55305-1-thuth@redhat.com<=
/a>&gt;<br>
<br>
Markus Armbruster (1):<br>
=C2=A0 meson: Enable -Wshadow=3Dlocal<br>
<br>
=C2=A0meson.build | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div></div>

--000000000000a9712a060898358d--

