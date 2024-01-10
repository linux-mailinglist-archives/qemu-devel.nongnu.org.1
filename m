Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCA829BDB
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 14:56:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNZ2w-0002BF-3O; Wed, 10 Jan 2024 08:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNZ2t-0002At-U7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 08:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNZ2r-0007cS-NE
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 08:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704894900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wk07C0QrNxbfu+ZfQjNe5NGRfyFgkwnr48d1D4Mxe+E=;
 b=QkZ7wIlS1+RoyCsI71yNLsVCnK5XfDELy/8+babW1tfZ8CTMNhL89C23FYoflSGEYR+JeJ
 WXIbMGaqTCPF/SKJk+QxwfGWKYB6U58Ga6h3Zr/MHnrljKzHmaGPoS4lrlouB52RCt5y0a
 uQ7eHsw3sBf60DUCHERTzF73IU7LAlw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-1g23w-L4NHqNyLTHE1BtLA-1; Wed,
 10 Jan 2024 08:54:57 -0500
X-MC-Unique: 1g23w-L4NHqNyLTHE1BtLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BFC01C05149;
 Wed, 10 Jan 2024 13:54:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C3E0C15880;
 Wed, 10 Jan 2024 13:54:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92EE321E6682; Wed, 10 Jan 2024 14:54:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Tyrone Ting <kfting@nuvoton.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Joel Stanley <joel@jms.id.au>,  Alistair Francis
 <alistair@alistair23.me>,  Anton Johansson <anjo@rev.ng>,  Andrey Smirnov
 <andrew.smirnov@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Hao Wu <wuhaotsh@google.com>,  Jean-Christophe Dubois
 <jcd@tribudubois.net>,  Igor Mitsyanko <i.mitsyanko@gmail.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
In-Reply-To: <874jfl8gwf.fsf@suse.de> (Fabiano Rosas's message of "Wed, 10 Jan
 2024 10:19:44 -0300")
References: <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
 <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org>
 <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org>
 <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org>
 <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org>
 <ZZ4Qrfis4XHWGN0j@x1n> <87cyu9hgit.fsf@pond.sub.org>
 <874jfl8gwf.fsf@suse.de>
Date: Wed, 10 Jan 2024 14:54:53 +0100
Message-ID: <87v88170pe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Peter Xu <peterx@redhat.com> writes:
>>
>>> On Tue, Jan 09, 2024 at 10:22:31PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>>> Hi Fabiano,
>>>>=20
>>>> On 9/1/24 21:21, Fabiano Rosas wrote:
>>>> > C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>> >=20
>>>> > > On 1/9/24 18:40, Fabiano Rosas wrote:
>>>> > > > C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>> > > >=20
>>>> > > > > On 1/3/24 20:53, Fabiano Rosas wrote:
>>>> > > > > > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>>> > > > > >=20
>>>> > > > > > > +Peter/Fabiano
>>>> > > > > > >=20
>>>> > > > > > > On 2/1/24 17:41, C=C3=A9dric Le Goater wrote:
>>>> > > > > > > > On 1/2/24 17:15, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> > > > > > > > > Hi C=C3=A9dric,
>>>> > > > > > > > >=20
>>>> > > > > > > > > On 2/1/24 15:55, C=C3=A9dric Le Goater wrote:
>>>> > > > > > > > > > On 12/12/23 17:29, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> > > > > > > > > > > Hi,
>>>> > > > > > > > > > >=20
>>>> > > > > > > > > > > When a MPCore cluster is used, the Cortex-A cores =
belong the the
>>>> > > > > > > > > > > cluster container, not to the board/soc layer. Thi=
s series move
>>>> > > > > > > > > > > the creation of vCPUs to the MPCore private contai=
ner.
>>>> > > > > > > > > > >=20
>>>> > > > > > > > > > > Doing so we consolidate the QOM model, moving comm=
on code in a
>>>> > > > > > > > > > > central place (abstract MPCore parent).
>>>> > > > > > > > > >=20
>>>> > > > > > > > > > Changing the QOM hierarchy has an impact on the stat=
e of the machine
>>>> > > > > > > > > > and some fixups are then required to maintain migrat=
ion compatibility.
>>>> > > > > > > > > > This can become a real headache for KVM machines lik=
e virt for which
>>>> > > > > > > > > > migration compatibility is a feature, less for emula=
ted ones.
>>>> > > > > > > > >=20
>>>> > > > > > > > > All changes are either moving properties (which are no=
t migrated)
>>>> > > > > > > > > or moving non-migrated QOM members (i.e. pointers of A=
RMCPU, which
>>>> > > > > > > > > is still migrated elsewhere). So I don't see any obvio=
us migration
>>>> > > > > > > > > problem, but I might be missing something, so I Cc'ed =
Juan :>
>>>> > > > > >=20
>>>> > > > > > FWIW, I didn't spot anything problematic either.
>>>> > > > > >=20
>>>> > > > > > I've ran this through my migration compatibility series [1] =
and it
>>>> > > > > > doesn't regress aarch64 migration from/to 8.2. The tests use=
 '-M
>>>> > > > > > virt -cpu max', so the cortex-a7 and cortex-a15 are not cove=
red. I don't
>>>> > > > > > think we even support migration of anything non-KVM on arm.
>>>> > > > >=20
>>>> > > > > it happens we do.
>>>> > > > >=20
>>>> > > >=20
>>>> > > > Oh, sorry, I didn't mean TCG here. Probably meant to say somethi=
ng like
>>>> > > > non-KVM-capable cpus, as in 32-bit. Nevermind.
>>>> > >=20
>>>> > > Theoretically, we should be able to migrate to a TCG guest. Well, =
this
>>>> > > worked in the past for PPC. When I was doing more KVM related chan=
ges,
>>>> > > this was very useful for dev. Also, some machines are partially em=
ulated.
>>>> > > Anyhow I agree this is not a strong requirement and we often break=
 it.
>>>> > > Let's focus on KVM only.
>>>> > >=20
>>>> > > > > > 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
>>>> > > > >=20
>>>> > > > > yes it depends on the QOM hierarchy and virt seems immune to t=
he changes.
>>>> > > > > Good.
>>>> > > > >=20
>>>> > > > > However, changing the QOM topology clearly breaks migration co=
mpat,
>>>> > > >=20
>>>> > > > Well, "clearly" is relative =3D) You've mentioned pseries and as=
peed
>>>> > > > already, do you have a pointer to one of those cases were we bro=
ke
>>>> > > > migration
>>>> > >=20
>>>> > > Regarding pseries, migration compat broke because of 5bc8d26de20c
>>>> > > ("spapr: allocate the ICPState object from under sPAPRCPUCore") wh=
ich
>>>> > > is similar to the changes proposed by this series, it impacts the =
QOM
>>>> > > hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
>>>> > > ("spapr: fix migration of ICPState objects from/to older QEMU") wh=
ich
>>>> > > is quite an headache and this turned out to raise another problem =
some
>>>> > > months ago ... :/ That's why I sent [1] to prepare removal of old
>>>> > > machines and workarounds becoming a burden.
>>>> >=20
>>>> > This feels like something that could be handled by the vmstate code
>>>> > somehow. The state is there, just under a different path.
>>>>=20
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
>>>>=20
>>>> See recent discussions on "QOM path stability":
>>>> https://lore.kernel.org/qemu-devel/ZZfYvlmcxBCiaeWE@redhat.com/
>>>> https://lore.kernel.org/qemu-devel/87jzojbxt7.fsf@pond.sub.org/
>>>> https://lore.kernel.org/qemu-devel/87v883by34.fsf@pond.sub.org/
>>>
>>> If I read it right, the commit 46f7afa37096 example is pretty special t=
hat
>>> the QOM path more or less decided more than the hierachy itself but cha=
nges
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

Alright, I understand neither the problem nor the fix :)

>> The QOM patch changes are *not* part of the problem.
>
> The only explanation I can come up with is that after the patch
> migration has broken after a hotplug or similar operation. In such
> situation, the preallocated state would always be present before the
> patch, but sometimes not present after the patch in case, say, a
> hot-unplug has taken away a cpu + ICPState.

My head hurts...  Oh, we're talking migration!  Perfectly normal then.


