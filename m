Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A84797A6200
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZSz-0004Ka-7P; Tue, 19 Sep 2023 08:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiZSw-0004Je-6x; Tue, 19 Sep 2023 08:04:30 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiZSu-0001MZ-JK; Tue, 19 Sep 2023 08:04:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RqgLv70K9z4xNj;
 Tue, 19 Sep 2023 22:04:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqgLs6m4Vz4xM6;
 Tue, 19 Sep 2023 22:04:21 +1000 (AEST)
Message-ID: <ffa930c1-f8bb-2ab3-b7bd-80e328011069@kaod.org>
Date: Tue, 19 Sep 2023 14:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] spapr/pci: Clean up local variable shadowing in
 spapr_phb_realize()
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-8-clg@kaod.org>
 <6539ab03-b630-91d4-c36b-b74f0757709a@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <6539ab03-b630-91d4-c36b-b74f0757709a@linux.ibm.com>
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

On 9/19/23 10:38, Harsh Prateek Bora wrote:
> 
> 
> On 9/18/23 20:28, Cédric Le Goater wrote:
>> Rename SysBusDevice variable to avoid this warning :
>>
>>    ../hw/ppc/spapr_pci.c: In function ‘spapr_phb_realize’:
>>    ../hw/ppc/spapr_pci.c:1872:24: warning: declaration of ‘s’ shadows a previous local [-Wshadow=local]
>>     1872 |         SpaprPhbState *s;
>>          |                        ^
>>    ../hw/ppc/spapr_pci.c:1829:19: note: shadowed declaration is here
>>     1829 |     SysBusDevice *s = SYS_BUS_DEVICE(dev);
>>          |                   ^
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/spapr_pci.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index ce1495931744..370c5a90f218 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1826,9 +1826,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>>           (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
>>                                                     TYPE_SPAPR_MACHINE);
>>       SpaprMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
>> -    SysBusDevice *s = SYS_BUS_DEVICE(dev);
>> -    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
>> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(sbd);
> 
> Declaration of SpaprPhbState *s later in the code could be brought here?

nah. 's' is really local. It could be even called 'tmp' IMO.

Thanks,

C.


> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
>> +    PCIHostState *phb = PCI_HOST_BRIDGE(sbd);
>>       MachineState *ms = MACHINE(spapr);
>>       char *namebuf;
>>       int i;


