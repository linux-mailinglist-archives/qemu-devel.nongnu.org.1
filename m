Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B226B7A6440
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 15:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaME-0003mH-SH; Tue, 19 Sep 2023 09:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1qiaM0-0003iz-GQ; Tue, 19 Sep 2023 09:01:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1qiaLx-0007j5-UQ; Tue, 19 Sep 2023 09:01:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so60647245e9.0; 
 Tue, 19 Sep 2023 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695128480; x=1695733280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J9jNbPRMrRNU/LBVOlQIwvktxEl8c6v/JwodgHZNZhE=;
 b=QO+Ja8rNn2sZ4Q0YklHGuAoxGzofwuVmgZZDg9xRsX3PIqKYIpfSA8yART6OTluPUk
 d7/NbcKEq3TojDmApP9uP9GsFkoYhrPiowxxnB4GAk2PLGmcYM3iVf+eYwH/lLik1z3V
 b9ESYBhLykl8Jf2zI4ZdBqhNxVtgrwkr8yBjECT6jDU/uP5zhGw1c2Pbc0Wer6Xlz7+y
 ihN2q+JEKn7psbw3bMtPzaaUARi2Ge5VqYvSKtIa3eifojVeFyNyDn9n64G+YKOGFfMc
 a7B1al2/2XSxr9tez0Dy0KNnrP0xsoPT5Czp8OWyyI6oTSwUxP/YD+UtX5yQ9hrqOrHv
 ISVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695128480; x=1695733280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9jNbPRMrRNU/LBVOlQIwvktxEl8c6v/JwodgHZNZhE=;
 b=U+aa+PchDbum/9b7mu08Otyp5Hhm3SJp5dJoVrYbFDkeoYkLiX2Iha1Sre57ZiH2wf
 DvoFTsq8v549cytKO747FeOc4MfwYhot5hSjHdoHeqxAODbXfq2D007t0VkfMpn7/rZB
 ehUE6cuhXqD+hmReKQ/jor1KVrxk4CMdTS/VapdZiauVGc2zoiwPWG4q92pvA2kCoz05
 9s+QWsISrB6rXso3auqsrh+G6LKKkvluI3VK1wwXNw6dnOqmAMygILYZvgzJgcT8cEcH
 KTiACKtwzSUxwSV2JIriZxCDVFCoMGR9vJ0A1Y1JlprCrpjhCpZlf8k1JGWR6Ma1jbFu
 wJ8g==
X-Gm-Message-State: AOJu0YyI7nSCE1l0Wk1OUtN3+iGoPrYTqgAeFXcSaJu0d/uGtgIjaGOh
 n62ZB8lQ5Ene1hTh3lWp5lbs07fg715tXl3vzFA=
X-Google-Smtp-Source: AGHT+IGlGCo6VHvb6sdOBDXw4ssz+yKnNt2BfFoHF72gk4HzG0jO9AK7EcfLjs2sC1obmjYlAOj6a7w5OeVCi/Yl2YU=
X-Received: by 2002:adf:a3c4:0:b0:31f:f664:d87 with SMTP id
 m4-20020adfa3c4000000b0031ff6640d87mr9533523wrb.20.1695128479453; Tue, 19 Sep
 2023 06:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-7-clg@kaod.org>
 <9e061471-931c-daf8-ab8f-567ce99f5057@linux.ibm.com>
 <0f407c08-fb59-4a41-e134-4f184b5ec758@kaod.org>
In-Reply-To: <0f407c08-fb59-4a41-e134-4f184b5ec758@kaod.org>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Tue, 19 Sep 2023 18:31:08 +0530
Message-ID: <CAEuJdmqPg2TnOBE2q3c+FaP5y9g+fwk=9SG+_u17J8d=5mgp+w@mail.gmail.com>
Subject: Re: [PATCH 6/8] spapr/drc: Clean up local variable shadowing in
 rtas_ibm_configure_connector()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ddd8de0605b5da04"
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-wm1-x335.google.com
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

--000000000000ddd8de0605b5da04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Sept, 2023, 5:33 pm C=C3=A9dric Le Goater, <clg@kaod.org> wrote:

> On 9/19/23 10:29, Harsh Prateek Bora wrote:
> >
> >
> > On 9/18/23 20:28, C=C3=A9dric Le Goater wrote:
> >> Remove extra 'drc_index' variable to avoid this warning :
> >>
> >>    ../hw/ppc/spapr_drc.c: In function =E2=80=98rtas_ibm_configure_conn=
ector=E2=80=99:
> >>    ../hw/ppc/spapr_drc.c:1240:26: warning: declaration of =E2=80=98drc=
_index=E2=80=99
> shadows a previous local [-Wshadow=3Dcompatible-local]
> >>     1240 |                 uint32_t drc_index =3D spapr_drc_index(drc)=
;
> >>          |                          ^~~~~~~~~
> >>    ../hw/ppc/spapr_drc.c:1155:14: note: shadowed declaration is here
> >>     1155 |     uint32_t drc_index;
> >>          |              ^~~~~~~~~
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>   hw/ppc/spapr_drc.c | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> >> index b5c400a94d1c..843e318312d3 100644
> >> --- a/hw/ppc/spapr_drc.c
> >> +++ b/hw/ppc/spapr_drc.c
> >> @@ -1237,8 +1237,6 @@ static void
> rtas_ibm_configure_connector(PowerPCCPU *cpu,
> >>           case FDT_END_NODE:
> >>               drc->ccs_depth--;
> >>               if (drc->ccs_depth =3D=3D 0) {
> >> -                uint32_t drc_index =3D spapr_drc_index(drc);
> >> -
> > I guess you only wanted to remove re-declaration part. Assigning the
> value returned by this function doesnt seem to happen before.
>
> drc_index is assigned at the top of this large routine with :
>
>      drc_index =3D rtas_ld(wa_addr, 0);
>      drc =3D spapr_drc_by_index(drc_index);
>
>
> So, the extra local variable 'drc_index' is simply redundant because
> there are no reason for it to change. The drc object is the same AFAICT.
> Correct ? I should have explained that better in the commit log.
>

Okay, since both routines were implemented differently, I wasn't sure about
the impact of reassignment. Better commit log is always welcome.

Regards
Harsh

Thanks,
>
> C.
>
>
> >
> >>                   /* done sending the device tree, move to configured
> state */
> >>                   trace_spapr_drc_set_configured(drc_index);
> >>                   drc->state =3D drck->ready_state;
>
>
>

--000000000000ddd8de0605b5da04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, 19 Sept, 2023, 5:33 pm C=C3=A9dric Le Goater, =
&lt;<a href=3D"mailto:clg@kaod.org">clg@kaod.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">On 9/19/23 10:29, Harsh Prateek Bora wrote:<br=
>
&gt; <br>
&gt; <br>
&gt; On 9/18/23 20:28, C=C3=A9dric Le Goater wrote:<br>
&gt;&gt; Remove extra &#39;drc_index&#39; variable to avoid this warning :<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0 ../hw/ppc/spapr_drc.c: In function =E2=80=98rtas_ibm_=
configure_connector=E2=80=99:<br>
&gt;&gt; =C2=A0=C2=A0 ../hw/ppc/spapr_drc.c:1240:26: warning: declaration o=
f =E2=80=98drc_index=E2=80=99 shadows a previous local [-Wshadow=3Dcompatib=
le-local]<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 1240 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t drc_inde=
x =3D spapr_drc_index(drc);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~<br>
&gt;&gt; =C2=A0=C2=A0 ../hw/ppc/spapr_drc.c:1155:14: note: shadowed declara=
tion is here<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 1155 |=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t drc_ind=
ex;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~<b=
r>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kao=
d.org" target=3D"_blank" rel=3D"noreferrer">clg@kaod.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 hw/ppc/spapr_drc.c | 2 --<br>
&gt;&gt; =C2=A0 1 file changed, 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c<br>
&gt;&gt; index b5c400a94d1c..843e318312d3 100644<br>
&gt;&gt; --- a/hw/ppc/spapr_drc.c<br>
&gt;&gt; +++ b/hw/ppc/spapr_drc.c<br>
&gt;&gt; @@ -1237,8 +1237,6 @@ static void rtas_ibm_configure_connector(Pow=
erPCCPU *cpu,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case FDT_EN=
D_NODE:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 drc-&gt;ccs_depth--;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (drc-&gt;ccs_depth =3D=3D 0) {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t drc_index =3D spapr_drc_index(drc);<br=
>
&gt;&gt; -<br>
&gt; I guess you only wanted to remove re-declaration part. Assigning the v=
alue returned by this function doesnt seem to happen before.<br>
<br>
drc_index is assigned at the top of this large routine with :<br>
<br>
=C2=A0 =C2=A0 =C2=A0drc_index =3D rtas_ld(wa_addr, 0);<br>
=C2=A0 =C2=A0 =C2=A0drc =3D spapr_drc_by_index(drc_index);<br>
<br>
<br>
So, the extra local variable &#39;drc_index&#39; is simply redundant becaus=
e<br>
there are no reason for it to change. The drc object is the same AFAICT.<br=
>
Correct ? I should have explained that better in the commit log.<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Okay, since=
 both routines were implemented differently, I wasn&#39;t sure about the im=
pact of reassignment. Better commit log is always welcome.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Regards</div><div dir=3D"auto">Harsh</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Thanks,<br>
<br>
C.<br>
<br>
<br>
&gt; <br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* done sending the device tree, move =
to configured state */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_spapr_drc_set_configured(drc_ind=
ex);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drc-&gt;state =3D drck-&gt;ready_state=
;<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000ddd8de0605b5da04--

