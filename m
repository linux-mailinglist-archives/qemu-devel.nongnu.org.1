Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC56E7D6138
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:35:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWWi-0000aY-8h; Wed, 25 Oct 2023 01:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvWWg-0000Zn-1U
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvWWR-0001z5-Sr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698212017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CrSihu8VKiDdOji9QEUdPRRNz3WMdd/axe6tmn5zv0Y=;
 b=TNxcEzkkim1YEQskTh8IP5WDll4lQRcSf1ggYJf6OsyMuDQQKbMzmgUFCGKYSOUaOagP+m
 jA22dZHfsOSnJWkbq0+i65snrLwU52OvSbxiF49jhZGFOvq5QDfhb/MPN9LCrHdtgUlV4u
 kAdD7QyWGHFGoqR8H8RP29EJzww7Svo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-wv59m29sO26OIrmDHLwY3g-1; Wed,
 25 Oct 2023 01:33:23 -0400
X-MC-Unique: wv59m29sO26OIrmDHLwY3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57FF628237D8;
 Wed, 25 Oct 2023 05:33:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BCB82026D66;
 Wed, 25 Oct 2023 05:33:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D8D821E6A1F; Wed, 25 Oct 2023 07:33:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de> <87r0lkvbfd.fsf@pond.sub.org>
 <8734xzevoj.fsf@suse.de>
Date: Wed, 25 Oct 2023 07:33:22 +0200
In-Reply-To: <8734xzevoj.fsf@suse.de> (Fabiano Rosas's message of "Tue, 24 Oct
 2023 15:12:44 -0300")
Message-ID: <871qdjmfkt.fsf@pond.sub.org>
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
>>> Add a capability that allows the management layer to delegate to QEMU
>>> the decision of whether to pause a VM and perform a non-live
>>> migration. Depending on the type of migration being performed, this
>>> could bring performance benefits.
>>>
>>> Note that the capability is enabled by default but at this moment no
>>> migration scheme is making use of it.
>>
>> This sounds as if the capability has no effect unless the "migration
>> scheme" (whatever that may be) opts into using it.  Am I confused?
>>
>
> What I mean here is that this capability is implemented and functional,
> but I'm not retroactively enabling any existing migration code to use
> auto-pause. Otherwise people would start seeing their guests being
> paused before migraton in scenarios they never used to pause.
>
> By "migration scheme" I mean types of migration. Or modes of
> operation. Or exclusive parameters. Anything that is different enough
> from what exists today that we would consider a different type of
> migration. Anything that allow us to break backward compatibility
> (because it never existed before to begin with).
>
> E.g. this series introduces the fixed-ram migration. That never existed
> before. So from the moment we enable that code to use this capability,
> it will always do auto-pause, unless the management layer wants to avoid
> it.

So the auto-pause's *effective* default depends on the migration scheme:
certain new schemes pause by default, everything else doesn't.  Is this
a good idea?

If it is, then we need to document this behavior clearly.

Here's another way to design the interface: keep the default behavior
consistent (no pause), and provide a way to ask for pause (fails if
migration scheme doesn't support it).

>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> [...]
>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index db3df12d6c..74f12adc0e 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -523,6 +523,10 @@
>>>  #     and can result in more stable read performance.  Requires KVM
>>>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>>>  #
>>> +# @auto-pause: If enabled, allows QEMU to decide whether to pause the
>>> +#     VM before migration for an optimal migration performance.
>>> +#     Enabled by default. (since 8.1)
>>
>> If this needs an opt-in to take effect, it should be documented.
>
> Someting like this perhaps?
>
> # @auto-pause: If enabled, allows QEMU to decide whether to pause the VM
> #     before migration for an optimal migration performance. Enabled by
> #     default. New migration code needs to opt-in at
> #     migration_should_pause(), otherwise this behaves as if
> #     disabled. (since 8.2)

Remember, this is user-facing documentation.  Talking about
migration_should_pause() makes no sense there.

Instead, you need to document what @auto-pause does: pause when a
condition specific to the migration scheme is met, and specify the
condition for each migration scheme.  The condition could be "never"
(auto-pause has no effect), "always", or something in between.

A configuration knob that has no effect feels like an interface blemish.

>>> +#
>>>  # Features:
>>>  #
>>>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>>> @@ -539,7 +543,7 @@
>>>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>>             'validate-uuid', 'background-snapshot',
>>>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>>> -           'dirty-limit'] }
>>> +           'dirty-limit', 'auto-pause'] }
>>>  
>>>  ##
>>>  # @MigrationCapabilityStatus:


