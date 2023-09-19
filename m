Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DAD7A59F9
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 08:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUFf-0002c1-55; Tue, 19 Sep 2023 02:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiUFU-0002ak-2n
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiUFQ-0000vg-W0
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695105009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GnEy/R37W9DqVlZ+UU16jlrw13YWmEkRgYevJnbQIhY=;
 b=I3xQnalN61/ctqXcxrNKZT4X56zRhTimGaFZKf+86KKFBkEdonOhbjgrSXkohIsOhhD8EA
 nBCRNs5mLascRB2XJlpd4ji/fgBhuMPeXN13ADbYnPUk/tWG7s7yqvWFM/1hjn7WdbwOPu
 E0t1iLfMFpuYqDsCqdF1uR5+pSli17w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-Mbk6CQNmM5-oLzM5NqDO9A-1; Tue, 19 Sep 2023 02:30:00 -0400
X-MC-Unique: Mbk6CQNmM5-oLzM5NqDO9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3520C185A78E;
 Tue, 19 Sep 2023 06:30:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C33C014171B6;
 Tue, 19 Sep 2023 06:29:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC2D721E6900; Tue, 19 Sep 2023 08:29:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 kwolf@redhat.com,  hreitz@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com,  idryomov@gmail.com,  sw@weilnetz.de,
 sstabellini@kernel.org,  anthony.perard@citrix.com,  paul@xen.org,
 pbonzini@redhat.com,  marcandre.lureau@redhat.com,  berrange@redhat.com,
 thuth@redhat.com,  philmd@linaro.org,  stefanha@redhat.com,
 fam@euphon.net,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com,  kraxel@redhat.com,  qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org,  alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 7/7] qobject atomics osdep: Make a few macros more hygienic
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-8-armbru@redhat.com>
 <vfkfi6uld3gbd4urmqdlzkv6djtws6mkbluc5qvwcla6btszhu@ff66zfyd7smm>
 <87ledqjn39.fsf@pond.sub.org>
 <viam47z5ascty5zluzvj3byrrrp2fe6jh6vevcaggpozxwzabj@avo7fb3gs7bt>
Date: Tue, 19 Sep 2023 08:29:58 +0200
In-Reply-To: <viam47z5ascty5zluzvj3byrrrp2fe6jh6vevcaggpozxwzabj@avo7fb3gs7bt>
 (Eric Blake's message of "Fri, 1 Sep 2023 08:18:38 -0500")
Message-ID: <87v8c63cbd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Eric Blake <eblake@redhat.com> writes:

> On Fri, Sep 01, 2023 at 10:48:26AM +0200, Markus Armbruster wrote:
>> > Indeed, not fully understanding the preprocessor makes for some
>> > interesting death traps.
>> 
>> We use ALL_CAPS for macros to signal "watch out for traps".
>> 
>
>> >> -#define QOBJECT(obj) ({                                         \
>> >> -    typeof(obj) _obj = (obj);                                   \
>> >> -    _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
>> >> +#define QOBJECT_INTERNAL(obj, l) ({                                     \
>> >> +    typeof(obj) PASTE(_obj, l) = (obj);                                 \
>> >> +    PASTE(_obj, l)                                                      \
>> >> +        ? container_of(&(PASTE(_obj, l))->base, QObject, base) : NULL;  \
>> >>  })
>> >> +#define QOBJECT(obj) QOBJECT_INTERNAL((obj), __COUNTER__)
>> >
>> > Slick!  Every call to QOBJECT() defines a unique temporary variable
>> > name.  But as written, QOBJECT(o) expands to this (when __COUNTER__ is
>> > 1):
>> >
>> > ({
>> >   typeof((o)) _obj1 = ((o));
>> >   _obj1 ? container_of(&(_obj1)->base, QObject, base) : NULL;
>> > })
>> >
>> > which has three sets of redundant parens that could be elided.  Why do
>> > you need to add () around obj when forwarding to QOBJECT_INTERNAL()?
>> 
>> Habit: enclose macro arguments in parenthesis unless there's a specific
>> need not to.
>> 
>> > The only way the expansion of the text passed through the 'obj'
>> > parameter can contain a comma is if the user has already parenthesized
>> > it on their end (not that I expect a comma expression to be a frequent
>> > argument to QOBJECT(), but who knows).  Arguing that it is to silence
>> > a syntax checker is weak; since we must NOT add parens around the
>> > parameters to QOBJECT_INTERNAL (calling PASTE((_obj), (l)) is
>> > obviously wrong).
>> >
>> > Meanwhile, the repetition of three calls to PASTE() is annoying.  How
>> > about:
>> >
>> > #define QOBJECT_INTERNAL_2(_obj, _tmp) ({ \
>> >   typeof _obj _tmp = _obj; \
>> >   _tmp ? container_of(&_tmp->base, QObject, base) : NULL; \
>> >   )}
>> > #define QOBJECT_INTERNAL_1(_arg, _tmp) QOBJECT_INTERNAL_2(_arg, _tmp)
>> > #define QOBJECT_INTERNAL(_arg, _ctr) \
>> >   QOBJECT_INTERNAL_1(_arg, PASTE(_obj, _ctr))
>> > #define QOBJECT(obj) QOBJECT_INTERNAL((obj), __COUNTER__)
>> >
>> > or:
>> >
>> > #define QOBJECT_INTERNAL_2(_obj, _tmp) ({ \
>> >   typeof(_obj) _tmp = (_obj); \
>> >   _tmp ? container_of(&_tmp->base, QObject, base) : NULL; \
>> >   )}
>> > #define QOBJECT_INTERNAL_1(_arg, _tmp) QOBJECT_INTERNAL_2(_arg, _tmp)
>> > #define QOBJECT_INTERNAL(_arg, _ctr) \
>> >   QOBJECT_INTERNAL_1(_arg, PASTE(_obj, _ctr))
>> > #define QOBJECT(obj) QOBJECT_INTERNAL(obj, __COUNTER__)
>> >
>> > where, in either case, QOBJECT(o) should then expand to
>> >
>> > ({
>> >   typeof (o) _obj1 = (o);
>> >   _obj1 ? container_of(&_obj1->base, QObject, base) : NULL;
>> > })
>> 
>> The idea is to have the innermost macro take the variable name instead
>> of the counter.  "PASTE(_obj, l)" then becomes "_tmp" there, which is
>> more legible.  However, we pay for it by going through two more macros.
>> 
>> Can you explain why you need two more?
>
> Likewise habit, on my part (and laziness - I wrote the previous email
> without testing anything). I've learned over the years that pasting is
> hard (you can't mix ## with a macro that you want expanded without 2
> layers of indirection), so I started out by adding two layers of
> QOBJECT_INTERNAL, then wrote QOBJECT to forward to QOBJECT_INTERNAL.
> But now that you asked, I actually spent the time to test with the
> preprocessor, and your hunch is indeed correct: I over-compensated
> becaues of my habit.
>
> $cat foo.c
> #define PASTE(_a, _b) _a##_b
>
> #define QOBJECT_INTERNAL_2(_obj, _tmp) ({       \
>   typeof _obj _tmp = _obj; \
>   _tmp ? container_of(&_tmp->base, QObject, base) : NULL; \
>   )}
> #define QOBJECT_INTERNAL_1(_arg, _tmp) QOBJECT_INTERNAL_2(_arg, _tmp)
> #define QOBJECT_INTERNAL(_arg, _ctr) \
>   QOBJECT_INTERNAL_1(_arg, PASTE(_obj, _ctr))
> #define QOBJECT(obj) QOBJECT_INTERNAL((obj), __COUNTER__)
>
> QOBJECT(o)
>
> #define Q_INTERNAL_1(_obj, _tmp) ({ \
>   typeof _obj _tmp = _obj; \
>   _tmp ? container_of(&_tmp->base, QObject, base) : NULL; \
>   )}
> #define Q_INTERNAL(_arg, _ctr) \
>   Q_INTERNAL_1(_arg, PASTE(_obj, _ctr))
> #define Q(obj) Q_INTERNAL((obj), __COUNTER__)
>
> Q(o)
> $ gcc -E foo.c
> # 0 "foo.c"
> # 0 "<built-in>"
> # 0 "<command-line>"
> # 1 "/usr/include/stdc-predef.h" 1 3 4
> # 0 "<command-line>" 2
> # 1 "foo.c"
> # 12 "foo.c"
> ({ typeof (o) _obj0 = (o); _obj0 ? container_of(&_obj0->base, QObject, base) : NULL; )}
> # 22 "foo.c"
> ({ typeof (o) _obj1 = (o); _obj1 ? container_of(&_obj1->base, QObject, base) : NULL; )}
>
> So the important part was merely ensuring that __COUNTER__ has a
> chance to be expanded PRIOR to the point where ## gets its argument,
> and one less layer of indirection was still sufficient for that.

The version with less indirection is easier to understand for me.

>> 
>> Complication: the innermost macro needs to take all its variable names
>> as arguments.  The macro above has just one.  Macros below have two.
>> 
>> Not quite sure which version is easier to understand.
>
> Proper comments may help; once you realize that you are passing in the
> unique variable name(s) to be used as the temporary identifier(s),
> rather than an integer that still needs to be glued, then separating
> the task of generating name(s) (which is done once per name, instead
> of repeated 3 times) makes sense to me.  I also like minimizing the
> number of times I have to spell out __COUNTER__; wrapping unique name
> generation behind a well-named helper macro gives a better view of why
> it is needed in the first place.

I can add this comment to every instance of the __COUNTER__ trick:

    /*
     * Preprocessor wizardry ahead: glue(_val, l) expands to a new
     * identifier in each macro expansion.  Helps avoid shadowing
     * variables and the unwanted name captures that come with it.
     */

> At any rate, this comment still applies:
>
>> >
>> > I think you are definitely on the right track to have all internal
>> > variable declarations within a macro definition use multi-layered
>> > expansion with the help of __COUNTER__ to ensure that the macro's
>> > temporary variable is globally unique; so if you leave it as written,
>> > I could live with:
>> >
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> >
>> > But if you respin it to pick up any of my suggestions, I'll definitely
>> > spend another review cycle on the result.
>> >
>> > If it helps, here's what I ended up using in nbdkit:
>> >
>> > https://gitlab.com/nbdkit/nbdkit/-/blame/master/common/include/unique-name.h#L36
>> > /* https://stackoverflow.com/a/1597129
>> >  * https://stackoverflow.com/a/12711226
>> >  */
>> > #define XXUNIQUE_NAME(name, counter) name ## counter
>> > #define XUNIQUE_NAME(name, counter) XXUNIQUE_NAME (name, counter)
>> > #define NBDKIT_UNIQUE_NAME(name) XUNIQUE_NAME (name, __COUNTER__)
>> >
>> > https://gitlab.com/nbdkit/nbdkit/-/blame/master/common/include/minmax.h#L47
>> > #include "unique-name.h"
>> >
>> > #undef MIN
>> > #define MIN(x, y) \
>> >   MIN_1 ((x), (y), NBDKIT_UNIQUE_NAME (_x), NBDKIT_UNIQUE_NAME (_y))
>> >
>> > ...
>> > #define MIN_1(x, y, _x, _y) ({                 \
>> >       __auto_type _x = (x);                    \
>> >       __auto_type _y = (y);                    \
>> >       _x < _y ? _x : _y;                       \
>> >     })
>> 
>> Thanks!
>
> and so I'm fine leaving it up to you if you want to copy the paradigm
> I've seen elsewhere, or if you want to leave it as you first proposed.
> The end result is the same, and it is more of a judgment call on which
> form is easier for you to reason about.

I need to review the two competing versions once more to decide which I
find easier to read.  Or shall I say less hard; preprocessor wizardry is
never really easy.

> But as other commenters mentioned, we already have a glue() macro, so
> use that instead of PASTE(), no matter what else you choose.
>
> Looking forward to v2!

Thanks again!


