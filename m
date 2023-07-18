Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E7A7583CE
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 19:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLolm-0005xf-QA; Tue, 18 Jul 2023 13:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLolb-0005qT-NU
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 13:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLolY-0005tF-Ho
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 13:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689702338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGtJA6JLQsBwarJzfkotuySobzXPpOLwOUG+u5ge+QM=;
 b=Zdul9klTZvwsa5nxdCjqXUwxJYbHmCjFlYT0/jKGru0IZgmVAjipVAPv6aa+WLVDjUFeLA
 h7+3yENMvf4FttaWDuzotRgt8LGx6NkjVmekOeapJH5KT2ZtxAX2Ujm1ILJO0m+52tqT+Q
 7teXYCHLTqXVcwvm3ON0tMhtXQzqDMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-eK2qiFllOqKci7rMxw4hZw-1; Tue, 18 Jul 2023 13:45:37 -0400
X-MC-Unique: eK2qiFllOqKci7rMxw4hZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C03D41044592;
 Tue, 18 Jul 2023 17:45:36 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23C21F66D0;
 Tue, 18 Jul 2023 17:45:35 +0000 (UTC)
Date: Tue, 18 Jul 2023 12:45:34 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 3/5] qemu-nbd: properly report error on error in dup2()
 after qemu_daemon()
Message-ID: <pkdgj4m5ym6sgql546sy6uq4jea3o5wcwbsbwpu3mmhf6um5jf@nid5h3seqq5v>
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-4-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717145544.194786-4-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 17, 2023 at 04:55:42PM +0200, Denis V. Lunev wrote:
> We are trying to temporary redirect stderr of daemonized process to

temporarily

> a pipe to report a error and get failed. In that case we could not
> use error_report() helper, but should write the message directly into
> the problematic pipe.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qemu-nbd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 186ce9474c..4450cc826b 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -937,7 +937,20 @@ int main(int argc, char **argv)
>              ret = qemu_daemon(1, 0);
>

errno from qemu_daemon...

>              /* Temporarily redirect stderr to the parent's pipe...  */
> -            dup2(stderr_fd[1], STDERR_FILENO);
> +            if (dup2(stderr_fd[1], STDERR_FILENO) < 0) {

...is still potentially lost here...

> +                char str[256];
> +                snprintf(str, sizeof(str),
> +                         "%s: Failed to link stderr to the pipe: %s\n",
> +                         g_get_prgname(), strerror(errno));
> +                /*
> +                 * We are unable to use error_report() here as we need to get
> +                 * stderr pointed to the parent's pipe. Write to that pipe
> +                 * manually.
> +                 */
> +                ret = write(stderr_fd[1], str, strlen(str));
> +                exit(EXIT_FAILURE);
> +            }
> +
>              if (ret < 0) {
>                  error_report("Failed to daemonize: %s", strerror(errno));

...before use here.

Patch 4/5 addresses that, but I'm inclined to just swap the order of
the two patches when applying the series in my NBD tree.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


