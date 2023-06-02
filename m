Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A407204C2
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:43:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5609-0007kP-Cf; Fri, 02 Jun 2023 10:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q5606-0007jH-V1
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q5604-0005PO-JO
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685717011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YmDo/PdZCiCxi1AxnPiAzvUiVYawu2Ntk9RXgzo8Mo=;
 b=FmfK6xQ3QyJdytHsdDTaa4M3+PDi9bT1/xQXwmopwEbbFGEInuGOoqUjA1yLFMnZMpkkyL
 jQkZ8n52WoIpqpyWvdKglNalrAq58nCHLe00N7NeJ9AARx4YyTO60XRvdtssMYPSpQkKPT
 mAro+U0eFbMde6fJksBrlxM+rlTXzQc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-qoLlQ3BfOxaAUY-cMwzUXg-1; Fri, 02 Jun 2023 10:43:30 -0400
X-MC-Unique: qoLlQ3BfOxaAUY-cMwzUXg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-974612253c6so70321466b.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685717009; x=1688309009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3YmDo/PdZCiCxi1AxnPiAzvUiVYawu2Ntk9RXgzo8Mo=;
 b=bZu1hEy/gAbsvHTPhjZCAo/TrewRCTq0XAMJWlznHejQp8YyX4HsWDbuV6LoUAM+Mf
 SOIyQhDhhXrUnpTg9WF+g58+zge2DWkdOc0jKx1+TbIXAY3u4ZuKsnRhEBMKwS6/ltrh
 KOKE9ZF9nQvk+W3MTsysGxP+QVh5m3D2Vl8JLGWPE54murMH5pkquORBvS4yetJihd95
 +NCukE/Sts+x3P4Wpq/BvgWcuXKR4mf+B75peMlnCUHSv5t05u5GBJZ1NogCQ0/pGONG
 Ke18CNLTAdf3iKa8J+cSy4Z2XR6uGUWSPd+6pOfVUOPzvPHYuICTVYSCeldv6IbstVCP
 trkA==
X-Gm-Message-State: AC+VfDwcRDy4LKbYfL0WGHz2iyhBxt7tGI1RmHe2JRRCmuDX399++2fm
 O4p0DpYGS3VYSVT/9KX05PGlPj+/s19eSVlWfrdKJgf5LslabiV34n5t5+tLnpJWalsbI2v6W34
 q2xOX11ahJ7OjfaA=
X-Received: by 2002:a17:907:961c:b0:96a:1ee9:4a5 with SMTP id
 gb28-20020a170907961c00b0096a1ee904a5mr13763462ejc.8.1685717009238; 
 Fri, 02 Jun 2023 07:43:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4awbGjnfsPAGz9ao3cn1DFBDQ3YNKv65RklAhV8tM05EBRy3fNNpJhRZxzroCBLL3cXzohfA==
X-Received: by 2002:a17:907:961c:b0:96a:1ee9:4a5 with SMTP id
 gb28-20020a170907961c00b0096a1ee904a5mr13763444ejc.8.1685717008885; 
 Fri, 02 Jun 2023 07:43:28 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:e1ec:6307:c799:c188?
 (p200300cfd72ef7e0e1ec6307c799c188.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:e1ec:6307:c799:c188])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a170906960200b00965b2d3968csm835293ejx.84.2023.06.02.07.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 07:43:28 -0700 (PDT)
Message-ID: <5cbe5958-e47b-8151-9d5e-a9ae0d572d3d@redhat.com>
Date: Fri, 2 Jun 2023 16:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/5] parallels: Add checking and repairing duplicate
 offsets in BAT
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-4-alexander.ivanov@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230529151503.34006-4-alexander.ivanov@virtuozzo.com>
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

On 29.05.23 17:15, Alexander Ivanov wrote:
> Cluster offsets must be unique among all the BAT entries. Find duplicate
> offsets in the BAT and fix it by copying the content of the relevant
> cluster to a newly allocated cluster and set the new cluster offset to the
> duplicated entry.
>
> Add host_cluster_index() helper to deduplicate the code.
>
> Move parallels_fix_leak() call to parallels_co_check() to fix both types
> of leak: real corruption and a leak produced by allocate_clusters()
> during deduplication.

I’m not really a fan of splitting parallels_fix_leak() in this way. One 
problem is that parallels_check_leak() still increments leaks_fixed, 
even though it cannot know whether that will succeed. Would it be a 
problem to move parallels_check_leak() after parallels_check_duplicate()?

> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 138 ++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 133 insertions(+), 5 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 64850b9655..9fa1f93973 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -136,6 +136,12 @@ static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
>       return MIN(nb_sectors, ret);
>   }
>   
> +static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
> +{
> +    off -= le32_to_cpu(s->header->data_off) << BDRV_SECTOR_BITS;
> +    return off / s->cluster_size;
> +}
> +
>   static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
>                               int nb_sectors, int *pnum)
>   {
> @@ -533,7 +539,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>   {
>       BDRVParallelsState *s = bs->opaque;
>       int64_t count, leak_size;
> -    int ret;
>   
>       leak_size = parallels_get_leak_size(bs, res);
>       if (leak_size < 0) {
> @@ -550,16 +555,127 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>               fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak_size);
>   
>       if (fix & BDRV_FIX_LEAKS) {
> -        ret = parallels_fix_leak(bs, res);
> -        if (ret < 0) {
> -            return ret;
> -        }
>           res->leaks_fixed += count;
>       }
>   
>       return 0;
>   }
>   
> +static int parallels_check_duplicate(BlockDriverState *bs,
> +                                     BdrvCheckResult *res,
> +                                     BdrvCheckMode *fix)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    QEMUIOVector qiov;
> +    int64_t off, sector;
> +    unsigned long *bitmap;
> +    uint32_t i, bitmap_size, cluster_index;
> +    int n, ret = 0;
> +    uint64_t *buf = NULL;
> +
> +    /*
> +     * Create a bitmap of used clusters.
> +     * If a bit is set, there is a BAT entry pointing to this cluster.
> +     * Loop through the BAT entries, check bits relevant to an entry offset.
> +     * If bit is set, this entry is duplicated. Otherwise set the bit.
> +     *
> +     * We shouldn't worry about newly allocated clusters outside the image
> +     * because they are created higher then any existing cluster pointed by
> +     * a BAT entry.
> +     */
> +    bitmap_size = host_cluster_index(s, res->image_end_offset);
> +    if (bitmap_size == 0) {
> +        return 0;
> +    }
> +
> +    bitmap = bitmap_new(bitmap_size);
> +
> +    buf = qemu_memalign(4096, s->cluster_size);

There is qemu_blockalign(), which actually uses the BDS’s memory 
alignment, so should be a better fit.

> +    qemu_iovec_init(&qiov, 0);
> +    qemu_iovec_add(&qiov, buf, s->cluster_size);

I don’t think this is necessary, there is bdrv_co_pwrite() that takes a 
buffer.  OTOH, if you want to keep this, you could replace the 
bdrv_co_pread() call by bdrv_co_preadv().

> +
> +    for (i = 0; i < s->bat_size; i++) {
> +        off = bat2sect(s, i) << BDRV_SECTOR_BITS;
> +        if (off == 0) {
> +            continue;
> +        }
> +
> +        cluster_index = host_cluster_index(s, off);
> +        if (test_bit(cluster_index, bitmap)) {

I understand we’ve already ensured that image_end_offset (which 
determines the bitmap size) is large enough, and so this can’t overflow, 
but I could sleep better if there was an `assert(cluster_index < 
bitmap_size);` before this `test_bit()`.

> +            /* this cluster duplicates another one */
> +            fprintf(stderr,
> +                    "%s duplicate offset in BAT entry %u\n",
> +                    *fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
> +
> +            res->corruptions++;
> +
> +            if (*fix & BDRV_FIX_ERRORS) {
> +                /*
> +                 * Reset the entry and allocate a new cluster
> +                 * for the relevant guest offset. In this way we let
> +                 * the lower layer to place the new cluster properly.
> +                 * Copy the original cluster to the allocated one.
> +                 */
> +                parallels_set_bat_entry(s, i, 0);

As far as I understand, this will modify the image content when read.  
Can we perhaps revert this change if there’s an error in bdrv_co_pread() 
or allocate_clusters()?  I understand that a double allocation is a bad 
corruption, but if we can’t fix it because of some unexpected error, I 
feel like it’s better to still keep the image in the same state as 
before rather than having effectively destroyed the data in the 
respective cluster, so users can at least try to fix it by copying it.

> +
> +                ret = bdrv_co_pread(bs->file, off, s->cluster_size, buf, 0);
> +                if (ret < 0) {
> +                    res->check_errors++;
> +                    goto out;
> +                }
> +
> +                sector = (i * (int64_t)s->cluster_size) >> BDRV_SECTOR_BITS;

Both for my own understanding and to maybe suggest a simplification: 
This is the same as `sector = i * (int64_t)s->tracks`, right?

Hanna

> +                sector = allocate_clusters(bs, sector, s->tracks, &n);
> +                if (sector < 0) {
> +                    res->check_errors++;
> +                    ret = sector;
> +                    goto out;
> +                }


