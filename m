Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1678BA67
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 23:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qajux-000815-4B; Mon, 28 Aug 2023 17:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qajuu-00080o-1A
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:37:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qajur-0006BS-Pv
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:36:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso35355445e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693258616; x=1693863416;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKOHlCKw3QIyIK3ofhohySPZ/nSZC6HPnqaQwu1HJUw=;
 b=R60w07avVe95zhcnF1ibMvmeobOYs5DPEFQq0UKYgExp3IpYhXXgF0RBEKHrnS8+o/
 3Cl0cGWkW6Z/hS3Z9jNU/RCW/wHr++XHCCfL4RFN96b2rOFmtRgYNmI4PH8WOsNF9Cg8
 gcoHoUcUEgLzE11ZPJyGCVoXtB4j943djbVaoGPtdx2U8zt/3JYgvqWyzmWXux57SIm7
 ORrT1OyxMb1ytTD3krlTwDsSlWxvFcdANP6/jzTHIp0aSIVYM1Mi+QcpzrA8lYzqX4vQ
 5zGhflrvYfdbPr64oUoyIbKAzrkbeC3UPC576GG0npEfgbXc+Z6+BVHnYExzOphBqCrG
 0/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693258616; x=1693863416;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKOHlCKw3QIyIK3ofhohySPZ/nSZC6HPnqaQwu1HJUw=;
 b=IS9Jh42ZKpsgXiQFK03E8Ii1MXlYvGeE8wlAoEDa59AU3ky3NWIqCBe9GaGEEX14A8
 fo+0AR/bSuuNKFYpaItuXfb8S2jsVvMWWQ66HjhPMbvsTCu+Y0DgceGy/CeXfIUJ2kjO
 GpDtEbSsOY2jwmbdBcljc0eyEu6zsgQk/W79u8kTB4i55zG9Sdz3rrOQHp+nqW2ZGVyU
 qQQXOp6/pmhBE/RoauCfaRbiZ1Ao6WsAPcrsbD8N6drU8d73erXXx+wH+QZE6GqD/6Iz
 ncOW/sOMLz/xW+BDoGlLL+/c3z2jrBfrpjoxKOvSl0sDn33dSCpoGs0alk8O9QFvzp1Z
 NuNg==
X-Gm-Message-State: AOJu0YymPedgphfGYP4QEG4decquxOCpe+HyJ7H9yTKYKJLA2UaoOO5M
 O6mqdObq3ceMxeC4xCbSOxAqYw==
X-Google-Smtp-Source: AGHT+IG0BsR3kTPEq8dehgWZY3cIK3xTbCR7MJDsINUWN9FELIpkB4a44qYUUMOlIE6RaSfWr4b3Ig==
X-Received: by 2002:a05:600c:21d1:b0:401:906b:7e9d with SMTP id
 x17-20020a05600c21d100b00401906b7e9dmr9812664wmj.18.1693258615172; 
 Mon, 28 Aug 2023 14:36:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 k21-20020a05600c0b5500b003feea62440bsm11750476wmr.43.2023.08.28.14.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 14:36:54 -0700 (PDT)
Message-ID: <7e7ae799-8313-6874-5395-e0a45fa62e68@linaro.org>
Date: Mon, 28 Aug 2023 23:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] tcg: Remove vecop_list check from tcg_gen_not_vec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230828193949.576198-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828193949.576198-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 28/8/23 21:39, Richard Henderson wrote:
> The not pattern is always available via generic expansion.
> See 

commit 11978f6f58 ("tcg: Fix expansion of INDEX_op_not_vec") and the

> debug block in tcg_can_emit_vecop_list.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-vec.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


