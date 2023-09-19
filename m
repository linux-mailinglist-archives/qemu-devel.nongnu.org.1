Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B167A61C2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:54:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZJ4-0007b6-Uh; Tue, 19 Sep 2023 07:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiZJ1-0007Sl-ME; Tue, 19 Sep 2023 07:54:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiZIy-0006vk-WB; Tue, 19 Sep 2023 07:54:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rqg735ZgZz4xNs;
 Tue, 19 Sep 2023 21:54:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rqg713b5cz4wy6;
 Tue, 19 Sep 2023 21:54:05 +1000 (AEST)
Message-ID: <9660dfe4-a0ec-0212-9212-ef49ad63a750@kaod.org>
Date: Tue, 19 Sep 2023 13:54:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] spapr: Clean up local variable shadowing in
 spapr_get_fw_dev_path()
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-6-clg@kaod.org>
 <16ec9b62-9c83-68db-344b-050c9299bec1@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <16ec9b62-9c83-68db-344b-050c9299bec1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=UaPf=FD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
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

On 9/19/23 10:23, Harsh Prateek Bora wrote:
> 
> 
> On 9/18/23 20:28, Cédric Le Goater wrote:
>> Rename PCIDevice variable to avoid this warning :
>>
>>    ../hw/ppc/spapr.c: In function ‘spapr_get_fw_dev_path’:
>>    ../hw/ppc/spapr.c:3217:20: warning: declaration of ‘pcidev’ shadows a previous local [-Wshadow=compatible-local]
>>     3217 |         PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
>>          |                    ^~~~~~
>>    ../hw/ppc/spapr.c:3147:16: note: shadowed declaration is here
>>     3147 |     PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
>>          |                ^~~~~~
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/spapr.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 41ce7de77c14..8090fb0302df 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3214,8 +3214,8 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
>>       if (g_str_equal("pci-bridge", qdev_fw_name(dev))) {
>>           /* SLOF uses "pci" instead of "pci-bridge" for PCI bridges */
>> -        PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
>> -        return g_strdup_printf("pci@%x", PCI_SLOT(pcidev->devfn));
>> +        PCIDevice *pdev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
>> +        return g_strdup_printf("pci@%x", PCI_SLOT(pdev->devfn));
> 
> Instead of renaming, can't we use pcidev itself without re-declaring ?

I agree this could be done. But there is this test below :
  
> 
>>       }
>>       if (pcidev) {

which makes use of the same variable. I would rather keep the same
logic in the code or rewrite the routine completely with something
like:

     if (object_dynamic_cast(OBJECT(dev), TYPE_1 {
         /* return this */
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_2 {
         /* or that */
     } else if (object_dynamic_cast(OBJECT(dev), "some string"))
     ....
     } else {
         error_report("...");
     }

     return NULL;


This is beyond the issue that this patch is trying to fix.

Thanks,

C.

