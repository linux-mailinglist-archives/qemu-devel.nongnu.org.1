Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C2845E7B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 18:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaok-0003zQ-Tt; Thu, 01 Feb 2024 12:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVaoV-0003xS-Lb
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:25:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVaoT-0006XK-1s
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:25:22 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fb804e330so10728175e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 09:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706808319; x=1707413119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvyz7svt+rDKyDp/SOgh9hz72wTjUIXmJmJV4jS2tOM=;
 b=XJBZvqXoB5alaDNZn/7VWJMLPNlxB2RUtipzJEsWWYJwEE1vpYCX0AbNAVwjICrUdK
 ijk3xspPFdgzh0051wnXHDuuH9+H88PQW//RMPOUev5izpJE63WiWyxNmdJAArcEkQNR
 ReqghTuT4FoyuMaC7ecwMteSXM4yK+yYtKeOzcLJkgtooHKLg/ocy7BFrYEsfOPXQlxo
 jKKIBgiH4msDir9hvCcHy8daDZVAHYFR3B5gWs8tkLLDvW5RtbT/eJ1Z093mNHuCJNkZ
 4m4m3+tLSmSw5kF2IpdYjBw7MoBSFoFWsply1+WZBu0YVE34z4VYLAMdfenKO59tVZJa
 UHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706808319; x=1707413119;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvyz7svt+rDKyDp/SOgh9hz72wTjUIXmJmJV4jS2tOM=;
 b=o1QCHh/EQ/JmzN+C1WsGhShr6CSSXNayP8TXBa0gmj+me44bkO4yEusfF1M9rzscIr
 7/7bgML+AsHw/iheJG1hTi499eSw6k63h0M5GNfDmwP4VLpMzZqIwfGL7a9Ne3w+Zuk8
 NoUHK1zaHZffoMGufWmf6KrTSQu7YwMTSlYhNX2sQkrZ0aJZcJopyjkuPXMNFjPsJMtg
 VbI5hWzQmoCs5UXoO5k7Ze+ZrrCfMx4yGluw0r0rBsEs9fDbnTnw0G5oE1vN1/kkKgeU
 bpscvUYTNpTYZ0hQGFMYmvjiDx8AjYJfO/EvFdunuVhVtRyLKZt/9xDADlyYnOpO97/6
 69UA==
X-Gm-Message-State: AOJu0YxmqEQgOT0eNd5e0WESVpW5/SGG4J59ECNISUPe9KvdYvY+D48T
 hi9+ftHiYlhizipLImiJFhSN8o9YkRxQFB6ll3X0xxHLZ6CUN7aWFWvpM+W0Owc=
X-Google-Smtp-Source: AGHT+IHAMvhBdsLXHDMyKvRHOmOiHl55AXpZkLLlgGCdhru8fH8HCQZqv2bOI9DhR+ITo+6M0WQrxQ==
X-Received: by 2002:a05:600c:3510:b0:40e:fd1d:af6a with SMTP id
 h16-20020a05600c351000b0040efd1daf6amr4636237wmq.38.1706808319045; 
 Thu, 01 Feb 2024 09:25:19 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUGa7sqmCiNtaTnDBF9jrEtXkRHop13zY1Kj1dfUAGax1iriuq0Dlu0Ujl3C29vhSRoPhln00JbJ3EwtJpYnsNFaCDBdW2JMBNfE6H9DIxtDZ9rImGZbwrrTDVTVqkpywmyQNIYMQ+jKWtk8C2aGfjnHpFpHl1YbqCHojrRRySabD6Hkf8W5DdZx0jytyeuyyvtVuSvAGL3FlcVbS6T4e8zRx+9sPZjTS24QYSJWfjMbuH2kXy3yUWPGPEL4s9SUPpwwfH5GEgKDeOeFuE=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v7-20020a5d4a47000000b0033aef37ec94sm10694654wrs.113.2024.02.01.09.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 09:25:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62E215F7AF;
 Thu,  1 Feb 2024 17:25:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Sajjan Rao
 <sajjanr@gmail.com>,  Gregory Price <gregory.price@memverge.com>,
 "Dimitrios Palyvos" <dimitrios.palyvos@zptcorp.com>,
 <linux-cxl@vger.kernel.org>,  <qemu-devel@nongnu.org>,
 <richard.henderson@linaro.org>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
In-Reply-To: <20240201170822.00005bad@Huawei.com> (Jonathan Cameron's message
 of "Thu, 1 Feb 2024 17:08:22 +0000")
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
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 17:25:18 +0000
Message-ID: <87r0hwjdvl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, LOTS_OF_MONEY=0.001,
 MONEY_NOHTML=2.497, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=no autolearn_force=no
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

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Thu, 01 Feb 2024 16:45:30 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>>=20
>> > On Thu, 1 Feb 2024 16:00:56 +0000
>> > Peter Maydell <peter.maydell@linaro.org> wrote:
>> >=20=20
>> >> On Thu, 1 Feb 2024 at 15:17, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:=20=20
>> >> >
>> >> > Peter Maydell <peter.maydell@linaro.org> writes:=20=20=20=20
>> >> > > So, that looks like:
>> >> > >  * we call cpu_tb_exec(), which executes some generated code
>> >> > >  * that generated code calls the lookup_tb_ptr helper to see
>> >> > >    if we have a generated TB already for the address we're going
>> >> > >    to execute next
>> >> > >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
>> >> > >    address for the guest address
>> >> > >  * this results in a TLB walk for an instruction fetch
>> >> > >  * the page table descriptor load is to IO memory
>> >> > >  * io_prepare assumes it needs to do a TLB recompile, because
>> >> > >    can_do_io is clear
>> >> > >
>> >> > > I am not surprised that the corner case of "the guest put its
>> >> > > page tables in an MMIO device" has not yet come up :-)
>> >> > >
>> >> > > I'm really not sure how the icount handling should interact
>> >> > > with that...=20=20=20=20
>> >> >
>> >> > Its not just icount - we need to handle it for all modes now. That =
said
>> >> > seeing as we are at the end of a block shouldn't can_do_io be set?=
=20=20=20=20
>> >>=20
>> >> The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
>> >> which happens earlier than the tb_stop callback (it can
>> >> happen in the trans function for branch etc insns, for
>> >> example).
>> >>=20
>> >> I think it should be OK to clear can_do_io at the start
>> >> of the lookup_tb_ptr helper, something like:
>> >> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> >> index 977576ca143..7818537f318 100644
>> >> --- a/accel/tcg/cpu-exec.c
>> >> +++ b/accel/tcg/cpu-exec.c
>> >> @@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *=
env)
>> >>      uint64_t cs_base;
>> >>      uint32_t flags, cflags;
>> >>=20
>> >> +    /*
>> >> +     * By definition we've just finished a TB, so I/O is OK.
>> >> +     * Avoid the possibility of calling cpu_io_recompile() if
>> >> +     * a page table walk triggered by tb_lookup() calling
>> >> +     * probe_access_internal() happens to touch an MMIO device.
>> >> +     * The next TB, if we chain to it, will clear the flag again.
>> >> +     */
>> >> +    cpu->neg.can_do_io =3D true;
>> >> +
>> >>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>> >>=20
>> >>      cflags =3D curr_cflags(cpu);
>> >>=20
>> >> -- PMM=20=20
>> >
>> > No joy.  Seems like a very similar backtrace.
>> >
>> > Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
>> > [Switching to Thread 0x7ffff4efe6c0 (LWP 23937)]
>> > __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<opti=
mized out>) at ./nptl/pthread_kill.c:44
>> > 44      ./nptl/pthread_kill.c: No such file or directory.
>> > (gdb) bt
>> > #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<=
optimized out>) at ./nptl/pthread_kill.c:44
>> > #1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>) at=
 ./nptl/pthread_kill.c:78
>> > #2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@ent=
ry=3D6) at ./nptl/pthread_kill.c:89
>> > #3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysde=
ps/posix/raise.c:26
>> > #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
>> > #5  0x0000555555c4d19e in cpu_abort (cpu=3Dcpu@entry=3D0x5555578e0cb0,=
 fmt=3Dfmt@entry=3D0x555556048ee8 "cpu_io_recompile: could not find TB for =
pc=3D%p") at ../../cpu-target.c:373
>> > #6  0x0000555555c9cb25 in cpu_io_recompile (cpu=3Dcpu@entry=3D0x555557=
8e0cb0, retaddr=3Dretaddr@entry=3D0) at ../../accel/tcg/translate-all.c:611
>> > #7  0x0000555555c9f744 in io_prepare (retaddr=3D0, addr=3D19595790664,=
 attrs=3D..., xlat=3D<optimized out>, cpu=3D0x5555578e0cb0, out_offset=3D<s=
ynthetic pointer>) at ../../accel/tcg/cputlb.c:1339
>> > #8  do_ld_mmio_beN (cpu=3D0x5555578e0cb0, full=3D0x7ffe88012890, ret_b=
e=3Dret_be@entry=3D0, addr=3D19595790664, size=3Dsize@entry=3D8, mmu_idx=3D=
4, type=3DMMU_DATA_LOAD, ra=3D0) at ../../accel/tcg/cputlb.c:2030
>> > #9  0x0000555555ca0ecd in do_ld_8 (cpu=3Dcpu@entry=3D0x5555578e0cb0, p=
=3Dp@entry=3D0x7ffff4efcdd0, mmu_idx=3D<optimized out>, type=3Dtype@entry=
=3DMMU_DATA_LOAD, memop=3D<optimized out>, ra=3Dra@entry=3D0) at ../../acce=
l/tcg/cputlb.c:2356
>> > #10 0x0000555555ca332f in do_ld8_mmu (cpu=3Dcpu@entry=3D0x5555578e0cb0=
, addr=3Daddr@entry=3D19595790664, oi=3Doi@entry=3D52, ra=3Dra@entry=3D0, a=
ccess_type=3Daccess_type@entry=3DMMU_DATA_LOAD) at ../../accel/tcg/cputlb.c=
:2439
>> > #11 0x0000555555ca5e69 in cpu_ldq_mmu (ra=3D0, oi=3D52, addr=3D1959579=
0664, env=3D0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
>> > #12 cpu_ldq_le_mmuidx_ra (env=3D0x5555578e3470, addr=3D19595790664, mm=
u_idx=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/ldst_common.=
c.inc:301
>> > #13 0x0000555555b4b5de in ptw_ldq (in=3D0x7ffff4efcf10) at ../../targe=
t/i386/tcg/sysemu/excp_helper.c:98
>> > #14 ptw_ldq (in=3D0x7ffff4efcf10) at ../../target/i386/tcg/sysemu/excp=
_helper.c:93
>> > #15 mmu_translate (env=3Denv@entry=3D0x5555578e3470, in=3D0x7ffff4efcf=
d0, out=3D0x7ffff4efcfa0, err=3Derr@entry=3D0x7ffff4efcfb0) at ../../target=
/i386/tcg/sysemu/excp_helper.c:173
>> > #16 0x0000555555b4c3f3 in get_physical_address (err=3D0x7ffff4efcfb0, =
out=3D0x7ffff4efcfa0, mmu_idx=3D0, access_type=3DMMU_DATA_STORE, addr=3D183=
86491786698339392, env=3D0x5555578e3470) at ../../target/i386/tcg/sysemu/ex=
cp_helper.c:578
>> > #17 x86_cpu_tlb_fill (cs=3D0x5555578e0cb0, addr=3D18386491786698339392=
, size=3D<optimized out>, access_type=3DMMU_DATA_STORE, mmu_idx=3D0, probe=
=3D<optimized out>, retaddr=3D140736029817822) at ../../target/i386/tcg/sys=
emu/excp_helper.c:604
>> > #18 0x0000555555ca0df9 in tlb_fill (retaddr=3D140736029817822, mmu_idx=
=3D0, access_type=3DMMU_DATA_STORE, size=3D<optimized out>, addr=3D18386491=
786698339392, cpu=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1315
>> > #19 mmu_lookup1 (cpu=3Dcpu@entry=3D0x5555578e0cb0, data=3Ddata@entry=
=3D0x7ffff4efd120, mmu_idx=3D0, access_type=3Daccess_type@entry=3DMMU_DATA_=
STORE, ra=3Dra@entry=3D140736029817822) at ../../accel/tcg/cputlb.c:1713
>> > #20 0x0000555555ca2b71 in mmu_lookup (cpu=3D0x5555578e0cb0, addr=3D183=
86491786698339392, oi=3D<optimized out>, ra=3D140736029817822, type=3DMMU_D=
ATA_STORE, l=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1803
>> > #21 0x0000555555ca3e5d in do_st8_mmu (cpu=3D0x5555578e0cb0, addr=3D239=
37, val=3D18386491784638059520, oi=3D6, ra=3D140736029817822) at ../../acce=
l/tcg/cputlb.c:2853
>> > #22 0x00007fffa9107c63 in code_gen_buffer ()=20=20
>>=20
>> No thats different - we are actually writing to the MMIO region here.
>> But the fact we hit cpu_abort because we can't find the TB we are
>> executing is a little problematic.
>>=20
>> Does ra properly point to the code buffer here?
>
> Err.  How would I tell?

(gdb) p/x 140736029817822
$1 =3D 0x7fffa9107bde

seems off because code_gen_buffer starts at 0x00007fffa9107c63

>
> I'll confess I have almost no idea what is going on in TCG :(
>
> Can learn but it won't be quick.
>
> J
>
>>=20
>> > #23 0x0000555555c9395b in cpu_tb_exec (cpu=3Dcpu@entry=3D0x5555578e0cb=
0, itb=3Ditb@entry=3D0x7fffa9107980 <code_gen_buffer+17856851>, tb_exit=3Dt=
b_exit@entry=3D0x7ffff4efd718) at ../../accel/tcg/cpu-exec.c:442

At this point I'd run under rr and set a bp at cpu_tb_exec,
reverse-continue and then see how we ended up off-piste with a retaddr
that can't be resolved.

>> > #24 0x0000555555c93ec0 in cpu_loop_exec_tb (tb_exit=3D0x7ffff4efd718, =
last_tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffa9107980 <c=
ode_gen_buffer+17856851>, cpu=3D0x5555578e0cb0) at ../../accel/tcg/cpu-exec=
.c:897
>> > #25 cpu_exec_loop (cpu=3Dcpu@entry=3D0x5555578e0cb0, sc=3Dsc@entry=3D0=
x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1012
>> > #26 0x0000555555c946d1 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x5555578=
e0cb0, sc=3Dsc@entry=3D0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1029
>> > #27 0x0000555555c94ebc in cpu_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0) =
at ../../accel/tcg/cpu-exec.c:1055
>> > #28 0x0000555555cb8f53 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x5555578e0c=
b0) at ../../accel/tcg/tcg-accel-ops.c:76
>> > #29 0x0000555555cb90b0 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x555=
5578e0cb0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
>> > #30 0x0000555555e57180 in qemu_thread_start (args=3D0x555557956000) at=
 ../../util/qemu-thread-posix.c:541
>> > #31 0x00007ffff78176ba in start_thread (arg=3D<optimized out>) at ./np=
tl/pthread_create.c:444
>> > #32 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_=
64/clone3.S:81=20=20
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

