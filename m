Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE094838621
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 04:44:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS7gs-0001pb-9L; Mon, 22 Jan 2024 22:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rS7gp-0001pB-QI
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 22:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rS7gn-0004Wu-7G
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 22:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705981384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5n2SgZvEsWE4l0OqHrWLoGxflp/2mgCQLU3pNSinj4c=;
 b=HSc02yntaTGnYtqlMvM3oa78qPABSADsl6RQK9ZBRa1iS2mk4DhiVEFY+3p/4kVpQmW71z
 1mBGtWZBCU7jmqYzo2eKoROCUBauZWLC5XTypKD0bcyE2OY4XeC4qWYJ82Su5dosMIRP6+
 WRIX1fSAvGI/t24dN/4W9Ry7oUuv7/8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-e7DGJNftOlS5r960xQQrTg-1; Mon, 22 Jan 2024 22:43:02 -0500
X-MC-Unique: e7DGJNftOlS5r960xQQrTg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d99cdbeb9dso1147567b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 19:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705981381; x=1706586181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5n2SgZvEsWE4l0OqHrWLoGxflp/2mgCQLU3pNSinj4c=;
 b=HaZncJqhasXD3vt9VJBbLlhL/hgaryf4ojtwy8tKbmPCLiuVehpd3DMHZjpYlPRoEg
 aVFWqddriugU0+vlonh5ilZogCHNuvFYeeIjM/7DETvWrDCjlZzqRc+RBTQkpqrdNpo5
 2Hktyh57tVhB32EYw1Kx1AJaHN+K5Wt+ZRHC6UxofD/KImoiwu504VQKoSeGJxUjW3yy
 UCuQ7cBQxjoVwKvAWZoiW+qcOJOgLyniOHaNfnkIlHRDFKrd7rqCUCmlWYrPsWwZjfRT
 U4TylXp/nt2VmIhrJ4BggcntafE7CwhVt/zvPyJLNM6cKl0xIXlPw/E/VeTR4vTE9xIJ
 /IRQ==
X-Gm-Message-State: AOJu0YzTmlc1cOrnbdGE6a8/K9VEd5HP3PGv8of204+mvylgIhWiJkRI
 hQuBCIu6rF5a3JPD7TGk3kfCff9yodgqLvQU3LcCjt3QbiUtxJ3L9PW+d2xFvQWCBI4yFPwVbUO
 kaoW4w2dj6SZ0DGRBLjcSUN0BOcLxTMNQD0QHbq+kc0m5lqNQYVeA
X-Received: by 2002:a05:6a20:438d:b0:19a:e152:656 with SMTP id
 i13-20020a056a20438d00b0019ae1520656mr13735649pzl.3.1705981380721; 
 Mon, 22 Jan 2024 19:43:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/sncKGx0q6QIg8lXCGLjGxmNnmKHigQHtAXLp9JmV0hyNS8CzY0Wk3+MsWQ6rq7diMs/5aA==
X-Received: by 2002:a05:6a20:438d:b0:19a:e152:656 with SMTP id
 i13-20020a056a20438d00b0019ae1520656mr13735635pzl.3.1705981380301; 
 Mon, 22 Jan 2024 19:43:00 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 mn11-20020a1709030a4b00b001d6f891535fsm5996001plb.163.2024.01.22.19.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 19:43:00 -0800 (PST)
Date: Tue, 23 Jan 2024 11:42:52 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
Message-ID: <Za81vJgTjFSGT56r@x1n>
References: <20240122070600.16681-1-peterx@redhat.com> <87plxtgyxx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plxtgyxx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 22, 2024 at 12:39:06PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > The current article is not extremely easy to follow, and may contain too
> > much information for someone looking for solutions on VMSD compatibility
> > issues.  Meanwhile, VMSD versioning is not discussed.
> >
> > I'm not yet sure whether we should just obsolete VMSD versioning; it's
> > still used quite a lot.  And I had a feeling that for simple use cases
> > where backward migration is not strongly required, device developers can
> > still consider using it.  So in this patch I decided to keep it (anyway, we
> > can't drop it in the near future because of massive existing users), and we
> > can still allow user to use it in contexts where forward-only migration
> > might be enough.
> >
> > This doc patch does below changes:
> >
> >   - Rename the page from "Backward compatibility" to "Migration
> >   compatibility", to avoid using "backward" as a word (because we'll want
> >   to identify "forward" / "backward" migrations in the new doc)
> >
> >   - Add a TOC for this page for better indexing
> >
> >   - A new section to explain what is forward/backward migration
> >
> >   - A new small section for VMSD just to make things complete
> >
> >   - Explain the two ways to make VMSD compatible with old qemu binaries
> >
> >     For this one, I added a small section on how to use VMSD versioning for
> >     new fields just to start such documents.  Rename the old "How backwards
> >     compatibility works" section to "machine type based (forward+backward
> >     migration)" to be the 2nd solution (I called it machine type based
> >     solution). When at it, I provided a summary and a TODO for the 2nd
> >     solution.
> >
> >   - A new section to explain which solution to choose
> >
> >   - Moved the other two existing sections into "Extended readings", because
> >   they can be even further away to most device developers
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  docs/devel/migration/compatibility.rst | 140 ++++++++++++++++++++++++-
> >  1 file changed, 137 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
> > index 5a5417ef06..ea9da201ef 100644
> > --- a/docs/devel/migration/compatibility.rst
> > +++ b/docs/devel/migration/compatibility.rst
> > @@ -1,8 +1,139 @@
> > -Backwards compatibility
> >  =======================
> > +Migration compatibility
> > +=======================
> > +
> > +Migration is a hard topic sometimes.  One of the major reason is that it
> > +has a strict compatibility requirement - a migration (live or not) can
> > +happen between two different versions of QEMUs, so QEMU needs to make sure
> 
> S/QEMUs/QEMU/

I'll fix all these up that you suggested as English issues.

> 
> > +the migration can work across different versions of QEMU binaries.
> > +
> > +This document majorly discusses the compatibility requirement of forward /
> 
> s/majorly/mainly/
> 
> > +backward migrations that QEMU need to maintain, and what QEMU developers
> 
> s/need/needs/
> 
> > +should do to achieve such compatibility requirements across different QEMU
> 
> maybe s/achieve/maintain/ ?
> 
> > +versions.
> > +
> > +.. contents::
> > +
> > +Types of migrations (forward / backward)
> > +========================================
> > +
> > +Let's firstly define the terms **forward migration** and **backward
> > +migration**.
> > +
> > +.. note::
> > +
> > +    To simplify the use case, we always discuss between two consecutive
> > +    versions of QEMU major releases (between QEMU version *N* and QEMU
> > +    version *N-1*).  But logically it applies to the case where the two
> > +    QEMU binaries involved contains more than one major version difference.
> > +
> > +.. _forward_migration:
> > +
> > +**Forward migration**: can be seen as the use case where a VM cluster can
> > +upgrade its nodes to a newer version of QEMU (version *N*) from an older
> > +version of QEMU (version *N-1*).
> > +
> > +.. _backward_migration:
> > +
> > +**Backward migration**: can be seen as the use case where a VM cluster
> > +would like to migrate from a newer version of QEMU (version *N*) back to an
> > +even older version of QEMU (version *N-1*).
> 
> I'd drop the VM cluster part from these. Define the terms in a more
> strict manner (QEMU versions, n/n-1, that's it). Then the parts below
> could be second paragraphs further detailing the use-cases of the two
> types of migration.

OK.

> 
> > +
> > +A forward migration is more common, where system upgrades are needed.  In
> > +this case, the upgrade can be done seamlessly by live migrating the old VMs
> > +to the new VMs with the new binaries.
> 
> I got a bit confused whether this was describing migration to a
> different host or within the same host. I suggest we spell it out some
> more:

It can be same-host or across-host.

> 
> "live migrating an existing VM that uses an old QEMU binary to another
> VM using the newly updated QEMU binary."

Even though I don't see a major difference on how it was reworded.. but I
can use your version here.

> 
> > +
> > +A backward migration can be less common OTOH, because downgrade is less
> > +common than upgrade for whatever reasons.  However for a production level
> > +system setup, this should also be allowed, because a cluster can contain
> > +different versions of QEMU binary.  It should be always allowed to migrate
> > +between old and new hosts as long as the machine type is supported across
> > +all the relevant hosts / nodes.
> > +
> > +VMState description data structure (VMSD)
> > +=========================================
> > +
> > +VMSD (or in the complete form, **VMStateDescription**) is the data
> > +structure that QEMU uses to describe data to be migrated for devices.
> > +Each device should provide its own VMSD structure to describe what it needs
> > +to be migrated when a VM live migration is requested.
> > +
> > +Device VMSD compatibility
> > +=========================
> > +
> > +Then if the VMSD structures need changing, how does the device maintain
> > +compatibilty?
> 
> s/compatibilty/compatibility/
> 
> Hm, there's a logical jump here from the _device_ changing to this
> requiring a change in the VMSD. Also the device is not the thing that
> maintains compatibility. Again we might need to spell it out:
> 
> "When a device data needs to change from one QEMU version to another,
> how to maintain compatibility?" ... or something like this

OK.

> 
> >  
> > -How backwards compatibility works
> > ----------------------------------
> > +Here we only discuss VMSD-based migrations.  If one device is not using
> > +VMSD to migrate its device data, it's considered part of "advanced users",
> > +then this document may not apply anymore.  If you're writting a new device,
> > +please always consider starting with VMSD-based migration model.
> > +
> > +Consider the case where a device can start to support a new feature in the
> > +current release, where it wasn't supported before.  The new feature may
> 
> s/, where it/ that/
> 
> > +require some new device states to be migrated (which can be new VMSD fields
> > +to be added, or new subsections).  The same question needs to be answered
> > +when one would like to modify an existing VMSD fields / layouts to fix a
> 
> s/an //
> 
> > +bug, and so on.
> > +
> > +Depending on the goal, the solution to this problem may vary.
> > +
> > +If one would like to provide a full support of migration between whatever
> > +versions, one can try to implement it using :ref:`machine_type_compat`
> > +solution.  If one would like to provide a fundamental upgrade-only
> > +compatibility, one could consider to use the simpler
> > +:ref:`vmsd_versioning_compat` solution.
> 
> Should this whole paragraph be put before mentioning VMSD? Otherwise
> here we are talking about machine type compat after having said: "Here
> we only discuss VMSD-based migrations".

Note that even with the machine compat properties solution we mentioned
below, the device will still need some VMSD entry changes, and VMSD is
still the core of the problem.

The difference is instead of using VMSD versioning, one may need to link
the VMSD entry to the machine compat properties via either:

  - VMStateDescription.needed(), as a sub-vmsd or,

  - VMStateField.field_exists() as a vmsd field.

That's why I want to keep VMSD a separate section, because it's always the
core of the problem, no matter for either of the two solutions below.

> 
> All in all this could be:
> 
> up top:
> Migration compatibility strategies
> ==================================
> 
> When a device data needs to change from one QEMU version to another, how
> to maintain compatibility?
> 
> Depending on the goal, the solution to this problem may vary.
> 
> If one would like to provide a full support of migration between
> arbitrary versions, one can try to implement it using
> :ref:`machine_type_compat` solution.  If one would like to provide a
> fundamental upgrade-only compatibility, one could consider to use the
> simpler :ref:`vmsd_versioning_compat` solution.
> 
> VMState description data structure (VMSD)
> -----------------------------------------
> 
> VMSD (or in the complete form, **VMStateDescription**) is the data ...
> ...
> 
> Machine type properties
> -----------------------
> 
> The QEMU machine type is versioned (-machine q35 resolves is equivalent
> to pc-q35-9.0) and has properties that can be set to different values
> across machine versions. Those can be used to enable/disable different
> parts of the code and can be used to help migration compatibility.

Some statement on machine types may be good, but I'm afraid then we'll also
need to describe more on machine compat properties, which is IMHO even more
important.  That part is actually more or less covered by the old document
below (which is pretty long that Juan drafted just a while ago).  That's
why I didn't mention much on machine types here, leaving that for the rest.

PS: I added a "TODO" though right below for a possible future rewrite [1].
The current explanation is, IMHO, too much, and not as clear.

The major goal of this doc patch is adding vmsd versioning into the
picutre, and describe both solutions we can use, while in Juan's old
version there's no mention of VMSD versioning.  The ultimate goal is in the
future we can share the doc to other developers when asking similar
questions.

Since we're at it, I would also like to know how you think about whether we
should still suggest people using VMSD versioning, as we know that it won't
work for backward migrations.

My current thoughts is it is still fine, as it's easier to use, and it
should still be applicable to the cases where a strict migration semantics
are not required.  However it's hard to justify which device needs that
strictness.

For example, any device to be used in migration-test must be forward +
backward migration compatible at least, because you just added the n-1
regression tests to cover both directions.  Said that, only a few devices
are involved because currently our migration-test qemu cmdline is pretty
simple.

Fundamentally, IMHO it's because QEMU as a project is used both in
enterprise and personal emulations.  I think it might be too strict to
always request backward migration capability if we know some device / arch
is only used for personal, or educational, purposes.

The other reason is so far using machine compat properties can sometimes be
complicated, and I'm not sure whether it's worthwhile we keep requesting
that to device developers.  Maybe some day we can provide some VMSD macros
to make that even easier, then we can obsolete VMSD versionings.  But I
haven't really thought it through.

> 
> Migration compatibility solutions
> =================================
> 
> VMSD versioning (forward migration only)
> ----------------------------------------
> ...
> 
> Machine type based (forward+backward migration)
> -----------------------------------------------
> ...
> 
> > +
> > +Solutions
> > +=========
> > +
> > +.. _vmsd_versioning_compat:
> > +
> > +VMSD versioning (forward migration only)
> > +----------------------------------------
> > +
> > +This is normally the simplest way to support cross-version QEMU live
> > +migration. The trade-off is backward migration will not be supported. It
> > +means migrations from new QEMU binaries to old QEMU binaries can fail. It's
> > +because even if the new QEMU can understand the old version of VMSD by
> > +proper versioning of the VMSD fields, the old QEMU will not be able to
> > +understand the new version of VMSD layout.  Then when someone migrates a VM
> > +using the new VMSD to an older version of QEMU, the old QEMU will not
> > +accept the new migration stream, reporting that the VSMD version too new.
> 
> But we still have _some_ form of backward compat for _some_ kinds of
> problems by using dummy fields in the VMSD for instance, right?

Just to make sure we're on the same page: UNUSED is definitely needed for
forward migration, since if without those the old stream will still contain
the removed field, which on the new binary will be wrongly recognized as
the "next" field if ever existed, or "extra / unknown" fields, probably
messing up the next device state.

For backward, I assume it only works if all-zero is a valid state first on
that field being removed on the old binary.  Otherwise it might still fail
in weird ways, afaiu.  For that, I'd say that shouldn't be stated as
supported either as a general approach.

> 
> > +
> > +Please have a look at **include/migration/vmstate.h** for more information
> > +on how to use VMSD versioning.
> > +
> > +Taking an example of adding a new field for migration.  The change will
> > +need to at least contain two parts:
> > +
> > +  - Boost existing VMSD version.
> > +
> > +  - Add the new VMSD field with the boosted version, with specific
> > +    **VMSTATE_\*_V()** macros.  For example, **VMSTATE_UINT8_V()** will
> > +    define an uint8 typed VMSD field with version specified.
> > +
> > +.. _machine_type_compat:
> > +
> > +Machine type based (forward+backward migration)
> > +-----------------------------------------------
> > +
> > +QEMU developers can leverage machine type compatibile properties to provide
> 
> compatible
> 
> > +a fully migratable device / protocol, so the migration behavior will be
> > +defined by the machine type, no matter which QEMU binary will be used.  One
> > +can reference the entries defined in **hw_compat_\*** global properties for
> > +examples.
> > +
> > +Comparing to VMSD versioning approach above, this may require more code
> > +changes, but provide a higher level of compatibility that is bound to the
> > +machine type being used.  To be explicit, since the migration behavior is
> > +bound to machine type, it will support both forward migration and backward
> > +migration as long as the machine type is supported.
> > +
> > +.. note::
> > +
> > +   Currently this section is pretty long.  TODO: rewrite this section to
> > +   make it easier for QEMU developers to understand.

[1]

> >  
> >  When we do migration, we have two QEMU processes: the source and the
> >  target.  There are two cases, they are the same version or they are
> > @@ -217,6 +348,9 @@ machine types to have the right value::
> >           ...
> >       };
> >  
> > +Extended readings
> > +=================
> > +
> >  A device with different features on both sides
> >  ----------------------------------------------
> 

-- 
Peter Xu


