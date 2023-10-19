Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D4F7D0392
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaNH-0002ah-7q; Thu, 19 Oct 2023 17:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PA0m=GB=kaod.org=clg@ozlabs.org>)
 id 1qtaNF-0002Zz-CF; Thu, 19 Oct 2023 17:16:09 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PA0m=GB=kaod.org=clg@ozlabs.org>)
 id 1qtaNB-0003QI-6E; Thu, 19 Oct 2023 17:16:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SBL9V6TGQz4x1P;
 Fri, 20 Oct 2023 08:15:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBL9H6jfjz4xc1;
 Fri, 20 Oct 2023 08:15:47 +1100 (AEDT)
Message-ID: <f5245b42-2a0a-430c-b10c-e9d3530af80b@kaod.org>
Date: Thu, 19 Oct 2023 23:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
Content-Language: en-US
To: Greg Kurz <groug@kaod.org>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Corey Minyard <minyard@acm.org>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Halil Pasic <pasic@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com> <20231019224935.03232495@bahia>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231019224935.03232495@bahia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=PA0m=GB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/19/23 22:49, Greg Kurz wrote:
> Hi Juan,
> 
> On Thu, 19 Oct 2023 21:08:25 +0200
> Juan Quintela <quintela@redhat.com> wrote:
> 
>> Current code does:
>> - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
>>    dependinfg on cpu number
>> - for newer machines, it register vmstate_icp with "icp/server" name
>>    and instance 0
>> - now it unregisters "icp/server" for the 1st instance.
>>
> 
> Heh I remember about this hack... it was caused by some rework in
> the interrupt controller that broke migration.
> 
>> This is wrong at many levels:
>> - we shouldn't have two VMSTATEDescriptions with the same name
> 
> I don't know how bad it is. The idea here is to send extra
> state in the stream because older QEMU expect it (but won't use
> it), so it made sense to keep the same name.
> 
>> - In case this is the only solution that we can came with, it needs to
>>    be:
>>    * register pre_2_10_vmstate_dummy_icp
>>    * unregister pre_2_10_vmstate_dummy_icp
>>    * register real vmstate_icp
>>
>> As the initialization of this machine is already complex enough, I
>> need help from PPC maintainers to fix this.
>>
> 
> What about dropping all this code, i.e. basically reverting 46f7afa37096 ("spapr:
> fix migration of ICPState objects from/to older QEMU") ?

I'd vote for removing the dummy ICP states for pre-2.10 pseries machines.
Migration compatibility would be broken for these old versions but, with
a clear error report, it should be more than enough. I doubt anyone will
need such a feature now days.

C.


> Unless we still care to migrate pseries machine types from 2017 of
> course...
> 
>> Volunteers?
>>
> 
> Not working on PPC anymore since almost two years, I certainly don't have time,
> nor motivation to fix this. I might be able to answer some questions or to
> review someone else's patch that gets rid of the offending code, at best.
> 
> Cheers,
> 
> --
> Greg
> 
> 
>> CC: Cedric Le Goater <clg@kaod.org>
>> CC: Daniel Henrique Barboza <danielhb413@gmail.com>
>> CC: David Gibson <david@gibson.dropbear.id.au>
>> CC: Greg Kurz <groug@kaod.org>
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   hw/ppc/spapr.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index cb840676d3..8531d13492 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -143,7 +143,12 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
>>   }
>>   
>>   static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
>> -    .name = "icp/server",
>> +    /*
>> +     * Hack ahead.  We can't have two devices with the same name and
>> +     * instance id.  So I rename this to pass make check.
>> +     * Real help from people who knows the hardware is needed.
>> +     */
>> +    .name = "pre-2.10-icp/server",
>>       .version_id = 1,
>>       .minimum_version_id = 1,
>>       .needed = pre_2_10_vmstate_dummy_icp_needed,
> 
> 
> 


