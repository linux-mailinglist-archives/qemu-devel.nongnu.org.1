Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4137A677F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:01:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qicCP-0005Hj-M2; Tue, 19 Sep 2023 10:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1qicCL-0005FX-V7; Tue, 19 Sep 2023 10:59:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1qicCJ-0006b0-UL; Tue, 19 Sep 2023 10:59:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3214d4ecd39so2267000f8f.1; 
 Tue, 19 Sep 2023 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695135570; x=1695740370; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F8m8Nwopnk3ZUBjlj59jcYLuzILSI1xRxDeSyuLj3pw=;
 b=di6t57CrSUWTzOh8PVAIUkfUJZ0xWMum/kphmdKkfL8rVCPi28i0CUQLSnZxm3NJNM
 Dp83xwblWuZur+exxtnHrKp2bxg8VhBsa8Phg3z7OxLBwjBFocpv45IP6pV/R8xz852B
 oRiKrntdRCC+20uErFDA3QIdl1HxSWghycG5s9DeuaTVYRGCm1JJ4je8J16PNKZkMvS9
 XwbBRueJ0GEwcI80NlyWzXDdP3IcRBTA2u0ON7aRy6CCzgl9akb8E3bT1agNxnSUMKXM
 qP8/qif2Yyuya19ngAZBZ1OIZ+vEoWdt+teKoMIEPuB4gy57QbTTYp95Z40rBBMNtrj5
 Gv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695135570; x=1695740370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F8m8Nwopnk3ZUBjlj59jcYLuzILSI1xRxDeSyuLj3pw=;
 b=YCV3MHAbnaJbFx1u2pA+GTQX++PPMnSurJ/jntrjM2HvQ92vBaGuphwGQWDg3MfmJR
 e/3RR/Kb2o+J0M19ltLpCGLASGbtl4qqMLOcxWPfIpXdP6iFqHjLs9d2+FTG/QljeFQA
 8ektH7Lm+yp4cYfDyM9ZcmNvLa5AVhhgChHeirN0vu6qmwEYAWNTqcopHsIMEKB1cevK
 VQr15iyf5gge9wK2TBEMR8NchKzZ7GEHs8LwqjrrNGAP2T5UXqFablFJcFW9ITHae2EM
 WyS0yeYJxRqw1CxPoysSXKLMqZU4wHHMb97PZMej51qLttTTdzWXNeA5Boar5Gx60f5B
 qcgw==
X-Gm-Message-State: AOJu0Yyk4n4+gBNH7IoyMafKynE0ZRna8vJfmmJ3zWwGMdqwK1bqvnyn
 SGZJQOEl07tVJqHZFpNLi7TRtVBNlirWoyzPDEQ=
X-Google-Smtp-Source: AGHT+IHlDcdS6mkfHo8QoUv0grRykHDIkxpa0Qd6ojybkFRasmH1otkW9Y51myJa3eQ2uDJoOaRY+1g3ZmmjxCEZVUU=
X-Received: by 2002:a5d:53d0:0:b0:31c:84e9:20fd with SMTP id
 a16-20020a5d53d0000000b0031c84e920fdmr9318022wrw.13.1695135569760; Tue, 19
 Sep 2023 07:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-4-clg@kaod.org>
 <56a18122-ed29-ddc5-03f7-6e539a9f46f2@linux.ibm.com>
 <78e09b46-cf41-91d7-d518-519c12ca4b43@kaod.org>
 <CAEuJdmpsG_SEpBcb33-NJKtYr2WNqNaKrKMsfAOQtiRg8NxFJA@mail.gmail.com>
In-Reply-To: <CAEuJdmpsG_SEpBcb33-NJKtYr2WNqNaKrKMsfAOQtiRg8NxFJA@mail.gmail.com>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Tue, 19 Sep 2023 20:29:18 +0530
Message-ID: <CAEuJdmrbS2Jh6_zOQX=3EtN0xjHFQt3wGtHHnsh7CfvBt-1RCQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] spapr: Clean up local variable shadowing in
 spapr_dt_cpus()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007b57330605b78139"
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-wr1-x436.google.com
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

--0000000000007b57330605b78139
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Sept, 2023, 6:34 pm Harsh Prateek Bora, <
harsh.prateek.bora@gmail.com> wrote:

>
>
> On Tue, 19 Sept, 2023, 4:37 pm C=C3=A9dric Le Goater, <clg@kaod.org> wrot=
e:
>
>> On 9/19/23 09:28, Harsh Prateek Bora wrote:
>> >
>> >
>> > On 9/18/23 20:28, C=C3=A9dric Le Goater wrote:
>> >> Introduce a helper routine defining one CPU device node to fix this
>> >> warning :
>> >>
>> >>    ../hw/ppc/spapr.c: In function =E2=80=98spapr_dt_cpus=E2=80=99:
>> >>    ../hw/ppc/spapr.c:812:19: warning: declaration of =E2=80=98cs=E2=
=80=99 shadows a
>> previous local [-Wshadow=3Dcompatible-local]
>> >>      812 |         CPUState *cs =3D rev[i];
>> >>          |                   ^~
>> >>    ../hw/ppc/spapr.c:786:15: note: shadowed declaration is here
>> >>      786 |     CPUState *cs;
>> >>          |               ^~
>> >>
>> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> >> ---
>> >>   hw/ppc/spapr.c | 36 +++++++++++++++++++++---------------
>> >>   1 file changed, 21 insertions(+), 15 deletions(-)
>> >>
>> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> >> index de3c616b4637..d89f0fd496b6 100644
>> >> --- a/hw/ppc/spapr.c
>> >> +++ b/hw/ppc/spapr.c
>> >> @@ -780,6 +780,26 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt=
,
>> int offset,
>> >>                                 pcc->lrg_decr_bits)));
>> >>   }
>> >> +static void spapr_dt_one_cpu(void *fdt, SpaprMachineState *spapr,
>> CPUState *cs,
>> >> +                             int cpus_offset)
>> >> +{
>> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> >> +    int index =3D spapr_get_vcpu_id(cpu);
>> >> +    DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>> >> +    g_autofree char *nodename =3D NULL;
>> >> +    int offset;
>> >> +
>> >> +    if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
>> >> +        return;
>> >> +    }
>> >> +
>> >> +    nodename =3D g_strdup_printf("%s@%x", dc->fw_name, index);
>> >> +    offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
>> >> +    _FDT(offset);
>> >> +    spapr_dt_cpu(cs, fdt, offset, spapr);
>> >> +}
>> >> +
>> >> +
>> >>   static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
>> >>   {
>> >>       CPUState **rev;
>> >> @@ -809,21 +829,7 @@ static void spapr_dt_cpus(void *fdt,
>> SpaprMachineState *spapr)
>> >>       }
>> >>       for (i =3D n_cpus - 1; i >=3D 0; i--) {
>> >> -        CPUState *cs =3D rev[i];
>> >> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> >> -        int index =3D spapr_get_vcpu_id(cpu);
>> >> -        DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>> >> -        g_autofree char *nodename =3D NULL;
>> >> -        int offset;
>> >> -
>> >> -        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
>> >> -            continue;
>> >> -        }
>> >> -
>> >> -        nodename =3D g_strdup_printf("%s@%x", dc->fw_name, index);
>> >> -        offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
>> >> -        _FDT(offset);
>> >> -        spapr_dt_cpu(cs, fdt, offset, spapr);
>> >> +        spapr_dt_one_cpu(fdt, spapr, rev[i], cpus_offset);
>> >
>> > Do we want to replace the call to spapr_dt_cpu in
>> > spapr_core_dt_populate() with the _one_ as well?
>> > Not sure about the implication of additional instructions there.
>>
>> yeah may be we could rework spapr_dt_one_cpu() and
>> spapr_core_dt_populate()
>> in a single routine. They are similar. It can come later.
>>
>> > Also, could this code insider wrapper become part of spapr_dt_cpu()
>> itself?
>> > If can't, do we want a better renaming of wrapper here?
>>
>> I am open to proposal :)
>>
>
> How about spapr_dt_cpu_prepare() ?
>

I guess spapr_dt_cpu_process() may be more apt since it calls the
spapr_dt_cpu internally.


>
>> Thanks
>>
>> C.
>>
>>
>> >
>> > Otherwise,
>> > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> >
>> >>       }
>> >>       g_free(rev);
>>
>>
>>

--0000000000007b57330605b78139
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, 19 Sept, 2023, 6:34 pm Harsh Prateek Bora, &lt=
;<a href=3D"mailto:harsh.prateek.bora@gmail.com">harsh.prateek.bora@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"=
><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, 19 Sept, 2023, 4:37 pm C=C3=A9dric Le Goater, &lt;<a href=3D"ma=
ilto:clg@kaod.org" target=3D"_blank" rel=3D"noreferrer">clg@kaod.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">On 9/19/23 09:28, Harsh Pr=
ateek Bora wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 9/18/23 20:28, C=C3=A9dric Le Goater wrote:<br>
&gt;&gt; Introduce a helper routine defining one CPU device node to fix thi=
s<br>
&gt;&gt; warning :<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0 ../hw/ppc/spapr.c: In function =E2=80=98spapr_dt_cpus=
=E2=80=99:<br>
&gt;&gt; =C2=A0=C2=A0 ../hw/ppc/spapr.c:812:19: warning: declaration of =E2=
=80=98cs=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]<br=
>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 812 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 CPUState *cs =3D rev[i];<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~<br>
&gt;&gt; =C2=A0=C2=A0 ../hw/ppc/spapr.c:786:15: note: shadowed declaration =
is here<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 786 |=C2=A0=C2=A0=C2=A0=C2=A0 CPUState *c=
s;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~<br=
>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kao=
d.org" rel=3D"noreferrer noreferrer" target=3D"_blank">clg@kaod.org</a>&gt;=
<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 hw/ppc/spapr.c | 36 +++++++++++++++++++++---------------<br=
>
&gt;&gt; =C2=A0 1 file changed, 21 insertions(+), 15 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c<br>
&gt;&gt; index de3c616b4637..d89f0fd496b6 100644<br>
&gt;&gt; --- a/hw/ppc/spapr.c<br>
&gt;&gt; +++ b/hw/ppc/spapr.c<br>
&gt;&gt; @@ -780,6 +780,26 @@ static void spapr_dt_cpu(CPUState *cs, void *=
fdt, int offset,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcc-&gt;lrg_decr_bits)));<br>
&gt;&gt; =C2=A0 }<br>
&gt;&gt; +static void spapr_dt_one_cpu(void *fdt, SpaprMachineState *spapr,=
 CPUState *cs,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cpus_offset)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 PowerPCCPU *cpu =3D POWERPC_CPU(cs);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 int index =3D spapr_get_vcpu_id(cpu);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_GET_CLASS(cs);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 g_autofree char *nodename =3D NULL;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 int offset;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!spapr_is_thread0_in_vcore(spapr, cpu)) {<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 nodename =3D g_strdup_printf(&quot;%s@%x&quot;=
, dc-&gt;fw_name, index);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 offset =3D fdt_add_subnode(fdt, cpus_offset, n=
odename);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 _FDT(offset);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 spapr_dt_cpu(cs, fdt, offset, spapr);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 static void spapr_dt_cpus(void *fdt, SpaprMachineState *spa=
pr)<br>
&gt;&gt; =C2=A0 {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUState **rev;<br>
&gt;&gt; @@ -809,21 +829,7 @@ static void spapr_dt_cpus(void *fdt, SpaprMac=
hineState *spapr)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D n_cpus - 1; i &gt;=3D 0;=
 i--) {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUState *cs =3D rev[i=
];<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PowerPCCPU *cpu =3D PO=
WERPC_CPU(cs);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int index =3D spapr_ge=
t_vcpu_id(cpu);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DE=
VICE_GET_CLASS(cs);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *noden=
ame =3D NULL;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset;<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!spapr_is_thread0_=
in_vcore(spapr, cpu)) {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 continue;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nodename =3D g_strdup_=
printf(&quot;%s@%x&quot;, dc-&gt;fw_name, index);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D fdt_add_sub=
node(fdt, cpus_offset, nodename);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _FDT(offset);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spapr_dt_cpu(cs, fdt, =
offset, spapr);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spapr_dt_one_cpu(fdt, =
spapr, rev[i], cpus_offset);<br>
&gt; <br>
&gt; Do we want to replace the call to spapr_dt_cpu in<br>
&gt; spapr_core_dt_populate() with the _one_ as well?<br>
&gt; Not sure about the implication of additional instructions there.<br>
<br>
yeah may be we could rework spapr_dt_one_cpu() and spapr_core_dt_populate()=
<br>
in a single routine. They are similar. It can come later.<br>
<br>
&gt; Also, could this code insider wrapper become part of spapr_dt_cpu() it=
self?<br>
&gt; If can&#39;t, do we want a better renaming of wrapper here?<br>
<br>
I am open to proposal :)<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">How about spapr_dt_cpu_prepare() ?=C2=A0</div><div =
dir=3D"auto"></div></div></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">I guess spapr_dt_cpu_process() may be more apt since i=
t calls the spapr_dt_cpu internally.=C2=A0</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks<br>
<br>
C.<br>
<br>
<br>
&gt; <br>
&gt; Otherwise,<br>
&gt; Reviewed-by: Harsh Prateek Bora &lt;<a href=3D"mailto:harshpb@linux.ib=
m.com" rel=3D"noreferrer noreferrer" target=3D"_blank">harshpb@linux.ibm.co=
m</a>&gt;<br>
&gt; <br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(rev);<br>
<br>
<br>
</blockquote></div></div></div>
</blockquote></div></div></div>

--0000000000007b57330605b78139--

