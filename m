Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4B97268C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Sep 2024 03:16:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snpTJ-0007DE-NR; Mon, 09 Sep 2024 21:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snpTF-0007A2-Q1; Mon, 09 Sep 2024 21:15:06 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snpTC-00079q-Bk; Mon, 09 Sep 2024 21:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725930891; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=rZZ8GHhSwokTHHhAHnWxpnMzj032GOMBvFtfhHtLitc=;
 b=GctDTxMla4EzbXEuoSqJzv8Cmn/It5FF8DhJ/MWN5lyum/LBZ4fzTD5jQCNLzjuLVODMbdZ4POP5ir2Aex/ctBleuBQhuv+6uBUFJa6L5hagAEVfy77wJuaS5HaGCCPyFaIf+wm1dy2ZBqdPi5FdBd8ZW6a8tyESbZ90xyhGr64=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEhvXpM_1725930889) by smtp.aliyun-inc.com;
 Tue, 10 Sep 2024 09:14:50 +0800
Message-ID: <3d2f459a-8d73-48fa-9da1-c8aa7e5989f7@linux.alibaba.com>
Date: Tue, 10 Sep 2024 09:13:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] tcg/riscv: Implement vector mov/dup{m/i}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-7-zhiwei_liu@linux.alibaba.com>
 <e8091bd4-95f3-4a7c-966e-521d75a33c79@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <e8091bd4-95f3-4a7c-966e-521d75a33c79@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/9/5 14:56, Richard Henderson wrote:
> On 9/4/24 07:27, LIU Zhiwei wrote:
>> @@ -698,6 +704,21 @@ static bool tcg_out_mov(TCGContext *s, TCGType 
>> type, TCGReg ret, TCGReg arg)
>>       case TCG_TYPE_I64:
>>           tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
>>           break;
>> +    case TCG_TYPE_V64:
>> +    case TCG_TYPE_V128:
>> +    case TCG_TYPE_V256:
>> +        {
>> +            int nf = get_vec_type_bytes(type) / riscv_vlenb;
>> +
>> +            if (nf != 0) {
>> +                tcg_debug_assert(is_power_of_2(nf) && nf <= 8);
>> +                tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1, true);
>> +            } else {
>> +                riscv_set_vec_config_vl(s, type);
>> +                tcg_out_opc_vv(s, OPC_VMV_V_V, ret, TCG_REG_V0, arg, 
>> true);
>> +            }
>> +        }
>> +        break;
>
> Perhaps
>
>         int lmul = type - riscv_lg2_vlenb;
>         int nf = 1 << MIN(lmul, 0);
>         tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
>
> Is there a reason to prefer vmv.v.v over vmvnr.v?

I think it's a trade-off. For some CPUs,  instruction will be split 
internally. Thus the less the fraction lmul is, the less micro ops for 
execution.
That's the benefit of using vmv.v.v. But here we also need a vsetivli. 
On some cpus, it can be fusion-ed to the next instruction.

> Seems like we can always move one vector reg...
OK. I will take this way.
>
>> +static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned 
>> vece,
>> +                                    TCGReg dst, int64_t arg)
>> +{
>> +    if (arg < 16 && arg >= -16) {
>> +        riscv_set_vec_config_vl_vece(s, type, vece);
>> +        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, TCG_REG_V0, arg, true);
>> +        return;
>> +    }
>> +    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
>> +    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
>> +}
>
> I'll note that 0 and -1 do not require SEW change. I don't know how 
> often that will come up

On our test on OpenCV, we get a rate of 99.7%. Thus we will optimize 
this next version.

Thanks,
Zhiwei

> , since in my testing with aarch64, we usually needed to swap to 
> TCG_TYPE_V256 anyway.
>
>
> r~

