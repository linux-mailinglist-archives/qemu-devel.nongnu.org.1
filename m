Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797975EFB4
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 11:47:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNs8O-0000gT-50; Mon, 24 Jul 2023 05:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qNs80-0000fb-JG; Mon, 24 Jul 2023 05:45:20 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qNs7v-0003pA-QB; Mon, 24 Jul 2023 05:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690191908; x=1690796708; i=deller@gmx.de;
 bh=6HYfTHcQ9fIXS+sOtxOPIt0+tynnyGfW7gae7YU5kjg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=IWpAfcY8X7bA6okXGlO8wEk74YmqM7AnJfaC5PD/XohzBuW18EWMIS+CsNzr+8pyZvKr3Pi
 5Gu4O5h+stnBfj12cIUHhgiLZjQqGz7UNCGSla2hbNdy+Un26mm1tVBKp4lD4sJzzFnfsnnEM
 RUQcyyqK7hzUpA/4D4NEm9HGVdUc9FunaLeBZNuG4cin9+ZGEDwR30bJu6CN8FwvTQYQTbOdI
 mCB97jc2b3pscun01uLdS7ljiTI2InTdBg3yAUj4qOS1cruvsO4H0t/prHLjz3y0SZgW3Drt0
 mOElkHwIGOKE1ntbJo1lEBWvxyJcMsNsOPWClzUGNvJWvceGdCLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1qL7Es2fUo-002nGs; Mon, 24
 Jul 2023 11:45:08 +0200
Message-ID: <79c3dabd-3e75-d93e-2185-43ad1e6291ee@gmx.de>
Date: Mon, 24 Jul 2023 11:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 5/5] linux-user: Fix qemu-arm to run static armhf binaries
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
References: <20230719155235.244478-1-deller@gmx.de>
 <20230719155235.244478-6-deller@gmx.de>
 <68821f3a-84ce-a44a-aecb-46ad27059205@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <68821f3a-84ce-a44a-aecb-46ad27059205@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M4SgW67P23HoTPk928/G29hbgzwvroELB0t4v0MDiNlEmJVrJT2
 HxPFA4yu6WTCL9Py7g3swGBTODtSPN3fSvrQp8/7St7JCLaXBMfzxI9RJtxozED/hClzUCX
 a4qxBoGq8sMwIknB4rd3qqICq8n0c0ogTgFQyldmsrxaCvQ09u6XmtaG3jEKxAjzloNbpqQ
 v+5MRWDYfUAZySv4GwHcA==
UI-OutboundReport: notjunk:1;M01:P0:FQtLQSYlmUY=;8FWn/vbADy/pJ2Krg13qOB5WPQk
 hggmg1lpy/5aJRmMtMhdn6x/fCtwKmr8t6jXPR/QHVUuUcrqAYr4YzlvN+9JUa3Ffg/zNGpcl
 9khlGZIELyW/R3/g5qrXu+l0/p+ETAI13U76koHKvxFYyHH8myU5EeDyP/2Yn2i/xqa1nzSGT
 pa8RuNl2bGlwxEVPbY7F8T3W/+ejTRco3ugJiLsBzNk6+pPzVQoQB3E04XdwJYrNRMu+P1NCe
 ilFxGJfY11bZ2rLNB4rLMwGvaF3zrUIg4m3aM6c6+yTcuP8mVFEKC4mga+vqpKgcc0k6oFUea
 eRPAPA3CDnMz+pwl9zLcjQEfaLLpBhtRJEDWrofs52Kb1RbXuhwjHtoAusg6juLkNms8567Ku
 XIq9IB0k0V4Y0pycunuzMDryjm/P4UNzGVgCbUDCyw1oLnaDufn3jhSSRpHTD1uFV9JwzqGu/
 HZbLcTafUl0iKkdnvUuPTz3VdrRVsY1DxnSPH3+5tReSJ2vs8iuYXJCyX9JbXL6jI/H0TxZAR
 kSFwLvFEHZjoWKfvsA7cjTDGJDQGtQbtQiBVTmxRGtaTA6JA53Te560Y/e9vKlAPcgTO/IyCO
 fAkv1PVKfPhEm8YFyDQvdiSRO44EdB/8zbivaWwfo1l4cf6MjW97kVmNEQrizi8Y0v5xqAzL4
 KGaIx8oVClVaTvCdFd/M7g0U/r6JMscQv6TeVP0AA1mNnXOVcCDniE4zYmafZhB7xyNM2uJD2
 ZgF6/8v+JE+0cqEH0FVqGMAnhDSOvdlbCQAv0SLzCqq26829DgiEbMNMPreEU+mOYOCTgB874
 9rWRAObIgjpRKBXLulOasnAwL5UTS7bp72+bpql6ckWj7532ChoyX3jAZ2ZVmSFHUq6d1z7AE
 bN9ZPR6hyGijvS+77MkPkQ6ExlUP/HCi1nswbWGD3DeDHX6pqBNj9BAWKZNS+/91B3WZCTZfT
 lKpLxW29LqYsyXy8slGYjEnU+Jo=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/21/23 17:14, Michael Tokarev wrote:
> 19.07.2023 18:52, Helge Deller wrote:
>> qemu-user crashes immediately when running static binaries on the armhf
>> architecture. The problem is the memory layout where the executable is
>> loaded before the interpreter library, in which case the reserved brk
>> region clashes with the interpreter code and is released before qemu
>> tries to start the program.
>>
>> At load time qemu calculates a brk value for interpreter and executable
>> each.=C2=A0 The fix is to choose the higher one of both.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: Andreas Schwab <schwab@suse.de>
>> Cc: qemu-stable@nongnu.org
>> Reported-by:=C2=A0 Venkata.Pyla@toshiba-tsip.com
>> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1040981
>> ---
>> =C2=A0 linux-user/elfload.c | 7 +++++++
>> =C2=A0 1 file changed, 7 insertions(+)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index a26200d9f3..94951630b1 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3615,6 +3615,13 @@ int load_elf_binary(struct linux_binprm *bprm, s=
truct image_info *info)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (elf_interpreter) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_elf_interp(=
elf_interpreter, &interp_info, bprm->buf);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * adjust brk address =
if the interpreter was loaded above the main
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * executable, e.g. ha=
ppens with static binaries on armhf
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (interp_info.brk > info-=
>brk) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inf=
o->brk =3D interp_info.brk;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> So, this is kinda amusing.
> This broke arm64, ppc64el and s390x:
>
> arm64$ ./qemu-aarch64 /bin/sh -c '/bin/ls -dCFl *[t]* >/dev/null'
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault
>
> (it was just a quick test from debian qemu-user package).
>
> Reverting this patch makes it work again..

It seems the whole loading of binaries on aarch64 is somewhat wrong.
My patch just triggers the whole thing to blow up.

This is how the memory-map looks on physical hardware:
  deller@amdahl:~$ uname -a
Linux amdahl 5.10.0-23-arm64 #1 SMP Debian 5.10.179-2 (2023-07-14) aarch64=
 GNU/Linux
deller@amdahl:~$ cat /proc/self/maps
aaaaafb70000-aaaaafb78000 r-xp 00000000 fe:02 131743                     /=
bin/cat
aaaaafb88000-aaaaafb89000 r--p 00008000 fe:02 131743                     /=
bin/cat
aaaaafb89000-aaaaafb8a000 rw-p 00009000 fe:02 131743                     /=
bin/cat
aaaae022b000-aaaae024c000 rw-p 00000000 00:00 0                          [=
heap]
ffff9ce78000-ffff9ce9a000 rw-p 00000000 00:00 0
ffff9ce9a000-ffff9cff6000 r-xp 00000000 fe:02 790863                     /=
lib/aarch64-linux-gnu/libc-2.31.so
ffff9cff6000-ffff9d005000 ---p 0015c000 fe:02 790863                     /=
lib/aarch64-linux-gnu/libc-2.31.so
ffff9d005000-ffff9d009000 r--p 0015b000 fe:02 790863                     /=
lib/aarch64-linux-gnu/libc-2.31.so
ffff9d009000-ffff9d00b000 rw-p 0015f000 fe:02 790863                     /=
lib/aarch64-linux-gnu/libc-2.31.so
ffff9d00b000-ffff9d00e000 rw-p 00000000 00:00 0
ffff9d00e000-ffff9d02f000 r-xp 00000000 fe:02 790820                     /=
lib/aarch64-linux-gnu/ld-2.31.so
ffff9d033000-ffff9d035000 rw-p 00000000 00:00 0
ffff9d03c000-ffff9d03e000 r--p 00000000 00:00 0                          [=
vvar]
ffff9d03e000-ffff9d03f000 r-xp 00000000 00:00 0                          [=
vdso]
ffff9d03f000-ffff9d040000 r--p 00021000 fe:02 790820                     /=
lib/aarch64-linux-gnu/ld-2.31.so
ffff9d040000-ffff9d042000 rw-p 00022000 fe:02 790820                     /=
lib/aarch64-linux-gnu/ld-2.31.so
ffffe9ea3000-ffffe9ec4000 rw-p 00000000 00:00 0                          [=
stack]

this is on qemu-linux-user-aarch64:
I have no name!@paq:/# cat /proc/self/maps
5500000000-5500009000 r-xp 00000000 08:01 2380521                        /=
usr/bin/cat
5500009000-550001f000 ---p 00000000 00:00 0
550001f000-5500020000 r--p 0000f000 08:01 2380521                        /=
usr/bin/cat
5500020000-5500021000 rw-p 00010000 08:01 2380521                        /=
usr/bin/cat
5500021000-5500042000 rw-p 00000000 00:00 0
5502021000-5502022000 ---p 00000000 00:00 0
5502022000-5502822000 rw-p 00000000 00:00 0                              [=
stack]
5502822000-5502848000 r-xp 00000000 08:01 2382563                        /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5502848000-5502860000 ---p 00000000 00:00 0
5502860000-5502862000 r--p 0002e000 08:01 2382563                        /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5502862000-5502864000 rw-p 00030000 08:01 2382563                        /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5502864000-5502865000 r-xp 00000000 00:00 0
5502865000-5502867000 rw-p 00000000 00:00 0
5502870000-55029f7000 r-xp 00000000 08:01 2382566                        /=
usr/lib/aarch64-linux-gnu/libc.so.6
55029f7000-5502a0d000 ---p 00187000 08:01 2382566                        /=
usr/lib/aarch64-linux-gnu/libc.so.6
5502a0d000-5502a10000 r--p 0018d000 08:01 2382566                        /=
usr/lib/aarch64-linux-gnu/libc.so.6
5502a10000-5502a12000 rw-p 00190000 08:01 2382566                        /=
usr/lib/aarch64-linux-gnu/libc.so.6
5502a12000-5502a1f000 rw-p 00000000 00:00 0

Here I got:
interp_info.brk 0x5502863358
info->brk       0x5500020458
diff            0x2842f00   40 MB

I think we need to make sure that the shared libs (ld, glibc) gets loaded
at the top of the memory to free up heap space. Right now (without my patc=
h)
there were 40MB heap, with my patch if clashed with ld.so.

Helge

