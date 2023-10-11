Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 450267C48D2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 06:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqQmd-0007oW-4E; Wed, 11 Oct 2023 00:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qqQma-0007hL-R3
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 00:25:16 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qqQmY-0002mt-TJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 00:25:16 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5041d6d8b10so8376225e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 21:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696998313; x=1697603113;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7virY4gRlPd0UJZSNKdnWq4YQlqfHYdNT5Em/ouO508=;
 b=LYqJtvrNAu1XtrckQJnF6P86mtfi95Jg8WOXlRgxqC88KgSbdVd5GYpZBQvzO3Q31G
 /Q6EtMurFsYGMtKNwxq651AGMqyJ++NTS2fhuAsd3Ls6A3XqaasDVWEEfY1ZfNSUi8eN
 1tmp2nFh0Dr50RmV+iS5UoKotpG3VWOGTtvKMF3JNkWoB8sltBwicp7DDtPLlkK66KYE
 G5vYQ/I3SKeKIYJHiSEBwdcbybbdjWl5j9J1r+suY/HCYFSFOie1A5pN9rktUq7pRoC0
 H/42lRlYxUUnPjvzMuy000UDoJ0tmMe2NIBWLE5ZC/8q07h7OiU16he/n2dbWBRMQens
 JguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696998313; x=1697603113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7virY4gRlPd0UJZSNKdnWq4YQlqfHYdNT5Em/ouO508=;
 b=ClcOKsyQnv9Dt5Q1YUuymIdG61igSJgodpJiVZwy7WR0Eym0HhG4elbLUhbgXK6DKq
 sSOv4T7HZqfBZTm3xP6Kj42jCf4vqTO2TM0VlBcK95s9xUKdT76Bpk0O1VTXxeO6sQct
 Dpanq50HUrAsZpqD/mLvGKt+kI+ePhxS0B4VxaBM3VnrptXxSwABv2slWp7BXewFrjgr
 M6RroGOiGAd47bU6KcvOgMsO/cVeLBO/wFrLR+E1SVyQ3WWficT2ahluNaSOXvwOZZqh
 3J6xMvWYKBKOFEpMOdrLs12oxa+0yM2q7wE6G3tPdv8rm+vmWXHlus7qlXiReX7Yu2Db
 Bg3g==
X-Gm-Message-State: AOJu0YxRgCA7B1CJYU3DpX8O+viNgnr+mDB2cdHdfxR54JSUgTSgmghq
 Ni8GtOnTPSb0NumIt2jQlA+5ZMjZmfZ5oK81+Y48Vw==
X-Google-Smtp-Source: AGHT+IE96MSKyhIO40ENRGc9Q74dcelDes4B0uRU8P9gCsmBS9z3fk/lqEJXRVsOtyce3E1EwFRoZaiURpAliAVCur8=
X-Received: by 2002:a05:6512:308a:b0:502:e651:129b with SMTP id
 z10-20020a056512308a00b00502e651129bmr19798566lfd.19.1696998312917; Tue, 10
 Oct 2023 21:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-7-npiggin@gmail.com>
 <CANCZdfqNJ97EgAax=P7pzny8zcULfiLEVJighecm5=DgLtRv8g@mail.gmail.com>
 <CW593XZPASQW.3OODX8I6KCO2L@wheely>
In-Reply-To: <CW593XZPASQW.3OODX8I6KCO2L@wheely>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Oct 2023 22:25:16 -0600
Message-ID: <CANCZdfoNC9GUPwLvQXyZqMmC_EFy+fu8=5poqqNyCa-G4U2UPA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/11] tests/avocado: Add FreeBSD distro boot tests
 for ppc
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a0567606076935ed"
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x129.google.com
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

--000000000000a0567606076935ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 8:23=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:

> On Wed Oct 11, 2023 at 7:55 AM AEST, Warner Losh wrote:
> > On Tue, Oct 10, 2023 at 1:53=E2=80=AFAM Nicholas Piggin <npiggin@gmail.=
com>
> wrote:
> >
> > > FreeBSD project provides qcow2 images that work well for testing QEMU=
.
> > > Add pseries tests for HPT and Radix, KVM and TCG.
> > >
> > > Other architectures could be added so this does not get a ppc_ prefix
> > > but is instead named similarly to boot_linux.
> > >
> > > Cc: Warner Losh <imp@bsdimp.com>
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > >
> > > CC'ing Warner to check if it's okay for us to use these images and
> > > any comments or suggestions. avocado tests have many Linux boots so
> we'd
> > > do much better to expand test coverage by adding some other systems.
> > >
> >
> > I like this.... I'm a little worried at the exact hash encoded in it, b=
ut
> > since there's a checksum
> > to match, it's OK I guess. It will give this code a shelf-life of month=
s,
> > IIRC our retention policy.
>
> The oldest 15.0 CURRENT image on there is May 1st, so ~6 months? That's
> not too bad. There are some release qcow2 images as well which sound
> like they're maintained longer-term:
>
> https://download.freebsd.org/releases/VM-IMAGES/
>
> No builds for powerpc, but those might be preferable for other targets.
>
> Another option for powerpc might be to use a release .iso. It's much
> nicer to have a qcow image already installed though. I'll tinker with
> it a bit more, but may stick with the snapshot for now.
>

I'll try to track that down. It may just be an oversight since powerpc64le
is
new.

Warner


> Thanks,
> Nick
>

--000000000000a0567606076935ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 10, 2023 at 8:23=E2=80=AF=
PM Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npiggin@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Wed Oct 11, 2023 at 7:55 AM AEST, Warner Losh wrote:<br>
&gt; On Tue, Oct 10, 2023 at 1:53=E2=80=AFAM Nicholas Piggin &lt;<a href=3D=
"mailto:npiggin@gmail.com" target=3D"_blank">npiggin@gmail.com</a>&gt; wrot=
e:<br>
&gt;<br>
&gt; &gt; FreeBSD project provides qcow2 images that work well for testing =
QEMU.<br>
&gt; &gt; Add pseries tests for HPT and Radix, KVM and TCG.<br>
&gt; &gt;<br>
&gt; &gt; Other architectures could be added so this does not get a ppc_ pr=
efix<br>
&gt; &gt; but is instead named similarly to boot_linux.<br>
&gt; &gt;<br>
&gt; &gt; Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_=
blank">imp@bsdimp.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmai=
l.com" target=3D"_blank">npiggin@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; CC&#39;ing Warner to check if it&#39;s okay for us to use these i=
mages and<br>
&gt; &gt; any comments or suggestions. avocado tests have many Linux boots =
so we&#39;d<br>
&gt; &gt; do much better to expand test coverage by adding some other syste=
ms.<br>
&gt; &gt;<br>
&gt;<br>
&gt; I like this.... I&#39;m a little worried at the exact hash encoded in =
it, but<br>
&gt; since there&#39;s a checksum<br>
&gt; to match, it&#39;s OK I guess. It will give this code a shelf-life of =
months,<br>
&gt; IIRC our retention policy.<br>
<br>
The oldest 15.0 CURRENT image on there is May 1st, so ~6 months? That&#39;s=
<br>
not too bad. There are some release qcow2 images as well which sound<br>
like they&#39;re maintained longer-term:<br>
<br>
<a href=3D"https://download.freebsd.org/releases/VM-IMAGES/" rel=3D"norefer=
rer" target=3D"_blank">https://download.freebsd.org/releases/VM-IMAGES/</a>=
<br>
<br>
No builds for powerpc, but those might be preferable for other targets.<br>
<br>
Another option for powerpc might be to use a release .iso. It&#39;s much<br=
>
nicer to have a qcow image already installed though. I&#39;ll tinker with<b=
r>
it a bit more, but may stick with the snapshot for now.<br></blockquote><di=
v><br></div><div>I&#39;ll try to track that down. It may just be an oversig=
ht since powerpc64le is</div><div>new.</div><div><br></div><div>Warner<br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks,<br>
Nick<br>
</blockquote></div></div>

--000000000000a0567606076935ed--

