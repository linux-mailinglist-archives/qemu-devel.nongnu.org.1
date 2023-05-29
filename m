Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A57143DC
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 08:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3VxL-00012u-HC; Mon, 29 May 2023 02:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3VxD-000128-0c; Mon, 29 May 2023 02:02:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3Vx7-00084v-DA; Mon, 29 May 2023 02:02:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B52E6906A;
 Mon, 29 May 2023 09:01:52 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 57C9880A8;
 Mon, 29 May 2023 09:01:52 +0300 (MSK)
Message-ID: <c66df357-d647-1335-7a7e-70e602dd44bb@tls.msk.ru>
Date: Mon, 29 May 2023 09:01:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/10] ppc queue
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Bernhard Beschow <shentey@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
 <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
 <CSYEG7TJD7S7.IYIJXRKLWCZA@wheely>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CSYEG7TJD7S7.IYIJXRKLWCZA@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
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

29.05.2023 05:18, Nicholas Piggin wrote:
..

>> 01/10 target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3.0 ISAs
>> 02/10 target/ppc: Fix width of some 32-bit SPRs
>> 03/10 target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
>> 05/10 hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
>>
>> Or are these not important for -stable?  Or maybe there are other changes
>> which should be picked too?
> 
> They certainly fix some parts of target emulation, but what is the
> guidance for backporting those type of fixes? Most of the patches I sent
> including 2,3 were just found from inspection or new test code and not
> real software failing.
> 
> Should just simple ones go in? 32-bit SPRs do not fix entirely the
> behaviour of all SPRs, just one aspect. In another fix I had (that
> didn't make it in this merge), was a bit more complicated and the
> first iteration caused a deadlock that didn't show up in basic test
> like booting Linux.
> 
> My guess is that fixes that correct an issue with real software running
> on the target should be ported to stable. Perhaps "obviously correct"
> small fixes as well. But not sure about larger changes.

This is exactly why I asked, - because I don't clearly understand how
important these to have in -stable. And also to remind that -stable
exist, just in case.. ;)

So be it, no actual issue so not applying to -stable.

Thank you for the clarification!

/mjt

