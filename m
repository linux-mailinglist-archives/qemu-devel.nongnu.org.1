Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6570F9F6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:22:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1qIa-0006Uo-JE; Wed, 24 May 2023 11:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q1qIU-0006H1-96
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q1qIS-0004Ze-CH
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684941656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JdljUTN50ccARt2cX/Ux2spcnkZExIScarAgUoX/pj0=;
 b=Ydbo2p3F3NJtDxCbP7nQmU2fSWfJp8+cd3DTryGjdAkYcx+3RE+Q0r4YJ8M0VsM+NXO4HO
 SjTwSfdibEFWUrfsBHyBt+MGWX33EeGXAPxaZgnpcAtsFpOysPdmMG2kfETEiR9L/8YWrT
 fjQvaG2AGmc6w4K0cqeVxkC/4jiSogk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-zwUt68LYP8GCUtd9HPtp2g-1; Wed, 24 May 2023 11:20:54 -0400
X-MC-Unique: zwUt68LYP8GCUtd9HPtp2g-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-52855ba7539so240942a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684941653; x=1687533653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdljUTN50ccARt2cX/Ux2spcnkZExIScarAgUoX/pj0=;
 b=PqsO5XWQBzW98by1Xm4F/IqPVqj7DkHspCx8Ed9idS1BmKL+4AMBP+EHDyuVJqfG7r
 QgSR+p8cCmXifGkETP60COr7HmZVG4YrTPvptXZ4aQiBMrijrWJWO6EQaZCs51OhmZHk
 2deH8LFH9Le4hWL84TW7sm40kOxmK+oNLehRVZFceG0QPhu1jSOabmyWGAft8jqAlKYo
 tT3plOjlZaS1XzL5uDz9SNS3mBsvHS8bVwwtzDs/5IGyCbqpy1jFR2nAZeIqn5ZlzOqG
 qt+PlMS8F4QJ8oYsdzSp4Bo2Ap9aBcYDch1+F5I+PoO1eKRbrB9G9cnttdDJDk6jTBrS
 b4tw==
X-Gm-Message-State: AC+VfDztJwbyMVgRT3LXXLuf5xIr+dJJLuPErGYwTXK0kuMInUya0mUw
 zb3o6PzlQuj4YnCCluABX1XIhtaMho1z3YXHpDT/Atgy+4Wi28UFwWsb5j6As0H/7VxsxfaEC3y
 sJS5V03Gr0RolduSIda44U1h0Fn3RKwo=
X-Received: by 2002:a17:90a:9483:b0:233:fb7d:845a with SMTP id
 s3-20020a17090a948300b00233fb7d845amr17564406pjo.4.1684941652979; 
 Wed, 24 May 2023 08:20:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59q4US8Js45Ofmsy0XQgtzljJEvnVCJCuIRDooEHf9LNob9zLOy9F4QfquaSKkQZrl1Cs5oaoKfn/hgMHSwqY=
X-Received: by 2002:a17:90a:9483:b0:233:fb7d:845a with SMTP id
 s3-20020a17090a948300b00233fb7d845amr17564386pjo.4.1684941652591; Wed, 24 May
 2023 08:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230416222838.36642-1-mateusz.p.albecki@gmail.com>
 <20230416222838.36642-2-mateusz.p.albecki@gmail.com>
 <CAFn=p-bcAW9aMymmWeVSMeyuT88YDZ2iYVh-t1GoogbBBPFjSw@mail.gmail.com>
 <CAGe=PKEvnnjBQVx-rNDXjmwvQ272S2DLw-xEDjp1vVuU30i4Hw@mail.gmail.com>
 <CAFn=p-bVdQ6E10F9FmapMcBvEUMX7hOjr-kz7FgfQL+cdJHV+A@mail.gmail.com>
 <ZG3II3qlIjmuSZzm@flawful.org>
In-Reply-To: <ZG3II3qlIjmuSZzm@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 24 May 2023 11:20:41 -0400
Message-ID: <CAFn=p-bJM4GpAg=U308EftJCzjAUYOh1exm4Cuz=6FDFgUuHHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core.c: fix handling of unsupported commands
To: Niklas Cassel <nks@flawful.org>
Cc: Mateusz Albecki <mateusz.p.albecki@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Mateusz Albecki <mateusz.albecki@outlook.com>,
 Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: multipart/alternative; boundary="000000000000ab9ba105fc720cd3"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--000000000000ab9ba105fc720cd3
Content-Type: text/plain; charset="UTF-8"

On Wed, May 24, 2023, 4:17 AM Niklas Cassel <nks@flawful.org> wrote:

> On Tue, May 23, 2023 at 10:35:56AM -0400, John Snow wrote:
> > On Mon, May 22, 2023 at 5:16???PM Mateusz Albecki <
> mateusz.p.albecki@gmail.com>
> > wrote:
> > >
> > > Certainly seems like my patch is wrong as it will make the abort path
> > execute ide_cmd_done twice. During debug I came to the conclusion that
> > ide_cmd_done is not called at all as I was getting timeouts on the driver
> > side while waiting for D2H FIS. I am still not sure how I was getting
> this
> > behavior if the problem was actually with setting correct error bits.
> Even
> > so I think it can be safely assumed that Niklas' change will solve the
> > issue, I will try to verify it in a couple of days and if I see any
> problem
> > I will come back to you.
> > >
> > > Mateusz
> >
> > Great, thanks :)
> >
> > I'm waiting to hear back from Niklas, but I'm hoping to take their
> patches
> > this cycle as I think they look quite good.
>
> Hello John,
>
> Unfortunately, I've noticed an increase in boot time during
> the initial SeaBIOS part of QEMU with my changes.
>
> Will need to debug to see which change is causing this.
>
> I'm at a conference this week, so it might take until next
> week until I have time to figure out why this is happening.
>
> So unfortunately, I think we need to hold off with my series
> for now.
>

Shame. Feel free to resend it once you've isolated the problem and I'll try
to fast-track it, since it'd be nice to have my more embarrassing mistakes
for NCQ fixed :)

(If I become hard to reach, please ping me with a direct, non-patch email
so it bubbles up to the top of my inbox.)

((...by the way, what are you working on? What motivates the interest in
AHCI/SATA now? Can you say?))


> If Mateusz can confirm that
> https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg05552.html
> solves his issue, and that it does not cause an increased boot
> time for SeaBIOS, perhaps that patch could be picked up separately.
>
>
> Kind regards,
> Niklas
>
>

--000000000000ab9ba105fc720cd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, May 24, 2023, 4:17 AM Niklas Cassel &lt;<a hre=
f=3D"mailto:nks@flawful.org">nks@flawful.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On Tue, May 23, 2023 at 10:35:56AM -0400, John Sno=
w wrote:<br>
&gt; On Mon, May 22, 2023 at 5:16???PM Mateusz Albecki &lt;<a href=3D"mailt=
o:mateusz.p.albecki@gmail.com" target=3D"_blank" rel=3D"noreferrer">mateusz=
.p.albecki@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Certainly seems like my patch is wrong as it will make the abort =
path<br>
&gt; execute ide_cmd_done twice. During debug I came to the conclusion that=
<br>
&gt; ide_cmd_done is not called at all as I was getting timeouts on the dri=
ver<br>
&gt; side while waiting for D2H FIS. I am still not sure how I was getting =
this<br>
&gt; behavior if the problem was actually with setting correct error bits. =
Even<br>
&gt; so I think it can be safely assumed that Niklas&#39; change will solve=
 the<br>
&gt; issue, I will try to verify it in a couple of days and if I see any pr=
oblem<br>
&gt; I will come back to you.<br>
&gt; &gt;<br>
&gt; &gt; Mateusz<br>
&gt; <br>
&gt; Great, thanks :)<br>
&gt; <br>
&gt; I&#39;m waiting to hear back from Niklas, but I&#39;m hoping to take t=
heir patches<br>
&gt; this cycle as I think they look quite good.<br>
<br>
Hello John,<br>
<br>
Unfortunately, I&#39;ve noticed an increase in boot time during<br>
the initial SeaBIOS part of QEMU with my changes.<br>
<br>
Will need to debug to see which change is causing this.<br>
<br>
I&#39;m at a conference this week, so it might take until next<br>
week until I have time to figure out why this is happening.<br>
<br>
So unfortunately, I think we need to hold off with my series<br>
for now.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Shame. Feel free to resend it once you&#39;ve isolated the proble=
m and I&#39;ll try to fast-track it, since it&#39;d be nice to have my more=
 embarrassing mistakes for NCQ fixed :)</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">(If I become hard to reach, please ping me with a direct, n=
on-patch email so it bubbles up to the top of my inbox.)</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">((...by the way, what are you working on? =
What motivates the interest in AHCI/SATA now? Can you say?))</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
If Mateusz can confirm that<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg05552.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2023-04/msg05552.html</a><br>
solves his issue, and that it does not cause an increased boot<br>
time for SeaBIOS, perhaps that patch could be picked up separately.<br>
<br>
<br>
Kind regards,<br>
Niklas<br>
<br>
</blockquote></div></div></div>

--000000000000ab9ba105fc720cd3--


