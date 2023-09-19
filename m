Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2E47A5D53
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWdu-0003K0-Ml; Tue, 19 Sep 2023 05:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiWdq-0003DI-Ah; Tue, 19 Sep 2023 05:03:35 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiWdo-0003l5-7C; Tue, 19 Sep 2023 05:03:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RqbKy3V28z4xQM;
 Tue, 19 Sep 2023 19:03:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqbKw0Jgvz4xQT;
 Tue, 19 Sep 2023 19:03:15 +1000 (AEST)
Message-ID: <752e55c4-0a81-3f7e-905e-53f89674dfdd@kaod.org>
Date: Tue, 19 Sep 2023 11:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] pnv/psi: Clean up local variable shadowing
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-3-clg@kaod.org>
 <01ba6d06-79ae-18a3-5835-a364cadbb9fd@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <01ba6d06-79ae-18a3-5835-a364cadbb9fd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=UaPf=FD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/19/23 08:57, Harsh Prateek Bora wrote:
> 
> 
> On 9/18/23 20:28, Cédric Le Goater wrote:
>> to fix :
>>
>>    ../hw/ppc/pnv_psi.c: In function ‘pnv_psi_p9_mmio_write’:
>>    ../hw/ppc/pnv_psi.c:741:24: warning: declaration of ‘addr’ shadows a parameter [-Wshadow=compatible-local]
>>      741 |                 hwaddr addr = val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
>>          |                        ^~~~
>>    ../hw/ppc/pnv_psi.c:702:56: note: shadowed declaration is here
>>      702 | static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
>>          |                                                 ~~~~~~~^~~~
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/pnv_psi.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
>> index daaa2f0575fd..26460d210deb 100644
>> --- a/hw/ppc/pnv_psi.c
>> +++ b/hw/ppc/pnv_psi.c
>> @@ -738,8 +738,9 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
>>               }
>>           } else {
>>               if (!(psi->regs[reg] & PSIHB9_ESB_CI_VALID)) {
>> -                hwaddr addr = val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
>> -                memory_region_add_subregion(sysmem, addr,
>> +                hwaddr esb_addr =
> 
> While at it, we may want to move the declaration to the beginning of the function. 

I am more in favor of declaring the variables where they are needed.
I think it is better pratice since it identifies a functional block
which could be move in a external routine at some point if it becomes
too complex.

> Anyways,
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


Thanks,

C.


> 
>> +                    val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
>> +                memory_region_add_subregion(sysmem, esb_addr,
>>                                               &psi9->source.esb_mmio);
>>               }
>>           }


