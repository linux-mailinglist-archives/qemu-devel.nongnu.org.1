Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D457D828E7B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 21:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNIb4-0003RS-Fs; Tue, 09 Jan 2024 15:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rNIb2-0003R7-FU; Tue, 09 Jan 2024 15:21:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rNIay-0005mU-WA; Tue, 09 Jan 2024 15:21:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B683220F1;
 Tue,  9 Jan 2024 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704831666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWmxf0mlhBYBS0EsSSNkgd7+huRVr/Byc/CXIT+Shks=;
 b=m5mRB0aNdJCipoWMCSVL6uy6d0dX1M18wrNH5XUG3y6s8z0ukpuf0FBJa8vb71kEJ+xGfQ
 0QIZyw9SPdlvvDA6tvjbWtzof9CwXGQa+tD5Hlu03ITjzhAeeiAXx1K/Qc0ilEcaV4ygoi
 RNbcVBj7t2sIaVoLrIM2Muw0PE9Y3Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704831666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWmxf0mlhBYBS0EsSSNkgd7+huRVr/Byc/CXIT+Shks=;
 b=ZOdEsI6SQyhpNNOqcEdQO1aTqVK/VSAnKvI+Hz1Z8TcpizgcoJgyrEWPtD2+GwKbsIO2zk
 l/72NJSJGrHNRECQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704831666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWmxf0mlhBYBS0EsSSNkgd7+huRVr/Byc/CXIT+Shks=;
 b=m5mRB0aNdJCipoWMCSVL6uy6d0dX1M18wrNH5XUG3y6s8z0ukpuf0FBJa8vb71kEJ+xGfQ
 0QIZyw9SPdlvvDA6tvjbWtzof9CwXGQa+tD5Hlu03ITjzhAeeiAXx1K/Qc0ilEcaV4ygoi
 RNbcVBj7t2sIaVoLrIM2Muw0PE9Y3Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704831666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWmxf0mlhBYBS0EsSSNkgd7+huRVr/Byc/CXIT+Shks=;
 b=ZOdEsI6SQyhpNNOqcEdQO1aTqVK/VSAnKvI+Hz1Z8TcpizgcoJgyrEWPtD2+GwKbsIO2zk
 l/72NJSJGrHNRECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8727C134E8;
 Tue,  9 Jan 2024 20:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RW6WE7GqnWVbMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jan 2024 20:21:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Philippe =?utf-8?Q?M?=
 =?utf-8?Q?athieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, Juan Quintela
 <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Anton Johansson <anjo@rev.ng>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Igor Mitsyanko
 <i.mitsyanko@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
 <robh@kernel.org>, qemu-arm@nongnu.org, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
In-Reply-To: <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org>
References: <20231212162935.42910-1-philmd@linaro.org>
 <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
 <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org> <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org> <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org>
Date: Tue, 09 Jan 2024 17:21:03 -0300
Message-ID: <87bk9u8dhs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0B683220F1
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m5mRB0aN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZOdEsI6S
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLpct1jb1dgwfjtbqq8ebpmkdo)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[23];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[redhat.com,nuvoton.com,linaro.org,habkost.net,jms.id.au,alistair23.me,rev.ng,gmail.com,google.com,tribudubois.net,codeconstruct.com.au,kernel.org,nongnu.org,ilande.co.uk];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
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

> On 1/9/24 18:40, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>>> On 1/3/24 20:53, Fabiano Rosas wrote:
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>>>
>>>>> +Peter/Fabiano
>>>>>
>>>>> On 2/1/24 17:41, C=C3=A9dric Le Goater wrote:
>>>>>> On 1/2/24 17:15, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>> Hi C=C3=A9dric,
>>>>>>>
>>>>>>> On 2/1/24 15:55, C=C3=A9dric Le Goater wrote:
>>>>>>>> On 12/12/23 17:29, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> When a MPCore cluster is used, the Cortex-A cores belong the the
>>>>>>>>> cluster container, not to the board/soc layer. This series move
>>>>>>>>> the creation of vCPUs to the MPCore private container.
>>>>>>>>>
>>>>>>>>> Doing so we consolidate the QOM model, moving common code in a
>>>>>>>>> central place (abstract MPCore parent).
>>>>>>>>
>>>>>>>> Changing the QOM hierarchy has an impact on the state of the machi=
ne
>>>>>>>> and some fixups are then required to maintain migration compatibil=
ity.
>>>>>>>> This can become a real headache for KVM machines like virt for whi=
ch
>>>>>>>> migration compatibility is a feature, less for emulated ones.
>>>>>>>
>>>>>>> All changes are either moving properties (which are not migrated)
>>>>>>> or moving non-migrated QOM members (i.e. pointers of ARMCPU, which
>>>>>>> is still migrated elsewhere). So I don't see any obvious migration
>>>>>>> problem, but I might be missing something, so I Cc'ed Juan :>
>>>>
>>>> FWIW, I didn't spot anything problematic either.
>>>>
>>>> I've ran this through my migration compatibility series [1] and it
>>>> doesn't regress aarch64 migration from/to 8.2. The tests use '-M
>>>> virt -cpu max', so the cortex-a7 and cortex-a15 are not covered. I don=
't
>>>> think we even support migration of anything non-KVM on arm.
>>>
>>> it happens we do.
>>>
>>=20
>> Oh, sorry, I didn't mean TCG here. Probably meant to say something like
>> non-KVM-capable cpus, as in 32-bit. Nevermind.
>
> Theoretically, we should be able to migrate to a TCG guest. Well, this
> worked in the past for PPC. When I was doing more KVM related changes,
> this was very useful for dev. Also, some machines are partially emulated.
> Anyhow I agree this is not a strong requirement and we often break it.
> Let's focus on KVM only.
>
>>>> 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
>>>
>>> yes it depends on the QOM hierarchy and virt seems immune to the change=
s.
>>> Good.
>>>
>>> However, changing the QOM topology clearly breaks migration compat,
>>=20
>> Well, "clearly" is relative =3D) You've mentioned pseries and aspeed
>> already, do you have a pointer to one of those cases were we broke
>> migration=20
>
> Regarding pseries, migration compat broke because of 5bc8d26de20c
> ("spapr: allocate the ICPState object from under sPAPRCPUCore") which
> is similar to the changes proposed by this series, it impacts the QOM
> hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
> ("spapr: fix migration of ICPState objects from/to older QEMU") which
> is quite an headache and this turned out to raise another problem some
> months ago ... :/ That's why I sent [1] to prepare removal of old
> machines and workarounds becoming a burden.

This feels like something that could be handled by the vmstate code
somehow. The state is there, just under a different path. No one wants
to be policing QOM hierarchy changes in every single series that shows
up on the list.

Anyway, thanks for the pointers. I'll study that code a bit more, maybe
I can come up with some way to handle these cases.

Hopefully between the analyze-migration test and the compat tests we'll
catch the next bug of this kind before it gets merged.



