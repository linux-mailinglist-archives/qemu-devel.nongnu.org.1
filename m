Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 089397D09A6
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:41:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtk76-0007xD-5R; Fri, 20 Oct 2023 03:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=+bN6=GC=kaod.org=clg@ozlabs.org>)
 id 1qtk70-0007ui-Sr; Fri, 20 Oct 2023 03:40:03 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=+bN6=GC=kaod.org=clg@ozlabs.org>)
 id 1qtk6x-0001aU-My; Fri, 20 Oct 2023 03:40:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SBc1H4lgxz4wd0;
 Fri, 20 Oct 2023 18:39:47 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBc125h03z4xbx;
 Fri, 20 Oct 2023 18:39:34 +1100 (AEDT)
Message-ID: <e6a55f60-dd77-4758-a9e2-0fa5c33a6798@kaod.org>
Date: Fri, 20 Oct 2023 09:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>,
 Juan Quintela <quintela@redhat.com>
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
 Leonardo Bras <leobras@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Halil Pasic
 <pasic@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com> <20231019224935.03232495@bahia>
 <f5245b42-2a0a-430c-b10c-e9d3530af80b@kaod.org>
 <81b1bcb8-4217-4324-8bb5-8edde40a1838@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <81b1bcb8-4217-4324-8bb5-8edde40a1838@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=+bN6=GC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 10/20/23 07:10, Thomas Huth wrote:
> On 19/10/2023 23.15, Cédric Le Goater wrote:
>> On 10/19/23 22:49, Greg Kurz wrote:
>>> Hi Juan,
>>>
>>> On Thu, 19 Oct 2023 21:08:25 +0200
>>> Juan Quintela <quintela@redhat.com> wrote:
>>>
>>>> Current code does:
>>>> - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
>>>>    dependinfg on cpu number
>>>> - for newer machines, it register vmstate_icp with "icp/server" name
>>>>    and instance 0
>>>> - now it unregisters "icp/server" for the 1st instance.
>>>>
>>>
>>> Heh I remember about this hack... it was caused by some rework in
>>> the interrupt controller that broke migration.
>>>
>>>> This is wrong at many levels:
>>>> - we shouldn't have two VMSTATEDescriptions with the same name
>>>
>>> I don't know how bad it is. The idea here is to send extra
>>> state in the stream because older QEMU expect it (but won't use
>>> it), so it made sense to keep the same name.
>>>
>>>> - In case this is the only solution that we can came with, it needs to
>>>>    be:
>>>>    * register pre_2_10_vmstate_dummy_icp
>>>>    * unregister pre_2_10_vmstate_dummy_icp
>>>>    * register real vmstate_icp
>>>>
>>>> As the initialization of this machine is already complex enough, I
>>>> need help from PPC maintainers to fix this.
>>>>
>>>
>>> What about dropping all this code, i.e. basically reverting 46f7afa37096 ("spapr:
>>> fix migration of ICPState objects from/to older QEMU") ?
>>
>> I'd vote for removing the dummy ICP states for pre-2.10 pseries machines.
>> Migration compatibility would be broken for these old versions but, with
>> a clear error report, it should be more than enough. I doubt anyone will
>> need such a feature now days.
> 
> In that case: Please also put the pseries-2.1 machine up to pseries-2.9 onto the deprecation list, so that they can finally get removed after two releases. It does not make sense to keep compat machines around if the compatibility is not available anymore.

This would be a really good cleanup for PPC to deprecate pseries-2.1/2.9.
We did a few workarounds in that time frame which wouldn't be necessary
anymore.

Thanks,

C.



