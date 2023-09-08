Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE59E798287
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVCM-0001re-Ue; Fri, 08 Sep 2023 02:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeVCJ-0001qI-Ge; Fri, 08 Sep 2023 02:42:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeVCG-0000a0-TB; Fri, 08 Sep 2023 02:42:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2653A1FF92;
 Fri,  8 Sep 2023 09:43:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6C7A6267F4;
 Fri,  8 Sep 2023 09:42:25 +0300 (MSK)
Message-ID: <6874b2b1-1d47-ea7e-8c89-82f9f0678b9b@tls.msk.ru>
Date: Fri, 8 Sep 2023 09:42:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL v2 00/35] ppc queue
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230906143653.54709-1-clg@kaod.org>
 <2b6c3dd1-430a-2e60-ea73-29c507d631d8@tls.msk.ru>
 <ad943b46-0652-8fd1-49a4-c86dd6214827@kaod.org>
 <CVD90VD3O9W1.1UBFXQ7MSVZEO@wheely>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CVD90VD3O9W1.1UBFXQ7MSVZEO@wheely>
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

08.09.2023 07:24, Nicholas Piggin wrote:
> On Fri Sep 8, 2023 at 8:15 AM AEST, Cédric Le Goater wrote:
..
>> The decrementer fixes are good candidates but there are quite a few
>> patches and you might encounter conflicts.
> 
> Decrementer I was nervous about since there were quite a lot of
> interacting issues. Decrementer has worked okay for a while, so
> even though there are some bugs, they're mostly in edge cases
> that most OSes don't hit or care so much about.
> 
> Possibly the decrementer migration patch could be a candidate.
> 
> In any case I would like them to get more testing upstream for
> a while first.

Yeah, got it, thank you for the explanation! Let's see how it goes.

>>> or some of these:
>>>
>>>    ppc/vof: Fix missed fields in VOF cleanup
> 
> vof patch I think is a candidate. Simple and fixes leaks.
> 
>>>    spapr: Fix machine reset deadlock from replay-record
>>>    hw/ppc/e500: fix broken snapshot replay
>>
>> I can not tell if replay-record is important for stable. Nick ?
> 
> It seems to have been broken in many ways for long enough that
> nobody was really using it (at least on pseries). Maybe e500
> because an issue was filed for that and the fix looked small.
> 
>>    
>>> or something else?
>>
>> These are :
>>
>>     target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
>>     target/ppc: Fix LQ, STQ register-pair order for big-endian
> 
> Yes definitely these two.

The "LQ, STQ on big-endian" has been Cc'd to stable so I picked it
up right away.  I now also added

   ppc/vof: Fix missed fields in VOF cleanup
   hw/ppc/e500: fix broken snapshot replay
   target/ppc: Flush inputs to zero with NJ in ppc_store_vscr

to the mix, and also put a few of decrementer on hold to check
later.

Thank you!

/mjt

