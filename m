Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8A7F41D0
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:39:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5jgM-000734-Fg; Wed, 22 Nov 2023 04:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5jgK-0006zQ-J7
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5jgI-0008F9-Or
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700645881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J7Qs43maiVkg/yh3hO7IWJaKZK86ISiBO/eQnVM+b7I=;
 b=cpwS/ojj22hUiPY1RIAwA2KUFDJXWLJF5xM44i1wcor1WA8WGVKGKBWZ1f/K3yXBv12R9a
 BQ3lHJyFM8z7YzXhqLBGV4uLjqsU8oi+4geXP07+Q4VyUuKYPX/reEUTYxhMqlGNFCfOXX
 +ASumDrJkmYnPwbUzi0eCigSDXj+zek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-Xpx06stlNgaUFbydg_2MgQ-1; Wed, 22 Nov 2023 04:37:59 -0500
X-MC-Unique: Xpx06stlNgaUFbydg_2MgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 914A6101A53B;
 Wed, 22 Nov 2023 09:37:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7035740C6EB9;
 Wed, 22 Nov 2023 09:37:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C9D221E6A1F; Wed, 22 Nov 2023 10:37:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 03/19] qapi/schema: name QAPISchemaInclude entities
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-4-jsnow@redhat.com>
 <87o7fn44em.fsf@pond.sub.org>
 <CAFn=p-Zeu0O9Jvo6AvK0a5jC8VW94sSutv8S7v7_N4tkfLEr_A@mail.gmail.com>
Date: Wed, 22 Nov 2023 10:37:58 +0100
In-Reply-To: <CAFn=p-Zeu0O9Jvo6AvK0a5jC8VW94sSutv8S7v7_N4tkfLEr_A@mail.gmail.com>
 (John Snow's message of "Tue, 21 Nov 2023 11:22:16 -0500")
Message-ID: <87o7fmw2kp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Nov 21, 2023, 8:33 AM Markus Armbruster <armbru@redhat.com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > It simplifies typing to mandate that entities will always have a name;
>> > to achieve this we can occasionally assign an internal name. This
>> > alleviates errors such as:
>> >
>> > qapi/schema.py:287: error: Argument 1 to "__init__" of
>> > "QAPISchemaEntity" has incompatible type "None"; expected "str"
>> > [arg-type]
>> >
>> > Trying to fix it the other way by allowing entities to only have
>> > optional names opens up a nightmare portal of whackamole to try and
>> > audit that every other pathway doesn't actually pass a None name when we
>> > expect it to; this is the simpler direction of consitifying the typing.
>>
>> Arguably, that nightmare is compile-time proof of "we are not mistaking
>> QAPISchemaInclude for a named entity".
>>
>> When I added the include directive, I shoehorned it into the existing
>> representation of the QAPI schema as "list of QAPISchemaEntity" by
>> making it a subtype of QAPISchemaEntity.  That was a somewhat lazy hack.
>>
>> Note that qapi-code-gen.rst distinguishes between definitions and
>> directives.
>>
>> The places where mypy gripes that .name isn't 'str' generally want
>> something with a name (what qapi-code-gen.rst calls a definition).  If
>> we somehow pass them an include directive, they'll use None for a name,
>> which is no good.  mypy is pointing out this problem.
>>
>> What to do about it?
>>
>> 1. Paper it over: give include directives some made-up name (this
>> patch).  Now the places use the made-up name instead of None, and mypy
>> can't see the problem anymore.
>>
>> 2. Assert .name is not None until mypy is happy.  I guess that's what
>> you called opening "a nightmare portal of whackamole".
>>
>
> Yep.
>
>
>> 3. Clean up the typing: have a type for top-level expression (has no
>> name), and a subtype for definition (has a name).  Rough sketch
>> appended.  Thoughts?
>>
>
> Oh, that'll work. I tried to keep to "minimal SLOC" but where you want to
> see deeper fixes, I'm happy to deviate. I'll give it a shot.

I do appreciate the minimal fix!  I *like* exploring "minimal" first.
In this case, the exploration led me to not like my lazy hack anymore :)

[...]

> I'll try the refactor out in a patch at the end of my series and see how
> feasible it is.
>
> (I haven't reviewed it deeply yet, so if there's an obvious problem I'll
> find it when I go to implement this. conceptually it seems fine.)

Thanks!


