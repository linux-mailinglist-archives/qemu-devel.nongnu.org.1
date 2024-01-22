Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C097837211
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:13:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzhp-0004HY-IL; Mon, 22 Jan 2024 14:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rRzhm-0004Gr-HO
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:11:34 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rRzhh-0003Vl-E5
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:11:33 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2906bcae4feso692217a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 11:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705950687; x=1706555487; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHbJFwRa8aq7E4zZR5LNVI9opQnLh7o+uT/oLIfZqAU=;
 b=hKpLDJPWudW2N61jMr4klV/KUv5ISV0dHDeYooMzjPh/SaKNsvJcriBcSHynMolhVY
 AQyUUkeHuEAJ6//TloGUOBWF2MTyrzy7RAYnHSXPBm0P4r1rnvbUwDT5gjEVoAZ08ruL
 8prc+IlJiI7EqZ7fHzCAqiSkerqr1RiSgZ71MDR6XnLuCM+gM9V/Er5bcS4NVNOEvggv
 TV3lcFo/BSUB1sbxw/eaL8+npjbmoF689MYLAU7/m0DZ3W3Md5D/lWh2gpTrR53S/sXL
 Lfm/eoh8ANwJBP6dL0w3hRCfN0u/xPrx/jX3I2wUDI4dOX/Voac+xI4+WSTH66qqnIi0
 p0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705950687; x=1706555487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHbJFwRa8aq7E4zZR5LNVI9opQnLh7o+uT/oLIfZqAU=;
 b=ECpuzQZ6AN0ExgfdXW4iKJFdA4j4NaV+KCmu7KncR8lpaJjyd+/F/8D9E7Ndj3y8Uc
 Y7EilWRso8TfMFe9BZFIrGzYGi+X9VTJvrQ6/AmVe/QIEWqTt34KQ4EHkIMCfyUi5SjQ
 Cr5kasLCqipUozZX8Oy8mlaWyyAOL6QBBsoupF9PIAWzO5SvATY4YoHsADzMLfRpCuOy
 QcL7nhD1h/YhnGVL2+2fajOpH3PuGCeflBxHrDisBgEfEABlA99P26acnF2L1izPJ79a
 OcWHGYN8y1/A9AdCA6y8Wxn3qBq6M3r0+/2NClL9gQUMHt/SPaIrH9LFiWcLgeszx5Pl
 D77w==
X-Gm-Message-State: AOJu0YyZY1ZtIAbwgk//iZbprPOiuLzL88o0WYU5gE1f9saYOeau7mMX
 gxreBN5ChFk4VYAlzz9M6vcPbIq5cdzlbhxbJOOEhyyEU5AODhO/pEmf1oV/aw9lgoT/+nJep4b
 KNAgxN2T3W2jo8FEOIYU7TkQNOI0=
X-Google-Smtp-Source: AGHT+IFlEJR0f6SVcpFy4bIbK3qkiW7G71PKz9PkjjqwZo8rhPFNtJkdMy/Dh3LvkXt+7BLF7OuiAyL4pDMFsoEkUrA=
X-Received: by 2002:a17:90b:4109:b0:290:b29a:5258 with SMTP id
 io9-20020a17090b410900b00290b29a5258mr1110325pjb.29.1705950687420; Mon, 22
 Jan 2024 11:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20240119204608.779541-1-jcmvbkbc@gmail.com>
 <20240119204608.779541-3-jcmvbkbc@gmail.com>
 <CAFEAcA_OvQzJV5knmS6qyK=XoZYBcqWNu29nSqBcgzy4G2ebBg@mail.gmail.com>
In-Reply-To: <CAFEAcA_OvQzJV5knmS6qyK=XoZYBcqWNu29nSqBcgzy4G2ebBg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 22 Jan 2024 11:11:15 -0800
Message-ID: <CAMo8BfK787zFQ_2nwTKv+Vedbe7TUiRWYoFHowpYADe_qdj0xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/xtensa: tidy TLB way variability logic
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jan 22, 2024 at 10:42=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Fri, 19 Jan 2024 at 20:47, Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > Whether TLB ways 5 and 6 are variable is not a property of the TLB
> > instance or a TLB entry instance, it's a property of the xtensa core
> > configuration.
> > Remove 'varway56' field from the xtensa_tlb structure and remove
> > 'variable' field from the xtensa_tlb_entry structure. Add
> > 'tlb_variable_way' array to the XtensaConfig and use it instead of
> > removed fields.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  target/xtensa/cpu.h          |  3 +--
> >  target/xtensa/mmu_helper.c   | 38 ++++++++++--------------------------
> >  target/xtensa/overlay_tool.h | 15 ++++++++++++--
> >  3 files changed, 24 insertions(+), 32 deletions(-)
> >
> > diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> > index 497325466397..24d3f15ea1bf 100644
> > --- a/target/xtensa/cpu.h
> > +++ b/target/xtensa/cpu.h
> > @@ -316,13 +316,11 @@ typedef struct xtensa_tlb_entry {
> >      uint32_t paddr;
> >      uint8_t asid;
> >      uint8_t attr;
> > -    bool variable;
> >  } xtensa_tlb_entry;
> >
> >  typedef struct xtensa_tlb {
> >      unsigned nways;
> >      const unsigned way_size[10];
> > -    bool varway56;
> >      unsigned nrefillentries;
> >  } xtensa_tlb;
> >
> > @@ -493,6 +491,7 @@ typedef struct XtensaConfig {
> >
> >      xtensa_tlb itlb;
> >      xtensa_tlb dtlb;
> > +    bool tlb_variable_way[16];
> >
> >      uint32_t mpu_align;
> >      unsigned n_mpu_fg_segments;
> > diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> > index d9f845e7fb6f..414c2f5ef669 100644
> > --- a/target/xtensa/mmu_helper.c
> > +++ b/target/xtensa/mmu_helper.c
> > @@ -105,23 +105,19 @@ static uint32_t xtensa_tlb_get_addr_mask(const CP=
UXtensaState *env,
> >                                           bool dtlb, uint32_t way)
> >  {
> >      if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
> > -        bool varway56 =3D dtlb ?
> > -            env->config->dtlb.varway56 :
> > -            env->config->itlb.varway56;
> > -
> >          switch (way) {
> >          case 4:
> >              return 0xfff00000 << get_page_size(env, dtlb, way) * 2;
> >
> >          case 5:
> > -            if (varway56) {
> > +            if (env->config->tlb_variable_way[5]) {
> >                  return 0xf8000000 << get_page_size(env, dtlb, way);
> >              } else {
> >                  return 0xf8000000;
> >              }
> >
> >          case 6:
> > -            if (varway56) {
> > +            if (env->config->tlb_variable_way[6]) {
> >                  return 0xf0000000 << (1 - get_page_size(env, dtlb, way=
));
> >              } else {
> >                  return 0xf0000000;
>
> So we now have a tlb_variable_way bool for all 16 possible
> ways, but the code actually only checks it for ways 5 and 6.

xtensa_tlb_set_entry checks this for all possible ways.

I would say that this is an unfortunate definition of MMU in the
xtensa ISA book that uses the variability of the ways 5/6 as a
discriminator between MMUv2 and MMUv3.

> Should we have an assertion somewhere that the config
> doesn't try to set it on ways where it has no effect ?
> Or is there actually a generic behaviour that would make
> sense for eg "way 3 is variable-way" that we just don't
> currently implement?

We currently use the TLB structure to implement the following
xtensa memory management options: cacheattr, region protection,
region translation, MMUv2 and MMUv3. First three only have
one variable way, in MMUv2 all ways except 5 and 6 are variable
and in MMUv3 all ways are variable. QEMU supports all of it
and tlb_variable_way is set properly in all of these cases.

> > @@ -150,11 +146,8 @@ static uint32_t get_vpn_mask(const CPUXtensaState =
*env, bool dtlb, uint32_t way)
> >          return xtensa_tlb_get_addr_mask(env, dtlb, way) << 2;
> >      } else if (way <=3D 6) {
> >          uint32_t mask =3D xtensa_tlb_get_addr_mask(env, dtlb, way);
> > -        bool varway56 =3D dtlb ?
> > -            env->config->dtlb.varway56 :
> > -            env->config->itlb.varway56;
> >
> > -        if (varway56) {
> > +        if (env->config->tlb_variable_way[5]) {
> >              return mask << (way =3D=3D 5 ? 2 : 3);
> >          } else {
> >              return mask << 1;
>
> This doesn't look right -- this branch of the if-else deals
> with way =3D=3D 5 and way =3D=3D 6, but we're only looking at
> tlb_variable_way[5].

Yeah, that's MMUv2 vs MMUv3 check, again.

> > @@ -172,10 +165,6 @@ static void split_tlb_entry_spec_way(const CPUXten=
saState *env, uint32_t v,
> >                                       bool dtlb, uint32_t *vpn,
> >                                       uint32_t wi, uint32_t *ei)
> >  {
> > -    bool varway56 =3D dtlb ?
> > -        env->config->dtlb.varway56 :
> > -        env->config->itlb.varway56;
> > -
> >      if (!dtlb) {
> >          wi &=3D 7;
> >      }
> > @@ -195,7 +184,7 @@ static void split_tlb_entry_spec_way(const CPUXtens=
aState *env, uint32_t v,
> >              break;
> >
> >          case 5:
> > -            if (varway56) {
> > +            if (env->config->tlb_variable_way[5]) {
> >                  uint32_t eibase =3D 27 + get_page_size(env, dtlb, wi);
> >                  *ei =3D (v >> eibase) & 0x3;
> >              } else {
> > @@ -204,7 +193,7 @@ static void split_tlb_entry_spec_way(const CPUXtens=
aState *env, uint32_t v,
> >              break;
> >
> >          case 6:
> > -            if (varway56) {
> > +            if (env->config->tlb_variable_way[6]) {
> >                  uint32_t eibase =3D 29 - get_page_size(env, dtlb, wi);
> >                  *ei =3D (v >> eibase) & 0x7;
> >              } else {
>
> There's no direct code duplication, but it definitely feels like
> the logic for "figure out how many bits we're dealing with" is
> duplicated across these three functions.
>
> I think it ought to be possible to have a function (or maybe two)
> which take account of both the way number and tlb_get_variable_way[]
> such that all of these three functions then don't need to have
> a switch on the way or look at tlb_variable_way[] themselves...

Ok, let me have another look at cleaning this up.

--=20
Thanks.
-- Max

