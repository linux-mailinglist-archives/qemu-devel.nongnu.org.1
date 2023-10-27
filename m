Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CBA7DA215
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 22:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwTop-0005EP-In; Fri, 27 Oct 2023 16:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwTon-0005Ds-Gs
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 16:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwTol-00051Y-W7
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 16:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698439950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9bjimocBZOwQb9cAeyLHKLj3DNsGVeTikLVS/H/e1w=;
 b=FrgA13JabgsdGULUK6fYaqii58Z3TFbyYwNuSVFz9MHz3ahLpCeYPoJYviBIl1lEHXUv6l
 AVcYRVyCv6UEfgoC9SdPKDqxqx+diTWE2/3aDh/0nEN6LcB13TQgbHXGgWidfE6BayOEXu
 v+pSDifap1ZLQkT/3p8Dolu28x7OGNQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-CEG-kVemMXSjqiB2Iu3vuw-1; Fri, 27 Oct 2023 16:52:19 -0400
X-MC-Unique: CEG-kVemMXSjqiB2Iu3vuw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3744836F80;
 Fri, 27 Oct 2023 20:52:18 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 990BD492BE0;
 Fri, 27 Oct 2023 20:52:17 +0000 (UTC)
Date: Fri, 27 Oct 2023 15:52:15 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 08/24] block: Mark bdrv_skip_filters() and callers
 GRAPH_RDLOCK
Message-ID: <ouwiakzbahrjbgtvffpe3e4r3bp6msfepjef7gxvv6ac6hh34t@p2w5mo2k55y5>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-9-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Fri, Oct 27, 2023 at 05:53:17PM +0200, Kevin Wolf wrote:
> This adds GRAPH_RDLOCK annotations to declare that callers of
> bdrv_skip_filters() need to hold a reader lock for the graph because it
> calls bdrv_filter_child(), which accesses bs->file/backing.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-global-state.h |  8 ++++---
>  include/block/block_int-io.h       |  4 ++--
>  block/block-backend.c              |  1 +
>  block/block-copy.c                 |  9 +++++++-
>  block/commit.c                     |  5 ++++-
>  block/mirror.c                     | 34 +++++++++++++++++++++---------
>  block/stream.c                     | 22 ++++++++++++-------
>  blockdev.c                         |  7 +++---
>  qemu-img.c                         | 18 +++++++++++++---
>  9 files changed, 77 insertions(+), 31 deletions(-)
> 
> diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
> index 3ae468ea15..b6860ae43b 100644
> --- a/include/block/block-global-state.h
> +++ b/include/block/block-global-state.h
> @@ -144,9 +144,11 @@ int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
>  void bdrv_register(BlockDriver *bdrv);
>  int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
>                             const char *backing_file_str);
> -BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
> -                                    BlockDriverState *bs);
> -BlockDriverState *bdrv_find_base(BlockDriverState *bs);
> +
> +BlockDriverState * GRAPH_RDLOCK
> +bdrv_find_overlay(BlockDriverState *active, BlockDriverState *bs);
> +
> +BlockDriverState * GRAPH_RDLOCK bdrv_find_base(BlockDriverState *bs);

Similar story to 3/24 earlier in the series - these are callers of
bdrv_skip_filters(), which in turn have callers that are already
locked, or which are touched to lock in this patch.  May be worth
tweaking the commit message to mention them by name.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


