Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F1280E42E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 07:13:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCw08-0001zm-2y; Tue, 12 Dec 2023 01:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rCw04-0001zY-HL
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 01:12:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rCw02-0003B6-Lj
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 01:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702361529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n7ZfHi2eNFq/haYA4z4IGXdzsRJRpUkSp7C2bPpTItc=;
 b=WnPBQe2FFShihkwYYtPJJByizfi51ucJO6aaBTRq8D44B7/PMEX5J55DXDQRJTR3zzXMDG
 mkObtxhYQYEMmr1Edm0loCbKxr4dNTxwoj8RcTONBG0/YpOQ+U0obFxzhrZtb7Kxg7L5B+
 4DFzXQ+4k3qPOJTgi+WW0AuCg/NgXZU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-nDnsO7gMM4mOqkhz0OIBOQ-1; Tue,
 12 Dec 2023 01:12:05 -0500
X-MC-Unique: nDnsO7gMM4mOqkhz0OIBOQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E96A2823F6E;
 Tue, 12 Dec 2023 06:12:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35F92492BC6;
 Tue, 12 Dec 2023 06:12:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C3F921E6812; Tue, 12 Dec 2023 07:12:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  Michael Roth
 <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC] string-output-visitor: show structs as "<omitted>"
In-Reply-To: <20231211195734.425040-1-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Mon, 11 Dec 2023 14:57:34 -0500")
References: <20231211195734.425040-1-stefanha@redhat.com>
Date: Tue, 12 Dec 2023 07:12:04 +0100
Message-ID: <87zfyg54qz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> StringOutputVisitor crashes when it visits a struct because
> ->start_struct() is NULL.
>
> Show "<omitted>" instead of crashing. This is necessary because the
> virtio-blk-pci iothread-vq-mapping parameter that I'd like to introduce
> soon is a list of IOThreadMapping structs.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Can we do better?
>
> I am unfamiliar with StringOutputVisitor, so I wasn't sure how to
> proceed. Is the format or at least the intended use of
> StringOutputVisitor's output defined somewhere?

Bwuahahahaha!

SCNR

>                                                 Does it need to be a
> single line or can the output be multiple lines?

I'm afraid we need to review its users to be sure.

> Or maybe I shouldn't introduce a qdev property with IOThreadMappingList
> as its type in
> https://lore.kernel.org/qemu-devel/ZUoPiFxIIwFq5wMg@redhat.com/?

QOM initially supported only scalar properties.

I think maintaining this restriction will lead to awkward interfaces.
Lists are clearly useful.  And then we'll likely want list of struct,
not multiple lists.

Lifting the restriction will take some work.

On the string visitors, see also my musings in

    Subject: Re: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property type 
    Date: Mon, 11 Dec 2023 16:32:06 +0100
    Message-ID: <87msugah6x.fsf@pond.sub.org>

> ---
>  include/qapi/string-output-visitor.h |  6 +++---
>  qapi/string-output-visitor.c         | 14 ++++++++++++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/include/qapi/string-output-visitor.h b/include/qapi/string-output-visitor.h
> index 268dfe9986..762fe3f705 100644
> --- a/include/qapi/string-output-visitor.h
> +++ b/include/qapi/string-output-visitor.h
> @@ -26,9 +26,9 @@ typedef struct StringOutputVisitor StringOutputVisitor;
>   * If everything else succeeds, pass @result to visit_complete() to
>   * collect the result of the visit.
>   *
> - * The string output visitor does not implement support for visiting
> - * QAPI structs, alternates, null, or arbitrary QTypes.  It also
> - * requires a non-null list argument to visit_start_list().
> + * The string output visitor does not implement support for alternates, null,
> + * or arbitrary QTypes.  It also requires a non-null list argument to
> + * visit_start_list().

Mention output for structs is information-free?

>   */
>  Visitor *string_output_visitor_new(bool human, char **result);
>  
> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index c0cb72dbe4..363dac00fe 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -292,6 +292,18 @@ static bool print_type_null(Visitor *v, const char *name, QNull **obj,
>      return true;
>  }
>  
> +static bool start_struct(Visitor *v, const char *name, void **obj,
> +                         size_t size, Error **errp)
> +{
> +    return true;
> +}
> +
> +static void end_struct(Visitor *v, void **obj)
> +{
> +    StringOutputVisitor *sov = to_sov(v);
> +    string_output_set(sov, g_strdup("<omitted>"));

TODO comment?

> +}
> +
>  static bool
>  start_list(Visitor *v, const char *name, GenericList **list, size_t size,
>             Error **errp)
> @@ -379,6 +391,8 @@ Visitor *string_output_visitor_new(bool human, char **result)
>      v->visitor.type_str = print_type_str;
>      v->visitor.type_number = print_type_number;
>      v->visitor.type_null = print_type_null;
> +    v->visitor.start_struct = start_struct;
> +    v->visitor.end_struct = end_struct;
>      v->visitor.start_list = start_list;
>      v->visitor.next_list = next_list;
>      v->visitor.end_list = end_list;


