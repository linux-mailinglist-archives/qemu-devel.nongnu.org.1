Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7A784AE1
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:55:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYXSa-0006M6-HI; Tue, 22 Aug 2023 15:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qYXSS-0006Le-LZ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:54:32 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qYXSP-0002fb-9A
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:54:32 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-991c786369cso650059766b.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692734067; x=1693338867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rtTFgnYHobQSaKZyoC09kQk59qPgEUdgEnoCJ23X0Tw=;
 b=x/QI608X8ua9Mr/XibdlGSgDQsGcYfLPjuLvIFeKf63nGGcRgAB3HKL6Uh24pvQZl5
 +BUe3VFSYOCT+AZHlc8f9qryfIBvQWbSkhVnqPMuC8mWHNCUROBdvpKXDoMIFOlX++73
 Kk9QZEjdEBoEYoXgrONCmL2pBhSm/qmOZocQYzytnUAMDVcYTt1lGXLWV5KIAaV2PC4I
 ScCpcMMlvbsFeNBpwLPV/cPkS0FPhZNr7Th5aBdHEZKkB2u1SZBPPdswj5stl0H4fQYt
 pC64MPHpNn6SZ8F/DxS1URSN3LPXaKg27Hws9r0dU6ntmWX3FFfb6zWaaRnR36PFIfHS
 tmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692734067; x=1693338867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rtTFgnYHobQSaKZyoC09kQk59qPgEUdgEnoCJ23X0Tw=;
 b=LT4/Z/u9DQIIObHGEdXgkSna89f/E4gRvHCumW1pquoLumbpV4EIpnUK0TRRN4AIFh
 WaKfDhXrOSURjoyAxKrS3IdBZ3hfBO+gArq7J9dfAn6Ql4tgXRDXeVOV5CZxNE2uU5vB
 dsHjER6ZzGTPBDrfbeIZwbQdZAceMSdoOZWIzH7hv/J+rv6XSnLczx3/IK+fg8WxRzma
 a5q8Au5MZDmON/jzavvN24c+uBdKLxofShztcUShfO6s4mt8/KUCDiLwj8wisHerh4Pt
 ARVz8Iqvy1V7Vj4204AUSf1i7ynfTOHG3NyVS5SfIzibt6xhU4lro0plf33F/hGg0Uw1
 9AKw==
X-Gm-Message-State: AOJu0YwAQk1HNQr4lNWbyM8zj5Ys3IX8VdgnTJ/yPnr6+bJErYb+BESJ
 kTkQE/m3yL5Zz+CQKiI6++jJ5fu2a7PAHc0NKZE9vg==
X-Google-Smtp-Source: AGHT+IECGkhXJvaD6+ovKuW+OBOLAZFWO4rZlaT3VulKpAblE5St1zgAMJefjigNGjdFdE96ai1USyemFEYz+af9nGc=
X-Received: by 2002:a17:906:73da:b0:994:569b:61b8 with SMTP id
 n26-20020a17090673da00b00994569b61b8mr7631899ejl.58.1692734066739; Tue, 22
 Aug 2023 12:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-22-kariem.taha2.7@gmail.com>
 <eb0506c6-f9bd-5a1f-870b-b6d07dd337ea@linaro.org>
 <CANCZdfrmw6c9kxFTUrWegaU78SHBjqVMEHuO8VVsPN=7hGQb0Q@mail.gmail.com>
 <c7dbf551-f833-c5e3-302e-fcea2d411bb5@linaro.org>
In-Reply-To: <c7dbf551-f833-c5e3-302e-fcea2d411bb5@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 22 Aug 2023 13:54:15 -0600
Message-ID: <CANCZdfpROK+m4B3-0NiN4uwpV+4pUd7dWwec-_f5_VWNjwpEKg@mail.gmail.com>
Subject: Re: [PATCH 21/22] Implement shmat(2) and shmdt(2)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000bf64540603885c22"
Received-SPF: none client-ip=2a00:1450:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x635.google.com
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

--000000000000bf64540603885c22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 12:11=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/22/23 11:03, Warner Losh wrote:
> >     Hmm, bug with linux-user as well, because here we should
> re-establish the reserved_va
> >     reservation.
> >
> >
> > ... of the shared memory region we just detached? Right?
>
> Correct.
>
> On a related note, on FreeBSD is there any practical difference between
>
>      PROT_NONE, MAP_ANON
> and
>      PROT_NONE, MAP_GUARD
>
> for large memory regions?
>

They do different things. MAP_ANON maps the memory without a backing
device. This means it allocates the VA space right away, but lazily
allocates
the backing pages as the pages are dirtied.

MAP_GUARD creates the VA mapping, but never maps any pages to those
pages (well, until it's remapped). Any read/write/exec access to MAP_GUARD
pages results in a SIGSEGV.


> I ask since FreeBSD doesn't have MAP_NORESERVE, which Linux uses to avoid
> allocation of
> gigabytes
>

Yea. It sounds like MAP_NORESERVE is what FreeBSD's default behavior is: We
don't
allocate backing store in the swap areas until there's memory pressure. You
can safely
allocate GB of space with MAP_ANON and get similar behavior to the
MAP_NORESERVE.

MAP_GUARD could be used if you wanted to reserve the VA space, but didn't
want to assign
anything to the VA space until later.

As a practical matter, they both consume about the same resources until the
MAP_ANON
region starts to get populated with data...

With PROT_NONE, I think they would have the same effect. If it is to be a
backing store for
something like malloc, then MAP_ANON would be best. If you are replacing it
with a lot of
things, like a mix of files, devices and/or anon memory, then MAP_GUARD and
replace it
with MAP_FIXED later. Most likely you'll want MAP_GUARD to reserve the
area, and then
MAP_FIXED to use it for mmap'd memory, shared memory, executable pages, etc=
.

Does that tell you what you need to know?

Warner


> r~
>

--000000000000bf64540603885c22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 22, 2023 at 12:11=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 8/22/23 11:03, Warner Losh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hmm, bug with linux-user as well, because here we s=
hould re-establish the reserved_va<br>
&gt;=C2=A0 =C2=A0 =C2=A0reservation.<br>
&gt; <br>
&gt; <br>
&gt; ... of the shared memory region we just detached? Right?<br>
<br>
Correct.<br>
<br>
On a related note, on FreeBSD is there any practical difference between<br>
<br>
=C2=A0 =C2=A0 =C2=A0PROT_NONE, MAP_ANON<br>
and<br>
=C2=A0 =C2=A0 =C2=A0PROT_NONE, MAP_GUARD<br>
<br>
for large memory regions?<br></blockquote><div><br></div><div>They do diffe=
rent things. MAP_ANON maps the memory without a backing</div><div>device. T=
his means it allocates the VA space right away, but lazily allocates</div><=
div>the backing pages as the pages are dirtied.</div><div><br></div><div>MA=
P_GUARD creates the VA mapping, but never maps any pages to those</div><div=
>pages (well, until it&#39;s remapped). Any read/write/exec access to MAP_G=
UARD</div><div>pages results in a SIGSEGV.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
I ask since FreeBSD doesn&#39;t have MAP_NORESERVE, which Linux uses to avo=
id allocation of <br>
gigabytes<br></blockquote><div><br></div><div>Yea. It sounds like MAP_NORES=
ERVE is what FreeBSD&#39;s default behavior is: We don&#39;t</div><div>allo=
cate backing store in the swap areas until there&#39;s memory pressure. You=
 can safely</div><div>allocate GB of space with MAP_ANON and get similar be=
havior to the MAP_NORESERVE.</div><div><br></div><div>MAP_GUARD could be us=
ed if you wanted to reserve the VA space, but didn&#39;t want to assign</di=
v><div>anything to the VA space until later.</div><div><br></div><div>As a =
practical matter, they both consume about the same resources until the MAP_=
ANON</div><div>region starts to get populated with data...</div><div><br></=
div><div>With PROT_NONE, I think they would have the same effect. If it is =
to be a backing store for</div><div>something like malloc, then MAP_ANON wo=
uld be best. If you are replacing it with a lot of</div><div>things, like a=
 mix of files, devices and/or anon memory, then MAP_GUARD and replace it</d=
iv><div>with MAP_FIXED later. Most likely you&#39;ll want MAP_GUARD to rese=
rve the area, and then</div><div>MAP_FIXED to use it for mmap&#39;d memory,=
 shared memory, executable pages, etc.</div><div><br></div><div>Does that t=
ell you what you need to know?</div><div><br></div><div>Warner</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
r~<br>
</blockquote></div></div>

--000000000000bf64540603885c22--

