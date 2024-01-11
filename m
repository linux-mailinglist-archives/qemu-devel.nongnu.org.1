Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C7A82AAD6
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:25:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrIy-0000YG-CU; Thu, 11 Jan 2024 04:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNrIn-0000PK-W2
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNrIi-0005L6-Rq
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704965073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+chrzTXHhcReQdRa38thZwuij/N2mlCF47qspVqkkB4=;
 b=IqvN14Cf36rvuY2RUcTCOyJ72yFJf0yQlgZi3hZDLqtcuP8U8ER/9WtEIlwBW+8A/S5tFF
 UnUh3itmSeulvX+3Z1ES7t7cRt4eGYMXtvpcQewtpDtGBdC91WvA/l1yUl1sR/rABj+zPy
 6eH0d6og9M2dLA4Ijxhzq/tl4PCVWl8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-CKp4j5pjNS2IA1zBzWED5w-1; Thu, 11 Jan 2024 04:24:30 -0500
X-MC-Unique: CKp4j5pjNS2IA1zBzWED5w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8152868901;
 Thu, 11 Jan 2024 09:24:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90414492BC6;
 Thu, 11 Jan 2024 09:24:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7934921E6682; Thu, 11 Jan 2024 10:24:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 12/19] qapi/schema: split "checked" field into
 "checking" and "checked"
In-Reply-To: <CAFn=p-bvAcej5vgc4N=WtTrQ1B0dUP5SDy6nhs4eADhQATbxRA@mail.gmail.com>
 (John Snow's message of "Wed, 10 Jan 2024 15:21:03 -0500")
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-13-jsnow@redhat.com>
 <874jhddgxt.fsf@pond.sub.org>
 <CAFn=p-bvAcej5vgc4N=WtTrQ1B0dUP5SDy6nhs4eADhQATbxRA@mail.gmail.com>
Date: Thu, 11 Jan 2024 10:24:28 +0100
Message-ID: <87mstc1aur.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Wed, Nov 22, 2023, 9:02 AM Markus Armbruster <armbru@redhat.com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Differentiate between "actively in the process of checking" and
>> > "checking has completed". This allows us to clean up the types of some
>> > internal fields such as QAPISchemaObjectType's members field which
>> > currently uses "None" as a canary for determining if check has
>> > completed.
>>
>> Certain members become valid only after .check().  Two ways to code
>> that:
>>
>> 1. Assign to such members only in .check().  If you try to use them
>> before .check(), AttributeError.  Nice.  Drawback: pylint is unhappy,
>> W0201 attribute-defined-outside-init.
>>
>
> Can be overcome by declaring the field in __init__, which satisfies both
> the linter and my developer usability sense (Classes should be easy to have
> their properties enumerated by looking in one well known place.)
>
>
>> 2. Assign None in .__init__(), and the real value in .check().  If you
>> try to use them before .check(), you get None, which hopefully leads to
>> an error.  Meh, but pylint is happy.
>>
>> I picked 2. because pylint's warning made me go "when in Rome..."
>>
>
> Yep, this is perfectly cromulent dynamically typed Python. It's not the
> Roman's fault I'm packing us up to go to another empire.
>
>
>> With type hints, we can declare in .__init__(), and assign in .check().
>> Gives me the AttributeError I like, and pylint remains happy.  What do
>> you think?
>>
>
> Sounds good to me in general, I already changed this for 2/3 of my other
> uses of @property.
>
> (I'm only reluctant because I don't really like that it's a "lie", but in
> this case, without potentially significant rewrites, it's a reasonable type
> band-aid. Once we're type checked, we can refactor more confidently if we
> so desire, to make certain patterns less prominent or landmine-y.)

The general problem is "attribute value is valid only after a state
transition" (here: .member is valid only after .check()).

We want to catch uses of the attribute before it becomes valid.

We want to keep pylint and mypy happy.

Solutions:

1. Initialize in .__init__() to some invalid value.  Set it to the valid
   value in .check().

1.a. Pick the "natural" invalid value: None

   How to catch: assert attribute value is valid (here: .members is not
   None).  Easy to forget.  Better: when the use will safely choke on
   the invalid value (here: elide for uses like for m in .members),
   catch is automatic.

   Pylint: fine.

   Mypy: adding None to the set of values changes the type from T to
   Optional[T].  Because of this, mypy commonly can't prove valid uses
   are valid.  Keeping it happy requires cluttering the code with
   assertions and such.  Meh.

   Note: catching invalid uses is a run time check.  Mypy won't.

1.b. Pick an invalid value of type T (here: [])

   How to catch: same as 1.a., except automatic catch is rare.  Meh.

   Pylint: fine.

   Mypy: fine.

2. Declare in .__init__() without initializing.  Initialize to valid
   value in .check()

   How to catch: always automatic.  Good, me want!

   Pylint: fine.

   Mypy: fine.

   Note: catching invalid uses is a run time check.  Mypy won't.

3. Express the state transition in the type system

   To catch invalid uses statically with mypy, we need to use different
   types before and after the state transition.  Feels possible.  Also
   feels ludicrously overengineered.

May I have 2., please?

>> Splitting .checked feels like a separate change, though.  I can't quite
>> see why we need it.  Help me out: what problem does it solve?
>>
>
> Mechanically, I wanted to eliminate the Optional type from the members
> field, but you have conditionals in the code that use the presence or
> absence of this field as a query to determine if we had run check or not
> yet.
>
> So I did the stupidest possible thing and added a "checked" variable to
> explicitly represent it.

If 2. complicates the existing "have we .check()ed?" code too much, then
adding such a variable may indeed be useful.

>> > This simplifies the typing from a cumbersome Optional[List[T]] to merely
>> > a List[T], which is more pythonic: it is safe to iterate over an empty
>> > list with "for x in []" whereas with an Optional[List[T]] you have to
>> > rely on the more cumbersome "if L: for x in L: ..."
>>
>> Yes, but when L is None, it's *invalid*, and for i in L *should* fail
>> when L is invalid.
>>
>
> Sure, but it's so invalid that it causes static typing errors.
>
> You can't write "for x in None" in a way that makes mypy happy, None is not
> iterable.

A variable that is declared, but not initialized (2. above) also not
iterable, and it does make mypy happy, doesn't it?

> If you want to preserve the behavior of "iterating an empty collection is
> an Assertion", you need a custom iterator that throws an exception when the
> collection is empty. I can do that, if you'd like, but I think it's
> actually fine to just allow the collection to be empty and to just catch
> the error in check() with either an assertion (oops, something went wrong
> and the list is empty, this should never happen) or a QAPISemError (oops,
> you didn't specify any members, which is illegal.)
>
> I'd prefer to catch this in check and just allow the iterator to permit
> empty iterators at the callsite, knowing it'll never happen.
>
>
>> I think the actual problem is something else.  By adding the type hint
>> Optional[List[T]], the valid uses of L become type errors.  We really
>> want L to be a List[T].  Doesn't mean we have to (or want to) make uses
>> of invalid L "work".
>>
>
> I didn't think I did allow for invalid uses to work - if the list should
> semantically never be empty, I think it's fine to enforce that in schema.py
> during construction of the schema object and to assume all uses of "for x
> in L: ..." are inherently valid.
>
>
>> > RFC: are we guaranteed to have members here? can we just use "if
>> > members" without adding the new field?
>>
>> I'm afraid I don't understand these questions.
>>
>
> I think you answered this one for me; I was asking if it was ever valid in
> any circumstance to have an empty members list, but I think you've laid out
> in your response that it isn't.
>
> And I think with that knowledge I can simplify this patch, but don't quite
> recall. (On my mobile again, please excuse my apparent laziness.)

Feel excused!

[...]


