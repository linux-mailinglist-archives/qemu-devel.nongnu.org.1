Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E627D618E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXEg-0000cd-KR; Wed, 25 Oct 2023 02:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvXEe-0000bq-7Y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvXEY-0000lQ-I5
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698214752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qz9nibAudhAmTPodeSx0XLITFaKh7AO80kVAgHaWlMM=;
 b=P+mi1LOs0iam8E5qgh6VSz6RmjL7/EEQVE4jiRrJCqhfCi2tqC2fY4KzSNI7LwKBV8LFH+
 jclaATB2GNm0YZ7RoKuwNUSwPMIx5FQUu8eopzjScRDvPP+om2V5wTAIvtry1jS8mMrIr0
 uOQt6YqFNyWuXXF30Y5E/LaVIHAmNqI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-3pTSsSTfO9uA7oDZ6XZScw-1; Wed,
 25 Oct 2023 02:19:00 -0400
X-MC-Unique: 3pTSsSTfO9uA7oDZ6XZScw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 813C33C0FC85;
 Wed, 25 Oct 2023 06:19:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 443252026D4C;
 Wed, 25 Oct 2023 06:19:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE4FD21E6A1F; Wed, 25 Oct 2023 08:18:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 14/29] migration/ram: Introduce 'fixed-ram' migration
 capability
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-15-farosas@suse.de>
 <87fs20vb2p.fsf@pond.sub.org> <87zg07dg1u.fsf@suse.de>
Date: Wed, 25 Oct 2023 08:18:58 +0200
In-Reply-To: <87zg07dg1u.fsf@suse.de> (Fabiano Rosas's message of "Tue, 24 Oct
 2023 15:35:41 -0300")
Message-ID: <87sf5zkywd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Add a new migration capability 'fixed-ram'.
>>>
>>> The core of the feature is to ensure that each ram page has a specific
>>> offset in the resulting migration stream. The reason why we'd want
>>> such behavior are two fold:
>>>
>>>  - When doing a 'fixed-ram' migration the resulting file will have a
>>>    bounded size, since pages which are dirtied multiple times will
>>>    always go to a fixed location in the file, rather than constantly
>>>    being added to a sequential stream. This eliminates cases where a vm
>>>    with, say, 1G of ram can result in a migration file that's 10s of
>>>    GBs, provided that the workload constantly redirties memory.
>>>
>>>  - It paves the way to implement DIRECT_IO-enabled save/restore of the
>>>    migration stream as the pages are ensured to be written at aligned
>>>    offsets.
>>>
>>> For now, enabling the capability has no effect. The next couple of
>>> patches implement the core funcionality.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  docs/devel/migration.rst | 14 ++++++++++++++
>>>  migration/options.c      | 37 +++++++++++++++++++++++++++++++++++++
>>>  migration/options.h      |  1 +
>>>  migration/savevm.c       |  1 +
>>>  qapi/migration.json      |  5 ++++-
>>>  5 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
>>> index c3e1400c0c..6f898b5dbd 100644
>>> --- a/docs/devel/migration.rst
>>> +++ b/docs/devel/migration.rst
>>> @@ -566,6 +566,20 @@ Others (especially either older devices or system devices which for
>>>  some reason don't have a bus concept) make use of the ``instance id``
>>>  for otherwise identically named devices.
>>>  
>>> +Fixed-ram format
>>> +----------------
>>> +
>>> +When the ``fixed-ram`` capability is enabled, a slightly different
>>> +stream format is used for the RAM section. Instead of having a
>>> +sequential stream of pages that follow the RAMBlock headers, the dirty
>>> +pages for a RAMBlock follow its header. This ensures that each RAM
>>> +page has a fixed offset in the resulting migration stream.
>>
>> This requires the migration stream to be seekable, as documented in the
>> QAPI schema below.  I think it's worth documenting here, as well.
>>
>
> Ok.
>
>>> +
>>> +The ``fixed-ram`` capaility can be enabled in both source and
>>> +destination with:
>>> +
>>> +    ``migrate_set_capability fixed-ram on``
>>
>> Effect of enabling on the destination?
>>
>> What happens when we enable it only on one end?
>>
>
> qemu-system-x86_64: Capability fixed-ram is off, but received capability is on
> qemu-system-x86_64: load of migration failed: Invalid argument
>
> So I guess that *can* be enabled up there should become a *must*.

Makes sense.

>>> +
>>>  Return path
>>>  -----------
>>>  
>>
>> [...]
>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 74f12adc0e..1317dd32ab 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -527,6 +527,9 @@
>>>  #     VM before migration for an optimal migration performance.
>>>  #     Enabled by default. (since 8.1)
>>>  #
>>> +# @fixed-ram: Migrate using fixed offsets for each RAM page. Requires
>>
>> Two spaces between sentences for consistency, please.
>>
>>> +#             a seekable transport such as a file.  (since 8.1)
>>
>> What is a migration transport?  migration.json doesn't define the term.
>>
>
> The medium that transports the migration. We are about to define some
> terms at the QAPI series:
>
> [PATCH v15 00/14] migration: Modify 'migrate' and 'migrate-incoming'
> QAPI commands for migration
> https://lore.kernel.org/r/20231023182053.8711-1-farosas@suse.de

Can't find it there offhand.  No need to explain it further to me now,
just make sure it's defined at this point in the series when you respin.

>> Which transports are seekable?
>>
>
> The ones that implement QIO_CHANNEL_FEATURE_SEEKABLE. Currently only
> QIOChannelFile.

Transport seekability needs to be documented clearly.

>> Out of curiosity: what happens if the transport isn't seekable?
>
> We fail the migration. At migration_channels_and_uri_compatible():
>
>     if (migration_needs_seekable_channel() &&
>         !uri_supports_seeking(uri)) {
>         error_setg(errp, "Migration requires seekable transport (e.g. file)");
>         compatible = false;
>     }

Thanks!

>>> +#
>>>  # Features:
>>>  #
>>>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>>> @@ -543,7 +546,7 @@
>>>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>>             'validate-uuid', 'background-snapshot',
>>>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>>> -           'dirty-limit', 'auto-pause'] }
>>> +           'dirty-limit', 'auto-pause', 'fixed-ram'] }
>>>  
>>>  ##
>>>  # @MigrationCapabilityStatus:


