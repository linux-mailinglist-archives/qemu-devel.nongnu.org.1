Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AD27DD1AC
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:34:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrgT-0003yV-3I; Tue, 31 Oct 2023 12:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxrgQ-0003xh-Nz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxrgO-0005B6-UA
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698770016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RflxAKJ/xjhoi4uscHkfanIrJ4da3AfEw+g+UJ9ESbE=;
 b=NeMPLPy39zljAyN0GDCOAZModVPMuhWpECM3Ks/JXIhCK2sn7FEvbyP2OpbH8YeLCurDQ7
 /9vDhFYe9ylo+/Gt/jkCZzyA2WFeKR1/1aNGKllm+jyzK32Ua8M6jHEt9LPrw5IZkirQCa
 KISCfo7lLJ0YgZRZncA1F9r0t44fHuY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-qhxIu0VRPYq_QAotVUOXGQ-1; Tue, 31 Oct 2023 12:33:32 -0400
X-MC-Unique: qhxIu0VRPYq_QAotVUOXGQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408695c377dso42238875e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698770011; x=1699374811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RflxAKJ/xjhoi4uscHkfanIrJ4da3AfEw+g+UJ9ESbE=;
 b=fxTNEoynn6B8K7mcJ3zllo/jrfY0OE2pujBhqzIlNO0Ti8xwMkcydLNZ2InVjmTWC1
 RBjyMSN6AMa25T11yL98EHDN8qWu34sI3AaYCGlYiVh+qqcqkq7Vhq6NC3CKwCjsOK0+
 AjfUgyHgtovTbbgZuLagzkCCwk6hO+JiB9h4vi/OjQp5p+O2E4WX1NF09GIzDKDFMEyv
 uJvCrC+ubxDugaALpAP9PS7NnEDFnQ+MjcuJbABA4q+ootip4G7bQR6qrwb45w7JQ14j
 1wUNfCHr2N21zHZnSOmI3bsHSDjvJLNzj0iO5pKlS7SHJoagGE5tfPI9YNcz6bFpwnss
 X6iw==
X-Gm-Message-State: AOJu0YwokmkapAPdxg2Iz2ztsaBYB+J5Bz2Nkn6uzM+TOjeP6JdnWkZg
 K0xz7clVlDNHzpjI3BwpEKr1JTwJn9ob/gwpwrRdaiI9Lzczs7j0QUXa62OGLydN3jNEUb8IuGB
 kbNxGx1gWy4FyFOU=
X-Received: by 2002:a05:600c:45d3:b0:405:3dd0:6ee9 with SMTP id
 s19-20020a05600c45d300b004053dd06ee9mr10719639wmo.34.1698770011209; 
 Tue, 31 Oct 2023 09:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX5MCROxuBETVSMtk0v0XgZsqoD+FnovPim18sNoOFxt1/fzg3sBKUq+hk+fnqFjUkrvMLRA==
X-Received: by 2002:a05:600c:45d3:b0:405:3dd0:6ee9 with SMTP id
 s19-20020a05600c45d300b004053dd06ee9mr10719625wmo.34.1698770010853; 
 Tue, 31 Oct 2023 09:33:30 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c30d300b003fefaf299b6sm2083441wmn.38.2023.10.31.09.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 09:33:30 -0700 (PDT)
Message-ID: <6ecd944b-0b8d-46b4-8906-3a9cb5511863@redhat.com>
Date: Tue, 31 Oct 2023 17:33:29 +0100
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

(Sorry, opened another reply window, forgot I already had one open...)

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

Allowing to takes this from the caller sounds dangerous, considering we 
need to track who takes care of freeing scri.l2_slice.

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

What if there are subclusters in the cluster that are marked as zero, 
outside of the discarded range?  It sounds wrong to apply a discard with 
either full_discard set or cleared to them.

> +        return discard_in_l2_slice(bs,
> +                                   QEMU_ALIGN_DOWN(offset, s->cluster_size),
> +                                   1, type, full_discard);
> +    }
> +
> +    /*
> +     * Full discard means we fall through to the backing file, thus we only
> +     * need to mark the subclusters as deallocated.

I think it also means we need to clear the zero bits.

Hanna

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


