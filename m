Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A9B7DA222
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 23:02:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwTwM-0006ao-0W; Fri, 27 Oct 2023 17:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwTwK-0006aQ-7P
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwTwI-0006Pp-KF
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698440417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t9NBTPDfEm/RR4215rNQey8ZsgZoA1wxnLkhdy3Cg8k=;
 b=STgBXitv9+ikOuK6i/NSrEgzx2ItglXMRAsQOM5m2FGkRw4A/seC6/eR2nSgGd1MmEdhJU
 fKC7WDKI5D6T74uQGSHZ/fVYGtkCLYgvB7RssQGf6xxI+b2oF8YP3bIeP8D0wFgbwZXdbG
 b1zkoJ9qOY63mkllEqhDyiuXiHpC67s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-DMZVIGxlOj-AVaBVtLydHQ-1; Fri, 27 Oct 2023 17:00:13 -0400
X-MC-Unique: DMZVIGxlOj-AVaBVtLydHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CE6B801944;
 Fri, 27 Oct 2023 21:00:13 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC12B2026D4C;
 Fri, 27 Oct 2023 21:00:11 +0000 (UTC)
Date: Fri, 27 Oct 2023 16:00:10 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 09/24] block: Mark bdrv_(un)freeze_backing_chain() and
 callers GRAPH_RDLOCK
Message-ID: <eqtsucwg72w4lstprikpxve4oocw6od5zywsxth74zfrwszb6i@rxmwm5zu56mq>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-10-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 27, 2023 at 05:53:18PM +0200, Kevin Wolf wrote:
> This adds GRAPH_RDLOCK annotations to declare that callers of
> bdrv_(un)freeze_backing_chain() need to hold a reader lock for the
> graph because it calls bdrv_filter_or_cow_child(), which accesses
> bs->file/backing.
> 
> Use the opportunity to make bdrv_is_backing_chain_frozen() static, it
> has no external callers.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/copy-on-read.h               |  3 ++-
>  include/block/block-global-state.h | 11 ++++++-----
>  block.c                            |  5 +++--
>  block/commit.c                     |  6 ++++++
>  block/copy-on-read.c               | 19 +++++++++++++++----
>  block/mirror.c                     |  3 +++
>  block/stream.c                     | 16 +++++++++++-----
>  7 files changed, 46 insertions(+), 17 deletions(-)
>
...
> +++ b/block/copy-on-read.c
...
> -static void cor_close(BlockDriverState *bs)
> +static void GRAPH_UNLOCKED cor_close(BlockDriverState *bs)
>  {
>      BDRVStateCOR *s = bs->opaque;
>  
> +    GLOBAL_STATE_CODE();
> +
>      if (s->chain_frozen) {
> +        bdrv_graph_rdlock_main_loop();
>          s->chain_frozen = false;
>          bdrv_unfreeze_backing_chain(bs, s->bottom_bs);
> +        bdrv_graph_rdunlock_main_loop();

Why the two-line addition here...

>      }
>  
>      bdrv_unref(s->bottom_bs);
> @@ -263,12 +271,15 @@ static BlockDriver bdrv_copy_on_read = {
>  };
>  
>  
> -void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs)
> +void no_coroutine_fn bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs)
>  {
>      BDRVStateCOR *s = cor_filter_bs->opaque;
>  
> +    GLOBAL_STATE_CODE();
> +
>      /* unfreeze, as otherwise bdrv_replace_node() will fail */
>      if (s->chain_frozen) {
> +        GRAPH_RDLOCK_GUARD_MAINLOOP();
>          s->chain_frozen = false;
>          bdrv_unfreeze_backing_chain(cor_filter_bs, s->bottom_bs);
>      }

...vs. the magic one-line per-scope change here?  Both work, so I
don't see any problems, but it does seem odd to mix styles in the same
patch.  (I can see other places where you have intentionally picked
the version that required the least reindenting; adding a scope just
to use GRAPH_RDLOCK_GUARD_MAINLOOP() without having to carefully pair
an unlock on every early exit path is fewer lines of code overall, but
more lines of churn in the patch itself.)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


