Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF057943273
	for <lists+qemu-devel@lfdr.de>; Wed, 31 Jul 2024 16:50:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAe2-0002en-OJ; Wed, 31 Jul 2024 10:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZOnj=O7=kaod.org=clg@ozlabs.org>)
 id 1sZAe0-0002aS-Pm; Wed, 31 Jul 2024 10:49:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZOnj=O7=kaod.org=clg@ozlabs.org>)
 id 1sZAdx-0005br-Up; Wed, 31 Jul 2024 10:49:36 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WYw3Y1Xllz4wZx;
 Thu,  1 Aug 2024 00:49:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WYw3V304Vz4wcl;
 Thu,  1 Aug 2024 00:49:26 +1000 (AEST)
Message-ID: <ceba3fd8-ac6b-4b84-ad1d-5854a0caf3eb@kaod.org>
Date: Wed, 31 Jul 2024 16:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/ppc: Implement -dtb support for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20240731132235.887918-1-adityag@linux.ibm.com>
 <Zqo9SOG_t-iI9xW4@redhat.com>
 <fenybu4ixflehyc64kt4s73nqderhkl6xcik5gvgopot23dg75@e4asgghuctp3>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <fenybu4ixflehyc64kt4s73nqderhkl6xcik5gvgopot23dg75@e4asgghuctp3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZOnj=O7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/31/24 15:51, Aditya Gupta wrote:
> Hi Daniel,
> 
> Thank you for the review.
> 
> On 24/07/31 02:34PM, Daniel P. Berrangé wrote:
>> On Wed, Jul 31, 2024 at 06:52:35PM +0530, Aditya Gupta wrote:
>>> Currently any device tree passed with -dtb option in QEMU, was ignored
>>> by the PowerNV code.
>>>
>>> Read and pass the passed -dtb to the kernel, thus enabling easier
>>> debugging with custom DTBs.
>>>
>>> The existing behaviour when -dtb is 'not' passed, is preserved as-is.
>>>
>>> But when a '-dtb' is passed, it completely overrides any dtb nodes or
>>> changes QEMU might have done, such as '-append' arguments to the kernel
>>> (which are mentioned in /chosen/bootargs in the dtb), hence add warning
>>> when -dtb is being used
>>>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>>
>>> ---
>>> This is an RFC patch, and hence might not be the final implementation,
>>> though this current one is a solution which works
>>> ---
>>> ---
>>>   hw/ppc/pnv.c | 29 ++++++++++++++++++++++++++---
>>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 3526852685b4..12cc909b9e26 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -714,6 +714,8 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
>>>       PnvMachineState *pnv = PNV_MACHINE(machine);
>>>       IPMIBmc *bmc;
>>>       void *fdt;
>>> +    FILE *fdt_file;
>>> +    uint32_t fdt_size;
>>>   
>>>       qemu_devices_reset(reason);
>>>   
>>> @@ -736,10 +738,31 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
>>>           }
>>>       }
>>>   
>>> -    fdt = pnv_dt_create(machine);
>>> +    if (machine->dtb) {
>>> +        warn_report("with manually passed dtb, some options like '-append'"
>>> +                " might ignored and the dtb passed will be used as-is");
>>
>> Check whether append is actually set, and report an fatal error in
>> that case.
> 
> Got it.

and this check should be done preferably when the machine is initialized,
not in the reset handler.

Thanks,

C.


