Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3689571EF3D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:40:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lKm-0001FG-D8; Thu, 01 Jun 2023 12:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4lKj-0001Cu-Dj
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4lKh-0008TO-C8
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685637565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjubJvUb7paTnivBG8OhsVBJzeoj1vdrP555ELT6sU4=;
 b=Ck0GGhUoMd79+Dd/8EfZU9YUq8ZDrj+xZWF4PX+nBzDstXzRgm7SHFgFCQbFAW3GLIg9F7
 klf3aTMS7T8LPdX6xzb0OnP7XxONUES0X29FF0yMMzTvBTliDo/40d7TeFWLZ33Ap5O9nK
 GnjSnSsI2ZGMuVDNlGI27VpUrN5tORM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-04dNY5RoM7-VasO_K4lc7w-1; Thu, 01 Jun 2023 12:39:24 -0400
X-MC-Unique: 04dNY5RoM7-VasO_K4lc7w-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-256b2c2baf1so877551a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 09:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685637563; x=1688229563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AjubJvUb7paTnivBG8OhsVBJzeoj1vdrP555ELT6sU4=;
 b=Ndw68d7OlZsh+CCs6C3fAwGDQpJ8Skq/7KjzAIAPfangrfZ2B7BAcUZ1IB7IcwJef6
 XJS5EFhjnF6be3mfWh9fd29iELVnDOP2J6V31VhdPQ1fEwrEXw0my63N4+UgWVVZN9yW
 QGlZ3ETLhYyRx0A1caZgmyVzYqRxrBFzMKIo9LhMQXTPEOY+WfPpO8PDXYP5BWrgxq10
 g4FQWY8qIvR9aOxkfX4zs4p1YR4bzax4NQikyzxW238Eo5ulAlnfuJFrXIPeojNuhnFc
 Y1Ss8Tov44pvJDeli7yMHRwdvsnU1304zaQ1TqZKKZgrZrnDNJHFJEzkmMvelN2uezy6
 5vwQ==
X-Gm-Message-State: AC+VfDxBiNBaIHER222RV0pjbV/5HCqd6yQq8oGi51RDT85OwCELZomU
 Ibm0vJHspXsW2KUM8JDUXAOKToq5PqglBTkswMeC5t9jVRGpNN9ZmSvlFNz/Vr3ra2269yWTtEB
 HVhN8cE1nfASCB8A9Ug5HPj6tmx3cjk4=
X-Received: by 2002:a17:90a:94c9:b0:252:a0dc:7950 with SMTP id
 j9-20020a17090a94c900b00252a0dc7950mr24672pjw.2.1685637563190; 
 Thu, 01 Jun 2023 09:39:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TKTPhTAsOaQ1boTaKwhpleyGbLdsStNXYI0YYZkXwF42NOfrTTvVqT+1Sv0DKS+hWn574XWCVxXWkAYhm44U=
X-Received: by 2002:a17:90a:94c9:b0:252:a0dc:7950 with SMTP id
 j9-20020a17090a94c900b00252a0dc7950mr24660pjw.2.1685637562844; Thu, 01 Jun
 2023 09:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230416222838.36642-1-mateusz.p.albecki@gmail.com>
 <20230416222838.36642-2-mateusz.p.albecki@gmail.com>
 <CAFn=p-bcAW9aMymmWeVSMeyuT88YDZ2iYVh-t1GoogbBBPFjSw@mail.gmail.com>
 <CAGe=PKEvnnjBQVx-rNDXjmwvQ272S2DLw-xEDjp1vVuU30i4Hw@mail.gmail.com>
 <CAFn=p-bVdQ6E10F9FmapMcBvEUMX7hOjr-kz7FgfQL+cdJHV+A@mail.gmail.com>
 <ZG3II3qlIjmuSZzm@flawful.org>
 <CAFn=p-bJM4GpAg=U308EftJCzjAUYOh1exm4Cuz=6FDFgUuHHQ@mail.gmail.com>
 <ZHilPUjfC/lJ2ubA@x1-carbon>
In-Reply-To: <ZHilPUjfC/lJ2ubA@x1-carbon>
From: John Snow <jsnow@redhat.com>
Date: Thu, 1 Jun 2023 12:39:11 -0400
Message-ID: <CAFn=p-ZnX7qy7nAEeJ3HJ2PNMsHVBc6ghdtkHmeB3MNL=8n23w@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core.c: fix handling of unsupported commands
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Niklas Cassel <nks@flawful.org>,
 Mateusz Albecki <mateusz.p.albecki@gmail.com>, 
 qemu-devel <qemu-devel@nongnu.org>,
 Mateusz Albecki <mateusz.albecki@outlook.com>
Content-Type: multipart/alternative; boundary="0000000000002768a905fd141491"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000002768a905fd141491
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 1, 2023, 10:03 AM Niklas Cassel <Niklas.Cassel@wdc.com> wrote:

> On Wed, May 24, 2023 at 11:20:41AM -0400, John Snow wrote:
> > On Wed, May 24, 2023, 4:17 AM Niklas Cassel <nks@flawful.org> wrote:
> >
> > > On Tue, May 23, 2023 at 10:35:56AM -0400, John Snow wrote:
> > > > On Mon, May 22, 2023 at 5:16???PM Mateusz Albecki <
> > > mateusz.p.albecki@gmail.com>
> > > > wrote:
> > > > >
> > > > > Certainly seems like my patch is wrong as it will make the abort
> path
> > > > execute ide_cmd_done twice. During debug I came to the conclusion
> that
> > > > ide_cmd_done is not called at all as I was getting timeouts on the
> driver
> > > > side while waiting for D2H FIS. I am still not sure how I was getting
> > > this
> > > > behavior if the problem was actually with setting correct error bits.
> > > Even
> > > > so I think it can be safely assumed that Niklas' change will solve
> the
> > > > issue, I will try to verify it in a couple of days and if I see any
> > > problem
> > > > I will come back to you.
> > > > >
> > > > > Mateusz
> > > >
> > > > Great, thanks :)
> > > >
> > > > I'm waiting to hear back from Niklas, but I'm hoping to take their
> > > patches
> > > > this cycle as I think they look quite good.
> > >
> > > Hello John,
> > >
> > > Unfortunately, I've noticed an increase in boot time during
> > > the initial SeaBIOS part of QEMU with my changes.
> > >
> > > Will need to debug to see which change is causing this.
> > >
> > > I'm at a conference this week, so it might take until next
> > > week until I have time to figure out why this is happening.
> > >
> > > So unfortunately, I think we need to hold off with my series
> > > for now.
> > >
> >
> > Shame. Feel free to resend it once you've isolated the problem and I'll
> try
> > to fast-track it, since it'd be nice to have my more embarrassing
> mistakes
> > for NCQ fixed :)
> >
> > (If I become hard to reach, please ping me with a direct, non-patch email
> > so it bubbles up to the top of my inbox.)
> >
> > ((...by the way, what are you working on? What motivates the interest in
> > AHCI/SATA now? Can you say?))
>
> Hello John,
>
> It is simple, Western Digital is still selling a lot of SATA drives :)
>

Haha! Fair enough. I built my first computer without a single AHCI device
in it last year, but you can't say the same for my Synology downstairs in
my networking closet :)


> And we used QEMU to verify some of the support for Command Duration Limits
> in linux:
> https://lore.kernel.org/linux-scsi/20230511011356.227789-1-nks@flawful.org/


Ah-ha, that helps explain it :)

If you find other problems, even if you don't intend to fix them, please
file a gitlab issue to document that there's work that needs done.


>
> Right now, I don't intend to upstream all my hacky patches to QEMU,
> just the things that might be useful for everyone, e.g. GPL and NCQ error
> log
> (and possibly Sense Data Reporting feature set support, and NCQ autosense).
>

Got it, thanks! I'll try to set aside time to look over your patches
"soon", I'd like then for 8.1. If I go quiet, *please* ping me.


>
> Kind regards,
> Niklas
>

--0000000000002768a905fd141491
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 1, 2023, 10:03 AM Niklas Cassel &lt;<a hre=
f=3D"mailto:Niklas.Cassel@wdc.com">Niklas.Cassel@wdc.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On Wed, May 24, 2023 at 11:20:41AM -04=
00, John Snow wrote:<br>
&gt; On Wed, May 24, 2023, 4:17 AM Niklas Cassel &lt;<a href=3D"mailto:nks@=
flawful.org" target=3D"_blank" rel=3D"noreferrer">nks@flawful.org</a>&gt; w=
rote:<br>
&gt; <br>
&gt; &gt; On Tue, May 23, 2023 at 10:35:56AM -0400, John Snow wrote:<br>
&gt; &gt; &gt; On Mon, May 22, 2023 at 5:16???PM Mateusz Albecki &lt;<br>
&gt; &gt; <a href=3D"mailto:mateusz.p.albecki@gmail.com" target=3D"_blank" =
rel=3D"noreferrer">mateusz.p.albecki@gmail.com</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Certainly seems like my patch is wrong as it will make =
the abort path<br>
&gt; &gt; &gt; execute ide_cmd_done twice. During debug I came to the concl=
usion that<br>
&gt; &gt; &gt; ide_cmd_done is not called at all as I was getting timeouts =
on the driver<br>
&gt; &gt; &gt; side while waiting for D2H FIS. I am still not sure how I wa=
s getting<br>
&gt; &gt; this<br>
&gt; &gt; &gt; behavior if the problem was actually with setting correct er=
ror bits.<br>
&gt; &gt; Even<br>
&gt; &gt; &gt; so I think it can be safely assumed that Niklas&#39; change =
will solve the<br>
&gt; &gt; &gt; issue, I will try to verify it in a couple of days and if I =
see any<br>
&gt; &gt; problem<br>
&gt; &gt; &gt; I will come back to you.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Mateusz<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Great, thanks :)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;m waiting to hear back from Niklas, but I&#39;m hoping=
 to take their<br>
&gt; &gt; patches<br>
&gt; &gt; &gt; this cycle as I think they look quite good.<br>
&gt; &gt;<br>
&gt; &gt; Hello John,<br>
&gt; &gt;<br>
&gt; &gt; Unfortunately, I&#39;ve noticed an increase in boot time during<b=
r>
&gt; &gt; the initial SeaBIOS part of QEMU with my changes.<br>
&gt; &gt;<br>
&gt; &gt; Will need to debug to see which change is causing this.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m at a conference this week, so it might take until next<br=
>
&gt; &gt; week until I have time to figure out why this is happening.<br>
&gt; &gt;<br>
&gt; &gt; So unfortunately, I think we need to hold off with my series<br>
&gt; &gt; for now.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Shame. Feel free to resend it once you&#39;ve isolated the problem and=
 I&#39;ll try<br>
&gt; to fast-track it, since it&#39;d be nice to have my more embarrassing =
mistakes<br>
&gt; for NCQ fixed :)<br>
&gt; <br>
&gt; (If I become hard to reach, please ping me with a direct, non-patch em=
ail<br>
&gt; so it bubbles up to the top of my inbox.)<br>
&gt; <br>
&gt; ((...by the way, what are you working on? What motivates the interest =
in<br>
&gt; AHCI/SATA now? Can you say?))<br>
<br>
Hello John,<br>
<br>
It is simple, Western Digital is still selling a lot of SATA drives :)<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Haha!=
 Fair enough. I built my first computer without a single AHCI device in it =
last year, but you can&#39;t say the same for my Synology downstairs in my =
networking closet :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
And we used QEMU to verify some of the support for Command Duration Limits<=
br>
in linux:<br>
<a href=3D"https://lore.kernel.org/linux-scsi/20230511011356.227789-1-nks@f=
lawful.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.k=
ernel.org/linux-scsi/20230511011356.227789-1-nks@flawful.org/</a></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ah-ha, that he=
lps explain it :)</div><div dir=3D"auto"><br></div><div dir=3D"auto">If you=
 find other problems, even if you don&#39;t intend to fix them, please file=
 a gitlab issue to document that there&#39;s work that needs done.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>
<br>
Right now, I don&#39;t intend to upstream all my hacky patches to QEMU,<br>
just the things that might be useful for everyone, e.g. GPL and NCQ error l=
og<br>
(and possibly Sense Data Reporting feature set support, and NCQ autosense).=
<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Got it, thanks! I&#39;ll try to set aside time to look over your patches &q=
uot;soon&quot;, I&#39;d like then for 8.1. If I go quiet, *please* ping me.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<br>
<br>
Kind regards,<br>
Niklas<br>
</blockquote></div></div></div>

--0000000000002768a905fd141491--


