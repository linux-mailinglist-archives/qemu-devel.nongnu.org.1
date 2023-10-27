Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A62297D960D
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 13:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwKjO-0006tX-59; Fri, 27 Oct 2023 07:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qwKjK-0006sN-Ci; Fri, 27 Oct 2023 07:10:18 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qwKjG-0003GO-Iu; Fri, 27 Oct 2023 07:10:18 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 7288D1520E7F;
 Fri, 27 Oct 2023 13:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1698405008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wu0AmSpliDQL0jXaBdDIXXbEuRFwuYt2HnhOUwg3eCk=;
 b=j5i7afV6QjSOCjOXY7/uBeQkjap+kbDqozz/zuHMd+0by2q3c3QFwGvkGhK3OsQh+TJCgX
 O/pjbU/rfHigbCB0G1fe8kkXlca0aoltpNAffRNl06R7NMzJuC21p5rVXla818K1GpNekY
 2CYet4u3I9ZOo/iXXghfEeLA7N3C6zF9QqojD/8VNeJTvWwz2zXVq3eYdsV05rV3WScF6j
 FAiZLs1NbbKpCuzJEP14jHUatYorgbnj0DgpvkBtjGvuBpG6GP95ycFIidWK3iRX2FZtGT
 jYqya8jzY20M1rQnHegmdis1/N1PMUcM4b/dG/7gwCAgDpGpstMrfxNsY2UMaQ==
Message-ID: <b92c8ede-604f-4859-b3b8-7e2fd7824274@dupond.be>
Date: Fri, 27 Oct 2023 13:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] qcow2: make subclusters discardable
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/2023 23:56, Andrey Drobyshev wrote:
> This commit makes the discard operation work on the subcluster level
> rather than cluster level.  It introduces discard_l2_subclusters()
> function and makes use of it in qcow2 discard implementation, much like
> it's done with zero_in_l2_slice() / zero_l2_subclusters().  It also
> changes the qcow2 driver pdiscard_alignment to subcluster_size.  That
> way subcluster-aligned discards lead to actual fallocate(PUNCH_HOLE)
> operation and free host disk space.
>
> This feature will let us gain additional disk space on guest
> TRIM/discard requests, especially when using large enough clusters
> (1M, 2M) with subclusters enabled.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 100 ++++++++++++++++++++++++++++++++++++++++--
>   block/qcow2.c         |   8 ++--
>   2 files changed, 101 insertions(+), 7 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 7c6fa5524c..cf40f2dc12 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2042,6 +2042,74 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>       return nb_clusters;
>   }
>   
> +static int coroutine_fn GRAPH_RDLOCK
> +discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
> +                       uint64_t nb_subclusters,
> +                       enum qcow2_discard_type type,
> +                       bool full_discard,
> +                       SubClusterRangeInfo *pscri)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t new_l2_bitmap, l2_bitmap_mask;
> +    int ret, sc = offset_to_sc_index(s, offset);
> +    SubClusterRangeInfo scri = { 0 };
> +
> +    if (!pscri) {
> +        ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +    } else {
> +        scri = *pscri;
> +    }
> +
> +    l2_bitmap_mask = QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
> +    new_l2_bitmap = scri.l2_bitmap;
> +    new_l2_bitmap &= ~l2_bitmap_mask;
> +
> +    /*
> +     * If there're no allocated subclusters left, we might as well discard
> +     * the entire cluster.  That way we'd also update the refcount table.
> +     */
> +    if (!(new_l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC)) {
> +        return discard_in_l2_slice(bs,
> +                                   QEMU_ALIGN_DOWN(offset, s->cluster_size),
> +                                   1, type, full_discard);
> +    }
> +
> +    /*
> +     * Full discard means we fall through to the backing file, thus we only
> +     * need to mark the subclusters as deallocated.
> +     *
> +     * Non-full discard means subclusters should be explicitly marked as
> +     * zeroes.  In this case QCOW2 specification requires the corresponding
> +     * allocation status bits to be unset as well.  If the subclusters are
> +     * deallocated in the first place and there's no backing, the operation
> +     * can be skipped.
> +     */
> +    if (!full_discard &&
> +        (bs->backing || scri.l2_bitmap & l2_bitmap_mask)) {
> +        new_l2_bitmap |= QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
> +    }
> +
> +    if (scri.l2_bitmap != new_l2_bitmap) {
> +        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
> +    }
> +
> +    if (s->discard_passthrough[type]) {
> +        qcow2_queue_discard(bs, (scri.l2_entry & L2E_OFFSET_MASK) +
> +                            offset_into_cluster(s, offset),
> +                            nb_subclusters * s->subcluster_size);
> +    }
> +
> +    ret = 0;
> +out:
> +    qcow2_cache_put(s->l2_table_cache, (void **) &scri.l2_slice);
> +
> +    return ret;
> +}
> +
>   int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>                             uint64_t bytes, enum qcow2_discard_type type,
>                             bool full_discard)
> @@ -2049,19 +2117,36 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>       BDRVQcow2State *s = bs->opaque;
>       uint64_t end_offset = offset + bytes;
>       uint64_t nb_clusters;
> +    unsigned head, tail;
>       int64_t cleared;
>       int ret;
>   
>       /* Caller must pass aligned values, except at image end */
> -    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> -    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
> +    assert(QEMU_IS_ALIGNED(offset, s->subcluster_size));
> +    assert(QEMU_IS_ALIGNED(end_offset, s->subcluster_size) ||
>              end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
>   
> -    nb_clusters = size_to_clusters(s, bytes);
> +    head = MIN(end_offset, ROUND_UP(offset, s->cluster_size)) - offset;
> +    offset += head;
> +
> +    tail = (end_offset >= bs->total_sectors << BDRV_SECTOR_BITS) ? 0 :
> +           end_offset - MAX(offset, start_of_cluster(s, end_offset));
> +    end_offset -= tail;
>   
>       s->cache_discards = true;
>   
> +    if (head) {
> +        ret = discard_l2_subclusters(bs, offset - head,
> +                                     size_to_subclusters(s, head), type,
> +                                     full_discard, NULL);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +    }
> +
>       /* Each L2 slice is handled by its own loop iteration */
> +    nb_clusters = size_to_clusters(s, end_offset - offset);
> +
>       while (nb_clusters > 0) {
>           cleared = discard_in_l2_slice(bs, offset, nb_clusters, type,
>                                         full_discard);
> @@ -2074,6 +2159,15 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>           offset += (cleared * s->cluster_size);
>       }
>   
> +    if (tail) {
> +        ret = discard_l2_subclusters(bs, end_offset,
> +                                     size_to_subclusters(s, tail), type,
> +                                     full_discard, NULL);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +    }
> +
>       ret = 0;
>   fail:
>       s->cache_discards = false;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index aa01d9e7b5..66961fa59e 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1966,7 +1966,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
>           bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
>       }
>       bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
> -    bs->bl.pdiscard_alignment = s->cluster_size;
> +    bs->bl.pdiscard_alignment = s->subcluster_size;
>   }
>   
>   static int GRAPH_UNLOCKED
> @@ -4102,11 +4102,11 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
>           return -ENOTSUP;
>       }
>   
> -    if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
> -        assert(bytes < s->cluster_size);
> +    if (!QEMU_IS_ALIGNED(offset | bytes, bs->bl.pdiscard_alignment)) {
> +        assert(bytes < bs->bl.pdiscard_alignment);
>           /* Ignore partial clusters, except for the special case of the
>            * complete partial cluster at the end of an unaligned file */
> -        if (!QEMU_IS_ALIGNED(offset, s->cluster_size) ||
> +        if (!QEMU_IS_ALIGNED(offset, bs->bl.pdiscard_alignment) ||
>               offset + bytes != bs->total_sectors * BDRV_SECTOR_SIZE) {
>               return -ENOTSUP;
>           }


I've checked all the code paths, and as far as I see it nowhere breaks 
the discard_no_unref option.
It's important that we don't introduce new code paths that can make 
holes in the qcow2 image when this option is enabled :)

If you can confirm my conclusion, that would be great.


Thanks
Jean-Louis


