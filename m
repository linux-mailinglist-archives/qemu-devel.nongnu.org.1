Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D2B781E5E
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjpq-0007Rv-Hi; Sun, 20 Aug 2023 10:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjpo-0007Rk-NK
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:55:20 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjpm-0003sw-FN
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:55:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68a41031768so83595b3a.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692543316; x=1693148116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hw8Ocz2z6zeSozNqPuULEet/XqgWkUfKwoh2hGFCX0k=;
 b=RFdHk3Dxd8xNWhu0XTW0tRHIxcCQxZJUR4nw49vA8GRZT1pvCnhwiEg7H3/uMDNmYi
 P27Ac4cTW91Zsh0Qln2EC+OVw2ywOuverof77nQ4mxQ64ojBSCuBdkI585ty6tHXrezo
 gIiBaShaAa8e+waUjbFk/r/rhVlgBh4oxNqKoJEmNB2paGWaQj2s9hqrIX2Rq/FbiRhP
 9gfYIhYAMO7GdqiJ8xHboF7pf5Q9jI7GTljQ2VAWwRsbofLn12DaFg0M8E1WgMm7RTMw
 rljDNayY9E9vVZrMbXQAkp1JGw72eLgtgQ0UWgBd7bxitOCNXO4zYGDzZ4rdUOpe3Pfg
 mYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692543316; x=1693148116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hw8Ocz2z6zeSozNqPuULEet/XqgWkUfKwoh2hGFCX0k=;
 b=UyiwgcXvpJ3Og30CoE5Ym412afIVPM93gHqmzkBM0QO4uLh1u2YqV/tM/ekVrsQNdr
 dm9mrvdR5LVkkgjYOOnwLQ/KUti5xqBel8D6stS9VMFy0YxsQI5vISTbB8Bkm0XPwvRD
 ok8b8CZxEDNZeO/q6C4o2LJIbGajYJmDRmb4WnpLXURDhXKoeljqaDyM26aDXzE3Hlmy
 AB9i7eq2eZASZ1Fh1PgqcZce422YCUyc5XaQ04EACzr/MJRQJuKqRHB7Gzgm9/0TqWcg
 eFhh/4VwPNqQx/Nk9hh3vELSVwT3BuGhJWMtRkwex2iUlV5A/Aln2xhg+20+zt85g+C3
 ZkPQ==
X-Gm-Message-State: AOJu0YycMwMLkA8LoFhIJf7hxaSn1/9avQyy6b/ibHK052DlD2eSr4ss
 aNCjX75a6SNveD2nuq5I4pSXAA==
X-Google-Smtp-Source: AGHT+IFaJNi87bKf7Q3PkFeYpHJX3MugdrcXy+D75UvGnMUpcsh4660gkPWGtQeP2ZMg/adlVsaGpg==
X-Received: by 2002:a05:6a20:8e01:b0:13e:b7e9:1a71 with SMTP id
 y1-20020a056a208e0100b0013eb7e91a71mr3451178pzj.14.1692543316667; 
 Sun, 20 Aug 2023 07:55:16 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 2-20020a170902e9c200b001a6d4ea7301sm5174505plk.251.2023.08.20.07.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:55:16 -0700 (PDT)
Message-ID: <cf5468f9-32fc-4e6c-a0ad-5e87b578bcb5@linaro.org>
Date: Sun, 20 Aug 2023 07:55:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/22] Implement mincore(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-17-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-17-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:48, Karim Taha wrote:
> +/* mincore(2) */
> +static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
> +        abi_ulong target_vec)
> +{
> +    abi_long ret;
> +    void *p, *a;
> +
> +    a = lock_user(VERIFY_WRITE, target_addr, len, 0);
> +    if (a == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    p = lock_user_string(target_vec);
> +    if (p == NULL) {
> +        unlock_user(a, target_addr, 0);
> +        return -TARGET_EFAULT;
> +    }
> +    ret = get_errno(mincore(a, len, p));
> +    unlock_user(p, target_vec, ret);
> +    unlock_user(a, target_addr, 0);
> +
> +    return ret;

This is wrong.

(1) VERIFY_WRITE is incorrect.  Here you need a combination of guest_range_valid_untagged 
and page_check_range(addr, len, PAGE_VALID).

(2) vec is not a string, it is an array of size DIV_ROUND_UP(len, TARGET_PAGE_SIZE).  For 
that, you do want lock_user(VERIFY_WRITE).


r~

