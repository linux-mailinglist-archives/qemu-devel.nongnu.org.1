Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A117FEFCA
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 14:13:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8gq1-0005ML-91; Thu, 30 Nov 2023 08:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8gpu-0005M5-Oi
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:12:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8gps-00024W-Lt
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701349923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i37NFmSHen3C53aEt3VQViZjO8BfLRy6l37w9uKZKHw=;
 b=KzS21JKu/IhuLHWVIXksrl49CIRziTzyurNFDB5cYQImKv+/jD+5hysH6EGWvWa7uPf8dl
 IuUa3mJB2e40mbeVZLGvgRpJztbUm/8lW/JDR2P/DGe+Cg55AeIO/fisNENw28e86M/MW1
 jqh92sgtZ5G3w6uMMHpcWZXD/UczQb4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-gAF0c3j-NfakLKTd8GAX8g-1; Thu,
 30 Nov 2023 08:12:00 -0500
X-MC-Unique: gAF0c3j-NfakLKTd8GAX8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCF833C000AD;
 Thu, 30 Nov 2023 13:11:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4224E492BFC;
 Thu, 30 Nov 2023 13:11:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3971121E6A1F; Thu, 30 Nov 2023 14:11:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  philmd@linaro.org,
 peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-8.2 2/2] string-output-visitor: Support lists for
 non-integer types
References: <20231121173416.346610-1-kwolf@redhat.com>
 <20231121173416.346610-3-kwolf@redhat.com>
Date: Thu, 30 Nov 2023 14:11:58 +0100
In-Reply-To: <20231121173416.346610-3-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 21 Nov 2023 18:34:16 +0100")
Message-ID: <87bkbb9yht.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

I understand Stefan already took this patch.  I'm looking at it anyway,
because experience has taught me to be very afraid of the string
visitors.

Kevin Wolf <kwolf@redhat.com> writes:

> With the introduction of list-based array properties in qdev, the string
> output visitor has to deal with lists of non-integer elements now ('info
> qtree' prints all properties with the string output visitor).
>
> Currently there is no explicit support for such lists, and the resulting
> output is only the last element because string_output_set() always
> replaces the output with the latest value.

Yes.

The string visitors were created just for QOM's object_property_parse()
and object_property_print().  At the time, QOM properties were limited
to scalars, and the new visitors implemented just enough of the visitor
API to be usable with scalars.  This was a Really Bad Idea(tm).

Commit a020f9809cf (qapi: add string-based visitors)
   and b2cd7dee86f (qom: add generic string parsing/printing).

When we wanted a QOM property for "set of NUMA node number", we extended
the visitors to support integer lists.  With fancy range syntax.  Except
for 'size'.  This was another Really Bad Idea(tm).

Commit 659268ffbff (qapi: make string input visitor parse int list)
   and 69e255635d0 (qapi: make string output visitor parse int list)

All the visitor stuff was scandalously under-documented (that's not even
a bad idea, just a Really Bad Habit(tm)).  When we added documentation
much later, we missed the lack of support for lists with elements other
than integers.  We later fixed that oversight for the input visitor
only.

Commit adfb264c9ed (qapi: Document visitor interfaces, add assertions)
   and c9fba9de89d (qapi: Rewrite string-input-visitor's integer and list parsing)

Your patch extends the string output visitor to support lists of
arbitrary scalars.

>                                            Instead of replacing the old
> value, append comma separated values in list context.
>
> The difference can be observed in 'info qtree' with a 'rocker' device
> that has a 'ports' list with more than one element.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/string-output-visitor.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Missing: update of string-output-visitor.h's comment

 * The string output visitor does not implement support for visiting
 * QAPI structs, alternates, null, or arbitrary QTypes.  It also
 * requires a non-null list argument to visit_start_list().

It is wrong before the patch: most lists do not work.  After the patch,
only lists of scalars work.  Document that, please.  Maybe:

 * The string output visitor does not implement support for visiting
 * QAPI structs, alternates, null, or arbitrary QTypes.  Only flat lists
 * are supported.  It also requires a non-null list argument to
 * visit_start_list().

Stolen from string-input-visitor.h's comment.

Could instead use "Only lists of scalars are supported."

Follow-up patch would be fine.

>
> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index 71ddc92b7b..c0cb72dbe4 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -74,11 +74,27 @@ static StringOutputVisitor *to_sov(Visitor *v)
>  
>  static void string_output_set(StringOutputVisitor *sov, char *string)
>  {
> -    if (sov->string) {
> -        g_string_free(sov->string, true);
> +    switch (sov->list_mode) {
> +    case LM_STARTED:
> +        sov->list_mode = LM_IN_PROGRESS;
> +        /* fall through */
> +    case LM_NONE:
> +        if (sov->string) {
> +            g_string_free(sov->string, true);
> +        }
> +        sov->string = g_string_new(string);
> +        g_free(string);
> +        break;
> +
> +    case LM_IN_PROGRESS:
> +    case LM_END:
> +        g_string_append(sov->string, ", ");
> +        g_string_append(sov->string, string);
> +        break;
> +
> +    default:
> +        abort();
>      }
> -    sov->string = g_string_new(string);
> -    g_free(string);
>  }
>  
>  static void string_output_append(StringOutputVisitor *sov, int64_t a)

The ->list_mode state machine was designed for parsing integer lists
with fancy range syntax.  Let me try to figure out how it works.

Initial state is LM_NONE.

On start_list():
    LM_NONE -> LM_STARTED.

On end_list():
    any -> LM_NONE. 

On next_list():
    any -> LM_END.

On print_type_int64():
    LM_STARTED -> LM_IN_PROGRESS
    LM_IN_PROGRESS -> LM_IN_PROGRESS
    LM_END -> LM_END

The two states LM_SIGNED_INTERVAL and LM_UNSIGNED_INTERVAL have never
been used.  Copy-pasta from opts-visitor.c.

Only real walks call next_list(), virtual walks do not.  In a real walk,
print_type_int64() executes its LM_END case for non-first elements.  In
a virtual walk, it executes its LM_IN_PROGRESS case.  This can't be
right.

What a load of confused crap.

Your string_output_set() treats LM_IN_PROGRESS and LM_END the same.
This could be right ;)

It behaves as before in state LM_NONE: overwrite sov->string.  Good.

In state LM_STARTED, it overwrites sov->string.  Good.

In states, LM_IN_PROGRESS and LM_END, it appends to sov->string.  Good.

It is used for all scalar visitors except print_type_int64() and
print_type_uint64().  Therefore, it makes all remaining scalars work in
lists.  Good.

Objects and nested lists still don't work.  If "info qdev" runs into a
such a property, it'll crash.  Not your patch's fault.

I loathe the string visitors.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

But please take care of fixing the comment in string-output-visitor.h.


