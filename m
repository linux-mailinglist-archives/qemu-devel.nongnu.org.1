Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399EE7E1E78
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:37:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwyR-0000dt-8x; Mon, 06 Nov 2023 05:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qzwyP-0000dl-7S
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:36:49 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qzwyN-00072C-2m
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:36:49 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 51AE5756088;
 Mon,  6 Nov 2023 11:37:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 44E1A756087; Mon,  6 Nov 2023 11:37:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 426327560A3;
 Mon,  6 Nov 2023 11:37:00 +0100 (CET)
Date: Mon, 6 Nov 2023 11:37:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Howard Spoelstra <hsp.cat7@gmail.com>
cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, 
 Rene Engel <ReneEngel80@emailn.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Error detecting linker while compiling qemu-system-ppc on
 macOS
In-Reply-To: <CABLmASHL3etTk7b1Tbg6rcZD+qGZXcPBkAR0+tcJP+EJdXF63Q@mail.gmail.com>
Message-ID: <d11d3bba-4e6f-6303-8d9c-5d786128a23a@eik.bme.hu>
References: <cover.1672868854.git.balaton@eik.bme.hu>
 <4162db13bd1da9c6ddd77f185cef738e44790467.1672868854.git.balaton@eik.bme.hu>
 <b821c773-a443-c70b-5d4c-787284028f8a@ilande.co.uk>
 <389d8398-2b77-a64e-7034-79123da6cb86@eik.bme.hu>
 <CABLmASHE7iiqHnOZxCfaqvz5zwUipG5vunHG_UK8krXu71HOgw@mail.gmail.com>
 <bd0e4431-c5ec-2ef5-d847-8c59aa8cc55c@eik.bme.hu>
 <ab9e33e5-70fc-0a76-c548-16ec787ea1af@ilande.co.uk>
 <ed8ee369-c9a8-7853-3b65-7361fefc3c63@eik.bme.hu>
 <ca5240e6-e00d-6213-22d6-f7b43d8bed18@ilande.co.uk>
 <CABLmASGc6fybw7mL5JHUCukwoB6KjGaaWHct5mi20A2vXZhtaA@mail.gmail.com>
 <CABLmASHL3etTk7b1Tbg6rcZD+qGZXcPBkAR0+tcJP+EJdXF63Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

On Mon, 6 Nov 2023, Howard Spoelstra wrote:
> Hi all,
>
> I'm getting a error while compiling on macOS (Intel). It seems linker
> detection is passed an unknown argument "--version", whereas "-v" works OK?
> See log below.

See also 
https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg10375.html
and the tickets listed in there. It should work with meson 1.2.x according 
to Rene's ticket to Meson and you can install that from homebrew but it 
seems it's not picked up. Why is it using 
/Users/hsp/src/qemu-ppc/build/pyvenv/bin/python3.11 ? How many pythons do 
you8 have on macOS? What does which python tell you and does it work 
better when you add --python=/path/to/python/that/homebrew/meson/uses ?

Regards,
BALATON Zoltan

> Thanks for looking into this,
> Howard
>
> Build started at 2023-11-06T07:29:19.181487
> Main binary: /Users/hsp/src/qemu-ppc/build/pyvenv/bin/python3.11
> Build Options: -Db_pie=false -Ddocs=disabled -Dplugins=true '--native-file
> config-meson.cross'
> Python system: Darwin
> The Meson build system
> Version: 0.63.3
> Source dir: /Users/hsp/src/qemu-ppc
> Build dir: /Users/hsp/src/qemu-ppc/build
> Build type: native build
> Project name: qemu
> Project version: 8.1.50
> -----
> Detecting compiler via: cc -m64 -mcx16 --version
> compiler returned <Popen: returncode: 0 args: ['cc', '-m64', '-mcx16',
> '--version']>
> compiler stdout:
> Apple clang version 15.0.0 (clang-1500.0.40.1)
> Target: x86_64-apple-darwin22.6.0
> Thread model: posix
> InstalledDir: /Library/Developer/CommandLineTools/usr/bin
>
> compiler stderr:
>
> Running command: cc -m64 -mcx16 -E -dM -
> -----
> Detecting linker via: cc -m64 -mcx16 -Wl,--version
> linker returned <Popen: returncode: 1 args: ['cc', '-m64', '-mcx16',
> '-Wl,--version']>
> linker stdout:
>
> linker stderr:
> ld: unknown options: --version
> clang: error: linker command failed with exit code 1 (use -v to see
> invocation)
>
> -----
> Detecting Apple linker via: cc -m64 -mcx16 -Wl,-v
> linker stdout:
>
> linker stderr:
> @(#)PROGRAM:ld  PROJECT:dyld-1015.7
> BUILD 18:48:43 Aug 22 2023
> configured to support archs: armv6 armv7 armv7s arm64 arm64e arm64_32 i386
> x86_64 x86_64h armv6m armv7k armv7m armv7em
> will use ld-classic for: armv6 armv7 armv7s arm64_32 i386 armv6m armv7k
> armv7m armv7em
> LTO support using: LLVM version 15.0.0 (static support for 29, runtime is
> 29)
> TAPI support using: Apple TAPI version 15.0.0 (tapi-1500.0.12.3)
> Library search paths:
> /usr/local/lib
> Framework search paths:
> ld: Undefined symbols:
>  _main, referenced from:
>      <initial-undefines>
> clang: error: linker command failed with exit code 1 (use -v to see
> invocation)
>
>
> ../meson.build:1:0: ERROR: Unable to detect linker for compiler `cc -m64
> -mcx16 -Wl,--version`
> stdout:
> stderr: ld: unknown options: --version
> clang: error: linker command failed with exit code 1 (use -v to see
> invocation)
>

