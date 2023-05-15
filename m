Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C832A703166
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZzg-0007iV-GY; Mon, 15 May 2023 11:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyZzG-0007ZS-4i; Mon, 15 May 2023 11:19:48 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyZzD-00008t-7U; Mon, 15 May 2023 11:19:45 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-24decf5cc03so8798535a91.0; 
 Mon, 15 May 2023 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684163981; x=1686755981;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuYcl5ovq7mHOIJNJABMIQ3RPuhAUMBwNBlArNXFCww=;
 b=UVM0358yY2yA/skPAHOLAAnV8IDMp/LHVyePbEYZmXGC2wjPkqpnWcoL17JzBNDiEj
 qnIZa0VVWRE2s1uAMFRM7sA1TQcEESErvmAMcxzgdrMzO0dDFIfsFQKZ5RDZDgPa1oyJ
 yL/6xAo0MM7ak1DWlMRr3KY3X32XOLz7HcWvZKsyidZYinldFwh2z4k0ehxDbgJEOT/q
 7k+nuqsjepLanzQYBFy5qa5DdW/9Zw8SfaWrTKWCpMugmP+h6pEQQ/rFWtP0Dg8KMur6
 Q4BIIGTrlcSPZLsBVqjeq1XYriPDapvShGdK6sm5E755tteGyA7RG7I801Jhf0zWkNqc
 3eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684163981; x=1686755981;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kuYcl5ovq7mHOIJNJABMIQ3RPuhAUMBwNBlArNXFCww=;
 b=Qy14nNEynDNJmKWVKUCvGVnmn+jEBKFzktsif64nhZr1SEG8ZpkU3EZq1RY/EgGngy
 EhtuPyTg/QuoOs69GNbT52Tv6YeKcQElDbMUzvOi13hEI6OTYVJnXlUL5B7rHt3q2Nbe
 QhEaTQXQyaS1yNbgPd1odPOJVDe6NZSVmaCXNEJcxiWltCBfOgu9BJdI6UJZNMi1bI7u
 FIaqyJm6GlwZSHQbsnWPb/dvgrx83M+bTnIroU+Hk2+ZPXt0Cs7CMEIV57ybNDrxKchO
 PEil2p9OiSzxaCGWTmFUcydoaihpfok3YDpSVehvji7gT2xZPFx82fMvhIvldLg1MdA3
 lDKg==
X-Gm-Message-State: AC+VfDw7DF0d+DYOuQzzs7LQAvdbqCk8dLmzCGbcTsRN9eJcT0Z2vQLO
 h8YyXbu4BJfj2tM+U12V290=
X-Google-Smtp-Source: ACHHUZ76C5QkVRj5EyTV+WbetJ6Q5puN3iCe0JI73ibzaamA9+o2tRJvhACCPWoGu3mGSuUAtaGdXA==
X-Received: by 2002:a17:90a:fc90:b0:24b:c580:1ab8 with SMTP id
 ci16-20020a17090afc9000b0024bc5801ab8mr32963645pjb.40.1684163981236; 
 Mon, 15 May 2023 08:19:41 -0700 (PDT)
Received: from localhost ([202.168.30.146]) by smtp.gmail.com with ESMTPSA id
 kx6-20020a17090b228600b002477dda66d2sm21942800pjb.37.2023.05.15.08.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 08:19:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 01:19:36 +1000
Message-Id: <CSMYAXLT8B9P.1D85SFBUZQ9ZC@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v3 1/9] target/ppc: Fix width of some 32-bit SPRs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230515092655.171206-1-npiggin@gmail.com>
 <20230515092655.171206-2-npiggin@gmail.com>
 <4cefbbd6-6ab2-cd55-4468-4066b464c99c@ilande.co.uk>
In-Reply-To: <4cefbbd6-6ab2-cd55-4468-4066b464c99c@ilande.co.uk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 15, 2023 at 10:03 PM AEST, Mark Cave-Ayland wrote:
> On 15/05/2023 10:26, Nicholas Piggin wrote:
>
> > Some 32-bit SPRs are incorrectly implemented as 64-bits on 64-bit
> > targets.
> >=20
> > This changes VRSAVE, DSISR, HDSISR, DAWRX0, PIDR, LPIDR, DEXCR,
> > HDEXCR, CTRL, TSCR, MMCRH, and PMC[1-6] from to be 32-bit registers.
> >=20
> > This only goes by the 32/64 classification in the architecture, it
> > does not try to implement finer details of SPR implementation (e.g.,
> > not all bits implemented as simple read/write storage).
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Since v2: no change.
> >=20
> >   target/ppc/cpu_init.c    | 18 +++++++++---------
> >   target/ppc/helper_regs.c |  2 +-
> >   target/ppc/misc_helper.c |  4 ++--
> >   target/ppc/power8-pmu.c  |  2 +-
> >   target/ppc/translate.c   |  2 +-
> >   5 files changed, 14 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index 0ce2e3c91d..5aa0b3f0f1 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -5085,8 +5085,8 @@ static void register_book3s_altivec_sprs(CPUPPCSt=
ate *env)
> >       }
> >  =20
> >       spr_register_kvm(env, SPR_VRSAVE, "VRSAVE",
> > -                     &spr_read_generic, &spr_write_generic,
> > -                     &spr_read_generic, &spr_write_generic,
> > +                     &spr_read_generic, &spr_write_generic32,
> > +                     &spr_read_generic, &spr_write_generic32,
> >                        KVM_REG_PPC_VRSAVE, 0x00000000);
> >  =20
> >   }
> > @@ -5120,7 +5120,7 @@ static void register_book3s_207_dbg_sprs(CPUPPCSt=
ate *env)
> >       spr_register_kvm_hv(env, SPR_DAWRX0, "DAWRX0",
> >                           SPR_NOACCESS, SPR_NOACCESS,
> >                           SPR_NOACCESS, SPR_NOACCESS,
> > -                        &spr_read_generic, &spr_write_generic,
> > +                        &spr_read_generic, &spr_write_generic32,
> >                           KVM_REG_PPC_DAWRX, 0x00000000);
> >       spr_register_kvm_hv(env, SPR_CIABR, "CIABR",
> >                           SPR_NOACCESS, SPR_NOACCESS,
> > @@ -5376,7 +5376,7 @@ static void register_book3s_ids_sprs(CPUPPCState =
*env)
> >       spr_register_hv(env, SPR_TSCR, "TSCR",
> >                    SPR_NOACCESS, SPR_NOACCESS,
> >                    SPR_NOACCESS, SPR_NOACCESS,
> > -                 &spr_read_generic, &spr_write_generic,
> > +                 &spr_read_generic, &spr_write_generic32,
> >                    0x00000000);
> >       spr_register_hv(env, SPR_HMER, "HMER",
> >                    SPR_NOACCESS, SPR_NOACCESS,
> > @@ -5406,7 +5406,7 @@ static void register_book3s_ids_sprs(CPUPPCState =
*env)
> >       spr_register_hv(env, SPR_MMCRC, "MMCRC",
> >                    SPR_NOACCESS, SPR_NOACCESS,
> >                    SPR_NOACCESS, SPR_NOACCESS,
> > -                 &spr_read_generic, &spr_write_generic,
> > +                 &spr_read_generic, &spr_write_generic32,
> >                    0x00000000);
> >       spr_register_hv(env, SPR_MMCRH, "MMCRH",
> >                    SPR_NOACCESS, SPR_NOACCESS,
> > @@ -5441,7 +5441,7 @@ static void register_book3s_ids_sprs(CPUPPCState =
*env)
> >       spr_register_hv(env, SPR_HDSISR, "HDSISR",
> >                    SPR_NOACCESS, SPR_NOACCESS,
> >                    SPR_NOACCESS, SPR_NOACCESS,
> > -                 &spr_read_generic, &spr_write_generic,
> > +                 &spr_read_generic, &spr_write_generic32,
> >                    0x00000000);
> >       spr_register_hv(env, SPR_HRMOR, "HRMOR",
> >                    SPR_NOACCESS, SPR_NOACCESS,
> > @@ -5665,7 +5665,7 @@ static void register_power7_book4_sprs(CPUPPCStat=
e *env)
> >                        KVM_REG_PPC_ACOP, 0);
> >       spr_register_kvm(env, SPR_BOOKS_PID, "PID",
> >                        SPR_NOACCESS, SPR_NOACCESS,
> > -                     &spr_read_generic, &spr_write_generic,
> > +                     &spr_read_generic, &spr_write_generic32,
> >                        KVM_REG_PPC_PID, 0);
> >   #endif
> >   }
> > @@ -5730,7 +5730,7 @@ static void register_power10_dexcr_sprs(CPUPPCSta=
te *env)
> >   {
> >       spr_register(env, SPR_DEXCR, "DEXCR",
> >               SPR_NOACCESS, SPR_NOACCESS,
> > -            &spr_read_generic, &spr_write_generic,
> > +            &spr_read_generic, &spr_write_generic32,
> >               0);
> >  =20
> >       spr_register(env, SPR_UDEXCR, "DEXCR",
> > @@ -5741,7 +5741,7 @@ static void register_power10_dexcr_sprs(CPUPPCSta=
te *env)
> >       spr_register_hv(env, SPR_HDEXCR, "HDEXCR",
> >               SPR_NOACCESS, SPR_NOACCESS,
> >               SPR_NOACCESS, SPR_NOACCESS,
> > -            &spr_read_generic, &spr_write_generic,
> > +            &spr_read_generic, &spr_write_generic32,
> >               0);
> >  =20
> >       spr_register(env, SPR_UHDEXCR, "HDEXCR",
> > diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> > index 779e7db513..fb351c303f 100644
> > --- a/target/ppc/helper_regs.c
> > +++ b/target/ppc/helper_regs.c
> > @@ -448,7 +448,7 @@ void register_non_embedded_sprs(CPUPPCState *env)
> >       /* Exception processing */
> >       spr_register_kvm(env, SPR_DSISR, "DSISR",
> >                        SPR_NOACCESS, SPR_NOACCESS,
> > -                     &spr_read_generic, &spr_write_generic,
> > +                     &spr_read_generic, &spr_write_generic32,
> >                        KVM_REG_PPC_DSISR, 0x00000000);
> >       spr_register_kvm(env, SPR_DAR, "DAR",
> >                        SPR_NOACCESS, SPR_NOACCESS,
> > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> > index a9bc1522e2..40ddc5c08c 100644
> > --- a/target/ppc/misc_helper.c
> > +++ b/target/ppc/misc_helper.c
> > @@ -190,13 +190,13 @@ void helper_store_dpdes(CPUPPCState *env, target_=
ulong val)
> >  =20
> >   void helper_store_pidr(CPUPPCState *env, target_ulong val)
> >   {
> > -    env->spr[SPR_BOOKS_PID] =3D val;
> > +    env->spr[SPR_BOOKS_PID] =3D (uint32_t)val;
> >       tlb_flush(env_cpu(env));
> >   }
> >  =20
> >   void helper_store_lpidr(CPUPPCState *env, target_ulong val)
> >   {
> > -    env->spr[SPR_LPIDR] =3D val;
> > +    env->spr[SPR_LPIDR] =3D (uint32_t)val;
> >  =20
> >       /*
> >        * We need to flush the TLB on LPID changes as we only tag HV vs
> > diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
> > index 1381072b9e..64a64865d7 100644
> > --- a/target/ppc/power8-pmu.c
> > +++ b/target/ppc/power8-pmu.c
> > @@ -272,7 +272,7 @@ void helper_store_pmc(CPUPPCState *env, uint32_t sp=
rn, uint64_t value)
> >   {
> >       pmu_update_cycles(env);
> >  =20
> > -    env->spr[sprn] =3D value;
> > +    env->spr[sprn] =3D (uint32_t)value;
> >  =20
> >       pmc_update_overflow_timer(env, sprn);
> >   }
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index f603f1a939..c03a6bdc9a 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -413,7 +413,7 @@ void spr_write_generic(DisasContext *ctx, int sprn,=
 int gprn)
> >  =20
> >   void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
> >   {
> > -    spr_write_generic(ctx, sprn, gprn);
> > +    spr_write_generic32(ctx, sprn, gprn);
> >  =20
> >       /*
> >        * SPR_CTRL writes must force a new translation block,
>
> Just out of curiosity, is this the same as the problem described at [1] f=
or DECAR?
>
>
> ATB,
>
> Mark.
>
> [1] https://lists.nongnu.org/archive/html/qemu-ppc/2023-03/msg00451.html

Oh if it's a 64-bit target running in 32-bit mode, then the compiled
code might use something like li reg,-1 to set the 0xffffffff value,
but that gets sign extended to 64-bits. Storing that to DECAR then
does cause it to get stored to DECR. So DECAR should use
spr_write_generic32.

But all the store_decr calculations are unsigned and DECR gets clamped
to 32-bits, at least when reading it back. The problem seems to be the
timer ends up getting set for a negative expire time.

So storing to DECR directly seems like it would have the same problems
as via DECAR. This should help.

Thanks,
Nick
---

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 4e816c68c7..35a1410c4d 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -794,14 +794,18 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uin=
t64_t *nextp,
     CPUPPCState *env =3D &cpu->env;
     ppc_tb_t *tb_env =3D env->tb_env;
     uint64_t now, next;
+    uint64_t unsigned_value;
+    uint64_t unsigned_decr;
     int64_t signed_value;
     int64_t signed_decr;
=20
     /* Truncate value to decr_width and sign extend for simplicity */
+    unsigned_value =3D extract64(value, 0, nr_bits);
+    unsigned_decr =3D extract64(decr, 0, nr_bits);
     signed_value =3D sextract64(value, 0, nr_bits);
     signed_decr =3D sextract64(decr, 0, nr_bits);
=20
-    trace_ppc_decr_store(nr_bits, decr, value);
+    trace_ppc_decr_store(nr_bits, unsigned_decr, unsigned_value);
=20
     if (kvm_enabled()) {
         /* KVM handles decrementer exceptions, we don't need our own timer=
 */
@@ -821,7 +825,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint6=
4_t *nextp,
      * On MSB edge based DEC implementations the MSB going from 0 -> 1 tri=
ggers
      * an edge interrupt, so raise it here too.
      */
-    if ((value < 3) ||
+    if ((unsigned_value < 3) ||
         ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) |=
|
         ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < =
0
           && signed_decr >=3D 0)) {
@@ -836,7 +840,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint6=
4_t *nextp,
=20
     /* Calculate the next timer event */
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next =3D now + muldiv64(value, NANOSECONDS_PER_SECOND, tb_env->decr_fr=
eq);
+    next =3D now + muldiv64(unsigned_value, NANOSECONDS_PER_SECOND,
+                          tb_env->decr_freq);
     *nextp =3D next;
=20
     /* Adjust timer */

