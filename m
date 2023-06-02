Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30262720633
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q56iP-0003p2-DL; Fri, 02 Jun 2023 11:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q56iN-0003oe-1o
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q56iL-0001jT-4a
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685719756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFI0EI0RLFTQ9/hVt0vz/ywXpdWXjgQFbsAixRk8qAM=;
 b=Dnu6DoHXc5phhx4hyGFMJ7CJJv564wdBjxEXfF9tpWrmC3WbZFaPBSiQ2/8UzSNhQPo/77
 DPko8OhqkLj9KdxDl6oP3CojFIw+nVGztWKytz6h3IPdhSoSrj1jgariUHSzRtE8VTw/kc
 JCEltq5rtaiLUSgEGFP99GPhl1o9dTg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-cNiwMXBPNVCLxD374pW2nw-1; Fri, 02 Jun 2023 11:29:04 -0400
X-MC-Unique: cNiwMXBPNVCLxD374pW2nw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-975942c2a29so23791766b.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685719740; x=1688311740;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFI0EI0RLFTQ9/hVt0vz/ywXpdWXjgQFbsAixRk8qAM=;
 b=ILmqKNxPEfT72HE6DGdzgJaB036UrLaRfKW6OCsASoTq5pgehYTlkX6oPqJ0P4mbKx
 itNUNUOsNqlYH2ueOxSwLqrVKkq98JBDc51xfwfgHHLnW1QnNS8HplvSun4Xs9PcCLoc
 e3oCkPXvgMFWZiZDIQOAaBZvaedSPqP2fCysH+L8c9J7nMar+OCTikp98FXGoGnqDBEg
 07ES+B25Q4qrLWeg4QDPQ0wsXTQjpePRsKxBrsOH7LWQPPNrTRrxClY/ehxG0p8LrT/y
 +XbQ5/Dlsllk2bmaGKKXMhXNCcwRJPFBsKaFAejhqgASGlV+w0UUy5Yi/TKMz8NETNKg
 FA3g==
X-Gm-Message-State: AC+VfDxgS4CRWTknAV0GLZjUV7oRuJlXJda8m46PoipyfPvQcCdtZY92
 4Npk/bYCAMOCdn9FULzeScJ68ovwqqrnew7690yyanTMBF8vXYFG6bMNGv3W8EPLNu6odlU1N/4
 EBd7/41/SIweY0c8=
X-Received: by 2002:a17:907:9403:b0:966:5c04:2c61 with SMTP id
 dk3-20020a170907940300b009665c042c61mr11038842ejc.8.1685719740051; 
 Fri, 02 Jun 2023 08:29:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FqxfeZuwtaofDAk5X7ysaVvcTQ2ZNvNz4cl8qFeyR74t6/v2A2sOr7GsCYmRsbpbrwhtOwA==
X-Received: by 2002:a17:907:9403:b0:966:5c04:2c61 with SMTP id
 dk3-20020a170907940300b009665c042c61mr11038825ejc.8.1685719739732; 
 Fri, 02 Jun 2023 08:28:59 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:e1ec:6307:c799:c188?
 (p200300cfd72ef7e0e1ec6307c799c188.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:e1ec:6307:c799:c188])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a1709061c9200b0096f920858afsm879673ejh.102.2023.06.02.08.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 08:28:59 -0700 (PDT)
Message-ID: <11d5e450-f24f-a52c-e143-9889ccf724ef@redhat.com>
Date: Fri, 2 Jun 2023 17:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] qcow2: add discard-no-unref option
Content-Language: en-US
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20230602124747.1544077-1-jean-louis@dupond.be>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230602124747.1544077-1-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 02.06.23 14:47, Jean-Louis Dupond wrote:
> When we for example have a sparse qcow2 image and discard: unmap is enabled,
> there can be a lot of fragmentation in the image after some time. Especially on VM's
> that do a lot of writes/deletes.
> This causes the qcow2 image to grow even over 110% of its virtual size,
> because the free gaps in the image get too small to allocate new
> continuous clusters. So it allocates new space at the end of the image.
>
> Disabling discard is not an option, as discard is needed to keep the
> incremental backup size as low as possible. Without discard, the
> incremental backups would become large, as qemu thinks it's just dirty
> blocks but it doesn't know the blocks are unneeded.
> So we need to avoid fragmentation but also 'empty' the unneeded blocks in
> the image to have a small incremental backup.
>
> In addition, we also want to send the discards further down the stack, so
> the underlying blocks are still discarded.
>
> Therefor we introduce a new qcow2 option "discard-no-unref".
> When setting this option to true, discards will no longer have the qcow2
> driver relinquish cluster allocations. Other than that, the request is
> handled as normal: All clusters in range are marked as zero, and, if
> pass-discard-request is true, it is passed further down the stack.
> The only difference is that the now-zero clusters are preallocated
> instead of being unallocated.
> This will avoid fragmentation on the qcow2 image.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2-cluster.c | 32 ++++++++++++++++++++++++++++----
>   block/qcow2.c         | 18 ++++++++++++++++++
>   block/qcow2.h         |  3 +++
>   qapi/block-core.json  | 12 ++++++++++++
>   qemu-options.hx       | 12 ++++++++++++
>   5 files changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 39cda7f907..1f130c6ab9 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1894,6 +1894,7 @@ again:
>       return 0;
>   }
>   
> +
>   /*
>    * This discards as many clusters of nb_clusters as possible at once (i.e.
>    * all clusters in the same L2 slice) and returns the number of discarded

Was adding this empty line intentional?  (If not, I’d drop it.)

> @@ -1925,6 +1926,9 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>           uint64_t new_l2_bitmap = old_l2_bitmap;
>           QCow2ClusterType cluster_type =
>               qcow2_get_cluster_type(bs, old_l2_entry);
> +        bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
> +                              (s->discard_no_unref &&
> +                               type == QCOW2_DISCARD_REQUEST);

(Sorry I didn’t notice before :/) I think there’s a condition missing 
here, namely `full_discard` (i.e. `&& !full_discard`).  We must set 
`keep_reference` only if we will actually keep the reference, which 
won’t happen when `full_discard` is set.  (Same could be said for 
s->qcow_version < 3, but in that case, `s->discard_no_unref` can’t be true.)

(Not a problem in practice because `type == QCOW2_DISCARD_REQUEST` never 
happens together with `full_discard`, but better be safe than sorry.)

Alternatively...

>           /*
>            * If full_discard is true, the cluster should not read back as zeroes,

[...]

> @@ -1960,8 +1976,16 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>           if (has_subclusters(s)) {
>               set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
>           }
> -        /* Then decrease the refcount */
> -        qcow2_free_any_cluster(bs, old_l2_entry, type);
> +        if (!keep_reference) {

...we could explicitly check here whether the new L2 entry is still 
allocated or not, like

```
QCow2ClusterType new_cluster_type =
     qcow2_get_cluster_type(bs, new_l2_entry);

if (!qcow2_cluster_is_allocated(new_cluster_type)) {
     /* Decrease the refcount if the cluster has been deallocated */
     qcow2_free_any_cluster(...);
} else if (s->discard_passthrough[type] &&
            qcow2_cluster_is_allocated(cluster_type)) {
     /* If we keep the reference, pass on the discard still */

     /* Discard must always produce zero-reading clusters */
     assert(new_cluster_type == QCOW2_CLUSTER_ZERO_ALLOC);
     /* Compressed clusters will never remain allocated */
     assert(cluster_type != QCOW2_CLUSTER_COMPRESSED);

     bdrv_pdiscard(...);
}
```

Just an idea, though, I understand if you’d rather not modify the patch 
further.

> +            /* Then decrease the refcount */
> +            qcow2_free_any_cluster(bs, old_l2_entry, type);
> +        } else if (s->discard_passthrough[type] &&
> +                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
> +                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +            /* If we keep the reference, pass on the discard still */
> +            bdrv_pdiscard(s->data_file, new_l2_entry & L2E_OFFSET_MASK,
> +                          s->cluster_size);

I mentioned this briefly on IRC, might have gone under the radar; I 
think using `old_l2_entry` is better than `new_l2_entry`.  In practice, 
there shouldn’t be a difference, but I think it’s slightly cleaner to 
free based on the old entry than have this be based on the new one.

(Also, in case we did mess up, like in the hypothetical case above where 
`keep_reference` is true while `full_discard` is also true, using 
`old_l2_entry` means we’ll just accidentally discard the old cluster 
(the accident is merely to discard the cluster instead of decrementing 
its refcount), instead of discarding a completely wrong cluster (the 
image header, with `new_l2_entry = 0`).)

Rest looks good to me!

Hanna


