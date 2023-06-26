Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34C73ED0B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 23:46:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDu1l-00086J-NG; Mon, 26 Jun 2023 17:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDu1j-00085e-4o; Mon, 26 Jun 2023 17:45:39 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDu1h-0001qC-9k; Mon, 26 Jun 2023 17:45:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqhGg5gFLz4wZv;
 Tue, 27 Jun 2023 07:45:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqhGd2XCxz4wZr;
 Tue, 27 Jun 2023 07:45:28 +1000 (AEST)
Message-ID: <ecca1867-4308-5218-a5f6-9b0a93756f72@kaod.org>
Date: Mon, 26 Jun 2023 23:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 10/30] ppc/spapr: H_ENTER_NESTED should restore host XER ca
 field
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230626055647.1147743-1-clg@kaod.org>
 <20230626055647.1147743-11-clg@kaod.org>
 <eb1c3b7c-5f50-7e25-ec99-3f84013e76c4@tls.msk.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <eb1c3b7c-5f50-7e25-ec99-3f84013e76c4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/26/23 14:26, Michael Tokarev wrote:
> 26.06.2023 08:56, Cédric Le Goater wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> Fix missing env->ca restore when going from L2 back to the host.
>>
>> Fixes: 120f738a467 ("spapr: implement nested-hv capability for the virtual hypervisor")
>> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/spapr_hcall.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index b9047555757f..0582b524d108 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1773,6 +1773,7 @@ out_restore_l1:
>>       env->cfar = spapr_cpu->nested_host_state->cfar;
>>       env->xer = spapr_cpu->nested_host_state->xer;
>>       env->so = spapr_cpu->nested_host_state->so;
>> +    env->ca = spapr_cpu->nested_host_state->ca;
>>       env->ov = spapr_cpu->nested_host_state->ov;
>>       env->ov32 = spapr_cpu->nested_host_state->ov32;
>>       env->ca32 = spapr_cpu->nested_host_state->ca32;
> 
> Is it -stable material too, or don't bother?
> 120f738a467 is 7.0.

I would say so. The CPU is missing state (Carry bit) when restoring context,
it could be important for some instructions.

Nick, did you have specific test case ?

Thanks,

C.


