Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F189730CD2
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 03:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9c1K-0008LH-5g; Wed, 14 Jun 2023 21:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9c1I-0008Kj-15; Wed, 14 Jun 2023 21:43:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9c1G-0003tF-1H; Wed, 14 Jun 2023 21:43:27 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-662f0feafb2so211826b3a.1; 
 Wed, 14 Jun 2023 18:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686793404; x=1689385404;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVGiqT+75LvKk6flW6tJzjxmUoBBEU5I0d+1Pp7AXkc=;
 b=FoGNzLV+RMeDvXIuQnHNHHuqyiyhT0wbcEn+nkVOuueK2oSARVF37H90ioSa434cHr
 f8avAZmXmSW6AkULf/m7rjutaAuxEeS3BH6oZuMKvvvntZR9d6ExfKCdo+9YBXll5rPP
 rUYytpDnhUvmepdCpKec2w9CeKDnKw2zQUSBiCgsUWU8Xj4SKSx3TIou/CXJgp1YaexU
 e6laQ5jkSDQwDDUJu1RjvYSvw/mMHr0vYKgTBgcLgJ64U5WIg7PnvuBkOWhEkh03lCtr
 8u74I4gSunLencrSu0Szqo6orLWl/nUKVVO7xgE6qnYamq1SSJ0/FijCfrit+E6IW5M0
 Y15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686793404; x=1689385404;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xVGiqT+75LvKk6flW6tJzjxmUoBBEU5I0d+1Pp7AXkc=;
 b=VC1A9CnJmfY0cS4bm4NGD+F7DTKcx9p1S9w2Px/zJiDMK2rM5YRx+NsKuHSlan9a9y
 POKJNFjSvihvdyJ8De8bIOhDsgTxuwIFdPMUT0jghXCSJCoYUNzpWfy13SZXjQ3A2vut
 zUv44dMxuba/341Y8q589JAUVuY8q55q3CQ0dtG738aElCzYXHXepk9e47ihN2vlkKQ6
 NcltUESBCofODdjwLGNFTFGRUh6oOJ2QiyK8re/QGS0AoqRapGrpO2YQ9656yXoFXuh/
 zp7sOsIN6RQPSzsHruBLq2hCLSKc0cj1emz7B2IqLxvLmrhe+cbOQ/puCumUMXPFcYoP
 1h8Q==
X-Gm-Message-State: AC+VfDxtDg8jY9jT/5+JK2qHqdW1uL58KHMrOPQV89N/f5dyhQK5QFUk
 RIgK7pat6fbcsddP0stGRTE=
X-Google-Smtp-Source: ACHHUZ58G4l3GebFfbmWxgOD0t3at+vs3wNQh+f2Y155Di7lUKXgqkNUeTlpSoPc0dkYbyqdNdEO2g==
X-Received: by 2002:a05:6a00:2d9d:b0:656:5182:5e61 with SMTP id
 fb29-20020a056a002d9d00b0065651825e61mr4748800pfb.2.1686793404029; 
 Wed, 14 Jun 2023 18:43:24 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa78008000000b00659edece5dasm8836035pfi.49.2023.06.14.18.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 18:43:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 11:43:18 +1000
Message-Id: <CTCUCTKOWUT6.111CRYUYBN9HO@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <clg@kaod.org>, "Greg
 Kurz" <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 08/10] target/ppc: Fix gen_sc to use correct nip
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <7ae167986e18144bc665bbdd836b49fe723a90a1.1686522199.git.balaton@eik.bme.hu>
 <CTC2DN50X8A2.2UVS9YQ2HNYJ9@wheely>
 <da6086be-ccd8-7cbf-8fbe-e4924d9c230f@eik.bme.hu>
In-Reply-To: <da6086be-ccd8-7cbf-8fbe-e4924d9c230f@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Thu Jun 15, 2023 at 7:27 AM AEST, BALATON Zoltan wrote:
> On Wed, 14 Jun 2023, Nicholas Piggin wrote:
> > On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> >> Most exceptions are raised with nip pointing to the faulting
> >> instruction but the sc instruction generating a syscall exception
> >> leaves nip pointing to next instruction. Fix gen_sc to not use
> >> gen_exception_err() which sets nip back but correctly set nip to
> >> pc_next so we don't have to patch this in the exception handlers.
> >>
> >> This changes the nip logged in dump_syscall and dump_hcall debug
> >> functions but now this matches how nip would be on a real CPU.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/excp_helper.c | 39 ---------------------------------------
> >>  target/ppc/translate.c   |  8 +++++---
> >>  2 files changed, 5 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> >> index 885e479301..4f6a6dfb19 100644
> >> --- a/target/ppc/excp_helper.c
> >> +++ b/target/ppc/excp_helper.c
> >> @@ -493,12 +493,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int=
 excp)
> >>          break;
> >>      case POWERPC_EXCP_SYSCALL:   /* System call exception            =
        */
> >>          dump_syscall(env);
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >>          break;
> >>      case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt   =
        */
> >>          trace_ppc_excp_print("FIT");
> >> @@ -609,12 +603,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int=
 excp)
> >>          break;
> >>      case POWERPC_EXCP_SYSCALL:   /* System call exception            =
        */
> >>          dump_syscall(env);
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >>          break;
> >>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable except=
ion     */
> >>      case POWERPC_EXCP_DECR:      /* Decrementer exception            =
        */
> >> @@ -757,13 +745,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int=
 excp)
> >>          } else {
> >>              dump_syscall(env);
> >>          }
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >> -
> >>          /*
> >>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
> >>           * instruction to communicate with QEMU. The pegasos2 machine
> >> @@ -908,13 +889,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, in=
t excp)
> >>          } else {
> >>              dump_syscall(env);
> >>          }
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >> -
> >>          /*
> >>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
> >>           * instruction to communicate with QEMU. The pegasos2 machine
> >> @@ -1073,12 +1047,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu,=
 int excp)
> >>          break;
> >>      case POWERPC_EXCP_SYSCALL:   /* System call exception            =
        */
> >>          dump_syscall(env);
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >>          break;
> >>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable except=
ion     */
> >>      case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable  =
        */
> >> @@ -1320,13 +1288,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu,=
 int excp)
> >>          } else {
> >>              dump_syscall(env);
> >>          }
> >> -
> >> -        /*
> >> -         * We need to correct the NIP which in this case is supposed
> >> -         * to point to the next instruction
> >> -         */
> >> -        env->nip +=3D 4;
> >> -
> >>          /* "PAPR mode" built-in hypercall emulation */
> >>          if (lev =3D=3D 1 && books_vhyp_handles_hcall(cpu)) {
> >>              PPCVirtualHypervisorClass *vhc =3D
> >> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> >> index a32a9b8a5f..4260d3d66f 100644
> >> --- a/target/ppc/translate.c
> >> +++ b/target/ppc/translate.c
> >> @@ -4419,10 +4419,12 @@ static void gen_hrfid(DisasContext *ctx)
> >>  #endif
> >>  static void gen_sc(DisasContext *ctx)
> >>  {
> >> -    uint32_t lev;
> >> +    uint32_t lev =3D (ctx->opcode >> 5) & 0x7F;
> >>
> >> -    lev =3D (ctx->opcode >> 5) & 0x7F;
> >> -    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
> >> +    gen_update_nip(ctx, ctx->base.pc_next);
> >> +    gen_helper_raise_exception_err(cpu_env, tcg_constant_i32(POWERPC_=
SYSCALL),
> >> +                                   tcg_constant_i32(lev));
> >> +    ctx->base.is_jmp =3D DISAS_NORETURN;
> >
> > Generally for blame and bisect I don't like to mix cleanup with real
> > change, I guess this is pretty minor though.
> >
> > Great cleanup though, sc is certainly defined to set SRR0 to the
> > instruction past the sc unlike other interrupts so it is more natural
> > and less hacky feeling do it like this.
> >
> > Could you do scv while you are here? It has the same semantics as
> > sc.
>
> I've tried but scv seems to be a bit different as it can sometimes raise=
=20
> POWERPC_EXCP_FU instead of POWERPC_EXCP_SYSCALL_VECTORED according to=20
> excp_helper.c::helper_scv() which may need the nip to be different so I'd=
=20
> rather leave this to somebody who knows what they are doing.

Yes and the fscr check requires a helper so no point doing that
twice, but I think it would still better match the new sc code to
have something like this (patch is tested, you can squash it in
yours if you like):

Thanks,
Nick
---

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 12d8a7257b..55c6edfacb 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1507,7 +1507,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int e=
xcp)
     case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                  =
   */
         lev =3D env->error_code;
         dump_syscall(env);
-        env->nip +=3D 4;
         new_msr |=3D env->msr & ((target_ulong)1 << MSR_EE);
         new_msr |=3D env->msr & ((target_ulong)1 << MSR_RI);
=20
@@ -2623,6 +2622,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
 void helper_scv(CPUPPCState *env, uint32_t lev)
 {
     if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
+        env->nip +=3D 4;
         raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
     } else {
         raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b591f2e496..90d07a3e56 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4432,7 +4432,11 @@ static void gen_scv(DisasContext *ctx)
 {
     uint32_t lev =3D (ctx->opcode >> 5) & 0x7F;
=20
-    /* Set the PC back to the faulting instruction. */
+    /*
+     * Set the PC back to the scv instruction (unlike sc), because a facil=
ity
+     * unavailable interrupt must be generated if FSCR[SCV]=3D0. The helpe=
r
+     * advances nip if the FSCR check passes.
+     */
     gen_update_nip(ctx, ctx->cia);
     gen_helper_scv(cpu_env, tcg_constant_i32(lev));
=20

