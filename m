Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D768790174
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:29:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7wk-000591-DL; Fri, 01 Sep 2023 13:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qc7wi-00058R-O8
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:28:36 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qc7wg-0001jr-4D
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:28:36 -0400
Received: from [192.168.1.12] (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 2408844477;
 Fri,  1 Sep 2023 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693589311; bh=FDX1A2L+Sgj5g9Qh1UDTzOqJ0j+w/qC/GCZxbjgc7Lw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=neTy6U3o7e+ySpuZbRygw2Rz6EEVr/uAwOa/6q/v+fr/Wr+LlcKEjgESCXkaz9vMf
 a7KNdwM5/Pwn574uQQLkQXgYC7UHrSXYQckdeo1EjhMVQFEHjJ/jF52uC43p6qDSHS
 3KAlWXro7OFXXzoZCOojzyRnkjzp0U6g1BqxtpKM=
Message-ID: <3ddba7dd-db34-c017-8dfa-fa805145e2f2@jia.je>
Date: Sat, 2 Sep 2023 01:28:20 +0800
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
From: Jiajie Chen <c@jia.je>
In-Reply-To: <1f963ece-d5b6-50c7-5e40-bc04867494f7@linaro.org>
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


On 2023/9/2 01:24, Richard Henderson wrote:
> On 9/1/23 02:30, Jiajie Chen wrote:
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>>   tcg/loongarch64/tcg-target.c.inc     | 60 ++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
>>
>> diff --git a/tcg/loongarch64/tcg-target-con-set.h 
>> b/tcg/loongarch64/tcg-target-con-set.h
>> index 37b3f80bf9..d04916db25 100644
>> --- a/tcg/loongarch64/tcg-target-con-set.h
>> +++ b/tcg/loongarch64/tcg-target-con-set.h
>> @@ -31,4 +31,5 @@ C_O1_I2(r, 0, rZ)
>>   C_O1_I2(r, rZ, ri)
>>   C_O1_I2(r, rZ, rJ)
>>   C_O1_I2(r, rZ, rZ)
>> +C_O1_I2(w, w, wJ)
>
> Notes for improvement: 'J' is a signed 32-bit immediate.


I was wondering about the behavior of 'J' on i128 types: in 
tcg_target_const_match(), the argument type is int, so will the higher 
bits be truncated?

Besides, tcg_target_const_match() does not know the vector element width.


>
>> +        if (const_args[2]) {
>> +            /*
>> +             * cmp_vec dest, src, value
>> +             * Try vseqi/vslei/vslti
>> +             */
>> +            int64_t value = sextract64(a2, 0, 8 << vece);
>> +            if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
>> +                 cond == TCG_COND_LT) && (-0x10 <= value && value <= 
>> 0x0f)) {
>> +                tcg_out32(s, 
>> encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
>> +                                                 a0, a1, value));
>> +                break;
>> +            } else if ((cond == TCG_COND_LEU || cond == 
>> TCG_COND_LTU) &&
>> +                (0x00 <= value && value <= 0x1f)) {
>> +                tcg_out32(s, 
>> encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
>> +                                                 a0, a1, value));
>
> Better would be a new constraint that only matches
>
>     -0x10 <= x <= 0x1f
>
> If the sign is wrong for the comparison, it can *always* be loaded 
> with just vldi.
>
> Whereas at present, using J,
>
>> +            tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
>> +            a2 = temp_vec;
>
> this may require 3 instructions (lu12i.w + ori + vreplgr2vr).
>
> By constraining the constants allowed, you allow the register 
> allocator to see that a register is required, which may be reused for 
> another instruction.
>
>
> r~

