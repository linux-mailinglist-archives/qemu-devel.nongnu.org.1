Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EFE7C76C3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 21:30:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr1MW-0008K8-0d; Thu, 12 Oct 2023 15:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qr1MT-0008Jr-Ti
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 15:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qr1MS-0007wS-0H
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 15:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697138922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lhltgJBDnVJ953ZdWewd5u/x/jCvFQ3s9uExn5uyUY=;
 b=UlMWDYX+DoGxFymm26BAqJ9eSdj46F8GJwd8Tp2hIDPF6bZsnDyl6DAOm8YYxsisno96Xi
 zTNgSyzP6Oqkig1GT/YVxSvCSLORpg+SUl/c6UaSyQ6JmWn4smSJO3LNl9Ef+pLz/69dYb
 RMDJiKgAJjR7RTAgm87zn836YFgJ7Ck=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-Ev8eN2KBNAqOVowPckre7Q-1; Thu, 12 Oct 2023 15:28:36 -0400
X-MC-Unique: Ev8eN2KBNAqOVowPckre7Q-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6c4e17f5b1bso286130a34.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 12:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697138915; x=1697743715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lhltgJBDnVJ953ZdWewd5u/x/jCvFQ3s9uExn5uyUY=;
 b=nXngDILFzr9nV4nSa9xlVG5lS7+FTXhujfgRuGgIO3zT3pUdL8+ezs0R2jJq1Jv7nu
 jtLKg8OYoUzrE0QIcSHmGKgmc8aHVKHLXLuJ2H7ltSNvILfJVUp/m/gqtBljMx6XKFND
 0id9YolyQUPGCrjsFtMvPTTOTD+wD1oOYDf+lgzqWsEN7fTSKVRWCQ6/KExQR3ng7qQM
 0gWY/y6DjQARyJWMeJvtU2WGVsj867iowhapv8eUXCPuej70S65TcU35t10h64K4CRE6
 LC1n3dCnTtrmSUmKGWgE+r7TzodWhwKnv1+jDtOT7sErCxrGnLea3gCTvCKNr3IMMTHU
 VErw==
X-Gm-Message-State: AOJu0YxNyjL2pYkINdr9uQKQpVwIgxjiJpBQqi86Tox6zMbm+Txdaovh
 jNplauTnMtEyaH0+4hr4CUEhDcXDXRZYoRPgrVA3h+l7lEpNgdFJpq5HdKEutis/oF/2WvSsJE1
 4laYMCpw7qCpksqw=
X-Received: by 2002:a05:6870:bacf:b0:1e9:8ab9:11ca with SMTP id
 js15-20020a056870bacf00b001e98ab911camr6579582oab.3.1697138915656; 
 Thu, 12 Oct 2023 12:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5VPQj4X5OItz9g60zXxmh9rFeXt+xUsCMgpEoC/RmVVLQ/1wvMrPCjM/z4kCDsw4P802zvQ==
X-Received: by 2002:a05:6870:bacf:b0:1e9:8ab9:11ca with SMTP id
 js15-20020a056870bacf00b001e98ab911camr6579568oab.3.1697138915286; 
 Thu, 12 Oct 2023 12:28:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 kq19-20020ac86193000000b00405502aaf76sm29577qtb.57.2023.10.12.12.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 12:28:34 -0700 (PDT)
Date: Thu, 12 Oct 2023 15:28:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
Message-ID: <ZShI4AucDGvUvJiS@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734yhgrzl.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 11, 2023 at 04:21:02PM +0200, Markus Armbruster wrote:
> > I'll have another look at the schema change, and how the types are used.
> 
> Schema changes:
> 
> 1. Change MigrationParameters members @tls-creds, @tls-hostname,
>    @tls-authz from 'str' to 'StrOrNull'
> 
> 2. Replace MigrateSetParameters by MigrationParameters.
> 
>    No change, since they are identical after change 1.
> 
> To determine the patch's impact, we need to examine uses of
> MigrationParameters members @tls-FOO before the patch.  These are:
> 
> * Return type of query-migrate-parameters
> 
>   Introspection shows the type change: the type's set of values now
>   includes JSON null.
> 
>   Is JSON null possible?  See [*] below.
> 
> * migrate_params_init()
> 
>   Before the patch, we initialize to "".
> 
>   Afterwards, we initialize to "" wrapped in a StrOrNull.
> 
>   The initial value means "off" before and after.
> 
> * migrate_params_check()
> 
>   An error check gets updated.  Ignoring for now.
> 
> * migrate_params_test_apply()
> 
>   Function deleted in the patch, but you wrote that's wrong.  Ignoring
>   for now.
> 
> * migrate_params_apply()
> 
>   Duplicates the three parameters from argument @parameters into the
>   migration object's member parameters.
> 
>   Argument @parameters comes from QMP via command
>   migrate-set-parameters.  Before the patch,
>   qmp_migrate_set_parameters() maps JSON null values to "".  Afterwards,
>   it passes the values verbatim.
> 
>   Parameters stored in the migration object before and after the patch:
> 
>   - When initialized and never changed: char * "", and StrOrNull
>     QTYPE_QSTRING "".
> 
>   - When set to non-empty string with migrate-set-parameters or
>     equivalent: that non-empty string, and QTYPE_QSTRING with that
>     non-empty string.
> 
>   - When reset with migrate-set-parameters with value "": "", and
>     QTYPE_QSTRING "".
> 
>   - When reset with migrate-set-parameters with value null: "", and
>     QTYPE_QNULL.
> 
>   Note that there's now a difference between passing "" and null to
>   migrate-set-parameters: the former results in value QTYPE_QSTRING "",
>   the latter QTYPE_QNULL.  Both values mean "off".  I hate this.  I very
>   much want a single C representation of "off".

Yes.

One option to avoid such ugliness is we keep using strings for tls fields,
then the only OFF is empty string.  It is not perfect either, but we need
to support empty string anyway as OFF.  That's the simplest to me.

We also have the benefit of decoupling this series from the qapi string
visitor issue, which means I'll just revive v1 which still doesn't use
StrOrNull.

> 
> * MigrationState member @parameters.
> 
>   Uses:
> 
>   - Properties "tls-creds", "tls-hostname", "tls-authz"
> 
>     These are externally accessible with -global.  The additional null
>     value is not accessible there: string input visitor limitation.  It
>     could become accessible depending on how we fix the crash bugs
>     related to that limitation, but we can worry about that when we do
>     it.
> 
>     Digression: why do these properties even exist?  I believe we
>     created the "migration" (pseudo-)device just so we can use "compat
>     props" to apply machine- and accelerator-specific configuration
>     tweaks.  We then added configuration for *all* configuration
>     parameters, not just the ones that need tweaking.  The external
>     exposure of properties via -global is not something we wanted, it
>     just came with the part we wanted (compat props).  Accidental
>     external interface.  Ugh.

IIRC both of them used to be the goals: either allow compat properties for
old machine types, or specify migration parameters in cmdline for easier
debugging and tests.  I use "-global" in mostly every migration test script
after it's introduced.

> 
>     None of the tls-FOO are tweaked via compat props, so no worries
>     there.
> 
>     I believe property access with qom-get and qom-set is not possible,
>     because the migration object is not part to the QOM tree, and
>     therefore is not reachable via any QOM path.  Aside: feels like
>     abuse of QOM.

Yes slightly abused, as the comment shows..

static const TypeInfo migration_type = {
    .name = TYPE_MIGRATION,
    /*
     * NOTE: TYPE_MIGRATION is not really a device, as the object is
     * not created using qdev_new(), it is not attached to the qdev
     * device tree, and it is never realized.
     *
     * TODO: Make this TYPE_OBJECT once QOM provides something like
     * TYPE_DEVICE's "-global" properties.
     */
    .parent = TYPE_DEVICE,

It's just that current code works mostly as expected without much churns
elsewhere.. so the TODO is not really getting much attention..

> 
>     It's also not part of the device tree rooted at the main system bus,
>     which means it isn't visible in "info qtree".  It is visible in
>     "info qdm", "device_add migration,help", and "-device
>     migration,help".  Output of the latter two changes.  All harmless.
> 
>     I *think* that's all.
> 
>   - migrate_tls(), migrate_tls_authz(), migrate_tls_creds(),
>     migrate_tls_hostname()
> 
>     Before the patch, these return the respective migration parameter
>     directly.  I believe the value is never NULL.  Value "" is special
>     and means "off".
> 
>     After the patch, these return the respective migration parameter
>     when it's a non-empty QTYPE_QSTRING, else NULL.  Value NULL means
>     off.
> 
>     Note this maps both C representations of "off" to NULL.
> 
>     This changes the return value for "off" from "" to NULL.
>     Improvement, because it results in a more pleasant "is off" check.

Maybe more than pleasant. :) Internally NULL is a must (even if empty
string), to make things like "if (tls_authz)" work.

> 
>   - qmp_query_migrate_parameters()
> 
>     The three tls_FOO get duplicated into the return value.
> 
>     Looks like the two different C representations of "off" bleed into
>     QMP (ugh!), and [*] JSON null is possible (incompatible change).
> 
> * hmp_info_migrate_parameters()
> 
>   The two different C representations of "off" are first mapped to NULL
>   with str_from_StrOrNull(), and then mapped to "" with a ?: operator.
>   Works.
> 
> Bottom line:
> 
> * Affected external interfaces:
> 
>   - query-migrate-parameters: can now return either "" or null when TLS
>     is off.  null is an incompatible change.  Needs fixing.

If we want to seriously keep using StrOrNull as the interface, I think we
need to allow both NULL or "" to exist?  Because the "logical goal" is to
use NULL but "" for compatibility?

I worry we spend a lot of time working on the NULL/"" but then found nobody
is using NULL anyway.

> 
>   - query-qmp-schema: shows null is now possible.  Correctly reflects
>     the backward incompatible change.  If we fix compatibility break, we
>     get a tolerable loss of typing precision instead.
> 
> 2. Two different C representations of "off".  Strong dislike.  I
>    recommend to fix the compatibility break by switching to a single C
>    representation.

IIUC the goal is to switch to StrOrNull, but that face challenge.

> 
> Thoughts?

If I'd vote (based on our current code), I'd double check tls* fields are
working properly with libvirt on empty strings, then switch all StrOrNull
in migration parameters to strings, for both QAPI and QEMU internally.
Then making sure all migrate_tls_*() helpers do proper job on converting ""
to NULL.

If we design a new interface, just remember to use NULL (hopefully) to be
clear and single way to say "OFF" starting from the 1st day.

But that's only my 2 cents.

Thanks,

-- 
Peter Xu


