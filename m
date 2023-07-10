Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018974DE7C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwri-0000mB-Ki; Mon, 10 Jul 2023 15:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qIwrX-0000fD-VP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qIwrW-0005TL-EM
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689018477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcvxBSBSxDvs53AX++ELmWRenBbMacAHC9NQUCgRUK4=;
 b=BQjQ4/xAxCoo4r5oKxQlu5eic6JXoJ3BjThGbF5rdv6fewieWnubf4Bhz396C2f9oihrJQ
 4YOn6aP3VSu611Y4COjowBmOzR7RYVK4JAVmugxskOoJ20NDSieCOgq7mHZwzxP5PQqJaS
 rcqDQsW0TZsE401HAlPcwHDs+KX2fac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-0J6XG97cP4amSpmPutmsbQ-1; Mon, 10 Jul 2023 15:47:54 -0400
X-MC-Unique: 0J6XG97cP4amSpmPutmsbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0167C800CAE;
 Mon, 10 Jul 2023 19:47:54 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A167B40C206F;
 Mon, 10 Jul 2023 19:47:52 +0000 (UTC)
Date: Mon, 10 Jul 2023 14:47:50 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org, 
 kwolf@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com
Subject: Re: [PATCH 2/3] block/io: align requests to subcluster_size
Message-ID: <5ogsrhiwbo5u5k4a4mleyszoolr7stx56kj6bcwysoyfg7crzw@lhm7o3l3wmbn>
References: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
 <20230626160834.696680-3-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626160834.696680-3-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 26, 2023 at 07:08:33PM +0300, Andrey Drobyshev via wrote:
> When target image is using subclusters, and we align the request during
> copy-on-read, it makes sense to align to subcluster_size rather than
> cluster_size.  Otherwise we end up with unnecessary allocations.
> 
> This commit renames bdrv_round_to_clusters() to bdrv_round_to_subclusters()
> and utilizes subcluster_size field of BlockDriverInfo to make necessary
> alignments.  It affects copy-on-read as well as mirror job (which is
> using bdrv_round_to_clusters()).
> 
> This change also fixes the following bug with failing assert (covered by
> the test in the subsequent commit):
> 
> qemu-img create -f qcow2 base.qcow2 64K
> qemu-img create -f qcow2 -o extended_l2=on,backing_file=base.qcow2,backing_fmt=qcow2 img.qcow2 64K
> qemu-io -c "write -P 0xaa 0 2K" img.qcow2
> qemu-io -C -c "read -P 0x00 2K 62K" img.qcow2
> 
> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/io.c               | 50 ++++++++++++++++++++--------------------
>  block/mirror.c           |  8 +++----
>  include/block/block-io.h |  2 +-
>  3 files changed, 30 insertions(+), 30 deletions(-)
> 
> +++ b/include/block/block-io.h
> @@ -189,7 +189,7 @@ bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
>  ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
>                                            Error **errp);
>  BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
> -void bdrv_round_to_clusters(BlockDriverState *bs,
> +void bdrv_round_to_subclusters(BlockDriverState *bs,
>                              int64_t offset, int64_t bytes,
>                              int64_t *cluster_offset,
>                              int64_t *cluster_bytes);

Indentation on subsequent lines should be fixed.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


