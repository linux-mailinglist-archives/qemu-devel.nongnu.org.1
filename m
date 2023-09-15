Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CB7A17D6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3dS-00010E-8a; Fri, 15 Sep 2023 03:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh3dO-0000zc-O1
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh3dN-0003XN-5b
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694764380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcVDXYMT8LMkjLVvlYxNFSFHVpcbcXjDofWehTamLNU=;
 b=TjZhJhTyV/K91oa4SkAGBvzlehPYimBE6blukykM3KxLzxmALLLmQw83OuKwvdT3vTkf04
 Aj5cMld838FmafWlOqXR2S3moHLLlVqHt6t+p7umzHQwQNHUP2tioRybpSWG0DwFZyrEI8
 RLeB+M+zoJGrVuLbRGY4SRZwEPvtil0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-pcOupwDDMkugD5Y9jR6PPg-1; Fri, 15 Sep 2023 03:52:56 -0400
X-MC-Unique: pcOupwDDMkugD5Y9jR6PPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 670C7101A58B;
 Fri, 15 Sep 2023 07:52:55 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA87E2026D4B;
 Fri, 15 Sep 2023 07:52:51 +0000 (UTC)
Date: Fri, 15 Sep 2023 09:52:50 +0200
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
Subject: Re: [PATCH 4/7] block/dirty-bitmap: Clean up local variable shadowing
Message-ID: <ZQQNUjN4Laf+k1Nk@redhat.com>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831132546.3525721-5-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 31.08.2023 um 15:25 hat Markus Armbruster geschrieben:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Tracked down with -Wshadow=local.
> Clean up: delete inner declarations when they are actually redundant,
> else rename variables.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/monitor/bitmap-qmp-cmds.c | 2 +-
>  block/qcow2-bitmap.c            | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
> index 55f778f5af..4d018423d8 100644
> --- a/block/monitor/bitmap-qmp-cmds.c
> +++ b/block/monitor/bitmap-qmp-cmds.c
> @@ -276,7 +276,7 @@ BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
>  
>      for (lst = bms; lst; lst = lst->next) {
>          switch (lst->value->type) {
> -            const char *name, *node;
> +            const char *name;
>          case QTYPE_QSTRING:
>              name = lst->value->u.local;
>              src = bdrv_find_dirty_bitmap(bs, name);

The names in this function are all over the place... A more ambitious
patch could rename the parameters to dst_node/dst_bitmap and these
variables to src_node/src_bitmap to get some more consistency (both with
each other and with the existing src/dst variables).

Preexisting, so I'm not insisting that you should do this.

> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 037fa2d435..ffd5cd3b23 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1555,7 +1555,6 @@ bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>      FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>          const char *name = bdrv_dirty_bitmap_name(bitmap);
>          uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
> -        Qcow2Bitmap *bm;
>  
>          if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
>              bdrv_dirty_bitmap_inconsistent(bitmap)) {
> @@ -1625,7 +1624,7 @@ bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>  
>      /* allocate clusters and store bitmaps */
>      QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> -        BdrvDirtyBitmap *bitmap = bm->dirty_bitmap;
> +        bitmap = bm->dirty_bitmap;
>  
>          if (bitmap == NULL || bdrv_dirty_bitmap_readonly(bitmap)) {
>              continue;

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


