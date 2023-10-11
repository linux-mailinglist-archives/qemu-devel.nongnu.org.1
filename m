Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2407C56AA
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:21:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa5U-0002Vj-Rl; Wed, 11 Oct 2023 10:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqa5P-0002TC-2E
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqa5M-0001xu-J4
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPeR+3BqL/3G6jsEcBeUtOsQNf3MRwxQ+Q0BcH5+UKA=;
 b=ausrUrRr8HZcBotRyRbWRcLrXqsLSVBbSY3KkjHuk/wP3sKufcfQS+BxnL7O1/Qw7yObjC
 1RHXpYR3eLxKAaTXNvDrGsnesJZ5AqnT5ZCQ9InWPmPP208EFuQsfSZvC0nF2MDVgq9Hwf
 dUfyE7O5t8FeTbqsBXC96AmgYRpHhsY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-XhhpKgNaPHqhmEAWYUM1aA-1; Wed, 11 Oct 2023 10:21:04 -0400
X-MC-Unique: XhhpKgNaPHqhmEAWYUM1aA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D896D38125AB;
 Wed, 11 Oct 2023 14:21:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AF63C0F789;
 Wed, 11 Oct 2023 14:21:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E4F721E6904; Wed, 11 Oct 2023 16:21:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org>
Date: Wed, 11 Oct 2023 16:21:02 +0200
In-Reply-To: <875y3dixzp.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 11 Oct 2023 06:28:26 +0200")
Message-ID: <8734yhgrzl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Markus Armbruster <armbru@redhat.com> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> Hi, Markus,
>>
>> On Tue, Oct 10, 2023 at 09:18:23PM +0200, Markus Armbruster wrote:
>>
>> [...]
>>
>>> >> The point I was trying to make is this.  Before the patch, we reject
>>> >> attempts to set the property value to null.  Afterwards, we accept them,
>>> >> i.e. the patch loses "reject null property value".  If this loss is
>>> >> undesirable, we better replace it with suitable hand-written code.
>>> >
>>> > I don't even know how to set it to NULL before.. as it can only be accessed
>>> > via cmdline "-global" as mentioned above, which must be a string anyway.
>>> > So I assume this is not an issue.
>>> 
>>> Something like
>>> 
>>>     {"execute": "migrate-set-parameters",
>>>      "arguments": {"tls-authz": null}}
>>> 
>>> Hmm, crashes in migrate_params_apply(), which is a bug.  I'm getting
>>> more and more suspicious about user-facing migration code...
>>
>> Did you apply patch 1 of this series?
>
> Since we're talking about "how to set it to NULL before", I was using
> master.
>
>> https://lore.kernel.org/qemu-devel/20230905162335.235619-2-peterx@redhat.com/
>>
>> QMP "migrate-set-parameters" does not go via migration_properties, so even
>> if we change handling of migration_properties, it shouldn't yet affect the
>> QMP interface of that.
>
> I see.
>
> I want to understand the impact of the change from 'str' to 'StrOrNull'
> on external interfaces.  The first step is to know where exactly the
> type is exposed externally.  *Know*, not gut-feel based on intended use.
>
> I'll have another look at the schema change, and how the types are used.

Schema changes:

1. Change MigrationParameters members @tls-creds, @tls-hostname,
   @tls-authz from 'str' to 'StrOrNull'

2. Replace MigrateSetParameters by MigrationParameters.

   No change, since they are identical after change 1.

To determine the patch's impact, we need to examine uses of
MigrationParameters members @tls-FOO before the patch.  These are:

* Return type of query-migrate-parameters

  Introspection shows the type change: the type's set of values now
  includes JSON null.

  Is JSON null possible?  See [*] below.

* migrate_params_init()

  Before the patch, we initialize to "".

  Afterwards, we initialize to "" wrapped in a StrOrNull.

  The initial value means "off" before and after.

* migrate_params_check()

  An error check gets updated.  Ignoring for now.

* migrate_params_test_apply()

  Function deleted in the patch, but you wrote that's wrong.  Ignoring
  for now.

* migrate_params_apply()

  Duplicates the three parameters from argument @parameters into the
  migration object's member parameters.

  Argument @parameters comes from QMP via command
  migrate-set-parameters.  Before the patch,
  qmp_migrate_set_parameters() maps JSON null values to "".  Afterwards,
  it passes the values verbatim.

  Parameters stored in the migration object before and after the patch:

  - When initialized and never changed: char * "", and StrOrNull
    QTYPE_QSTRING "".

  - When set to non-empty string with migrate-set-parameters or
    equivalent: that non-empty string, and QTYPE_QSTRING with that
    non-empty string.

  - When reset with migrate-set-parameters with value "": "", and
    QTYPE_QSTRING "".

  - When reset with migrate-set-parameters with value null: "", and
    QTYPE_QNULL.

  Note that there's now a difference between passing "" and null to
  migrate-set-parameters: the former results in value QTYPE_QSTRING "",
  the latter QTYPE_QNULL.  Both values mean "off".  I hate this.  I very
  much want a single C representation of "off".

* MigrationState member @parameters.

  Uses:

  - Properties "tls-creds", "tls-hostname", "tls-authz"

    These are externally accessible with -global.  The additional null
    value is not accessible there: string input visitor limitation.  It
    could become accessible depending on how we fix the crash bugs
    related to that limitation, but we can worry about that when we do
    it.

    Digression: why do these properties even exist?  I believe we
    created the "migration" (pseudo-)device just so we can use "compat
    props" to apply machine- and accelerator-specific configuration
    tweaks.  We then added configuration for *all* configuration
    parameters, not just the ones that need tweaking.  The external
    exposure of properties via -global is not something we wanted, it
    just came with the part we wanted (compat props).  Accidental
    external interface.  Ugh.

    None of the tls-FOO are tweaked via compat props, so no worries
    there.

    I believe property access with qom-get and qom-set is not possible,
    because the migration object is not part to the QOM tree, and
    therefore is not reachable via any QOM path.  Aside: feels like
    abuse of QOM.

    It's also not part of the device tree rooted at the main system bus,
    which means it isn't visible in "info qtree".  It is visible in
    "info qdm", "device_add migration,help", and "-device
    migration,help".  Output of the latter two changes.  All harmless.

    I *think* that's all.

  - migrate_tls(), migrate_tls_authz(), migrate_tls_creds(),
    migrate_tls_hostname()

    Before the patch, these return the respective migration parameter
    directly.  I believe the value is never NULL.  Value "" is special
    and means "off".

    After the patch, these return the respective migration parameter
    when it's a non-empty QTYPE_QSTRING, else NULL.  Value NULL means
    off.

    Note this maps both C representations of "off" to NULL.

    This changes the return value for "off" from "" to NULL.
    Improvement, because it results in a more pleasant "is off" check.

  - qmp_query_migrate_parameters()

    The three tls_FOO get duplicated into the return value.

    Looks like the two different C representations of "off" bleed into
    QMP (ugh!), and [*] JSON null is possible (incompatible change).

* hmp_info_migrate_parameters()

  The two different C representations of "off" are first mapped to NULL
  with str_from_StrOrNull(), and then mapped to "" with a ?: operator.
  Works.

Bottom line:

* Affected external interfaces:

  - query-migrate-parameters: can now return either "" or null when TLS
    is off.  null is an incompatible change.  Needs fixing.

  - query-qmp-schema: shows null is now possible.  Correctly reflects
    the backward incompatible change.  If we fix compatibility break, we
    get a tolerable loss of typing precision instead.

2. Two different C representations of "off".  Strong dislike.  I
   recommend to fix the compatibility break by switching to a single C
   representation.

Thoughts?

[...]


