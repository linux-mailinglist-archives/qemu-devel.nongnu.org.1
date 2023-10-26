Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ABB7D7A39
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvpKt-0001bx-M1; Wed, 25 Oct 2023 21:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qvpKr-0001bk-MS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:38:57 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qvpKp-0002z4-Or
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:38:57 -0400
Received: from [192.168.1.5] (unknown [223.72.62.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 158CD43DA4;
 Thu, 26 Oct 2023 01:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698284332; bh=nGA+fdnVbuT8+0M2eTwiQe3+SGjJ2Pt13f5q3oxDkhs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=n5B/22wLsSL4rqE0NkqKmQuDGJKtrrtJi8sCinJwe5OhggRylQfLySw/H5EENCmGL
 rX1gtqqZqRMZE0iTAM4P0dO8deJHQSthpB/ag7sqQ0fxyY/Flzu7p8QxftCzBEqDJm
 nx9v3g6xL+fjLuCFL6TsJa+jP7PBKBOq0K9SN3BE=
Message-ID: <062ee798-c112-46d4-82b8-983e85ffe2ed@jia.je>
Date: Thu, 26 Oct 2023 09:38:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
 <1af667c0-f1ba-4538-9aec-8232397dd3c5@jia.je>
 <a1784c3c-b00e-4cb6-a262-96e6cbaa5c30@jia.je>
 <70260625-5981-40f3-a189-afddac2a6dfa@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <70260625-5981-40f3-a189-afddac2a6dfa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


On 2023/10/26 03:04, Richard Henderson wrote:
> On 10/25/23 10:13, Jiajie Chen wrote:
>>> On 2023/10/24 07:26, Richard Henderson wrote:
>>>> See target/arm/tcg/translate-a64.c, gen_store_exclusive, TCGv_i128 
>>>> block.
>>>> See target/ppc/translate.c, gen_stqcx_.
>>>
>>> The situation here is slightly different: aarch64 and ppc64 have 
>>> both 128-bit ll and sc, however LoongArch v1.1 only has 64-bit ll 
>>> and 128-bit sc.
>
> Ah, that does complicate things.
>
>> Possibly use the combination of ll.d and ld.d:
>>
>>
>> ll.d lo, base, 0
>> ld.d hi, base, 4
>>
>> # do some computation
>>
>> sc.q lo, hi, base
>>
>> # try again if sc failed
>>
>> Then a possible implementation of gen_ll() would be: align base to 
>> 128-bit boundary, read 128-bit from memory, save 64-bit part to rd 
>> and record whole 128-bit data in llval. Then, in gen_sc_q(), it uses 
>> a 128-bit cmpxchg.
>>
>>
>> But what about the reversed instruction pattern: ll.d hi, base, 4; 
>> ld.d lo, base 0?
>
> It would be worth asking your hardware engineers about the bounds of 
> legal behaviour. Ideally there would be some very explicit language, 
> similar to


I'm a community developer not affiliated with Loongson. Song Gao, could 
you provide some detail from Loongson Inc.?


>
> https://developer.arm.com/documentation/ddi0487/latest/
> B2.9.5 Load-Exclusive and Store-Exclusive instruction usage restrictions
>
> But you could do the same thing, aligning and recording the entire 
> 128-bit quantity, then extract the ll.d result based on address bit 
> 6.  This would complicate the implementation of sc.d as well, but 
> would perhaps bring us "close enough" to the actual architecture.
>
> Note that our Arm store-exclusive implementation isn't quite in spec 
> either.  There is quite a large comment within translate-a64.c 
> store_exclusive() about the ways things are not quite right.  But it 
> seems to be close enough for actual usage to succeed.
>
>
> r~

