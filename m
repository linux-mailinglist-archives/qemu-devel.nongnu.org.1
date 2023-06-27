Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179AD73FA3C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5wR-0000qR-Au; Tue, 27 Jun 2023 06:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1qE5wP-0000q4-Be; Tue, 27 Jun 2023 06:28:57 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1qE5wN-0002Xw-1d; Tue, 27 Jun 2023 06:28:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51da8340ab4so1341129a12.1; 
 Tue, 27 Jun 2023 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687861732; x=1690453732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BIAlnvIwV0yHSQ0TFiuOAaQnctARPD4okO+94T+mJ9Q=;
 b=hFDikwpWHLs2UCCpxn5k649xRL6Nw2MIdmeR7DkWGXU3vipBEkTW0K8/66gUm3qbyS
 82rsAdRP+aaVlPkVVZ2Dbq2HntFgJcB/Gso8FvxyW+1sRDqfGsylfDklkD07yGGcSzW4
 U3Tt2n0EPZ3njLXtehwvBp+X6p4JKt7W2FRHrG/lSG5eCIVQ54V5x40uh03tgfYVJxxB
 3K4orBpMK0+1wOTJT/7jBE5kn9XBD+T411461sQT73Ez8AK4oB9wOFJjx6GqLvXjlrZA
 LiIsB40n/h86V4qtVXPsds718h2KsvnfJEHLtd+1d55gXRzPPyAcnD3neDVZMNRzroZt
 SMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687861732; x=1690453732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BIAlnvIwV0yHSQ0TFiuOAaQnctARPD4okO+94T+mJ9Q=;
 b=ZmN6SETS4fu+mGkVRrPopjNWBoS4GNroU0f3avdbag4oCDnqk5lAw/1uxB2s1xL+q6
 E1fT+tJlLT98tZcGlhyp/+ewRDqpX5lvoRC7wP27xCCeXKKir7Gd9EVv5MvnKvn/LHMo
 +KR5WJ0ato80t9rqk+xI5fl8Yp4qxmhf6tWh7UKaDeheKgrm/IDV6vpAuvqjEsuZBfGA
 i42aV9+QjfNo1oSXjdw5LeTvMdYaHEAhe3P5PZnQlcmHk5+8EpjnS/4NBq5IOQu1w/jk
 PLFUK0wREonjEGmcqI6igaI94yyKa0tuz1yQ/0lsz8/E1SmDSTKGxyMR7cUgHIVYJfIA
 T8kw==
X-Gm-Message-State: AC+VfDxTSJgJOclQC8FN3xxiL0u4r9RIZjrj79pgqrfaOwykgE2mq/nX
 8BoItcl22jkTJBT7YncgPM6WsCjJ4vhhuFSOfEI=
X-Google-Smtp-Source: ACHHUZ60BGH98BDrR9A/aav9qGeQ/Hft8iQZ9K6NIEhpbUmSOqsry9nYcKTGl81OIqxAm0mNofRltKi6vJG2owOdOYo=
X-Received: by 2002:a05:6402:50d4:b0:51d:a5c6:37c1 with SMTP id
 h20-20020a05640250d400b0051da5c637c1mr2474845edb.1.1687861732230; Tue, 27 Jun
 2023 03:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
In-Reply-To: <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 27 Jun 2023 12:28:39 +0200
Message-ID: <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000facb3305ff19eec1"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000facb3305ff19eec1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 10:15=E2=80=AFAM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 26/06/2023 14:35, C=C3=A9dric Le Goater wrote:
>
> > On 6/23/23 14:37, C=C3=A9dric Le Goater wrote:
> >> On 6/23/23 11:10, Peter Maydell wrote:
> >>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com>
> wrote:
> >>>>
> >>>> ppc has always silently ignored access to real (physical) addresses
> >>>> with nothing behind it, which can make debugging difficult at times.
> >>>>
> >>>> It looks like the way to handle this is implement the transaction
> >>>> failed call, which most target architectures do. Notably not x86
> >>>> though, I wonder why?
> >>>
> >>> Much of this is historical legacy. QEMU originally had no
> >>> concept of "the system outside the CPU returns some kind
> >>> of bus error and the CPU raises an exception for it".
> >>> This is turn is (I think) because the x86 PC doesn't do
> >>> that: you always get back some kind of response, I think
> >>> -1 on reads and writes ignored. We added the do_transaction_failed
> >>> hook largely because we wanted it to give more accurate
> >>> emulation of this kind of thing on Arm, but as usual with new
> >>> facilities we left the other architectures to do it themselves
> >>> if they wanted -- by default the behaviour remained the same.
> >>> Some architectures have picked it up; some haven't.
> >>>
> >>> The main reason it's a bit of a pain to turn the correct
> >>> handling on is because often boards don't actually implement
> >>> all the devices they're supposed to. For a pile of legacy Arm
> >>> boards, especially where we didn't have good test images,
> >>> we use the machine flag ignore_memory_transaction_failures to
> >>> retain the legacy behaviour. (This isn't great because it's
> >>> pretty much going to mean we have that flag set on those
> >>> boards forever because nobody is going to care enough to
> >>> investigate and test.)
> >>>
> >>>> Other question is, sometimes I guess it's nice to avoid crashing in
> >>>> order to try to quickly get past some unimplemented MMIO. Maybe a
> >>>> command line option or something could turn it off? It should
> >>>> probably be a QEMU-wide option if so, so that shouldn't hold this
> >>>> series up, I can propose a option for that if anybody is worried
> >>>> about it.
> >>>
> >>> I would not recommend going any further than maybe setting the
> >>> ignore_memory_transaction_failures flag for boards you don't
> >>> care about. (But in an ideal world, don't set it and deal with
> >>> any bug reports by implementing stub versions of missing devices.
> >>> Depends how confident you are in your test coverage.)
> >>
> >> It seems it broke the "mac99" and  powernv10 machines, using the
> >> qemu-ppc-boot images which are mostly buildroot. See below for logs.
> >>
> >> Adding Mark for further testing on Mac OS.
> >
> >
> > Mac OS 9.2 fails to boot with a popup saying :
> >          Sorry, a system error occured.
> >          "Sound Manager"
> >            address error
> >          To temporarily turn off extensions, restart and
> >          hold down the shift key
> >
> >
> > Darwin and Mac OSX look OK.
>
> My guess would be that MacOS 9.2 is trying to access the sound chip
> registers which
> isn't implemented in QEMU for the moment (I have a separate screamer
> branch
> available, but it's not ready for primetime yet). In theory they shouldn'=
t
> be
> accessed at all because the sound device isn't present in the OpenBIOS
> device tree,
> but this is all fairly old stuff.
>
> Does implementing the sound registers using a dummy device help at all?
>
>
My uneducated guess is that you stumbled on a longstanding, but
intermittently occurring, issue specific to Mac OS 9.2 related to sound
support over USB in Apple monitors.
I believe It is not fixed by the patch set from the 23 of june, I still get
system errors when running Mac OS 9.2 with the mac99 machine after applying
them.
Mac OS 9.2 has required mac99,via=3Dpmu for a long time now to always boot
successfully. (while 9.0.4 requires mac99 to boot, due to an undiagnosed
OHCI USB problem with the specific drivers that ship with it.)  ;-)

Best,
Howard


>
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 265c0bbd8d..e55f938da7 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -26,6 +26,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
> +#include "hw/misc/unimp.h"
>   #include "hw/misc/macio/cuda.h"
>   #include "hw/pci/pci.h"
>   #include "hw/ppc/mac_dbdma.h"
> @@ -94,6 +95,7 @@ static bool macio_common_realize(PCIDevice *d, Error
> **errp)
>   {
>       MacIOState *s =3D MACIO(d);
>       SysBusDevice *sbd;
> +    DeviceState *dev;
>
>       if (!qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), errp)) {
>           return false;
> @@ -102,6 +104,14 @@ static bool macio_common_realize(PCIDevice *d, Error
> **errp)
>       memory_region_add_subregion(&s->bar, 0x08000,
>                                   sysbus_mmio_get_region(sbd, 0));
>
> +    dev =3D qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
> +    qdev_prop_set_string(dev, "name", "screamer");
> +    qdev_prop_set_uint64(dev, "size", 0x1000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sbd =3D SYS_BUS_DEVICE(dev);
> +    memory_region_add_subregion(&s->bar, 0x14000,
> +                                sysbus_mmio_get_region(sbd, 0));
> +
>       qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>       qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>       qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.=
h
> index 86df2c2b60..1894178a68 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -109,6 +109,7 @@ struct MacIOState {
>       PMUState pmu;
>       DBDMAState dbdma;
>       ESCCState escc;
> +    MemoryRegion screamer;
>       uint64_t frequency;
>   };
>
>
>
> ATB,
>
> Mark.
>
>

--000000000000facb3305ff19eec1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 27, 2023 at 10:15=E2=80=
=AFAM Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk"=
>mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 26/06/2023 14:35, C=C3=A9dric Le Goater wr=
ote:<br>
<br>
&gt; On 6/23/23 14:37, C=C3=A9dric Le Goater wrote:<br>
&gt;&gt; On 6/23/23 11:10, Peter Maydell wrote:<br>
&gt;&gt;&gt; On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin &lt;<a href=3D"m=
ailto:npiggin@gmail.com" target=3D"_blank">npiggin@gmail.com</a>&gt; wrote:=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ppc has always silently ignored access to real (physical) =
addresses<br>
&gt;&gt;&gt;&gt; with nothing behind it, which can make debugging difficult=
 at times.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; It looks like the way to handle this is implement the tran=
saction<br>
&gt;&gt;&gt;&gt; failed call, which most target architectures do. Notably n=
ot x86<br>
&gt;&gt;&gt;&gt; though, I wonder why?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Much of this is historical legacy. QEMU originally had no<br>
&gt;&gt;&gt; concept of &quot;the system outside the CPU returns some kind<=
br>
&gt;&gt;&gt; of bus error and the CPU raises an exception for it&quot;.<br>
&gt;&gt;&gt; This is turn is (I think) because the x86 PC doesn&#39;t do<br=
>
&gt;&gt;&gt; that: you always get back some kind of response, I think<br>
&gt;&gt;&gt; -1 on reads and writes ignored. We added the do_transaction_fa=
iled<br>
&gt;&gt;&gt; hook largely because we wanted it to give more accurate<br>
&gt;&gt;&gt; emulation of this kind of thing on Arm, but as usual with new<=
br>
&gt;&gt;&gt; facilities we left the other architectures to do it themselves=
<br>
&gt;&gt;&gt; if they wanted -- by default the behaviour remained the same.<=
br>
&gt;&gt;&gt; Some architectures have picked it up; some haven&#39;t.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The main reason it&#39;s a bit of a pain to turn the correct<b=
r>
&gt;&gt;&gt; handling on is because often boards don&#39;t actually impleme=
nt<br>
&gt;&gt;&gt; all the devices they&#39;re supposed to. For a pile of legacy =
Arm<br>
&gt;&gt;&gt; boards, especially where we didn&#39;t have good test images,<=
br>
&gt;&gt;&gt; we use the machine flag ignore_memory_transaction_failures to<=
br>
&gt;&gt;&gt; retain the legacy behaviour. (This isn&#39;t great because it&=
#39;s<br>
&gt;&gt;&gt; pretty much going to mean we have that flag set on those<br>
&gt;&gt;&gt; boards forever because nobody is going to care enough to<br>
&gt;&gt;&gt; investigate and test.)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Other question is, sometimes I guess it&#39;s nice to avoi=
d crashing in<br>
&gt;&gt;&gt;&gt; order to try to quickly get past some unimplemented MMIO. =
Maybe a<br>
&gt;&gt;&gt;&gt; command line option or something could turn it off? It sho=
uld<br>
&gt;&gt;&gt;&gt; probably be a QEMU-wide option if so, so that shouldn&#39;=
t hold this<br>
&gt;&gt;&gt;&gt; series up, I can propose a option for that if anybody is w=
orried<br>
&gt;&gt;&gt;&gt; about it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I would not recommend going any further than maybe setting the=
<br>
&gt;&gt;&gt; ignore_memory_transaction_failures flag for boards you don&#39=
;t<br>
&gt;&gt;&gt; care about. (But in an ideal world, don&#39;t set it and deal =
with<br>
&gt;&gt;&gt; any bug reports by implementing stub versions of missing devic=
es.<br>
&gt;&gt;&gt; Depends how confident you are in your test coverage.)<br>
&gt;&gt;<br>
&gt;&gt; It seems it broke the &quot;mac99&quot; and=C2=A0 powernv10 machin=
es, using the<br>
&gt;&gt; qemu-ppc-boot images which are mostly buildroot. See below for log=
s.<br>
&gt;&gt;<br>
&gt;&gt; Adding Mark for further testing on Mac OS.<br>
&gt; <br>
&gt; <br>
&gt; Mac OS 9.2 fails to boot with a popup saying :<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sorry, a system error=
 occured.<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;Sound Manager&q=
uot;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 address e=
rror<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To temporarily turn o=
ff extensions, restart and<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hold down the shift k=
ey<br>
&gt; <br>
&gt; <br>
&gt; Darwin and Mac OSX look OK.<br>
<br>
My guess would be that MacOS 9.2 is trying to access the sound chip registe=
rs which <br>
isn&#39;t implemented in QEMU for the moment (I have a separate screamer br=
anch <br>
available, but it&#39;s not ready for primetime yet). In theory they should=
n&#39;t be <br>
accessed at all because the sound device isn&#39;t present in the OpenBIOS =
device tree, <br>
but this is all fairly old stuff.<br>
<br>
Does implementing the sound registers using a dummy device help at all?<br>
<br></blockquote><div><br></div><div>My uneducated guess is that you stumbl=
ed on a longstanding, but intermittently occurring, issue specific to Mac O=
S 9.2 related to sound support over USB in Apple monitors. <br></div><div>I=
 believe It is not fixed by the patch set from the 23 of june, I still get =
system errors when running Mac OS 9.2 with the mac99 machine after applying=
 them.<br></div><div>Mac OS 9.2 has required mac99,via=3Dpmu for a long tim=
e now to always boot successfully. (while 9.0.4 requires mac99 to boot, due=
 to an undiagnosed OHCI USB problem with the specific drivers that ship wit=
h it.)=C2=A0 ;-)</div><div><br></div><div>Best,</div><div>Howard<br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c<br>
index 265c0bbd8d..e55f938da7 100644<br>
--- a/hw/misc/macio/macio.c<br>
+++ b/hw/misc/macio/macio.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
=C2=A0 #include &quot;qapi/error.h&quot;<br>
=C2=A0 #include &quot;qemu/module.h&quot;<br>
+#include &quot;hw/misc/unimp.h&quot;<br>
=C2=A0 #include &quot;hw/misc/macio/cuda.h&quot;<br>
=C2=A0 #include &quot;hw/pci/pci.h&quot;<br>
=C2=A0 #include &quot;hw/ppc/mac_dbdma.h&quot;<br>
@@ -94,6 +95,7 @@ static bool macio_common_realize(PCIDevice *d, Error **er=
rp)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 MacIOState *s =3D MACIO(d);<br>
=C2=A0 =C2=A0 =C2=A0 SysBusDevice *sbd;<br>
+=C2=A0 =C2=A0 DeviceState *dev;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 if (!qdev_realize(DEVICE(&amp;s-&gt;dbdma), BUS(&amp;s=
-&gt;macio_bus), errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
@@ -102,6 +104,14 @@ static bool macio_common_realize(PCIDevice *d, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;bar, 0x08000,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_get_region(sbd, 0=
));<br>
<br>
+=C2=A0 =C2=A0 dev =3D qdev_new(TYPE_UNIMPLEMENTED_DEVICE);<br>
+=C2=A0 =C2=A0 qdev_prop_set_string(dev, &quot;name&quot;, &quot;screamer&q=
uot;);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint64(dev, &quot;size&quot;, 0x1000);<br>
+=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &amp;error_fat=
al);<br>
+=C2=A0 =C2=A0 sbd =3D SYS_BUS_DEVICE(dev);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;bar, 0x14000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_get_region(sbd, 0));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;escc), &quot;di=
sabled&quot;, 0);<br>
=C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;escc), &quot;fr=
equency&quot;, ESCC_CLOCK);<br>
=C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;escc), &quot;it=
_shift&quot;, 4);<br>
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h<=
br>
index 86df2c2b60..1894178a68 100644<br>
--- a/include/hw/misc/macio/macio.h<br>
+++ b/include/hw/misc/macio/macio.h<br>
@@ -109,6 +109,7 @@ struct MacIOState {<br>
=C2=A0 =C2=A0 =C2=A0 PMUState pmu;<br>
=C2=A0 =C2=A0 =C2=A0 DBDMAState dbdma;<br>
=C2=A0 =C2=A0 =C2=A0 ESCCState escc;<br>
+=C2=A0 =C2=A0 MemoryRegion screamer;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t frequency;<br>
=C2=A0 };<br>
<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div>

--000000000000facb3305ff19eec1--

