Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F878C0F5
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 11:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaud7-00046q-Fy; Tue, 29 Aug 2023 05:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qaud5-00046U-0a
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qaud0-0005JK-Ve
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693299794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4F89lSYzYu0iQ7l51z0n/CGnSz4QFklhrovKkXLhWw=;
 b=a6lwBFz+QpNBdZMNgiPjgNLXXAK7IoyfyLmh0LJ/axc8kRXvzEXefFXslrx1bKtYXv/ei4
 /lKOi5S1xKJ3kqR0IMsRSpi1XRJRqSB7vk7caI42PxI/7cBvqDYePgny91JjitLbnPtRkj
 V6bXhO4SZFzwRpoH0qfBhKOVhMiBDhs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-7bEdE1Y7PcefahXLwPEM2g-1; Tue, 29 Aug 2023 05:03:12 -0400
X-MC-Unique: 7bEdE1Y7PcefahXLwPEM2g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a0955ac1dcso340354966b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 02:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693299791; x=1693904591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4F89lSYzYu0iQ7l51z0n/CGnSz4QFklhrovKkXLhWw=;
 b=g32tx5JXMEKDL05i4WQCeidn5Fm9QrpIWxCRQ9vD3NvRfjpXn+a9ScKUvCShhKwK3K
 Dh6bt+PtDpHVKsLe2AQ9e5hZuKW9fXA1SG3dSNVoHfHJLzEK4ssPS3rfqgikIoPGq2ZD
 E72wgx1k9oidAPyx6RTsXK3bpowvUUhRZSNlgV3WxkThiYJU4NT33iXjxgXRSED9ZzgK
 5LSu9xPQrHvmBwJC3H2xzeE4DvU2cpmO93udL8JSv+PCcSfu8fH9LEoUwVRufyeZM2ws
 AJBqiiKo+zk954xqL8RISZWFPqdQ0msnoKRIsG2F4qElkqbzww3w9gwj5c+nlutFy8Ia
 nJ9A==
X-Gm-Message-State: AOJu0Yy1lCfRv0pwPvH57Scs9v2YvxwLuT1EPkZ+6sdRyj6TQMYRPvSH
 oFhhSf0xl/wo+a8ZhpVbD1o70tENJGjIOnn9lsd2u9/6QM3uUSuPeuuxMYTdOkvWtijK3JbVHx+
 V+e16i/X/W93q1JI=
X-Received: by 2002:a17:907:c010:b0:9a5:b874:93d5 with SMTP id
 ss16-20020a170907c01000b009a5b87493d5mr3004496ejc.76.1693299791268; 
 Tue, 29 Aug 2023 02:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQrwBXu2FvXPQtART1S73R6+IxR6G0nL16nRqib5NdpatKX4jPOZRdIxzt2nRpeSGOwAHd0w==
X-Received: by 2002:a17:907:c010:b0:9a5:b874:93d5 with SMTP id
 ss16-20020a170907c01000b009a5b87493d5mr3004480ejc.76.1693299790848; 
 Tue, 29 Aug 2023 02:03:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q22-20020a170906361600b0099bd6026f45sm5732281ejb.198.2023.08.29.02.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 02:03:10 -0700 (PDT)
Date: Tue, 29 Aug 2023 11:03:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, cohuck@redhat.com,
 pbonzini@redhat.com, shan.gavin@gmail.com, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 3/8] machine: Print supported CPU models instead of
 typenames
Message-ID: <20230829110308.5282936f@imammedo.users.ipa.redhat.com>
In-Reply-To: <6e637717-b739-3ee8-ac12-a339ea5fb166@redhat.com>
References: <20230726003205.1599788-1-gshan@redhat.com>
 <20230726003205.1599788-4-gshan@redhat.com>
 <24e54bac-9149-20da-e4cf-5829a6dcb174@linaro.org>
 <0454c1ad-314c-3df6-d6e9-1a05cb4c4050@redhat.com>
 <20230727110010.648b61a6@imammedo.users.ipa.redhat.com>
 <5f26299e-f1e0-a2ab-db83-87011fe524d5@redhat.com>
 <20230828164637.52c2b5b0@imammedo.users.ipa.redhat.com>
 <6e637717-b739-3ee8-ac12-a339ea5fb166@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 29 Aug 2023 16:28:45 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Igor,
>=20
> On 8/29/23 00:46, Igor Mammedov wrote:
> > On Mon, 31 Jul 2023 15:07:30 +1000
> > Gavin Shan <gshan@redhat.com> wrote: =20
> >> On 7/27/23 19:00, Igor Mammedov wrote: =20
> >>> On Thu, 27 Jul 2023 15:16:18 +1000
> >>> Gavin Shan <gshan@redhat.com> wrote:
> >>>     =20
> >>>> On 7/27/23 09:08, Richard Henderson wrote: =20
> >>>>> On 7/25/23 17:32, Gavin Shan wrote: =20
> >>>>>> -static const char *q800_machine_valid_cpu_types[] =3D {
> >>>>>> +static const char * const q800_machine_valid_cpu_types[] =3D {
> >>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M68K_CPU_TYPE_NAME("m68040"),
> >>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
> >>>>>>   =C2=A0 };
> >>>>>> +static const char * const q800_machine_valid_cpu_models[] =3D {
> >>>>>> +=C2=A0=C2=A0=C2=A0 "m68040",
> >>>>>> +=C2=A0=C2=A0=C2=A0 NULL
> >>>>>> +}; =20
> >>>>>
> >>>>> I really don't like this replication.
> >>>>>        =20
> >>>>
> >>>> Right, it's going to be lots of replications, but gives much flexibi=
lity.
> >>>> There are 21 targets and we don't have fixed pattern for the mapping=
 between
> >>>> CPU model name and CPU typename. I'm summarizing the used patterns l=
ike below.
> >>>>
> >>>>      1 All CPU model names are mappinged to fixed CPU typename; =20
> >>>
> >>>           plainly spelled it would be: cpu_model name ignored and
> >>>           a cpu type is returned anyways.
> >>>
> >>> I'd make this hard error right away, as "junk in =3D> error out"
> >>> it's clearly user error. I think we don't even have to follow
> >>> deprecation process for that.
> >>>     =20
> >>
> >> Right, It's not expected behavior to map ambiguous CPU model names to
> >> the fixed CPU typename. =20
> >=20
> > to be nice we can deprecate those and then later remove.
> > (while deprecating make those targets accept typenames)
> >  =20
>=20
> Lets put it aside for now and revisit it later, so that we can focus on
> the conversion from the CPU type name to the CPU model name for now.
>=20
> >> =20
> >>>>      2 CPU model name is same to CPU typename;
> >>>>      3 CPU model name is alias to CPU typename;
> >>>>      4 CPU model name is prefix of CPU typename; =20
> >>>
> >>> and some more:
> >>>       5. cpu model names aren't names at all sometimes, and some other
> >>>          CPU property is used. (ppc)
> >>> This one I'd prefer to get rid of and ppc handling more consistent
> >>> with other targets, which would need PPC folks to persuaded to drop
> >>> PVR lookup.
> >>>     =20
> >>
> >> I put this into class 3, meaning the PVRs are regarded as aliases to C=
PU
> >> typenames. =20
> >=20
> > with PPC using 'true' aliases, -cpu input is lost after it's translated=
 into typename.
> > (same for alpha)
> >=20
> > it also adds an extra fun with 'max' cpu model but that boils down to a=
bove statement.
> > (same for
> >    * sh4
> >    * cris(in user mode only, but you are making sysemu extension, so it=
 doesn't count)
> > )
> > For this class of aliases reverse translation won't yield the same
> > result as used -cpu. The only option you have is to store -cpu cpu_model
> > somewhere (use qemu_opts??, and then fetch it later to print in error m=
essage)
> >=20
> > x86 has 'aliases' as well, but in reality it creates distinct cpu types
> > for each 'alias', so it's possible to do reverse translation.
> >  =20
>=20
> It's true that '-cpu input' gets lost in these cases. However, the CPU ty=
pe
> name instead of the CPU model name is printed in the error message when t=
he
> CPU type is validated in hw/core/machine.c::machine_run_board_init(). It =
looks
> good to me to print the CPU type name instead of the model name there.

It's the same confusing whether it's type or cpumodel it it doesn't match
user provided value.

> Another error message is printed when the CPU model specified in '-cpu in=
put'
> isn't valid. The CPU model has been printed and it looks good either.
>=20
>    # qemu-system-aarch64 -M virt -cpu aaa
>    qemu-system-aarch64: unable to find CPU model 'aaa'
>=20
> Are there other cases I missed where we need to print the CPU model name,=
 which
> is specified by user through '-cpu input'?
>=20
> >>>>
> >>>>      Target         Categories    suffix-of-CPU-typename
> >>>>      -------------------------------------------------------
> >>>>      alpha          -234          -alpha-cpu
> >>>>      arm            ---4          -arm-cpu
> >>>>      avr            -2--
> >>>>      cris           --34          -cris-cpu
> >>>>      hexagon        ---4          -hexagon-cpu
> >>>>      hppa           1---
> >>>>      i386           ---4          -i386-cpu
> >>>>      loongarch      -2-4          -loongarch-cpu
> >>>>      m68k           ---4          -m68k-cpu
> >>>>      microblaze     1---
> >>>>      mips           ---4          -mips64-cpu  -mips-cpu
> >>>>      nios2          1---
> >>>>      openrisc       ---4          -or1k-cpu
> >>>>      ppc            --34          -powerpc64-cpu  -powerpc-cpu
> >>>>      riscv          ---4          -riscv-cpu
> >>>>      rx             -2-4          -rx-cpu
> >>>>      s390x          ---4          -s390x-cpu
> >>>>      sh4            --34          -superh-cpu
> >>>>      sparc          -2-- =20
> >=20
> > it's case 4
> >  =20
>=20
> Yes.
>=20
> >>>>      tricore        ---4          -tricore-cpu
> >>>>      xtensa         ---4          -xtensa-cpu
> >>>>
> >>>> There are several options as below. Please let me know which one or =
something
> >>>> else is the best.
> >>>>
> >>>> (a) Keep what we have and use mc->valid_{cpu_types, cpu_models}[] to=
 track
> >>>> the valid CPU typenames and CPU model names.
> >>>>
> >>>> (b) Introduce CPUClass::model_name_by_typename(). Every target has t=
heir own
> >>>> implementation to convert CPU typename to CPU model name. The CPU mo=
del name
> >>>> is parsed from mc->valid_cpu_types[i].
> >>>>
> >>>>        char *CPUClass::model_by_typename(const char *typename);
> >>>>
> >>>> (c) As we discussed before, use mc->valid_cpu_type_suffix and mc->va=
lid_cpu_models
> >>>> because the CPU type check is currently needed by target arm/m68k/ri=
scv where we
> >>>> do have fixed pattern to convert CPU model names to CPU typenames. T=
he CPU typename
> >>>> is comprised of CPU model name and suffix. However, it won't be work=
ing when the CPU
> >>>> type check is required by other target where we have patterns other =
than this. =20
> >>>
> >>> none of above is really good, that's why I was objecting to introduci=
ng
> >>> reverse type->name mapping. That ends up with increased amount junk,
> >>> and it's not because your patches are bad, but because you are trying
> >>> to deal with cpu model names (which is a historically evolved mess).
> >>> The best from engineering POV would be replacing CPU models with
> >>> type names.
> >>>
> >>> Even though it's a bit radical, I very much prefer replacing
> >>> cpu_model names with '-cpu type'usage directly. Making it
> >>> consistent with -device/other interfaces and coincidentally that
> >>> obsoletes need in reverse name mapping.
> >>>
> >>> It's painful for end users who will need to change configs/scripts,
> >>> but it's one time job. Additionally from QEMU pov, codebase
> >>> will be less messy =3D> more maintainable which benefits not only
> >>> developers but end-users in the end.
> >>>     =20
> >>
> >> I have to clarify the type->model mapping has been existing since the
> >> model->type mapping was introduced with the help of CPU_RESOLVING_TYPE.
> >> I mean the logic has been existing since the existence of CPU_RESOLVIN=
G_TYPE,
> >> even the code wasn't there.
> >>
> >> I'm not sure about the idea to switch to '-cpu <cpu-type-name>' since
> >> it was rejected by Peter Maydell before. Hope Peter can double confirm
> >> for this. For me, the shorter name is beneficial. For example, users
> >> needn't to have '-cpu host-arm-cpu' for '-cpu host'.
> >>
> >> =20
> >>> [rant:
> >>> It's the same story repeating over and over, when it comes to
> >>> changing QEMU CLI, which hits resistance wall. But with QEMU
> >>> deprecation process we've changed CLI behavior before,
> >>> despite of that world didn't cease to exist and users
> >>> have adapted to new QEMU and arguably QEMU became a tiny
> >>> bit more maintainable since we don't have to deal some
> >>> legacy behavior.
> >>> ]
> >>>     =20
> >>
> >> I need more context about 'deprecation process' here. My understanding
> >> is both CPU typename and model name will be accepted for a fixed period
> >> of time. However, a warning message will be given to indicate that the
> >> model name will be obsoleted soon. Eventually, we switch to CPU typena=
me
> >> completely. Please correct me if there are anything wrong. =20
> >=20
> > yep, that's the gist of deprecation in this case.
> >  =20
>=20
> Ok. Thanks for your confirm.
>   =20
> >>> Another idea back in the days was (as a compromise),
> >>>    1. keep using keep valid_cpu_types
> >>>    2. instead of introducing yet another way to do reverse mapping,
> >>>       clean/generalize/make it work everywhere list_cpus (which
> >>>       already does that mapping) and then use that to do your thing.
> >>>       It will have drawbacks you've listed above, but hopefully
> >>>       that will clean up and reuse existing list_cpus.
> >>>       (only this time, I'd build it around  query-cpu-model-expansion,
> >>>        which output is used by generic list_cpus)
> >>>       [and here I'm asking to rewrite directly unrelated QEMU part ye=
t again]
> >>>     =20
> >>
> >> I'm afraid that list_cpus() is hard to be reused. All available CPU mo=
del names
> >> are listed by list_cpus(). mc->valid_cpu_types[] are just part of them=
 and variable
> >> on basis of boards. Generally speaking, we need a function to do rever=
se things
> >> as to CPUClass::class_by_name(). So I would suggest to introduce CPUCl=
ass::model_from_type(),
> >> as below. Could you please suggest if it sounds reasonable to you?
> >>
> >> - CPUClass::class_by_name() is modified to
> >>     char *CPUClass::model_to_type(const char *model)
> >>
> >> - char *CPUClass::type_to_model(const char *type)
> >>
> >> - CPUClass::type_to_model() is used in cpu_list() for every target whe=
n CPU
> >>     model name, fetched from CPU type name, is printed in xxx_cpu_list=
_entry()
> >>
> >> - CPUClass::type_to_model() is reused in hw/core/machine.c to get the =
CPU
> >>     model name from CPU type names in mc->valid_cpu_types[]. =20
> >=20
> > instead of per target hooks (which are atm mostly open-coded in several=
 places)
> > how about adding generic handler for cases 2,4:
> >    cpu_type_to_model(typename)
> >       cpu_suffix =3D re'-*-cpu'
> >       if (class_exists(typename - cpu_suffix))
> >           return typename - cpu_suffix
> >       else if (class_exists(typename))
> >           return typename
> >       explode
> >=20
> > that should work for translating valid_cpus typenames to cpumodel names
> > and once that in place cleanup all open-coded translations with it tree=
-wide
> >=20
> > you can find those easily by:
> > git grep _CPU_TYPE_SUFFIX
> > git grep query_cpu_definitions
> >  =20
>=20
> Thanks for the advice. I think it's enough for now since the CPU type
> invalidation is currently done for arm/mips/riscv for now. On these
> targets, the CPU type name is always the combination of the CPU model
> name and suffix. I will add helper qemu/cpu.c::cpu_model_by_name()

cpu_model_from_type() would be describe what function does better.

> as you suggested. Note that, the suffix can be gained by ("-" CPU_RESOLVI=
NG_TYPE)
>=20
> Yes, the newly added helper cpu_model_by_name() needs to be applied
> to targets where query_cpu_definitions and cpu_list are defined.

>=20
> Thanks,
> Gavin
>=20


