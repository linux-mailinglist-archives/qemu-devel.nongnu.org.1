Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C2176726C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:52:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPQby-0006uX-5h; Fri, 28 Jul 2023 12:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPQbv-0006u3-RX
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:46:39 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPQbu-0006Zn-Ab
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:46:39 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68336d06620so2291804b3a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690562795; x=1691167595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CF4f66H0mjhCmliOUtC5TGKXFUGbLWWPvI24d7OVtkM=;
 b=iQpH3Yzokzix/36yGZ60IxMkbsBfcpUbMANJjmXSmw1Yzyb8L8Vz2y5jjlcdLIqGU6
 wX9laiskyuGjHTGozczbL9/OzqnjYowSy4Hl9PvDlY7EpWgPlYtIzcl1u+K1TzJJyu1c
 Nlw5SSpNQnW5PGfGfc+z+40XG2V36YV2yen6ESGX5LtYutk8ReOrfmMwLSLHkiYdI0FG
 /aZ5rMzOfrF3/3TdPjGVm+BhpXsEdhIDqA7o0OJxMwXnywFQCGrbLyFqPbkjUox5/4Yq
 iDzGZ7nqDid7mcA1/bDp2pTsEesYoe2KHoi/ajkdFeMS+Z2XO1BZeS7K5hPaLLNjd8Xx
 GieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690562795; x=1691167595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CF4f66H0mjhCmliOUtC5TGKXFUGbLWWPvI24d7OVtkM=;
 b=iHFVCn6OBRhy9nT+A2ZCJOBuHf9oDlyky9ELDsae+yDuQSfvRYXvzAr5xmi7fQfWFa
 sgLzjHyGK89jSMYaYh4lRU+/wLr4QTDGovwjeVOk+dksPMubWoJA8UnKuXtMIqxEHpYa
 zUSVbbamTnMRwC5YU93qXAdw2SCmfqfn0Uve1QV260z6OtxJQirqKRaROkuluNleTTFN
 9VSHyte6kXDy8qvOxnts1Ssb338ifpZTK9qG2GV3YFKkWfz4b06/dvd9vSfU7pLu22r7
 XF6RFti3qAlTJNP9PEAHbjHKC7rabv3lpY7d1GkaIJfDJCJa7UY84/UzIB6iDheGJiqf
 oMhQ==
X-Gm-Message-State: ABy/qLa67kksYAZbTwqyQJ5nfoJyzv1jPuJmg0cDTp4mJSjGoOmmV9ty
 7xKesh5rD6+6yTG/b0/fAW8xpau+xBK7ZTqDd5U=
X-Google-Smtp-Source: APBJJlF35NAiYXNyHYMDpKG2mak6xq0gQRZX1Vzq3BAopvJ3m0XHfoF7baOy8bgwWF+ZzgfOlmQLCw==
X-Received: by 2002:a05:6a00:3a0d:b0:67a:8fc7:1b61 with SMTP id
 fj13-20020a056a003a0d00b0067a8fc71b61mr2779806pfb.11.1690562795136; 
 Fri, 28 Jul 2023 09:46:35 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62bd12000000b0067acbc74977sm3519384pff.96.2023.07.28.09.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 09:46:34 -0700 (PDT)
Message-ID: <9fa0b0b0-aeda-63d8-3363-f8db137fed08@linaro.org>
Date: Fri, 28 Jul 2023 09:46:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] bsd-user: Specify host page alignment if none specified
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: kevans@freebsd.org
References: <20230728162927.5009-1-imp@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230728162927.5009-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/28/23 09:29, Warner Losh wrote:
> We're hitting an assert when we pass in alignment == 0 since that's not
> a power of two. so pass in the ideal page size.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued.


r~
> 
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 74ed00b9fe3..b62a69bd075 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -260,7 +260,8 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
>   
>       if (reserved_va) {
>           return mmap_find_vma_reserved(start, size,
> -            (alignment != 0 ? 1 << alignment : 0));
> +            (alignment != 0 ? 1 << alignment :
> +             MAX(qemu_host_page_size, TARGET_PAGE_SIZE)));
>       }
>   
>       addr = start;


