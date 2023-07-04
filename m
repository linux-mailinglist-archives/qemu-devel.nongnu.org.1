Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1AE746C5E
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbjO-00077o-Fv; Tue, 04 Jul 2023 04:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qGbjE-000773-DU
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:49:44 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qGbjC-0002B7-Ri
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2CTFhDduZ/gmTF0hcnq2jpjnTjXaK4UixOAgd7adtwo=; b=h41MW6RwgcJnbqymFMRuYIuZOK
 Iix7sbduWhnkJqlsMaADUlseSBYP6r3xYYxRPSkuzzVziJqjehL+SfBo0hSwFWlKbZgyuYYABjIW+
 G02qdL/ZF+h0KelKPEwRkHxEviBnsSk0bltV+spL7/RV5y0xu/EftruejZr2eBYt9mCQ=;
Message-ID: <a5a43032-4a8f-a12f-4e18-bb60d9231323@rev.ng>
Date: Tue, 4 Jul 2023 10:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/9] include/hw: introduce CPU_MAX_NEGATIVE_ENV_OFFSET
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, eduardo@habkost.net, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, peter.maydell@linaro.org, wangyanan55@huawei.com
References: <20230630122551.21766-1-anjo@rev.ng>
 <20230630122551.21766-5-anjo@rev.ng>
 <bd3618d9-549b-994d-55a9-d333e7f1a905@linaro.org>
Organization: rev.ng
In-Reply-To: <bd3618d9-549b-994d-55a9-d333e7f1a905@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 6/30/23 16:19, Richard Henderson wrote:
> On 6/30/23 14:25, Anton Johansson wrote:
>> For reasons related to code-generation quality, the offset of
>> CPUTLBDescFast and IcountDecr from CPUArchState needs to fit within
>> 11 bits of displacement (arm[32|64] and riscv addressing modes).
>>
>> This commit introduces a new constant to store the maximum allowed
>> negative offset, so it can be statically asserted to hold later on.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   include/hw/core/cpu.h | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index c226d7263c..0377f74d48 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -259,6 +259,17 @@ struct qemu_work_item;
>>     #define CPU_UNSET_NUMA_NODE_ID -1
>>   +/*
>> + * For reasons related to code-generation quality the fast path
>> + * CPUTLBDescFast array and IcountDecr fields need to be located 
>> within a
>> + * small negative offset of CPUArchState.  This requirement comes from
>> + * host-specific addressing modes of arm[32|64] and riscv which uses 
>> 12-
>> + * and 11 bits of displacement respectively.
>> + */
>> +#define CPU_MIN_DISPLACEMENT_BITS 11
>> +#define CPU_MAX_NEGATIVE_ENV_OFFSET \
>> +    (-(1 << CPU_MIN_DISPLACEMENT_BITS))
>
> You'd want 6 bits, for AArch64 LDP (7-bit signed immediate).

Ah right, but it's scaled so it would be -512 for AArch64 and -256 for 
arm32,
that would also agree with the smallest MIN_TLB_MASK_TABLE_OFS  in
the backends.

-- 
Anton Johansson,
rev.ng Labs Srl.


