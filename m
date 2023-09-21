Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5E7A92BD
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFHB-0005ZA-Ce; Thu, 21 Sep 2023 04:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qjFH9-0005Yf-Fr
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qjFH7-0002c6-U9
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695285785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWLMZ+X5Hd+F/5mLyFftJEP9/PMaQw/y62tEWzEwLSU=;
 b=dH3zotxIyGrSQtZ6MMBRrd/ZUlvJv8R54/8LIisnP93fdrThLjxicbTGfDAuMe2kptueR1
 UD9H5RhJlZBvYNlIIhQUdPxJmTp8WumIYYcVnK5ANscKSxmL48IIUxYubAjhAcPq51zCF4
 c0RWzuVM6DblU184prUYdEnos+Ul1Jw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-y9yC9AFJMomrr9msxjQjNg-1; Thu, 21 Sep 2023 04:43:02 -0400
X-MC-Unique: y9yC9AFJMomrr9msxjQjNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB882803497;
 Thu, 21 Sep 2023 08:43:01 +0000 (UTC)
Received: from redhat.com (dhcp-192-199.str.redhat.com [10.33.192.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7471020268D5;
 Thu, 21 Sep 2023 08:42:58 +0000 (UTC)
Date: Thu, 21 Sep 2023 10:42:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 7/7] qobject atomics osdep: Make a few macros more
 hygienic
Message-ID: <ZQwCEW4SBpI9f1Yx@redhat.com>
References: <20230920183149.1105333-1-armbru@redhat.com>
 <20230920183149.1105333-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920183149.1105333-8-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 20.09.2023 um 20:31 hat Markus Armbruster geschrieben:
> Variables declared in macros can shadow other variables.  Much of the
> time, this is harmless, e.g.:
> 
>     #define _FDT(exp)                                                  \
>         do {                                                           \
>             int ret = (exp);                                           \
>             if (ret < 0) {                                             \
>                 error_report("error creating device tree: %s: %s",   \
>                         #exp, fdt_strerror(ret));                      \
>                 exit(1);                                               \
>             }                                                          \
>         } while (0)
> 
> Harmless shadowing in h_client_architecture_support():
> 
>         target_ulong ret;
> 
>         [...]
> 
>         ret = do_client_architecture_support(cpu, spapr, vec, fdt_bufsize);
>         if (ret == H_SUCCESS) {
>             _FDT((fdt_pack(spapr->fdt_blob)));
>             [...]
>         }
> 
>         return ret;
> 
> However, we can get in trouble when the shadowed variable is used in a
> macro argument:
> 
>     #define QOBJECT(obj) ({                                 \
>         typeof(obj) o = (obj);                              \
>         o ? container_of(&(o)->base, QObject, base) : NULL; \
>      })
> 
> QOBJECT(o) expands into
> 
>     ({
> --->    typeof(o) o = (o);
>         o ? container_of(&(o)->base, QObject, base) : NULL;
>     })
> 
> Unintended variable name capture at --->.  We'd be saved by
> -Winit-self.  But I could certainly construct more elaborate death
> traps that don't trigger it.
> 
> To reduce the risk of trapping ourselves, we use variable names in
> macros that no sane person would use elsewhere.  Here's our actual
> definition of QOBJECT():
> 
>     #define QOBJECT(obj) ({                                         \
>         typeof(obj) _obj = (obj);                                   \
>         _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
>     })
> 
> Works well enough until we nest macro calls.  For instance, with
> 
>     #define qobject_ref(obj) ({                     \
>         typeof(obj) _obj = (obj);                   \
>         qobject_ref_impl(QOBJECT(_obj));            \
>         _obj;                                       \
>     })
> 
> the expression qobject_ref(obj) expands into
> 
>     ({
>         typeof(obj) _obj = (obj);
>         qobject_ref_impl(
>             ({
> --->            typeof(_obj) _obj = (_obj);
>                 _obj ? container_of(&(_obj)->base, QObject, base) : NULL;
>             }));
>         _obj;
>     })
> 
> Unintended variable name capture at --->.
> 
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
> + * local variable in each expansion, so we can nest macro calls
> + * without shadowing variables.
> + */
> +#define QOBJECT_INTERNAL(obj, _obj) ({                          \
>      typeof(obj) _obj = (obj);                                   \
> -    _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
> +    _obj                                                        \
> +        ? container_of(&(_obj)->base, QObject, base) : NULL;    \

What happened here? The code in this line (or now two lines) seems to be
unchanged apart from a strange looking newline.

>  })
> +#define QOBJECT(obj) QOBJECT_INTERNAL((obj), MAKE_IDENTFIER(_obj))

Kevin


