Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A776E9A3
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRY6t-0006Jm-5f; Thu, 03 Aug 2023 09:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qRY6q-0006HD-Jf
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:11:20 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qRY6n-00042l-Jv
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:11:20 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bcf2de59cso139697666b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1691068275; x=1691673075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nK4dfKfaywENGdK5gnMYSjtn30imYcDI3Jq/GgropbM=;
 b=WWvFkeI+mof5NQlG2MSuWOT7qu9iXxEycDIIYh+H30PAsTt0AZ05aawI08o882tpro
 MJImNQjsw5eir8q53JGFpvv/fx9RGU6+TFGiCglGPf1Bq7xMn4TIb8IrW6pBIS06Ih1C
 BAOAaEaKq9sT95VAJBmRMAuaMAoKmfrMc7EIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691068275; x=1691673075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nK4dfKfaywENGdK5gnMYSjtn30imYcDI3Jq/GgropbM=;
 b=YElyWVX0MrMLJpHmCbdtXWgTwr8YGeXv8jiypcufierDGL80rHN+5i60Q+tikYo6jQ
 /jDi9nODZHEislVWRgmu+MXUU9udEyEI+654GOh8EW8tAV8bidb4fx+d0v8BhBTYrrYP
 MH7rjQyFmRznEXoli88kKZ+s4IVLWZ9IcqUM7mbU7a129nGZ6NPo08DJ4pgVex7w9RvD
 NZW2pORApCb+9nPpoPBWy08c/3g78T42m6II8ETyT+vzdkiRmfJ6KYgyGIx+4A7LjJvF
 IEdXz9tkqYi5TbISP6hG17TlVAaYeyfcK38NNwAYtSsNrA04QXVylzyuhwYeNacxp9K8
 qW/w==
X-Gm-Message-State: ABy/qLaWRf25/qEZrzjGj421P9t6yJm0XG8MSawiaaY95en2i8ph2hlu
 DO6y6lRLHM8IYrdJEu2bl1rbcNrgZCz2KfcxQeY=
X-Google-Smtp-Source: APBJJlFb2Ot7vmdkdpAC6MPpuRfGku06sqLRR4MPgUnbgs1Xgw09EkD64+i4vVIK+go5GdqTgYc89659n9FOGiT0j14=
X-Received: by 2002:a17:907:7853:b0:99b:4378:a5ab with SMTP id
 lb19-20020a170907785300b0099b4378a5abmr6965519ejc.74.1691068275342; Thu, 03
 Aug 2023 06:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230803015302.407219-1-richard.henderson@linaro.org>
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 3 Aug 2023 13:11:03 +0000
Message-ID: <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] linux-user: brk fixes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, laurent@vivier.eu, 
 akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

Hi Richard,

On Thu, 3 Aug 2023 at 01:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Builds on Helge's v6, incorporating my feedback plus
> some other minor cleanup.

This succeeds for the armhf static binary on ppc64le host that was
previously segfaulting.

However, the arm static binary on ppc64le host now segfaults:

$ gdb -q -ex r --args ./build/qemu-arm -d guest_errors,page,strace ~/hello
Reading symbols from ./build/qemu-arm...
Starting program: /scratch/joel/qemu/build/qemu-arm -d
guest_errors,page,strace /home/joel/hello
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/powerpc64le-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff762ece0 (LWP 143553)]
host mmap_min_addr=0x10000
pgb_find_hole: base @ 140420000 for 4294967296 bytes
pgb_static: base @ 140420000 for 4294967295 bytes
pgb_reserved_va: base @ 0x140420000 for 4294967296 bytes
Locating guest address space @ 0x140420000
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 ---
00090000-0009b000 0000b000 ---
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-0009b000 0000b000 ---
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
40000000-40810000 00810000 rw-
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
40000000-40010000 00010000 ---
40010000-40811000 00801000 rw-
ffff0000-00000000 00010000 r-x
guest_base  0x140420000
page layout changed following binary load
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
40000000-40010000 00010000 ---
40010000-40810000 00800000 rw-
40810000-40811000 00001000 r-x
ffff0000-00000000 00010000 r-x
end_code    0x00084f7c
start_code  0x00010000
start_data  0x00095098
end_data    0x00098394
start_stack 0x4080f410
brk         0x0009b000
entry       0x00010418
argv_start  0x4080f414
env_start   0x4080f41c
auxv_start  0x4080f4a0
143551 brk(NULL) = 0x0009b000
143551 brk(0x0009b8fc) = 0x0009b000

Thread 1 "qemu-arm" received signal SIGSEGV, Segmentation fault.
0x00007fffeed9bb74 in code_gen_buffer ()
(gdb) bt
#0  0x00007fffeed9bb74 in code_gen_buffer ()
#1  0x0000000100169fdc in cpu_tb_exec (cpu=cpu@entry=0x1003d4a90,
    itb=itb@entry=0x7fffeed9ba60 <code_gen_buffer+47512>,
tb_exit=tb_exit@entry=0x7fffffffe51c)
    at ../accel/tcg/cpu-exec.c:457
#2  0x000000010016a704 in cpu_loop_exec_tb (tb_exit=0x7fffffffe51c,
last_tb=<synthetic pointer>,
    pc=<optimised out>, tb=0x7fffeed9ba60 <code_gen_buffer+47512>,
cpu=<optimised out>)
    at ../accel/tcg/cpu-exec.c:919
#3  cpu_exec_loop (cpu=cpu@entry=0x1003d4a90, sc=<optimised out>) at
../accel/tcg/cpu-exec.c:1040
#4  0x000000010016abac in cpu_exec_setjmp (cpu=cpu@entry=0x1003d4a90,
sc=<optimised out>)
    at ../accel/tcg/cpu-exec.c:1057
#5  0x000000010016b270 in cpu_exec (cpu=0x1003d4a90) at
../accel/tcg/cpu-exec.c:1083
#6  0x000000010004d7b0 in cpu_loop (env=0x1003d4fa0) at
../linux-user/arm/cpu_loop.c:328
#7  0x0000000100047548 in main (argc=<optimised out>,
argv=0x7ffffffff188, envp=<optimised out>)
    at ../linux-user/main.c:1012
(gdb)


>
>
> r~
>
>
> Akihiko Odaki (6):
>   linux-user: Unset MAP_FIXED_NOREPLACE for host
>   linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
>   linux-user: Do not call get_errno() in do_brk()
>   linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
>   linux-user: Do nothing if too small brk is specified
>   linux-user: Do not align brk with host page size
>
> Helge Deller (1):
>   linux-user: Adjust initial brk when interpreter is close to executable
>
> Richard Henderson (7):
>   linux-user: Remove last_brk
>   bsd-user: Remove last_brk
>   linux-user: Adjust task_unmapped_base for reserved_va
>   linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
>   linux-user: Add ELF_ET_DYN_BASE
>   linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
>   linux-user: Properly set image_info.brk in flatload
>
>  bsd-user/qemu.h                      |  1 -
>  linux-user/aarch64/target_mman.h     | 13 ++++
>  linux-user/alpha/target_mman.h       | 11 ++++
>  linux-user/arm/target_mman.h         | 11 ++++
>  linux-user/cris/target_mman.h        | 12 ++++
>  linux-user/hexagon/target_mman.h     | 13 ++++
>  linux-user/hppa/target_mman.h        |  6 ++
>  linux-user/i386/target_mman.h        | 16 +++++
>  linux-user/loongarch64/target_mman.h | 11 ++++
>  linux-user/m68k/target_mman.h        |  5 ++
>  linux-user/microblaze/target_mman.h  | 11 ++++
>  linux-user/mips/target_mman.h        | 10 +++
>  linux-user/nios2/target_mman.h       | 10 +++
>  linux-user/openrisc/target_mman.h    | 10 +++
>  linux-user/ppc/target_mman.h         | 20 ++++++
>  linux-user/qemu.h                    |  2 -
>  linux-user/riscv/target_mman.h       | 10 +++
>  linux-user/s390x/target_mman.h       | 20 ++++++
>  linux-user/sh4/target_mman.h         |  7 +++
>  linux-user/sparc/target_mman.h       | 25 ++++++++
>  linux-user/user-mmap.h               |  6 +-
>  linux-user/x86_64/target_mman.h      | 15 +++++
>  linux-user/xtensa/target_mman.h      | 10 +++
>  bsd-user/mmap.c                      |  2 -
>  linux-user/elfload.c                 | 94 ++++++++++++++++------------
>  linux-user/flatload.c                |  2 +-
>  linux-user/main.c                    | 43 ++++++++++++-
>  linux-user/mmap.c                    | 68 ++++++++++++--------
>  linux-user/syscall.c                 | 69 +++++---------------
>  29 files changed, 401 insertions(+), 132 deletions(-)
>
> --
> 2.34.1
>

