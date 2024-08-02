Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFBA945807
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Aug 2024 08:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZlgF-0005SJ-Gm; Fri, 02 Aug 2024 02:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZlgD-0005RN-8p; Fri, 02 Aug 2024 02:22:21 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZlgA-0003EX-21; Fri, 02 Aug 2024 02:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722579730; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=uzpilC9klZVD825AUqrt+tmlh02syWAANuFr7ATmvFo=;
 b=GtdBA1dxya6kODu8AH3xPHnHes+ESIaGUc/3nJASz8KIUPmXzH5zT7u2Fkg6N2cakQ/3SqQjv23TTi0hN6kCofP3KPxj2HGvmpWezQOp02e7zpYVEt9gfz5vEEC9RYbWx7jVV8beG2DTK8KxsZXCdfQ5JUDEFw5cMXiJp4kJ1HI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R891e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067111;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WBwKkyH_1722579728; 
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBwKkyH_1722579728) by smtp.aliyun-inc.com;
 Fri, 02 Aug 2024 14:22:09 +0800
Message-ID: <b65aa4d1-c206-4ebb-af8c-75b034c6b875@linux.alibaba.com>
Date: Fri, 2 Aug 2024 14:21:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: Add MXLEN check for F/D/Q applies to
 zama16b
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-3-zhiwei_liu@linux.alibaba.com>
 <e565894d-8378-4dbe-92ef-afd54d864810@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <e565894d-8378-4dbe-92ef-afd54d864810@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/8/2 13:47, Richard Henderson wrote:
> On 8/2/24 13:16, LIU Zhiwei wrote:
>> Zama16b loads and stores of no more than MXLEN bits defined in the F, 
>> D, and Q
>> extensions.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   target/riscv/insn_trans/trans_rvd.c.inc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc 
>> b/target/riscv/insn_trans/trans_rvd.c.inc
>> index 2be037930a..dbe508c7e0 100644
>> --- a/target/riscv/insn_trans/trans_rvd.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
>> @@ -52,7 +52,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>>        * in the F, D, and Q extensions. Otherwise, it falls through 
>> to default
>>        * MO_ATOM_IFALIGN.
>>        */
>> -    if ((ctx->xl >= MXL_RV64) && (ctx->cfg_ptr->ext_zama16b)) {
>> +    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>>           memop |= MO_ATOM_WITHIN16;
>>       }
>>   @@ -72,7 +72,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>>       REQUIRE_FPU;
>>       REQUIRE_EXT(ctx, RVD);
>>   -    if (ctx->cfg_ptr->ext_zama16b) {
>> +    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>>           memop |= MO_ATOM_WITHIN16;
>>       }
>
> I guess this is ok, because MXL cannot currently be changed. But since 
> that is a possible future enhancement, perhaps add a get_mxl(ctx) 
> accessor anyway, for documentation purposes.

OK, I will use it. By the way, the MXL is const now in recently updated 
RISC-V specification.

Thanks，
Zhiwei

>
>
> r~

