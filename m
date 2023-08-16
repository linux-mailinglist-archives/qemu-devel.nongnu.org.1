Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E7B77E655
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 18:27:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWJM7-000410-8d; Wed, 16 Aug 2023 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWJM3-0003zZ-LD
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:26:43 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWJM0-0005mB-Qh
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:26:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso10422035ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692203199; x=1692807999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LJVpl2kl3+1vfT0KpperyaYzG/cti8RQuVv1LS1pTu0=;
 b=HpqEG8ZABdEAAyKrrslEuwjdJo0did3B0qlQNM1q3vTEJVOLH4bBjEgGa1/I3eul0i
 me7u2znGZ+KlooD5T68190kiT1nqJ+JjOQPRwBZo4w2/EaxVYwYiNyqeiB0X5J+SGBzB
 kbtzo3JeID6zipFgcg+ja7by/y3XUd4Jv5f6jZSqtCYe/A5xgc5hWYvKRAYBE/rwMFN4
 OuKNkrK1MO0+w+qQzQPfK+KnwzrTuEIzaWKima/ILJZNHXehOLKxZ8PmwYST0FhDsxbg
 SFqljA6hiJx1GhFGdew+jk5Bix4HobNu2YSka7m9yQfS8wVfk9J2SKbgkbnIRfTYQ+GC
 yG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692203199; x=1692807999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJVpl2kl3+1vfT0KpperyaYzG/cti8RQuVv1LS1pTu0=;
 b=VniNJvoDMZXvkeHYCRn9jDdLUvSWxkWUoK2dxUZMLexsP59Mx+QLdr69wxajo2qVwo
 1dLBLP4aDYDncaUVExnGl4SV+zQc1x71HwpyGa6iY3EhImCuewZvDNDUTHYTD0Q+TYNg
 1QS4iHghL/Cd1CwHFA59VeRkVHFW6e1LDpzdO62WbAXBTQYOqAXtRZ4+BYy6UbOCCfnf
 0hlunSbJHVxrODG9ElYa7jYXHKwewIH6EwYP1RbMDTHcXjPi2ztZdnJJP19ISSQGn0d9
 t2+HyP33B+98g+F30iAHRD7E81iqwCuFsFSLZsd5JgrvrNWBuITnp6kr9BXDKliBIJ6e
 6ULg==
X-Gm-Message-State: AOJu0YwV3/hFLTnRs/G7Rwe/xeON8q36AIA4yWUD9mc/yrf9qhbfP7of
 7WdiYA3F6+5p5fZj9YTUeY+BFbGDAolPZGH+q/M=
X-Google-Smtp-Source: AGHT+IHnWdXSxP1tvT8sGMmxJiQ0NrjrSZMRDmwjmHADyoqfj9hWCr2ZX82sPE3jK16zxyOfyDwKeQ==
X-Received: by 2002:a17:903:41c2:b0:1bc:6861:d746 with SMTP id
 u2-20020a17090341c200b001bc6861d746mr2794266ple.58.1692203199029; 
 Wed, 16 Aug 2023 09:26:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 kx14-20020a170902f94e00b001b567bbe82dsm13439285plb.150.2023.08.16.09.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 09:26:38 -0700 (PDT)
Message-ID: <b2d06544-d072-c187-207c-edbb99e53a1e@linaro.org>
Date: Wed, 16 Aug 2023 09:26:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/25] target/riscv: Use GDBFeature for dynamic XML
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-11-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230816145155.21049-11-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/16/23 07:51, Akihiko Odaki wrote:
> -            if (csr_ops[i].name) {
> -                g_string_append_printf(s, "<reg name=\"%s\"", csr_ops[i].name);
> -            } else {
> -                g_string_append_printf(s, "<reg name=\"csr%03x\"", i);
> +            name = csr_ops[i].name;
> +            if (!name) {
> +                name = g_strdup_printf("csr%03x", i);
>               }

You are now leaking name.


r~

