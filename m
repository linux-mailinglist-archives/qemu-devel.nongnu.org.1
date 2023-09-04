Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB6791326
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:19:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4mq-0006V1-It; Mon, 04 Sep 2023 04:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4mn-0006Ty-RS
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:18:17 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4mk-0000Nk-S2
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:18:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so1567027a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693815493; x=1694420293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3xCVXbAhA7uHrZL2+u340yjZefRYEXr3ysXMcUTJAJU=;
 b=MOKAH4JsjaRb6UQ5r7fr9lW+tbcY/8rDHEzbYfRQx4sq8vgtlYvoRoywxbseFod81m
 qTABh/ClBr7cTtpk8JG5Sw2P64OpKvBIORhymyj3nOMLaOVFp5EUH67iBDPJG2FX/JpK
 tGyGVvsTwAbQAozOELH1uvOzdtynb/tFr6PuxO+a7VQoe2vYjIqaQ8l2TfnbExeb29qB
 P6abcSlC95dueucHcaTIr4VXvitu7BGvfNrJZ1H69rjAgJpstbw7P6CRWFpXJPpiMmed
 TXxTdVsqPOZRua1/tJokElENqbTX8TZyEf8xOnN7C8JXS6ZrhzDJlBvXt4UFP3m4HHfs
 qfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693815493; x=1694420293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3xCVXbAhA7uHrZL2+u340yjZefRYEXr3ysXMcUTJAJU=;
 b=CVeuU1z1BixVqoClyCofNdE72ZWHL5+EyLP0hFCUm7ubeU4HrhsOu28mjsHyyOG+34
 kRFEAoG+lj6fz0Fypw/Sp2B1NAlgIX/oqz32nVhtLMLSQU7xf/G5klZAe9UGBUqD8Ywh
 8siFmKJ2jHd08guIE/Ga+Va7OyrtqGNC0+g9T52VPMi0LKF4VeHlBpsI7W8+IpTNTmRe
 AYIh54LXySRPEoptW6x90zbdT2dslY3+8W9W1uwy+xBEf23eJZbnrkAgo9/PALfVveLS
 Vr6Jwussk9YRpWKt8JuLdNJTDaPWPEDffm7+7fZqZES5Fih06FKQMGPipYXdeUkeiHui
 sa7A==
X-Gm-Message-State: AOJu0Yy2RiVlQoZufc40FIIcSMRa01gcfALWqP4lwOydX75NOopemcQS
 N2DAf1dYWTz2RCnOaTJO9al1Sw==
X-Google-Smtp-Source: AGHT+IELcYYtxWL3rF0k9otwbbPb2wZIrip7qaNXBM2FkfA5B6wSuixMHP5J6w436Z5tkb3zkfZXhw==
X-Received: by 2002:a05:6402:2027:b0:522:b112:6254 with SMTP id
 ay7-20020a056402202700b00522b1126254mr5927067edb.4.1693815493181; 
 Mon, 04 Sep 2023 01:18:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa7d5c3000000b005232ea6a330sm5550179eds.2.2023.09.04.01.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:18:12 -0700 (PDT)
Message-ID: <91d32bd0-73bf-ee50-ccd1-bd010a4263cc@linaro.org>
Date: Mon, 4 Sep 2023 10:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 06/13] range: Introduce range_inverse_array()
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-7-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904080451.424731-7-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/9/23 10:03, Eric Auger wrote:
> This helper reverses an array of regions, turning original
> regions into holes and original holes into actual regions,
> covering the whole UINT64_MAX span.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/qemu/range.h |  3 +++
>   util/range.c         | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index 7e2b1cc447..fc1d3dabe6 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -219,4 +219,7 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
>   
>   GList *range_list_insert(GList *list, Range *data);
>   
> +void range_inverse_array(uint32_t nr_ranges, Range *ranges,
> +                         uint32_t *nr_inv_ranges, Range **inv_ranges);
> +
>   #endif
> diff --git a/util/range.c b/util/range.c
> index 098d9d2dc0..11c4ff0b78 100644
> --- a/util/range.c
> +++ b/util/range.c
> @@ -70,3 +70,38 @@ GList *range_list_insert(GList *list, Range *data)
>   
>       return list;
>   }
> +
> +/*
> + * Inverse an array of sorted ranges over the UINT64_MAX span, ie.
> + * original ranges becomes holes in the newly allocated inv_ranges
> + */

Most of the functions are described in the header; could you move this
description with the declaration?

> +void range_inverse_array(uint32_t nr_ranges, Range *ranges,
> +                         uint32_t *nr_inv_ranges, Range **inv_ranges)
> +{
> +    Range *resv;
> +    int i = 0, j = 0;
> +
> +    resv = g_malloc0_n(nr_ranges + 1, sizeof(Range));
> +
> +    /* first range lob is greater than 0, insert a first range */
> +    if (range_lob(&ranges[0]) > 0) {
> +        range_set_bounds(&resv[i++], 0,
> +                         range_lob(&ranges[0]) - 1);
> +    }
> +
> +    /* insert a range inbetween each original range */
> +    for (; j < nr_ranges - 1; j++) {
> +        if (range_compare(&ranges[j], &ranges[j + 1])) {
> +            range_set_bounds(&resv[i++], range_upb(&ranges[j]) + 1,
> +                             range_lob(&ranges[j + 1]) - 1);
> +        }
> +    }
> +    /* last range upb is less than UINT64_MAX, insert a last range */

In order to use this new function with variable range sizes,
can we pass UINT64_MAX as an 'inv_range_upb' argument?

> +    if (range_upb(&ranges[nr_ranges - 1]) <  UINT64_MAX) {
> +        range_set_bounds(&resv[i++],
> +                          range_upb(&ranges[nr_ranges - 1]) + 1, UINT64_MAX);
> +    }
> +    *nr_inv_ranges = i;
> +    resv = g_realloc(resv, i * sizeof(Range));
> +    *inv_ranges = resv;
> +}


