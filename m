Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B247DA197
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 22:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwT2r-0000qV-Hq; Fri, 27 Oct 2023 16:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwT2p-0000p8-Hv
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 16:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwT2k-0002jD-Pi
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 16:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698436972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D2q79LFI18JRLZJx3bFrZeHmQbVtdVW3qMMTMDnHckA=;
 b=Yh0aim8dfbgrIHbBU/lYovd/7PQk812uHpYV/vLexwOgJvfzbbnjKL1oReMG0HdUyzvIFB
 g/Fb8Pi/SnS4VgfUZSYjs0q/bAxfYQDONkbIVqyiU+usXiNEd0ttf4iHORYe2R8LXLLOiT
 PjlzdcGQqk4IjiBXGRqQblwWqtumqIk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-4eII3BDRPKKi8k7jJw4ERQ-1; Fri,
 27 Oct 2023 16:02:41 -0400
X-MC-Unique: 4eII3BDRPKKi8k7jJw4ERQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DC6D2808FEC;
 Fri, 27 Oct 2023 20:02:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07D832166B26;
 Fri, 27 Oct 2023 20:02:39 +0000 (UTC)
Date: Fri, 27 Oct 2023 15:02:38 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 03/24] block: Mark bdrv_filter_bs() and callers
 GRAPH_RDLOCK
Message-ID: <2foevtju4p7tzm3eqxlah3lomkqkqfgn6ci6h5tqmzipxluggq@cax77z2jaybs>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-4-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 27, 2023 at 05:53:12PM +0200, Kevin Wolf wrote:
> This adds GRAPH_RDLOCK annotations to declare that callers of
> bdrv_filter_bs() need to hold a reader lock for the graph because
> it calls bdrv_filter_child(), which accesses bs->file/backing.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-io.h       | 2 +-
>  include/block/block_int-io.h   | 3 ++-
>  block.c                        | 9 +++++++--
>  block/stream.c                 | 2 ++
>  migration/block-dirty-bitmap.c | 4 ++++
>  5 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index ad270b6ad2..58c4cf50a0 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -183,7 +183,7 @@ bdrv_co_eject(BlockDriverState *bs, bool eject_flag);
>  
>  const char *bdrv_get_format_name(BlockDriverState *bs);
>  
> -bool bdrv_supports_compressed_writes(BlockDriverState *bs);
> +bool GRAPH_RDLOCK bdrv_supports_compressed_writes(BlockDriverState *bs);

Unrelated change that belongs elsewhere in the series?

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


