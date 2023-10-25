Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F17D7229
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhSe-0000IN-Bo; Wed, 25 Oct 2023 13:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qvhSW-0000GN-Kj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 13:14:20 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qvhSU-0000ol-2c
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 13:14:20 -0400
Received: from [192.168.1.6] (unknown [223.72.40.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 7251E43B38;
 Wed, 25 Oct 2023 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698254049; bh=U69oy8KHXe5LhosfzL441GTuKULdvVZFen4SeGbH+mU=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=hTmi5Pe4AXTlbSz1eBNBOKDu0O6B82RlJx/hyuMbeuS0eFd07UEsgFTP7OMGxElML
 Ow4NjUb4WUurszr/JMOHBsUYd4CTWMer+l8Ke96d/DO0JDbEqtlSbPXSjvbTkR82vy
 rpn4qwl1Z+sy65tuynM1UNEaWtJlI/6nfxIFoKc4=
Message-ID: <a1784c3c-b00e-4cb6-a262-96e6cbaa5c30@jia.je>
Date: Thu, 26 Oct 2023 01:13:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
Content-Language: en-US
From: Jiajie Chen <c@jia.je>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
 <1af667c0-f1ba-4538-9aec-8232397dd3c5@jia.je>
In-Reply-To: <1af667c0-f1ba-4538-9aec-8232397dd3c5@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2023/10/24 14:10, Jiajie Chen wrote:
>
> On 2023/10/24 07:26, Richard Henderson wrote:
>> On 10/23/23 08:29, Jiajie Chen wrote:
>>> This patch series implements the new instructions except sc.q, 
>>> because I do not know how to match a pair of ll.d to sc.q.
>>
>> There are a couple of examples within the tree.
>>
>> See target/arm/tcg/translate-a64.c, gen_store_exclusive, TCGv_i128 
>> block.
>> See target/ppc/translate.c, gen_stqcx_.
>
>
> The situation here is slightly different: aarch64 and ppc64 have both 
> 128-bit ll and sc, however LoongArch v1.1 only has 64-bit ll and 
> 128-bit sc. I guest the intended usage of sc.q is:
>
>
> ll.d lo, base, 0
>
> ll.d hi, base, 4
>
> # do some computation
>
> sc.q lo, hi, base
>
> # try again if sc failed


Possibly use the combination of ll.d and ld.d:


ll.d lo, base, 0

ld.d hi, base, 4

# do some computation

sc.q lo, hi, base

# try again if sc failed


Then a possible implementation of gen_ll() would be: align base to 
128-bit boundary, read 128-bit from memory, save 64-bit part to rd and 
record whole 128-bit data in llval. Then, in gen_sc_q(), it uses a 
128-bit cmpxchg.


But what about the reversed instruction pattern: ll.d hi, base, 4; ld.d 
lo, base 0?


Since there are no existing code utilizing the new sc.q instruction, I 
don't know what should we consider here.


>
>
>
>>
>>
>> r~

