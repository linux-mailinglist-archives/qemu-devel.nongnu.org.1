Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9357F44C4
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 12:17:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5lDx-0006MV-Ft; Wed, 22 Nov 2023 06:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=osAF=HD=kaod.org=clg@ozlabs.org>)
 id 1r5lDm-0006Ej-LC; Wed, 22 Nov 2023 06:16:44 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=osAF=HD=kaod.org=clg@ozlabs.org>)
 id 1r5lDk-0002sM-LN; Wed, 22 Nov 2023 06:16:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZzGC5Bh0z4wby;
 Wed, 22 Nov 2023 22:16:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZzG93K0Mz4xVt;
 Wed, 22 Nov 2023 22:16:33 +1100 (AEDT)
Message-ID: <ff31e537-0f32-4d00-82fa-b9ff5d86c787@kaod.org>
Date: Wed, 22 Nov 2023 12:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ppc/spapr: Introduce SPAPR_NR_IPIS to refer IRQ
 range for CPU IPIs.
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-2-harshpb@linux.ibm.com>
 <ebc45ef8-1745-459d-a904-630d041c366e@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <ebc45ef8-1745-459d-a904-630d041c366e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=osAF=HD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/22/23 12:13, Philippe Mathieu-Daudé wrote:
> Hi Harsh,
> 
> On 22/11/23 10:28, Harsh Prateek Bora wrote:
>> spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
>> the range of CPU IPIs during initialization of nr-irqs property.
>> It is more appropriate to have its own define which can be further
>> reused as appropriate for correct interpretation.
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Suggested-by: Cedric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/spapr_irq.c         | 4 ++--
>>   include/hw/ppc/spapr_irq.h | 1 +
>>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> 
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index c22a72c9e2..e7a80a8349 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -28,6 +28,7 @@
>>   #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
>>   #define SPAPR_NR_XIRQS       0x1000
>> +#define SPAPR_NR_IPIS        0x1000
> 
> BTW why hexadecimal and not decimal?

I think because the HW IRQs are displayed in hex under Linux. Probably.
It has been a while.

Thanks,

C.



