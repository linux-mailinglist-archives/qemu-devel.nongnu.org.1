Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E407504F3
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 12:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXFa-0000dK-0B; Wed, 12 Jul 2023 06:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qJXFX-0000d2-DH; Wed, 12 Jul 2023 06:39:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qJXFU-0000PZ-Dq; Wed, 12 Jul 2023 06:39:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D1E913434;
 Wed, 12 Jul 2023 13:39:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 93D10145EB;
 Wed, 12 Jul 2023 13:39:03 +0300 (MSK)
Message-ID: <d902daf3-68ff-71ae-a849-8cd131f1210a@tls.msk.ru>
Date: Wed, 12 Jul 2023 13:39:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>
References: <20230711085903.304496-1-npiggin@gmail.com>
 <CTZTWJ73RQFY.1ZX05ZTD1FIWA@wheely>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CTZTWJ73RQFY.1ZX05ZTD1FIWA@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
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

12.07.2023 05:13, Nicholas Piggin wrote:
> On Tue Jul 11, 2023 at 6:59 PM AEST, Nicholas Piggin wrote:
>> The gdb remote protocol has a special interrupt character (0x03) that is
>> transmitted outside the regular packet processing, and represents a
>> Ctrl-C pressed in the client. Despite not being a regular packet, it
>> does expect a regular stop response if the stub successfully stops the
>> running program.
>>
>> See: https://sourceware.org/gdb/onlinedocs/gdb/Interrupts.html
>>
>> Inhibiting the stop reply packet can lead to gdb client hang. So permit
>> a stop response when receiving a character from gdb that stops the vm.
>> Additionally, add a warning if that was not a 0x03 character, because
>> the gdb session is likely to end up getting confused if this happens.
>>
>> Cc: qemu-stable@nongnu.org
> 
> Oh, I should note that this doesn't apply to any stable
> branches I'm sorry. Will be more careful with the tag...

That's entirely Okay, since the Fixes: tag helps to determine if it fits
or not, and 758370052fb is v8.0.0-803-g758370052f.  It's worse to miss
something important :)

Thank you!

/mjt

