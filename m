Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA62F7DD0F8
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:54:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxr3a-000601-6m; Tue, 31 Oct 2023 11:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxr3Y-0005zR-H0
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxr3W-0006QE-SF
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698767606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1PFDjUmGlAPZn3sCueGAIjbKvHWbHpeXFqEDA+ZgAE=;
 b=VpQKk+cPGBZSF0j/cYADjs2+TGNJhyAo/B+Yagog5JfonBPfXTXk9FcK71rm/sURpDNpMN
 mduu7hLs6z5kZsE9clv3/sYTCikYYLDIJI50ebjxaQC03fPH+uuhHeykZAPaWZB6TPZwfU
 rSNhX39bz805yOV88eoEym6mvhg+Txw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-aOxpl45TN_up1Br6WSAU4g-1; Tue, 31 Oct 2023 11:53:09 -0400
X-MC-Unique: aOxpl45TN_up1Br6WSAU4g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4084e263ec4so41335605e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698767588; x=1699372388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/1PFDjUmGlAPZn3sCueGAIjbKvHWbHpeXFqEDA+ZgAE=;
 b=IuZLwa/Z214Qi9H+9WhPXG9tYccZsdUThK7DGzU58L76RkMWJaA9aJxaJmjpUT7hgM
 mFzKquegxMqR5OfSCuWTzBlLaw21p1lHmlxtl0Z+36wL8heYKgA4wNj8RMyctSP2DQae
 LIXh/9VfM8pSkuVejNuSYGswdobse55CmxzozziqkT688XjZ3gzgvqOX2+19sYd4ZLLO
 xNnEl41/4oUG+2tVcN++vAMjuibXJQWuU3J1+cvVpxlGqW/FskkPbALpTGSuiP3OGxeF
 FfcqpWrNgBgOg77mXayqkaEPx7NceytQpSF5wjpi8HqHq0OCyw5sXot3WaQa9TSmgHp3
 yhrg==
X-Gm-Message-State: AOJu0Yz7KPA8m2BdBC4rA1Yw/Bz+7PjSZd74/rgUhQcAKkV/Z8NpD/wn
 haO+qanmOS0gcV0c4iceQfAbYZ41P4Hrdz6k4wCCa1zKHYV6ySVLKupsiJnQHZnukJBJhticZul
 xGAWXmqdggaxVUqZgIkGS4No=
X-Received: by 2002:a05:600c:358a:b0:407:5b54:bb0c with SMTP id
 p10-20020a05600c358a00b004075b54bb0cmr11464395wmq.19.1698767587974; 
 Tue, 31 Oct 2023 08:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+YnYkQbei7fF41P1qRbj+fhtMPdqeG3BZj41ddVuuYeP3AjZKpeiGsgcwbW6qJf9r3ijnZg==
X-Received: by 2002:a05:600c:358a:b0:407:5b54:bb0c with SMTP id
 p10-20020a05600c358a00b004075b54bb0cmr11464381wmq.19.1698767587639; 
 Tue, 31 Oct 2023 08:53:07 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a05600c20c100b00407efbc4361sm2072352wmm.9.2023.10.31.08.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 08:53:07 -0700 (PDT)
Message-ID: <28ae9906-0880-4143-8573-f880a9d1798c@redhat.com>
Date: Tue, 31 Oct 2023 16:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] qcow2: add get_sc_range_info() helper for working
 with subcluster ranges
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-3-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231020215622.789260-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20.10.23 23:56, Andrey Drobyshev wrote:
> This helper simply obtains the l2 table parameters of the cluster which
> contains the given subclusters range.  Right now this info is being
> obtained and used by zero_l2_subclusters().  As we're about to introduce
> the subclusters discard operation, this helper would let us avoid code
> duplication.
>
> Also introduce struct SubClusterRangeInfo, which would contain all the
> needed params.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 90 +++++++++++++++++++++++++++++--------------
>   1 file changed, 62 insertions(+), 28 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 904f00d1b3..8801856b93 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -32,6 +32,13 @@
>   #include "qemu/memalign.h"
>   #include "trace.h"
>   
> +typedef struct SubClusterRangeInfo {
> +    uint64_t *l2_slice;

We should document that this is a strong reference that must be returned 
via qcow2_cache_put().  Maybe you could also define a clean-up function 
using G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC() that does this, allowing this 
type to be used with g_auto().

> +    int l2_index;
> +    uint64_t l2_entry;
> +    uint64_t l2_bitmap;
> +} SubClusterRangeInfo;
> +
>   int coroutine_fn qcow2_shrink_l1_table(BlockDriverState *bs,
>                                          uint64_t exact_size)
>   {
> @@ -1892,6 +1899,50 @@ again:
>       return 0;
>   }
>   
> +static int get_sc_range_info(BlockDriverState *bs, uint64_t offset,
> +                             unsigned nb_subclusters,
> +                             SubClusterRangeInfo *scri)

It would be good to have documentation for this function, for example 
that it only works on a single cluster, i.e. that the range denoted by 
@offset and @nb_subclusters must not cross a cluster boundary, and that 
@offset must be aligned to subclusters.

In general, it is unclear to me at this point what this function does.  
OK, it gets the SCRI for all subclusters in the cluster at @offset (this 
is what its name implies), but then it also has this loop that checks 
whether there are compressed clusters among the @nb_subclusters.  It has 
a comment about being unable to zero/discard subclusters in compressed 
clusters, but the function name says nothing about this scope of 
zeroing/discarding.

> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    int ret, sc_cleared = 0, sc_index = offset_to_sc_index(s, offset);
> +    QCow2SubclusterType sctype;
> +
> +    /* Here we only work with the subclusters within single cluster. */
> +    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
> +    assert(sc_index + nb_subclusters <= s->subclusters_per_cluster);
> +    assert(offset_into_subcluster(s, offset) == 0);
> +
> +    ret = get_cluster_table(bs, offset, &scri->l2_slice, &scri->l2_index);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    scri->l2_entry = get_l2_entry(s, scri->l2_slice, scri->l2_index);
> +    scri->l2_bitmap = get_l2_bitmap(s, scri->l2_slice, scri->l2_index);
> +
> +    do {
> +        qcow2_get_subcluster_range_type(bs, scri->l2_entry, scri->l2_bitmap,
> +                                        sc_index, &sctype);

I think there’s a `ret = ` missing here.

> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        switch (sctype) {
> +        case QCOW2_SUBCLUSTER_COMPRESSED:
> +            /* We cannot partially zeroize/discard compressed clusters. */
> +            return -ENOTSUP;
> +        case QCOW2_SUBCLUSTER_INVALID:
> +            return -EINVAL;
> +        default:
> +            break;
> +        }
> +
> +        sc_cleared += ret;
> +    } while (sc_cleared < nb_subclusters);
> +
> +    return 0;
> +}
> +
>   /*
>    * This discards as many clusters of nb_clusters as possible at once (i.e.
>    * all clusters in the same L2 slice) and returns the number of discarded
> @@ -2097,44 +2148,27 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>                       unsigned nb_subclusters)
>   {
>       BDRVQcow2State *s = bs->opaque;
> -    uint64_t *l2_slice;
> -    uint64_t old_l2_bitmap, l2_bitmap;
> -    int l2_index, ret, sc = offset_to_sc_index(s, offset);
> +    uint64_t new_l2_bitmap;
> +    int ret, sc = offset_to_sc_index(s, offset);
> +    SubClusterRangeInfo scri = { 0 };
>   
> -    /* For full clusters use zero_in_l2_slice() instead */
> -    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
> -    assert(sc + nb_subclusters <= s->subclusters_per_cluster);
> -    assert(offset_into_subcluster(s, offset) == 0);
> -
> -    ret = get_cluster_table(bs, offset, &l2_slice, &l2_index);
> +    ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
>       if (ret < 0) {
> -        return ret;
> -    }
> -
> -    switch (qcow2_get_cluster_type(bs, get_l2_entry(s, l2_slice, l2_index))) {
> -    case QCOW2_CLUSTER_COMPRESSED:
> -        ret = -ENOTSUP; /* We cannot partially zeroize compressed clusters */
>           goto out;
> -    case QCOW2_CLUSTER_NORMAL:
> -    case QCOW2_CLUSTER_UNALLOCATED:
> -        break;
> -    default:
> -        g_assert_not_reached();
>       }
>   
> -    old_l2_bitmap = l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
> -
> -    l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
> -    l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
> +    new_l2_bitmap = scri.l2_bitmap;
> +    new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
> +    new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
>   
> -    if (old_l2_bitmap != l2_bitmap) {
> -        set_l2_bitmap(s, l2_slice, l2_index, l2_bitmap);
> -        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
> +    if (new_l2_bitmap != scri.l2_bitmap) {
> +        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
>       }
>   
>       ret = 0;
>   out:
> -    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
> +    qcow2_cache_put(s->l2_table_cache, (void **) &scri.l2_slice);

qcow2_cache_put() doesn’t look like it’s safe to be called if the table 
is NULL (i.e. `scri.l2_slice == NULL`).  We can get here if 
get_sc_range_info() fails, so that may happen.  I think you should either:

(A) Implement G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC() for the SCRI type so it 
isn’t an issue (at least I assume that could solve it), or

(B) Call qcow2_cache_put() here only if `scri.l2_slice != NULL`.

In any case, I think it also makes sense to have get_sc_range_info() 
only return a valid table if it returns success, i.e. if there’s any 
error in get_sc_range_info(), it should clean up `scri.l2_slice` itself.

Hanna

>   
>       return ret;
>   }


