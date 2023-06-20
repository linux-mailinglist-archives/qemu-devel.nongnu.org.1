Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D70736B6F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:55:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZvj-0005Ur-3s; Tue, 20 Jun 2023 07:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBZvg-0005UT-R9; Tue, 20 Jun 2023 07:53:48 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBZvf-0006Em-3N; Tue, 20 Jun 2023 07:53:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QllQY3TnXz4x0L;
 Tue, 20 Jun 2023 21:53:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QllQX0rLlz4x0G;
 Tue, 20 Jun 2023 21:53:39 +1000 (AEST)
Message-ID: <7027fb61-a02c-3ca0-35c9-27ca80148924@kaod.org>
Date: Tue, 20 Jun 2023 13:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 9/9] target/ppc: Fix timer register accessors when !KVM
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-10-clg@kaod.org>
 <f2731268-004f-74c4-3aa9-24dc0bacf835@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <f2731268-004f-74c4-3aa9-24dc0bacf835@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rj0j=CI=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
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

On 6/20/23 11:10, Richard Henderson wrote:
> On 6/20/23 07:59, Cédric Le Goater wrote:
>> When the Timer Control and Timer Status registers are modified, avoid
>> calling the KVM backend when not available
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   target/ppc/kvm.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index a7f2de9d1018..a8a935e26726 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -1728,6 +1728,10 @@ int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits)
>>           .addr = (uintptr_t) &bits,
>>       };
>> +    if (!kvm_enabled()) {
>> +        return 0;
>> +    }
> 
> assert(kvm_enabled()) ?
> 

Well, the callers store_booke_t[cs]r() can be called from instruction
implementation and from the timer reset handler, which is common to all
accelerators.

This is only important when running some of the emulated BookE machines
on a PPC64 host, which enables KVM. This is not the most common host
config but nevertheless, the machines should run and this fixes it.

Thanks,

C.

