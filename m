Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933F82BE9C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:28:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEkO-0006Ss-LQ; Fri, 12 Jan 2024 05:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOEkM-0006SA-SX; Fri, 12 Jan 2024 05:26:42 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOEkK-0004e6-9K; Fri, 12 Jan 2024 05:26:42 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TBHl136t8z4x5k;
 Fri, 12 Jan 2024 21:26:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TBHkt6Cbrz4x7q;
 Fri, 12 Jan 2024 21:26:30 +1100 (AEDT)
Message-ID: <1d58a31b-3a8b-4a56-b9bc-dded024ac7dc@kaod.org>
Date: Fri, 12 Jan 2024 11:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
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
References: <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
 <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org> <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org> <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org> <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org> <ZZ4Qrfis4XHWGN0j@x1n>
 <87cyu9hgit.fsf@pond.sub.org> <874jfl8gwf.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <874jfl8gwf.fsf@suse.de>
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

On 1/10/24 14:19, Fabiano Rosas wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
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
> 
> Unfortunately the original fix doesn't mention _what_ actually broke
> with migration. I assumed the QOM path was needed because otherwise I
> don't think the fix makes sense. The thread discussing that patch also
> directly mentions the QOM path:
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg450912.html
> 
> But I probably misunderstood something while reading that thread.
> 
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
> 
> If you checkout at the removal commit (5bc8d26de20c), the vmstate has
> been kept untouched.
> 
>>
>> The fix was adding the vmstate back as a dummy.
> 
> Since the vmstate was kept I don't see why would we need a dummy. The
> incoming migration stream would still have the state, only at a
> different point in the stream. It's surprising to me that that would
> cause an issue, but I'm not well versed in that code.
> 
>>
>> The QOM patch changes are *not* part of the problem.
> 
> The only explanation I can come up with is that after the patch
> migration has broken after a hotplug or similar operation. In such
> situation, the preallocated state would always be present before the
> patch, but sometimes not present after the patch in case, say, a
> hot-unplug has taken away a cpu + ICPState.

May be. It has been a while.

For a better understanding, I tried to reproduce. QEMU 2.9 still
compiles on a f38 (memfd_create needs a fix). However, a
QEMU-2.9/pseries-2.9 machine won't start any recent OS because
something broke the OS/platform negotiation process (CAS) ...

I removed the pre_2_10_has_unused_icps hack and worked around
another migration compat issue in IOMMU ... Here are the last
trace-events for migration :

     QEMU-mainline/pseries-2.9 -> QEMU-2.9/pseries-2.9

1016464@1705053752.106417:vmstate_load spapr, spapr
1016464@1705053752.106419:vmstate_load_state spapr v3
1016464@1705053752.106421:vmstate_load_state_field spapr:unused
1016464@1705053752.106424:vmstate_load_state_field spapr:rtc_offset
1016464@1705053752.106425:vmstate_load_state_field spapr:tb
1016464@1705053752.106427:vmstate_n_elems tb: 1
1016464@1705053752.106429:vmstate_load_state timebase v1
1016464@1705053752.106432:vmstate_load_state_field timebase:guest_timebase
1016464@1705053752.106433:vmstate_n_elems guest_timebase: 1
1016464@1705053752.106435:vmstate_load_state_field timebase:time_of_the_day_ns
1016464@1705053752.106436:vmstate_n_elems time_of_the_day_ns: 1
1016464@1705053752.106438:vmstate_subsection_load timebase
1016464@1705053752.106440:vmstate_subsection_load_bad timebase: spapr_option_vector_ov5_cas/(prefix)
1016464@1705053752.106442:vmstate_load_state_end timebase end/0
1016464@1705053752.106443:vmstate_subsection_load spapr
1016464@1705053752.106445:vmstate_load_state spapr_option_vector_ov5_cas v1
1016464@1705053752.106447:vmstate_load_state_field spapr_option_vector_ov5_cas:ov5_cas
1016464@1705053752.106448:vmstate_n_elems ov5_cas: 1
1016464@1705053752.106450:vmstate_load_state spapr_option_vector v1
1016464@1705053752.106452:vmstate_load_state_field spapr_option_vector:bitmap
1016464@1705053752.106454:vmstate_n_elems bitmap: 1
1016464@1705053752.106456:vmstate_subsection_load spapr_option_vector
1016464@1705053752.106457:vmstate_subsection_load_bad spapr_option_vector: (short)/
1016464@1705053752.106459:vmstate_load_state_end spapr_option_vector end/0
1016464@1705053752.106461:vmstate_subsection_load spapr_option_vector_ov5_cas
1016464@1705053752.106462:vmstate_subsection_load_bad spapr_option_vector_ov5_cas: (short)/
1016464@1705053752.106465:vmstate_load_state_end spapr_option_vector_ov5_cas end/0
1016464@1705053752.106466:vmstate_subsection_load_bad spapr: spapr/cap/htm/(lookup)
qemu-system-ppc64: error while loading state for instance 0x0 of device 'spapr'


Hope it helps,

Thanks,

C.





