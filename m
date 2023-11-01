Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0A7DE749
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 22:11:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyIUa-0007ji-Ku; Wed, 01 Nov 2023 17:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyIUY-0007jK-8T; Wed, 01 Nov 2023 17:11:10 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyIUV-000751-W5; Wed, 01 Nov 2023 17:11:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 79939756082;
 Wed,  1 Nov 2023 22:11:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4248E756078; Wed,  1 Nov 2023 22:11:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4041075606C;
 Wed,  1 Nov 2023 22:11:13 +0100 (CET)
Date: Wed, 1 Nov 2023 22:11:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 philmd@linaro.org, npiggin@gmail.com, clg@kaod.org, 
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org, 
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com, 
 mst@redhat.com, david@redhat.com, kraxel@redhat.com, 
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Subject: Re: [PATCH 1/7] spapr/pci: Correct "does not support hotplugging
 error messages
In-Reply-To: <c69961b0-54c6-4885-bbf4-597727be35fc@gmail.com>
Message-ID: <937323b3-5293-bdac-48fc-5af5d2c4f8f4@eik.bme.hu>
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-2-armbru@redhat.com>
 <c69961b0-54c6-4885-bbf4-597727be35fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 1 Nov 2023, Daniel Henrique Barboza wrote:
> On 10/31/23 08:10, Markus Armbruster wrote:
>> When dynamic-reconfiguration is off, hot plug / unplug can fail with
>> "Bus 'spapr-pci-host-bridge' does not support hotplugging".
>> spapr-pci-host-bridge is a device, not a bus.  Report the name of the
>> bus it provides instead: 'pci.0'.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>
> Feel free to queue it up. Thanks,
>
>
> Daniel
>
>>   hw/ppc/spapr_pci.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 370c5a90f2..ebb32ad90b 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1551,7 +1551,7 @@ static void spapr_pci_pre_plug(HotplugHandler 
>> *plug_handler,
>>            */
>>           if (plugged_dev->hotplugged) {
>>               error_setg(errp, QERR_BUS_NO_HOTPLUG,
>> -                       object_get_typename(OBJECT(phb)));
>> +                       phb->parent_obj.bus->qbus.name);

I could not find it mentioned in the docs but it was said the parent 
pointer is private and one should not access it but cast to the parent 
object instead. Or here may even use pci_get_bus(pdev) maybe after moving 
the asserts before it to make sure the device is valid. But I don't mind 
so you can commit it as it is if nobody notices.

Regards,
BALATON Zoltan

>>               return;
>>           }
>>       }
>> @@ -1672,7 +1672,7 @@ static void spapr_pci_unplug_request(HotplugHandler 
>> *plug_handler,
>>         if (!phb->dr_enabled) {
>>           error_setg(errp, QERR_BUS_NO_HOTPLUG,
>> -                   object_get_typename(OBJECT(phb)));
>> +                   phb->parent_obj.bus->qbus.name);
>>           return;
>>       }
>> 
>
>

