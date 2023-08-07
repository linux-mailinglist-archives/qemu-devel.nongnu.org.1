Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D297729F1
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:59:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2d1-0008O4-BW; Mon, 07 Aug 2023 11:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qT2cu-000848-1f
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:58:36 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qT2cr-0002oG-0l
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:58:35 -0400
Received: from [172.20.10.3] (unknown [112.97.81.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 2543E43AF2;
 Mon,  7 Aug 2023 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691423909; bh=3z0mOSuZP+giOYzjKqoMDNeYc4CYZsNesO0TLLeO6xA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Tq7QZeS4uH09QE3eMZCfi9gB9S9U7+qB5HOzJe6haVwwnSXoBEIv+I7irkQbAgz/j
 H+fbzhBTfkYaokKlcPx8TS138SUWTh15W40h+WWIQ2ESv4wf/MZ86yLTV9UWFvBVip
 Eb58J+rJ3m8CVsERCWn/1BWBDDtc1erFh5xCytY8=
Message-ID: <24159c58-e1e9-2ef3-2599-12def695bd45@jia.je>
Date: Mon, 7 Aug 2023 23:58:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/6] Add loongarch32 mode for loongarch64-softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230807094505.2030603-1-c@jia.je>
 <29e320c8-b95b-2188-a250-0eb5a19708da@linaro.org>
 <f9dc0f47-ab22-0227-7ecb-ba7530609888@jia.je>
 <0d03142e-3546-9cc9-e0c3-37ead0e63717@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <0d03142e-3546-9cc9-e0c3-37ead0e63717@linaro.org>
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


On 2023/8/7 23:56, Richard Henderson wrote:
> On 8/7/23 08:43, Jiajie Chen wrote:
>>> There are changes missing for the translator.
>>>
>>> All of the doubleword (D) instructions must be rejected in LA32 mode.
>> I was trying to do this, but I failed to figure out how to read the 
>> current cpucfg when translating instructions to TCP ops. This problem 
>> applies to the mode-specific behavior below: VA32L1, BL, JIRL, 
>> PCADD*, PWCH etc.
>
> Because the CPUCFG values are constant, you may read them in 
> loongarch_tr_init_disas_context and save the value in DisasContext.  
> This is sufficient for LA32 vs LA64.
>
> But virtual address width should be in HW_FLAGS and may be read from 
> ctx->base.tb->flags. You may wish to simplify usage throughout the 
> translation routines by extracting a 'bool va32' in 
> loongarch_tr_init_disas_context.
Thank you very much, I will rewrite the code to use this approach.
>
>
> r~

