Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E086770CC2D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 23:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ctb-0002KV-GL; Mon, 22 May 2023 17:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.p.albecki@gmail.com>)
 id 1q1CtT-0002If-Mm
 for qemu-devel@nongnu.org; Mon, 22 May 2023 17:16:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mateusz.p.albecki@gmail.com>)
 id 1q1CtQ-0005gU-9y
 for qemu-devel@nongnu.org; Mon, 22 May 2023 17:16:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae50da739dso42895485ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684790194; x=1687382194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/P3TD2k486dV4K7wpSPCrcrmQYOe4deMXS7flmpOPEw=;
 b=Pb+YOB9f+IbA5INjHug6cF6/dTGeN2DfsNvYnF1OsT6I1Jyap7pwsvafKK2F2YM1z6
 6dNmt8oWQk63xP80BB6FWXuDZNIy3T/rUTx3uxC+nv2cTxp1h1K61NienCa1aMURSDl5
 6IkD17lUOp2s+qQdI0mdzVF+SsiK2yMUroMVWNI8vo3UhCcU4idcAdISRbGA3lmCmVO5
 Tm3TqyiDVMBsR49ZyAK3m9ZPz2uQYZ3PJ0MrR/pslShzJ+PzzTupJYWFyCW8zJ9UNYKQ
 M99Sb9ChlElNrqBZdqI6/gkg70kjhVSjg+0oubBnu9CGCZ3drf30dDTIJfpAGaZJJyQp
 LeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684790194; x=1687382194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/P3TD2k486dV4K7wpSPCrcrmQYOe4deMXS7flmpOPEw=;
 b=TjxRm6dbRtdmsRN8B6y8vPz78XsUQ1WP7YlzJN0OKrIlUtRoCpo9LxEy1zlLnTvaTa
 oT2ujH6tH/bOtspEfi9Bt0c7ivrmvSEtq6+cyGIR/FDjWsm8VwqPb5ST9zIfmmggmU8a
 5NFc234csqUn/tRms7WOTUUyJ2fAzbw9+jXLI2QXv0vS+7flqY7c9y46aJEa7SleC4Rz
 Mf5sjjsDS0oCfSe3K2f7SDQd1WQ9B7he3o0HLJMhw2FnCsfFxMLnn2GNG5Rk9s8EJqMI
 Mk9u8PRXRDt9nHrQR5pVVw/jaxgaRZ37GGsHEgYM5PP770wyKbr1VQaVnTNrEMLsNC8T
 l8Wg==
X-Gm-Message-State: AC+VfDxINn+2klDWDimoztgtNkkbVnaPXDdv9t/TRn3TcGbXYZ5T3bzl
 b6retFZuQafbHHMeyXMIJyexh7I1WhXn4O/cWiA=
X-Google-Smtp-Source: ACHHUZ6TJxuBrQyyWqlJHA6wRrQ237N4hXIZdnA1BHFwKseznO77NrUbw/isLTJbpSSZpByafZa9F8LpBHI6I4eOvpw=
X-Received: by 2002:a17:903:1c8:b0:1ae:3dcd:30fc with SMTP id
 e8-20020a17090301c800b001ae3dcd30fcmr13354477plh.11.1684790194506; Mon, 22
 May 2023 14:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230416222838.36642-1-mateusz.p.albecki@gmail.com>
 <20230416222838.36642-2-mateusz.p.albecki@gmail.com>
 <CAFn=p-bcAW9aMymmWeVSMeyuT88YDZ2iYVh-t1GoogbBBPFjSw@mail.gmail.com>
In-Reply-To: <CAFn=p-bcAW9aMymmWeVSMeyuT88YDZ2iYVh-t1GoogbBBPFjSw@mail.gmail.com>
From: Mateusz Albecki <mateusz.p.albecki@gmail.com>
Date: Mon, 22 May 2023 23:16:23 +0200
Message-ID: <CAGe=PKEvnnjBQVx-rNDXjmwvQ272S2DLw-xEDjp1vVuU30i4Hw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core.c: fix handling of unsupported commands
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Mateusz Albecki <mateusz.albecki@outlook.com>, 
 Niklas Cassel <niklas.cassel@wdc.com>, Niklas Cassel <nks@flawful.org>
Content-Type: multipart/alternative; boundary="000000000000108faa05fc4ec962"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=mateusz.p.albecki@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

--000000000000108faa05fc4ec962
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Certainly seems like my patch is wrong as it will make the abort path
execute ide_cmd_done twice. During debug I came to the conclusion that
ide_cmd_done is not called at all as I was getting timeouts on the driver
side while waiting for D2H FIS. I am still not sure how I was getting this
behavior if the problem was actually with setting correct error bits. Even
so I think it can be safely assumed that Niklas' change will solve the
issue, I will try to verify it in a couple of days and if I see any problem
I will come back to you.

Mateusz

On Wed, 17 May 2023 at 23:33, John Snow <jsnow@redhat.com> wrote:

> On Sun, Apr 16, 2023 at 6:29=E2=80=AFPM Mateusz Albecki
> <mateusz.p.albecki@gmail.com> wrote:
> >
> > From: Mateusz Albecki <mateusz.albecki@outlook.com>
> >
> > Current code will not call ide_cmd_done when aborting the unsupported
> > command which will lead to the command timeout on the driver side inste=
ad
> > of getting a D2H FIS with ABRT indication. This can lead to problems on
> the
> > driver side as the spec mandates that device should return a D2H FIS wi=
th
> > ABRT bit set in ERR register(from SATA 3.1 section 16.3.3.8.6)
> >
> > Signed-off-by: Mateusz Albecki <mateusz.p.albecki@gmail.com>
> > ---
> >  hw/ide/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/ide/core.c b/hw/ide/core.c
> > index 45d14a25e9..d7027bbd4d 100644
> > --- a/hw/ide/core.c
> > +++ b/hw/ide/core.c
> > @@ -2146,6 +2146,7 @@ void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)
> >
> >      if (!ide_cmd_permitted(s, val)) {
> >          ide_abort_command(s);
> > +        ide_cmd_done(s);
> >          ide_bus_set_irq(s->bus);
> >          return;
> >      }
> > --
> > 2.40.0
> >
>
> I recently noticed that Niklas Cassel sent a patch to fix unsupported
> command handling:
> https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg05552.html
>
> I suspect that his approach is the more technically correct one and
> that calling ide_cmd_done here is a heavy cudgel that may have
> unintended consequences. Am I mistaken?
> Can you check that Niklas's patch solves your issue? I think you're
> both solving the same problem. I've CC'd him on this patch as well.
>
> --js
>
>

--000000000000108faa05fc4ec962
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Certainly seems like my patch is wrong as it will make the=
 abort path execute ide_cmd_done twice. During debug I came to the conclusi=
on that ide_cmd_done is not called at all as I was getting timeouts on the =
driver side while waiting for D2H FIS. I am still not sure how I was gettin=
g this behavior if the problem was actually with setting correct error bits=
. Even so I think it can be safely assumed that Niklas&#39; change will sol=
ve the issue, I will try to verify=C2=A0it in a couple of days and if I see=
 any problem I will come back to you.<div><br></div><div>Mateusz</div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, 17 May 2023 at 23:33, John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">=
jsnow@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Sun, Apr 16, 2023 at 6:29=E2=80=AFPM Mateusz Albecki<br>
&lt;<a href=3D"mailto:mateusz.p.albecki@gmail.com" target=3D"_blank">mateus=
z.p.albecki@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Mateusz Albecki &lt;<a href=3D"mailto:mateusz.albecki@outlook.co=
m" target=3D"_blank">mateusz.albecki@outlook.com</a>&gt;<br>
&gt;<br>
&gt; Current code will not call ide_cmd_done when aborting the unsupported<=
br>
&gt; command which will lead to the command timeout on the driver side inst=
ead<br>
&gt; of getting a D2H FIS with ABRT indication. This can lead to problems o=
n the<br>
&gt; driver side as the spec mandates that device should return a D2H FIS w=
ith<br>
&gt; ABRT bit set in ERR register(from SATA 3.1 section 16.3.3.8.6)<br>
&gt;<br>
&gt; Signed-off-by: Mateusz Albecki &lt;<a href=3D"mailto:mateusz.p.albecki=
@gmail.com" target=3D"_blank">mateusz.p.albecki@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/ide/core.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/hw/ide/core.c b/hw/ide/core.c<br>
&gt; index 45d14a25e9..d7027bbd4d 100644<br>
&gt; --- a/hw/ide/core.c<br>
&gt; +++ b/hw/ide/core.c<br>
&gt; @@ -2146,6 +2146,7 @@ void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!ide_cmd_permitted(s, val)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ide_abort_command(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ide_cmd_done(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ide_bus_set_irq(s-&gt;bus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; --<br>
&gt; 2.40.0<br>
&gt;<br>
<br>
I recently noticed that Niklas Cassel sent a patch to fix unsupported<br>
command handling:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg05552.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2023-04/msg05552.html</a><br>
<br>
I suspect that his approach is the more technically correct one and<br>
that calling ide_cmd_done here is a heavy cudgel that may have<br>
unintended consequences. Am I mistaken?<br>
Can you check that Niklas&#39;s patch solves your issue? I think you&#39;re=
<br>
both solving the same problem. I&#39;ve CC&#39;d him on this patch as well.=
<br>
<br>
--js<br>
<br>
</blockquote></div>

--000000000000108faa05fc4ec962--

