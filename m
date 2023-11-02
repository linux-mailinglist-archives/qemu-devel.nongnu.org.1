Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E858C7DF2F2
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 13:55:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXEF-0008TW-Fq; Thu, 02 Nov 2023 08:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyXED-0008TM-On
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyXEC-0004VC-3C
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698929714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T27ci5dy2yMenANfKcch/+MKEHx9/idiPAu6S9vCCFA=;
 b=LuEgluy2LPtE+yuRr5nI1H1X9C6RU6S9boEIjn5KoiBho+mUvZw76rlqSuAZUdOt0YI59z
 2RV5AR92JHn0DvLMoE3HQ7b/Z/bdpBkT5f2OqF9wXvSezzXnKObqYS35M4kCbuCAk9GHk+
 VwAnOdgXTqhphC+GFvAPXA9ENgfVjb4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-yNmR8IJjOv6TWxDHHC7Sog-1; Thu, 02 Nov 2023 08:55:10 -0400
X-MC-Unique: yNmR8IJjOv6TWxDHHC7Sog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C7B0811E8E;
 Thu,  2 Nov 2023 12:55:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 586B21121308;
 Thu,  2 Nov 2023 12:55:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C40D21E6A1F; Thu,  2 Nov 2023 13:55:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  peter.maydell@linaro.org,
 pbonzini@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v2 11/12] qdev: Make netdev properties work as list
 elements
References: <20231030142658.182193-1-kwolf@redhat.com>
 <20231030142658.182193-12-kwolf@redhat.com>
Date: Thu, 02 Nov 2023 13:55:09 +0100
In-Reply-To: <20231030142658.182193-12-kwolf@redhat.com> (Kevin Wolf's message
 of "Mon, 30 Oct 2023 15:26:57 +0100")
Message-ID: <87jzr09uxe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

Kevin Wolf <kwolf@redhat.com> writes:

> The 'name' parameter of QOM setters is primarily used to specify the name
> of the currently parsed input element in the visitor interface. For
> top-level qdev properties, this is always set and matches 'prop->name'.
>
> However, for list elements it is NULL, because each element of a list
> doesn't have a separate name. Passing a non-NULL value runs into
> assertion failures in the visitor code.

Yes.  visitor.h's big comment:

 * The @name parameter of visit_type_FOO() describes the relation
 * between this QAPI value and its parent container.  When visiting
 * the root of a tree, @name is ignored; when visiting a member of an
 * object, @name is the key associated with the value; when visiting a
 * member of a list, @name is NULL; and when visiting the member of an
 * alternate, @name should equal the name used for visiting the
 * alternate.

> Therefore, using 'name' in error messages is not right for property
> types that are used in lists, because "(null)" isn't very helpful to
> identify what QEMU is complaining about.

We get "(null)" on some hosts, and SEGV on others.

Same problem in all property setters and getters (qdev and QOM), I
presume.  The @name parameter looks like a death trap.  Thoughts?

Any reproducer known before the next patch?

> Change netdev properties to use 'prop->name' instead, which will contain
> the name of the array property after switching array properties to lists
> in the external interface.

Points at the entire array property without telling the user which of
the elements is at fault.  Sure better than NULL.  I'm not asking you to
improve the error message further.  Mention the error message's lack of
precision in the commit message?

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/core/qdev-properties-system.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 7c6dfab128..bf243d72d6 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -450,7 +450,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
>      peers_ptr->queues = queues;
>  
>  out:
> -    error_set_from_qdev_prop_error(errp, err, obj, name, str);
> +    error_set_from_qdev_prop_error(errp, err, obj, prop->name, str);
>      g_free(str);
>  }


