Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70A82BCA3
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 10:04:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rODSO-00035o-SC; Fri, 12 Jan 2024 04:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rODSM-00035K-FN; Fri, 12 Jan 2024 04:04:02 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rODSJ-00037v-D6; Fri, 12 Jan 2024 04:04:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TBFvY6vwqz4x43;
 Fri, 12 Jan 2024 20:03:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TBFvM6cJDz4wc6;
 Fri, 12 Jan 2024 20:03:43 +1100 (AEDT)
Message-ID: <17419ee0-11f4-4082-bd91-212449ab1da8@kaod.org>
Date: Fri, 12 Jan 2024 10:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org> <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org> <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org> <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org> <ZZ4Qrfis4XHWGN0j@x1n>
 <87cyu9hgit.fsf@pond.sub.org> <ZZ44iQRPrdDpfov7@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <ZZ44iQRPrdDpfov7@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qInK=IW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/10/24 07:26, Peter Xu wrote:
> On Wed, Jan 10, 2024 at 07:03:06AM +0100, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>
>>> On Tue, Jan 09, 2024 at 10:22:31PM +0100, Philippe Mathieu-Daudé wrote:
>>>> Hi Fabiano,
>>>>
>>>> On 9/1/24 21:21, Fabiano Rosas wrote:
>>>>> Cédric Le Goater <clg@kaod.org> writes:
>>>>>
>>>>>> On 1/9/24 18:40, Fabiano Rosas wrote:
>>>>>>> Cédric Le Goater <clg@kaod.org> writes:
>>>>>>>
>>>>>>>> On 1/3/24 20:53, Fabiano Rosas wrote:
>>>>>>>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>>>>>>>
>>>>>>>>>> +Peter/Fabiano
>>>>>>>>>>
>>>>>>>>>> On 2/1/24 17:41, Cédric Le Goater wrote:
>>>>>>>>>>> On 1/2/24 17:15, Philippe Mathieu-Daudé wrote:
>>>>>>>>>>>> Hi Cédric,
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/1/24 15:55, Cédric Le Goater wrote:
>>>>>>>>>>>>> On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> When a MPCore cluster is used, the Cortex-A cores belong the the
>>>>>>>>>>>>>> cluster container, not to the board/soc layer. This series move
>>>>>>>>>>>>>> the creation of vCPUs to the MPCore private container.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Doing so we consolidate the QOM model, moving common code in a
>>>>>>>>>>>>>> central place (abstract MPCore parent).
>>>>>>>>>>>>>
>>>>>>>>>>>>> Changing the QOM hierarchy has an impact on the state of the machine
>>>>>>>>>>>>> and some fixups are then required to maintain migration compatibility.
>>>>>>>>>>>>> This can become a real headache for KVM machines like virt for which
>>>>>>>>>>>>> migration compatibility is a feature, less for emulated ones.
>>>>>>>>>>>>
>>>>>>>>>>>> All changes are either moving properties (which are not migrated)
>>>>>>>>>>>> or moving non-migrated QOM members (i.e. pointers of ARMCPU, which
>>>>>>>>>>>> is still migrated elsewhere). So I don't see any obvious migration
>>>>>>>>>>>> problem, but I might be missing something, so I Cc'ed Juan :>
>>>>>>>>>
>>>>>>>>> FWIW, I didn't spot anything problematic either.
>>>>>>>>>
>>>>>>>>> I've ran this through my migration compatibility series [1] and it
>>>>>>>>> doesn't regress aarch64 migration from/to 8.2. The tests use '-M
>>>>>>>>> virt -cpu max', so the cortex-a7 and cortex-a15 are not covered. I don't
>>>>>>>>> think we even support migration of anything non-KVM on arm.
>>>>>>>>
>>>>>>>> it happens we do.
>>>>>>>>
>>>>>>>
>>>>>>> Oh, sorry, I didn't mean TCG here. Probably meant to say something like
>>>>>>> non-KVM-capable cpus, as in 32-bit. Nevermind.
>>>>>>
>>>>>> Theoretically, we should be able to migrate to a TCG guest. Well, this
>>>>>> worked in the past for PPC. When I was doing more KVM related changes,
>>>>>> this was very useful for dev. Also, some machines are partially emulated.
>>>>>> Anyhow I agree this is not a strong requirement and we often break it.
>>>>>> Let's focus on KVM only.
>>>>>>
>>>>>>>>> 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
>>>>>>>>
>>>>>>>> yes it depends on the QOM hierarchy and virt seems immune to the changes.
>>>>>>>> Good.
>>>>>>>>
>>>>>>>> However, changing the QOM topology clearly breaks migration compat,
>>>>>>>
>>>>>>> Well, "clearly" is relative =) You've mentioned pseries and aspeed
>>>>>>> already, do you have a pointer to one of those cases were we broke
>>>>>>> migration
>>>>>>
>>>>>> Regarding pseries, migration compat broke because of 5bc8d26de20c
>>>>>> ("spapr: allocate the ICPState object from under sPAPRCPUCore") which
>>>>>> is similar to the changes proposed by this series, it impacts the QOM
>>>>>> hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
>>>>>> ("spapr: fix migration of ICPState objects from/to older QEMU") which
>>>>>> is quite an headache and this turned out to raise another problem some
>>>>>> months ago ... :/ That's why I sent [1] to prepare removal of old
>>>>>> machines and workarounds becoming a burden.
>>>>>
>>>>> This feels like something that could be handled by the vmstate code
>>>>> somehow. The state is there, just under a different path.
>>>>
>>>> What, the QOM path is used in migration? ...
>>>
>>> Hopefully not..
>>>
>>>>
>>>> See recent discussions on "QOM path stability":
>>>> https://lore.kernel.org/qemu-devel/ZZfYvlmcxBCiaeWE@redhat.com/
>>>> https://lore.kernel.org/qemu-devel/87jzojbxt7.fsf@pond.sub.org/
>>>> https://lore.kernel.org/qemu-devel/87v883by34.fsf@pond.sub.org/
>>>
>>> If I read it right, the commit 46f7afa37096 example is pretty special that
>>> the QOM path more or less decided more than the hierachy itself but changes
>>> the existances of objects.
>>
>> Let's see whether I got this...
>>
>> We removed some useless objects, moved the useful ones to another home.
>> The move changed their QOM path.
>>
>> The problem was the removal of useless objects, because this also
>> removed their vmstate.
>>
>> The fix was adding the vmstate back as a dummy.
>>
>> The QOM patch changes are *not* part of the problem.
>>
>> Correct?
> 
> [I'd leave this to Cedric]
> 
>>
>>>>> No one wants
>>>>> to be policing QOM hierarchy changes in every single series that shows
>>>>> up on the list.
>>>>>
>>>>> Anyway, thanks for the pointers. I'll study that code a bit more, maybe
>>>>> I can come up with some way to handle these cases.
>>>>>
>>>>> Hopefully between the analyze-migration test and the compat tests we'll
>>>>> catch the next bug of this kind before it gets merged.
>>>
>>> Things like that might be able to be detected via vmstate-static-checker.py.
>>> But I'm not 100% sure, also its coverage is limited.
>>>
>>> For example, I don't think it can detect changes to objects that will only
>>> be created dynamically, e.g., I think sometimes we create objects after
>>> some guest behaviors (consider guest enables the device, then QEMU
>>> emulation creates some objects on demand of device setup?),
>>
>> Feels nuts to me.
>>
>> In real hardware, software enabling a device that is disabled by default
>> doesn't create the device.  The device is always there, it just happens
>> to be inactive unless enabled.  We should model the device just like
>> that.
> 
> It doesn't need to be the device itself to be dynamically created, but some
> other sub-objects that do not require to exist until the device is enabled,
> or some specific function of that device is enabled.  It is logically doable.
> 
> Is the example Cedric provided looks like some case like this?  I am not
> sure, that's also why I'm not sure the static checker would work here.  But
> logically it seems possible, e.g. with migration VMSD needed() facilities.
> Consider a device has a sub-function that requires a sub-object.  It may
> not need to migrate that object if that sub-feature is not even enabled.
> If that object is very large, it might be wise to do so if possible to not
> send chunks of junk during the VM downtime.
> 
> But then after a 2nd thought I do agree it's probably not sensible, because
> even if the src may know whether the sub-object will be needed, there's
> probably no good way for the dest QEMU to know.  It can only know in
> something like a post_load() hook, but logically that can happen only after
> a full load of that device state, so might already be too late.

If features can be dynamically enabled by the OS, after negotiation
with the platform, the source should prepare for all possible
scenarios and migrate all models supported for a given configuration.
The OS could choose to enable a feature on the target which was not
enabled on the source before migration.

Thanks,

C.


