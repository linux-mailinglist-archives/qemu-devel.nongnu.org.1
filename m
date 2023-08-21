Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C9F782636
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 11:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1AV-0003Th-29; Mon, 21 Aug 2023 05:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1AT-0003TZ-FI
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1AP-0003yR-DW
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692609944;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=c6r0VM+Il1rtDu5YFeTzXX2bOaetAg3O6QucdtEN6Qs=;
 b=Da11JG6Zh+yjgkQGPx1boIHNBTWTbgxQSr6w47Oixcr8mjq8n0J27yzDFsV0IpXvH5WZ48
 pgQ/y9DjHya+/jecFS1Rhbxww1cR1hALIPzsVI8f0Vsm1jBC6FRkLUkY0/wpJK+ct0K0W9
 6nh+oC2HdCsQEo44LGjGciWl3gXE950=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-7w7zhsm8OsOCDR6NXxJdWw-1; Mon, 21 Aug 2023 05:25:40 -0400
X-MC-Unique: 7w7zhsm8OsOCDR6NXxJdWw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2D3B85CBE5;
 Mon, 21 Aug 2023 09:25:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C53E4021B9;
 Mon, 21 Aug 2023 09:25:36 +0000 (UTC)
Date: Mon, 21 Aug 2023 10:25:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 19/58] qom: implement property helper for sha384
Message-ID: <ZOMtj0La71zf/uGd@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-20-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-20-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 18, 2023 at 05:50:02AM -0400, Xiaoyao Li wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Implement property_add_sha384() which converts hex string <-> uint8_t[48]
> It will be used for TDX which uses sha384 for measurement.

I think it is likely a better idea to use base64 for the encoding
the binary hash - we use base64 for all the sev-guest properties
that were binary data.

At which points the property set/get logic is much simpler as it
is just needing a call to  g_base64_encode / g_base64_decode and
length validation for the decode case.

> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  include/qom/object.h | 17 ++++++++++
>  qom/object.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index ef7258a5e149..70399a5b1940 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1887,6 +1887,23 @@ ObjectProperty *object_property_add_alias(Object *obj, const char *name,
>  ObjectProperty *object_property_add_const_link(Object *obj, const char *name,
>                                                 Object *target);
>  
> +
> +/**
> + * object_property_add_sha384:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an sha384 property in memory.  This function will add a
> + * property of type 'sha384'.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty * object_property_add_sha384(Object *obj, const char *name,
> +                                            const uint8_t *v,
> +                                            ObjectPropertyFlags flags);
> +
>  /**
>   * object_property_set_description:
>   * @obj: the object owning the property
> diff --git a/qom/object.c b/qom/object.c
> index e25f1e96db1e..e71ce46ed576 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -15,6 +15,7 @@
>  #include "qapi/error.h"
>  #include "qom/object.h"
>  #include "qom/object_interfaces.h"
> +#include "qemu/ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/memalign.h"
>  #include "qapi/visitor.h"
> @@ -2781,6 +2782,81 @@ object_property_add_alias(Object *obj, const char *name,
>      return op;
>  }
>  
> +#define SHA384_DIGEST_SIZE      48
> +static void property_get_sha384(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t *value = (uint8_t *)opaque;
> +    char str[SHA384_DIGEST_SIZE * 2 + 1];
> +    char *str_ = (char*)str;
> +    size_t i;
> +
> +    for (i = 0; i < SHA384_DIGEST_SIZE; i++) {
> +        char *buf;
> +        buf = &str[i * 2];
> +
> +        sprintf(buf, "%02hhx", value[i]);
> +    }
> +    str[SHA384_DIGEST_SIZE * 2] = '\0';
> +
> +    visit_type_str(v, name, &str_, errp);
> +}
> +
> +static void property_set_sha384(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint8_t *value = (uint8_t *)opaque;
> +    char* str;
> +    size_t len;
> +    size_t i;
> +
> +    if (!visit_type_str(v, name, &str, errp)) {
> +        goto err;
> +    }
> +
> +    len = strlen(str);
> +    if (len != SHA384_DIGEST_SIZE * 2) {
> +        error_setg(errp, "invalid length for sha348 hex string %s. "
> +                   "it must be 48 * 2 hex", name);
> +        goto err;
> +    }
> +
> +    for (i = 0; i < SHA384_DIGEST_SIZE; i++) {
> +        if (!qemu_isxdigit(str[i * 2]) || !qemu_isxdigit(str[i * 2 + 1])) {
> +            error_setg(errp, "invalid char for sha318 hex string %s at %c%c",
> +                       name, str[i * 2], str[i * 2 + 1]);
> +            goto err;
> +        }
> +
> +        if (sscanf(str + i * 2, "%02hhx", &value[i]) != 1) {
> +            error_setg(errp, "invalid format for sha318 hex string %s", name);
> +            goto err;
> +        }
> +    }
> +
> +err:
> +    g_free(str);
> +}
> +
> +ObjectProperty *
> +object_property_add_sha384(Object *obj, const char *name,
> +                           const uint8_t *v, ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_sha384;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_sha384;
> +    }
> +
> +    return object_property_add(obj, name, "sha384",
> +                               getter, setter, NULL, (void *)v);
> +}
> +
>  void object_property_set_description(Object *obj, const char *name,
>                                       const char *description)
>  {
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


