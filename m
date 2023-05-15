Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6BB7031E2
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:52:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyaUP-0003dG-AA; Mon, 15 May 2023 11:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pyaUM-0003d1-4q
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:51:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pyaUK-0007K5-31
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:51:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4CAAB600B;
 Mon, 15 May 2023 18:51:49 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 42B285591;
 Mon, 15 May 2023 18:51:48 +0300 (MSK)
Message-ID: <98d7376b-ff88-2a34-7c33-d6928defb823@msgid.tls.msk.ru>
Date: Mon, 15 May 2023 18:51:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: tcg_target_long to pointer conversion?
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <8173c29d-eac4-2d5b-d75f-2b95eb129736@msgid.tls.msk.ru>
 <d558a918-1dde-debb-0540-ba81f056c10a@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <d558a918-1dde-debb-0540-ba81f056c10a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -106
X-Spam_score: -10.7
X-Spam_bar: ----------
X-Spam_report: (-10.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
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

Just found an old thread marked "ToDo"..

23.04.2023 13:40, Richard Henderson wrote:
> On 4/23/23 10:55, Michael Tokarev wrote:
>> Hi!
>>
>> This commit:
>>
>> commit 705ed477d54c5bccf51d924c403a52049586c3d7
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:   Wed Oct 28 23:42:12 2020 -0700
>>
>>      tcg/i386: Support split-wx code generation
>>
>> contains the following change:
>>
>> -    diff = arg - ((uintptr_t)s->code_ptr + 7);
>> +    diff = tcg_pcrel_diff(s, (const void *)arg) - 7;
>>
>> where arg is of type tcg_target_long.  It looks like this is
>> the only place in qemu where this type is used as the pointer.
>>
>> Does it make sense?
> 
> Hmm.  No, I don't think it does.  We can't truncate arg from uint64_t and have the test work properly.
> 
>>
>> This warning is produced when building qemu on x32:
>>
>>   In file included from tcg/tcg.c:432:
>>   tcg/i386/tcg-target.c.inc: In function ‘tcg_out_movi_int’:
>>   tcg/i386/tcg-target.c.inc:1041:30: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>    1041 |     diff = tcg_pcrel_diff(s, (const void *)arg) - 7;
>>
>> yes, x32 itself isn't a supported target, but it has some
>> rather unique properties which might catch possible issues.
> 
> Maybe
> 
>      diff = arg - ((uintptr_t)tcg_splitwx_to_rx(s->code_ptr) + 7);

I know almost nothing about tcg.. :)

/mjt


