Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CA97FF253
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 15:39:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8i9B-0001Xj-Ov; Thu, 30 Nov 2023 09:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8i8U-0001Db-DB
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8i8R-0001r0-Hg
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701354918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76U5cbUty1PXiH6mrZ0KFyBJP0yn3L/XLpPSP7D9FxA=;
 b=BrYPn6jv/nRj4IWnYFM+jqfsRf9B1Q83n673bdyQO88kFN+qtgaxXpT/LrCHVTca03CVpo
 fTqbq8X+GAvz73BOrAX11yYjjy3Z6sBajuHjc/ksA9jOzMDqi8yuxXMPgZ4ROmzWrTO7NI
 OtHwvhuiij3pSRHz7HRxkA5U7b0W0YQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-GDJdEy3bNh2GMEU8EJ0Prg-1; Thu, 30 Nov 2023 09:35:14 -0500
X-MC-Unique: GDJdEy3bNh2GMEU8EJ0Prg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26883881F4C;
 Thu, 30 Nov 2023 14:35:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE950492BE7;
 Thu, 30 Nov 2023 14:35:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D673121E6A1F; Thu, 30 Nov 2023 15:35:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  philmd@linaro.org,
 peter.maydell@linaro.org,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-8.2 2/2] string-output-visitor: Support lists for
 non-integer types
References: <20231121173416.346610-1-kwolf@redhat.com>
 <20231121173416.346610-3-kwolf@redhat.com>
 <87bkbb9yht.fsf@pond.sub.org> <ZWiVliL7igJIv3-j@redhat.com>
Date: Thu, 30 Nov 2023 15:35:12 +0100
In-Reply-To: <ZWiVliL7igJIv3-j@redhat.com> (Kevin Wolf's message of "Thu, 30
 Nov 2023 15:00:54 +0100")
Message-ID: <87jzpz5mxr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 30.11.2023 um 14:11 hat Markus Armbruster geschrieben:
>> I understand Stefan already took this patch.  I'm looking at it anyway,
>> because experience has taught me to be very afraid of the string
>> visitors.
>> 
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > With the introduction of list-based array properties in qdev, the string
>> > output visitor has to deal with lists of non-integer elements now ('info
>> > qtree' prints all properties with the string output visitor).
>> >
>> > Currently there is no explicit support for such lists, and the resulting
>> > output is only the last element because string_output_set() always
>> > replaces the output with the latest value.
>> 
>> Yes.
>> 
>> The string visitors were created just for QOM's object_property_parse()
>> and object_property_print().  At the time, QOM properties were limited
>> to scalars, and the new visitors implemented just enough of the visitor
>> API to be usable with scalars.  This was a Really Bad Idea(tm).
>> 
>> Commit a020f9809cf (qapi: add string-based visitors)
>>    and b2cd7dee86f (qom: add generic string parsing/printing).
>> 
>> When we wanted a QOM property for "set of NUMA node number", we extended
>> the visitors to support integer lists.  With fancy range syntax.  Except
>> for 'size'.  This was another Really Bad Idea(tm).
>> 
>> Commit 659268ffbff (qapi: make string input visitor parse int list)
>>    and 69e255635d0 (qapi: make string output visitor parse int list)
>> 
>> All the visitor stuff was scandalously under-documented (that's not even
>> a bad idea, just a Really Bad Habit(tm)).  When we added documentation
>> much later, we missed the lack of support for lists with elements other
>> than integers.  We later fixed that oversight for the input visitor
>> only.
>> 
>> Commit adfb264c9ed (qapi: Document visitor interfaces, add assertions)
>>    and c9fba9de89d (qapi: Rewrite string-input-visitor's integer and list parsing)
>> 
>> Your patch extends the string output visitor to support lists of
>> arbitrary scalars.
>> 
>> >                                            Instead of replacing the old
>> > value, append comma separated values in list context.
>> >
>> > The difference can be observed in 'info qtree' with a 'rocker' device
>> > that has a 'ports' list with more than one element.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > ---
>> >  qapi/string-output-visitor.c | 24 ++++++++++++++++++++----
>> >  1 file changed, 20 insertions(+), 4 deletions(-)
>> 
>> Missing: update of string-output-visitor.h's comment
>> 
>>  * The string output visitor does not implement support for visiting
>>  * QAPI structs, alternates, null, or arbitrary QTypes.  It also
>>  * requires a non-null list argument to visit_start_list().
>> 
>> It is wrong before the patch: most lists do not work.  After the patch,
>> only lists of scalars work.  Document that, please.  Maybe:
>> 
>>  * The string output visitor does not implement support for visiting
>>  * QAPI structs, alternates, null, or arbitrary QTypes.  Only flat lists
>>  * are supported.  It also requires a non-null list argument to
>>  * visit_start_list().
>> 
>> Stolen from string-input-visitor.h's comment.
>> 
>> Could instead use "Only lists of scalars are supported."
>> 
>> Follow-up patch would be fine.
>
> I guess I'm lucky that the comment I missed already failed to point out
> the limitations before, so at least I didn't make anything worse!

Right!

> Adding a sentence makes sense to me. I find "list of scalars" easier to
> understand than "flat lists" (in particular, I would have considered a
> list of structs to be flat), so I'd prefer that wording.

Agree.

>> >
>> > diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
>> > index 71ddc92b7b..c0cb72dbe4 100644
>> > --- a/qapi/string-output-visitor.c
>> > +++ b/qapi/string-output-visitor.c
>> > @@ -74,11 +74,27 @@ static StringOutputVisitor *to_sov(Visitor *v)
>> >  
>> >  static void string_output_set(StringOutputVisitor *sov, char *string)
>> >  {
>> > -    if (sov->string) {
>> > -        g_string_free(sov->string, true);
>> > +    switch (sov->list_mode) {
>> > +    case LM_STARTED:
>> > +        sov->list_mode = LM_IN_PROGRESS;
>> > +        /* fall through */
>> > +    case LM_NONE:
>> > +        if (sov->string) {
>> > +            g_string_free(sov->string, true);
>> > +        }
>> > +        sov->string = g_string_new(string);
>> > +        g_free(string);
>> > +        break;
>> > +
>> > +    case LM_IN_PROGRESS:
>> > +    case LM_END:
>> > +        g_string_append(sov->string, ", ");
>> > +        g_string_append(sov->string, string);
>> > +        break;
>> > +
>> > +    default:
>> > +        abort();
>> >      }
>> > -    sov->string = g_string_new(string);
>> > -    g_free(string);
>> >  }
>> >  
>> >  static void string_output_append(StringOutputVisitor *sov, int64_t a)
>> 
>> The ->list_mode state machine was designed for parsing integer lists
>> with fancy range syntax.  Let me try to figure out how it works.
>> 
>> Initial state is LM_NONE.
>> 
>> On start_list():
>>     LM_NONE -> LM_STARTED.
>> 
>> On end_list():
>>     any -> LM_NONE. 
>> 
>> On next_list():
>>     any -> LM_END.
>> 
>> On print_type_int64():
>>     LM_STARTED -> LM_IN_PROGRESS
>>     LM_IN_PROGRESS -> LM_IN_PROGRESS
>>     LM_END -> LM_END
>> 
>> The two states LM_SIGNED_INTERVAL and LM_UNSIGNED_INTERVAL have never
>> been used.  Copy-pasta from opts-visitor.c.
>> 
>> Only real walks call next_list(), virtual walks do not.  In a real walk,
>> print_type_int64() executes its LM_END case for non-first elements.  In
>> a virtual walk, it executes its LM_IN_PROGRESS case.  This can't be
>> right.
>> 
>> What a load of confused crap.
>
> I won't try to argue that the string visitor isn't a load of confused
> crap, but I don't see how LM_END is non-first elements? It only gets set
> in next_list() for the last element.

You're right; I missed that.

> The more interesting point I wasn't aware of is that virtual walks don't
> need to call next_list().

visitor.h:

 * After visit_start_list() succeeds, the caller may visit its members
 * one after the other.  A real visit (where @list is non-NULL) uses
 * visit_next_list() for traversing the linked list, while a virtual
 * visit (where @list is NULL) uses other means.  For each list
 * element, call the appropriate visit_type_FOO() with name set to
 * NULL and obj set to the address of the value member of the list
 * element.  Finally, visit_end_list() needs to be called with the
 * same @list to clean up, even if intermediate visits fail.  See the
 * examples above.

>                           If we can fix the string visitor, doing a
> virtual walk might have made more sense for the array property getter
> than construction a temporary real list?
>
> Or can't you mix virtual and real with the same visitor? Because I
> assume the callers of property getters are doing a real walk.

visitor.h:

 * A visitor should be used for exactly one top-level visit_type_FOO()
 * or virtual walk; if that is successful, the caller can optionally
 * call visit_complete() (useful only for output visits, but safe to
 * call on all visits).  Then, regardless of success or failure, the
 * user should call visit_free() to clean up resources.  It is okay to
 * free the visitor without completing the visit, if some other error
 * is detected in the meantime.

The callers of property getters I can see look more or less like this:

    v = FOO_output_visitor_new(..., &ret);
    if (object_property_get(obj, name, v, errp)) {
        visit_complete(v, &ret);
    }
    visit_free(v);

Such callers don't walk anything themselves.

I think a virtual walk should be okay.


