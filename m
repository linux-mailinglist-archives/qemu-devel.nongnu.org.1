Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 286537F7562
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:40:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6WPC-0002no-1i; Fri, 24 Nov 2023 08:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r6WP5-0002mW-EX
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r6WP3-0004uo-TN
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700833168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dkZClAqqnY9P0dzfCFivKmZkeyy9X51kCbvCj1hdYg=;
 b=iLY8oKmx2mZ5ISTkcxaBPl3vfglQegHGfatkx1+ror6vg84TwxAA7nzLWaZlMoaBPXV+0p
 lPlgrJqQ6NUXuuSARNbYCe5IgsK0GYFy7FYGwIHDzgfV1IXbSwtkReY7EdwgNjaDNj8q2K
 RtyeStTZHnBwyLvOTUYeWGIIeKcaW3I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-v-sRW0KkOumPx9srAnMjGw-1; Fri,
 24 Nov 2023 08:39:26 -0500
X-MC-Unique: v-sRW0KkOumPx9srAnMjGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 414973C10158;
 Fri, 24 Nov 2023 13:39:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 098D640C6EB9;
 Fri, 24 Nov 2023 13:39:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02D6221E6A1F; Fri, 24 Nov 2023 14:39:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Hoffman <dhoff749@gmail.com>,  qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH] hw/core: define stack variable to NULL to fix qtest
 with sanitizers
References: <20231124015312.544422-1-dhoff749@gmail.com>
 <93f7ee3e-a92f-4b18-bf16-2169c8b2791d@linaro.org>
Date: Fri, 24 Nov 2023 14:39:24 +0100
In-Reply-To: <93f7ee3e-a92f-4b18-bf16-2169c8b2791d@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 24 Nov 2023 11:07:06
 +0100")
Message-ID: <87sf4vgtir.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> (Cc'ing QAPI maintainer)
>
> On 24/11/23 02:53, Daniel Hoffman wrote:
>> This was the only failure preventing `make check` from passing with sani=
tizers
>> enabled on my configuration.
>
> IIUC this is due to visit_start_list() which expects a NULL list,
> see qapi/qapi-visit-core.c:
>
> bool visit_start_list(Visitor *v, const char *name, GenericList **list,
>                       size_t size, Error **errp)
> {
>     bool ok;
>
>     assert(!list || size >=3D sizeof(GenericList));

This asserts either "if real walk, then size is sane".

>
> which is well defined in its declaration:
>
> /*
>  * Start visiting a list.
>  *
>  * @name expresses the relationship of this list to its parent
>  * container; see the general description of @name above.
>  *
>  * @list must be non-NULL for a real walk, in which case @size
>  * determines how much memory an input or clone visitor will allocate
>  * into *@list (at least sizeof(GenericList)).  Some visitors also
>  * allow @list to be NULL for a virtual walk, in which case @size is
>  * ignored.
>  ...

Mind the number of *!

The function contract talks about @list, which is GenericList **.

get_prop_array() passes &list, where list is GenericList *.  &list is
non-null even before the patch.

The patch initializes @list to empty.

> With the patch description improved:

Specifically, show how things fail under sanitation.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>> Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
>> ---
>>   hw/core/qdev-properties.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 91632f7be9f..4caa78b7bc5 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -690,7 +690,7 @@ static void get_prop_array(Object *obj, Visitor *v, =
const char *name,
>>      uint32_t *alenptr =3D object_field_prop_ptr(obj, prop);
>>      void **arrayptr =3D (void *)obj + prop->arrayoffset;
>>      char *elem =3D *arrayptr;
>> -    GenericList *list;
>> +    GenericList *list =3D NULL;
>>      const size_t list_elem_size =3D sizeof(*list) + prop->arrayfieldsiz=
e;
>>      int i;
>>      bool ok;

        if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
            return;
        }


