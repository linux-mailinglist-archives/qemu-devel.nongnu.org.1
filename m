Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DAB7728DF
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1wz-0008Hj-1C; Mon, 07 Aug 2023 11:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qT1wg-0008FU-8k
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:14:59 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qT1we-0001O8-Aq
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:14:58 -0400
Received: from [172.20.10.3] (unknown [112.97.81.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 0C58F43B16;
 Mon,  7 Aug 2023 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691421286; bh=FuePuJzQFUCAvu7zYz6JvQhlDC3MemFeEaVsxGNCKy8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mVYQaRXx/044vYUECaJ+Fo2iVW6qZhmkUpB4s43dcjSFWciV+F7hRyl8mZx/7lmU9
 a7akq91TJE0M+SAP+GakP+ipXleFbfakzCf/isyvz4afU1kbsAZPGMfGG5qUV1KK8x
 ETJC4MhOsIH2/+YSOYNo12IFYtZseSgF9OgPwnS8=
Message-ID: <1eb9bb2b-e69f-ddbf-2c24-4e2403e08651@jia.je>
Date: Mon, 7 Aug 2023 23:14:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/6] target/loongarch: Add loongarch32 mode for
 loongarch64-softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-2-c@jia.je>
 <ddc0fa77-0d44-58a0-86a0-6f2343c0fade@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <ddc0fa77-0d44-58a0-86a0-6f2343c0fade@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/8/7 23:13, Richard Henderson wrote:
> On 8/7/23 02:45, Jiajie Chen wrote:
>> This commit adds loongarch32 mode to loongarch64-softmmu.
>>
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   target/loongarch/cpu.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index fa371ca8ba..43c73e6363 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -272,9 +272,16 @@ struct LoongArchTLB {
>>   };
>>   typedef struct LoongArchTLB LoongArchTLB;
>>   +/* Current LoongArch mode */
>> +typedef enum LoongArchMode {
>> +    LA32 = 0,
>> +    LA64 = 1,
>> +} LoongArchMode;
>> +
>>   typedef struct CPUArchState {
>>       uint64_t gpr[32];
>>       uint64_t pc;
>> +    LoongArchMode mode;
>
> This is not how the hardware works.
> This data is stored in CPUCFG.1.ARCH.
Okay, I will change to use CFGCFG.1.ARCH instead in v4.
>
>
> r~

