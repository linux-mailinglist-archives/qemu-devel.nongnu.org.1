Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED67DA271
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 23:28:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwUMh-0006Lb-TZ; Fri, 27 Oct 2023 17:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwUMR-0006L3-Mt
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwUMQ-0003YV-06
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698442037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PlfHt3FKEre+q6tp2RjgChyKw48vq0KppmXyZiSeW4c=;
 b=LwTLxDprwDsXXdWRwHwWCIR8pvY4bytCQBHbKjI2EeUvLDDxJRlz+rBuXOel+JLSO/SKyn
 vN6odmD771nGTLljWfhEEF//fT+nytCXrigr3NZPb739rh9bv7qzlk+5AdF4EXUzxgwOwH
 4lxLhGNDqjIfgWKjcKxyMzCoFUIwbAY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-7YHNyWJvNbeA0C56P93GMw-1; Fri, 27 Oct 2023 17:27:14 -0400
X-MC-Unique: 7YHNyWJvNbeA0C56P93GMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8EE2881D31;
 Fri, 27 Oct 2023 21:27:13 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8C7C1121314;
 Fri, 27 Oct 2023 21:27:12 +0000 (UTC)
Date: Fri, 27 Oct 2023 16:27:11 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 15/24] block: Mark bdrv_replace_node_common() GRAPH_WRLOCK
Message-ID: <bc7yoivnsdkh6db3kjumor6uenvr2fveg2xa5dtpgei66ghrdd@ldtwmc5qpa6q>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-16-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-16-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Fri, Oct 27, 2023 at 05:53:24PM +0200, Kevin Wolf wrote:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_replace_node_common(). Basically everthing in
> the function needs the lock and its callers may already want to hold the
> graph lock and so wouldn't be able to call functions that take it
> internally.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 68 ++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 25 deletions(-)
> 
> diff --git a/block.c b/block.c
> index dc43e36f69..c7409cf658 100644
> --- a/block.c
> +++ b/block.c
> @@ -5412,6 +5412,9 @@ bdrv_replace_node_noperm(BlockDriverState *from,
>  }
>  
>  /*
> + * Switch all parents of @from to point to @to instead. @from and @to must be in
> + * the same AioContext and both must be drained.
> + *
>   * With auto_skip=true bdrv_replace_node_common skips updating from parents
>   * if it creates a parent-child relation loop or if parent is block-job.

Useful doc addition, even though the commit message doesn't mention
it.  I see no problem with keeping it.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


