Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4BA75DAA6
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 09:39:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN7BS-0008CE-DK; Sat, 22 Jul 2023 03:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qN7BP-0008C1-AS; Sat, 22 Jul 2023 03:37:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qN7BN-0007is-3a; Sat, 22 Jul 2023 03:37:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC248158C6;
 Sat, 22 Jul 2023 10:37:39 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4440118A34;
 Sat, 22 Jul 2023 10:37:33 +0300 (MSK)
Message-ID: <7729752d-6821-7f84-0659-5e8c7002cb3f@tls.msk.ru>
Date: Sat, 22 Jul 2023 10:37:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 5/5] linux-user: Fix qemu-arm to run static armhf binaries
Content-Language: en-US
To: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
References: <20230719155235.244478-1-deller@gmx.de>
 <20230719155235.244478-6-deller@gmx.de>
 <68821f3a-84ce-a44a-aecb-46ad27059205@tls.msk.ru>
 <a881af49-c2f2-3065-4e6c-8e076cd75c71@gmx.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <a881af49-c2f2-3065-4e6c-8e076cd75c71@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

22.07.2023 00:37, Helge Deller wrote:
..
>> So, this is kinda amusing.
>> This broke arm64, ppc64el and s390x:
>>
>> arm64$ ./qemu-aarch64 /bin/sh -c '/bin/ls -dCFl *[t]* >/dev/null'
>> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>> Segmentation fault

Note: I run it on native arm64, so it is arm64 on arm64, -
this is a quick test I had from the debian qemu autopkgtest (which
run /bin/ls under qemu and natively and compares the result).  I
haven't tried to reproduce it locally on amd64 host, - I did it on
a debian arm64 porterbox (which I was logged on anyway to debug a
different issue on armel, with qemu git tree already cloned).

> Argh, that's really unfortunate.
> I just tested myself.
> Running static busybox binary did work for me:
> # ./qemu-aarch64 busybox

It didn't trigger with ls, but it did when I run something from
emulated /bin/sh.

This whole email was more like a heads-up/warning, to collect more
details later, - and maybe someone knows what the problem is already
if it is obvious.

..
> Maybe someone else can try? I leave it up to Peter if he wants to revert
> that patch right now, or if it can wait a few days until I'm back?

For the time being, how about a quick-n-hacky band-aid, to include
this fixup only where the original prob actually triggered in the
first place?

Like, if the target is armel?  Something like

#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)

or what's the right preprocessor condition is?

Thanks,

/mjt

