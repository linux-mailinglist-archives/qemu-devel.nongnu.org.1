Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D097B765
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Sep 2024 07:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqn5L-0001Cl-T9; Wed, 18 Sep 2024 01:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sqn5J-00019b-2Y; Wed, 18 Sep 2024 01:18:37 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sqn5G-0003uf-U6; Wed, 18 Sep 2024 01:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1726636710; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=Asp+kIjt1BYzAhKLn6sMnwHXiEts6pgB9pv4w7WceKg=;
 b=HIYdrE0+Ap5IERZRoGJUknDsnCQiIGfuMS4+4kehjF0ezYqgF813o1ucwqORqHB2WWS7v1a0A6t2ld+Wten51JLaVUXeS48feAPES9UbUh4/M9nn9xspTsWMwPkDvJfQoVp8QpRW57cf/MCqfIqkTouGe7E8HOKmA29ab15ckFg=
Received: from 30.166.64.79(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WFCszvr_1726636708) by smtp.aliyun-inc.com;
 Wed, 18 Sep 2024 13:18:28 +0800
Message-ID: <b87e7a7e-41fd-4b26-bde3-9adca9babb24@linux.alibaba.com>
Date: Wed, 18 Sep 2024 13:17:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] tcg/riscv: Add basic support for vector
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 Swung0x48 <swung0x48@outlook.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-3-zhiwei_liu@linux.alibaba.com>
 <0d591570-02c6-48c9-9e3f-ef47ac20ce7d@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <0d591570-02c6-48c9-9e3f-ef47ac20ce7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/9/12 2:41, Richard Henderson wrote:
> On 9/11/24 06:26, LIU Zhiwei wrote:
>> From: Swung0x48<swung0x48@outlook.com>
>>
>> The RISC-V vector instruction set utilizes the LMUL field to group
>> multiple registers, enabling variable-length vector registers. This
>> implementation uses only the first register number of each group while
>> reserving the other register numbers within the group.
>>
>> In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
>> host runtime needs to adjust LMUL based on the type to use different
>> register groups.
>>
>> This presents challenges for TCG's register allocation. Currently, we
>> avoid modifying the register allocation part of TCG and only expose the
>> minimum number of vector registers.
>>
>> For example, when the host vlen is 64 bits and type is TCG_TYPE_V256, 
>> with
>> LMUL equal to 4, we use 4 vector registers as one register group. We can
>> use a maximum of 8 register groups, but the V0 register number is 
>> reserved
>> as a mask register, so we can effectively use at most 7 register groups.
>> Moreover, when type is smaller than TCG_TYPE_V256, only 7 registers are
>> forced to be used. This is because TCG cannot yet dynamically constrain
>> registers with type; likewise, when the host vlen is 128 bits and
>> TCG_TYPE_V256, we can use at most 15 registers.
>>
>> There is not much pressure on vector register allocation in TCG now, so
>> using 7 registers is feasible and will not have a major impact on code
>> generation.
>>
>> This patch:
>> 1. Reserves vector register 0 for use as a mask register.
>> 2. When using register groups, reserves the additional registers within
>>     each group.
>>
>> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
>> Co-authored-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
>
> If there is a co-author, there should be another Signed-off-by.

This patch has added a tag:

Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>


Do you mean we should add the same tag twice?

Thanks,
Zhiwei

>
>> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
>> ---
>>   tcg/riscv/tcg-target-con-str.h |   1 +
>>   tcg/riscv/tcg-target.c.inc     | 126 ++++++++++++++++++++++++---------
>>   tcg/riscv/tcg-target.h         |  78 +++++++++++---------
>>   tcg/riscv/tcg-target.opc.h     |  12 ++++
>>   4 files changed, 151 insertions(+), 66 deletions(-)
>>   create mode 100644 tcg/riscv/tcg-target.opc.h
>
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~

