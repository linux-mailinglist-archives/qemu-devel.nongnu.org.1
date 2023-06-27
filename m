Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988373FBAF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7SM-0001FE-Sv; Tue, 27 Jun 2023 08:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1qE7SB-0001Eq-OP; Tue, 27 Jun 2023 08:05:52 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1qE7S8-0008UI-TJ; Tue, 27 Jun 2023 08:05:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so5831300a12.1; 
 Tue, 27 Jun 2023 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687867547; x=1690459547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4N9ALCKtOtwXG6YA4OXBhX7opJg97tZPcXxotdHLaE=;
 b=rzmHEW8QgyYUWqC2Z0v4OG63srP/KuM3UYpgzVseDl6mi9s0y/J4/yxMOc1+5/Wqu4
 z9IWO+fGwTvteBmwajXATQL88joWOizP8LyPxEvj3AsqXzEw+k5BUxnq3vprrxeGQvU8
 DauqOBSVrGSysafZF0lmIFZ7err+ZslLzo6gGHNfq52MpEsXeXxIsrP8MTm28MWg83bL
 GEuZNrtFbnfPKfcGcuVuo7NlZ2UzKJzc3rVAnQciY1W9klb1UHpvAC6ALz/X2RqhXYZ2
 XFJt6xQSFj/Y9jM8EZD7OOgpRgBj1rZsejK/3KSZQV5G11SOwOuipjqPfMg6yaIZV0k7
 cUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867547; x=1690459547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z4N9ALCKtOtwXG6YA4OXBhX7opJg97tZPcXxotdHLaE=;
 b=EuDt8UenPEMhIFVPPwfzClaDG92kYiq2QZVO8MSSvckIYZLXtsjlZpOd71zChmXhZf
 L34doRLxzW0I6D5macM47d1jbgc0vP9RTl+KTv5MJfI9igDEDVOj18zArW69ExOYZcXR
 Kp6codxmL8Pb3AEw7kF4fpHY3YJYSwYm4//qZNrMuejEOLFkCHpKTd1QkoCNYMjp2R1f
 i9rl18yOWW0cHLG9Hu2G1T86ircWk45eW9SwyhNE4kDUDldoKZ2AbGDCEbCD4a4mptgZ
 ci7umxtvTaYAP9zsthjrm7NmMW1z6RuDu4Dugeso4l3vmO89LgD/nLGD7E1MJLNRHquO
 1rsw==
X-Gm-Message-State: AC+VfDzGGl+AlOrs7NzXNeVkngHbS6zEASgkTZyTKVulq0JBbbOk6VEv
 KJLdZIq+HdjyY1C0Ly1WJroQ/ERbwHjbrUH6Uuo=
X-Google-Smtp-Source: ACHHUZ6rT07+03nSgZNKuxfqGV+tqoxRzPuk4r1CTb56XIxoCn2lWRcUBiaQMWyfSO/5pUFpcGpc7kouIR/ZjtTSaUg=
X-Received: by 2002:aa7:d80b:0:b0:51b:ec89:ba9b with SMTP id
 v11-20020aa7d80b000000b0051bec89ba9bmr11831467edq.11.1687867546466; Tue, 27
 Jun 2023 05:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
 <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
 <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
In-Reply-To: <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 27 Jun 2023 14:05:32 +0200
Message-ID: <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Greg Kurz <groug@kaod.org>, Frederic Barrat <frederic.barrat@fr.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000088fe2105ff1b4957"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--00000000000088fe2105ff1b4957
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 1:24=E2=80=AFPM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 27/06/2023 11:28, Howard Spoelstra wrote:
>
> > On Tue, Jun 27, 2023 at 10:15=E2=80=AFAM Mark Cave-Ayland <
> mark.cave-ayland@ilande.co.uk
> > <mailto:mark.cave-ayland@ilande.co.uk>> wrote:
> >
> >     On 26/06/2023 14:35, C=C3=A9dric Le Goater wrote:
> >
> >      > On 6/23/23 14:37, C=C3=A9dric Le Goater wrote:
> >      >> On 6/23/23 11:10, Peter Maydell wrote:
> >      >>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <
> npiggin@gmail.com
> >     <mailto:npiggin@gmail.com>> wrote:
> >      >>>>
> >      >>>> ppc has always silently ignored access to real (physical)
> addresses
> >      >>>> with nothing behind it, which can make debugging difficult at
> times.
> >      >>>>
> >      >>>> It looks like the way to handle this is implement the
> transaction
> >      >>>> failed call, which most target architectures do. Notably not
> x86
> >      >>>> though, I wonder why?
> >      >>>
> >      >>> Much of this is historical legacy. QEMU originally had no
> >      >>> concept of "the system outside the CPU returns some kind
> >      >>> of bus error and the CPU raises an exception for it".
> >      >>> This is turn is (I think) because the x86 PC doesn't do
> >      >>> that: you always get back some kind of response, I think
> >      >>> -1 on reads and writes ignored. We added the
> do_transaction_failed
> >      >>> hook largely because we wanted it to give more accurate
> >      >>> emulation of this kind of thing on Arm, but as usual with new
> >      >>> facilities we left the other architectures to do it themselves
> >      >>> if they wanted -- by default the behaviour remained the same.
> >      >>> Some architectures have picked it up; some haven't.
> >      >>>
> >      >>> The main reason it's a bit of a pain to turn the correct
> >      >>> handling on is because often boards don't actually implement
> >      >>> all the devices they're supposed to. For a pile of legacy Arm
> >      >>> boards, especially where we didn't have good test images,
> >      >>> we use the machine flag ignore_memory_transaction_failures to
> >      >>> retain the legacy behaviour. (This isn't great because it's
> >      >>> pretty much going to mean we have that flag set on those
> >      >>> boards forever because nobody is going to care enough to
> >      >>> investigate and test.)
> >      >>>
> >      >>>> Other question is, sometimes I guess it's nice to avoid
> crashing in
> >      >>>> order to try to quickly get past some unimplemented MMIO.
> Maybe a
> >      >>>> command line option or something could turn it off? It should
> >      >>>> probably be a QEMU-wide option if so, so that shouldn't hold
> this
> >      >>>> series up, I can propose a option for that if anybody is
> worried
> >      >>>> about it.
> >      >>>
> >      >>> I would not recommend going any further than maybe setting the
> >      >>> ignore_memory_transaction_failures flag for boards you don't
> >      >>> care about. (But in an ideal world, don't set it and deal with
> >      >>> any bug reports by implementing stub versions of missing
> devices.
> >      >>> Depends how confident you are in your test coverage.)
> >      >>
> >      >> It seems it broke the "mac99" and  powernv10 machines, using th=
e
> >      >> qemu-ppc-boot images which are mostly buildroot. See below for
> logs.
> >      >>
> >      >> Adding Mark for further testing on Mac OS.
> >      >
> >      >
> >      > Mac OS 9.2 fails to boot with a popup saying :
> >      >          Sorry, a system error occured.
> >      >          "Sound Manager"
> >      >            address error
> >      >          To temporarily turn off extensions, restart and
> >      >          hold down the shift key
> >      >
> >      >
> >      > Darwin and Mac OSX look OK.
> >
> >     My guess would be that MacOS 9.2 is trying to access the sound chip
> registers which
> >     isn't implemented in QEMU for the moment (I have a separate screame=
r
> branch
> >     available, but it's not ready for primetime yet). In theory they
> shouldn't be
> >     accessed at all because the sound device isn't present in the
> OpenBIOS device tree,
> >     but this is all fairly old stuff.
> >
> >     Does implementing the sound registers using a dummy device help at
> all?
> >
> >
> > My uneducated guess is that you stumbled on a longstanding, but
> intermittently
> > occurring, issue specific to Mac OS 9.2 related to sound support over
> USB in Apple
> > monitors.
>
> I'm not sure I understand this: are there non-standard command line
> options being
> used here other than "qemu-system-ppc -M mac99 -cdrom macos92.iso -boot d=
"?
>


It must be my windows host ;-)

qemu-system-ppc.exe -M mac99,via=3Dpmu -cdrom C:\mac-iso\9.2.2.iso -boot d =
-L
pc-bios
crashes Mac OS with an address error. (with unpatched and patched builds).

qemu-system-ppc.exe -M mac99 -hda C:\mac-hd\9.2.2-clean.img -boot c -L
pc-bios sometimes crashes with an illegal instruction.

qemu-system-ppc.exe -M mac99,via=3Dpmu -hda C:\mac-hd\9.2.2-clean.img -boot=
 c
-L pc-bios sometimes crashes with Sound manager address error.
(with both patched and non-patched versions).

Best,
Howard



>
> > I believe It is not fixed by the patch set from the 23 of june, I still
> get system
> > errors when running Mac OS 9.2 with the mac99 machine after applying
> them.
> > Mac OS 9.2 has required mac99,via=3Dpmu for a long time now to always b=
oot
> > successfully. (while 9.0.4 requires mac99 to boot, due to an undiagnose=
d
> OHCI USB
> > problem with the specific drivers that ship with it.)  ;-)
>
> I always test MacOS 9.2 boot both with and without via=3Dpmu for my OpenB=
IOS
> tests, so
> I'd expect this to work unless a regression has slipped in?
>
>
> ATB,
>
> Mark.
>
>

--00000000000088fe2105ff1b4957
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 27, 2023 at 1:24=E2=80=AF=
PM Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk">ma=
rk.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On 27/06/2023 11:28, Howard Spoelstra wrote:<br>
<br>
&gt; On Tue, Jun 27, 2023 at 10:15=E2=80=AFAM Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"_blank">mark.cave-aylan=
d@ilande.co.uk</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"=
_blank">mark.cave-ayland@ilande.co.uk</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 26/06/2023 14:35, C=C3=A9dric Le Goater wrote:<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On 6/23/23 14:37, C=C3=A9dric Le Goater wrote=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; On 6/23/23 11:10, Peter Maydell wrote:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; On Fri, 23 Jun 2023 at 09:21, Nichola=
s Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" target=3D"_blank">npiggin=
@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; ppc has always silently ignored a=
ccess to real (physical) addresses<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; with nothing behind it, which can=
 make debugging difficult at times.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; It looks like the way to handle t=
his is implement the transaction<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; failed call, which most target ar=
chitectures do. Notably not x86<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; though, I wonder why?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Much of this is historical legacy. QE=
MU originally had no<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; concept of &quot;the system outside t=
he CPU returns some kind<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; of bus error and the CPU raises an ex=
ception for it&quot;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; This is turn is (I think) because the=
 x86 PC doesn&#39;t do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; that: you always get back some kind o=
f response, I think<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; -1 on reads and writes ignored. We ad=
ded the do_transaction_failed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; hook largely because we wanted it to =
give more accurate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; emulation of this kind of thing on Ar=
m, but as usual with new<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; facilities we left the other architec=
tures to do it themselves<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; if they wanted -- by default the beha=
viour remained the same.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Some architectures have picked it up;=
 some haven&#39;t.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; The main reason it&#39;s a bit of a p=
ain to turn the correct<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; handling on is because often boards d=
on&#39;t actually implement<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; all the devices they&#39;re supposed =
to. For a pile of legacy Arm<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; boards, especially where we didn&#39;=
t have good test images,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; we use the machine flag ignore_memory=
_transaction_failures to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; retain the legacy behaviour. (This is=
n&#39;t great because it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; pretty much going to mean we have tha=
t flag set on those<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; boards forever because nobody is goin=
g to care enough to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; investigate and test.)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; Other question is, sometimes I gu=
ess it&#39;s nice to avoid crashing in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; order to try to quickly get past =
some unimplemented MMIO. Maybe a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; command line option or something =
could turn it off? It should<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; probably be a QEMU-wide option if=
 so, so that shouldn&#39;t hold this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; series up, I can propose a option=
 for that if anybody is worried<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; about it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; I would not recommend going any furth=
er than maybe setting the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; ignore_memory_transaction_failures fl=
ag for boards you don&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; care about. (But in an ideal world, d=
on&#39;t set it and deal with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; any bug reports by implementing stub =
versions of missing devices.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Depends how confident you are in your=
 test coverage.)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; It seems it broke the &quot;mac99&quot; a=
nd=C2=A0 powernv10 machines, using the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; qemu-ppc-boot images which are mostly bui=
ldroot. See below for logs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Adding Mark for further testing on Mac OS=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Mac OS 9.2 fails to boot with a popup saying =
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Sorry, a system error occured.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &quot;Sound Manager&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 address error<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 To temporarily turn off extensions, restart and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 hold down the shift key<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Darwin and Mac OSX look OK.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0My guess would be that MacOS 9.2 is trying to acces=
s the sound chip registers which<br>
&gt;=C2=A0 =C2=A0 =C2=A0isn&#39;t implemented in QEMU for the moment (I hav=
e a separate screamer branch<br>
&gt;=C2=A0 =C2=A0 =C2=A0available, but it&#39;s not ready for primetime yet=
). In theory they shouldn&#39;t be<br>
&gt;=C2=A0 =C2=A0 =C2=A0accessed at all because the sound device isn&#39;t =
present in the OpenBIOS device tree,<br>
&gt;=C2=A0 =C2=A0 =C2=A0but this is all fairly old stuff.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Does implementing the sound registers using a dummy=
 device help at all?<br>
&gt; <br>
&gt; <br>
&gt; My uneducated guess is that you stumbled on a longstanding, but interm=
ittently <br>
&gt; occurring, issue specific to Mac OS 9.2 related to sound support over =
USB in Apple <br>
&gt; monitors.<br>
<br>
I&#39;m not sure I understand this: are there non-standard command line opt=
ions being <br>
used here other than &quot;qemu-system-ppc -M mac99 -cdrom macos92.iso -boo=
t d&quot;?<br></blockquote><div><br></div><div><br></div><div>It must be my=
 windows host ;-)<br></div><div><br></div><div>qemu-system-ppc.exe -M mac99=
,via=3Dpmu -cdrom C:\mac-iso\9.2.2.iso -boot d -L pc-bios</div><div>crashes=
 Mac OS with an address error. (with unpatched and patched builds).</div><d=
iv><br></div><div>qemu-system-ppc.exe -M mac99 -hda C:\mac-hd\9.2.2-clean.i=
mg -boot c -L pc-bios sometimes crashes with an illegal instruction.</div><=
div><br></div><div>qemu-system-ppc.exe -M mac99,via=3Dpmu -hda C:\mac-hd\9.=
2.2-clean.img -boot c -L pc-bios sometimes crashes with Sound manager addre=
ss error.</div><div>(with both patched and non-patched versions).<br></div>=
<div><br></div><div>Best,</div><div>Howard<br></div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; I believe It is not fixed by the patch set from the 23 of june, I stil=
l get system <br>
&gt; errors when running Mac OS 9.2 with the mac99 machine after applying t=
hem.<br>
&gt; Mac OS 9.2 has required mac99,via=3Dpmu for a long time now to always =
boot <br>
&gt; successfully. (while 9.0.4 requires mac99 to boot, due to an undiagnos=
ed OHCI USB <br>
&gt; problem with the specific drivers that ship with it.)=C2=A0 ;-)<br>
<br>
I always test MacOS 9.2 boot both with and without via=3Dpmu for my OpenBIO=
S tests, so <br>
I&#39;d expect this to work unless a regression has slipped in?<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div>

--00000000000088fe2105ff1b4957--

