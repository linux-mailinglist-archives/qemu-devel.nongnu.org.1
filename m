Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD097E581
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Sep 2024 06:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssazJ-0007Iy-W5; Mon, 23 Sep 2024 00:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1ssazG-0007HG-11; Mon, 23 Sep 2024 00:47:50 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1ssazD-0005Pe-97; Mon, 23 Sep 2024 00:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1727066854; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=kxhh9s+5tBWKzOSw7z0mWEfmZte4xbou4jJc687yGUQ=;
 b=onJKN16j/e4Ux5DQjCpVpCprBpchtfmElm/AyNdDzY2NyNkMFGXR09j/AZw7oWySEEEU1mTqv9mhOPAj/iFCz4jJOPosq6n0s3/p5fmZlUQ7BRK0ECaCX5nzr5tMP+7F++qOkQtmMJu2SfCE5MSrbMoltiUObiYYFdNsEe3ufJw=
Received: from 30.166.64.122(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WFSQYmX_1727066852) by smtp.aliyun-inc.com;
 Mon, 23 Sep 2024 12:47:33 +0800
Message-ID: <8f4fb8f4-508b-40f0-ac9e-f3f591b5aae5@linux.alibaba.com>
Date: Mon, 23 Sep 2024 12:46:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] tcg/riscv: Add vset{i}vli and ld/st vec ops
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-4-zhiwei_liu@linux.alibaba.com>
 <0dba42ab-83fb-44f8-9802-1f2e53bb89ba@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <0dba42ab-83fb-44f8-9802-1f2e53bb89ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/9/22 12:46, Richard Henderson wrote:
> On 9/11/24 15:26, LIU Zhiwei wrote:
>> @@ -2129,6 +2389,7 @@ static void tcg_target_qemu_prologue(TCGContext 
>> *s)
>>     static void tcg_out_tb_start(TCGContext *s)
>>   {
>> +    s->riscv_cur_type = TCG_TYPE_COUNT;
>>       /* nothing to do */
>>   }
>
> I recently realized that the vector config is call-clobbered.
> We need this reset as well in tcg_out_call_int(), 
OK.
> and prepare_host_addr().
>
> In prepare_host_addr, place the reset just after the two calls to 
> new_ldst_label().

As slow path will also cal tcg_out_call_init, can we only reset after 
tcg_out_call_init?

Thanks,
Zhiwei

>
>
> r~

