Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A57E0572
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:21:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyvxE-0003rI-QU; Fri, 03 Nov 2023 11:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qyvx9-0003p8-4s
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qyvx7-0002Ni-8o
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699024754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j7G//Yqvkc297t4X3C2t+/eaRmwdrvmpAHiV91z+l08=;
 b=d7XyvfiOqlFvPiQeqVrWYfCe27rtM/zsYdnnOrmnA99WEsK9QD/bCBsy/YOB3lK9o+B0+L
 Eutf11nZ50Ydz42pGNHcAJ13mV/9UpPPFo3nqKqwoW2y6LWNN368NGeTYEWzQp+jA7C383
 NHHGY4wh9hdp7WAjoiA968uLqcHlDnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-gkGQbSr4PZWzCLWxkr8WsA-1; Fri, 03 Nov 2023 11:19:12 -0400
X-MC-Unique: gkGQbSr4PZWzCLWxkr8WsA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32f7cf9c33bso1101241f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699024752; x=1699629552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j7G//Yqvkc297t4X3C2t+/eaRmwdrvmpAHiV91z+l08=;
 b=kDxs5Tdkh3CeiAyxK5ve8LjcMgKP2SdRleiCGijPE+vBmtrDsOMPNoUYb7UTZLvKY6
 rw5UgG1/gxcx+ThoDGIqHyJ6pJXAekiQ5+nqL31anToJEWRgHnNJ9UORiRSgRQ826VwG
 b2vOgg21AiaJcako2Opy2PAhPMcIrxcfOHiKb75V1hQ79cGTsBmFnzOCseNQVRKd612H
 49dqlTX0hTqK4YEnQW+pxU7eBx9LU28CeMqGEHtC0EVMMDTzWduw5L8J1GnOnqG0a/Yf
 tx7l4LviqG7S7cEKNbeOpPs/a1FkXzP+uHqgn2mmYWMbFBThLjFauvZ1BxtU0WHuWU78
 j+pw==
X-Gm-Message-State: AOJu0YxmoSsBG0o/n3+iMb1S+oEWKv7gdSJ3FhWOnKO644Z2XApTHCdh
 m5tx0PMIydV/PVfKpD/Y9RJ7yjyiKn6Lxl9p6dAlw3VisXcPhhq3gMMqywOCzvbcK2/GfEsupUh
 T7fGImsr2T7TytH0=
X-Received: by 2002:a5d:588a:0:b0:32f:b1ab:ee87 with SMTP id
 n10-20020a5d588a000000b0032fb1abee87mr3740833wrf.25.1699024751741; 
 Fri, 03 Nov 2023 08:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsIi1zLs8557C7e8wUltILToLewpVfLbCdzrxT9DQSqkznW0wPcXzl8iMHXATxMPSaGKYRMw==
X-Received: by 2002:a5d:588a:0:b0:32f:b1ab:ee87 with SMTP id
 n10-20020a5d588a000000b0032fb1abee87mr3740820wrf.25.1699024751412; 
 Fri, 03 Nov 2023 08:19:11 -0700 (PDT)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a5d4891000000b0032dbf32bd56sm2088635wrq.37.2023.11.03.08.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 08:19:10 -0700 (PDT)
Message-ID: <2ed4cbd2-cb44-434e-9e02-5a16e086cfed@redhat.com>
Date: Fri, 3 Nov 2023 16:19:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] qcow2: zero_l2_subclusters: fall through to discard
 operation when requested
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-6-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231020215622.789260-6-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

On 20.10.23 23:56, Andrey Drobyshev wrote:
> When zeroizing subclusters within single cluster, detect usage of the
> BDRV_REQ_MAY_UNMAP flag and fall through to the subcluster-based discard
> operation, much like it's done with the cluster-based discards.  That
> way subcluster-aligned operations "qemu-io -c 'write -z -u ...'" will
> lead to actual unmap.

Ever since the introduction of discard-no-unref, I wonder whether that 
is actually an advantage or not.  I can’t think of a reason why it’d be 
advantageous to drop the allocation.

On the other hand, zero_in_l2_slice() does it indeed, so consistency is 
a reasonable argument.

> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index cf40f2dc12..040251f2c3 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2242,7 +2242,7 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>                       unsigned nb_subclusters, int flags)
>   {
>       BDRVQcow2State *s = bs->opaque;
> -    uint64_t new_l2_bitmap;
> +    uint64_t new_l2_bitmap, l2_bitmap_mask;
>       int ret, sc = offset_to_sc_index(s, offset);
>       SubClusterRangeInfo scri = { 0 };
>   
> @@ -2251,9 +2251,10 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>           goto out;
>       }
>   
> +    l2_bitmap_mask = QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);

“l2_bitmap_mask” already wasn’t a great name in patch 4 because it 
doesn’t say what mask it is, but in patch 4, there was at least only one 
relevant mask.  Here, we have two (ALLOC_RANGE and ZERO_RANGE), so the 
name should reflect what kind of mask it is.

>       new_l2_bitmap = scri.l2_bitmap;
> -    new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
> -    new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
> +    new_l2_bitmap |= QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
> +    new_l2_bitmap &= ~l2_bitmap_mask;
>   
>       /*
>        * If there're no non-zero subclusters left, we might as well zeroize
> @@ -2266,6 +2267,16 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>                                   1, flags);
>       }
>   
> +    /*
> +     * If the request allows discarding subclusters and they're actually
> +     * allocated, we go down the discard path since after the discard
> +     * operation the subclusters are going to be read as zeroes anyway.
> +     */
> +    if ((flags & BDRV_REQ_MAY_UNMAP) && (scri.l2_bitmap & l2_bitmap_mask)) {
> +        return discard_l2_subclusters(bs, offset, nb_subclusters,
> +                                      QCOW2_DISCARD_REQUEST, false, &scri);
> +    }

I wonder why it matters whether any subclusters are allocated, i.e. why 
can’t we just immediately use discard_l2_subclusters() whenever 
BDRV_REQ_MAY_UNMAP is set, without even fetching SCRI (that would also 
save us passing SCRI here, which I’ve already said on patch 4, I don’t 
find great).

Doesn’t discard_l2_subclusters() guarantee the clusters read as zero 
when full_discard=false?  There is this case where it won’t mark the 
subclusters as zero if there is no backing file, and none of the 
subclusters is allocated.  But still, (A) those subclusters will read as 
zero, and (B) if there is a problem there, why don’t we just always mark 
those subclusters as zero?  This optimization only has effect when the 
guest discards/zeroes subclusters (not whole clusters) that were already 
discarded, so sounds miniscule.

Hanna

> +
>       if (new_l2_bitmap != scri.l2_bitmap) {
>           set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
>           qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);


