Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A97203FE
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55SR-0002bd-6r; Fri, 02 Jun 2023 10:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q55SP-0002b3-7X
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q55SN-0005y2-II
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685714922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VldGy/qKU9Dqm6mr44wg5YAiQnTcmyUwVJrhnkXiYGU=;
 b=AtmBQE+V3CWM8G6cwO2eTb2LJvgjfdinlXvaOED4P9VI32PGrp2vxDdTEdG+gNup2EQQ4s
 TYtjXbkf6umkHKzstB9wuY0fQpNTG3WnZIyD4lekKi7Q8nuUIDrzkPwwMTO9+x2jbTq8OS
 kqWqz0M6vrvJ6fbY7qHeRd5vUS7eI3E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-QB_qPAIKNAqzFUGkV0La6Q-1; Fri, 02 Jun 2023 10:08:41 -0400
X-MC-Unique: QB_qPAIKNAqzFUGkV0La6Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-97542592eb9so25137966b.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685714920; x=1688306920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VldGy/qKU9Dqm6mr44wg5YAiQnTcmyUwVJrhnkXiYGU=;
 b=E/B34feSRthwC1ay6lFdxMTYo48wcrrWmNNqKV1HcecV+bcGE04ROb75OQpcPNKSlr
 meq6/p82u+CzBIETLe2ZhKBOLXtgFkgFLDMkxxmtBq6ptDfEJ2uycf2FgvdOycArUfpM
 LAaC5zeqvmGogihxIJhXax2yydPI0w5MbeMNmRHDhAgsEHpDzxnLmXH2t7wcsqkRXQQ+
 yxs9Omnoz5QsC5v1/7eaBtN52/GFybjKaXgx2h6U50FkO/7A20yOWgA89V06xcGwjwyu
 x7StikPGiULPKIQNbf4UHJoS0DKHpTfSAk7N2ahIuyJE7dQFGnu0XwiVF8ZMZiQoBzHG
 9RKw==
X-Gm-Message-State: AC+VfDwjghcBt22kpMkeYhw8Sg6SVT5DUJTul7zS5vTFDBbPFzHaNLSt
 HF+0/HT6iEz9oT3oRM0uBfpPw/FIEzX4WBhKBODaJNTd4gL9PHQfzQzc63lzpyZjMRGnZJIKGp6
 j8+4RdmvkzeS6zu4=
X-Received: by 2002:a17:907:928d:b0:96f:bc31:5e1c with SMTP id
 bw13-20020a170907928d00b0096fbc315e1cmr11340261ejc.47.1685714919313; 
 Fri, 02 Jun 2023 07:08:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Rox1gU/zfGFqvRp3xm0rRLJ3M9g2jYt+7gFX5/RRAsdN8LLBBVvu6sHVfueQnsyb4X0o/5w==
X-Received: by 2002:a17:907:928d:b0:96f:bc31:5e1c with SMTP id
 bw13-20020a170907928d00b0096fbc315e1cmr11340240ejc.47.1685714918923; 
 Fri, 02 Jun 2023 07:08:38 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:e1ec:6307:c799:c188?
 (p200300cfd72ef7e0e1ec6307c799c188.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:e1ec:6307:c799:c188])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a170906960200b00965b2d3968csm802910ejx.84.2023.06.02.07.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 07:08:38 -0700 (PDT)
Message-ID: <db062a52-3ee2-2f9b-7ef6-8c7e28e4e217@redhat.com>
Date: Fri, 2 Jun 2023 16:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/5] parallels: Split image leak handling to separate
 check and fix helpers
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-3-alexander.ivanov@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230529151503.34006-3-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 29.05.23 17:15, Alexander Ivanov wrote:
> We need to fix leak after deduplication in the next patch. Move leak
> fixing to a separate helper parallels_fix_leak() and add
> parallels_get_leak_size() helper wich used in parallels_fix_leak() and
> parallels_check_leak().
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 86 +++++++++++++++++++++++++++++++++--------------
>   1 file changed, 61 insertions(+), 25 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 1ec98c722b..64850b9655 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -482,43 +482,79 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
>       return 0;
>   }
>   
> +static int64_t parallels_get_leak_size(BlockDriverState *bs,
> +                                       BdrvCheckResult *res)
> +{
> +    int64_t size;
> +
> +    size = bdrv_getlength(bs->file->bs);
> +    if (size < 0) {
> +        return size;
> +    }
> +
> +    /*
> +     * Before any usage of this function, image_end_offset has to be set to the
> +     * the highest offset in the BAT, excluding out-of-image offsets.
> +     */
> +    assert(size >= res->image_end_offset);

If `high_off == 0` in parallels_check_outside_image(), it will use 
s->data_end to determine image_end_offset, which is originally read from 
the image header.  I don’t see any place where we ensure that 
`s->data_end <= bdrv_getlength(bs->file->bs)`, so can we be certain the 
assertion holds even in that case?

> +
> +    return size - res->image_end_offset;
> +}
> +
> +static int parallels_fix_leak(BlockDriverState *bs,
> +                              BdrvCheckResult *res)
> +{
> +    Error *local_err = NULL;
> +    int64_t size;
> +    int ret;
> +
> +    size = parallels_get_leak_size(bs, res);
> +    if (size <= 0) {
> +        return size;
> +    }
> +
> +    /*
> +     * In order to really repair the image, we must shrink it.
> +     * That means we have to pass exact=true.
> +     */
> +    ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
> +                           PREALLOC_MODE_OFF, 0, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>   static int coroutine_fn GRAPH_RDLOCK
>   parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>                        BdrvCheckMode fix)
>   {
>       BDRVParallelsState *s = bs->opaque;
> -    int64_t size;
> +    int64_t count, leak_size;
>       int ret;
>   
> -    size = bdrv_getlength(bs->file->bs);
> -    if (size < 0) {
> +    leak_size = parallels_get_leak_size(bs, res);
> +    if (leak_size < 0) {
>           res->check_errors++;
> -        return size;
> +        return leak_size;
> +    }
> +    if (leak_size == 0) {
> +        return 0;
>       }
>   
> -    if (size > res->image_end_offset) {
> -        int64_t count;
> -        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
> -        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
> -                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
> -                size - res->image_end_offset);
> -        res->leaks += count;
> -        if (fix & BDRV_FIX_LEAKS) {
> -            Error *local_err = NULL;
> +    count = DIV_ROUND_UP(leak_size, s->cluster_size);
> +    res->leaks += count;
> +    fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
> +            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak_size);
>   
> -            /*
> -             * In order to really repair the image, we must shrink it.
> -             * That means we have to pass exact=true.
> -             */
> -            ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
> -                                   PREALLOC_MODE_OFF, 0, &local_err);
> -            if (ret < 0) {
> -                error_report_err(local_err);
> -                res->check_errors++;
> -                return ret;
> -            }
> -            res->leaks_fixed += count;
> +    if (fix & BDRV_FIX_LEAKS) {
> +        ret = parallels_fix_leak(bs, res);
> +        if (ret < 0) {
> +            return ret;

We used to increment res->check_errors here – should we still do that?

Hanna

>           }
> +        res->leaks_fixed += count;
>       }
>   
>       return 0;


