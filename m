Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C37A8D93
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:11:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3Xa-00062L-9n; Wed, 20 Sep 2023 16:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qj3XS-00061w-Ka
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qj3XQ-0004e7-4c
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695240666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzgvNJzY/68WUln+4ygEgcbphW7zrzD8/5OdQWeLmIw=;
 b=B4DWnVI9QORlb9+vMdkSMMVxIL+gZMRXoSNxkiyfO8T2MgfUkqCXK3UPBPxdD4D75OP634
 O8YkDK22xywFoturFEDXwSAFzwbb3LoNQhd+NOuCadnSZ1FFB+vjCOWxMCkNydMbU9vBnF
 AqHoifg/5tBjLGsk+vA+lJauUaC0iSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-rRZj9kNcNqGVfV692jvxlw-1; Wed, 20 Sep 2023 16:11:03 -0400
X-MC-Unique: rRZj9kNcNqGVfV692jvxlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42BE38001EA;
 Wed, 20 Sep 2023 20:11:02 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B256D140E950;
 Wed, 20 Sep 2023 20:10:59 +0000 (UTC)
Date: Wed, 20 Sep 2023 15:10:58 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com, pl@kamp.de,
 sw@weilnetz.de, 
 sstabellini@kernel.org, anthony.perard@citrix.com, paul@xen.org,
 pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, 
 stefanha@redhat.com, fam@euphon.net, quintela@redhat.com, peterx@redhat.com, 
 leobras@redhat.com, kraxel@redhat.com, qemu-block@nongnu.org, 
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 7/7] qobject atomics osdep: Make a few macros more
 hygienic
Message-ID: <3gjitlytxqobntg4fluip365s5ijwt3h2zvf3tjbmtiifikv53@xxrl7slw5tjt>
References: <20230920183149.1105333-1-armbru@redhat.com>
 <20230920183149.1105333-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920183149.1105333-8-armbru@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Wed, Sep 20, 2023 at 08:31:49PM +0200, Markus Armbruster wrote:
...
> The only reliable way to prevent unintended variable name capture is
> -Wshadow.
> 
> One blocker for enabling it is shadowing hiding in function-like
> macros like
> 
>      qdict_put(dict, "name", qobject_ref(...))
> 
> qdict_put() wraps its last argument in QOBJECT(), and the last
> argument here contains another QOBJECT().
> 
> Use dark preprocessor sorcery to make the macros that give us this
> problem use different variable names on every call.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

It's changed (for the better) since v1, so I'm re-reviewing.

> ---
>  include/qapi/qmp/qobject.h | 11 +++++++++--
>  include/qemu/atomic.h      | 17 ++++++++++++-----
>  include/qemu/compiler.h    |  3 +++
>  include/qemu/osdep.h       | 31 +++++++++++++++++++++++--------
>  4 files changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
> index 9003b71fd3..d36cc97805 100644
> --- a/include/qapi/qmp/qobject.h
> +++ b/include/qapi/qmp/qobject.h
> @@ -45,10 +45,17 @@ struct QObject {
>      struct QObjectBase_ base;
>  };
>  
> -#define QOBJECT(obj) ({                                         \
> +/*
> + * Preprocessory sorcery ahead: use a different identifier for the

s/Preprocessory/Preprocessor/ (multiple times in the patch)

> + * local variable in each expansion, so we can nest macro calls
> + * without shadowing variables.
> + */
> +#define QOBJECT_INTERNAL(obj, _obj) ({                          \
>      typeof(obj) _obj = (obj);                                   \
> -    _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
> +    _obj                                                        \
> +        ? container_of(&(_obj)->base, QObject, base) : NULL;    \

As pointed out before, you can write &_obj->base instead of
&(_obj)->base, now that we know _obj is a single identifier rather
than an arbitrary expression.  Not strictly necessary since the extra
() doesn't change semantics...

>  })
> +#define QOBJECT(obj) QOBJECT_INTERNAL((obj), MAKE_IDENTFIER(_obj))
>  
>  /* Required for qobject_to() */
>  #define QTYPE_CAST_TO_QNull     QTYPE_QNULL
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index d95612f7a0..d4cbd01909 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -157,13 +157,20 @@
>      smp_read_barrier_depends();
>  #endif
>  
> -#define qatomic_rcu_read(ptr)                          \
> -    ({                                                 \
> +/*
> + * Preprocessory sorcery ahead: use a different identifier for the
> + * local variable in each expansion, so we can nest macro calls
> + * without shadowing variables.
> + */
> +#define qatomic_rcu_read_internal(ptr, _val)            \
> +    ({                                                  \
>      qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
> -    typeof_strip_qual(*ptr) _val;                      \
> -    qatomic_rcu_read__nocheck(ptr, &_val);             \
> -    _val;                                              \
> +    typeof_strip_qual(*ptr) _val;                       \
> +    qatomic_rcu_read__nocheck(ptr, &_val);              \

...but it looks odd for the patch to not be consistent on that front.

> +    _val;                                               \
>      })
> +#define qatomic_rcu_read(ptr) \
> +    qatomic_rcu_read_internal((ptr), MAKE_IDENTFIER(_val))
>  
>  #define qatomic_rcu_set(ptr, i) do {                   \
>      qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index a309f90c76..03236d830c 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -37,6 +37,9 @@
>  #define tostring(s) #s
>  #endif
>  
> +/* Expands into an identifier stemN, where N is another number each time */
> +#define MAKE_IDENTFIER(stem) glue(stem, __COUNTER__)

I like how this turned out.

With the spelling fix, and optionally with the redundant () dropped,
you can keep my R-b.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


