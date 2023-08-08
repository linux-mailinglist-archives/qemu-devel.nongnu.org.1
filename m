Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFF773B07
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:37:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOkx-0003Kg-DC; Tue, 08 Aug 2023 11:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qTOkl-0003KH-A5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:36:12 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qTOke-00077M-N0
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691508956; x=1692113756; i=deller@gmx.de;
 bh=RAhv/mrRqCBHbzsVOB+w7YZEzQnYNQ4Cnr4B7hpFjXQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=habYe61+24Y0+2V7bgFuC3st4vyBWDKqEvW9Rshlzk6InCbXADC+R8lXyXY7CuH0BDmNwCe
 ROD3bAuRZjEro2WP2tyN6FNj8WNS83cflZKHkGkqAEnaY2QhzCRk0mO6l6T84kyITFoMfTDEC
 vz9fkgqBzSFxxMVTsqFr36CfAmLH2ZnUo94i6G55+HAWhKQskZ36hVmaJUecrp18eG5FYhrdl
 kAJ9cj8ka7jwyqLpPrtAsokTVwlbbj7QF3ctvQELbA7y3oHknQpspDPoYIbLCKFx3luIcMMdL
 zizvc2ainTTy6kStyzlqx+UtEoY22oG6ce8BOh+06lYwG6VsISLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.175]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1qbtLL0cZH-009gp3; Tue, 08
 Aug 2023 17:35:56 +0200
Message-ID: <82e20337-af08-bfdf-21bd-71e5bcaad635@gmx.de>
Date: Tue, 8 Aug 2023 17:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 v10 01/14] linux-user: Adjust task_unmapped_base
 for reserved_va
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-2-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230807163705.9848-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UpcFCUowYdLjpXHQSiCprwXMmeVjjfRMpRC80Rao8twqvTszdXy
 4Z3fG6dhwmDX/mB3l/2eNNpBCLgIjR1lp02bhic6BNS8u6NBOoMz32jhaMI41/o9r44CI2h
 4NJGpWro3QXCdo7w/sxFlQVAp4iEqBVnXbMscfrqDlvsIKE+ThZTB9VtHVt1S3vsgtNQmQS
 OTM32bH7Q9Ak+1VrFb8gA==
UI-OutboundReport: notjunk:1;M01:P0:+yfL4ecIaUw=;tqvL921qnerD3NR1od9Uw5Zv/OF
 FAu03gGvYfjYfda5rQj7KwDkRLYDnkj9UsJK2z4QNw+I9NoyChgn/Fm6Gr09uI2SzeefP9oWL
 4CdMKNAbrNfhJqw9bgGquRfGty06wMZq8qsMEoMT5e87cG3pJAYvh2s1o1siLctywMkY/7oEm
 Ng1DVSpRCPYqB5HFyU8KmI40Vcl2QIFUvp0fKv5K/aMXM+iOvVrRSHUYITqDfIhN2jbOwjRrh
 B7/j/3vfqLQkyArhV8ml82alv6i87A+B2WLdcqvqJqQIFvAt4hPDXFVGutMz4Wt7tesWA6YEd
 whtB0nyT0ScsWssYM2oAc4sgT8MrmqM2SisGr9Wd37cMRUy6tq1o5q8D+2R52WASQIZlXI2Gg
 vfWMZLkF2i6jeDOwf00XKZR1ttQNpdaaUQNciIBYuM3BN1LkELzcv8VrD2EOCpo9m/sa3YH5k
 EFAL8DuI6DYnoPyM8p9WKrNiv3+3FKzE15E9JE3eZq607MBDXWhu4KBtkQqmZ4HFkeoO6l/P5
 VkU0wjC6EXbi1k6C5XbIiMA1Vy2OqNpEbW55eCSmaVzhhhB3aLDOxZejaxGYG+N7Cl1XAdzfu
 vWDDvT/8/CylvCHZjci1bQOz0qL0pZyA1+vuyH3/mLGGcfYC4pdGjmdhHmat8EyvgLlsB447x
 I2PkYIb0Zfpnqag7zLT+OUIEPySV3SxDrUY2D9puqktSOFZSSy3/9P778AfAAOWY+zS8MDse7
 ppo7Tnrui0eU9npF2R39qljlJHrQNYz4F9c4Hm8zjgQmRdZ5C1MtKvFUN7AZ9AXr/YnhyX5bC
 0MxewH8dZoHVE+Wqx+gemHe9qsheJbL5ATzHR2Hv8e0ooUvSZI6dZLdmBAXNNuNUYNcTTBISk
 B3HA00T9iRT+cZdgnKBABAd85yP4rRpP0r/1eH+19Nu8v+HtLf7F+I9zdMemKBG9VSABxmwqV
 tyKvF4cYf8DPL6s+lLFuaVFKGvE=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-4.14, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/7/23 18:36, Richard Henderson wrote:
> Ensure that the chosen values for mmap_next_start and
> task_unmapped_base are within the guest address space.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I've tested this whole series for quite some chroots.
Good thing is, that all targets do run and can execute a static hello-worl=
d
program.
So, overall that's good and I think the patch series should go in for 8.1.

Looking at the target's memmap I do see non-optimal heap-addresses for arm=
 and
powerpc.
I know it's not directly related to your patches, but we should later
try to move the heap behind the executables where they can grow bigger.

Helge

armel-chroot  and armhf-chroot:
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 armv7l GNU/Linux
00021000-00042000 rw-p 00000000 00:00 0                                  [=
heap]
00400000-00408000 r-xp 00000000 fd:00 801471                             /=
usr/bin/cat
00408000-0041f000 ---p 00000000 00:00 0
0041f000-00420000 r--p 0000f000 fd:00 801471                             /=
usr/bin/cat
00420000-00421000 rw-p 00010000 fd:00 801471                             /=
usr/bin/cat
40000000-40001000 ---p 00000000 00:00 0
40001000-40801000 rw-p 00000000 00:00 0                                  [=
stack]
40801000-40827000 r-xp 00000000 fd:00 839152                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
40827000-40828000 r--p 00026000 fd:00 839152                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
40828000-40829000 rw-p 00027000 fd:00 839152                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
...

powerpc-chroot
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 ppc GNU/Linux
00021000-00043000 rw-p 00000000 00:00 0                                  [=
heap]
001c0000-003d5000 r-xp 00000000 fd:00 577250                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
003d5000-003eb000 ---p 00215000 fd:00 577250                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
003eb000-003f0000 r--p 0021b000 fd:00 577250                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
003f0000-003f1000 rw-p 00220000 fd:00 577250                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
003f1000-003fb000 rw-p 00000000 00:00 0
00400000-0040b000 r-xp 00000000 fd:00 535994                             /=
usr/bin/cat
0040b000-0041f000 ---p 00000000 00:00 0
0041f000-00420000 r--p 0000f000 fd:00 535994                             /=
usr/bin/cat
00420000-00421000 rw-p 00010000 fd:00 535994                             /=
usr/bin/cat
40000000-40001000 ---p 00000000 00:00 0
40001000-40801000 rw-p 00000000 00:00 0                                  [=
stack]
40801000-40834000 r-xp 00000000 fd:00 577246                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
40834000-4084f000 ---p 00000000 00:00 0
4084f000-40851000 r--p 0003e000 fd:00 577246                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
40851000-40852000 rw-p 00040000 fd:00 577246                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
40852000-40853000 r-xp 00000000 00:00 0
40853000-40855000 rw-p 00000000 00:00 0



