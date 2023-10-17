Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA97CBB4C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdct-0005Q9-Ft; Tue, 17 Oct 2023 02:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qsdcm-0005Py-BV
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qsdcj-0008Di-Gl
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697524331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSJCYYcHgux47iWeHMf5NG9GfTpS0M4TjX0EUFuda0Q=;
 b=JiPsKRVm5vuSne/cTAakTkAdH5kKeBFDPhLWkq1GQjktlg8WlYTMKWCNS7Dj8bDZdnkDWe
 7kV+pzT7lwBMWBOR3AlwvZ0MlZZxuSSHrMVm/6S1K4urQrda2EqtrYV3EE8HuMmlFKLsaa
 v/0z2+MBuMxLu/oMZ9SbbeUnmfj51Xk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-_mZTO0LsNEmS8WMWNxiviA-1; Tue, 17 Oct 2023 02:32:04 -0400
X-MC-Unique: _mZTO0LsNEmS8WMWNxiviA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9635F2932480;
 Tue, 17 Oct 2023 06:32:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 589CA1C060AE;
 Tue, 17 Oct 2023 06:32:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A49B21E6A1F; Tue, 17 Oct 2023 08:32:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 0/4] qapi/migration: Dedup migration parameter
 objects and fix tls-authz crash
References: <20230905162335.235619-1-peterx@redhat.com>
 <87h6mqixya.fsf@pond.sub.org> <ZS1k3mBVHgIPrjfO@x1n>
Date: Tue, 17 Oct 2023 08:32:02 +0200
In-Reply-To: <ZS1k3mBVHgIPrjfO@x1n> (Peter Xu's message of "Mon, 16 Oct 2023
 12:29:18 -0400")
Message-ID: <87v8b5dajh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

> On Mon, Oct 16, 2023 at 09:08:40AM +0200, Markus Armbruster wrote:
>> Let me try to summarize our findings so far.
>
> Thanks.  I'll reply here instead of all the rest places.
>
>> 
>> PATCH 1 has been merged.  PATCH 2 has been queued, but not merged (not
>> sure why, accident?).
>
> (I don't know, either; could be in the next pull)
>
>> 
>> The remaining two are the actual de-triplication:
>> 
>> PATCH 3: Fuse MigrationParameters and MigrateSetParameters
>> 
>> PATCH 4: De-document MigrationParameter
>> 
>> The latter is a much simpler problem, so let's discuss it first.
>> 
>> 
>> Enum MigrationParameter is used only internally.  It's in the QAPI
>> schema just because we want code generated for it.  It shouldn't be
>> documented in the QEMU QMP Reference Manual, but is, because the
>> generator is too stupid to elide internal-only stuff.
>> 
>> PATCH 4 moves it out of the schema.  It has to add back the lost
>> generated code in hand-written form, which is a bit unfortunate.  I
>> proposed to instead drop most of the useless doc comment by exploiting a
>> QAPI generator loophole.
>> 
>> Aside: the QAPI generator should elide internal-only stuff from the QEMU
>> QMP Reference manual, and it should not require doc comments then.
>> Future work, let's not worry about it now.
>
> Just to double check: @MigrationParameter will not be exported in any form
> even today, including query-qmp-schema, am I right?

You are right.

Checking whether something is in the output of query-qmp-schema is easy:
look for it in the generated qapi-introspect.c.  Command names appear
like

    QLIT_QDICT(((QLitDictEntry[]) {
        [...]
        { "meta-type", QLIT_QSTR("command"), },
        { "name", QLIT_QSTR("query-migrate"), },
        [...]
    })),

Events names appear like

    QLIT_QDICT(((QLitDictEntry[]) {
        [...]
        { "meta-type", QLIT_QSTR("event"), },
        { "name", QLIT_QSTR("MIGRATION"), },
        [...]
    })),

Type names appear in comments instead of code, like

    /* "145" = MigrationParameters */

MigrationParameter does not appear.

>> The fusing of MigrationParameters and MigrateSetParameters is kind of
>> stuck.  Several options, all with drawbacks or problems:
>> 
>> 1. Pick StrOrNull for the tls_FOO members
>> 
>>    This is what PATCH 3 does.  Blocked on the pre-existing class of
>>    crash bugs discussed in
>> 
>>     Subject: QAPI string visitors crashes
>>     Message-ID: <875y3epv3y.fsf@pond.sub.org>
>>     https://lore.kernel.org/qemu-devel/875y3epv3y.fsf@pond.sub.org/
>> 
>>    Needs fixing, but when a fix will be available is unclear.
>> 
>> 2. Pick str for the tls_FOO members
>> 
>>    This is what v1 did.  Incompatible change: JSON null no longer works.
>>    Libvirt doesn't use it (it uses deprecated "" instead), but we cannot
>>    know for sure nothing else out there uses it.
>> 
>>    I don't think reducing development friction (that's what
>>    de-duplication accomplishes) justifies breaking our compatibility
>>    promise.
>> 
>>    To keep the promise, we'd have to deprecate null, un-deprecate "",
>>    let the grace period pass, and only then de-duplicate.
>
> Is "" deprecated already anywhere?

Deprecation was cleary intended (see commit message of 01fa5598269), but
it looks like it wasn't (and isn't) properly documented.  We were much
less organized about deprecating stuff back then.

>> 3. Do nothing, live with the duplication
>> 
>>    Giving up like this would be sad.  Unless we commit to a more
>>    complete overhaul of migration's QAPI/QMP configuration interface,
>>    but I doubt we're ready for that.
>> 
>> Thoughts?
>
> I already went 3) on the patch I posted for avail-switchover-bw.  I don't
> know what's the best for 1) and 2), but if we can at least reduce
> duplication from 3->2 that's a progress.  I replied in the other thread for
> that loophole experiment.
>
> How hard it is to mark an object not requiring documentation on each of its
> field, if that's what we want in this case?  Currently the loophole didn't
> work for me for some reason.  If we can have a marker for objects to escape
> doc check legally, we can apply that to both @MigrationParameter and one
> other (perhaps @MigrationSetParameters).

I can see two useful QAPI generator features:

* Improved handling of missing member documentation

  Problem: many members lack documentation.  We silently generate
  documentation like

      name-of-member
          Not documented

  for them.

  Possible improvement: make missing member documentation a hard error,
  create a knob to suppress the error for a type.  Open question: how to
  best document member documentation is incomplete.

* Suppress documentation for internal-only definitions

  Problem: generated documentation covers everything, even types that
  aren't visible in QMP.  The irrelevant material is distracting and
  possibly confusing for users, and may be bothersome to maintain for
  developers.

  Possible improvement: include only the types visible in QMP in
  documentation, similar to how we do for query-qmp-schema.  Open
  question: what level of documentation to require for internal-only
  types.


