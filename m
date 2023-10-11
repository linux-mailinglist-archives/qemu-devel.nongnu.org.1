Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA077C4875
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 05:27:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqPrm-0003yG-9n; Tue, 10 Oct 2023 23:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qqPri-0003y3-Tn
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 23:26:30 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qqPrf-0006Jy-UH
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 23:26:30 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VtuaBTs_1696994780; 
Received: from 30.221.100.88(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0VtuaBTs_1696994780) by smtp.aliyun-inc.com;
 Wed, 11 Oct 2023 11:26:20 +0800
Message-ID: <4a7e39f4-4302-4dfd-9112-4deea5c7403f@linux.alibaba.com>
Date: Wed, 11 Oct 2023 11:25:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/riscv: Use env_archcpu() in [check_]nanbox()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231009110239.66778-1-philmd@linaro.org>
 <20231009110239.66778-3-philmd@linaro.org>
 <8e8b6cef-efbf-42ac-975c-b523dc24a531@linux.alibaba.com>
 <58838379-60bf-4af4-980b-cff8ee49bfc2@linaro.org>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <58838379-60bf-4af4-980b-cff8ee49bfc2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001,
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


On 2023/10/11 1:04, Richard Henderson wrote:
> On 10/9/23 05:42, LIU Zhiwei wrote:
>>
>> On 2023/10/9 19:02, Philippe Mathieu-Daudé wrote:
>>> When CPUArchState* is available (here CPURISCVState*), we
>>> can use the fast env_archcpu() macro to get ArchCPU* (here
>>> RISCVCPU*). The QOM cast RISCV_CPU() macro will be slower
>>> when building with --enable-qom-cast-debug.
>>>
>>> Inspired-by: Richard W.M. Jones <rjones@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>>
>> By the way, does the community has the plan to support heterogeneous 
>> architecture cpus in one soc?
>
> Yes.

Hi Richard,

It's a good news. Thanks.

>
>> If so, maybe we have to do this qom cast somewhere.
>
> No, I don't think so.  Or at least not in these places.

Yes.  Perhaps, we should remove all RISCV_CPU macros using after the qom 
objects realized.

Do you think we should remove the RISCV_CPU using in 
riscv_cpu_exec_interrupt? Although it  is not so hot. I think there is 
no reason to use it there.
Except this, there are many other places in hw/ and target/riscv using 
the RISCV_CPU macro.

If we know whether we should remove the RISCV_CPU macro use in these 
places, we can do it in another patch.

Thanks,
Zhiwei

>
>
> r~

