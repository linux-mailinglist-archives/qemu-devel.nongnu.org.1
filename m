Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE50AEEF7D
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Jul 2025 09:10:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWV6j-0004w7-8g; Tue, 01 Jul 2025 03:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWV6Y-0004vp-98
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 03:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWV6P-0005E1-QR
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 03:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751353702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BStXMMxRw1s8W9xNcjZ1l9zKliX7yn/dh9DAkD6FBbo=;
 b=VgEVidngZdOA9ea+2Pssrz/pD0yjt+fEEq4SxuSp2xX8QKMdClPvDZVJDgkrszCW6ey5H0
 AfSrs32i5IUFBQJCAz/k7YgVFsSvkL6DeJGcBDvBHQJ/FVid8pF3mBV3enXvX0LUTzLYum
 Uu038a0ZpiqgUD5u3+5hMD55l3YDS4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-jS2-SD-HNUituZKHsdv3Tg-1; Tue,
 01 Jul 2025 03:08:17 -0400
X-MC-Unique: jS2-SD-HNUituZKHsdv3Tg-1
X-Mimecast-MFC-AGG-ID: jS2-SD-HNUituZKHsdv3Tg_1751353696
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A76E180120D; Tue,  1 Jul 2025 07:08:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C634119560AB; Tue,  1 Jul 2025 07:08:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2FFBB21E6A27; Tue, 01 Jul 2025 09:08:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 01/21] migration: Normalize tls arguments
In-Reply-To: <87tt4153ql.fsf@suse.de> (Fabiano Rosas's message of "Fri, 27 Jun
 2025 17:28:02 -0300")
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-2-farosas@suse.de> <87cyas88gg.fsf@pond.sub.org>
 <878qlf7nc0.fsf@suse.de> <87o6uayh9r.fsf@pond.sub.org>
 <87zfdu5zf4.fsf@suse.de> <877c0xpsli.fsf@pond.sub.org>
 <87tt4153ql.fsf@suse.de>
Date: Tue, 01 Jul 2025 09:08:13 +0200
Message-ID: <8734bg4cde.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> Fabiano Rosas <farosas@suse.de> writes:
>>>>
>>>>> Markus Armbruster <armbru@redhat.com> writes:
>>>>>
>>>>>> Fabiano Rosas <farosas@suse.de> writes:

[...]

>> There more than one way to skin this cat.  I like to keep state
>> normalized.
>>
>> State is an optional StrOrNull.  Possible values:
>>
>> * NULL
>>
>> * QNull, i.e. non-NULL, ->type is QTYPE_QNULL
>>
>> * Empty string, i.e. non-NULL, ->type is QTYPE_QSTRING, ->u.s is ""
>>
>> * Non-empty string, i.e. non-NULL, -> type is QTYPE_QSTRING, ->u.s is
>>   not "" (and cannot be NULL)
>>
>> As far as I understand, we have just two cases semantically:
>>
>> * Set, value is a non-empty string (empty makes no sense)
>>
>> * Unset
>>
>> I'd normalize the state to "either NULL, or (non-empty) string".
>>
>
> This is what I wanted to do (in the next version), but it results in
> more complex and less readable code:

[...]

> If we instead normalize to "either non-empty string or empty string"
> then:

[...]

> The query methods get simpler because s->parameters already contains
> data in the format they expect, we can normalize earlier in [2], which
> means data is always in the same format throughout
> qmp_migrate_set_parameters() and lastly, we already have the getter
> methods [1] which can expose "abc"|NULL to the rest of the code anyway.

I'd like the possible states to be clearly visible, and suggest to guard
them with assertions.  Details, such as how exactly the states are
encoded, are up to you.  You're in a better position to judge them than
I am.

>> When writing state, we need to normalize.
>>
>> When reading state, we can rely on it being normalized.  Asserting it is
>> seems prudent, and should help readers.
>>
>
> My main concern is that reading can rely on it being normalized, but the
> query methods cannot, so they need to do an "extra conversion", which
> from the reader's POV, will look nonsensical. It's not as simple as
> using a ternary because the StrOrNull object needs to be allocated.

[...]

>>> There are two external interfaces actually.
>>>
>>> -global migration.some_compat_option=on (stored in MigrationState):
>>>
>>> seems intentional and I believe we'd lose the ability to get out of some
>>> tricky situations if we ditched it.
>>>
>>> -global migation.some_random_option=on (stored in MigrationParameters):
>>>
>>> has become a debugging *feature*, which I personally don't use, but
>>> others do. And worse: we don't know if anyone uses it in production.
>>
>> Accidental external interface.
>>
>>> We also arbitrarily put x- in front of options for some reason. There is
>>> an argument to drop those because x- is scary and no one should be using
>>> them.
>>
>> We pretty much ditched the x- convention in the QAPI schema.
>> docs/devel/qapi-code-gen.rst:
>>
>>     Names beginning with ``x-`` used to signify "experimental".  This
>>     convention has been replaced by special feature "unstable".
>>
>> Goes back to
>>
>> commit a3c45b3e62962f99338716b1347cfb0d427cea44
>> Author: Markus Armbruster <armbru@redhat.com>
>> Date:   Thu Oct 28 12:25:12 2021 +0200
>>
>>     qapi: New special feature flag "unstable"
>>     
>>     By convention, names starting with "x-" are experimental.  The parts
>>     of external interfaces so named may be withdrawn or changed
>>     incompatibly in future releases.
>
> This allows dropping about half of the parameters we expose. Deprecate
> the other half, move the remaining legitimate compat options into
> MigrationParameters, (which can be set by migrate-set-parameters) and
> maybe we can remove the TYPE_DEVICE from MigrationState anytime this
> decade.

I'd love to get rid of the pseudo-device.

> Moving all qdev properties to their own TYPE_DEVICE object and putting
> it under --enable-debug is also an idea.
>
> I'm willing to do the work if we ever reach a consensus about this.

I'd like migration to work more like other long-running tasks: pass the
entire configuration with the command starting it, provide commands and
events to manage the task while it runs.

This is advice, not a demand.  I'm not going to block change the
migration maintainers want.  I may ask you to do the QAPI schema part in
certain ways, but that's detail.

[...]


