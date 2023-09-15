Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2597A1805
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 10:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3uK-0004pZ-9m; Fri, 15 Sep 2023 04:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh3u7-0004W5-E7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh3u4-00073a-5p
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694765414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OQOzGTH+QcJO4xCc8kvvszHjY7AgCE+/6nxQstlUISE=;
 b=fn9wwaVA9kzIeiODELTRdxns0y5Xj7KhXdRBTeCKPo6NKzYKrpYsQr/8ADUbkuo0U1h0Sl
 7goJJAIBQN0FFc3J1KYZ1wF42diAGjoSWOtX5vPCI2BWxRH1iLEpYN2HGhWVfgcvkxsBvZ
 S6hL4CwvaxWvB9477Ea+OWTd0fRzZ7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-AH_e6IbZMfefIIrXyISEjA-1; Fri, 15 Sep 2023 04:10:11 -0400
X-MC-Unique: AH_e6IbZMfefIIrXyISEjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89A2C85A5BD;
 Fri, 15 Sep 2023 08:10:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D770A40C6EA8;
 Fri, 15 Sep 2023 08:10:06 +0000 (UTC)
Date: Fri, 15 Sep 2023 10:10:05 +0200
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
Subject: Re: [PATCH 6/7] block: Clean up local variable shadowing
Message-ID: <ZQQRXR7LP2fVrcMU@redhat.com>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831132546.3525721-7-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 31.08.2023 um 15:25 hat Markus Armbruster geschrieben:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Tracked down with -Wshadow=local.
> Clean up: delete inner declarations when they are actually redundant,
> else rename variables.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block.c              |  7 ++++---
>  block/rbd.c          |  2 +-
>  block/stream.c       |  1 -
>  block/vvfat.c        | 34 +++++++++++++++++-----------------
>  hw/block/xen-block.c |  6 +++---
>  5 files changed, 25 insertions(+), 25 deletions(-)

I wonder why you made vdi a separate patch, but not vvfat, even though
that has more changes. (Of course, my selfish motivation for asking this
is that I could have given a R-b for it and wouldn't have to look at it
again in a v2 :-))

> diff --git a/block.c b/block.c
> index a307c151a8..7f0003d8ac 100644
> --- a/block.c
> +++ b/block.c
> @@ -3001,7 +3001,8 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
>                                             BdrvChildRole child_role,
>                                             uint64_t perm, uint64_t shared_perm,
>                                             void *opaque,
> -                                           Transaction *tran, Error **errp)
> +                                           Transaction *transaction,
> +                                           Error **errp)
>  {
>      BdrvChild *new_child;
>      AioContext *parent_ctx, *new_child_ctx;
> @@ -3088,7 +3089,7 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
>          .old_parent_ctx = parent_ctx,
>          .old_child_ctx = child_ctx,
>      };
> -    tran_add(tran, &bdrv_attach_child_common_drv, s);
> +    tran_add(transaction, &bdrv_attach_child_common_drv, s);
>  
>      if (new_child_ctx != child_ctx) {
>          aio_context_release(new_child_ctx);

I think I would resolve this one the other way around. 'tran' is the
typical name for the parameter and it is the transaction that this
function should add things to.

The other one that shadows it is a local transaction that is completed
within the function. I think it's better if that one has a different
name.

As usual, being more specific than just 'tran' vs. 'transaction' would
be nice. Maybe 'aio_ctx_tran' for the nested one?

The rest looks okay.

Kevin


