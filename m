Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96125766E80
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNbv-0004RS-VE; Fri, 28 Jul 2023 09:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPNbt-0004R3-Mt
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:34:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPNbs-00052t-3y
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:34:25 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-563f4e49ff9so1195863a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690551262; x=1691156062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yndvAqvOHMeuQwBGmewYeaBanoyxHU8sjznR4zAHPnU=;
 b=QEV1shIbLYN7TBYT143NINQfhUF3nDatlS0nirT85VlWGDYLvliaf3c21DxPYi244O
 3lo6amA9nmmnQeP09TrrbLL0eQWIxyyF//JbQ7IkdHa3q2zfTcloVJYeKAN7nMUN57wy
 k+HEnCpr9SUiogeE2loL5crVDMAkVjj6NNDGKhddPwaCrResq+ZMeBp1ygs0Sq4G8EBf
 nXMXO433hE55jKvgbcjpsuZnrNrmGrsw1+9KOx1sf+gxpfVZ9QfogrUTIs+Ui3HXoz/z
 /0xDr/F+vv4Y/g+Q9K+PxqWJuDN0Kdf7gR+SWJE4B9x7mvQiCq0w2FWpWS0tzZ8cL0sw
 4mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690551262; x=1691156062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yndvAqvOHMeuQwBGmewYeaBanoyxHU8sjznR4zAHPnU=;
 b=c7EgpySfr3NXGSdglHE8pH3WuQGrc8gCWyd0SSIdbR8HRCUH/mh+xLrWa5l+g9iseF
 AbBBSsTZoxknUXscZtACKJPLN3hl3yFutRgwq2OBnsg2+FZWTl7suwgJ7/aTZwC5q+Hz
 pycS4NQqKIzj3f1zPaFezjb7LGbzV2rKZIXyQc2SVH3JO7VVGnlMTQk2DtnWW60TSXor
 875Wy4vMDNe27RVdLkIJ0F+U7Ut68O7LQ/P2FKIBIfyVtgWxh/fSS8Bi3KaQseUZm1q7
 Fkok2isvLVYAlQP+gDf5b5ZmuWcTvdT50PAjQzb56dBGVzb7uBONL3iGqI4jcP16smo4
 aH/A==
X-Gm-Message-State: ABy/qLZ+V4QxBR0dpAtXC37AKWR/z9j6q44hVnpqUXbELiWMjrhr2KE9
 Hrm7gGWsC/3/NnNITUXSywC7Qw==
X-Google-Smtp-Source: APBJJlE+ah+debx+fOD7cPTP7kMGP+LcSLg18xsFeT4dCXeFGr79ZIOg7jtZd+7emDOy1NNG/i6OYQ==
X-Received: by 2002:a17:90a:5408:b0:267:c0cb:e462 with SMTP id
 z8-20020a17090a540800b00267c0cbe462mr1231221pjh.48.1690551262626; 
 Fri, 28 Jul 2023 06:34:22 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a01de00b00268032f6a64sm4546536pjd.25.2023.07.28.06.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 06:34:22 -0700 (PDT)
Message-ID: <10ae7649-7712-9884-0604-645cb12068aa@linaro.org>
Date: Fri, 28 Jul 2023 06:34:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bsd-user: Specify host page alignment if none specified
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20230728035456.99066-1-imp@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230728035456.99066-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 7/27/23 20:54, Warner Losh wrote:
> We're hitting an assert when we pass in alignment == 0 since that's not
> a power of two. so pass in the ideal page size.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 74ed00b9fe3..e3ce4ab1fc7 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -260,7 +260,7 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
>   
>       if (reserved_va) {
>           return mmap_find_vma_reserved(start, size,
> -            (alignment != 0 ? 1 << alignment : 0));
> +            (alignment != 0 ? 1 << alignment : qemu_host_page_size));
>       }
>   
>       addr = start;


