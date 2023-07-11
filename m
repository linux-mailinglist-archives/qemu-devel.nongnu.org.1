Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E71A74EB75
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 12:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJAFN-00073r-J8; Tue, 11 Jul 2023 06:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJAFM-00072n-3R
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 06:05:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJAFJ-0000wC-VY
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 06:05:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso6272005f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689069924; x=1691661924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3qufLgGJDOLwPzUajrdsAX4m2c29oj8UaCgQu5JJxwE=;
 b=dcHfdeU9tTmbeA65+QHz05cIaw/ydbtApLeNJGmW6KKRVqbRF+Pjvu0ggeh+lhjjPh
 7GnEA/I4/LmE2pq2lwuaCDMNXM4MUJDkY/H/B6IXTYUenXNoTPwYGsgrlsK5TGRJHODN
 IdygeOBJ8K7wjBYrJipQan7r7LN2FDPBxWdHJBs9yeaJusiyzYeGwaE0NNZ6p1bH2Pgd
 Tt2YObgW0inazP+XvyxNNZ7WgFM8XWe9dl1IBoLVaS7BLywZvYpCghWmMbrd3q6vWc6D
 FHsNQQONMea9y9y8fzhTr8UEi2ffJ35C84CViM6f+WoIM5OfxLxdg2RT3+9yXm4QWxI2
 rWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689069924; x=1691661924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3qufLgGJDOLwPzUajrdsAX4m2c29oj8UaCgQu5JJxwE=;
 b=AIMbVq1XfLsIVlLoUIbVNnN5dAX1YDxOIcGj4ShnXI6XD7IfK/KnD3tW07T1pPqeDq
 mH7w5tWPsDct+3YeY87vC3p22op5F26csMBWXCU7EfreSQ2WsrIWUDzsVo4YLpKDZz1Y
 cXgOD0hq1hPlsLPw6aTV7mIbzDstbusFFBXvWYvn1/q9UCCHA47QyQlik5TzGsicxP+A
 eHfB7tEKcnhXjywELtCsIAoYR391nEdal6qp+K+VLCkXu5yK34D/7TYQZ+ssRoAnJ2gP
 QkdclLh2IqbAedWFPeD7IJqdlAIhy3HiJS1UI4SMtXibnQV4iGStGsKkbbKdwKfknB+5
 HE2A==
X-Gm-Message-State: ABy/qLYN8flb5HyxjckE/eM7Lnn3etjhzIxKCyMOOGi9pECpoFonZEM4
 lHqhCgofuBpour+K4i0+8CDHwA==
X-Google-Smtp-Source: APBJJlGS0hExR6kVcvVoFxtsp7iCVlqW/vYaBTnllq+Fm/UgvYnHCwlhT4daVLPRKr0qhxjZegZxRA==
X-Received: by 2002:a05:6000:905:b0:314:3b9c:f02f with SMTP id
 cw5-20020a056000090500b003143b9cf02fmr15707709wrb.49.1689069923984; 
 Tue, 11 Jul 2023 03:05:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a5d558a000000b0030fb828511csm1792895wrv.100.2023.07.11.03.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 03:05:23 -0700 (PDT)
Message-ID: <3d25f58e-e926-2eeb-470c-5c816771577f@linaro.org>
Date: Tue, 11 Jul 2023 12:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [hotfix PATCH-for-8.1 v2] meson: Fix cross-building for RISCV host
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230711092532.53929-1-philmd@linaro.org>
 <CAFEAcA9f0_dYHR9AbPdZxnk3Fk5Pqcwvv94PvLXOUTxSC8p=4g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9f0_dYHR9AbPdZxnk3Fk5Pqcwvv94PvLXOUTxSC8p=4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 11/7/23 11:35, Peter Maydell wrote:
> On Tue, 11 Jul 2023 at 10:26, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> While when building on native Linux the host architecture
>> is reported as "riscv32" or "riscv64", when cross-compiling
>> it is detected as "riscv". Meson handles the cross-detection
>> but displays a warning:
>>
>>    WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new
> 
> So where does the "riscv" string come from? It seems odd,
> because don't we need to specify whether it's 32 or
> 64 bit ?
> 
> (https://github.com/mesonbuild/meson/issues/5950
> got closed as "not a bug in meson, you should be using
> riscv32 or riscv64 instead".)

The meson-log.txt isn't very helpful:

======

Build started at 2023-07-11T08:42:37.510716
Main binary: 
/home/philippe.mathieu-daude/qemu/build/docker_debian-riscv64-cross/pyvenv/bin/python3
Build Options: -Dwerror=true -Ddocs=disabled -Dprefix=/usr/local 
--cross-file=config-meson.cross
Python system: Linux
The Meson build system
Version: 1.1.1
Source dir: /home/philippe.mathieu-daude/qemu
Build dir: 
/home/philippe.mathieu-daude/qemu/build/docker_debian-riscv64-cross
Build type: cross build
Project name: qemu
Project version: 8.0.50
-----
Detecting compiler via: riscv64-linux-gnu-gcc --version
compiler returned <Popen: returncode: 0 args: ['riscv64-linux-gnu-gcc', 
'--version']>
compiler stdout:
riscv64-linux-gnu-gcc (Debian 12.3.0-4) 12.3.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


compiler stderr:

Running command: riscv64-linux-gnu-gcc -E -dM -
-----
Detecting linker via: riscv64-linux-gnu-gcc -Wl,--version
linker returned <Popen: returncode: 0 args: ['riscv64-linux-gnu-gcc', 
'-Wl,--version']>
linker stdout:
GNU ld (GNU Binutils for Debian) 2.40.90.20230705
Copyright (C) 2023 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later 
version.
This program has absolutely no warranty.

linker stderr:
collect2 version 12.3.0
/usr/lib/gcc-cross/riscv64-linux-gnu/12/../../../../riscv64-linux-gnu/bin/ld 
-plugin /usr/lib/gcc-cross/riscv64-linux-gnu/12/liblto_plugin.so 
-plugin-opt=/usr/lib/gcc-cross/riscv64-linux-gnu/12/lto-wrapper 
-plugin-opt=-fresolution=/tmp/ccbttPz7.res 
-plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s 
-plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc 
-plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id --eh-frame-hdr 
-hash-style=gnu --as-needed -melf64lriscv -dynamic-linker 
/lib/ld-linux-riscv64-lp64d.so.1 -pie 
/usr/lib/gcc-cross/riscv64-linux-gnu/12/../../../../riscv64-linux-gnu/lib/Scrt1.o 
/usr/lib/gcc-cross/riscv64-linux-gnu/12/crti.o 
/usr/lib/gcc-cross/riscv64-linux-gnu/12/crtbeginS.o 
-L/usr/lib/gcc-cross/riscv64-linux-gnu/12 
-L/usr/lib/gcc-cross/riscv64-linux-gnu/12/../../../../riscv64-linux-gnu/lib 
-L/lib/riscv64-linux-gnu -L/usr/lib/riscv64-linux-gnu --version -lgcc 
--push-state --as-needed -lgcc_s --pop-state -lc -lgcc --push-state 
--as-needed -lgcc_s --pop-state 
/usr/lib/gcc-cross/riscv64-linux-gnu/12/crtendS.o 
/usr/lib/gcc-cross/riscv64-linux-gnu/12/crtn.o

Sanity testing C compiler: riscv64-linux-gnu-gcc
Is cross compiler: True.
Sanity check compiler command line: riscv64-linux-gnu-gcc sanitycheckc.c 
-o sanitycheckc_cross.exe -D_FILE_OFFSET_BITS=64 -c
Sanity check compile stdout:

-----
Sanity check compile stderr:

-----
C compiler for the host machine: riscv64-linux-gnu-gcc (gcc 12.3.0 
"riscv64-linux-gnu-gcc (Debian 12.3.0-4) 12.3.0")
C linker for the host machine: riscv64-linux-gnu-gcc ld.bfd 2.40.90.20230705
-----
Detecting compiler via: cc --version
compiler returned <Popen: returncode: 0 args: ['cc', '--version']>
compiler stdout:
cc (Debian 12.3.0-5) 12.3.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


compiler stderr:

Running command: cc -E -dM -
-----
Detecting linker via: cc -Wl,--version
linker returned <Popen: returncode: 0 args: ['cc', '-Wl,--version']>
linker stdout:
GNU ld (GNU Binutils for Debian) 2.40.90.20230705
Copyright (C) 2023 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later 
version.
This program has absolutely no warranty.

linker stderr:
collect2 version 12.3.0
/usr/bin/ld -plugin /usr/lib/gcc/x86_64-linux-gnu/12/liblto_plugin.so 
-plugin-opt=/usr/lib/gcc/x86_64-linux-gnu/12/lto-wrapper 
-plugin-opt=-fresolution=/tmp/ccfGNRcN.res 
-plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s 
-plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc 
-plugin-opt=-pass-through=-lgcc_s --build-id --eh-frame-hdr -m 
elf_x86_64 --hash-style=gnu --as-needed -dynamic-linker 
/lib64/ld-linux-x86-64.so.2 -pie 
/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/Scrt1.o 
/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/crti.o 
/usr/lib/gcc/x86_64-linux-gnu/12/crtbeginS.o 
-L/usr/lib/gcc/x86_64-linux-gnu/12 
-L/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu 
-L/usr/lib/gcc/x86_64-linux-gnu/12/../../../../lib 
-L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu 
-L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/12/../../.. --version 
-lgcc --push-state --as-needed -lgcc_s --pop-state -lc -lgcc 
--push-state --as-needed -lgcc_s --pop-state 
/usr/lib/gcc/x86_64-linux-gnu/12/crtendS.o 
/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/crtn.o

Sanity testing C compiler: ccache cc
Is cross compiler: False.
Sanity check compiler command line: ccache cc sanitycheckc.c -o 
sanitycheckc.exe -D_FILE_OFFSET_BITS=64
Sanity check compile stdout:

-----
Sanity check compile stderr:

-----
Running test binary command: 
/home/philippe.mathieu-daude/qemu/build/docker_debian-riscv64-cross/meson-private/sanitycheckc.exe
C compiler for the build machine: ccache cc (gcc 12.3.0 "cc (Debian 
12.3.0-5) 12.3.0")
C linker for the build machine: cc ld.bfd 2.40.90.20230705
Build machine cpu family: x86_64
Build machine cpu: x86_64
Host machine cpu family: riscv
Host machine cpu: riscv
Target machine cpu family: riscv
Target machine cpu: riscv
Program scripts/symlink-install-tree.py found: YES 
(/home/philippe.mathieu-daude/qemu/build/docker_debian-riscv64-cross/pyvenv/bin/python3 
/home/philippe.mathieu-daude/qemu/scripts/symlink-install-tree.py)
Program sh found: YES (/usr/bin/sh)
Program python3 found: YES 
(/home/philippe.mathieu-daude/qemu/build/docker_debian-riscv64-cross/pyvenv/bin/python3)

[...]

======



