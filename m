Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C3837388
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:09:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS0b9-00031B-RC; Mon, 22 Jan 2024 15:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cr@cristianrodriguez.net>)
 id 1rS0b4-00030t-Ah
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:08:42 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cr@cristianrodriguez.net>)
 id 1rS0as-00057L-6c
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:08:39 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4bd29882f96so9728e0c.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rodriguez.im; s=google; t=1705954108; x=1706558908; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yudmI3Xyazx+JwbrnJNDAmTy82Pmo/8KeGZqzCu8ZDI=;
 b=F1c6lFXk8D/8/QmH/TAtESDs1LZ+iPl33PVOfI0u6dEbdbiJQsQyOa2fYBc3Qn/kWX
 1dx0dOPyKyfY0/7ZOhquWZn2HkviFeT8eeiL1sDM1RVJuZXjSoXARwouKRkjIeRus90m
 vJlyxMxaIPPbKp3q3RowBOpnopI/fwxV3zeq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705954108; x=1706558908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yudmI3Xyazx+JwbrnJNDAmTy82Pmo/8KeGZqzCu8ZDI=;
 b=pr/R3lvXj33hxRODDFTclVRJdR9nwelXAa+9EgNz778Xw249HKeKidKuUayttYw/lQ
 Gq/a7cZv1J9CBhpmGqqcOXHiDCKPuYMU1RpmKnmmSm1oQOPZ5R7+Kq1pO085NkryrnJc
 wxMImq8ARn+i3oBM34RCuOox9YS8xPPn6kO3F2ws2I1DEDyFpdWG8jjuUl5XhjYiF/Av
 DIwrxjXCk3NgQCDjnAHSKIOn2MF9HG6cCGMDXDiSra/hsgXpD+7UrjUQlYFRGR+2TdN7
 SQqxk1pBz/xu3TonxxbmD9/Cr3TlRjLZWpANUQf9nxnl/FI1cTk45XdKFM5grc+Q6d4h
 D2iw==
X-Gm-Message-State: AOJu0YxZ2ORH/M4My0TXuUv1buS8nWIIBuDfO8HLAj/5lx/gNyEAhKES
 RmO9WIGZ9UWosJ1yzzRdnrmk8le7UMRQmxH/i0Ceu8jCooScpykZUiV8JcRolvNB5+Uy/P82Q2E
 EqZfMLje2kbsMQCcXPiQW9mjeLgxFcxhj2rkq
X-Google-Smtp-Source: AGHT+IGYDvONCxC5DK+hyhdw7W9VEydZHnJlHawh7KLeo1wyYbvuo7sodVydwwSXK9+froyOwQGxHvycLn0fwRFCjJ0=
X-Received: by 2002:a05:6122:2009:b0:4b7:2dbf:c558 with SMTP id
 l9-20020a056122200900b004b72dbfc558mr3859893vkd.0.1705954108216; Mon, 22 Jan
 2024 12:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20240119203950.6434-1-cristian@rodriguez.im>
 <Za6ALDkMyW9Pdspd@redhat.com>
In-Reply-To: <Za6ALDkMyW9Pdspd@redhat.com>
From: =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cristian@rodriguez.im>
Date: Mon, 22 Jan 2024 17:08:16 -0300
Message-ID: <CAPBLoAfbj51gFZ-=41jYHytPBvM_AagsB1ixySPpwr5Y4SPJpA@mail.gmail.com>
Subject: Re: [PATCH] crypto/gcrypt: prefer kernel as direct source of entropy
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: multipart/alternative; boundary="0000000000009fb8e7060f8e6407"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=cr@cristianrodriguez.net; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--0000000000009fb8e7060f8e6407
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:48=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Fri, Jan 19, 2024 at 05:39:40PM -0300, Cristian Rodr=C3=ADguez wrote:
> > gcrypt by default uses an userspace RNG, which cannot know
> > when it is time to discard/invalidate its buffer
> > (suspend, resume, vm forks, other corner cases)
> > as a "when to discard" event is unavailable to userspace.
>
> So in this scenario QEMU is impacted when QEMU is running inside
> another VM. ie the L0 QEMU "forks" the guest, and the L1 QEMU
> needs to re-init its RNG.
>
> > Set GCRYCTL_SET_PREFERRED_RNG_TYPE to GCRY_RNG_TYPE_SYSTEM
> > which must be done before the first call to gcry_check_version()
>
> QEMU is just one out of many applications that use libgcrypt and
> I see no reason why QEMU should be special cased in this respect.
>
> Updating each application to hardcode use of GCRY_RNG_TYPE_SYSTEM
> does not feel like a good solution. If this was a good default
> to use everywhere, then gcrypt should have set this default
> already, rather than requiring every app to solve the forking
> problem itself.
>

this default is because either other OSs had problems or in the past the
linux rng was not as performant as it is right now,
 now it outputs 100's of MB per second on a potato.

Updating every app that uses gcrypt is not really practical
> in terms of time investment anyway.
>

Yeah, it will be pretty time consuming so I have so far only sent a few
patches for things I consider important.

>
> If gcrypt doesn't want to make this its global default, then
> I would suggest that gcrypt should make its default be
> configurable. I see from its docs:
>
>
> https://gnupg.org/documentation/manuals/gcrypt/Configuration.html#Configu=
ration
>
> that it already supports a /etc/gcrypt/random.conf file.
> Perhaps they would extend that to allow selection of the
> default RNG backend, system-wide.


And things will remain problematic by default , because of all the
obscurity and that FIPS mode overrides
all defaults you choose anyways, including if I hardcode the preference in
the source code like I did here.
.


>
>
>

--0000000000009fb8e7060f8e6407
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 22, 2024 at 11:48=E2=80=
=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Fri, Jan 19, 2024 at 05:39:40PM -0300, Cristian Rodr=C3=
=ADguez wrote:<br>
&gt; gcrypt by default uses an userspace RNG, which cannot know<br>
&gt; when it is time to discard/invalidate its buffer<br>
&gt; (suspend, resume, vm forks, other corner cases)<br>
&gt; as a &quot;when to discard&quot; event is unavailable to userspace.<br=
>
<br>
So in this scenario QEMU is impacted when QEMU is running inside<br>
another VM. ie the L0 QEMU &quot;forks&quot; the guest, and the L1 QEMU<br>
needs to re-init its RNG.<br>
<br>
&gt; Set GCRYCTL_SET_PREFERRED_RNG_TYPE to GCRY_RNG_TYPE_SYSTEM<br>
&gt; which must be done before the first call to gcry_check_version()<br>
<br>
QEMU is just one out of many applications that use libgcrypt and<br>
I see no reason why QEMU should be special cased in this respect.<br>
<br>
Updating each application to hardcode use of GCRY_RNG_TYPE_SYSTEM<br>
does not feel like a good solution. If this was a good default<br>
to use everywhere, then gcrypt should have set this default<br>
already, rather than requiring every app to solve the forking<br>
problem itself.<br></blockquote><div><br></div><div>this default is because=
 either other OSs had problems or in the past the linux rng was not as perf=
ormant as it is right now,</div><div>=C2=A0now it outputs 100&#39;s of MB p=
er second on a potato.</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
Updating every app that uses gcrypt is not really practical<br>
in terms of time investment anyway.<br></blockquote><div><br></div><div>Yea=
h, it will be pretty time consuming so I have so far only sent a few patche=
s for things I consider important.</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
If gcrypt doesn&#39;t want to make this its global default, then<br>
I would suggest that gcrypt should make its default be<br>
configurable. I see from its docs:<br>
<br>
<a href=3D"https://gnupg.org/documentation/manuals/gcrypt/Configuration.htm=
l#Configuration" rel=3D"noreferrer" target=3D"_blank">https://gnupg.org/doc=
umentation/manuals/gcrypt/Configuration.html#Configuration</a><br>
<br>
that it already supports a /etc/gcrypt/random.conf file.<br>
Perhaps they would extend that to allow selection of the<br>
default RNG backend, system-wide.</blockquote><div>=C2=A0</div><div>And thi=
ngs will remain problematic by default , because of all the obscurity and t=
hat FIPS mode overrides</div><div>all defaults you choose anyways,=C2=A0inc=
luding if I hardcode the preference in the source code like I did here.</di=
v><div>.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><br>
<br>
</blockquote></div></div>

--0000000000009fb8e7060f8e6407--

