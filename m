Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BC288BD4B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Mar 2024 10:08:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp2m9-00053n-7j; Tue, 26 Mar 2024 05:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp2m6-00053F-9V
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp2m0-00067H-He
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711444031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=axdPqTnTwNc5IrsGPyhYItPNWF7Zm1RI8uY2Il5mILo=;
 b=iHNhxycHWqiyON0r/9V+iK8sgRhUbnkgNDDXSfYR5qGuAW1YYHYT+8CEaRl4azcymd3C5U
 +9Bq6kQHjQI/w6wv5BfbtPTYiReEdC5TzqJv/SdoC88G5PP3DtwwDX1mf/p7tyWnoVeRhN
 xv77w66nweXY7Xc0SweANJyR+UmAs8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-DUjjUWdjMlOTxbogsoUd0Q-1; Tue, 26 Mar 2024 05:07:06 -0400
X-MC-Unique: DUjjUWdjMlOTxbogsoUd0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94A9889C528;
 Tue, 26 Mar 2024 09:06:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E04F2200AFA3;
 Tue, 26 Mar 2024 09:06:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F30ED21E6757; Tue, 26 Mar 2024 10:06:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com
Subject: Re: [PATCH 1/2] copy-before-write: allow specifying minimum cluster
 size
In-Reply-To: <20240308155158.830258-2-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 8 Mar 2024 16:51:57 +0100")
References: <20240308155158.830258-1-f.ebner@proxmox.com>
 <20240308155158.830258-2-f.ebner@proxmox.com>
Date: Tue, 26 Mar 2024 10:06:10 +0100
Message-ID: <875xx9s6pp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> Useful to make discard-source work in the context of backup fleecing
> when the fleecing image has a larger granularity than the backup
> target.
>
> Copy-before-write operations will use at least this granularity and in
> particular, discard requests to the source node will too. If the
> granularity is too small, they will just be aligned down in
> cbw_co_pdiscard_snapshot() and thus effectively ignored.
>
> The QAPI uses uint32 so the value will be non-negative, but still fit
> into a uint64_t.
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/block-copy.c         | 17 +++++++++++++----
>  block/copy-before-write.c  |  3 ++-
>  include/block/block-copy.h |  1 +
>  qapi/block-core.json       |  8 +++++++-
>  4 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 7e3b378528..adb1cbb440 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -310,6 +310,7 @@ void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
>  }
>  
>  static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
> +                                                 int64_t min_cluster_size,
>                                                   Error **errp)
>  {
>      int ret;
> @@ -335,7 +336,7 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
>                      "used. If the actual block size of the target exceeds "
>                      "this default, the backup may be unusable",
>                      BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
> -        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
> +        return MAX(min_cluster_size, BLOCK_COPY_CLUSTER_SIZE_DEFAULT);

min_cluster_size is int64_t, BLOCK_COPY_CLUSTER_SIZE_DEFAULT is int, and
gets converted to int64_t.  The return type is int64_t.  Okay.

>      } else if (ret < 0 && !target_does_cow) {
>          error_setg_errno(errp, -ret,
>              "Couldn't determine the cluster size of the target image, "
> @@ -345,16 +346,18 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
>          return ret;
>      } else if (ret < 0 && target_does_cow) {
>          /* Not fatal; just trudge on ahead. */
> -        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
> +        return MAX(min_cluster_size, BLOCK_COPY_CLUSTER_SIZE_DEFAULT);

Same.

>      }
>  
> -    return MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
> +    return MAX(min_cluster_size,
> +               MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size));

Similar: bdi.cluster_size is int.

>  }
>  
>  BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>                                       BlockDriverState *copy_bitmap_bs,
>                                       const BdrvDirtyBitmap *bitmap,
>                                       bool discard_source,
> +                                     int64_t min_cluster_size,
>                                       Error **errp)
>  {
>      ERRP_GUARD();
> @@ -365,7 +368,13 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>  
>      GLOBAL_STATE_CODE();
>  
> -    cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
> +    if (min_cluster_size && !is_power_of_2(min_cluster_size)) {

min_cluster_size is int64_t, is_power_of_2() takes uint64_t.  Bad if
min_cluster_size is negative.  Could this happen?


> +        error_setg(errp, "min-cluster-size needs to be a power of 2");
> +        return NULL;
> +    }
> +
> +    cluster_size = block_copy_calculate_cluster_size(target->bs,
> +                                                     min_cluster_size, errp);

min_cluster_size is int64_t, block_copy_calculate_cluster_size() takes
int64_t, returns int64_t, and cluster_size is int64_t.  Good.

>      if (cluster_size < 0) {
>          return NULL;
>      }
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index dac57481c5..f9896c6c1e 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -476,7 +476,8 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      s->discard_source = flags & BDRV_O_CBW_DISCARD_SOURCE;
>      s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap,
> -                                  flags & BDRV_O_CBW_DISCARD_SOURCE, errp);
> +                                  flags & BDRV_O_CBW_DISCARD_SOURCE,
> +                                  opts->min_cluster_size, errp);

@opts is BlockdevOptionsCbw *, opts->min_cluster_size is uint32_t (see
last hunk), block_copy_state_new() takes int64_t: opts->min_cluster_size
gets zero-extended.  Okay.

>      if (!s->bcs) {
>          error_prepend(errp, "Cannot create block-copy-state: ");
>          return -EINVAL;
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index bdc703bacd..77857c6c68 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -28,6 +28,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>                                       BlockDriverState *copy_bitmap_bs,
>                                       const BdrvDirtyBitmap *bitmap,
>                                       bool discard_source,
> +                                     int64_t min_cluster_size,
>                                       Error **errp);
>  
>  /* Function should be called prior any actual copy request */
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0a72c590a8..85c8f88f6e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4625,12 +4625,18 @@
>  #     @on-cbw-error parameter will decide how this failure is handled.
>  #     Default 0. (Since 7.1)
>  #
> +# @min-cluster-size: Minimum size of blocks used by copy-before-write
> +#     operations.  Has to be a power of 2.  No effect if smaller than
> +#     the maximum of the target's cluster size and 64 KiB.  Default 0.
> +#     (Since 9.0)
> +#
>  # Since: 6.2
>  ##
>  { 'struct': 'BlockdevOptionsCbw',
>    'base': 'BlockdevOptionsGenericFormat',
>    'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
> -            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
> +            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
> +            '*min-cluster-size': 'uint32' } }

Elsewhere in the schema, we use either 'int' or 'size' for cluster-size.
Why the difference?

>  
>  ##
>  # @BlockdevOptions:


