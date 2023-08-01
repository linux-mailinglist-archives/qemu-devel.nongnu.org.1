Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36976B21C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 12:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQmrD-00046o-UJ; Tue, 01 Aug 2023 06:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQmrA-00046e-Ir
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 06:44:00 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQmr8-00064b-4I
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 06:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690886633; x=1691491433; i=deller@gmx.de;
 bh=7gHNAqSjXsOHXE+ksPVZKcVZaySbuEMvcdQar3kWjGE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UzM3HDMrbS4dadIJdnzqYUaOXUmbEhUM8kma+cKMKdr6bv6yFKZ0Uz8brxSyHHrUEJL+r3e
 utd8RVmnDte9scHi8bgCKZHJy1gXrXhQRUqm46LxH5YyA+aNjLy0sPa2ylHRmiLr768+lOEzO
 mW4GQr1Oq0UUGES5odwPcPpT0XKgEkkv1W93PK/yQwykGKTu+Tom72ZTwx54rYMXi1cxq9riS
 1rXstTxJmffFYJ0OgRwqMjiORYjqqwZ0kUZyOo9i0Lq8vPiiqjfHudAflY3I50JadImoyPXSk
 sMD14YIxwf490AqzDaNU2C089iTjZ+n/aqjp9eV1f+DGdIoHe5Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1qGWDy0utv-00TRks; Tue, 01
 Aug 2023 12:43:53 +0200
Message-ID: <915e346e-fc91-5098-0f72-520f63a7e99a@gmx.de>
Date: Tue, 1 Aug 2023 12:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev
 <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
 <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
 <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
 <57d9980d-b881-b16e-844a-e651d6d09de7@gmx.de>
 <c3ed33f0-998d-5386-1880-22436af149b7@gmx.de>
 <def4abbf-ec8a-7986-1831-d9c839acff8c@gmx.de>
 <CACPK8XfXMU=YyvkPTHFV6n_THkDPKfRmjYt_Ps7KJrxV9Srjbg@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <CACPK8XfXMU=YyvkPTHFV6n_THkDPKfRmjYt_Ps7KJrxV9Srjbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X8yNUYAP+XRxJTNNZLsTGFsTqdGuY+qOQRNqwJN3K9tuyCb93I2
 82SGbPYaquNLlbEzKqvlc4xpWzLkfmgU9nrwfvrnMM9NrQKsyCsyJPf83PXEPP+CRh0qiaT
 CMm++X6DStYpoFUztHIgo+HBVXUJUp66ldwZQXKUXJKlHMeMLoQHvCnSZNZh4Accn6ovXol
 poLAXdnJ36ffLvHFfGkNw==
UI-OutboundReport: notjunk:1;M01:P0:dZS7vGbQuZw=;gAhrCDYPKnTWofvAYvNcrIWCwm0
 sPD+a/XXTVl3+Pswu5sNzTykgx6jK1hSt+L5giBuXx8f+OjuBm6/iEmjyqXLrfwJC1bbXY1gh
 viXUyczSIR5+Wivk3upVXTE6fYWf20/1HKXki/bL6aHstmM8cB4rpSQuc85pjQj6wzS8FgLHc
 by88cC3fDm2JSR+q14R752Ohbv1wdkHGHt7q5Z5uLrKxWhmXUstfNVdaBhXgHHQIr7T7gxZZ2
 WvJ0QDKi6kPqBRl2Ti6DuL6PSy9hPabgQhyiepYRKU37gKm76ZWVaAglRtEykFqz2BQU545rK
 Z9ePzhphQKBWeCMZ8Bw5fBv1Qy9FGSINOwcIQabbSKVWzobtMPVI/M2cW2nb+PfgfyNFGppmh
 WZLqFh+AQwXAhQfM4/QSanYt0T4KXhhNxU0SrZ/NQtwYEFi3Cp6e/GHEGU25TJSvXe+4L0Kjr
 /lhGIgAhrCFAlbHa9MT2j6D2PHJKcFLaTVA2rLSnwQhuB+6ahZdp2T4Owqs1BOGQfvmWKBs1T
 RPjDGdx9z4CcbmyJUZYIN3yUfKjWNO5AYggvUSoz7ChOJpEw2Ej/BWyCp0eO6c3HWGyL2Ezp9
 Wg1mS9wj1oNmfJ+xm9Sxcy0NUO+zuwT0Ea7wwAG/Sgsdzb53lQUiFR1jsKGjpPJmHwLEh7OZq
 WYfXWRD8e1EwrmdWFeb4cI8D/YBvzfcVh1SKX+AB3ul3LphRVBvnAdCqEIxRXcAq2AALahTzx
 ryB9GUlCK27bzNjtEzaFGblPyCFcXq7fj+2ZD0LNjxKFPHrLSBnSQcld3ygyNhJGp9wvRckBn
 MsT6UCH0w9inZomGuMRcN/MOd4b4q8w+uFRq8v9zCiHsELuPWBrKlszaSatD58TDe7+G2jpc/
 OIThw6/f8wpEgA63pKdt9EhGL/6y5U1ZJ1uGQGMS8uAAE0/PxenT+/pYboS5lSKGrJXzdIxDx
 v0luAUJJKzXJ9hwZVXrSbOTV6ZA=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/1/23 06:49, Joel Stanley wrote:
> On Mon, 31 Jul 2023 at 18:24, Helge Deller <deller@gmx.de> wrote:
>> As suggested, I've based my patches on top of yours and the tree can be
>> pulled from:
>> git pull https://github.com/hdeller/qemu-hppa/   brk-fixes-akihiko-2
>>
>> My patches are neccessary to fix an arm-static testcase:
>>          /usr/bin/qemu-arm-static ./fstype
>>
>> Let's try this patch series...
>
> The armhf static binary works with expected output.

Good!

> The arm static binary causes qemu to segfault:

I can't reproduce here.
I tried it in an arm64 chroot which provided the cross-compiler and worked=
 for me:

(arm64-chroot)root@p100:/# uname -a
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 aarch64 GNU/Linux
(arm64-chroot)root@p100:/# arm-linux-gnueabi-gcc-13 -o hello hello.c -stat=
ic
(arm64-chroot)root@p100:/# file hello
hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically =
linked, BuildID[sha1]=3Dfa0f7cd6e1779fa8cd76c6e5d3123900ceefa952, for GNU/=
Linux 3.2.0, not stripped
(arm64-chroot)root@p100:/# ./hello
Hello, World!

Maybe you can send me your binary (and the needed klibc*so)?
Btw, I tested a whole bunch of platforms too, see below...

Helge

> $ gdb -quiet --args ./build/qemu-arm -d guest_errors,page,strace ~/hello
> Reading symbols from ./build/qemu-arm...
> (gdb) r
> Starting program: build/qemu-arm -d guest_errors,page,strace
> /home/joel/hello
> Using host libthread_db library "/lib/powerpc64le-linux-gnu/libthread_db=
.so.1".
> [New Thread 0x7ffff762ece0 (LWP 118359)]
> host mmap_min_addr=3D0x10000
> pgb_find_hole: base @ 140420000 for 4294967296 bytes
> pgb_static: base @ 140420000 for 4294967295 bytes
> pgb_reserved_va: base @ 0x140420000 for 4294967296 bytes
> Locating guest address space @ 0x140420000
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 ---
> 00090000-0009b000 0000b000 ---
> ffff0000-00000000 00010000 r-x
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-0009b000 0000b000 ---
> ffff0000-00000000 00010000 r-x
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-000a0000 00010000 rw-
> ffff0000-00000000 00010000 r-x
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-000a0000 00010000 rw-
> e0000000-e0810000 00810000 rw-
> ffff0000-00000000 00010000 r-x
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-000a0000 00010000 rw-
> e0000000-e0010000 00010000 ---
> e0010000-e0811000 00801000 rw-
> ffff0000-00000000 00010000 r-x
> guest_base  0x140420000
> page layout changed following binary load
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-000a0000 00010000 rw-
> e0000000-e0010000 00010000 ---
> e0010000-e0810000 00800000 rw-
> e0810000-e0811000 00001000 r-x
> ffff0000-00000000 00010000 r-x
> start_brk   0x00000000
> end_code    0x00084f7c
> start_code  0x00010000
> start_data  0x00095098
> end_data    0x00098394
> start_stack 0xe080f410
> brk         0x0009b000
> entry       0x00010418
> argv_start  0xe080f414
> env_start   0xe080f41c
> auxv_start  0xe080f4a0
> 118357 brk(NULL) =3D 0x0009b000
> 118357 brk(0x0009b8fc) =3D 0x0009b000
>
> Thread 1 "qemu-arm" received signal SIGSEGV, Segmentation fault.
> 0x00007fffeed9bb74 in code_gen_buffer ()
> (gdb)
> (gdb) bt
> #0  0x00007fffeed9bb74 in code_gen_buffer ()
> #1  0x0000000100169e3c in cpu_tb_exec (cpu=3Dcpu@entry=3D0x1003d4aa0,
>      itb=3Ditb@entry=3D0x7fffeed9ba60 <code_gen_buffer+47512>,
> tb_exit=3Dtb_exit@entry=3D0x7fffffffe50c)
>      at ../accel/tcg/cpu-exec.c:457
> #2  0x000000010016a564 in cpu_loop_exec_tb (tb_exit=3D0x7fffffffe50c,
> last_tb=3D<synthetic pointer>,
>      pc=3D<optimised out>, tb=3D0x7fffeed9ba60 <code_gen_buffer+47512>,
> cpu=3D<optimised out>)
>      at ../accel/tcg/cpu-exec.c:919
> #3  cpu_exec_loop (cpu=3Dcpu@entry=3D0x1003d4aa0, sc=3D<optimised out>) =
at
> ../accel/tcg/cpu-exec.c:1040
> #4  0x000000010016aa0c in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x1003d4aa0=
,
> sc=3D<optimised out>)
>      at ../accel/tcg/cpu-exec.c:1057
> #5  0x000000010016b0d0 in cpu_exec (cpu=3D0x1003d4aa0) at
> ../accel/tcg/cpu-exec.c:1083
> #6  0x000000010004d780 in cpu_loop (env=3D0x1003d4fb0) at
> ../linux-user/arm/cpu_loop.c:323
> #7  0x0000000100047534 in main (argc=3D<optimised out>,
> argv=3D0x7ffffffff178, envp=3D<optimised out>)
>      at ../linux-user/main.c:975
>
> I tested 74a22a175c4340a01f6f860f72307093e3307681.

Those I did tested sucessfully (static binary):

alpha-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 alpha GNU/Linux
/hello: ELF 64-bit LSB executable, Alpha (unofficial), version 1 (SYSV), s=
tatically linked, BuildID[sha1]=3D5bf21139aa3937121e8843b062619de8e53d035a=
, for GNU/Linux 3.2.0, not stripped
Hello, World!

arm64-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 aarch64 GNU/Linux
/hello: ELF 64-bit LSB executable, ARM aarch64, version 1 (GNU/Linux), sta=
tically linked, BuildID[sha1]=3D201827af1ffdef4fc2afa404047c6d1a41e4825e, =
for GNU/Linux 3.7.0, not stripped
Hello, World!

armel-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 armv7l GNU/Linux
/hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically=
 linked, BuildID[sha1]=3D6e6a52f60037690052b2e54e750a56543ed9d7a0, for GNU=
/Linux 3.2.0, not stripped
Hello, World!

armhf-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 armv7l GNU/Linux
/hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (GNU/Linux), stati=
cally linked, BuildID[sha1]=3D842df9fd0bf910f6a00c19d61435387efa591390, fo=
r GNU/Linux 3.2.0, not stripped
Hello, World!

hppa-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 parisc GNU/Linux
/hello: ELF 32-bit MSB executable, PA-RISC, 1.1 version 1 (GNU/Linux), sta=
tically linked, BuildID[sha1]=3D03d4b299b31d30b5920e9fdcfccce071b77e4447, =
for GNU/Linux 3.2.0, not stripped
Hello, World!

m68k-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 m68k GNU/Linux
/hello: ELF 32-bit MSB executable, Motorola m68k, 68020, version 1 (SYSV),=
 statically linked, BuildID[sha1]=3Dc01101b8ae6a6a0161a08b6ac24821b28daa5b=
73, for GNU/Linux 3.2.0, not stripped
Hello, World!

mips64el-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 mips64 GNU/Linux
/hello: ELF 64-bit LSB executable, MIPS, MIPS64 rel2 version 1 (SYSV), sta=
tically linked, BuildID[sha1]=3D0c50fc29be7ef781cdfb4ec4c47b4e350cab218b, =
for GNU/Linux 3.2.0, not stripped
Hello, World!

mipsel-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 mips GNU/Linux
/hello: ELF 32-bit LSB executable, MIPS, MIPS32 rel2 version 1 (SYSV), sta=
tically linked, BuildID[sha1]=3De0db11bbc59070f5fefb4355d73df76791e96c29, =
for GNU/Linux 3.2.0, not stripped
Hello, World!

powerpc-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 ppc GNU/Linux
/hello: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV)=
, statically linked, BuildID[sha1]=3D4fe85ef8ebd86eb383ccf4fd741ce224143da=
2b2, for GNU/Linux 3.2.0, not stripped
Hello, World!

ppc64-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 ppc64 GNU/Linux
/hello: ELF 64-bit MSB executable, 64-bit PowerPC or cisco 7500, Power ELF=
 V1 ABI, version 1 (GNU/Linux), statically linked, BuildID[sha1]=3Dc3bb5c4=
d94b2096f70261bf0ab1f3fc93813df8f, for GNU/Linux 3.2.0, not stripped
Hello, World!

ppc64el-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 ppc64le GNU/Linux
/hello: ELF 64-bit LSB executable, 64-bit PowerPC or cisco 7500, OpenPOWER=
 ELF V2 ABI, version 1 (GNU/Linux), statically linked, BuildID[sha1]=3D645=
abb5dcd9075d826d539675258fa5f9c7bc777, for GNU/Linux 3.10.0, not stripped
Hello, World!

s390x-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 s390x GNU/Linux
/hello: ELF 64-bit MSB executable, IBM S/390, version 1 (GNU/Linux), stati=
cally linked, BuildID[sha1]=3Df512d5ac759962ab66ae947d1308c8ceedef8fd3, fo=
r GNU/Linux 3.2.0, not stripped
Hello, World!

sh4-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 sh4 GNU/Linux
/hello: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), staticall=
y linked, BuildID[sha1]=3D4cf38c7f67b5d7dc7a93c6ab513aaf0d2d21c4fc, for GN=
U/Linux 3.2.0, not stripped
Hello, World!

sparc64-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 sparc64 GNU/Linux
/hello: ELF 64-bit MSB executable, SPARC V9, Sun UltraSPARC1 Extensions Re=
quired, relaxed memory ordering, version 1 (GNU/Linux), statically linked,=
 BuildID[sha1]=3D36f02b1b3acc94f61dff6dc26205f82314c899e0, for GNU/Linux 3=
.2.0, not stripped
Hello, World!

