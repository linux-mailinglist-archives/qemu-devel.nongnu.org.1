Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D03E475B525
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:02:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMX24-0001cv-Ok; Thu, 20 Jul 2023 13:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMX20-0001cb-J2
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMX1u-000613-EH
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689872487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCeioRL7CtT7Uki18AKHzjN2rsoSE83JqlP1xySD7Qg=;
 b=ixkfOA9TnthHqX37oLW4MYkpZvEF7II4Q42zsKJcyQ5vmWxSH+ksE1o7unQtuq5YTsha0t
 PTlnuP/732xRh/s+LniNfBLMKt6J6GBUdLWVVzWbnDPeAuGtfvBphBDGc0ml6+Gw7tkcoo
 S0ZuqcRfA9RSMhqi6Du9ZijbG0hyMoY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-v7KKZ8ukNfSFiew6wefdfA-1; Thu, 20 Jul 2023 13:01:23 -0400
X-MC-Unique: v7KKZ8ukNfSFiew6wefdfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AC613C0E206;
 Thu, 20 Jul 2023 17:01:23 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D7CF2166B25;
 Thu, 20 Jul 2023 17:01:22 +0000 (UTC)
Date: Thu, 20 Jul 2023 12:01:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] block: Be more verbose in create fallback
Message-ID: <aq2akzsoub74l3h7lwwhvdjqjabqanbwtmqceyt2bgjvxdp72t@366jljylr4wn>
References: <20230720140024.46836-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720140024.46836-1-hreitz@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Thu, Jul 20, 2023 at 04:00:24PM +0200, Hanna Czenczek wrote:
> For image creation code, we have central fallback code for protocols
> that do not support creating new images (like NBD or iscsi).  So for
> them, you can only specify existing paths/exports that are overwritten
> to make clean new images.  In such a case, if the given path cannot be
> opened (assuming a pre-existing image there), we print an error message
> that tries to describe what is going on: That with this protocol, you
> cannot create new images, but only overwrite existing ones; and the
> given path could not be opened as a pre-existing image.
> 
> However, the current message is confusing, because it does not say that
> the protocol in question does not support creating new images, but
> instead that "image creation" is unsupported.  This can be interpreted
> to mean that `qemu-img create` will not work in principle, which is not
> true.  Be more verbose for clarity.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2217204
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Definitely more vebose, but I don't see that as a bad thing.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block.c b/block.c
> index a307c151a8..f530dd9c02 100644
> --- a/block.c
> +++ b/block.c
> @@ -661,8 +661,10 @@ int coroutine_fn bdrv_co_create_opts_simple(BlockDriver *drv,
>      blk = blk_co_new_open(filename, NULL, options,
>                            BDRV_O_RDWR | BDRV_O_RESIZE, errp);
>      if (!blk) {
> -        error_prepend(errp, "Protocol driver '%s' does not support image "
> -                      "creation, and opening the image failed: ",
> +        error_prepend(errp, "Protocol driver '%s' does not support creating "
> +                      "new images, so an existing image must be selected as "
> +                      "the target; however, opening the given target as an "
> +                      "existing image failed: ",
>                        drv->format_name);
>          return -EINVAL;
>      }
> -- 
> 2.41.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


