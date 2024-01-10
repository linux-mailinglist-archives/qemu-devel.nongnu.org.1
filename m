Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE963829B22
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 14:21:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNYUz-0004OM-NL; Wed, 10 Jan 2024 08:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rNYUw-0004NB-G9; Wed, 10 Jan 2024 08:19:58 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rNYUu-0006kB-8B; Wed, 10 Jan 2024 08:19:58 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D2941F8AB;
 Wed, 10 Jan 2024 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704892792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GYT9PesspGGTGrKftEOP1PfOQjdmzxfChZ6FPizWes=;
 b=uvtYAcnOz9eQLWG8584tL8SFuNZDxpyGe9n4Hr/bnZYJivVhxSXqjB0ti6zRaWSyC26KJA
 ivMIeTEpYGLpQ0W9nrOkB3LFhqtTfsvPHMm0uqGmqaWuTYa8A5eNw0uZPE8u6wj4binMaB
 Z/JnW8JVqpK8H1Tcyb6tSqA+YWcPOP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704892792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GYT9PesspGGTGrKftEOP1PfOQjdmzxfChZ6FPizWes=;
 b=rBKmJ+a1DPlGGBsLtsGibhShrqzsmxK0w+kxYcsMaYAdQreboGtYX7Q2swkzvbpyxG3GNW
 LbnhZWa8PuOY5qAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704892792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GYT9PesspGGTGrKftEOP1PfOQjdmzxfChZ6FPizWes=;
 b=uvtYAcnOz9eQLWG8584tL8SFuNZDxpyGe9n4Hr/bnZYJivVhxSXqjB0ti6zRaWSyC26KJA
 ivMIeTEpYGLpQ0W9nrOkB3LFhqtTfsvPHMm0uqGmqaWuTYa8A5eNw0uZPE8u6wj4binMaB
 Z/JnW8JVqpK8H1Tcyb6tSqA+YWcPOP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704892792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GYT9PesspGGTGrKftEOP1PfOQjdmzxfChZ6FPizWes=;
 b=rBKmJ+a1DPlGGBsLtsGibhShrqzsmxK0w+kxYcsMaYAdQreboGtYX7Q2swkzvbpyxG3GNW
 LbnhZWa8PuOY5qAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A287C13786;
 Wed, 10 Jan 2024 13:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vowEGneZnmV6EwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jan 2024 13:19:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, qemu-devel@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Hao
 Wu <wuhaotsh@google.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
In-Reply-To: <87cyu9hgit.fsf@pond.sub.org>
References: <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
 <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org> <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org> <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org> <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org> <ZZ4Qrfis4XHWGN0j@x1n>
 <87cyu9hgit.fsf@pond.sub.org>
Date: Wed, 10 Jan 2024 10:19:44 -0300
Message-ID: <874jfl8gwf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 R_RATELIMIT(0.00)[to_ip_from(RLgn3pipxh44ye66tuwadwbnif)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWELVE(0.00)[25];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linaro.org,kaod.org,nongnu.org,redhat.com,nuvoton.com,habkost.net,jms.id.au,alistair23.me,rev.ng,gmail.com,google.com,tribudubois.net,codeconstruct.com.au,kernel.org,ilande.co.uk];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Tue, Jan 09, 2024 at 10:22:31PM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> Hi Fabiano,
>>>=20
>>> On 9/1/24 21:21, Fabiano Rosas wrote:
>>> > C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>> >=20
>>> > > On 1/9/24 18:40, Fabiano Rosas wrote:
>>> > > > C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>> > > >=20
>>> > > > > On 1/3/24 20:53, Fabiano Rosas wrote:
>>> > > > > > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>> > > > > >=20
>>> > > > > > > +Peter/Fabiano
>>> > > > > > >=20
>>> > > > > > > On 2/1/24 17:41, C=C3=A9dric Le Goater wrote:
>>> > > > > > > > On 1/2/24 17:15, Philippe Mathieu-Daud=C3=A9 wrote:
>>> > > > > > > > > Hi C=C3=A9dric,
>>> > > > > > > > >=20
>>> > > > > > > > > On 2/1/24 15:55, C=C3=A9dric Le Goater wrote:
>>> > > > > > > > > > On 12/12/23 17:29, Philippe Mathieu-Daud=C3=A9 wrote:
>>> > > > > > > > > > > Hi,
>>> > > > > > > > > > >=20
>>> > > > > > > > > > > When a MPCore cluster is used, the Cortex-A cores b=
elong the the
>>> > > > > > > > > > > cluster container, not to the board/soc layer. This=
 series move
>>> > > > > > > > > > > the creation of vCPUs to the MPCore private contain=
er.
>>> > > > > > > > > > >=20
>>> > > > > > > > > > > Doing so we consolidate the QOM model, moving commo=
n code in a
>>> > > > > > > > > > > central place (abstract MPCore parent).
>>> > > > > > > > > >=20
>>> > > > > > > > > > Changing the QOM hierarchy has an impact on the state=
 of the machine
>>> > > > > > > > > > and some fixups are then required to maintain migrati=
on compatibility.
>>> > > > > > > > > > This can become a real headache for KVM machines like=
 virt for which
>>> > > > > > > > > > migration compatibility is a feature, less for emulat=
ed ones.
>>> > > > > > > > >=20
>>> > > > > > > > > All changes are either moving properties (which are not=
 migrated)
>>> > > > > > > > > or moving non-migrated QOM members (i.e. pointers of AR=
MCPU, which
>>> > > > > > > > > is still migrated elsewhere). So I don't see any obviou=
s migration
>>> > > > > > > > > problem, but I might be missing something, so I Cc'ed J=
uan :>
>>> > > > > >=20
>>> > > > > > FWIW, I didn't spot anything problematic either.
>>> > > > > >=20
>>> > > > > > I've ran this through my migration compatibility series [1] a=
nd it
>>> > > > > > doesn't regress aarch64 migration from/to 8.2. The tests use =
'-M
>>> > > > > > virt -cpu max', so the cortex-a7 and cortex-a15 are not cover=
ed. I don't
>>> > > > > > think we even support migration of anything non-KVM on arm.
>>> > > > >=20
>>> > > > > it happens we do.
>>> > > > >=20
>>> > > >=20
>>> > > > Oh, sorry, I didn't mean TCG here. Probably meant to say somethin=
g like
>>> > > > non-KVM-capable cpus, as in 32-bit. Nevermind.
>>> > >=20
>>> > > Theoretically, we should be able to migrate to a TCG guest. Well, t=
his
>>> > > worked in the past for PPC. When I was doing more KVM related chang=
es,
>>> > > this was very useful for dev. Also, some machines are partially emu=
lated.
>>> > > Anyhow I agree this is not a strong requirement and we often break =
it.
>>> > > Let's focus on KVM only.
>>> > >=20
>>> > > > > > 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
>>> > > > >=20
>>> > > > > yes it depends on the QOM hierarchy and virt seems immune to th=
e changes.
>>> > > > > Good.
>>> > > > >=20
>>> > > > > However, changing the QOM topology clearly breaks migration com=
pat,
>>> > > >=20
>>> > > > Well, "clearly" is relative =3D) You've mentioned pseries and asp=
eed
>>> > > > already, do you have a pointer to one of those cases were we broke
>>> > > > migration
>>> > >=20
>>> > > Regarding pseries, migration compat broke because of 5bc8d26de20c
>>> > > ("spapr: allocate the ICPState object from under sPAPRCPUCore") whi=
ch
>>> > > is similar to the changes proposed by this series, it impacts the Q=
OM
>>> > > hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
>>> > > ("spapr: fix migration of ICPState objects from/to older QEMU") whi=
ch
>>> > > is quite an headache and this turned out to raise another problem s=
ome
>>> > > months ago ... :/ That's why I sent [1] to prepare removal of old
>>> > > machines and workarounds becoming a burden.
>>> >=20
>>> > This feels like something that could be handled by the vmstate code
>>> > somehow. The state is there, just under a different path.
>>>=20
>>> What, the QOM path is used in migration? ...
>>
>> Hopefully not..

Unfortunately the original fix doesn't mention _what_ actually broke
with migration. I assumed the QOM path was needed because otherwise I
don't think the fix makes sense. The thread discussing that patch also
directly mentions the QOM path:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg450912.html

But I probably misunderstood something while reading that thread.

>>
>>>=20
>>> See recent discussions on "QOM path stability":
>>> https://lore.kernel.org/qemu-devel/ZZfYvlmcxBCiaeWE@redhat.com/
>>> https://lore.kernel.org/qemu-devel/87jzojbxt7.fsf@pond.sub.org/
>>> https://lore.kernel.org/qemu-devel/87v883by34.fsf@pond.sub.org/
>>
>> If I read it right, the commit 46f7afa37096 example is pretty special th=
at
>> the QOM path more or less decided more than the hierachy itself but chan=
ges
>> the existances of objects.
>
> Let's see whether I got this...
>
> We removed some useless objects, moved the useful ones to another home.
> The move changed their QOM path.
>
> The problem was the removal of useless objects, because this also
> removed their vmstate.

If you checkout at the removal commit (5bc8d26de20c), the vmstate has
been kept untouched.

>
> The fix was adding the vmstate back as a dummy.

Since the vmstate was kept I don't see why would we need a dummy. The
incoming migration stream would still have the state, only at a
different point in the stream. It's surprising to me that that would
cause an issue, but I'm not well versed in that code.

>
> The QOM patch changes are *not* part of the problem.

The only explanation I can come up with is that after the patch
migration has broken after a hotplug or similar operation. In such
situation, the preallocated state would always be present before the
patch, but sometimes not present after the patch in case, say, a
hot-unplug has taken away a cpu + ICPState.

