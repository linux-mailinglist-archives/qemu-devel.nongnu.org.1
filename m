Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B587183688D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:40:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwOL-0006EX-B4; Mon, 22 Jan 2024 10:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rRwOJ-0006D7-Eb
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:39:15 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rRwOH-0008C0-1L
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:39:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EC9722250;
 Mon, 22 Jan 2024 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705937949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9I1J3qw+gdrRjH59bt7QJDGN72NqvOnZFmEx2unfFA=;
 b=E+1Bd8TjmgAE0FtqLEa1nVCGL+iWWUSJicOaq596AXOFybut6umCtS7jMIm5f9gbGsSz/h
 RgZ7jyn2VJeU22JYBMuq5Z16DYDTfIypN3GYKVaDJ+LkbXlStJjY6iOYz2v2QfpFx5amUq
 INfLFtU8eAl1dPkaCIWKzVa8FYYFwbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705937949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9I1J3qw+gdrRjH59bt7QJDGN72NqvOnZFmEx2unfFA=;
 b=94ZOZekfE+WXzDZHYOTyEUkAK41MzpkjdOBKYAEKlM8fSnOBcXfspnAGZwkwkPGq2vJJAI
 Eebywd1aMWNhLdAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705937949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9I1J3qw+gdrRjH59bt7QJDGN72NqvOnZFmEx2unfFA=;
 b=E+1Bd8TjmgAE0FtqLEa1nVCGL+iWWUSJicOaq596AXOFybut6umCtS7jMIm5f9gbGsSz/h
 RgZ7jyn2VJeU22JYBMuq5Z16DYDTfIypN3GYKVaDJ+LkbXlStJjY6iOYz2v2QfpFx5amUq
 INfLFtU8eAl1dPkaCIWKzVa8FYYFwbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705937949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9I1J3qw+gdrRjH59bt7QJDGN72NqvOnZFmEx2unfFA=;
 b=94ZOZekfE+WXzDZHYOTyEUkAK41MzpkjdOBKYAEKlM8fSnOBcXfspnAGZwkwkPGq2vJJAI
 Eebywd1aMWNhLdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28D3413995;
 Mon, 22 Jan 2024 15:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xyApOByMrmUFbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jan 2024 15:39:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 peterx@redhat.com
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
In-Reply-To: <20240122070600.16681-1-peterx@redhat.com>
References: <20240122070600.16681-1-peterx@redhat.com>
Date: Mon, 22 Jan 2024 12:39:06 -0300
Message-ID: <87plxtgyxx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E+1Bd8Tj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=94ZOZekf
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9EC9722250
X-Spam-Score: -3.31
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> The current article is not extremely easy to follow, and may contain too
> much information for someone looking for solutions on VMSD compatibility
> issues.  Meanwhile, VMSD versioning is not discussed.
>
> I'm not yet sure whether we should just obsolete VMSD versioning; it's
> still used quite a lot.  And I had a feeling that for simple use cases
> where backward migration is not strongly required, device developers can
> still consider using it.  So in this patch I decided to keep it (anyway, we
> can't drop it in the near future because of massive existing users), and we
> can still allow user to use it in contexts where forward-only migration
> might be enough.
>
> This doc patch does below changes:
>
>   - Rename the page from "Backward compatibility" to "Migration
>   compatibility", to avoid using "backward" as a word (because we'll want
>   to identify "forward" / "backward" migrations in the new doc)
>
>   - Add a TOC for this page for better indexing
>
>   - A new section to explain what is forward/backward migration
>
>   - A new small section for VMSD just to make things complete
>
>   - Explain the two ways to make VMSD compatible with old qemu binaries
>
>     For this one, I added a small section on how to use VMSD versioning for
>     new fields just to start such documents.  Rename the old "How backwards
>     compatibility works" section to "machine type based (forward+backward
>     migration)" to be the 2nd solution (I called it machine type based
>     solution). When at it, I provided a summary and a TODO for the 2nd
>     solution.
>
>   - A new section to explain which solution to choose
>
>   - Moved the other two existing sections into "Extended readings", because
>   they can be even further away to most device developers
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/migration/compatibility.rst | 140 ++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
> index 5a5417ef06..ea9da201ef 100644
> --- a/docs/devel/migration/compatibility.rst
> +++ b/docs/devel/migration/compatibility.rst
> @@ -1,8 +1,139 @@
> -Backwards compatibility
>  =======================
> +Migration compatibility
> +=======================
> +
> +Migration is a hard topic sometimes.  One of the major reason is that it
> +has a strict compatibility requirement - a migration (live or not) can
> +happen between two different versions of QEMUs, so QEMU needs to make sure

S/QEMUs/QEMU/

> +the migration can work across different versions of QEMU binaries.
> +
> +This document majorly discusses the compatibility requirement of forward /

s/majorly/mainly/

> +backward migrations that QEMU need to maintain, and what QEMU developers

s/need/needs/

> +should do to achieve such compatibility requirements across different QEMU

maybe s/achieve/maintain/ ?

> +versions.
> +
> +.. contents::
> +
> +Types of migrations (forward / backward)
> +========================================
> +
> +Let's firstly define the terms **forward migration** and **backward
> +migration**.
> +
> +.. note::
> +
> +    To simplify the use case, we always discuss between two consecutive
> +    versions of QEMU major releases (between QEMU version *N* and QEMU
> +    version *N-1*).  But logically it applies to the case where the two
> +    QEMU binaries involved contains more than one major version difference.
> +
> +.. _forward_migration:
> +
> +**Forward migration**: can be seen as the use case where a VM cluster can
> +upgrade its nodes to a newer version of QEMU (version *N*) from an older
> +version of QEMU (version *N-1*).
> +
> +.. _backward_migration:
> +
> +**Backward migration**: can be seen as the use case where a VM cluster
> +would like to migrate from a newer version of QEMU (version *N*) back to an
> +even older version of QEMU (version *N-1*).

I'd drop the VM cluster part from these. Define the terms in a more
strict manner (QEMU versions, n/n-1, that's it). Then the parts below
could be second paragraphs further detailing the use-cases of the two
types of migration.

> +
> +A forward migration is more common, where system upgrades are needed.  In
> +this case, the upgrade can be done seamlessly by live migrating the old VMs
> +to the new VMs with the new binaries.

I got a bit confused whether this was describing migration to a
different host or within the same host. I suggest we spell it out some
more:

"live migrating an existing VM that uses an old QEMU binary to another
VM using the newly updated QEMU binary."

> +
> +A backward migration can be less common OTOH, because downgrade is less
> +common than upgrade for whatever reasons.  However for a production level
> +system setup, this should also be allowed, because a cluster can contain
> +different versions of QEMU binary.  It should be always allowed to migrate
> +between old and new hosts as long as the machine type is supported across
> +all the relevant hosts / nodes.
> +
> +VMState description data structure (VMSD)
> +=========================================
> +
> +VMSD (or in the complete form, **VMStateDescription**) is the data
> +structure that QEMU uses to describe data to be migrated for devices.
> +Each device should provide its own VMSD structure to describe what it needs
> +to be migrated when a VM live migration is requested.
> +
> +Device VMSD compatibility
> +=========================
> +
> +Then if the VMSD structures need changing, how does the device maintain
> +compatibilty?

s/compatibilty/compatibility/

Hm, there's a logical jump here from the _device_ changing to this
requiring a change in the VMSD. Also the device is not the thing that
maintains compatibility. Again we might need to spell it out:

"When a device data needs to change from one QEMU version to another,
how to maintain compatibility?" ... or something like this

>  
> -How backwards compatibility works
> ----------------------------------
> +Here we only discuss VMSD-based migrations.  If one device is not using
> +VMSD to migrate its device data, it's considered part of "advanced users",
> +then this document may not apply anymore.  If you're writting a new device,
> +please always consider starting with VMSD-based migration model.
> +
> +Consider the case where a device can start to support a new feature in the
> +current release, where it wasn't supported before.  The new feature may

s/, where it/ that/

> +require some new device states to be migrated (which can be new VMSD fields
> +to be added, or new subsections).  The same question needs to be answered
> +when one would like to modify an existing VMSD fields / layouts to fix a

s/an //

> +bug, and so on.
> +
> +Depending on the goal, the solution to this problem may vary.
> +
> +If one would like to provide a full support of migration between whatever
> +versions, one can try to implement it using :ref:`machine_type_compat`
> +solution.  If one would like to provide a fundamental upgrade-only
> +compatibility, one could consider to use the simpler
> +:ref:`vmsd_versioning_compat` solution.

Should this whole paragraph be put before mentioning VMSD? Otherwise
here we are talking about machine type compat after having said: "Here
we only discuss VMSD-based migrations".

All in all this could be:

up top:
Migration compatibility strategies
==================================

When a device data needs to change from one QEMU version to another, how
to maintain compatibility?

Depending on the goal, the solution to this problem may vary.

If one would like to provide a full support of migration between
arbitrary versions, one can try to implement it using
:ref:`machine_type_compat` solution.  If one would like to provide a
fundamental upgrade-only compatibility, one could consider to use the
simpler :ref:`vmsd_versioning_compat` solution.

VMState description data structure (VMSD)
-----------------------------------------

VMSD (or in the complete form, **VMStateDescription**) is the data ...
...

Machine type properties
-----------------------

The QEMU machine type is versioned (-machine q35 resolves is equivalent
to pc-q35-9.0) and has properties that can be set to different values
across machine versions. Those can be used to enable/disable different
parts of the code and can be used to help migration compatibility.

Migration compatibility solutions
=================================

VMSD versioning (forward migration only)
----------------------------------------
...

Machine type based (forward+backward migration)
-----------------------------------------------
...

> +
> +Solutions
> +=========
> +
> +.. _vmsd_versioning_compat:
> +
> +VMSD versioning (forward migration only)
> +----------------------------------------
> +
> +This is normally the simplest way to support cross-version QEMU live
> +migration. The trade-off is backward migration will not be supported. It
> +means migrations from new QEMU binaries to old QEMU binaries can fail. It's
> +because even if the new QEMU can understand the old version of VMSD by
> +proper versioning of the VMSD fields, the old QEMU will not be able to
> +understand the new version of VMSD layout.  Then when someone migrates a VM
> +using the new VMSD to an older version of QEMU, the old QEMU will not
> +accept the new migration stream, reporting that the VSMD version too new.

But we still have _some_ form of backward compat for _some_ kinds of
problems by using dummy fields in the VMSD for instance, right?

> +
> +Please have a look at **include/migration/vmstate.h** for more information
> +on how to use VMSD versioning.
> +
> +Taking an example of adding a new field for migration.  The change will
> +need to at least contain two parts:
> +
> +  - Boost existing VMSD version.
> +
> +  - Add the new VMSD field with the boosted version, with specific
> +    **VMSTATE_\*_V()** macros.  For example, **VMSTATE_UINT8_V()** will
> +    define an uint8 typed VMSD field with version specified.
> +
> +.. _machine_type_compat:
> +
> +Machine type based (forward+backward migration)
> +-----------------------------------------------
> +
> +QEMU developers can leverage machine type compatibile properties to provide

compatible

> +a fully migratable device / protocol, so the migration behavior will be
> +defined by the machine type, no matter which QEMU binary will be used.  One
> +can reference the entries defined in **hw_compat_\*** global properties for
> +examples.
> +
> +Comparing to VMSD versioning approach above, this may require more code
> +changes, but provide a higher level of compatibility that is bound to the
> +machine type being used.  To be explicit, since the migration behavior is
> +bound to machine type, it will support both forward migration and backward
> +migration as long as the machine type is supported.
> +
> +.. note::
> +
> +   Currently this section is pretty long.  TODO: rewrite this section to
> +   make it easier for QEMU developers to understand.
>  
>  When we do migration, we have two QEMU processes: the source and the
>  target.  There are two cases, they are the same version or they are
> @@ -217,6 +348,9 @@ machine types to have the right value::
>           ...
>       };
>  
> +Extended readings
> +=================
> +
>  A device with different features on both sides
>  ----------------------------------------------

