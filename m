Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1307583DC
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 19:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLoqO-00076i-HN; Tue, 18 Jul 2023 13:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLoqL-00076F-Tf
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 13:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLoqJ-0007t9-V0
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 13:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689702634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwPT11CmzUrDiON9ylTL7vVu5g5PkgH4JRja5t4Y43o=;
 b=TV+j26STl0QjIUBI9ys2nGM1O9SCsCLMQMLuqLWGY3HiDswPApZ0jjQYVN5c8cKTedPDkc
 QQ9SPgAairJfE1UaZKHdJCrIEfYGkqYdAapPYBgi1xxKscbH4cTHXhFUr7723XW3g+0zqY
 oElmwDeL98dN1PDnkZNYJqR+i/82YQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-3xiaYSJTPJ2hDvm9MIx9Tg-1; Tue, 18 Jul 2023 13:50:31 -0400
X-MC-Unique: 3xiaYSJTPJ2hDvm9MIx9Tg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACC75101A528;
 Tue, 18 Jul 2023 17:50:30 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C40541121314;
 Tue, 18 Jul 2023 17:50:29 +0000 (UTC)
Date: Tue, 18 Jul 2023 12:50:28 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 4/5] qemu-nbd: properly report error if qemu_daemon() is
 failed
Message-ID: <l4vdyny2u3xpgn5wuhbvmqxoqdmedtvromzzvt47azflxpw3nl@46tv7ocro6cb>
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-5-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717145544.194786-5-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On Mon, Jul 17, 2023 at 04:55:43PM +0200, Denis V. Lunev wrote:
> errno has been overwritten by dup2() just below qemu_daemon() and thus
> improperly returned to the caller. Fix accordingly.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qemu-nbd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 4450cc826b..f27613cb57 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -932,9 +932,12 @@ int main(int argc, char **argv)
>              error_report("Failed to fork: %s", strerror(errno));
>              exit(EXIT_FAILURE);
>          } else if (pid == 0) {
> +            int saved_errno;
> +
>              close(stderr_fd[0]);
>  
>              ret = qemu_daemon(1, 0);
> +            saved_errno = errno;    /* dup2 will overwrite error below */

I would have written 'may', not 'will'; but that's a triviality not
worth changing.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


