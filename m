Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAB776444
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:44:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTlM7-0003OX-4L; Wed, 09 Aug 2023 11:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlLx-0003OB-Dp
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:44:06 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlLv-0005i7-Ue
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:44:05 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6874d1c8610so5056996b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691595842; x=1692200642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uRayGt/7vBZvSFOt01c82DNlfu/weLIxDRhQzRS0KMg=;
 b=NtMWRySJ6DzpgC8nRGwgB4j68oKTwLe4mvYmf+Se5GPVhq4Cz+pzlzw1H8KS//wgqe
 kdUD8BjR0k9e+XFRxs75xGtkyY6MD5YHD/eotWOZQfImSfKD31f3Co91ph9MiLxde+b5
 18Oq5QsLRRyUZvWLxxYUMHRsZAMmA9NE+wgx0iq6ORn/hqyn06LrF1z8L3tAHu55iEhi
 648tL5H7dDBz/ciiz5BgZ11LhIhR567uBa6yTXbbwGECeVw8NpRRRawSzZhpzWHzKaph
 5EP29ACxgv2PVLVeW9gBSKj39AavNqL80MR7MHjpoFe9HRxTDJR9tz5HvSWELzYvnEvv
 cjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691595842; x=1692200642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uRayGt/7vBZvSFOt01c82DNlfu/weLIxDRhQzRS0KMg=;
 b=bwhiTDPUCyGiNBs1xYjzlDiRObY18Xvc/LTcjgnazzbTWBmv3V5gFNkDVY6Yct0Vu/
 gH62kNo6dAc9noGweP4Q5PS5jFqKhowfl1pja0abw/vozZumd3FohDUsppGiliWGo+6d
 pujYX3TZD8ZL94afSxSBwOpVD6tZmJz6C1RWT7eIJu90lnQxOVA2Zy6MwhZDFed6NHcM
 Zu/rFLaqq0ZXa/9E/WV6tHg64CVCtzwgn40XZhcEOOWOndU3gj6iMoBhXKejvvCuZ1GU
 DCaKKJAGFaWoq0HVkToi0MpKa0BxxswNnf+zIAW0e2W+CTVvqAMZYFLfVd1zUY8ecKhY
 IDHw==
X-Gm-Message-State: AOJu0YxdlV08rP0yvNZCke6A4TdIg8m9tkiXTC9lWm5xbgqVA+tngc2N
 hBTSb5M4Oo/cv2l6bK3GTowpOg==
X-Google-Smtp-Source: AGHT+IHNa7Mc9Od+rWnGkxwnsIMqSk9AjL8N4sKhtqxgSoKhWMv1bUDmmI8jpPEErbb456qYazFxCA==
X-Received: by 2002:a05:6a00:2d05:b0:686:6e90:a99b with SMTP id
 fa5-20020a056a002d0500b006866e90a99bmr3222764pfb.25.1691595842429; 
 Wed, 09 Aug 2023 08:44:02 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 k24-20020aa790d8000000b006829b28b393sm10026956pfk.199.2023.08.09.08.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 08:44:01 -0700 (PDT)
Message-ID: <474ba745-4501-da43-91b2-fa757ec0b240@linaro.org>
Date: Wed, 9 Aug 2023 08:44:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v4 03/11] linux-user: Implement envlist_appendenv and add
 tests for envlist
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-4-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808141739.3110740-4-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/8/23 07:17, Yeqi Fu wrote:
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>   include/qemu/envlist.h    | 13 ++++++
>   tests/unit/meson.build    |  1 +
>   tests/unit/test-envlist.c | 94 +++++++++++++++++++++++++++++++++++++++
>   util/envlist.c            | 71 ++++++++++++++++++++++++-----
>   4 files changed, 169 insertions(+), 10 deletions(-)
>   create mode 100644 tests/unit/test-envlist.c
> 
> diff --git a/include/qemu/envlist.h b/include/qemu/envlist.h
> index 6006dfae44..9eb1459e79 100644
> --- a/include/qemu/envlist.h
> +++ b/include/qemu/envlist.h
> @@ -1,12 +1,25 @@
>   #ifndef ENVLIST_H
>   #define ENVLIST_H
>   
> +#include "qemu/queue.h"
> +
> +struct envlist_entry {
> +    const char *ev_var;            /* actual env value */
> +    QLIST_ENTRY(envlist_entry) ev_link;
> +};
> +
> +struct envlist {
> +    QLIST_HEAD(, envlist_entry) el_entries; /* actual entries */
> +    size_t el_count;                        /* number of entries */
> +};
> +

Why are you exposing the structures?

> +static void envlist_parse_set_unset_test(void)
> +{
> +    envlist_t *testenvlist;
> +    const char *env = "TEST1=123,TEST2=456";
> +
> +    testenvlist = envlist_create();
> +    g_assert(envlist_parse_set(testenvlist, env) == 0);
> +    g_assert(testenvlist->el_count == 2);
> +    g_assert(envlist_parse_unset(testenvlist, "TEST1,TEST2") == 0);
> +    g_assert(testenvlist->el_count == 0);

If it's just for the count, then add an envlist_length() function.


r~

