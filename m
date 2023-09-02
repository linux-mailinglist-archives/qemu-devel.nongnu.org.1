Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8193790496
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 03:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcF5h-0001rr-9b; Fri, 01 Sep 2023 21:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcF5f-0001r9-NA
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 21:06:19 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcF5d-0006yB-89
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 21:06:19 -0400
Received: from [192.168.1.12] (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id C9F4743F6D;
 Sat,  2 Sep 2023 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693616775; bh=Cx0lpVYhNgGKx5ayX6OaSwMFAZgvvDZi4vFbn5I0fh8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=a8hd0kGig+lho2kkxFFBmU++5eGWKLRCtu5aq/v794BXmJOJgofWs0Ek61tYM+lZV
 WSm0jNHBOUxik3gt/6t1pNz5HiJ7H/SrHfHH1Wx56Xz1gTAuUI4y5yjTn6zAppBq6R
 P59nfdqsdwwyhD1IgcBu9Q3K2Xj0x1cqJKdYo5t0=
Message-ID: <a6ce39a5-c128-3b5e-f412-b13a0328e328@jia.je>
Date: Sat, 2 Sep 2023 09:06:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 03/14] tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-4-c@jia.je>
 <1f963ece-d5b6-50c7-5e40-bc04867494f7@linaro.org>
 <3ddba7dd-db34-c017-8dfa-fa805145e2f2@jia.je>
 <39e63387-dad7-ffd0-12c3-082f81c09997@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <39e63387-dad7-ffd0-12c3-082f81c09997@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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


On 2023/9/2 01:48, Richard Henderson wrote:
> On 9/1/23 10:28, Jiajie Chen wrote:
>>
>> On 2023/9/2 01:24, Richard Henderson wrote:
>>> On 9/1/23 02:30, Jiajie Chen wrote:
>>>> Signed-off-by: Jiajie Chen <c@jia.je>
>>>> ---
>>>>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>>>>   tcg/loongarch64/tcg-target.c.inc     | 60 
>>>> ++++++++++++++++++++++++++++
>>>>   2 files changed, 61 insertions(+)
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>>
>>>>
>>>> diff --git a/tcg/loongarch64/tcg-target-con-set.h 
>>>> b/tcg/loongarch64/tcg-target-con-set.h
>>>> index 37b3f80bf9..d04916db25 100644
>>>> --- a/tcg/loongarch64/tcg-target-con-set.h
>>>> +++ b/tcg/loongarch64/tcg-target-con-set.h
>>>> @@ -31,4 +31,5 @@ C_O1_I2(r, 0, rZ)
>>>>   C_O1_I2(r, rZ, ri)
>>>>   C_O1_I2(r, rZ, rJ)
>>>>   C_O1_I2(r, rZ, rZ)
>>>> +C_O1_I2(w, w, wJ)
>>>
>>> Notes for improvement: 'J' is a signed 32-bit immediate.
>>
>>
>> I was wondering about the behavior of 'J' on i128 types: in 
>> tcg_target_const_match(), the argument type is int, so will the 
>> higher bits be truncated?
>
> The argument is int64_t val.
>
> The only constants that we allow for vectors are dupi, so all higher 
> parts are the same as the lower part.


Consider the following scenario:


cmp_vec v128,e32,tmp4,tmp3,v128$0xffffffffffffffff

cmp_vec v128,e32,tmp4,tmp3,v128$0xfffffffefffffffe

cmp_vec v128,e8,tmp4,tmp3,v128$0xfefefefefefefefe


When matching constant constraint, the vector element width is unknown, 
so it cannot decide whether 0xfefefefefefefefe means e8 0xfe or e16 0xfefe.


>
>> Besides, tcg_target_const_match() does not know the vector element 
>> width.
>
> No, it hadn't been required so far -- there are very few vector 
> instructions that allow immediates.
>
>
> r~

