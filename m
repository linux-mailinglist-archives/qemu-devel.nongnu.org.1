Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313A737BE6
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBrx0-00014G-9q; Wed, 21 Jun 2023 03:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBrwy-00013V-1T
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBrwv-0006n2-SF
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687331296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guajjWA0E41jSktTFHRwPYzg0aHi5JVRDO2nkZp+v4g=;
 b=JVtHbB4Io0M6Z/ab/zCb2f1r0Hytb/zwvnmyZE56uLOpBVlZkacgrJNHmiAfoWt5eiyGBu
 5N9ojqxcEV9bvsancXtrMblM7xPt5iU1VTakl4MXIRgkdUjQCUoWTLIHZ6466Qf7fGkxkZ
 tm1xa/FLgUF7BmAJ1QfBQJby4KPlQJ4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-NFnxGxzHOdqr0gmUv536Zw-1; Wed, 21 Jun 2023 03:08:14 -0400
X-MC-Unique: NFnxGxzHOdqr0gmUv536Zw-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-440bc497ef7so658253137.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 00:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687331292; x=1689923292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=guajjWA0E41jSktTFHRwPYzg0aHi5JVRDO2nkZp+v4g=;
 b=ccEZe1P6r0W72FfNGbP8nqk2RCtNqj0hgRWgoDxsPouQDd4aHx5ErZ1wjM5pkr8OvW
 GX1DGCHaK8bSpBihZFS0iXT9pAJcqkZKDxIhK2ur4xnqvkABWbxmg++FsEmcJHSGyIt5
 NCm0+lxroCgB11dqMQDMyFIdNtvfR0Y0IFUv+i/+fM8rUiPdR4KEpZHnIkdPrsSmJJd7
 Uwjias7v5HF2M0+WlBzs4OhrdlPqHxK75hy/jRmYbaxS+aLdBHUsJahPdUz6TKmNdeVz
 2iw7wXTbt8mkEoOGLN3R0FAe8N8fil4trzw0Zo//5g4oHgdrDROV77G6uQ2p5NKivWrc
 2L+A==
X-Gm-Message-State: AC+VfDwMR1/r9aunD6UcCuVLSbkP9zl8e3y1Cy/Q2nYfmXa7nlYQUA5s
 82TmkY8dhB22aVp58eidoGGQzjqbJStGAJX/4Kj5ZNJ6iHFtoxbZVpTlLqH4NNIar8HU7BVadQI
 3jy/bIz+7y21QyQIiYuWHq/L0jb9Gzuk=
X-Received: by 2002:a67:de81:0:b0:43f:4714:a03b with SMTP id
 r1-20020a67de81000000b0043f4714a03bmr6036821vsk.17.1687331292583; 
 Wed, 21 Jun 2023 00:08:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6LP9jbx4etZ1ryFHRkkEbqAiuZ/wOjr+vgmMuqXHYSrnvBD6TqPu1LAO89iF28X+a2WBe/+Y4+v6qSYhGeDaU=
X-Received: by 2002:a67:de81:0:b0:43f:4714:a03b with SMTP id
 r1-20020a67de81000000b0043f4714a03bmr6036809vsk.17.1687331292314; Wed, 21 Jun
 2023 00:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230621002121.1609612-1-jsnow@redhat.com>
In-Reply-To: <20230621002121.1609612-1-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 Jun 2023 09:08:01 +0200
Message-ID: <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Switch iotests to pyvenv
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004c139a05fe9e6e90"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--0000000000004c139a05fe9e6e90
Content-Type: text/plain; charset="UTF-8"

Il mer 21 giu 2023, 02:21 John Snow <jsnow@redhat.com> ha scritto:

> Hi, this is ... a fairly incomplete series about trying to get iotests
> to run out of the configure-time venv. I'm looking for some feedback, so
> out to the list it goes.
>
> Primarily, I'm having doubts about these points:
>
> 1) I think I need something like "mkvenv install" in the first patch,
>    but mkvenv.py is getting pretty long...
>

It's not a lot of code, but using pip install from configure might also be
good enough, I don't know.

2) Is there a way to optimize the speed for patch #2? Maybe installing

   this package can be skipped until it's needed, but that means that
>    things like iotest's ./check might get complicated to support that.
>
> 3) I cheated quite a bit in patch 4 to use the correct Python to launch
>    iotests, but I'm wondering if there's a nicer way to solve this
>    more *completely*.
>

Maybe patch 4 can use distlib.scripts as well to create the check script in
the build directory? (Yes that's another mkvenv functionality...) On a
phone and don't have the docs at hand, so I am not sure. If not, your
solution is good enough.

Apart from this the only issue is the speed. IIRC having a prebuilt .whl
would fix it, I think for Meson we observed that the slow part was building
the wheel. Possibilities:

1) using --no-pep517 if that also speeds it up?

2) already removing the sources to qemu.qmp since that's the plan anyway;
and then, if you want editability you can install the package with --user
--editable, i.e. outside the venv

Paolo


> John Snow (6):
>   experiment: add mkvenv install
>   build, tests: Add qemu in-tree packages to pyvenv at configure time.
>   iotests: get rid of '..' in path environment output
>   iotests: use the correct python to run linters
>   iotests: use pyvenv/bin/python3 to launch child test processes
>   iotests: don't add qemu.git/python to PYTHONPATH
>
>  configure                     | 31 +++++++++++++++++++++++++++
>  python/scripts/mkvenv.py      | 40 +++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/linters.py |  2 +-
>  tests/qemu-iotests/testenv.py | 21 ++++++++++++------
>  4 files changed, 87 insertions(+), 7 deletions(-)
>
> --
> 2.40.1
>
>
>

--0000000000004c139a05fe9e6e90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 21 giu 2023, 02:21 John Snow &lt;<a href=3D"mai=
lto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Hi, this is ... a fairly incomplete series about tr=
ying to get iotests<br>
to run out of the configure-time venv. I&#39;m looking for some feedback, s=
o<br>
out to the list it goes.<br>
<br>
Primarily, I&#39;m having doubts about these points:<br>
<br>
1) I think I need something like &quot;mkvenv install&quot; in the first pa=
tch,<br>
=C2=A0 =C2=A0but mkvenv.py is getting pretty long...<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s not a lot of c=
ode, but using pip install from configure might also be good enough, I don&=
#39;t know.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
2) Is there a way to optimize the speed for patch #2? Maybe installing</blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0this package can be skipped until it&#39;s needed, but that me=
ans that<br>
=C2=A0 =C2=A0things like iotest&#39;s ./check might get complicated to supp=
ort that.<br>
<br>
3) I cheated quite a bit in patch 4 to use the correct Python to launch<br>
=C2=A0 =C2=A0iotests, but I&#39;m wondering if there&#39;s a nicer way to s=
olve this<br>
=C2=A0 =C2=A0more *completely*.<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Maybe patch 4 can use distlib.scripts as wel=
l to create the check script in the build directory? (Yes that&#39;s anothe=
r mkvenv functionality...) On a phone and don&#39;t have the docs at hand, =
so I am not sure. If not, your solution is good enough.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Apart from this the only issue is the speed=
. IIRC having a prebuilt .whl would fix it, I think for Meson we observed t=
hat the slow part was building the wheel. Possibilities:</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">1) using --no-pep517 if that also speeds i=
t up?</div><div dir=3D"auto"><br></div><div dir=3D"auto">2) already removin=
g the sources to qemu.qmp since that&#39;s the plan anyway; and then, if yo=
u want editability you can install the package with --user --editable, i.e.=
 outside the venv</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo<=
br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
John Snow (6):<br>
=C2=A0 experiment: add mkvenv install<br>
=C2=A0 build, tests: Add qemu in-tree packages to pyvenv at configure time.=
<br>
=C2=A0 iotests: get rid of &#39;..&#39; in path environment output<br>
=C2=A0 iotests: use the correct python to run linters<br>
=C2=A0 iotests: use pyvenv/bin/python3 to launch child test processes<br>
=C2=A0 iotests: don&#39;t add qemu.git/python to PYTHONPATH<br>
<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 31 +++++++++++++++++++++++++++<br>
=C2=A0python/scripts/mkvenv.py=C2=A0 =C2=A0 =C2=A0 | 40 +++++++++++++++++++=
++++++++++++++++<br>
=C2=A0tests/qemu-iotests/linters.py |=C2=A0 2 +-<br>
=C2=A0tests/qemu-iotests/testenv.py | 21 ++++++++++++------<br>
=C2=A04 files changed, 87 insertions(+), 7 deletions(-)<br>
<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000004c139a05fe9e6e90--


