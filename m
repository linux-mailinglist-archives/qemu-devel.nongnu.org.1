Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F760772D26
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT4Af-0001h3-A3; Mon, 07 Aug 2023 13:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qT4Aa-0001e6-3p
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qT4AY-0000L5-GO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691429845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jBARGRZnSz5cdvbdUiAEcE2G3gP6wCXI6ewKIewVnA=;
 b=d06eRwu1pLmCM1KWIDOQ+GjJFmr0zZTO6bArTQbt+3zz/8qxoLDOwElFQmA1k9vNTTKZpE
 S28RYQdD3ZfM6Js9vN/4iZ9/mBBS9aecdHIXI+qXnToEOUWx2faC3BcfNo8N7dP/MfQGv+
 fPAsuFZDqEH5DZ6ylnnyCeNtM3ceBA8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-VX19HSPfOVSqB3Id59Bjog-1; Mon, 07 Aug 2023 13:37:23 -0400
X-MC-Unique: VX19HSPfOVSqB3Id59Bjog-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2685bc4f867so3040956a91.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 10:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691429842; x=1692034642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3jBARGRZnSz5cdvbdUiAEcE2G3gP6wCXI6ewKIewVnA=;
 b=aLI+99bwyZpLhjPIJYnxYftub1r0/KgZfAhTX5O+Wk74KdGQr5O58XkuaobehHeJty
 8kX7277/tQqEHMXLcw2/jHBX+OUunDA7JtHjDjLtEhFVFKaAUaUllDs1FcN0eHGkdf0c
 xuvVjIz0vUb3CL5uYPSzutAmVxiB+7JCMdcj8kY80H+XL6EYEG7UUinQ0SK61MfK2Deh
 z05cR3Ksa7qF+mreHKM7moihQj/nFWt7hzMo8vrUvsBNCuybNfSP9wMTyXCIK0haNYo9
 9vfzpn+Ii65o76Cpug8AvUZDcx5eSmj2skQtUiA/9QJxdZJWv3qpyEVp8/6GLgMyupLl
 e8qA==
X-Gm-Message-State: AOJu0YznmK4m/fvoKkhvXksBElsnP+p5HwNxy8gsdqCTAGbvFtgWytRC
 y1ms0yIWEKn1AssEm5V8dZqf0Um1TWRsLDVrRnmJupht4PGU/waToTK7ZQgrtKJ4pczdVxdEN7G
 RDGcc5PuyfU8mAOzNlfRPyvnP67bR8bM=
X-Received: by 2002:a17:90b:3e88:b0:269:3771:7342 with SMTP id
 rj8-20020a17090b3e8800b0026937717342mr5385874pjb.18.1691429842246; 
 Mon, 07 Aug 2023 10:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGAR31N5470O0LTrsg8sc814gi1Z9nJRRAaGTHUqyas3Rud7KzzQ/5tioTh3PweewLHy8bzqRvSckwCosjN68=
X-Received: by 2002:a17:90b:3e88:b0:269:3771:7342 with SMTP id
 rj8-20020a17090b3e8800b0026937717342mr5385854pjb.18.1691429841895; Mon, 07
 Aug 2023 10:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230609140844.202795-1-nks@flawful.org>
 <ZLe/VG5d6TEdp/MT@x1-carbon>
 <b58779ed-cecb-824b-019e-bc34e6b2258a@linaro.org>
 <CAFn=p-Y4Tw0eY=8yXxnzSA3kzwb36H0oysag=HD_8eMsPNwuDg@mail.gmail.com>
 <ZNDIUzyB9hmt+E1I@x1-carbon>
In-Reply-To: <ZNDIUzyB9hmt+E1I@x1-carbon>
From: John Snow <jsnow@redhat.com>
Date: Mon, 7 Aug 2023 13:37:11 -0400
Message-ID: <CAFn=p-a5GuQ9mxxTn7T7B2-_5nPq9nw1ucsmJK5WuMOwXg=cSw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] misc AHCI cleanups
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, 
 Damien Le Moal <dlemoal@kernel.org>
Content-Type: multipart/alternative; boundary="000000000000e3aaa4060258b29d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000e3aaa4060258b29d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 7, 2023, 6:33 AM Niklas Cassel <Niklas.Cassel@wdc.com> wrote:

> On Tue, Jul 25, 2023 at 03:00:56PM -0400, John Snow wrote:
> > On Tue, Jul 25, 2023 at 9:04=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> > >
> > > Hi Niklas, John, Paolo, Kevin,
> > >
> > > On 19/7/23 12:47, Niklas Cassel wrote:
> > >
> > > >> Niklas Cassel (8):
> > > >>    hw/ide/ahci: remove stray backslash
> > > >>    hw/ide/core: set ERR_STAT in unsupported command completion
> > > >>    hw/ide/ahci: write D2H FIS when processing NCQ command
> > > >>    hw/ide/ahci: simplify and document PxCI handling
> > > >>    hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleare=
d
> > > >>    hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
> > > >>    hw/ide/ahci: fix ahci_write_fis_sdb()
> > > >>    hw/ide/ahci: fix broken SError handling
> > > >>
> > > >>   hw/ide/ahci.c             | 112
> +++++++++++++++++++++++++++-----------
> > > >>   hw/ide/core.c             |   2 +-
> > > >>   tests/qtest/libqos/ahci.c | 106
> +++++++++++++++++++++++++++---------
> > > >>   tests/qtest/libqos/ahci.h |   8 +--
> > > >>   4 files changed, 164 insertions(+), 64 deletions(-)
> > > >>
> > > >> --
> > > >> 2.40.1
> > > >>
> > > >>
> > > >
> > > > Hello Philippe,
> > > >
> > > > Considering that you picked up my patch,
> > > > "hw/ide/ahci: remove stray backslash" (patch 1/8 in this series),
> > > > and since John seems to have gone silent for 40+ days,
> > > > could you please consider taking this series through your misc tree=
?
> > >
> >
> > 40 days, ouch. I kept thinking it had been a week. Don't trust me with
> time.
>
> Well, it is summer vacation times, so the days tend to fly by quite
> quickly :)
>
>
> >
> > > (First patch was a cleanup)
> > >
> > > Niklas, I don't feel confident enough :/
> > >
> > > John, Paolo, Kevin, do you Ack?
> > >
> > > Regards,
> > >
> > > Phil.
> >
> > I'm staging it, but it's for next release. We'll get it in early and
> > it gives us a chance to fix anything that's amiss before the next RC
> > window.
> >
>
> Thank you John!
>
> I don't expect any (further) issues, but I will of course be available
> in case something unexpectedly pops up.
>
>
> Kind regards,
> Niklas


Apologies again for the delay. I tested it lightly and it seems fine to me
(and in general I trust your commits as they've got meticulous references
to the spec, so it'll be easy to fix if something goes wrong)

It's my fault we'll miss this release window, but putting it in early next
window gives us a lot of time for people to notice accidental regressions.

Thanks for the patches and I hope to see more from you soon ;)

--js

--000000000000e3aaa4060258b29d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Aug 7, 2023, 6:33 AM Niklas Cassel &lt;<a href=
=3D"mailto:Niklas.Cassel@wdc.com">Niklas.Cassel@wdc.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">On Tue, Jul 25, 2023 at 03:00:56PM -040=
0, John Snow wrote:<br>
&gt; On Tue, Jul 25, 2023 at 9:04=E2=80=AFAM Philippe Mathieu-Daud=C3=A9<br=
>
&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"nore=
ferrer">philmd@linaro.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi Niklas, John, Paolo, Kevin,<br>
&gt; &gt;<br>
&gt; &gt; On 19/7/23 12:47, Niklas Cassel wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt;&gt; Niklas Cassel (8):<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 hw/ide/ahci: remove stray backslash<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 hw/ide/core: set ERR_STAT in unsupported co=
mmand completion<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 hw/ide/ahci: write D2H FIS when processing =
NCQ command<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 hw/ide/ahci: simplify and document PxCI han=
dling<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 hw/ide/ahci: PxSACT and PxCI is cleared whe=
n PxCMD.ST is cleared<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 hw/ide/ahci: PxCI should not get cleared wh=
en ERR_STAT is set<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 hw/ide/ahci: fix ahci_write_fis_sdb()<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 hw/ide/ahci: fix broken SError handling<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0hw/ide/ahci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 112 +++++++++++++++++++++++++++-----------<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0hw/ide/core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0tests/qtest/libqos/ahci.c | 106 ++++++++++++=
+++++++++++++++---------<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0tests/qtest/libqos/ahci.h |=C2=A0 =C2=A08 +-=
-<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A04 files changed, 164 insertions(+), 64 delet=
ions(-)<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; --<br>
&gt; &gt; &gt;&gt; 2.40.1<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hello Philippe,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Considering that you picked up my patch,<br>
&gt; &gt; &gt; &quot;hw/ide/ahci: remove stray backslash&quot; (patch 1/8 i=
n this series),<br>
&gt; &gt; &gt; and since John seems to have gone silent for 40+ days,<br>
&gt; &gt; &gt; could you please consider taking this series through your mi=
sc tree?<br>
&gt; &gt;<br>
&gt; <br>
&gt; 40 days, ouch. I kept thinking it had been a week. Don&#39;t trust me =
with time.<br>
<br>
Well, it is summer vacation times, so the days tend to fly by quite<br>
quickly :)<br>
<br>
<br>
&gt; <br>
&gt; &gt; (First patch was a cleanup)<br>
&gt; &gt;<br>
&gt; &gt; Niklas, I don&#39;t feel confident enough :/<br>
&gt; &gt;<br>
&gt; &gt; John, Paolo, Kevin, do you Ack?<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt;<br>
&gt; &gt; Phil.<br>
&gt; <br>
&gt; I&#39;m staging it, but it&#39;s for next release. We&#39;ll get it in=
 early and<br>
&gt; it gives us a chance to fix anything that&#39;s amiss before the next =
RC<br>
&gt; window.<br>
&gt; <br>
<br>
Thank you John!<br>
<br>
I don&#39;t expect any (further) issues, but I will of course be available<=
br>
in case something unexpectedly pops up.<br>
<br>
<br>
Kind regards,<br>
Niklas</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Apologies again for the delay. I tested it lightly and it seems fine to m=
e (and in general I trust your commits as they&#39;ve got meticulous refere=
nces to the spec, so it&#39;ll be easy to fix if something goes wrong)</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s my fault we&#39;ll =
miss this release window, but putting it in early next window gives us a lo=
t of time for people to notice accidental regressions.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Thanks for the patches and I hope to see mor=
e from you soon ;)</div><div dir=3D"auto"><br></div><div dir=3D"auto">--js<=
/div><div dir=3D"auto"></div></div>

--000000000000e3aaa4060258b29d--


