Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455F82938A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 07:03:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNRgN-0002ze-Ng; Wed, 10 Jan 2024 01:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNRgL-0002zL-6a
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 01:03:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNRgJ-0007Bw-3n
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 01:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704866594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5RZoGOKOxGnVXcC9uaDFVLRQMnMpiPtzRtI/UC1ngc=;
 b=LjbG3yPz/fomI9pFR+3CG7+PyEmi/eemNdgkpuNEi47Pyznm4mgQn9W7WDojAY5mdJbsk+
 aS4rpCDM4W/6cHJgCFUpipANVSqPzIFOoSmRqVfNBEMcVdRTO99BBxso4FFRvek0NGlOxW
 TJns+jwLAwOcykdazArZuGsgwNP3gWY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-I1FjNc2gO_6ovNOLKohGaA-1; Wed,
 10 Jan 2024 01:03:10 -0500
X-MC-Unique: I1FjNc2gO_6ovNOLKohGaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E7BB3C025C5;
 Wed, 10 Jan 2024 06:03:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15EDA51E3;
 Wed, 10 Jan 2024 06:03:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 067DC21E6682; Wed, 10 Jan 2024 07:03:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Fabiano Rosas
 <farosas@suse.de>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Joel Stanley <joel@jms.id.au>,  Alistair Francis
 <alistair@alistair23.me>,  Anton Johansson <anjo@rev.ng>,  Andrey Smirnov
 <andrew.smirnov@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Hao Wu <wuhaotsh@google.com>,  Jean-Christophe Dubois
 <jcd@tribudubois.net>,  Igor Mitsyanko <i.mitsyanko@gmail.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
In-Reply-To: <ZZ4Qrfis4XHWGN0j@x1n> (Peter Xu's message of "Wed, 10 Jan 2024
 11:36:13 +0800")
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
 <ZZ4Qrfis4XHWGN0j@x1n>
Date: Wed, 10 Jan 2024 07:03:06 +0100
Message-ID: <87cyu9hgit.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jan 09, 2024 at 10:22:31PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi Fabiano,
>>=20
>> On 9/1/24 21:21, Fabiano Rosas wrote:
>> > C=C3=A9dric Le Goater <clg@kaod.org> writes:
>> >=20
>> > > On 1/9/24 18:40, Fabiano Rosas wrote:
>> > > > C=C3=A9dric Le Goater <clg@kaod.org> writes:
>> > > >=20
>> > > > > On 1/3/24 20:53, Fabiano Rosas wrote:
>> > > > > > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>> > > > > >=20
>> > > > > > > +Peter/Fabiano
>> > > > > > >=20
>> > > > > > > On 2/1/24 17:41, C=C3=A9dric Le Goater wrote:
>> > > > > > > > On 1/2/24 17:15, Philippe Mathieu-Daud=C3=A9 wrote:
>> > > > > > > > > Hi C=C3=A9dric,
>> > > > > > > > >=20
>> > > > > > > > > On 2/1/24 15:55, C=C3=A9dric Le Goater wrote:
>> > > > > > > > > > On 12/12/23 17:29, Philippe Mathieu-Daud=C3=A9 wrote:
>> > > > > > > > > > > Hi,
>> > > > > > > > > > >=20
>> > > > > > > > > > > When a MPCore cluster is used, the Cortex-A cores be=
long the the
>> > > > > > > > > > > cluster container, not to the board/soc layer. This =
series move
>> > > > > > > > > > > the creation of vCPUs to the MPCore private containe=
r.
>> > > > > > > > > > >=20
>> > > > > > > > > > > Doing so we consolidate the QOM model, moving common=
 code in a
>> > > > > > > > > > > central place (abstract MPCore parent).
>> > > > > > > > > >=20
>> > > > > > > > > > Changing the QOM hierarchy has an impact on the state =
of the machine
>> > > > > > > > > > and some fixups are then required to maintain migratio=
n compatibility.
>> > > > > > > > > > This can become a real headache for KVM machines like =
virt for which
>> > > > > > > > > > migration compatibility is a feature, less for emulate=
d ones.
>> > > > > > > > >=20
>> > > > > > > > > All changes are either moving properties (which are not =
migrated)
>> > > > > > > > > or moving non-migrated QOM members (i.e. pointers of ARM=
CPU, which
>> > > > > > > > > is still migrated elsewhere). So I don't see any obvious=
 migration
>> > > > > > > > > problem, but I might be missing something, so I Cc'ed Ju=
an :>
>> > > > > >=20
>> > > > > > FWIW, I didn't spot anything problematic either.
>> > > > > >=20
>> > > > > > I've ran this through my migration compatibility series [1] an=
d it
>> > > > > > doesn't regress aarch64 migration from/to 8.2. The tests use '=
-M
>> > > > > > virt -cpu max', so the cortex-a7 and cortex-a15 are not covere=
d. I don't
>> > > > > > think we even support migration of anything non-KVM on arm.
>> > > > >=20
>> > > > > it happens we do.
>> > > > >=20
>> > > >=20
>> > > > Oh, sorry, I didn't mean TCG here. Probably meant to say something=
 like
>> > > > non-KVM-capable cpus, as in 32-bit. Nevermind.
>> > >=20
>> > > Theoretically, we should be able to migrate to a TCG guest. Well, th=
is
>> > > worked in the past for PPC. When I was doing more KVM related change=
s,
>> > > this was very useful for dev. Also, some machines are partially emul=
ated.
>> > > Anyhow I agree this is not a strong requirement and we often break i=
t.
>> > > Let's focus on KVM only.
>> > >=20
>> > > > > > 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
>> > > > >=20
>> > > > > yes it depends on the QOM hierarchy and virt seems immune to the=
 changes.
>> > > > > Good.
>> > > > >=20
>> > > > > However, changing the QOM topology clearly breaks migration comp=
at,
>> > > >=20
>> > > > Well, "clearly" is relative =3D) You've mentioned pseries and aspe=
ed
>> > > > already, do you have a pointer to one of those cases were we broke
>> > > > migration
>> > >=20
>> > > Regarding pseries, migration compat broke because of 5bc8d26de20c
>> > > ("spapr: allocate the ICPState object from under sPAPRCPUCore") which
>> > > is similar to the changes proposed by this series, it impacts the QOM
>> > > hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
>> > > ("spapr: fix migration of ICPState objects from/to older QEMU") which
>> > > is quite an headache and this turned out to raise another problem so=
me
>> > > months ago ... :/ That's why I sent [1] to prepare removal of old
>> > > machines and workarounds becoming a burden.
>> >=20
>> > This feels like something that could be handled by the vmstate code
>> > somehow. The state is there, just under a different path.
>>=20
>> What, the QOM path is used in migration? ...
>
> Hopefully not..
>
>>=20
>> See recent discussions on "QOM path stability":
>> https://lore.kernel.org/qemu-devel/ZZfYvlmcxBCiaeWE@redhat.com/
>> https://lore.kernel.org/qemu-devel/87jzojbxt7.fsf@pond.sub.org/
>> https://lore.kernel.org/qemu-devel/87v883by34.fsf@pond.sub.org/
>
> If I read it right, the commit 46f7afa37096 example is pretty special that
> the QOM path more or less decided more than the hierachy itself but chang=
es
> the existances of objects.

Let's see whether I got this...

We removed some useless objects, moved the useful ones to another home.
The move changed their QOM path.

The problem was the removal of useless objects, because this also
removed their vmstate.

The fix was adding the vmstate back as a dummy.

The QOM patch changes are *not* part of the problem.

Correct?

>> > No one wants
>> > to be policing QOM hierarchy changes in every single series that shows
>> > up on the list.
>> >=20
>> > Anyway, thanks for the pointers. I'll study that code a bit more, maybe
>> > I can come up with some way to handle these cases.
>> >=20
>> > Hopefully between the analyze-migration test and the compat tests we'll
>> > catch the next bug of this kind before it gets merged.
>
> Things like that might be able to be detected via vmstate-static-checker.=
py.
> But I'm not 100% sure, also its coverage is limited.
>
> For example, I don't think it can detect changes to objects that will only
> be created dynamically, e.g., I think sometimes we create objects after
> some guest behaviors (consider guest enables the device, then QEMU
> emulation creates some objects on demand of device setup?),

Feels nuts to me.

In real hardware, software enabling a device that is disabled by default
doesn't create the device.  The device is always there, it just happens
to be inactive unless enabled.  We should model the device just like
that.

>                                                             and since the
> static checker shouldn't ever start the VM and run any code, they won't
> trigger.


