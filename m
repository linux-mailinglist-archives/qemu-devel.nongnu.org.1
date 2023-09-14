Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E67A0ABD
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 18:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgp95-0004wM-6f; Thu, 14 Sep 2023 12:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgp92-0004wD-Qe
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:24:44 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgp8p-0006yD-Eg
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vSGCoyWDK2dVT2m+xquY7HvAcEH+lnWZmEjnLlQn4Xo=; b=vy2FaorRc7xFAClc78QvDUgqvX
 zBemNiefXOiD+TSh8QsJZfuV9kmYal5hcH9/RgLvwqCTIwU/0fg0qEmi24GTuWQuNuCcH2+Nw+CXq
 ROEV3K+yNjV+EeVQnjzjaXBNZWPilhtDv0JANq8hWHgrAeqWcvCmOKiWPxf3MkPgcrZs=;
Message-ID: <9ee8618b-58ad-416e-934f-cdde3617e0e4@rev.ng>
Date: Thu, 14 Sep 2023 18:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/24] accel/tcg: Remove env_tlb()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-23-richard.henderson@linaro.org>
 <2cfd1afd-ad83-8507-b8be-b0d743f9d0ee@linaro.org>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <2cfd1afd-ad83-8507-b8be-b0d743f9d0ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 9/14/23 17:44, Philippe Mathieu-Daudé wrote:
> On 14/9/23 04:44, Richard Henderson wrote:
>> From: Anton Johansson <anjo@rev.ng>
>>
>> The function is no longer used to access the TLB,
>> and has been replaced by cpu->neg.tlb.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> Message-Id: <20230912153428.17816-9-anjo@rev.ng>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> [rth: Merge comment update patch]
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/cpu-all.h       | 11 -----------
>>   tcg/aarch64/tcg-target.c.inc |  2 +-
>>   tcg/arm/tcg-target.c.inc     |  2 +-
>>   3 files changed, 2 insertions(+), 13 deletions(-)
>
> Missing:
>
> -- >8 --
> diff --cc accel/tcg/cputlb.c
> index bb7dcb87af,08df68f03a..0000000000
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@@ -1746,7 -1734,7 +1734,7 @@@ bool tlb_plugin_lookup(CPUState *cpu, v
>           /* We must have an iotlb entry for MMIO */
>           if (tlb_addr & TLB_MMIO) {
>               CPUTLBEntryFull *full;
> -             full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
> ++            full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>               data->is_io = true;
>               data->v.io.section =
>                   iotlb_to_section(cpu, full->xlat_section, full->attrs);
> ---
>
> (Noticed using --enable-plugins).
Ah right, I'll make sure to test with plugins in the future! Thanks:)

-- 
Anton Johansson,
rev.ng Labs Srl.


