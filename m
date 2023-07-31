Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774E67692C4
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPpm-0007PK-AK; Mon, 31 Jul 2023 06:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qQPph-0007On-Ss
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:08:57 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qQPpf-0003sc-3c
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:08:57 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c1d03e124so64497066b.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1690798133; x=1691402933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dvmzdTWPLUoH2OThh4NDIdXgzp8yb2XuT3JilMo8co4=;
 b=f/aC48UC1eoQ9KbvnSPJWR7fsQDz2+oBiqBYSlV8hjhF6PptjlnLP/RZCnMV+Osn2N
 ThDrkBi7pXILnYkFY+4gaGbmsZeQGBNNCWB1baDnrPJ160ka479+mKdHZ5rb+9++Kkyn
 H8TkkmaNVbqTI9m2+Mg4MWiNJWZUWFO23BBCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690798133; x=1691402933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dvmzdTWPLUoH2OThh4NDIdXgzp8yb2XuT3JilMo8co4=;
 b=ZypXzCOG8CPNGAFSK+/e3ndRVI7LKYHaSV8ess/uubZ+2wfoxxtOTSdN0GXH5kspvb
 KrViGFB0coCovR9D5J06hRWKnGztaHgDDU45Ny+CI1eA3nJ0eYQMOHxBGY3mTiKkl3sg
 SSbdiNEotx9DaHxvqC4xrCu+1DQx2Gyb3oBMayk+rASFINz/qDyXa9cZDxD0drBWJHVz
 Xb32vTOwnQ6apX4Fmxy1iMxMfG6vc+HRTq4lSMXijbBQP17o0bkxEA0n79f3ViUeNrm/
 wEIcnUtWGj8m+Qpcug4bS3086/wbD2iAN6FkRgGZxRyGvOG4P126gTsjXQgbqH72M+gc
 VI7w==
X-Gm-Message-State: ABy/qLYTlpnHOauqWbXeHjK7VmIsZKLSypPgklH5bqIht8wxVj7QFQt6
 /Lh/IiM1miSduBAM0zxsWS+sdE9j4wJpprNdDyE=
X-Google-Smtp-Source: APBJJlFLxeKNFtfDgSyKZuB4sl2JMiCXRQOYvpOflxU6bWQmXw1nDhhOJc9xq10D8USTVj/618r8bohH0mWo9PUChIw=
X-Received: by 2002:a17:907:1dea:b0:99b:4a2b:2ea3 with SMTP id
 og42-20020a1709071dea00b0099b4a2b2ea3mr5744920ejc.17.1690798132867; Mon, 31
 Jul 2023 03:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230728173127.259192-1-deller@gmx.de>
In-Reply-To: <20230728173127.259192-1-deller@gmx.de>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 31 Jul 2023 10:08:40 +0000
Message-ID: <CACPK8XeyqcEDyyL3Jw2WYWs_gGdtTCf2=Ly04CMgkshSMdj7RA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] linux-user: Fix and optimize target memory layout
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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

On Fri, 28 Jul 2023 at 18:58, Helge Deller <deller@gmx.de> wrote:
>
> While trying to fix a bug which prevents running a static
> armhf binary with linux-user, I noticed a whole bunch of
> memory layout issues on various platforms. Most noteably
> the free heap space was very limited in the current setup.
> A large heap is important for example, if you want to
> use qemu-user for building Linux packages where gcc requires
> lots of space (e.g. using qemu-user as buildd for debian
> packages).
>
> Those findings led to this patch series, which
> - fixes qemu-arm to run static armhf binaries

Applying this on top of master and trying to run a simple armhf binary
on a ppc64le host fails:

qemu$ ./build/qemu-arm -d guest_errors,page,strace ~/hello-armhf
host mmap_min_addr=0x10000
pgb_find_hole: base @ 10000 for 4294967296 bytes
pgb_static: base @ 10000 for 4294967295 bytes
pgb_reserved_va: base @ 0x10000 for 4294967296 bytes
Locating guest address space @ 0x10000
page layout changed following mmap
start    end      size     prot
00010000-00060000 00050000 ---
00060000-00066000 00006000 ---
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00060000 00050000 r-x
00060000-00066000 00006000 ---
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00060000 00050000 r-x
00060000-00064000 00004000 rw-
00064000-00066000 00002000 ---
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00060000 00050000 r-x
00060000-00064000 00004000 rw-
00064000-00066000 00002000 rw-
f3000000-f3810000 00810000 rw-
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00060000 00050000 r-x
00060000-00064000 00004000 rw-
00064000-00066000 00002000 rw-
f3000000-f3010000 00010000 ---
f3010000-f3811000 00801000 rw-
ffff0000-00000000 00010000 r-x
guest_base  0x10000
page layout changed following binary load
start    end      size     prot
00010000-00060000 00050000 r-x
00060000-00064000 00004000 rw-
00064000-00066000 00002000 rw-
f3000000-f3010000 00010000 ---
f3010000-f3810000 00800000 rw-
f3810000-f3811000 00001000 r-x
ffff0000-00000000 00010000 r-x
start_brk   0x00000000
end_code    0x0005f9c8
start_code  0x00010000
start_data  0x00060414
end_data    0x0006327c
start_stack 0xf380f420
brk         0x00066000
entry       0x00010341
argv_start  0xf380f424
env_start   0xf380f42c
auxv_start  0xf380f4a8
95718 brk(NULL) = 0x00066000
95718 brk(0x00066874) = 0x00066874
95718 set_tid_address(0x66068) = 95718
95718 set_robust_list(0x6606c,12) = -1 errno=38 (Function not implemented)
95718 Unknown syscall 398
95718 ugetrlimit(3,-209652764,328608,404128,401408,1) = 0
95718 readlinkat(AT_FDCWD,"/proc/self/exe",0xf380e390,4096) = 22
95718 getrandom(0x65940,4,1) = 4
95718 brk(NULL) = 0x00066874
95718 brk(0x00087874)page layout changed following mmap
start    end      size     prot
00010000-00060000 00050000 r-x
00060000-00064000 00004000 rw-
00064000-00066000 00002000 rw-
00070000-00090000 00020000 rw-
f3000000-f3010000 00010000 ---
f3010000-f3810000 00800000 rw-
f3810000-f3811000 00001000 r-x
ffff0000-00000000 00010000 r-x
 = 0x00087874
95718 brk(0x00088000) = 0x00088000
95718 mprotect(0x00060000,8192,PROT_READ) = 0
95718 statx(1,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS_STAT,STATX_BASIC_STATS,0xf380f078)
= 0
95718 write(1,0x66b08,14) = -1 errno=14 (Bad address)
95718 exit_group(0)

A working arm binary by comparison:

qemu$ ./build/qemu-arm -d guest_errors,page,strace ~/hello
host mmap_min_addr=0x10000
pgb_find_hole: base @ 10000 for 4294967296 bytes
pgb_static: base @ 10000 for 4294967295 bytes
pgb_reserved_va: base @ 0x10000 for 4294967296 bytes
Locating guest address space @ 0x10000
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
f3000000-f3810000 00810000 rw-
ffff0000-00000000 00010000 r-x
page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
f3000000-f3010000 00010000 ---
f3010000-f3811000 00801000 rw-
ffff0000-00000000 00010000 r-x
guest_base  0x10000
page layout changed following binary load
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
f3000000-f3010000 00010000 ---
f3010000-f3810000 00800000 rw-
f3810000-f3811000 00001000 r-x
ffff0000-00000000 00010000 r-x
start_brk   0x00000000
end_code    0x00084f7c
start_code  0x00010000
start_data  0x00095098
end_data    0x00098394
start_stack 0xf380f430
brk         0x0009b000
entry       0x00010418
argv_start  0xf380f434
env_start   0xf380f43c
auxv_start  0xf380f4b8
95733 brk(NULL) = 0x0009b000
95733 brk(0x0009b8fc) = 0x0009b8fc
95733 set_tid_address(0x9b068) = 95733
95733 set_robust_list(0x9b070,12) = -1 errno=38 (Function not implemented)
95733 Unknown syscall 398
95733 uname(0xfffffffff380f270) = 0
95733 ugetrlimit(3,-209652756,469816,622616,618496,1) = 0
95733 readlink("/proc/self/exe",0xf380e380,4096) = 16
95733 getrandom(0x9ab10,4,1) = 4
95733 brk(0x000cb8fc)page layout changed following mmap
start    end      size     prot
00010000-00090000 00080000 r-x
00090000-000a0000 00010000 rw-
000a0000-000d0000 00030000 rw-
f3000000-f3010000 00010000 ---
f3010000-f3810000 00800000 rw-
f3810000-f3811000 00001000 r-x
ffff0000-00000000 00010000 r-x
 = 0x000cb8fc
95733 brk(0x000d0000) = 0x000d0000
95733 statx(1,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS_STAT,STATX_BASIC_STATS,0xf380f0b8)
= 0
95733 write(1,0x9bb90,14)Hello, World!
 = 14
95733 exit_group(0)

The test program is:

#include <stdio.h>
int main() { printf("Hello, World!\n");}

Built like this:

arm-linux-gnueabihf-gcc -o hello-armhf hello.c -static

arm-linux-gnueabi-gcc -o hello hello.c -static

on an Ubuntu 23.04 host.

Cheers,

Joel

