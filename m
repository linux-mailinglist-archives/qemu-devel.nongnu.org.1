Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8D7E05CA
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:54:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywUY-0007jf-6D; Fri, 03 Nov 2023 11:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qywUX-0007jU-2i
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qywUV-0001sp-Jx
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699026826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cz+kOhgGJhxRhD0k72Py/6L+FET/s8jHzb9cLegIIHg=;
 b=MYPJeIIQK+AMYb3qIACjNR0nOZjEft1FgJtidG/P10M4upIzwVH72KH+Gv9NJAtjIhHjod
 6nInMDWoLVodAK5U6rW5FYYTuvi0SFPRKoI9528vlYobayHt5dvOUYYgBKhvesUzX1hbWo
 KkQSzckOk57vHrbJ3YXirMcpap2H4XQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-lVTlS6rHMVyTRG2oVzXGrQ-1; Fri, 03 Nov 2023 11:53:43 -0400
X-MC-Unique: lVTlS6rHMVyTRG2oVzXGrQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so14306075e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699026822; x=1699631622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cz+kOhgGJhxRhD0k72Py/6L+FET/s8jHzb9cLegIIHg=;
 b=wnEf8AXs5rL5y7LdKlAKeiJOdSXeuamFLMdHG9ASo9lfDCg+FkR1Tut+QhbIADyUoU
 v8jgWbWuLjyldKl8tBBnC2j1DdLyIYgB+KB8nJmaHSWZMdrZJjcuhMboATx/xVGmpf3X
 KUbenqkvCME9ZAioC472Qk+N27zTYWnd77WYO8BhXVwSDwPIDOmULXLOpkZgwFRYbe94
 iuFaDoezhM3mZIp0BrlnwR6TxmA5170PqujOJc5IbJLoKKfobQdPjrqz1CJlCB1A4usO
 aWQPVdTX+9IjtN7vgic3lrDUNP4IXWrgNSBCxKt/1gjBp3YzJS8acdKKX3imhsETckDd
 myOw==
X-Gm-Message-State: AOJu0YwD/trkCk9YJRCEYXfwTZHYAbUET1m2FqMJqairTFLMbW3Zid0I
 8gLQlVShG4GW5ewLXQqs6IUvqQ7EyP+RB8kt1a6IlVv/uv5OXGQZbto6/+9B4ZINR7CHUMRRFSc
 E0uZGM5nlNam65Nw=
X-Received: by 2002:a05:600c:450a:b0:405:3a3b:2aa2 with SMTP id
 t10-20020a05600c450a00b004053a3b2aa2mr18523277wmo.37.1699026821883; 
 Fri, 03 Nov 2023 08:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw1YJpokaHMZS8lhHmHUIlVheXwQJHOogTNF39kR7P7WQRhktwP8ukC6zdoKH9S+qGV5RQBw==
X-Received: by 2002:a05:600c:450a:b0:405:3a3b:2aa2 with SMTP id
 t10-20020a05600c450a00b004053a3b2aa2mr18523265wmo.37.1699026821605; 
 Fri, 03 Nov 2023 08:53:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a7bcc15000000b0040773c69fc0sm2842418wmh.11.2023.11.03.08.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 08:53:40 -0700 (PDT)
Message-ID: <034202b3-e028-4d46-9c2e-cb2782798f13@redhat.com>
Date: Fri, 3 Nov 2023 16:53:39 +0100
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
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

scri.l2_slice is leaked here.

Hanna


