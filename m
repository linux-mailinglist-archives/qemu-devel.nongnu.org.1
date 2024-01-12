Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521482C60E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 20:55:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rONby-0005EA-Ov; Fri, 12 Jan 2024 14:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rONbv-0005De-6a; Fri, 12 Jan 2024 14:54:35 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rONbs-00051I-8v; Fri, 12 Jan 2024 14:54:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12F0121A61;
 Fri, 12 Jan 2024 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705089267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9lR4FF2XvVBDHSLk9YaBEPtCYlCK1uKX6T1qbRuZhE=;
 b=To6BzbsNJoiOX+WAtNG2LjDzvR5Vf7zcgb+SkzoZ0NBa7ljwVDxmJc8Hel9JvNnHb57YaT
 jlodVOod7FxaoNrmc8x65Wj5NKM9CNJcYvf2Q9K4sK/zeLVBUQmZl4uIC4YF5H4AQt7+GO
 LhSA9T145zWHpoE6+oTohvZenTbSn+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705089267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9lR4FF2XvVBDHSLk9YaBEPtCYlCK1uKX6T1qbRuZhE=;
 b=S5I/8izY4WW098LF8gTaJXU91Ct0d5JsepDAJRN594OfU5/S/DJ7JZVARzdawHoADAFVRV
 tFNQc+4hPRZzCPBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705089267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9lR4FF2XvVBDHSLk9YaBEPtCYlCK1uKX6T1qbRuZhE=;
 b=To6BzbsNJoiOX+WAtNG2LjDzvR5Vf7zcgb+SkzoZ0NBa7ljwVDxmJc8Hel9JvNnHb57YaT
 jlodVOod7FxaoNrmc8x65Wj5NKM9CNJcYvf2Q9K4sK/zeLVBUQmZl4uIC4YF5H4AQt7+GO
 LhSA9T145zWHpoE6+oTohvZenTbSn+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705089267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9lR4FF2XvVBDHSLk9YaBEPtCYlCK1uKX6T1qbRuZhE=;
 b=S5I/8izY4WW098LF8gTaJXU91Ct0d5JsepDAJRN594OfU5/S/DJ7JZVARzdawHoADAFVRV
 tFNQc+4hPRZzCPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8640D136A4;
 Fri, 12 Jan 2024 19:54:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IAFwE/KYoWUUXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Jan 2024 19:54:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, Alex =?utf-8?Q?B?=
 =?utf-8?Q?enn=C3=A9e?= <alex.bennee@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Anton Johansson <anjo@rev.ng>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Igor Mitsyanko
 <i.mitsyanko@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
 <robh@kernel.org>, qemu-arm@nongnu.org, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
In-Reply-To: <1d58a31b-3a8b-4a56-b9bc-dded024ac7dc@kaod.org>
References: <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
 <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org> <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org> <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org> <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org> <ZZ4Qrfis4XHWGN0j@x1n>
 <87cyu9hgit.fsf@pond.sub.org> <874jfl8gwf.fsf@suse.de>
 <1d58a31b-3a8b-4a56-b9bc-dded024ac7dc@kaod.org>
Date: Fri, 12 Jan 2024 16:54:23 -0300
Message-ID: <871qamfhu8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 R_RATELIMIT(0.00)[to_ip_from(RLgn3pipxh44ye66tuwadwbnif)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[24]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linaro.org,nongnu.org,redhat.com,nuvoton.com,habkost.net,jms.id.au,alistair23.me,rev.ng,gmail.com,google.com,tribudubois.net,codeconstruct.com.au,kernel.org,ilande.co.uk];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.60
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 1/10/24 14:19, Fabiano Rosas wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>=20
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Tue, Jan 09, 2024 at 10:22:31PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>>>> Hi Fabiano,
>>>>>
>>>>> On 9/1/24 21:21, Fabiano Rosas wrote:
>>>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>>>
>>>>>>> On 1/9/24 18:40, Fabiano Rosas wrote:
>>>>>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>>>>>
>>>>>>>>> On 1/3/24 20:53, Fabiano Rosas wrote:
>>>>>>>>>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>>>>>>>>>
>>>>>>>>>>> +Peter/Fabiano
>>>>>>>>>>>
>>>>>>>>>>> On 2/1/24 17:41, C=C3=A9dric Le Goater wrote:
>>>>>>>>>>>> On 1/2/24 17:15, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>>>>>>> Hi C=C3=A9dric,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2/1/24 15:55, C=C3=A9dric Le Goater wrote:
>>>>>>>>>>>>>> On 12/12/23 17:29, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> When a MPCore cluster is used, the Cortex-A cores belong th=
e the
>>>>>>>>>>>>>>> cluster container, not to the board/soc layer. This series =
move
>>>>>>>>>>>>>>> the creation of vCPUs to the MPCore private container.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Doing so we consolidate the QOM model, moving common code i=
n a
>>>>>>>>>>>>>>> central place (abstract MPCore parent).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Changing the QOM hierarchy has an impact on the state of the=
 machine
>>>>>>>>>>>>>> and some fixups are then required to maintain migration comp=
atibility.
>>>>>>>>>>>>>> This can become a real headache for KVM machines like virt f=
or which
>>>>>>>>>>>>>> migration compatibility is a feature, less for emulated ones.
>>>>>>>>>>>>>
>>>>>>>>>>>>> All changes are either moving properties (which are not migra=
ted)
>>>>>>>>>>>>> or moving non-migrated QOM members (i.e. pointers of ARMCPU, =
which
>>>>>>>>>>>>> is still migrated elsewhere). So I don't see any obvious migr=
ation
>>>>>>>>>>>>> problem, but I might be missing something, so I Cc'ed Juan :>
>>>>>>>>>>
>>>>>>>>>> FWIW, I didn't spot anything problematic either.
>>>>>>>>>>
>>>>>>>>>> I've ran this through my migration compatibility series [1] and =
it
>>>>>>>>>> doesn't regress aarch64 migration from/to 8.2. The tests use '-M
>>>>>>>>>> virt -cpu max', so the cortex-a7 and cortex-a15 are not covered.=
 I don't
>>>>>>>>>> think we even support migration of anything non-KVM on arm.
>>>>>>>>>
>>>>>>>>> it happens we do.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Oh, sorry, I didn't mean TCG here. Probably meant to say something=
 like
>>>>>>>> non-KVM-capable cpus, as in 32-bit. Nevermind.
>>>>>>>
>>>>>>> Theoretically, we should be able to migrate to a TCG guest. Well, t=
his
>>>>>>> worked in the past for PPC. When I was doing more KVM related chang=
es,
>>>>>>> this was very useful for dev. Also, some machines are partially emu=
lated.
>>>>>>> Anyhow I agree this is not a strong requirement and we often break =
it.
>>>>>>> Let's focus on KVM only.
>>>>>>>
>>>>>>>>>> 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
>>>>>>>>>
>>>>>>>>> yes it depends on the QOM hierarchy and virt seems immune to the =
changes.
>>>>>>>>> Good.
>>>>>>>>>
>>>>>>>>> However, changing the QOM topology clearly breaks migration compa=
t,
>>>>>>>>
>>>>>>>> Well, "clearly" is relative =3D) You've mentioned pseries and aspe=
ed
>>>>>>>> already, do you have a pointer to one of those cases were we broke
>>>>>>>> migration
>>>>>>>
>>>>>>> Regarding pseries, migration compat broke because of 5bc8d26de20c
>>>>>>> ("spapr: allocate the ICPState object from under sPAPRCPUCore") whi=
ch
>>>>>>> is similar to the changes proposed by this series, it impacts the Q=
OM
>>>>>>> hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
>>>>>>> ("spapr: fix migration of ICPState objects from/to older QEMU") whi=
ch
>>>>>>> is quite an headache and this turned out to raise another problem s=
ome
>>>>>>> months ago ... :/ That's why I sent [1] to prepare removal of old
>>>>>>> machines and workarounds becoming a burden.
>>>>>>
>>>>>> This feels like something that could be handled by the vmstate code
>>>>>> somehow. The state is there, just under a different path.
>>>>>
>>>>> What, the QOM path is used in migration? ...
>>>>
>>>> Hopefully not..
>>=20
>> Unfortunately the original fix doesn't mention _what_ actually broke
>> with migration. I assumed the QOM path was needed because otherwise I
>> don't think the fix makes sense. The thread discussing that patch also
>> directly mentions the QOM path:
>>=20
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg450912.html
>>=20
>> But I probably misunderstood something while reading that thread.
>>=20
>>>>
>>>>>
>>>>> See recent discussions on "QOM path stability":
>>>>> https://lore.kernel.org/qemu-devel/ZZfYvlmcxBCiaeWE@redhat.com/
>>>>> https://lore.kernel.org/qemu-devel/87jzojbxt7.fsf@pond.sub.org/
>>>>> https://lore.kernel.org/qemu-devel/87v883by34.fsf@pond.sub.org/
>>>>
>>>> If I read it right, the commit 46f7afa37096 example is pretty special =
that
>>>> the QOM path more or less decided more than the hierachy itself but ch=
anges
>>>> the existances of objects.
>>>
>>> Let's see whether I got this...
>>>
>>> We removed some useless objects, moved the useful ones to another home.
>>> The move changed their QOM path.
>>>
>>> The problem was the removal of useless objects, because this also
>>> removed their vmstate.
>>=20
>> If you checkout at the removal commit (5bc8d26de20c), the vmstate has
>> been kept untouched.
>>=20
>>>
>>> The fix was adding the vmstate back as a dummy.
>>=20
>> Since the vmstate was kept I don't see why would we need a dummy. The
>> incoming migration stream would still have the state, only at a
>> different point in the stream. It's surprising to me that that would
>> cause an issue, but I'm not well versed in that code.
>>=20
>>>
>>> The QOM patch changes are *not* part of the problem.
>>=20
>> The only explanation I can come up with is that after the patch
>> migration has broken after a hotplug or similar operation. In such
>> situation, the preallocated state would always be present before the
>> patch, but sometimes not present after the patch in case, say, a
>> hot-unplug has taken away a cpu + ICPState.
>
> May be. It has been a while.
>
> For a better understanding, I tried to reproduce. QEMU 2.9 still
> compiles on a f38 (memfd_create needs a fix). However, a
> QEMU-2.9/pseries-2.9 machine won't start any recent OS because
> something broke the OS/platform negotiation process (CAS) ...

Thanks for letting us know it still builds. That motivated me to try as
well. Although it took me a while because of python's brokenness.

The issue was indeed the difference in preallocation vs. no
preallocation. I don't remember how to do hotplug in ppc anymore, but
maxcpus was sufficient to reproduce:

src 2.9.0:
$ ./ppc64-softmmu/qemu-system-ppc64 -serial mon:stdio -nographic -vga none
-display none -accel tcg -machine pseries -smp 4,maxcpus=3D8 -m 256M
-nodefaults

dst 2.9.0 prior to 46f7afa:
$ ./ppc64-softmmu/qemu-system-ppc64 -serial mon:stdio -display none
-accel tcg -machine pseries-2.9 -smp 4,maxcpus=3D8 -m 256M -nodefaults
-incoming defer

(qemu) migrate_incoming tcp:localhost:1234
(qemu) qemu-system-ppc64: Unknown savevm section or instance 'icp/server' 4
qemu-system-ppc64: load of migration failed: Invalid argument

As you can see, both use 4 cpus, but the src will try to migrate all 8
icp/server instances. After the patch, the same migration works.

So this was not related to the QOM path nor the QOM hierarchy, it was
just about having state created at machine init vs. cpu realize time. It
might be wise to keep an eye on the QOM hierarchy anyway as it could
make these kinds of changes more evident during review.

> I removed the pre_2_10_has_unused_icps hack and worked around
> another migration compat issue in IOMMU ... Here are the last
> trace-events for migration :
>
>      QEMU-mainline/pseries-2.9 -> QEMU-2.9/pseries-2.9
>
> 1016464@1705053752.106417:vmstate_load spapr, spapr
> 1016464@1705053752.106419:vmstate_load_state spapr v3
> 1016464@1705053752.106421:vmstate_load_state_field spapr:unused
> 1016464@1705053752.106424:vmstate_load_state_field spapr:rtc_offset
> 1016464@1705053752.106425:vmstate_load_state_field spapr:tb
> 1016464@1705053752.106427:vmstate_n_elems tb: 1
> 1016464@1705053752.106429:vmstate_load_state timebase v1
> 1016464@1705053752.106432:vmstate_load_state_field timebase:guest_timebase
> 1016464@1705053752.106433:vmstate_n_elems guest_timebase: 1
> 1016464@1705053752.106435:vmstate_load_state_field timebase:time_of_the_d=
ay_ns
> 1016464@1705053752.106436:vmstate_n_elems time_of_the_day_ns: 1
> 1016464@1705053752.106438:vmstate_subsection_load timebase
> 1016464@1705053752.106440:vmstate_subsection_load_bad timebase: spapr_opt=
ion_vector_ov5_cas/(prefix)
> 1016464@1705053752.106442:vmstate_load_state_end timebase end/0
> 1016464@1705053752.106443:vmstate_subsection_load spapr
> 1016464@1705053752.106445:vmstate_load_state spapr_option_vector_ov5_cas =
v1
> 1016464@1705053752.106447:vmstate_load_state_field spapr_option_vector_ov=
5_cas:ov5_cas
> 1016464@1705053752.106448:vmstate_n_elems ov5_cas: 1
> 1016464@1705053752.106450:vmstate_load_state spapr_option_vector v1
> 1016464@1705053752.106452:vmstate_load_state_field spapr_option_vector:bi=
tmap
> 1016464@1705053752.106454:vmstate_n_elems bitmap: 1
> 1016464@1705053752.106456:vmstate_subsection_load spapr_option_vector
> 1016464@1705053752.106457:vmstate_subsection_load_bad spapr_option_vector=
: (short)/
> 1016464@1705053752.106459:vmstate_load_state_end spapr_option_vector end/0
> 1016464@1705053752.106461:vmstate_subsection_load spapr_option_vector_ov5=
_cas
> 1016464@1705053752.106462:vmstate_subsection_load_bad spapr_option_vector=
_ov5_cas: (short)/
> 1016464@1705053752.106465:vmstate_load_state_end spapr_option_vector_ov5_=
cas end/0
> 1016464@1705053752.106466:vmstate_subsection_load_bad spapr: spapr/cap/ht=
m/(lookup)
> qemu-system-ppc64: error while loading state for instance 0x0 of device '=
spapr'

This trace this seems to be something else entirely. I'd be amazed if
migrating mainline vs. something that old worked at all, even on x86.

