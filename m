Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF447ABA79
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 22:23:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjmf5-0006sQ-8K; Fri, 22 Sep 2023 16:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjmez-0006s5-0E; Fri, 22 Sep 2023 16:21:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjmex-0006xR-0J; Fri, 22 Sep 2023 16:21:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C07172464B;
 Fri, 22 Sep 2023 23:22:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 99AC12A227;
 Fri, 22 Sep 2023 23:21:50 +0300 (MSK)
Message-ID: <87066678-b978-17dd-d65e-39de162fc4a4@tls.msk.ru>
Date: Fri, 22 Sep 2023 23:21:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Stable-8.1.1 11/34] softmmu: Assert data in bounds in
 iotlb_to_section
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
 <20230909102747.346522-11-mjt@tls.msk.ru>
 <5a617673-efe0-18b9-e3db-88277b09ba52@tls.msk.ru> <87y1h1ur1y.fsf@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <87y1h1ur1y.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

20.09.2023 12:23, Alex Bennée:
..
>> I wonder if I should keep 0d58c6606 for 8.1.1 (the deadline is
>> tomorrow)..
> 
> Unfortunately 0d58c is not the full fix, it papered over one crack but
> revealed others. It might be leading to a false sense of security. So I
> would argue:
> 
>    - keep the assert - better to fail early than to fail later in a hard
>      to understand way
>    - toss a coin for the 0d58c66 fix, if we include it we may end up
>      reverting later once we have the "complete" fix but at least its
>      slightly better for x86 while definitely breaking MIPS

Heh. I've read this email just now, way after 8.1.1 has been tagged and
the announcement sent.

I haven't included 0d58c66 for now, without tossing coins - just to be
on-par with 8.1.0, or else it is confusing at best (which stable releases
brings with new issues).

This whole thing is definitely worth a 8.1.2 once the fix is in.

Meanwhile I pushed qemu with 0d58c66 and the "always require can_do_io"
patchset to debian, - this one fixed all regressions so far.
https://salsa.debian.org/qemu-team/qemu/-/tree/debian/1%258.1.0+ds-6/debian/patches/always-can-do-io-1866
https://gitlab.com/mjt0k/qemu/-/commits/staging-8.1-always-require-can_do_io/

Thank you for the thoughts, much apprecated!

/mjt

