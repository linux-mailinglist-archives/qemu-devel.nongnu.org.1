Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADBA82F333
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 18:30:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPnFa-0008Mn-I7; Tue, 16 Jan 2024 12:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rPnFX-0008Lu-07; Tue, 16 Jan 2024 12:29:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rPnFU-0005oh-NI; Tue, 16 Jan 2024 12:29:18 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDwsh44qtz6J9xb;
 Wed, 17 Jan 2024 01:26:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 30B94140135;
 Wed, 17 Jan 2024 01:29:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Jan
 2024 17:29:09 +0000
Date: Tue, 16 Jan 2024 17:29:07 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/arm: Fix VNCR fault detection logic
Message-ID: <20240116172907.00003e6d@Huawei.com>
In-Reply-To: <20240116165605.2523055-1-peter.maydell@linaro.org>
References: <20240116165605.2523055-1-peter.maydell@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 16 Jan 2024 16:56:05 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> In arm_deliver_fault() we check for whether the fault is caused
> by a data abort due to an access to a FEAT_NV2 sysreg in the
> memory pointed to by the VNCR. Unfortunately part of the
> condition checks the wrong argument to the function, meaning
> that it would spuriously trigger, resulting in some instruction
> aborts being taken to the wrong EL and reported incorrectly.
> 
> Use the right variable in the condition.
> 
> Fixes: 674e5345275d425 ("target/arm: Report VNCR_EL2 based faults correctly")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Matches what I have locally from discussion earlier.

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks

> ---
> In less lax languages the compiler might have pointed out that
> the type of the LHS and the RHS in the comparison didn't match :-)
> ---
>  target/arm/tcg/tlb_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index dd5de74ffb7..5477c7fb7dc 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -184,7 +184,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
>       * (and indeed syndrome does not have the EC field in it,
>       * because we masked that out in disas_set_insn_syndrome())
>       */
> -    bool is_vncr = (mmu_idx != MMU_INST_FETCH) &&
> +    bool is_vncr = (access_type != MMU_INST_FETCH) &&
>          (env->exception.syndrome & ARM_EL_VNCR);
>  
>      if (is_vncr) {


