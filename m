Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5E4AD2564
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 20:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOh4N-0006Ky-Fz; Mon, 09 Jun 2025 14:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uOh3s-0006Jh-B4
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:17:32 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uOh3q-0002lk-Ek
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:17:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C2F01F46E;
 Mon,  9 Jun 2025 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749493048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7AIPV13Vke9xbPCGXzLNZ6FG77nKOJq1crtYxZdE2o=;
 b=biCJeh3WH1tA0cqqKE4bS0SiLi4oV0q0s2lBUDW3tJtf9aPSCby28T0hznZQbD/KoZIaND
 kvGGwBrvzpUSdFk0fzp9sJXiJeBb3/Qd4+e2UsKuymyNZxhCo3HiPvnsjEluSjKcOR0X0e
 /jNC42Np1Kdp/vbSql7uXUGx/NtXH8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749493048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7AIPV13Vke9xbPCGXzLNZ6FG77nKOJq1crtYxZdE2o=;
 b=XB6H/WS0Md1QkhwMeeG4Q+pUrnwnhZyk98YPar3K+z5fkmzmxFfihiWpwCWwhwLbge6u4B
 QOPcYdBKEnKG+RBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749493048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7AIPV13Vke9xbPCGXzLNZ6FG77nKOJq1crtYxZdE2o=;
 b=biCJeh3WH1tA0cqqKE4bS0SiLi4oV0q0s2lBUDW3tJtf9aPSCby28T0hznZQbD/KoZIaND
 kvGGwBrvzpUSdFk0fzp9sJXiJeBb3/Qd4+e2UsKuymyNZxhCo3HiPvnsjEluSjKcOR0X0e
 /jNC42Np1Kdp/vbSql7uXUGx/NtXH8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749493048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7AIPV13Vke9xbPCGXzLNZ6FG77nKOJq1crtYxZdE2o=;
 b=XB6H/WS0Md1QkhwMeeG4Q+pUrnwnhZyk98YPar3K+z5fkmzmxFfihiWpwCWwhwLbge6u4B
 QOPcYdBKEnKG+RBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F410D13A1D;
 Mon,  9 Jun 2025 18:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BlDzKjclR2gRLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Jun 2025 18:17:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
In-Reply-To: <aEcQj_XLnnnS9FKv@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de> <aENBda_y3v3y4ptS@x1.local>
 <874iwswrex.fsf@suse.de> <aENUrociiqlFuPpz@x1.local>
 <87y0u1ugkx.fsf@suse.de> <aEcC9X5i6eV4N7An@x1.local>
 <aEcIDNpXJHGAhwmK@redhat.com> <aEcQj_XLnnnS9FKv@x1.local>
Date: Mon, 09 Jun 2025 15:17:25 -0300
Message-ID: <87sek8vky2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> (I had a reply in the other thread, that might have covered most of the
>  points but maybe not this one..)
>
> On Mon, Jun 09, 2025 at 05:13:00PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> Even if only a single mgmt app is involved this is still beneficial
>> because the migration infrastructure is used for distinct use cases
>> inside QEMU - live migration, CPR, save/restore, and savevm/loadvm.
>
> I assume CPR is save/restore, so indeed we have 3 ways to use migration
> core.
>
>> Any time code any one of those uses cases starts using a new parameter,
>> apps have to make sure they don't inadvertantly have its effects apply
>> to the other use cases.
>
> AFAICT, that's not affected by "whether we allow global settings", that is
> still a concern internally as long as they use migration core.
>
> One thing to mention is CPR is really a fine citizen here, AFAICT it is
> exactly live migration using all the proper caps/params.  We _could_ split
> it as many things do not apply like postcopy, but we could still just reu=
se
> everything and ignoring the rest.  It'll be again a cleaness issue to me,
> and even if CPR reuses everything it looks still clean enough, especially
> comparing to savevm/loadvm.
>
> savevm/loadvm is another story.. however afaiu if we want to decouple it,
> it should be done not from the interface level, but internally first.
> E.g., we should allow taking parameters as a temp pointer passing to
> migration core, so that will be passed over by savevm setting all caps of=
f,
> for example, ignoring the global config.  The interface alone should, IMH=
O,
> be done only later.
>

This is simple to do, just reset all of s->parameters to (the new)
s->defaults. We never decided if any migration parameters do make sense
to use with savevm. If some of them does or is added later, then
snapshot_save would gain a "config" argument.

> Meanwhile, even if that, IMO we can't avoid the need to think any new par=
am
> affecting savevm, as long as it's still using migration core.  I don't kn=
ow
> whether we need to do that one step even further to decouple savevm: I
> would think the other way round to obsolete savevm completely if necessary
> when we have fine "file:" migrations now, especially with mapped-ram.

savevm is a weird case. It supports a wider range of setups than regular
migration. I don't know what to make of this. I would also like to make
it "just migration" but it will need a bunch of special-casing. Anyway,
we can discuss, but that's definitely for another day.

>
> Thanks,

