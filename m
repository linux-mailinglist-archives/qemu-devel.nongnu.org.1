Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1916F78FA2F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzpW-0000I2-Ql; Fri, 01 Sep 2023 04:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbzpV-0000HJ-2K
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbzpS-0007D9-35
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693558113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDec9lEmkr03tUmuqrMQUr6Z0wXTALRazdDr4iYPmgI=;
 b=X4hFf0HvEwrjcRdfzi0H2tFectEoL2zBk00Z93xzYkdHNrXPBy9bs58QkAEEmpmQmtDDhM
 ekXiPs2f0Y+7NswKhVZaDsftHyjMiz3i7qKDTREml8GvnZqYrC9+pwFCOhLnTiKTll7y5D
 14iTseueJA+KO1ZUAFx137mXs9K8t1k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-_-5Ivo6gMjGpo5PL1QjuTA-1; Fri, 01 Sep 2023 04:48:30 -0400
X-MC-Unique: _-5Ivo6gMjGpo5PL1QjuTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E9FB1C05ED8;
 Fri,  1 Sep 2023 08:48:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC29D2166B26;
 Fri,  1 Sep 2023 08:48:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E451721E692A; Fri,  1 Sep 2023 10:48:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  kwolf@redhat.com,  hreitz@redhat.com,
 vsementsov@yandex-team.ru,  jsnow@redhat.com,  idryomov@gmail.com,
 pl@kamp.de,  sw@weilnetz.de,  sstabellini@kernel.org,
 anthony.perard@citrix.com,  paul@xen.org,  pbonzini@redhat.com,
 marcandre.lureau@redhat.com,  berrange@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  stefanha@redhat.com,  fam@euphon.net,
 quintela@redhat.com,  peterx@redhat.com,  leobras@redhat.com,
 kraxel@redhat.com,  qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org,  alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 7/7] qobject atomics osdep: Make a few macros more hygienic
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-8-armbru@redhat.com>
 <vfkfi6uld3gbd4urmqdlzkv6djtws6mkbluc5qvwcla6btszhu@ff66zfyd7smm>
Date: Fri, 01 Sep 2023 10:48:26 +0200
In-Reply-To: <vfkfi6uld3gbd4urmqdlzkv6djtws6mkbluc5qvwcla6btszhu@ff66zfyd7smm>
 (Eric Blake's message of "Thu, 31 Aug 2023 09:30:33 -0500")
Message-ID: <87ledqjn39.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Thu, Aug 31, 2023 at 03:25:46PM +0200, Markus Armbruster wrote:
>
> [This paragraph written last: Bear with my stream of consciousness
> review below, where I end up duplicating some of the conslusions you
> reached before the point where I saw where the patch was headed]
>
>> Variables declared in macros can shadow other variables.  Much of the
>> time, this is harmless, e.g.:
>> 
>>     #define _FDT(exp)                                                  \
>>         do {                                                           \
>>             int ret = (exp);                                           \
>>             if (ret < 0) {                                             \
>>                 error_report("error creating device tree: %s: %s",   \
>>                         #exp, fdt_strerror(ret));                      \
>>                 exit(1);                                               \
>>             }                                                          \
>>         } while (0)
>
> Which is why I've seen some projects require a strict namespace
> separation: if all macro parameters and any identifiers declared in
> macros use either a leading or a trailing _ (I prefer a trailing one,
> to avoid risking conflicts with libc reserved namespace; but leading
> is usually okay), and all other identifiers avoid that namespace, then
> you will never have shadowing by calling a macro from normal code.
>
>> 
>> Harmless shadowing in h_client_architecture_support():
>> 
>>         target_ulong ret;
>> 
>>         [...]
>> 
>>         ret = do_client_architecture_support(cpu, spapr, vec, fdt_bufsize);
>>         if (ret == H_SUCCESS) {
>>             _FDT((fdt_pack(spapr->fdt_blob)));
>>             [...]
>>         }
>> 
>>         return ret;
>> 
>> However, we can get in trouble when the shadowed variable is used in a
>> macro argument:
>> 
>>     #define QOBJECT(obj) ({                                 \
>>         typeof(obj) o = (obj);                              \
>>         o ? container_of(&(o)->base, QObject, base) : NULL; \
>>      })
>> 
>> QOBJECT(o) expands into
>> 
>>     ({
>> --->    typeof(o) o = (o);
>>         o ? container_of(&(o)->base, QObject, base) : NULL;
>>     })
>> 
>> Unintended variable name capture at --->.  We'd be saved by
>> -Winit-self.  But I could certainly construct more elaborate death
>> traps that don't trigger it.
>
> Indeed, not fully understanding the preprocessor makes for some
> interesting death traps.

We use ALL_CAPS for macros to signal "watch out for traps".

>> To reduce the risk of trapping ourselves, we use variable names in
>> macros that no sane person would use elsewhere.  Here's our actual
>> definition of QOBJECT():
>> 
>>     #define QOBJECT(obj) ({                                         \
>>         typeof(obj) _obj = (obj);                                   \
>>         _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
>>     })
>
> Yep, goes back to the policy I've seen of enforcing naming conventions
> that ensure macros can't shadow normal code.
>
>> 
>> Works well enough until we nest macro calls.  For instance, with
>> 
>>     #define qobject_ref(obj) ({                     \
>>         typeof(obj) _obj = (obj);                   \
>>         qobject_ref_impl(QOBJECT(_obj));            \
>>         _obj;                                       \
>>     })
>> 
>> the expression qobject_ref(obj) expands into
>> 
>>     ({
>>         typeof(obj) _obj = (obj);
>>         qobject_ref_impl(
>>             ({
>> --->            typeof(_obj) _obj = (_obj);
>>                 _obj ? container_of(&(_obj)->base, QObject, base) : NULL;
>>             }));
>>         _obj;
>>     })
>> 
>> Unintended variable name capture at --->.
>
> Yep, you've just proven how macros calling macros requires care, as we
> no longer have the namespace protections.  If macro calls can only
> form a DAG, it is possible to choose unique intermediate declarations
> for every macro (although remembering to do that, and still keeping
> the macro definition legible, may not be easy).  But if you can have
> macros that form any sort of nesting loop (and we WANT to allow things
> like MIN(MIN(a, b), c) - which is such a loop), dynamic naming becomes
> the only solution.
>
>> 
>> The only reliable way to prevent unintended variable name capture is
>> -Wshadow.
>
> Yes, I would love to have that enabled eventually.
>
>> 
>> One blocker for enabling it is shadowing hiding in function-like
>> macros like
>> 
>>      qdict_put(dict, "name", qobject_ref(...))
>> 
>> qdict_put() wraps its last argument in QOBJECT(), and the last
>> argument here contains another QOBJECT().
>> 
>> Use dark preprocessor sorcery to make the macros that give us this
>> problem use different variable names on every call.
>
> Sounds foreboding; hopefully not many macros are affected...
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/qmp/qobject.h |  8 +++++---
>>  include/qemu/atomic.h      | 11 ++++++-----
>>  include/qemu/osdep.h       | 34 +++++++++++++++++++---------------
>>  3 files changed, 30 insertions(+), 23 deletions(-)
>
> ...okay, the size of the diffstat seems tolerable (good that we don't
> have many macros that expand to a temporary variable declaration and
> which are likely to be heavily reused from nested contexts).
>
>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>> index 9003b71fd3..7b50fc905d 100644
>> --- a/include/qapi/qmp/qobject.h
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -45,10 +45,12 @@ struct QObject {
>>      struct QObjectBase_ base;
>>  };
>>  
>> -#define QOBJECT(obj) ({                                         \
>> -    typeof(obj) _obj = (obj);                                   \
>> -    _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
>> +#define QOBJECT_INTERNAL(obj, l) ({                                     \
>> +    typeof(obj) PASTE(_obj, l) = (obj);                                 \
>> +    PASTE(_obj, l)                                                      \
>> +        ? container_of(&(PASTE(_obj, l))->base, QObject, base) : NULL;  \
>>  })
>> +#define QOBJECT(obj) QOBJECT_INTERNAL((obj), __COUNTER__)
>
> Slick!  Every call to QOBJECT() defines a unique temporary variable
> name.  But as written, QOBJECT(o) expands to this (when __COUNTER__ is
> 1):
>
> ({
>   typeof((o)) _obj1 = ((o));
>   _obj1 ? container_of(&(_obj1)->base, QObject, base) : NULL;
> })
>
> which has three sets of redundant parens that could be elided.  Why do
> you need to add () around obj when forwarding to QOBJECT_INTERNAL()?

Habit: enclose macro arguments in parenthesis unless there's a specific
need not to.

> The only way the expansion of the text passed through the 'obj'
> parameter can contain a comma is if the user has already parenthesized
> it on their end (not that I expect a comma expression to be a frequent
> argument to QOBJECT(), but who knows).  Arguing that it is to silence
> a syntax checker is weak; since we must NOT add parens around the
> parameters to QOBJECT_INTERNAL (calling PASTE((_obj), (l)) is
> obviously wrong).
>
> Meanwhile, the repetition of three calls to PASTE() is annoying.  How
> about:
>
> #define QOBJECT_INTERNAL_2(_obj, _tmp) ({ \
>   typeof _obj _tmp = _obj; \
>   _tmp ? container_of(&_tmp->base, QObject, base) : NULL; \
>   )}
> #define QOBJECT_INTERNAL_1(_arg, _tmp) QOBJECT_INTERNAL_2(_arg, _tmp)
> #define QOBJECT_INTERNAL(_arg, _ctr) \
>   QOBJECT_INTERNAL_1(_arg, PASTE(_obj, _ctr))
> #define QOBJECT(obj) QOBJECT_INTERNAL((obj), __COUNTER__)
>
> or:
>
> #define QOBJECT_INTERNAL_2(_obj, _tmp) ({ \
>   typeof(_obj) _tmp = (_obj); \
>   _tmp ? container_of(&_tmp->base, QObject, base) : NULL; \
>   )}
> #define QOBJECT_INTERNAL_1(_arg, _tmp) QOBJECT_INTERNAL_2(_arg, _tmp)
> #define QOBJECT_INTERNAL(_arg, _ctr) \
>   QOBJECT_INTERNAL_1(_arg, PASTE(_obj, _ctr))
> #define QOBJECT(obj) QOBJECT_INTERNAL(obj, __COUNTER__)
>
> where, in either case, QOBJECT(o) should then expand to
>
> ({
>   typeof (o) _obj1 = (o);
>   _obj1 ? container_of(&_obj1->base, QObject, base) : NULL;
> })

The idea is to have the innermost macro take the variable name instead
of the counter.  "PASTE(_obj, l)" then becomes "_tmp" there, which is
more legible.  However, we pay for it by going through two more macros.

Can you explain why you need two more?

Complication: the innermost macro needs to take all its variable names
as arguments.  The macro above has just one.  Macros below have two.

Not quite sure which version is easier to understand.

>>  /* Required for qobject_to() */
>>  #define QTYPE_CAST_TO_QNull     QTYPE_QNULL
>> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
>> index d95612f7a0..3f80ffac69 100644
>> --- a/include/qemu/atomic.h
>> +++ b/include/qemu/atomic.h
>> @@ -157,13 +157,14 @@
>>      smp_read_barrier_depends();
>>  #endif
>>  
>> -#define qatomic_rcu_read(ptr)                          \
>> -    ({                                                 \
>> +#define qatomic_rcu_read_internal(ptr, l)               \
>> +    ({                                                  \
>>      qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
>> -    typeof_strip_qual(*ptr) _val;                      \
>> -    qatomic_rcu_read__nocheck(ptr, &_val);             \
>> -    _val;                                              \
>> +    typeof_strip_qual(*ptr) PASTE(_val, l);             \
>> +    qatomic_rcu_read__nocheck(ptr, &PASTE(_val, l));    \
>> +    PASTE(_val, l);                                     \
>>      })
>> +#define qatomic_rcu_read(ptr) qatomic_rcu_read_internal((ptr), __COUNTER__)
>
> Same observation about being able to reduce the number of PASTE()
> calls by adding yet another layer of macro invocations.
>
>>  
>>  #define qatomic_rcu_set(ptr, i) do {                   \
>>      qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 21ef8f1699..9c191ebe99 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -371,18 +371,21 @@ void QEMU_ERROR("code path is reachable")
>>   * have to open-code it.  Sadly, Coverity is severely confused by the
>>   * constant variants, so we have to dumb things down there.
>>   */
>> +#define PASTE(a, b) a##b
>> +#define MIN_INTERNAL(a, b, l)                                           \
>> +    ({                                                                  \
>> +        typeof(1 ? (a) : (b)) PASTE(_a, l) = (a), PASTE(_b, l) = (b);   \
>> +        PASTE(_a, l) < PASTE(_b, l) ? PASTE(_a, l) : PASTE(_b, l);      \
>> +    })
>
> And again.
>
> I think you are definitely on the right track to have all internal
> variable declarations within a macro definition use multi-layered
> expansion with the help of __COUNTER__ to ensure that the macro's
> temporary variable is globally unique; so if you leave it as written,
> I could live with:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> But if you respin it to pick up any of my suggestions, I'll definitely
> spend another review cycle on the result.
>
> If it helps, here's what I ended up using in nbdkit:
>
> https://gitlab.com/nbdkit/nbdkit/-/blame/master/common/include/unique-name.h#L36
> /* https://stackoverflow.com/a/1597129
>  * https://stackoverflow.com/a/12711226
>  */
> #define XXUNIQUE_NAME(name, counter) name ## counter
> #define XUNIQUE_NAME(name, counter) XXUNIQUE_NAME (name, counter)
> #define NBDKIT_UNIQUE_NAME(name) XUNIQUE_NAME (name, __COUNTER__)
>
> https://gitlab.com/nbdkit/nbdkit/-/blame/master/common/include/minmax.h#L47
> #include "unique-name.h"
>
> #undef MIN
> #define MIN(x, y) \
>   MIN_1 ((x), (y), NBDKIT_UNIQUE_NAME (_x), NBDKIT_UNIQUE_NAME (_y))
>
> ...
> #define MIN_1(x, y, _x, _y) ({                 \
>       __auto_type _x = (x);                    \
>       __auto_type _y = (y);                    \
>       _x < _y ? _x : _y;                       \
>     })

Thanks!


