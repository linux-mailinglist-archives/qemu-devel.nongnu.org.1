Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3616E82BF49
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:35:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFnj-0007k5-0Z; Fri, 12 Jan 2024 06:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOFnb-0007jn-Qq; Fri, 12 Jan 2024 06:34:07 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOFnZ-0006Oa-4R; Fri, 12 Jan 2024 06:34:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TBKDk2rZDz4wy9;
 Fri, 12 Jan 2024 22:33:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TBKDf1mMVz4wcc;
 Fri, 12 Jan 2024 22:33:53 +1100 (AEDT)
Message-ID: <45fb3790-df2a-49f5-860e-46d4f9b0150c@kaod.org>
Date: Fri, 12 Jan 2024 12:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/ppc/cpu-models: Rename power5+ and power7+ for
 new QOM naming rules
To: Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240111164652.908182-1-thuth@redhat.com>
 <20240111164652.908182-2-thuth@redhat.com>
 <70fae07d-f6c1-4143-b632-a988ae53ccb0@linux.ibm.com>
 <27a311a8-f6db-48ea-8bbd-a09eb3c2e07e@redhat.com>
 <54b6ba59-8edc-4b9c-bd3f-88399127f60e@linux.ibm.com>
 <12a5e758-f144-40c2-bcb3-14855b81b7a4@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <12a5e758-f144-40c2-bcb3-14855b81b7a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=qInK=IW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 1/12/24 11:55, Thomas Huth wrote:
> On 12/01/2024 06.21, Harsh Prateek Bora wrote:
>>
>>
>> On 1/12/24 10:42, Thomas Huth wrote:
>>> On 12/01/2024 05.57, Harsh Prateek Bora wrote:
>>>>
>>>>
>>>> On 1/11/24 22:16, Thomas Huth wrote:
>>>>> The character "+" is now forbidden in QOM device names (see commit
>>>>> b447378e1217 - "Limit type names to alphanumerical and some few special
>>>>> characters"). For the "power5+" and "power7+" CPU names, there is
>>>>> currently a hack in type_name_is_valid() to still allow them for
>>>>> compatibility reasons. However, there is a much nicer solution for this:
>>>>> Simply use aliases! This way we can still support the old names without
>>>>> the need for the ugly hack in type_name_is_valid().
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>   hw/ppc/spapr_cpu_core.c |  4 ++--
>>>>>   qom/object.c            |  4 ----
>>>>>   target/ppc/cpu-models.c | 10 ++++++----
>>>>>   3 files changed, 8 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>>>>> index 5aa1ed474a..214b7a03d8 100644
>>>>> --- a/hw/ppc/spapr_cpu_core.c
>>>>> +++ b/hw/ppc/spapr_cpu_core.c
>>>>> @@ -389,9 +389,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>>>>>       DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
>>>>>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
>>>>>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
>>>>> -    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
>>>>> +    DEFINE_SPAPR_CPU_CORE_TYPE("power5plus_v2.1"),
>>>>>       DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
>>>>> -    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
>>>>> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7plus_v2.1"),
>>>>
>>>> Will using Power5x, Power7x be a better naming than using 'plus' suffix ?
>>>
>>> The "x" looks like a placeholder to me, so it could be confused with power50, power51, power52, etc. ...?
>>> But actually, I was thinking about using "power5p" and "power7p" first, so if the whole "plus" looks too long for you, would "p" be an option instead?
>>
>> Hmm .. I would certainly vote for 'p' over 'plus'.
> 
> Ok, I don't mind either way ... does anybody else have any preferences?

p is fine.


Thanks,

C.




