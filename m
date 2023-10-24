Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE87D5AB0
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 20:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvMFu-0004Bp-L9; Tue, 24 Oct 2023 14:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvMFs-0004Aj-88
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 14:35:52 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvMFm-0002O9-MD
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 14:35:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBD991FE9F;
 Tue, 24 Oct 2023 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698172543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eL79aGGX9xCM91MFhc9M7/97a6nA62VQu6IeBDoQOag=;
 b=XPr76rSHqx70Anv7+dFQMAi78P9INxqH3nT7xRByCi/C7jdfv4c4SklXkV0Nnyy+kJBBpL
 kND/jF2IarzBq+TPXl5nqEi8iCUhj996PoI8nlgB4NTGzESmO/8naWYWFpXNZlJkwPCOtj
 /VEMw0J0rah3PuLQr4oHvql0dLsrraU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698172543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eL79aGGX9xCM91MFhc9M7/97a6nA62VQu6IeBDoQOag=;
 b=lmOJZh9puqtYzw2yqaRV5VKmcrBZjBNKKxYjUdo4F4Mi0CkIqulDKNRtFFa9gcHLj0SdXP
 JcVtFntFpBGhCEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F2191391C;
 Tue, 24 Oct 2023 18:35:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BXDHEn8OOGXUJwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 18:35:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 14/29] migration/ram: Introduce 'fixed-ram' migration
 capability
In-Reply-To: <87fs20vb2p.fsf@pond.sub.org>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-15-farosas@suse.de> <87fs20vb2p.fsf@pond.sub.org>
Date: Tue, 24 Oct 2023 15:35:41 -0300
Message-ID: <87zg07dg1u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Add a new migration capability 'fixed-ram'.
>>
>> The core of the feature is to ensure that each ram page has a specific
>> offset in the resulting migration stream. The reason why we'd want
>> such behavior are two fold:
>>
>>  - When doing a 'fixed-ram' migration the resulting file will have a
>>    bounded size, since pages which are dirtied multiple times will
>>    always go to a fixed location in the file, rather than constantly
>>    being added to a sequential stream. This eliminates cases where a vm
>>    with, say, 1G of ram can result in a migration file that's 10s of
>>    GBs, provided that the workload constantly redirties memory.
>>
>>  - It paves the way to implement DIRECT_IO-enabled save/restore of the
>>    migration stream as the pages are ensured to be written at aligned
>>    offsets.
>>
>> For now, enabling the capability has no effect. The next couple of
>> patches implement the core funcionality.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  docs/devel/migration.rst | 14 ++++++++++++++
>>  migration/options.c      | 37 +++++++++++++++++++++++++++++++++++++
>>  migration/options.h      |  1 +
>>  migration/savevm.c       |  1 +
>>  qapi/migration.json      |  5 ++++-
>>  5 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
>> index c3e1400c0c..6f898b5dbd 100644
>> --- a/docs/devel/migration.rst
>> +++ b/docs/devel/migration.rst
>> @@ -566,6 +566,20 @@ Others (especially either older devices or system devices which for
>>  some reason don't have a bus concept) make use of the ``instance id``
>>  for otherwise identically named devices.
>>  
>> +Fixed-ram format
>> +----------------
>> +
>> +When the ``fixed-ram`` capability is enabled, a slightly different
>> +stream format is used for the RAM section. Instead of having a
>> +sequential stream of pages that follow the RAMBlock headers, the dirty
>> +pages for a RAMBlock follow its header. This ensures that each RAM
>> +page has a fixed offset in the resulting migration stream.
>
> This requires the migration stream to be seekable, as documented in the
> QAPI schema below.  I think it's worth documenting here, as well.
>

Ok.

>> +
>> +The ``fixed-ram`` capaility can be enabled in both source and
>> +destination with:
>> +
>> +    ``migrate_set_capability fixed-ram on``
>
> Effect of enabling on the destination?
>
> What happens when we enable it only on one end?
>

qemu-system-x86_64: Capability fixed-ram is off, but received capability is on
qemu-system-x86_64: load of migration failed: Invalid argument

So I guess that *can* be enabled up there should become a *must*.

>> +
>>  Return path
>>  -----------
>>  
>
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 74f12adc0e..1317dd32ab 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -527,6 +527,9 @@
>>  #     VM before migration for an optimal migration performance.
>>  #     Enabled by default. (since 8.1)
>>  #
>> +# @fixed-ram: Migrate using fixed offsets for each RAM page. Requires
>
> Two spaces between sentences for consistency, please.
>
>> +#             a seekable transport such as a file.  (since 8.1)
>
> What is a migration transport?  migration.json doesn't define the term.
>

The medium that transports the migration. We are about to define some
terms at the QAPI series:

[PATCH v15 00/14] migration: Modify 'migrate' and 'migrate-incoming'
QAPI commands for migration
https://lore.kernel.org/r/20231023182053.8711-1-farosas@suse.de

> Which transports are seekable?
>

The ones that implement QIO_CHANNEL_FEATURE_SEEKABLE. Currently only
QIOChannelFile.

> Out of curiosity: what happens if the transport isn't seekable?
>

We fail the migration. At migration_channels_and_uri_compatible():

    if (migration_needs_seekable_channel() &&
        !uri_supports_seeking(uri)) {
        error_setg(errp, "Migration requires seekable transport (e.g. file)");
        compatible = false;
    }

>> +#
>>  # Features:
>>  #
>>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>> @@ -543,7 +546,7 @@
>>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>             'validate-uuid', 'background-snapshot',
>>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit', 'auto-pause'] }
>> +           'dirty-limit', 'auto-pause', 'fixed-ram'] }
>>  
>>  ##
>>  # @MigrationCapabilityStatus:

