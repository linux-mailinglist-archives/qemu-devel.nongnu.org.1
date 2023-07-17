Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D77566F3
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPfk-0003cG-Ov; Mon, 17 Jul 2023 10:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qLPfI-0003T3-V0
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:57:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qLPfG-0004CN-Dr
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:57:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 715EA14604;
 Mon, 17 Jul 2023 17:57:20 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E198153AD;
 Mon, 17 Jul 2023 17:57:18 +0300 (MSK)
Message-ID: <6f53ef2c-a42f-938c-f9eb-9a28124ff270@tls.msk.ru>
Date: Mon, 17 Jul 2023 17:57:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 20/47] linux-user: Make sure initial brk(0) is page-aligned
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
 <20230715135317.7219-21-richard.henderson@linaro.org>
 <5a2a1941-2e8d-7ebc-b808-d91d27a69f1a@tls.msk.ru>
 <90ee6305-42d5-b045-c854-669521155160@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <90ee6305-42d5-b045-c854-669521155160@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.097,
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

17.07.2023 17:42, Richard Henderson пишет:
> On 7/16/23 19:15, Michael Tokarev wrote:
>> 15.07.2023 16:52, Richard Henderson wrote:
>>> From: Andreas Schwab <schwab@suse.de>
>>>
>>> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
>>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>>> Message-Id: <mvmpm55qnno.fsf@suse.de>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> This smells like a stable-8.0 material.  Please let me know if it is not.
> 
> Yep.

FWIW, there was an attempt to fix another issue I posted about
yesterday, with libklibc-based apps on armhf, after "linux-user:
Reserve space for brk" commit, here:

   https://github.com/hdeller/qemu-hppa/commits/upx-fix

(which reverts this very commit).  But apparently it doesn't fix
that issue, libklibc-linked armhf apps still segfaults right at
startup.

This is jfyi, maybe this commit is just another temporary band-aid,
I dunno yet.  Yes it fixes real failures so it's already good.

Thanks,

/mjt

