Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC8845986
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 15:02:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXdC-0000Wm-4h; Thu, 01 Feb 2024 09:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVXcw-0000RH-QX
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:01:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVXct-0005KH-3T
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:01:13 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQgTY3Cs8z6K8tP;
 Thu,  1 Feb 2024 21:57:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9343E140CB9;
 Thu,  1 Feb 2024 22:01:01 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 14:01:01 +0000
Date: Thu, 1 Feb 2024 14:01:00 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: Sajjan Rao <sajjanr@gmail.com>, Gregory Price
 <gregory.price@memverge.com>, Dimitrios Palyvos
 <dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <20240201140100.000016ce@huawei.com>
In-Reply-To: <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com>
 <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 1 Feb 2024 13:12:23 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 1 Feb 2024 at 13:04, Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >  
> 
> 
> 
> 
> > root@localhost:~/devmem2# numactl --membind=1 touch a
> > qemu: fatal: cpu_io_recompile: could not find TB for pc=(nil)  
> 
> Can you run QEMU under gdb and give the backtrace when it stops
> on the abort() ? That will probably have a helpful clue. I
> suspect something is failing to pass a valid retaddr in
> when it calls a load/store function.
> 
> thanks
> -- PMM

[Switching to Thread 0x7ffff56ff6c0 (LWP 21916)]
__pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
44      ./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff77c43b6 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
#5  0x0000555555c0d4ce in cpu_abort
    (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: could not find TB for pc=%p")
    at ../../cpu-target.c:359
#6  0x0000555555c59435 in cpu_io_recompile (cpu=cpu@entry=0x555556fd9000, retaddr=retaddr@entry=0) at ../../accel/tcg/translate-all.c:611
#7  0x0000555555c5c956 in io_prepare
    (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, out_offset=<synthetic pointer>)
    at ../../accel/tcg/cputlb.c:1339
#8  do_ld_mmio_beN
    (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
#9  0x0000555555c5dfad in do_ld_8
    (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
#10 0x0000555555c6026f in do_ld8_mmu
    (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
#11 0x0000555555c629f9 in cpu_ldq_mmu (ra=0, oi=52, addr=19595792376, env=0x555556fdb7c0) at ../../accel/tcg/ldst_common.c.inc:169
#12 cpu_ldq_le_mmuidx_ra (env=0x555556fdb7c0, addr=19595792376, mmu_idx=<optimized out>, ra=ra@entry=0)
    at ../../accel/tcg/ldst_common.c.inc:301
#13 0x0000555555b18ede in ptw_ldq (in=0x7ffff56fdf00) at ../../target/i386/tcg/sysemu/excp_helper.c:98
#14 ptw_ldq (in=0x7ffff56fdf00) at ../../target/i386/tcg/sysemu/excp_helper.c:93
#15 mmu_translate (env=env@entry=0x555556fdb7c0, in=in@entry=0x7ffff56fdfa0, out=out@entry=0x7ffff56fdf70, err=err@entry=0x7ffff56fdf80)
    at ../../target/i386/tcg/sysemu/excp_helper.c:173
#16 0x0000555555b19c95 in get_physical_address
    (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, addr=18446744072116178925, env=0x555556fdb7c0)
    at ../../target/i386/tcg/sysemu/excp_helper.c:578
#17 x86_cpu_tlb_fill
    (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:604
#18 0x0000555555c5dd2b in probe_access_internal
    (cpu=<optimized out>, addr=18446744072116178925, fault_size=fault_size@entry=1, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=0, nonfault=nonfault@entry=false, phost=0x7ffff56fe0d0, pfull=0x7ffff56fe0c8, retaddr=0, check_mem_cbs=false)
    at ../../accel/tcg/cputlb.c:1432
#19 0x0000555555c61ff8 in get_page_addr_code_hostp (env=<optimized out>, addr=addr@entry=18446744072116178925, hostp=hostp@entry=0x0)
    at ../../accel/tcg/cputlb.c:1603
#20 0x0000555555c50a2b in get_page_addr_code (addr=18446744072116178925, env=<optimized out>)
    at /home/jic23/src/qemu/include/exec/exec-all.h:594
#21 tb_htable_lookup (cpu=<optimized out>, pc=pc@entry=18446744072116178925, cs_base=0, flags=415285936, cflags=4278353920)
    at ../../accel/tcg/cpu-exec.c:231
#22 0x0000555555c50c08 in tb_lookup
    (cpu=cpu@entry=0x555556fd9000, pc=pc@entry=18446744072116178925, cs_base=cs_base@entry=0, flags=<optimized out>, cflags=<optimized out>) at ../../accel/tcg/cpu-exec.c:267
#23 0x0000555555c51e23 in helper_lookup_tb_ptr (env=0x555556fdb7c0) at ../../accel/tcg/cpu-exec.c:423
#24 0x00007fffa9076ead in code_gen_buffer ()
#25 0x0000555555c50fab in cpu_tb_exec (cpu=cpu@entry=0x555556fd9000, itb=<optimized out>, tb_exit=tb_exit@entry=0x7ffff56fe708)
    at ../../accel/tcg/cpu-exec.c:458
#26 0x0000555555c51492 in cpu_loop_exec_tb
    (tb_exit=0x7ffff56fe708, last_tb=<synthetic pointer>, pc=18446744072116179169, tb=<optimized out>, cpu=0x555556fd9000)
    at ../../accel/tcg/cpu-exec.c:920
#27 cpu_exec_loop (cpu=cpu@entry=0x555556fd9000, sc=sc@entry=0x7ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1041
#28 0x0000555555c51d11 in cpu_exec_setjmp (cpu=cpu@entry=0x555556fd9000, sc=sc@entry=0x7ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1058
#29 0x0000555555c523b4 in cpu_exec (cpu=cpu@entry=0x555556fd9000) at ../../accel/tcg/cpu-exec.c:1084
#30 0x0000555555c74053 in tcg_cpus_exec (cpu=cpu@entry=0x555556fd9000) at ../../accel/tcg/tcg-accel-ops.c:76
#31 0x0000555555c741a0 in mttcg_cpu_thread_fn (arg=arg@entry=0x555556fd9000) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
#32 0x0000555555dfb580 in qemu_thread_start (args=0x55555703c3e0) at ../../util/qemu-thread-posix.c:541
#33 0x00007ffff78176ba in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:444
#34 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

