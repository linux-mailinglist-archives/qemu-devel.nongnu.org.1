Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3CB74DE6C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:44:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwo5-0006hs-6X; Mon, 10 Jul 2023 15:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qIwo3-0006hh-AG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qIwo1-000418-UF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689018261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4hnMHpVGb4nMa70qKo1mNRxQ3HaVJZ2NJcCjQ65JaAM=;
 b=QgjsN6XkXFWl2A+WkkZt/ghShQQ6xUWAByfKC4pq/ZJ04qbJ12M8WjwrX86w8lUtis6Ayb
 PL7MrpCMdfOeChcKGEKdI7USk3Uq+JwPAas1d96/vJ2KVzPvy45gfHf9f9kerBbt/dx6Da
 ilikFb+gRqhHYWa62K/+jlROH/4AQiw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-nhWjz7DOO_KM2pbDs37Waw-1; Mon, 10 Jul 2023 15:44:17 -0400
X-MC-Unique: nhWjz7DOO_KM2pbDs37Waw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 527011044589;
 Mon, 10 Jul 2023 19:44:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69B08C51488;
 Mon, 10 Jul 2023 19:44:16 +0000 (UTC)
Date: Mon, 10 Jul 2023 14:44:14 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org, 
 kwolf@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com
Subject: Re: [PATCH 1/3] block: add subcluster_size field to BlockDriverInfo
Message-ID: <q67bzdmrwjcrcfh7ggc47nu4h4nb6q2pgmfgw2i3v6lg3ovokg@n4evcsyztbf6>
References: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
 <20230626160834.696680-2-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626160834.696680-2-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Mon, Jun 26, 2023 at 07:08:32PM +0300, Andrey Drobyshev via wrote:
> This is going to be used in the subsequent commit as requests alignment
> (in particular, during copy-on-read).  This value only makes sense for
> the formats which support subclusters (currently QCOW2 only).  If this
> field isn't set by driver's own bdrv_get_info() implementation, we
> simply set it equal to the cluster size thus treating each cluster as having
> a single subcluster.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block.c                      | 7 +++++++
>  block/qcow2.c                | 1 +
>  include/block/block-common.h | 5 +++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 0637265c26..4fe1743cfb 100644
> --- a/block.c
> +++ b/block.c
> @@ -6392,6 +6392,13 @@ int coroutine_fn bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>      }
>      memset(bdi, 0, sizeof(*bdi));
>      ret = drv->bdrv_co_get_info(bs, bdi);
> +    if (bdi->subcluster_size == 0) {
> +        /*
> +         * If the driver left this unset, subclusters either not supported.

s/either/are/

> +         * Then it is safe to treat each cluster as having only one subcluster.
> +         */
> +        bdi->subcluster_size = bdi->cluster_size;
> +    }

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


