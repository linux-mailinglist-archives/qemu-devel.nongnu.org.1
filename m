Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9176C9D4DA5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Nov 2024 14:21:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE77I-0005S9-3s; Thu, 21 Nov 2024 08:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tE77A-0005OD-GI
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tE778-0006Gb-6K
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732195251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MMcKkARuGM4ThQjAP+kS86raNF64P+1uxKV6dxbbb4U=;
 b=TFqaXrKVFNEq3ttXX566NX0ns2Hf27KREoo616bvAVc3qD4pv9sQk/yZLYrVKV5Dln1qTi
 zrNsZIJLFXUSpafiDzdL89dmq/mWalxRZoqXv/AlO1HG1/MTM57plVg3s11gzZ9WODN/bD
 9XgeWj6mdAJ6iSxzX5pFQFi/33S1jzE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-vjXZuvvZNoG407-00s_i0w-1; Thu,
 21 Nov 2024 08:20:48 -0500
X-MC-Unique: vjXZuvvZNoG407-00s_i0w-1
X-Mimecast-MFC-AGG-ID: vjXZuvvZNoG407-00s_i0w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 354491954B02; Thu, 21 Nov 2024 13:20:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB9EE1955F3E; Thu, 21 Nov 2024 13:20:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7EE8521E6A28; Thu, 21 Nov 2024 14:20:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Juraj Marcin <jmarcin@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?C=C3=A9dri?=
 =?utf-8?Q?c?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 02/12] qom: New container_create()
In-Reply-To: <20241120215703.3918445-3-peterx@redhat.com> (Peter Xu's message
 of "Wed, 20 Nov 2024 16:56:53 -0500")
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-3-peterx@redhat.com>
Date: Thu, 21 Nov 2024 14:20:44 +0100
Message-ID: <87ttc0iuz7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> To move towards explicit creations of containers, starting that by
> providing a helper for creating container objects.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qom/object.h | 12 ++++++++++++
>  qom/container.c      | 18 +++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 3ba370ce9b..41ef53241e 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2033,6 +2033,18 @@ int object_child_foreach_recursive(Object *obj,
>   */
>  Object *container_get(Object *root, const char *path);
>  
> +
> +/**
> + * container_create:
> + * @root: root of the object to create the new container
> + * @name: name of the new container

Is this the name of the property of @root to hold the new container?
Peeking ahead to the implementation... yes.

> + *
> + * Create a container object under @root with @name.
> + *
> + * Returns: the newly created container object.
> + */
> +Object *container_create(Object *root, const char *name);

No function in this file is named like FOO_create().  Hmm.

Compare:

   /**
    * object_property_try_add_child:
    * @obj: the object to add a property to
    * @name: the name of the property
    * @child: the child object
    * @errp: pointer to error object
    *
    * Child properties form the composition tree.  All objects need to be a child
    * of another object.  Objects can only be a child of one object.
    *
    * There is no way for a child to determine what its parent is.  It is not
    * a bidirectional relationship.  This is by design.

Aside: this is nonsense.  While you're not supposed to simply use
obj->parent (it's documented as private), you can still get the child's
canonical path with object_get_canonical_path(), split off its last
component to get the parent's canonical path, then use
object_resolve_path() to get the parent.

    *
    * The value of a child property as a C string will be the child object's
    * canonical path. It can be retrieved using object_property_get_str().
    * The child object itself can be retrieved using object_property_get_link().
    *
    * Returns: The newly added property on success, or %NULL on failure.
    */

What about

   /**
    * object_property_add_new_container:
    * @obj: the parent object
    * @name: the name of the parent object's property to add
    *
    * Add a newly created container object to a parent object.
    *
    * Returns: the newly created container object.  Its reference count
    * is 1, and the reference is owned by the parent object.
    */

> +
>  /**
>   * object_property_help:
>   * @name: the name of the property
> diff --git a/qom/container.c b/qom/container.c
> index cfec92a944..da657754a4 100644
> --- a/qom/container.c
> +++ b/qom/container.c
> @@ -24,6 +24,20 @@ static void container_register_types(void)
>      type_register_static(&container_info);
>  }
>  
> +Object *container_create(Object *obj, const char *name)
> +{
> +    Object *child = object_new(TYPE_CONTAINER);
> +
> +    object_property_add_child(obj, name, child);
> +    /*
> +     * Simplify the caller by always drop the refcount directly here, as
> +     * containers are normally never destroyed after created anyway.
> +     */
> +    object_unref(child);

Do we still need the comment if we document the reference count in the
function comment?

> +
> +    return child;
> +}
> +
>  Object *container_get(Object *root, const char *path)
>  {
>      Object *obj, *child;
> @@ -37,9 +51,7 @@ Object *container_get(Object *root, const char *path)
>      for (i = 1; parts[i] != NULL; i++, obj = child) {
>          child = object_resolve_path_component(obj, parts[i]);
>          if (!child) {
> -            child = object_new(TYPE_CONTAINER);
> -            object_property_add_child(obj, parts[i], child);
> -            object_unref(child);
> +            child = container_create(obj, parts[i]);
>          }
>      }


