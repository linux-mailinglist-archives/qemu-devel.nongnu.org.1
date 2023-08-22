Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C238378467A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTqF-0002Ve-4u; Tue, 22 Aug 2023 12:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYToI-0001CW-0V
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:01:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYToF-0005Ks-Jk
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:00:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf7a6509deso15327475ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692720046; x=1693324846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tIqN1h97jxVT1jQ8fzBPB53hH6Yz7IwITWFgubeYgvA=;
 b=mB9Jh5QTBRKbTYK1JZeXQo1QpxG8bkc4uczH2btO0zgP/OueCZtlAPuS8ya3ZnlgZS
 qo004wkmqo8ev9Y47mpzd0ey95+bNtm+2p5vYSl/yI7fmZ+XxlqL37GZWzrHB7lnbHza
 x/p/P1ZCF3otjoYZClnbGN2uxbTcaRN6Lkf/+hk14M9A9XEq7MsztbcpdfQbEjLSVdpj
 GVpYHwQimtL8NPaQ5dkZB9y/eo+ykCEPFBvkgZdtv1mRzjtYk2qF2D0IU9dJRLz96CE6
 XEU9g1RnHMb9u2pNtoc+HWVBevH2BTIovs1+Dyvsy1S1Y1eQc8sQFJcz5mAJDknQsHkn
 cCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720046; x=1693324846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tIqN1h97jxVT1jQ8fzBPB53hH6Yz7IwITWFgubeYgvA=;
 b=Je/Yi9ZuoybJ7bNmR8Wm1SZlMjDnR4rZ5JMnrZM0/u269p0RMjaDLlKTyDqot5exU3
 XcrjXG93SmjZDcKjm+S2nQwwSKHSorPnHAWpViQdXxXtHOZeiWiGEkoNXCpmz6exRpvD
 GFbs3qgomIeS5Sh37kvFdv5TORjdNCejh5aoB00gwecmjR29E64DCnsu6T3t8eeffSsf
 fnCqrTO410vCMIgH1cgie9p7eWA0iriD9D9yfPpiY8Y1Hg64JO3aiiLrkLgi7keASrs0
 B2331VE5fo2gn7CXSkc++arsCMbfjmp0Lmbu29vh0YiTQMHmGrZCLlfQPALV785r3qdI
 RMBg==
X-Gm-Message-State: AOJu0YyseyWLBLIK9XfB9vubBU8pAXD4aG90gGUkSNbxdkJqvnIEvyXJ
 w8XRoyZwEVJH2p4XewZRPPevWA==
X-Google-Smtp-Source: AGHT+IG0yZurcwwhrZCokAS7OvQs3XQ9sW0iPMmx/XBDU6dI89l/d3/mTTZFK0SUkyifJc8ZBa7kBg==
X-Received: by 2002:a17:902:a409:b0:1b9:c68f:91a5 with SMTP id
 p9-20020a170902a40900b001b9c68f91a5mr6037139plq.6.1692720046033; 
 Tue, 22 Aug 2023 09:00:46 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a170902690800b001bc56c1a384sm9194669plk.277.2023.08.22.09.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:00:45 -0700 (PDT)
Message-ID: <a9889a85-567c-77ef-7193-3bbfd5c1fbf8@linaro.org>
Date: Tue, 22 Aug 2023 09:00:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/7] tcg/tcg-op: Document bswap64() byte pattern
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822093712.38922-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/tcg-op.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index e6b0d74a46..f4fe13e040 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1828,6 +1828,11 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
>       }
>   }
>   
> +/*
> + * bswap64_i64: 64-bit byte swap on a 64-bit value.
> + *
> + * Byte pattern:  bswap64_i64(abcdefgh) -> hgfedcba
> + */
>   void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
>   {
>       if (TCG_TARGET_REG_BITS == 32) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

