Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD78788B60
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 16:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZXZm-0006L7-VR; Fri, 25 Aug 2023 10:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXZk-0006IJ-9B
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXZi-0003HD-3i
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692972849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1reuRlzShh6ovvJwPdq/llsAGMcRXrlEHztEXoTMo8=;
 b=WKH6oJZnSxzv0sLC1M1VWtP2apOO5aa0WCmS38HeePymA1CFmv4S83gFwO/5UtkjW1VqTZ
 jUgfAeZx0AefQCeXWx75FqfWLuXJyG/T6M352ZVsJnMQQcp/bu1ctoCIHq8ZO9HwKXJSS6
 K/TK0Fw4Q8ME4p/Hgzcz8SqWmRdKT58=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-vmXw68xFMF6Er81QuZxfdg-1; Fri, 25 Aug 2023 10:14:08 -0400
X-MC-Unique: vmXw68xFMF6Er81QuZxfdg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso77277266b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 07:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692972847; x=1693577647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g1reuRlzShh6ovvJwPdq/llsAGMcRXrlEHztEXoTMo8=;
 b=AdVe11mhw/yrlCp1diwn5l8c+u5l76YhebwXDVSuKw1V3F/lBcURXImbsyGdzodj2k
 QMDJoHRHEpn0k3pZQtefIPvarkq+m2sTD7/eHq2L58HLz8b5HVZycay3p69QlcyKcFBF
 HnPf3JbBhYyGsH80StYQwBjDxotJEY8Bxr9uBeDnDxgjlIfEtt9ErQvo8JJUvtYyZg3y
 YHbwMp18lIxCJv+97UkWqvGj7s8GYNfuOIKsmOWnyN9SpfB7xHylAQLZ9rkQatTG0LPn
 Y0DCRVY9Iy5TyoOPGvlR29WVr63d5RsPnY82IHb28Vb/OLFCvkUs5WEAbvTx98wInSxU
 lL+Q==
X-Gm-Message-State: AOJu0YyhElpnkCuFaNRa7dY3cr0KabYhdFCYLdGwwO9+JLoYM7L0/yj2
 ykUWYl71LAMBa3ZQFoIeMBA01UikcFdnOvmoiejiHBG8yLJAHw487grR9871cP/TjXNHSeF0evX
 MEBNuohXV1quZPbQ=
X-Received: by 2002:a17:906:76d7:b0:9a1:bfdc:2d5d with SMTP id
 q23-20020a17090676d700b009a1bfdc2d5dmr7656048ejn.41.1692972847102; 
 Fri, 25 Aug 2023 07:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHCuRQPmr2Mjx5uJd7YxpSXUtsvuVkWyvLgUgk2km6iibhLwNTRd9oJdx3gJ565EvLy+Zlig==
X-Received: by 2002:a17:906:76d7:b0:9a1:bfdc:2d5d with SMTP id
 q23-20020a17090676d700b009a1bfdc2d5dmr7656038ejn.41.1692972846811; 
 Fri, 25 Aug 2023 07:14:06 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a17090655c100b0098cf565d98asm1008072ejp.22.2023.08.25.07.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 07:14:06 -0700 (PDT)
Message-ID: <ada340d8-8ac1-9817-6d58-0da60a601637@redhat.com>
Date: Fri, 25 Aug 2023 16:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] qemu-img: map: report compressed data blocks
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <20230706163047.128999-3-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230706163047.128999-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 06.07.23 18:30, Andrey Drobyshev wrote:
> Right now "qemu-img map" reports compressed blocks as containing data
> but having no host offset.  This is not very informative.  Instead,
> let's add another boolean field named "compressed" in case JSON output
> mode is specified.  This is achieved by utilizing new allocation status
> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qapi/block-core.json |  7 +++++--
>   qemu-img.c           | 16 +++++++++++++---
>   2 files changed, 18 insertions(+), 5 deletions(-)

Patch 3 must be merged into this patch.  Every test must pass on every 
commit so we don’t break bisecting.

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5dd5f7e4b0..b263d2cd30 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -409,6 +409,9 @@
>   #
>   # @zero: whether the virtual blocks read as zeroes
>   #
> +# @compressed: true indicates that data is stored compressed.  Optional,
> +#     only valid for the formats whith support compression

This is missing information for when this field was introduced (i.e. a 
“(since 8.2)”).

I also wonder why this field is optional.  We have compression 
information even for formats that don’t support compression, 
specifically, nothing is compressed.  I would just make this field 
mandatory and print it always.  (A technical reason to do so is that 
this patch uses block_driver_can_compress() to figure out whether there 
is compression support; but that function only tells whether the driver 
can write compressed data.  Even if it cannot do that, the format may 
still support compression, and the driver may be able to read compressed 
data, just not write it.)

Hanna

> +#
>   # @depth: number of layers (0 = top image, 1 = top image's backing
>   #     file, ..., n - 1 = bottom image (where n is the number of images
>   #     in the chain)) before reaching one for which the range is
> @@ -426,8 +429,8 @@


