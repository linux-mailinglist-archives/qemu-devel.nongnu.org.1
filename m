Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9F845E71
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 18:23:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rValN-0002YL-CS; Thu, 01 Feb 2024 12:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rValJ-0002YB-HQ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:22:05 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rValH-0004fQ-2k
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:22:05 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55fe4534e9bso65371a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706808120; x=1707412920; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAxXAkmWjFalAKG9epWDBGxsg22LhG29DLdxe/gZN3E=;
 b=JZBxoa5hka92eXLQioz7b7yKY4hig5JeTThQ92s33qQ6Hs5N+23cPGjgn4E/Gh18Lc
 KoAua325KIXzgxABpZGrT7MOMvkI8X6wxAeTeCFZOhsUZAwW+7VskuKd2y8umrNPIdD6
 xnz1Ak5sqTi7ClieCP8j8JOo7l1yJIPOmAGIhgpYiYtLHnyeBSQPsNQvHIrHkNLO/APd
 5UvCJ16DGdTdZOnO0GEVZMEiwG26rPnkAUYdhAoolqY8CUwLAox/KyY2JkDz8RsssLI2
 weaOSXG4q1U80tNGTQ/R9rtM1nndGNxPwkMLRKOuBxgtzLWycLzlgmZaFxaT1pOcxL0L
 Uayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706808120; x=1707412920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAxXAkmWjFalAKG9epWDBGxsg22LhG29DLdxe/gZN3E=;
 b=OsFm1CJIMWYLbxOGPItCgtUVp/T/KLb/quwNNJs0/p2KzM0Fi88+gayUf2ifY/j/99
 DjF1oSKEUGlc7b8e4mD2aaxemyFz6+nog3j0+nQ9L+AFKgvy33jrHPHfhRrZBQjU2GmT
 GsXzfHZFhBTjBff/YAC7J11MshYWf2KCIyS90XoCZL7OIwITNxWEGkqZWfISnFhRWF21
 OcImbRlUNVoUqydPImWZBau/O5oh4otX1NVjbhcstelkkirjSu8kbLr4A4ZSFfYieIUs
 P+kwevPOV23CZuIDQgpiCUWaKnID+TjG67TddwLls7Jr+rXOyYO8Dtogu1NUq/uRxhc6
 cYfw==
X-Gm-Message-State: AOJu0YyzNBjAU1VHG973RA4TU179Tuag3+6T14TQ6ok+Q+c9EtbVQPTD
 eek07SrJk6wu9T/i2QvvYzutDRZKCy06oQpUv7DJO0WYFN6YwUt7XQ3aKgCCPG1rmjEOA86HekL
 d60QnHWwFZcVJptKSV6x8eqMcHeRL1FBgRUf1uw==
X-Google-Smtp-Source: AGHT+IGPJQ1U6njbV2nEc0XeHCDBxXaV+QYUI37Xq94Aup8TodieAEDiF3rYge6q6ffbpoygwYo/dsVUyV6UjJFKPuk=
X-Received: by 2002:aa7:c30e:0:b0:55f:e147:2524 with SMTP id
 l14-20020aa7c30e000000b0055fe1472524mr189852edq.38.1706808120213; Thu, 01 Feb
 2024 09:22:00 -0800 (PST)
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com>
In-Reply-To: <20240201170822.00005bad@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 17:21:49 +0000
Message-ID: <CAFEAcA-5KhX+O0tCTdkPbkobNo1sprgebqs63ebzKc5v7KqYeg@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Sajjan Rao <sajjanr@gmail.com>, Gregory Price <gregory.price@memverge.com>, 
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024 at 17:08, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 01 Feb 2024 16:45:30 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> >
> > > On Thu, 1 Feb 2024 16:00:56 +0000
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > >> On Thu, 1 Feb 2024 at 15:17, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
> > >> >
> > >> > Peter Maydell <peter.maydell@linaro.org> writes:
> > >> > > So, that looks like:
> > >> > >  * we call cpu_tb_exec(), which executes some generated code
> > >> > >  * that generated code calls the lookup_tb_ptr helper to see
> > >> > >    if we have a generated TB already for the address we're going
> > >> > >    to execute next
> > >> > >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
> > >> > >    address for the guest address
> > >> > >  * this results in a TLB walk for an instruction fetch
> > >> > >  * the page table descriptor load is to IO memory
> > >> > >  * io_prepare assumes it needs to do a TLB recompile, because
> > >> > >    can_do_io is clear
> > >> > >
> > >> > > I am not surprised that the corner case of "the guest put its
> > >> > > page tables in an MMIO device" has not yet come up :-)
> > >> > >
> > >> > > I'm really not sure how the icount handling should interact
> > >> > > with that...
> > >> >
> > >> > Its not just icount - we need to handle it for all modes now. That=
 said
> > >> > seeing as we are at the end of a block shouldn't can_do_io be set?
> > >>
> > >> The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
> > >> which happens earlier than the tb_stop callback (it can
> > >> happen in the trans function for branch etc insns, for
> > >> example).
> > >>
> > >> I think it should be OK to clear can_do_io at the start
> > >> of the lookup_tb_ptr helper, something like:
> > >> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > >> index 977576ca143..7818537f318 100644
> > >> --- a/accel/tcg/cpu-exec.c
> > >> +++ b/accel/tcg/cpu-exec.c
> > >> @@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState =
*env)
> > >>      uint64_t cs_base;
> > >>      uint32_t flags, cflags;
> > >>
> > >> +    /*
> > >> +     * By definition we've just finished a TB, so I/O is OK.
> > >> +     * Avoid the possibility of calling cpu_io_recompile() if
> > >> +     * a page table walk triggered by tb_lookup() calling
> > >> +     * probe_access_internal() happens to touch an MMIO device.
> > >> +     * The next TB, if we chain to it, will clear the flag again.
> > >> +     */
> > >> +    cpu->neg.can_do_io =3D true;
> > >> +
> > >>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> > >>
> > >>      cflags =3D curr_cflags(cpu);
> > >>
> > >> -- PMM
> > >
> > > No joy.  Seems like a very similar backtrace.
> > >
> > > Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
> > > [Switching to Thread 0x7ffff4efe6c0 (LWP 23937)]
> > > __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<opt=
imized out>) at ./nptl/pthread_kill.c:44
> > > 44      ./nptl/pthread_kill.c: No such file or directory.
> > > (gdb) bt
> > > #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D=
<optimized out>) at ./nptl/pthread_kill.c:44
> > > #1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>) a=
t ./nptl/pthread_kill.c:78
> > > #2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@en=
try=3D6) at ./nptl/pthread_kill.c:89
> > > #3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysd=
eps/posix/raise.c:26
> > > #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
> > > #5  0x0000555555c4d19e in cpu_abort (cpu=3Dcpu@entry=3D0x5555578e0cb0=
, fmt=3Dfmt@entry=3D0x555556048ee8 "cpu_io_recompile: could not find TB for=
 pc=3D%p") at ../../cpu-target.c:373
> > > #6  0x0000555555c9cb25 in cpu_io_recompile (cpu=3Dcpu@entry=3D0x55555=
78e0cb0, retaddr=3Dretaddr@entry=3D0) at ../../accel/tcg/translate-all.c:61=
1
> > > #7  0x0000555555c9f744 in io_prepare (retaddr=3D0, addr=3D19595790664=
, attrs=3D..., xlat=3D<optimized out>, cpu=3D0x5555578e0cb0, out_offset=3D<=
synthetic pointer>) at ../../accel/tcg/cputlb.c:1339
> > > #8  do_ld_mmio_beN (cpu=3D0x5555578e0cb0, full=3D0x7ffe88012890, ret_=
be=3Dret_be@entry=3D0, addr=3D19595790664, size=3Dsize@entry=3D8, mmu_idx=
=3D4, type=3DMMU_DATA_LOAD, ra=3D0) at ../../accel/tcg/cputlb.c:2030
> > > #9  0x0000555555ca0ecd in do_ld_8 (cpu=3Dcpu@entry=3D0x5555578e0cb0, =
p=3Dp@entry=3D0x7ffff4efcdd0, mmu_idx=3D<optimized out>, type=3Dtype@entry=
=3DMMU_DATA_LOAD, memop=3D<optimized out>, ra=3Dra@entry=3D0) at ../../acce=
l/tcg/cputlb.c:2356
> > > #10 0x0000555555ca332f in do_ld8_mmu (cpu=3Dcpu@entry=3D0x5555578e0cb=
0, addr=3Daddr@entry=3D19595790664, oi=3Doi@entry=3D52, ra=3Dra@entry=3D0, =
access_type=3Daccess_type@entry=3DMMU_DATA_LOAD) at ../../accel/tcg/cputlb.=
c:2439
> > > #11 0x0000555555ca5e69 in cpu_ldq_mmu (ra=3D0, oi=3D52, addr=3D195957=
90664, env=3D0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
> > > #12 cpu_ldq_le_mmuidx_ra (env=3D0x5555578e3470, addr=3D19595790664, m=
mu_idx=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/ldst_common=
.c.inc:301
> > > #13 0x0000555555b4b5de in ptw_ldq (in=3D0x7ffff4efcf10) at ../../targ=
et/i386/tcg/sysemu/excp_helper.c:98
> > > #14 ptw_ldq (in=3D0x7ffff4efcf10) at ../../target/i386/tcg/sysemu/exc=
p_helper.c:93
> > > #15 mmu_translate (env=3Denv@entry=3D0x5555578e3470, in=3D0x7ffff4efc=
fd0, out=3D0x7ffff4efcfa0, err=3Derr@entry=3D0x7ffff4efcfb0) at ../../targe=
t/i386/tcg/sysemu/excp_helper.c:173
> > > #16 0x0000555555b4c3f3 in get_physical_address (err=3D0x7ffff4efcfb0,=
 out=3D0x7ffff4efcfa0, mmu_idx=3D0, access_type=3DMMU_DATA_STORE, addr=3D18=
386491786698339392, env=3D0x5555578e3470) at ../../target/i386/tcg/sysemu/e=
xcp_helper.c:578
> > > #17 x86_cpu_tlb_fill (cs=3D0x5555578e0cb0, addr=3D1838649178669833939=
2, size=3D<optimized out>, access_type=3DMMU_DATA_STORE, mmu_idx=3D0, probe=
=3D<optimized out>, retaddr=3D140736029817822) at ../../target/i386/tcg/sys=
emu/excp_helper.c:604
> > > #18 0x0000555555ca0df9 in tlb_fill (retaddr=3D140736029817822, mmu_id=
x=3D0, access_type=3DMMU_DATA_STORE, size=3D<optimized out>, addr=3D1838649=
1786698339392, cpu=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1315
> > > #19 mmu_lookup1 (cpu=3Dcpu@entry=3D0x5555578e0cb0, data=3Ddata@entry=
=3D0x7ffff4efd120, mmu_idx=3D0, access_type=3Daccess_type@entry=3DMMU_DATA_=
STORE, ra=3Dra@entry=3D140736029817822) at ../../accel/tcg/cputlb.c:1713
> > > #20 0x0000555555ca2b71 in mmu_lookup (cpu=3D0x5555578e0cb0, addr=3D18=
386491786698339392, oi=3D<optimized out>, ra=3D140736029817822, type=3DMMU_=
DATA_STORE, l=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1803
> > > #21 0x0000555555ca3e5d in do_st8_mmu (cpu=3D0x5555578e0cb0, addr=3D23=
937, val=3D18386491784638059520, oi=3D6, ra=3D140736029817822) at ../../acc=
el/tcg/cputlb.c:2853
> > > #22 0x00007fffa9107c63 in code_gen_buffer ()
> >
> > No thats different - we are actually writing to the MMIO region here.
> > But the fact we hit cpu_abort because we can't find the TB we are
> > executing is a little problematic.
> >
> > Does ra properly point to the code buffer here?
>
> Err.  How would I tell?

Well, a NULL pointer for the return address is definitely not in
the codegen buffer :-)

This is again a TLB fill case, but this time it's a data
access from a guest store insn. We had the correct ra when we
did the do_st8_mmu() down in frame 21: ra=3D140736029817822,
but as we go through the page table walk, we leave the ra
behind in x86_cpu_tlb_fill(), and so the ptw_ldq()
passes a zero ra down to the cpu_ldq_mmuidx_ra() (which
is generally meant to mean "I am not being called from
translated code and so can_do_io should be false").

I think that none of the page-table-walking handling
(either in target code or in general) has been designed
with the idea in mind that it might need to do something
for icount if the ptw touches an MMIO device. This is probably
not as simple as merely "plumb the ra value down through the
ptw code" -- somebody needs to think about whether doing
an io_recompile() is the right response to that situation.
And any "do an address translation for me" system insns
might or might not need to be dealt with differently.

If you can at all arrange for your workload not to put
page tables into MMIO device regions then your life will
be a lot simpler.

thanks
-- PMM

