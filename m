Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3707C7D15
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 07:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrArB-0007Hr-Be; Fri, 13 Oct 2023 01:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrAr9-0007HT-Ie
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrAr3-0003m7-LN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697175415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ilw1ZyqJuotyp+EiHBcBBYNZUvzEII5uG+IN1Fq5KgE=;
 b=gQ65fqQKeNyYn7vEbM9bp8GYyK2kDLZuMN0HWXo02+1iWBh7XlT89ohFtNy7olYmYkLzaF
 csSmSYil0E5LKhWPu1106KJm/GHm0FHF74F/cbNRvG0ko/MZVwxZRs6lqn8X+MVbf2u8HU
 T+UHxSzfAq+jXNcxnHCM5DEklKJdDoU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-tgbGj3VvODSXGFZgvoraow-1; Fri, 13 Oct 2023 01:36:52 -0400
X-MC-Unique: tgbGj3VvODSXGFZgvoraow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 818EF85A5BA;
 Fri, 13 Oct 2023 05:36:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EA324021CE;
 Fri, 13 Oct 2023 05:36:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 379CE21E6A22; Fri, 13 Oct 2023 07:36:50 +0200 (CEST)
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
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n>
Date: Fri, 13 Oct 2023 07:36:50 +0200
In-Reply-To: <ZShI4AucDGvUvJiS@x1n> (Peter Xu's message of "Thu, 12 Oct 2023
 15:28:32 -0400")
Message-ID: <877cnrjd71.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Oct 11, 2023 at 04:21:02PM +0200, Markus Armbruster wrote:
>> > I'll have another look at the schema change, and how the types are used.
>> 
>> Schema changes:
>> 
>> 1. Change MigrationParameters members @tls-creds, @tls-hostname,
>>    @tls-authz from 'str' to 'StrOrNull'
>> 
>> 2. Replace MigrateSetParameters by MigrationParameters.
>> 
>>    No change, since they are identical after change 1.
>> 
>> To determine the patch's impact, we need to examine uses of
>> MigrationParameters members @tls-FOO before the patch.  These are:
>> 
>> * Return type of query-migrate-parameters
>> 
>>   Introspection shows the type change: the type's set of values now
>>   includes JSON null.
>> 
>>   Is JSON null possible?  See [*] below.
>> 
>> * migrate_params_init()
>> 
>>   Before the patch, we initialize to "".
>> 
>>   Afterwards, we initialize to "" wrapped in a StrOrNull.
>> 
>>   The initial value means "off" before and after.
>> 
>> * migrate_params_check()
>> 
>>   An error check gets updated.  Ignoring for now.
>> 
>> * migrate_params_test_apply()
>> 
>>   Function deleted in the patch, but you wrote that's wrong.  Ignoring
>>   for now.
>> 
>> * migrate_params_apply()
>> 
>>   Duplicates the three parameters from argument @parameters into the
>>   migration object's member parameters.
>> 
>>   Argument @parameters comes from QMP via command
>>   migrate-set-parameters.  Before the patch,
>>   qmp_migrate_set_parameters() maps JSON null values to "".  Afterwards,
>>   it passes the values verbatim.
>> 
>>   Parameters stored in the migration object before and after the patch:
>> 
>>   - When initialized and never changed: char * "", and StrOrNull
>>     QTYPE_QSTRING "".
>> 
>>   - When set to non-empty string with migrate-set-parameters or
>>     equivalent: that non-empty string, and QTYPE_QSTRING with that
>>     non-empty string.
>> 
>>   - When reset with migrate-set-parameters with value "": "", and
>>     QTYPE_QSTRING "".
>> 
>>   - When reset with migrate-set-parameters with value null: "", and
>>     QTYPE_QNULL.
>> 
>>   Note that there's now a difference between passing "" and null to
>>   migrate-set-parameters: the former results in value QTYPE_QSTRING "",
>>   the latter QTYPE_QNULL.  Both values mean "off".  I hate this.  I very
>>   much want a single C representation of "off".
>
> Yes.
>
> One option to avoid such ugliness is we keep using strings for tls fields,
> then the only OFF is empty string.  It is not perfect either, but we need
> to support empty string anyway as OFF.  That's the simplest to me.
>
> We also have the benefit of decoupling this series from the qapi string
> visitor issue, which means I'll just revive v1 which still doesn't use
> StrOrNull.

Another option is to keep the schema as is, but normalize the two "off"
values to just one value on assignment.

>> 
>> * MigrationState member @parameters.
>> 
>>   Uses:
>> 
>>   - Properties "tls-creds", "tls-hostname", "tls-authz"
>> 
>>     These are externally accessible with -global.  The additional null
>>     value is not accessible there: string input visitor limitation.  It
>>     could become accessible depending on how we fix the crash bugs
>>     related to that limitation, but we can worry about that when we do
>>     it.
>> 
>>     Digression: why do these properties even exist?  I believe we
>>     created the "migration" (pseudo-)device just so we can use "compat
>>     props" to apply machine- and accelerator-specific configuration
>>     tweaks.  We then added configuration for *all* configuration
>>     parameters, not just the ones that need tweaking.  The external
>>     exposure of properties via -global is not something we wanted, it
>>     just came with the part we wanted (compat props).  Accidental
>>     external interface.  Ugh.
>
> IIRC both of them used to be the goals: either allow compat properties for
> old machine types, or specify migration parameters in cmdline for easier
> debugging and tests.  I use "-global" in mostly every migration test script
> after it's introduced.

You use -global just because it's easier than using monitor commands,
correct?

>>     None of the tls-FOO are tweaked via compat props, so no worries
>>     there.
>> 
>>     I believe property access with qom-get and qom-set is not possible,
>>     because the migration object is not part to the QOM tree, and
>>     therefore is not reachable via any QOM path.  Aside: feels like
>>     abuse of QOM.
>
> Yes slightly abused, as the comment shows..
>
> static const TypeInfo migration_type = {
>     .name = TYPE_MIGRATION,
>     /*
>      * NOTE: TYPE_MIGRATION is not really a device, as the object is
>      * not created using qdev_new(), it is not attached to the qdev
>      * device tree, and it is never realized.
>      *
>      * TODO: Make this TYPE_OBJECT once QOM provides something like
>      * TYPE_DEVICE's "-global" properties.
>      */
>     .parent = TYPE_DEVICE,
>
> It's just that current code works mostly as expected without much churns
> elsewhere.. so the TODO is not really getting much attention..

I see a number of abuses:

1. We're using TYPE_DEVICE for something that clearly isn't a device.

2. The device is not connected to the qdev device tree rooted at the
main system bus.  I'm not sure this qualifies as abuse.  The connection
the device tree supports is plugging into a bus, which bus-less devices
cannot do.  Instead, they are commonly part of other devices.  There
might be exceptions.  The qdev device tree feels like a relic of the
pre-QOM past.

3. We're keeping the device around unrealized.  No written contract
forbids this, but it's highly irregular.

4. The object is not connected to the QOM composition tree.  No written
contract forbids this, but it's highly irregular, especially for an
object whose purpose is to provide an external configuration interface.

The comment is about the abuse of qdev (items 1 to 3).  Even with the
TODO comment fully addressed, we'd still abuse QOM (item 4).

>> 
>>     It's also not part of the device tree rooted at the main system bus,
>>     which means it isn't visible in "info qtree".  It is visible in
>>     "info qdm", "device_add migration,help", and "-device
>>     migration,help".  Output of the latter two changes.  All harmless.
>> 
>>     I *think* that's all.
>> 
>>   - migrate_tls(), migrate_tls_authz(), migrate_tls_creds(),
>>     migrate_tls_hostname()
>> 
>>     Before the patch, these return the respective migration parameter
>>     directly.  I believe the value is never NULL.  Value "" is special
>>     and means "off".
>> 
>>     After the patch, these return the respective migration parameter
>>     when it's a non-empty QTYPE_QSTRING, else NULL.  Value NULL means
>>     off.
>> 
>>     Note this maps both C representations of "off" to NULL.
>> 
>>     This changes the return value for "off" from "" to NULL.
>>     Improvement, because it results in a more pleasant "is off" check.
>
> Maybe more than pleasant. :) Internally NULL is a must (even if empty
> string), to make things like "if (tls_authz)" work.

Three possible interfaces, and the resulting tests:

* Non-empty string when on, "" when off:
  if (*tls_authz)

* Non-empty string when on, NULL when off:
  if (tls_authz)

* Non-empty string when on, NULL or "" when off:
  if (tls_authz && *tls_authz)
  
All three work equally well, but the second one is more pleasant than
the others.

>>   - qmp_query_migrate_parameters()
>> 
>>     The three tls_FOO get duplicated into the return value.
>> 
>>     Looks like the two different C representations of "off" bleed into
>>     QMP (ugh!), and [*] JSON null is possible (incompatible change).
>> 
>> * hmp_info_migrate_parameters()
>> 
>>   The two different C representations of "off" are first mapped to NULL
>>   with str_from_StrOrNull(), and then mapped to "" with a ?: operator.
>>   Works.
>> 
>> Bottom line:
>> 
>> * Affected external interfaces:
>> 
>>   - query-migrate-parameters: can now return either "" or null when TLS
>>     is off.  null is an incompatible change.  Needs fixing.
>
> If we want to seriously keep using StrOrNull as the interface, I think we
> need to allow both NULL or "" to exist?  Because the "logical goal" is to
> use NULL but "" for compatibility?

The interface was ill-conceived from the start.  Probably so it could be
shoehorned more easily into existing migraion configuration
infrastructure.

We have three syntactically independent parameters: @tls-creds,
@tls-hostname, @tls-authz.  The latter two are meaningless (and silently
ignored) unless the first one is given.  I hate that.

TLS is off by default.  To enable it, set @tls-creds.  Except setting it
to the otherwise invalid value "" disables it.  That's because all we
have for configuration is the "set migration parameter to value"
interface.  Only works because we have an invalid value we can abuse.  I
hate that.

I found this interface days before the freeze, too late to replace it by
a saner one.

> I worry we spend a lot of time working on the NULL/"" but then found nobody
> is using NULL anyway.

I naively assumed deprecating "" would get null used.

>>   - query-qmp-schema: shows null is now possible.  Correctly reflects
>>     the backward incompatible change.  If we fix compatibility break, we
>>     get a tolerable loss of typing precision instead.
>> 
>> 2. Two different C representations of "off".  Strong dislike.  I
>>    recommend to fix the compatibility break by switching to a single C
>>    representation.
>
> IIUC the goal is to switch to StrOrNull, but that face challenge.
>
>> 
>> Thoughts?
>
> If I'd vote (based on our current code), I'd double check tls* fields are
> working properly with libvirt on empty strings, then switch all StrOrNull
> in migration parameters to strings, for both QAPI and QEMU internally.
> Then making sure all migrate_tls_*() helpers do proper job on converting ""
> to NULL.

Accept cleanup of this bad interface is not practical.  Cut our losses
and run.

> If we design a new interface, just remember to use NULL (hopefully) to be
> clear and single way to say "OFF" starting from the 1st day.

Migration configuration and control is in an ugly state.

Configuration is almost entirely special (own QMP commands for
everything), with a little abuse of general infrastructure stirred in
(-global, compat props).  Having capabilities in addition to parameters
is a useless complication.  Too many features of questionable utility
with way too many configuration knobs.

Control is entirely special.  Solves the largely same problems as jobs
do, just different.

Is there hope for improvement, or should I hold my nose and look the
other way?

> But that's only my 2 cents.
>
> Thanks,


