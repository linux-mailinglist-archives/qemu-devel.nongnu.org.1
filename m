Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4227DD1AB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:34:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrfs-0003eJ-W3; Tue, 31 Oct 2023 12:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxrfp-0003dI-Hd
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxrfn-00056c-Ek
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698769978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YyMLDjjeMay6L6ajJYU/2sdD9xfTHGJT2FL03iGFgLw=;
 b=GdHWiEh1mh2v95xzGoHojv8Xbqcr9K841VAUJg34nlZBr7MI3ncb+fsvJCbYapwsgNoug1
 LD4vkaD3DOb9zIFvr8RRbV3BNAvccUvWVvsZHO8pYUEHE6RrkQl8EKC0v87XoXoJZglm40
 G4flRZXhAkKvwIW9Aw7dX6GKwyUsius=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-oyF3ZBt1PQeJENh3dM9Cug-1; Tue, 31 Oct 2023 12:32:37 -0400
X-MC-Unique: oyF3ZBt1PQeJENh3dM9Cug-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507b8ac8007so6894835e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698769955; x=1699374755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YyMLDjjeMay6L6ajJYU/2sdD9xfTHGJT2FL03iGFgLw=;
 b=F1Y9viyR7+dS8Py0tNtAFHDqpM4cEq2FjVecvinYVWkpne1MbXfSEsE4wGPrbKa+Sm
 0NJz3ysr3uHfa60SbPdiJwYpLT2RT91E0pifZj0wAHpyQYHoVJFAhrMa2WdykEhJn353
 lnJxcAwiF/Pi5yOkgBcWK7mxukR2pIS7eXbLyw9uu2p1vosB7g/2CY5h4/wx3zmN+Wqz
 /WzsOJ1NOp29BoSA7ym0bLxZeSNKlrANAREYSEy0Io1Q0ZUaj/cc4+ClndcrrnO1KJTy
 yspwp+il3cbNgGacJxoScI+AWbVVq83+Kb7m/hKPJTX05m0vsxq2kZ6fIZFLgTt3Db1k
 MEUA==
X-Gm-Message-State: AOJu0YyhhVqScjFpzCcwxMr7GvsaAfgGJHMU/gATYKlY07xq+1g+1ReZ
 T8p4mx7NanFFZajUqXrulYshtjPmHzEjRaDW/gSaTfoBmPO1rJxs0UWoFDNT0JG58GwAsUHSLfY
 SSOqmxbdE3jQ/3Hw=
X-Received: by 2002:ac2:5398:0:b0:507:9f69:e8d9 with SMTP id
 g24-20020ac25398000000b005079f69e8d9mr9531933lfh.49.1698769955598; 
 Tue, 31 Oct 2023 09:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgn9GIY555rqh5N+P/0p2GHAZpfzKcrvM6Cp2TcYO/xs9FM6jHrlTvLSR+gvIE0TU3/6YN2g==
X-Received: by 2002:ac2:5398:0:b0:507:9f69:e8d9 with SMTP id
 g24-20020ac25398000000b005079f69e8d9mr9531919lfh.49.1698769955205; 
 Tue, 31 Oct 2023 09:32:35 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c30d300b003fefaf299b6sm2083441wmn.38.2023.10.31.09.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 09:32:34 -0700 (PDT)
Message-ID: <8a85f4f5-35fb-4fbb-98c6-c1f2b9f11a8a@redhat.com>
Date: Tue, 31 Oct 2023 17:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] qcow2: make subclusters discardable
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

[...]

> +    if (scri.l2_bitmap != new_l2_bitmap) {
> +        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
> +    }
> +
> +    if (s->discard_passthrough[type]) {
> +        qcow2_queue_discard(bs, (scri.l2_entry & L2E_OFFSET_MASK) +
> +                            offset_into_cluster(s, offset),
> +                            nb_subclusters * s->subcluster_size);

Are we sure that the cluster is allocated, i.e. that scri.l2_entry & 
L2E_OFFSET_MASK != 0?

As a side note, I guess discard_in_l2_slice() should also use 
qcow2_queue_discard() instead of bdrv_pdiscard() then.

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

I think the comment should stay attached to the `while`.

Hanna

>           cleared = discard_in_l2_slice(bs, offset, nb_clusters, type,
>                                         full_discard);


