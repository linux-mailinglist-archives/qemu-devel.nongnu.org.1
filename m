Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE017D5A3E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 20:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLtk-00057k-9e; Tue, 24 Oct 2023 14:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvLtg-0004tY-71
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 14:12:56 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvLta-0005S8-2L
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 14:12:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 525101FE9E;
 Tue, 24 Oct 2023 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698171167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuFjuBT12MKx7y0Y/HRmjrY+8s+RB52SpTSjoy6KBE4=;
 b=DFe7W1IDotCiEOP7h6bykh5tVPYJ6TKZ9yCKn6oYrc5ArtKwR04qJAbcEHS/Yrd7oGxsOI
 nxl4HFKAoPVFsT63KraYZZaIS52lzDSvr6pqqu3qii3w/xufiyrXQmE3IdvD9Ptp9bmgdu
 if1COUTS61YcS6LR2oFV7zDst4v71NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698171167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuFjuBT12MKx7y0Y/HRmjrY+8s+RB52SpTSjoy6KBE4=;
 b=J0JP+0wLJKeFvMI6qC5lgOabgWnRXRAg2O3yZKw+aJNnJS+2nHZAtn8YM+h91yAJg1M9lj
 EkrEUkRCU+pqHwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D78521391C;
 Tue, 24 Oct 2023 18:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id X31bKB4JOGWPHQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 18:12:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
In-Reply-To: <87r0lkvbfd.fsf@pond.sub.org>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de> <87r0lkvbfd.fsf@pond.sub.org>
Date: Tue, 24 Oct 2023 15:12:44 -0300
Message-ID: <8734xzevoj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[36.35%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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
>> Add a capability that allows the management layer to delegate to QEMU
>> the decision of whether to pause a VM and perform a non-live
>> migration. Depending on the type of migration being performed, this
>> could bring performance benefits.
>>
>> Note that the capability is enabled by default but at this moment no
>> migration scheme is making use of it.
>
> This sounds as if the capability has no effect unless the "migration
> scheme" (whatever that may be) opts into using it.  Am I confused?
>

What I mean here is that this capability is implemented and functional,
but I'm not retroactively enabling any existing migration code to use
auto-pause. Otherwise people would start seeing their guests being
paused before migraton in scenarios they never used to pause.

By "migration scheme" I mean types of migration. Or modes of
operation. Or exclusive parameters. Anything that is different enough
from what exists today that we would consider a different type of
migration. Anything that allow us to break backward compatibility
(because it never existed before to begin with).

E.g. this series introduces the fixed-ram migration. That never existed
before. So from the moment we enable that code to use this capability,
it will always do auto-pause, unless the management layer wants to avoid
it.

>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index db3df12d6c..74f12adc0e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -523,6 +523,10 @@
>>  #     and can result in more stable read performance.  Requires KVM
>>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>>  #
>> +# @auto-pause: If enabled, allows QEMU to decide whether to pause the
>> +#     VM before migration for an optimal migration performance.
>> +#     Enabled by default. (since 8.1)
>
> If this needs an opt-in to take effect, it should be documented.
>

Someting like this perhaps?

# @auto-pause: If enabled, allows QEMU to decide whether to pause the VM
#     before migration for an optimal migration performance. Enabled by
#     default. New migration code needs to opt-in at
#     migration_should_pause(), otherwise this behaves as if
#     disabled. (since 8.2)

>> +#
>>  # Features:
>>  #
>>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>> @@ -539,7 +543,7 @@
>>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>             'validate-uuid', 'background-snapshot',
>>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit'] }
>> +           'dirty-limit', 'auto-pause'] }
>>  
>>  ##
>>  # @MigrationCapabilityStatus:

