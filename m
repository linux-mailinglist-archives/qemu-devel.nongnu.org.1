Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1BE76C6BD
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6FH-0003vN-3C; Wed, 02 Aug 2023 03:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR6FF-0003vA-Hc
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:26:09 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR6FB-0000iM-9z
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:26:09 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6bc93523162so3439381a34.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690961163; x=1691565963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uozCy4BA9x9jYDtrym7LMvcKDtv1Xn+jUjnlmC9ABZk=;
 b=MtAT4+mUEY7Ptcyd58nkFJlgfBRoJ9/BbhsA7QzwxJTekzNTAtLsMTz+eaqACMVj/p
 C6tapiT4aNdiN3QCJLR4eSjN8soPlWk75bOmf9Y8Ehks5tm639+lqJxpOvg7TLpdvg/O
 4wK2jb/TT4RJ8zeseq3s946yeLbPF3xTGffAax3OTBEzzWpi5pSPqwVA8FAidnjYNWzn
 96dqwyPeEFNlCfG3Kvjy0jaYGivxF8nH8EkrDe/lYRhsraNDjDT6zGT2amuYs/zOK2Vz
 GUZRlMSTh9ZJAHw5um4rQq1wYQCSfhYUc7KPhvl5rnNtL2ngqJbQDgtOsI+lHOl6HE0Y
 SNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690961163; x=1691565963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uozCy4BA9x9jYDtrym7LMvcKDtv1Xn+jUjnlmC9ABZk=;
 b=T9aYp7nrq3Judhq32nPSTWV2HMn78pcr6rRK0ynbfrKWiapLS5+nZ4hGU7nLeHaeUH
 CkIqRntYA9a9BwIyex4TeIwrRu8hMJw/Q1zRL/x1zaQ5f+moG3Ob8JhZhpmGtYPYsDS+
 yBZxh4puARgNKVy0h798x1kiPjDKC5/OKSMl6jfPnNevDJeBJRA3Tfh7a80FZYUbqdst
 9ZPgfk2LiYKrLhZspMH4en9ij9LMlQUzW3Z5GKxZK7PJYXl/g08RMZ1BGT7+5M2fpUtm
 H4YcZPiuhfG1RlnlmRWqZWxn8g8z3w+8wc2wPd1lYkl7l9ZTLAqzlNcLL6papUhjwpTw
 6qig==
X-Gm-Message-State: ABy/qLZz2neYt0vDMIBsNeAO60CI3vYJ6CcSE38zZWVhDfDaIuJJVzz8
 3TE4ppA1KVC+U+Qj4IZR+6uyWg==
X-Google-Smtp-Source: APBJJlEXv66bHn8xCiMcWF39VbhdHWXGQvES8DcvPcRvhG0sRoaLLAy2cEIuXShIC/hXKHtNPWhoTw==
X-Received: by 2002:a05:6830:95:b0:6bc:b8d9:476e with SMTP id
 a21-20020a056830009500b006bcb8d9476emr2165509oto.16.1690961163597; 
 Wed, 02 Aug 2023 00:26:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a17090abf0800b0026814d83a5asm555648pjs.26.2023.08.02.00.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 00:26:03 -0700 (PDT)
Message-ID: <6fcd0176-ce2a-342c-1baf-ba2820c17627@daynix.com>
Date: Wed, 2 Aug 2023 16:26:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
 <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
 <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
 <57d9980d-b881-b16e-844a-e651d6d09de7@gmx.de>
 <c3ed33f0-998d-5386-1880-22436af149b7@gmx.de>
 <def4abbf-ec8a-7986-1831-d9c839acff8c@gmx.de>
 <CACPK8XfXMU=YyvkPTHFV6n_THkDPKfRmjYt_Ps7KJrxV9Srjbg@mail.gmail.com>
 <915e346e-fc91-5098-0f72-520f63a7e99a@gmx.de>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <915e346e-fc91-5098-0f72-520f63a7e99a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/01 19:43, Helge Deller wrote:
> On 8/1/23 06:49, Joel Stanley wrote:
>> On Mon, 31 Jul 2023 at 18:24, Helge Deller <deller@gmx.de> wrote:
>>> As suggested, I've based my patches on top of yours and the tree can be
>>> pulled from:
>>> git pull https://github.com/hdeller/qemu-hppa/   brk-fixes-akihiko-2
>>>
>>> My patches are neccessary to fix an arm-static testcase:
>>>          /usr/bin/qemu-arm-static ./fstype
>>>
>>> Let's try this patch series...
>>
>> The armhf static binary works with expected output.
> 
> Good!
> 
>> The arm static binary causes qemu to segfault:
> 
> I can't reproduce here.
> I tried it in an arm64 chroot which provided the cross-compiler and 
> worked for me:
> 
> (arm64-chroot)root@p100:/# uname -a
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 aarch64 GNU/Linux
> (arm64-chroot)root@p100:/# arm-linux-gnueabi-gcc-13 -o hello hello.c 
> -static
> (arm64-chroot)root@p100:/# file hello
> hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), 
> statically linked, 
> BuildID[sha1]=fa0f7cd6e1779fa8cd76c6e5d3123900ceefa952, for GNU/Linux 
> 3.2.0, not stripped
> (arm64-chroot)root@p100:/# ./hello
> Hello, World!
> 
> Maybe you can send me your binary (and the needed klibc*so)?

Binaries will certainly help. I also suggest adding -trace target_mmap 
so that we can see what's passed to target_mmap().

I also sent a new version so please rebase to it and try again.
https://patchew.org/QEMU/20230802071754.14876-1-akihiko.odaki@daynix.com/

Helge, please rebase your series to the series, include only your 
patches in your series, and add the following to the cover letter:

Based-on: <20230802071754.14876-1-akihiko.odaki@daynix.com>
("[PATCH v2 0/6] linux-user: brk/mmap fixes")

> Btw, I tested a whole bunch of platforms too, see below...
> 
> Helge
> 
>> $ gdb -quiet --args ./build/qemu-arm -d guest_errors,page,strace ~/hello
>> Reading symbols from ./build/qemu-arm...
>> (gdb) r
>> Starting program: build/qemu-arm -d guest_errors,page,strace
>> /home/joel/hello
>> Using host libthread_db library 
>> "/lib/powerpc64le-linux-gnu/libthread_db.so.1".
>> [New Thread 0x7ffff762ece0 (LWP 118359)]
>> host mmap_min_addr=0x10000
>> pgb_find_hole: base @ 140420000 for 4294967296 bytes
>> pgb_static: base @ 140420000 for 4294967295 bytes
>> pgb_reserved_va: base @ 0x140420000 for 4294967296 bytes
>> Locating guest address space @ 0x140420000
>> page layout changed following mmap
>> start    end      size     prot
>> 00010000-00090000 00080000 ---
>> 00090000-0009b000 0000b000 ---
>> ffff0000-00000000 00010000 r-x
>> page layout changed following mmap
>> start    end      size     prot
>> 00010000-00090000 00080000 r-x
>> 00090000-0009b000 0000b000 ---
>> ffff0000-00000000 00010000 r-x
>> page layout changed following mmap
>> start    end      size     prot
>> 00010000-00090000 00080000 r-x
>> 00090000-000a0000 00010000 rw-
>> ffff0000-00000000 00010000 r-x
>> page layout changed following mmap
>> start    end      size     prot
>> 00010000-00090000 00080000 r-x
>> 00090000-000a0000 00010000 rw-
>> e0000000-e0810000 00810000 rw-
>> ffff0000-00000000 00010000 r-x
>> page layout changed following mmap
>> start    end      size     prot
>> 00010000-00090000 00080000 r-x
>> 00090000-000a0000 00010000 rw-
>> e0000000-e0010000 00010000 ---
>> e0010000-e0811000 00801000 rw-
>> ffff0000-00000000 00010000 r-x
>> guest_base  0x140420000
>> page layout changed following binary load
>> start    end      size     prot
>> 00010000-00090000 00080000 r-x
>> 00090000-000a0000 00010000 rw-
>> e0000000-e0010000 00010000 ---
>> e0010000-e0810000 00800000 rw-
>> e0810000-e0811000 00001000 r-x
>> ffff0000-00000000 00010000 r-x
>> start_brk   0x00000000
>> end_code    0x00084f7c
>> start_code  0x00010000
>> start_data  0x00095098
>> end_data    0x00098394
>> start_stack 0xe080f410
>> brk         0x0009b000
>> entry       0x00010418
>> argv_start  0xe080f414
>> env_start   0xe080f41c
>> auxv_start  0xe080f4a0
>> 118357 brk(NULL) = 0x0009b000
>> 118357 brk(0x0009b8fc) = 0x0009b000
>>
>> Thread 1 "qemu-arm" received signal SIGSEGV, Segmentation fault.
>> 0x00007fffeed9bb74 in code_gen_buffer ()
>> (gdb)
>> (gdb) bt
>> #0  0x00007fffeed9bb74 in code_gen_buffer ()
>> #1  0x0000000100169e3c in cpu_tb_exec (cpu=cpu@entry=0x1003d4aa0,
>>      itb=itb@entry=0x7fffeed9ba60 <code_gen_buffer+47512>,
>> tb_exit=tb_exit@entry=0x7fffffffe50c)
>>      at ../accel/tcg/cpu-exec.c:457
>> #2  0x000000010016a564 in cpu_loop_exec_tb (tb_exit=0x7fffffffe50c,
>> last_tb=<synthetic pointer>,
>>      pc=<optimised out>, tb=0x7fffeed9ba60 <code_gen_buffer+47512>,
>> cpu=<optimised out>)
>>      at ../accel/tcg/cpu-exec.c:919
>> #3  cpu_exec_loop (cpu=cpu@entry=0x1003d4aa0, sc=<optimised out>) at
>> ../accel/tcg/cpu-exec.c:1040
>> #4  0x000000010016aa0c in cpu_exec_setjmp (cpu=cpu@entry=0x1003d4aa0,
>> sc=<optimised out>)
>>      at ../accel/tcg/cpu-exec.c:1057
>> #5  0x000000010016b0d0 in cpu_exec (cpu=0x1003d4aa0) at
>> ../accel/tcg/cpu-exec.c:1083
>> #6  0x000000010004d780 in cpu_loop (env=0x1003d4fb0) at
>> ../linux-user/arm/cpu_loop.c:323
>> #7  0x0000000100047534 in main (argc=<optimised out>,
>> argv=0x7ffffffff178, envp=<optimised out>)
>>      at ../linux-user/main.c:975
>>
>> I tested 74a22a175c4340a01f6f860f72307093e3307681.
> 
> Those I did tested sucessfully (static binary):
> 
> alpha-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 alpha GNU/Linux
> /hello: ELF 64-bit LSB executable, Alpha (unofficial), version 1 (SYSV), 
> statically linked, 
> BuildID[sha1]=5bf21139aa3937121e8843b062619de8e53d035a, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> arm64-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 aarch64 GNU/Linux
> /hello: ELF 64-bit LSB executable, ARM aarch64, version 1 (GNU/Linux), 
> statically linked, 
> BuildID[sha1]=201827af1ffdef4fc2afa404047c6d1a41e4825e, for GNU/Linux 
> 3.7.0, not stripped
> Hello, World!
> 
> armel-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 armv7l GNU/Linux
> /hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), 
> statically linked, 
> BuildID[sha1]=6e6a52f60037690052b2e54e750a56543ed9d7a0, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> armhf-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 armv7l GNU/Linux
> /hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (GNU/Linux), 
> statically linked, 
> BuildID[sha1]=842df9fd0bf910f6a00c19d61435387efa591390, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> hppa-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 parisc GNU/Linux
> /hello: ELF 32-bit MSB executable, PA-RISC, 1.1 version 1 (GNU/Linux), 
> statically linked, 
> BuildID[sha1]=03d4b299b31d30b5920e9fdcfccce071b77e4447, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> m68k-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 m68k GNU/Linux
> /hello: ELF 32-bit MSB executable, Motorola m68k, 68020, version 1 
> (SYSV), statically linked, 
> BuildID[sha1]=c01101b8ae6a6a0161a08b6ac24821b28daa5b73, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> mips64el-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 mips64 GNU/Linux
> /hello: ELF 64-bit LSB executable, MIPS, MIPS64 rel2 version 1 (SYSV), 
> statically linked, 
> BuildID[sha1]=0c50fc29be7ef781cdfb4ec4c47b4e350cab218b, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> mipsel-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 mips GNU/Linux
> /hello: ELF 32-bit LSB executable, MIPS, MIPS32 rel2 version 1 (SYSV), 
> statically linked, 
> BuildID[sha1]=e0db11bbc59070f5fefb4355d73df76791e96c29, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> powerpc-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 ppc GNU/Linux
> /hello: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 
> (SYSV), statically linked, 
> BuildID[sha1]=4fe85ef8ebd86eb383ccf4fd741ce224143da2b2, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> ppc64-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 ppc64 GNU/Linux
> /hello: ELF 64-bit MSB executable, 64-bit PowerPC or cisco 7500, Power 
> ELF V1 ABI, version 1 (GNU/Linux), statically linked, 
> BuildID[sha1]=c3bb5c4d94b2096f70261bf0ab1f3fc93813df8f, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> ppc64el-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 ppc64le GNU/Linux
> /hello: ELF 64-bit LSB executable, 64-bit PowerPC or cisco 7500, 
> OpenPOWER ELF V2 ABI, version 1 (GNU/Linux), statically linked, 
> BuildID[sha1]=645abb5dcd9075d826d539675258fa5f9c7bc777, for GNU/Linux 
> 3.10.0, not stripped
> Hello, World!
> 
> s390x-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 s390x GNU/Linux
> /hello: ELF 64-bit MSB executable, IBM S/390, version 1 (GNU/Linux), 
> statically linked, 
> BuildID[sha1]=f512d5ac759962ab66ae947d1308c8ceedef8fd3, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> sh4-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 sh4 GNU/Linux
> /hello: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), 
> statically linked, 
> BuildID[sha1]=4cf38c7f67b5d7dc7a93c6ab513aaf0d2d21c4fc, for GNU/Linux 
> 3.2.0, not stripped
> Hello, World!
> 
> sparc64-chroot:
> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 
> 20:51:12 UTC 2023 sparc64 GNU/Linux
> /hello: ELF 64-bit MSB executable, SPARC V9, Sun UltraSPARC1 Extensions 
> Required, relaxed memory ordering, version 1 (GNU/Linux), statically 
> linked, BuildID[sha1]=36f02b1b3acc94f61dff6dc26205f82314c899e0, for 
> GNU/Linux 3.2.0, not stripped
> Hello, World!

