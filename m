Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD334719E5F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iX2-0003HB-5l; Thu, 01 Jun 2023 09:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4iWz-0003AR-MS
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4iWy-00070c-89
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685626795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2XSKG0NXfH8gEqDVqZPiVWdlnLgeqVY4mszqnLcZAYM=;
 b=h3idZ7RwWcL8Cl86N0m6SMINHx0cWvnsiV8bcRFENis6xXP77vckiu+gYpS/uO4n3ZlcKH
 ROUQhT5Us2XK06W07D5D53zi8euk5BbP2gkj2FIJmrJ6rcxaRrCYzBzKNqiSB38YuVHw7n
 WMHyBH19CVJI2HUXHhJHQduXpKnwnXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-PNGYZ9AaM3uFrB-7SQojzg-1; Thu, 01 Jun 2023 09:39:54 -0400
X-MC-Unique: PNGYZ9AaM3uFrB-7SQojzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3620E802A55;
 Thu,  1 Jun 2023 13:39:54 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C4B58162;
 Thu,  1 Jun 2023 13:39:53 +0000 (UTC)
Date: Thu, 1 Jun 2023 08:39:51 -0500
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/4] block: complete public block status API
Message-ID: <viivep7fyc7n5poinnsznzsitjpao332shqowuculpvp5h4zuo@uw4ar43xlibw>
References: <20230601115131.196234-1-pbonzini@redhat.com>
 <20230601115131.196234-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601115131.196234-3-pbonzini@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 01:51:29PM +0200, Paolo Bonzini wrote:
> Include both coroutine and non-coroutine versions, the latter being
> co_wrapper_mixed_bdrv_rdlock of the former.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c               | 18 +++++-------------
>  include/block/block-io.h | 18 ++++++++++++------
>  2 files changed, 17 insertions(+), 19 deletions(-)

Always funny to see adding functions by reducing line count, thanks to
the wrapper generator.

> +++ b/include/block/block-io.h
> @@ -128,17 +128,23 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
>                                                    BdrvRequestFlags flags);
>  
>  bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
> -int bdrv_block_status(BlockDriverState *bs, int64_t offset,
> -                      int64_t bytes, int64_t *pnum, int64_t *map,
> -                      BlockDriverState **file);
> +
> +int coroutine_fn GRAPH_RDLOCK
> +bdrv_co_block_status(BlockDriverState *bs, int64_t offset,
> +                     int64_t bytes, int64_t *pnum,
> +                     int64_t *map, BlockDriverState **file);

Given that you line-wrapped this one at the function name,

> +int co_wrapper_mixed_bdrv_rdlock bdrv_block_status(BlockDriverState *bs, int64_t offset,
> +                                                   int64_t bytes, int64_t *pnum,
> +                                                   int64_t *map, BlockDriverState **file);

shouldn't you do likewise here?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


