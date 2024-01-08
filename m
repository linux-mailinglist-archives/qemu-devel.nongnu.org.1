Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64858826C08
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:04:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnQA-0006TH-Md; Mon, 08 Jan 2024 06:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnQ8-0006T9-NS
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:03:52 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnQ7-0001cI-3h
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:03:52 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-783253c2182so44863785a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704711830; x=1705316630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JliUV7+Ff1mD0R6z5nbU8bGmXkglbsXzk0YFiMBLzK4=;
 b=iUQ+isCeHVPAubEyBinY0igrREIkiinPJ8sIqrCRLjMfc8MUW/UrNfDQ/KdHJKi+xg
 dChYQUPQk6tCOIc/CSp0YtHnOn8Oa/KviwgPswXuKFhDPrWZhnLgSX7uJrUeT8a04dIH
 ea+mOeP4Nn4fa6/ed44M8BLhquvh+d01m0/aRTC82RzX/TS3mS5KsTn7Ya/ZtwaG0c2z
 IoiHl+VQE46WN0pE2aEWhBttygRv7+ls0mSJX1tCpIUvV0nhbGaFb0BMTJMy0oItppEV
 b85MpmYkISivphNt0Bx8EYlcLqzbPGkNKk3blqpUSt2RxQ4T0+Nu03MYcDccltiVwP1v
 oVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711830; x=1705316630;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JliUV7+Ff1mD0R6z5nbU8bGmXkglbsXzk0YFiMBLzK4=;
 b=f1k5sViSg6h7bGWPUy63vjfRyeBQMlsCiGzHOJz+czu1S4WgljABjVQutn6CJqJ/Fv
 6Q+lZk+LyDkiiQo/+zfw7d6ohZfYuqxHs+NfzTjDwJnUW9XLFOtD3uBM2PizkASsX+Mo
 3QTQQ6KUPguBIn9SzILEaGPCFaVl6yPKlod0Z2PgZ5Hd8bg8ROmFmkc2/TxSKXo3uMFG
 8CV2B5/gIGanm7h5NqvN4a7ab/SXvrJp8drQtllfnwaH5qWK2BKOHyxlblbY3mkxIeLJ
 FIO39ZX9QTqvFpG6zYe4+02+CJGPkhhYQN7H2UwWwV1Y+jGVtYb8HcVDC8bLhovFnzHj
 h0mA==
X-Gm-Message-State: AOJu0Yx+YY8hj9VsexNCcyKygHFuoYOcWtF8RFSUsvDTdJA+yVxFzTzH
 r/CFbJ15tNfkpmlrdPmjYC1HmSwj+6tcBQ==
X-Google-Smtp-Source: AGHT+IFG41m4c2r4d6bX09kfHLiZSb4Z78muSPqmOYHaD8cMQjlLGzN9j7CUSs3jh7rxnfLNgBRqhg==
X-Received: by 2002:a05:620a:2729:b0:783:4e3:c994 with SMTP id
 b41-20020a05620a272900b0078304e3c994mr5400793qkp.0.1704711830064; 
 Mon, 08 Jan 2024 03:03:50 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a05620a164a00b00781663f3161sm2592930qko.85.2024.01.08.03.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:03:49 -0800 (PST)
Message-ID: <43903754-a603-4f0f-bbfd-10a0947d09bc@linaro.org>
Date: Mon, 8 Jan 2024 15:03:47 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/33] target/alpha: Enable TARGET_PAGE_BITS_VARY for
 user-only
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-34-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/2/24 05:58, Richard Henderson wrote:
> Since alpha binaries are generally built for multiple
> page sizes, it is trivial to allow the page size to vary.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/cpu-param.h | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
> index 68c46f7998..c969cb016b 100644
> --- a/target/alpha/cpu-param.h
> +++ b/target/alpha/cpu-param.h
> @@ -9,10 +9,22 @@
>   #define ALPHA_CPU_PARAM_H
>   
>   #define TARGET_LONG_BITS 64
> -#define TARGET_PAGE_BITS 13
>   
>   /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
>   #define TARGET_PHYS_ADDR_SPACE_BITS  44
> -#define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
> +
> +#ifdef CONFIG_USER_ONLY
> +/*
> + * Allow user-only to vary page size.  Real hardware allows only 8k and 64k,
> + * but since any variance means guests cannot assume a fixed value, allow
> + * a 4k minimum to match x86 host, which can minimize emulation issues.
> + */
> +# define TARGET_PAGE_BITS_VARY
> +# define TARGET_PAGE_BITS_MIN 12
> +# define TARGET_VIRT_ADDR_SPACE_BITS  63
> +#else
> +# define TARGET_PAGE_BITS 13
> +# define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
> +#endif
>   
>   #endif

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

