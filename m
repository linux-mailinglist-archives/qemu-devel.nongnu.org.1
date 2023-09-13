Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B7379E47E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMh2-0004Q7-IA; Wed, 13 Sep 2023 06:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgMh0-0004Px-6W
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:01:55 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgMgx-0004dZ-SP
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:01:53 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5738cb00eebso4154941eaf.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694599310; x=1695204110; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0VutuHNe7N1bUNxqsb51yPNw8j2NrLCXT9AaM8ckIr0=;
 b=Fr0F4tsCAZgkKDw+Lse6oF5BFUzy4vgO0BtO0N5Ukxv03QDt0PBm66onvh7K5iRd9O
 GQ28XzgWdZKrnbjwTtZEXaREi1UZ/+tIxrzKCjKBXwTB68+kupBN9cevjOXGpUxMvAqa
 /oLp4w0yhTbvUoBo3al51u5r4M18DcdPsGodFkJqsk/7sFb7d5zHUGq3v8GR09CMXx5A
 iZIsftlS6jKV8wRdajZ6IN805Prk0OnRM8wjCBiu8E8LumujHxYEokGjcXWMAMfxABzJ
 OQ5Y3jyqQD9tLkY20nnDLMnw/S88axXc9NpcHY/uzQfXSIB6lDqo88XtdSs8STRujbuJ
 rtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694599310; x=1695204110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0VutuHNe7N1bUNxqsb51yPNw8j2NrLCXT9AaM8ckIr0=;
 b=icYW/W942IjESoPOdo4e5teHUGqBmjRaJqGfrOpymwTSXVDuClHZXyuYKdEtRucJVc
 CQyS7d4Zv2rgOrPjksfGxWeOikHgFY+OFIuZPBBmkapdBJDAGxc0H+HN5yLUpIGTx6/t
 nUPs9Lhd85EUGCzROBigaX7Mxq/qwsCHKmuiQedJ1kB/WA69B6HTxLDNlZI3ri4h0xM4
 GcVF2q7Lbz+caqFplyOKgjHqkUzjCOF0aE6wv+TRqYQ6s3Yp67xjpYG1e6aqqWzSRZ1j
 6Jz22ARtii0Z5NDzt9H/6OtwwpNT4MZHTJ6JCaVoH7m5nDNJD3EEqTVU5cyYBL0L77zn
 yxjg==
X-Gm-Message-State: AOJu0YxNz2LslOP8Kd37DRroy2XTVGYlwAFv73w+bSFvB4Qa417140XW
 56pzGPOQ/LqeeMbgNnhCWrqolTQ4nfNaf63zn04=
X-Google-Smtp-Source: AGHT+IE26FUB9gbn8pRE3EHX13/SoiZOxaf5HJHHCvgzh6o0esqkKkZuDVU/zPEwFU44FtgrHIvUEsKjUdTkyte+W0M=
X-Received: by 2002:a05:6870:b69e:b0:1bf:5559:4aaf with SMTP id
 cy30-20020a056870b69e00b001bf55594aafmr2139340oab.34.1694599310537; Wed, 13
 Sep 2023 03:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXukZuLRF0x1Yt06n2rbeOMAAG0SRsx4Z_QTTro9vMFTw@mail.gmail.com>
 <9b7b9d2a-e8fc-658d-634b-15983c594658@tls.msk.ru>
In-Reply-To: <9b7b9d2a-e8fc-658d-634b-15983c594658@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 13 Sep 2023 06:01:38 -0400
Message-ID: <CAJSP0QUW-maHWkbR0zT0hk9Zu=j5Zz-1H+DjzH5WUhLewzDgTA@mail.gmail.com>
Subject: Re: CI container image interference between staging and staging-7.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f0fb8a06053aa563"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f0fb8a06053aa563
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 13, 2023, 03:26 Michael Tokarev <mjt@tls.msk.ru> wrote:

> 13.09.2023 02:07, Stefan Hajnoczi wrote:
> > Hi,
> > TL;DR Michael: Please check that the staging-7.2 branch has Dan's
> > commit e28112d00703abd136e2411d23931f4f891c9244 ("gitlab: stable
> > staging branches publish containers in a separate tag").
> ...
>
> Mea cupla, Stefan.  I'm always forgetting about the fact that ci controls
> don't work on older branches in one way or another. Sigh.
>
> The patch(es) you're talking about - I didn't pick them up for 7.2 (which
> was the branch in question this time, which interfered with your testing),
> thinking it would be ok.  Yes, after this fiasco (which is the first one
> actually), it looks like I should re-consider doing this.
>
> It needs quite a few changes in there. And one of them is to actually
> look at QEMU_CI={0,1,2} variable when pushing staging-N.M branches.  Right
> now - and this is what I forgot this time once again, - I used QEMU_CI=1
> so the job does not auto-start, but forgot that in 7.2 it auto-starts
> regardless of QEMU_CI value.
>
> I don't push staging-N.M branches often, usually doing all the CI on
> a my gitlab repository instead. And when I do push to qemu-project,
> I either intend to skip automatic job run, to run just the tests I'm
> interested in, or push it at a time when no other pipelines are to be
> run (which is easy due to time zone differences).
>
> But actually I'm a bit surprised this issue happened to begin with.
> Maybe something else is missing still.  The thing is that after
> Daniel's changes, qemu/staging container tags should be named differently,
> no?   Ah. No. Staging didn't change, it was staging-N.M which were
> renamed.  Once again, I'm sorry for not thinking well enough about this, -
> after container tags renaming I was kinda sure main staging tags were
> different from old staging-N.M, which is not the case..
>
> Please excuse me for this trouble.  Things like these usually takes quite
> some time to figure out.. :(  I'll make sure this wont happen again,
> one way or another.
>

No worries!

Stefan

>

--000000000000f0fb8a06053aa563
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Sep 13, 2023, 03:26 Michael Tokarev &lt;<a href=3D"mai=
lto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">13.09.2023 02:07, Stefan Hajnoczi wrote:<br>
&gt; Hi,<br>
&gt; TL;DR Michael: Please check that the staging-7.2 branch has Dan&#39;s<=
br>
&gt; commit e28112d00703abd136e2411d23931f4f891c9244 (&quot;gitlab: stable<=
br>
&gt; staging branches publish containers in a separate tag&quot;).<br>
...<br>
<br>
Mea cupla, Stefan.=C2=A0 I&#39;m always forgetting about the fact that ci c=
ontrols<br>
don&#39;t work on older branches in one way or another. Sigh.<br>
<br>
The patch(es) you&#39;re talking about - I didn&#39;t pick them up for 7.2 =
(which<br>
was the branch in question this time, which interfered with your testing),<=
br>
thinking it would be ok.=C2=A0 Yes, after this fiasco (which is the first o=
ne<br>
actually), it looks like I should re-consider doing this.<br>
<br>
It needs quite a few changes in there. And one of them is to actually<br>
look at QEMU_CI=3D{0,1,2} variable when pushing staging-N.M branches.=C2=A0=
 Right<br>
now - and this is what I forgot this time once again, - I used QEMU_CI=3D1<=
br>
so the job does not auto-start, but forgot that in 7.2 it auto-starts<br>
regardless of QEMU_CI value.<br>
<br>
I don&#39;t push staging-N.M branches often, usually doing all the CI on<br=
>
a my gitlab repository instead. And when I do push to qemu-project,<br>
I either intend to skip automatic job run, to run just the tests I&#39;m<br=
>
interested in, or push it at a time when no other pipelines are to be<br>
run (which is easy due to time zone differences).<br>
<br>
But actually I&#39;m a bit surprised this issue happened to begin with.<br>
Maybe something else is missing still.=C2=A0 The thing is that after<br>
Daniel&#39;s changes, qemu/staging container tags should be named different=
ly,<br>
no?=C2=A0 =C2=A0Ah. No. Staging didn&#39;t change, it was staging-N.M which=
 were<br>
renamed.=C2=A0 Once again, I&#39;m sorry for not thinking well enough about=
 this, -<br>
after container tags renaming I was kinda sure main staging tags were<br>
different from old staging-N.M, which is not the case..<br>
<br>
Please excuse me for this trouble.=C2=A0 Things like these usually takes qu=
ite<br>
some time to figure out.. :(=C2=A0 I&#39;ll make sure this wont happen agai=
n,<br>
one way or another.<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">No worries!</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Stefan</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
</blockquote></div></div></div>

--000000000000f0fb8a06053aa563--

