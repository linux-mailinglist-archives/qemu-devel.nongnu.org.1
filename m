Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFCC74077E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 03:11:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEJhM-0001Kc-Ae; Tue, 27 Jun 2023 21:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEJhI-0001KJ-JO; Tue, 27 Jun 2023 21:10:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEJhG-0000qP-N7; Tue, 27 Jun 2023 21:10:16 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-66f3fc56ef4so313088b3a.0; 
 Tue, 27 Jun 2023 18:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687914612; x=1690506612;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUUgqxCjkgnMo/9xXaKhVhe6c8pTfoAe33rRRKjbJY8=;
 b=PDUM0Lelt2prUdcyvy3Emec2YVDt/FLkAt8n7jZ8i0ixvde2DpZShgoFWAJU54Eb38
 TpWbW9w0Z1uzNJFAxzxJNli9WTTvBmZmHTkoQVPCPFWLyF0px/YX3J9LnnTh+cM/ndEq
 kiOsD4FVYupuuXK2A3B6vM7yev4qNP0EaePVmdQpgeDg+Yd5i8c5sYkMUVGafOZP9X+a
 RuwSVBxILzI67FEL5hSWYXsL184tyd97zA+zZoFSisjs+gRRBhNSDB8CrzJV2qmf0VWF
 2qvss1u26zndhfnEcAHvgGaPsovd28AV07A1PBBT6OTRSkLKiM++EJdC8xxbZfF60UTY
 xw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687914612; x=1690506612;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YUUgqxCjkgnMo/9xXaKhVhe6c8pTfoAe33rRRKjbJY8=;
 b=efsorLN5IgVPqjW5lUSBfrnrO7nw9JOjRXDZYGfrvFT0kr4QEgcush2xvXNxsby8Jy
 WVPH/eiG+uTgleiClJ0qojnt/H0rV9wSqt3aQidutoGO0wZ9mWYGCIEri9q69qTpj2nL
 /Ie8yr319R2h1YHuEWgvDeKO6R4B7DOY83uBPZRvxMoiojEiOlElVl9HWkIK1UHgwt7d
 Q4pAS6oYCs9EbltHnXG+5ndnH/LHGGFcQ17mPn9MctXPlU+v8M11GDfHcBJoZIYXp3dG
 cISMs5Akn30Mm5hp47iMgEDSKOafRGadugOyC7xJ4yZXy7nCTgTcchUuZNYyIAWqlqdo
 2avg==
X-Gm-Message-State: AC+VfDxQdWdzGvJwFEL81p9vJv3OaO/epgoIRSkKHTZukFsK6A6DvDv2
 10VWh+/7mN1Qh+X2uUajOus=
X-Google-Smtp-Source: ACHHUZ70nUXgUMMHE82cJN9iWHME6zuDMHYb4hTW51HlLSlxBG0tq/W9i/5M2ztmgbG8RFj1u5HppQ==
X-Received: by 2002:a17:90a:3d4c:b0:263:3386:9da3 with SMTP id
 o12-20020a17090a3d4c00b0026333869da3mr2189236pjf.17.1687914612370; 
 Tue, 27 Jun 2023 18:10:12 -0700 (PDT)
Received: from localhost (193-116-109-121.tpgi.com.au. [193.116.109.121])
 by smtp.gmail.com with ESMTPSA id
 10-20020a17090a19ca00b0026104629998sm9058404pjj.43.2023.06.27.18.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 18:10:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jun 2023 11:10:06 +1000
Message-Id: <CTNVSHIQ02CO.1PRX2304TIYZH@wheely>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] target/ppc: Implement attn instruction on BookS
 64-bit processors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Fabiano Rosas" <farosas@suse.de>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-5-npiggin@gmail.com> <87352dexl6.fsf@suse.de>
In-Reply-To: <87352dexl6.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

On Wed Jun 28, 2023 at 1:25 AM AEST, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > attn is an implementation-specific instruction that on POWER (and G5/
> > 970) can be enabled with a HID bit (disabled =3D illegal), and executin=
g
> > it causes the host processor to stop and the service processor to be
> > notified. Generally used for debugging.
> >
> > Implement attn and make it checkstop the system, which should be good
> > enough for QEMU debugging.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Since v1:
> > - New patch that also uses checkstop function. Works with skiboot.
> >
> >  target/ppc/cpu.h         |  2 ++
> >  target/ppc/excp_helper.c | 28 ++++++++++++++++++++++++++++
> >  target/ppc/helper.h      |  2 ++
> >  target/ppc/translate.c   |  7 +++++++
> >  4 files changed, 39 insertions(+)
> >
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 94497aa115..f6e93dec5f 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -2116,6 +2116,8 @@ void ppc_compat_add_property(Object *obj, const c=
har *name,
> >  #define HID0_NAP            (1 << 22)           /* pre-2.06 */
> >  #define HID0_HILE           PPC_BIT(19) /* POWER8 */
> >  #define HID0_POWER9_HILE    PPC_BIT(4)
> > +#define HID0_ENABLE_ATTN    PPC_BIT(31) /* POWER8 */
> > +#define HID0_POWER9_ENABLE_ATTN PPC_BIT(3)
> > =20
> >  /*********************************************************************=
********/
> >  /* PowerPC Instructions types definitions                             =
       */
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 28d8a9b212..f46fdd2ee6 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -208,6 +208,34 @@ static void powerpc_checkstop(CPUPPCState *env, co=
nst char *reason)
> >  }
> > =20
> >  #if defined(TARGET_PPC64)
> > +void helper_attn(CPUPPCState *env)
> > +{
> > +    CPUState *cs =3D env_cpu(env);
> > +    target_ulong hid0_attn =3D 0;
> > +
> > +    switch (env->excp_model) {
> > +    case POWERPC_EXCP_970:
> > +    case POWERPC_EXCP_POWER7:
> > +    case POWERPC_EXCP_POWER8:
> > +        hid0_attn =3D HID0_ENABLE_ATTN;
> > +        break;
> > +    case POWERPC_EXCP_POWER9:
> > +    case POWERPC_EXCP_POWER10:
> > +        hid0_attn =3D HID0_POWER9_ENABLE_ATTN;
> > +        break;
> > +    default:
> > +        break;
> > +    }
>
> There's some precedent for checking HID bits using a cpu class
> function. See pcc->check_pow, check_pow_hid0() and
> check_pow_hid0_74xx(). I find it a bit nicer because the class carries
> all the data so it's easier to move code around.

Good suggestion, thanks.

> > +
> > +    if (env->spr[SPR_HID0] & hid0_attn) {
> > +        powerpc_checkstop(env, "host executed attn");
> > +        cpu_loop_exit_noexc(cs);
> > +    } else {
> > +        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
> > +                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_IN=
VAL);
> > +    }
> > +}
> > +
> >  static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int ex=
cp,
> >                                  target_ulong *msr)
> >  {
> > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > index fda40b8a60..50bb105c08 100644
> > --- a/target/ppc/helper.h
> > +++ b/target/ppc/helper.h
> > @@ -812,3 +812,5 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
> > =20
> >  DEF_HELPER_1(tbegin, void, env)
> >  DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
> > +
> > +DEF_HELPER_1(attn, void, env)
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 372ee600b2..4e9e606d77 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -6382,6 +6382,12 @@ static void gen_dform3D(DisasContext *ctx)
> >  }
> > =20
> >  #if defined(TARGET_PPC64)
> > +/* attn */
> > +static void gen_attn(DisasContext *ctx)
> > +{
> > +    gen_helper_attn(cpu_env);
>
> In another incarnation of this patch, C=C3=A9dric had a check for the
> privilege level and linux-user:
>
> +static void gen_attn(DisasContext *ctx)
> +{
> + #if defined(CONFIG_USER_ONLY)
> +    GEN_PRIV;
> +#else
> +    CHK_SV;
> +
> +    gen_helper_attn(cpu_env, cpu_gpr[3]);
> +    ctx->base.is_jmp =3D DISAS_NORETURN;
> +#endif
> +}

User only could be checked... On priv, I thought that attn is
unprivileged (so long as it is enabled in HID). I could check
what hardware does.

>
> > +}
> > +
> >  /* brd */
> >  static void gen_brd(DisasContext *ctx)
> >  {
> > @@ -6413,6 +6419,7 @@ static void gen_brh(DisasContext *ctx)
> > =20
> >  static opcode_t opcodes[] =3D {
> >  #if defined(TARGET_PPC64)
> > +GEN_HANDLER_E(attn, 0x00, 0x00, 0x08, 0xFFFFFDFF, PPC_NONE,
> >  PPC2_ISA207S),
>
> Aren't you missing the 970 with this? Maybe worth a insns_flag2 flag
> just for the attn?

Yes good catch, I started out just doing powernv but found 970 manual
and it has attn. Will update.

Thanks,
Nick

