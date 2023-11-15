Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379857EBD5B
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:09:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A09-00048A-1F; Wed, 15 Nov 2023 02:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3A06-00047u-Jf
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3A05-0007S6-2R
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700032068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2kaJ5V50G415vB1WOnZSfKSNKlS9oSYgPfPDQaB/t7E=;
 b=RznCeRrsQ8dT2KQKC9qU28C+T+sSeKBE3Vv28Ea7vLlfrQ+IIoeCtWWUn7F55+o1EHJnj9
 nh8ixuYd7Hn/jokLqDd20J3S4asQDs0BEpz1sACCxslG/sgzZduKBSThk5SQvRf2hUILF7
 fs9AhmPjQ7UHhz+Rhimj3pnjAp5UZxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-eOokZXyUOFuDAKWnkdfFWA-1; Wed, 15 Nov 2023 02:07:44 -0500
X-MC-Unique: eOokZXyUOFuDAKWnkdfFWA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D2C485A58A;
 Wed, 15 Nov 2023 07:07:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03D5A492BE8;
 Wed, 15 Nov 2023 07:07:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9E6B21E6A1F; Wed, 15 Nov 2023 08:07:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,  Markus Armbruster
 <armbru@redhat.com>,  qemu-devel@nongnu.org,  philmd@linaro.org,
 npiggin@gmail.com,  clg@kaod.org,  david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com,  dave@treblig.org,  jasowang@redhat.com,
 michael.roth@amd.com,  kkostiuk@redhat.com,  mst@redhat.com,
 david@redhat.com,  kraxel@redhat.com,  marcandre.lureau@redhat.com,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 1/7] spapr/pci: Correct "does not support hotplugging
 error messages
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-2-armbru@redhat.com>
 <c69961b0-54c6-4885-bbf4-597727be35fc@gmail.com>
 <937323b3-5293-bdac-48fc-5af5d2c4f8f4@eik.bme.hu>
Date: Wed, 15 Nov 2023 08:07:41 +0100
In-Reply-To: <937323b3-5293-bdac-48fc-5af5d2c4f8f4@eik.bme.hu> (BALATON
 Zoltan's message of "Wed, 1 Nov 2023 22:11:13 +0100 (CET)")
Message-ID: <87fs17trya.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Wed, 1 Nov 2023, Daniel Henrique Barboza wrote:
>> On 10/31/23 08:10, Markus Armbruster wrote:
>>> When dynamic-reconfiguration is off, hot plug / unplug can fail with
>>> "Bus 'spapr-pci-host-bridge' does not support hotplugging".
>>> spapr-pci-host-bridge is a device, not a bus.  Report the name of the
>>> bus it provides instead: 'pci.0'.
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>
>> Feel free to queue it up. Thanks,
>>
>>
>> Daniel
>>
>>>   hw/ppc/spapr_pci.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>>> index 370c5a90f2..ebb32ad90b 100644
>>> --- a/hw/ppc/spapr_pci.c
>>> +++ b/hw/ppc/spapr_pci.c
>>> @@ -1551,7 +1551,7 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
>>>            */
>>>           if (plugged_dev->hotplugged) {
>>>               error_setg(errp, QERR_BUS_NO_HOTPLUG,
>>> -                       object_get_typename(OBJECT(phb)));
>>> +                       phb->parent_obj.bus->qbus.name);
>
> I could not find it mentioned in the docs but it was said the parent pointer is private and one should not access it but cast to the parent object instead. Or here may even use pci_get_bus(pdev) maybe after moving the asserts before it to make sure the device is valid. But I don't mind so you can commit it as it is if nobody notices.

pci_get_bus() returns the bus the device is plugged into as a PCI bus.
We need the bus the device provides.  Besides, @phb is plugged into the
main system bus.  pci_get_bus(PCI_DEVICE(phb)) would pass the main
system bus to PCI_BUS(), which is not good.

I can offer

                            PCI_HOST_BRIDGE(phb)->bus->qbus.name);

Looks like a wash to me, but if maintainers like it better, I'll change
to it.

>
> Regards,
> BALATON Zoltan
>
>>>               return;
>>>           }
>>>       }
>>> @@ -1672,7 +1672,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>>>         if (!phb->dr_enabled) {
>>>           error_setg(errp, QERR_BUS_NO_HOTPLUG,
>>> -                   object_get_typename(OBJECT(phb)));
>>> +                   phb->parent_obj.bus->qbus.name);
>>>           return;
>>>       }
>>> 
>>
>>


