Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B6F7E28A1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:26:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01UU-0008JD-3l; Mon, 06 Nov 2023 10:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01UR-0008Iu-QP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:26:11 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01UQ-00032I-4n
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:26:11 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so7877969a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284368; x=1699889168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1tGj/MlyT4QSlqWjO7+poXC4hkgbTT+jdn13urHGic=;
 b=wBnquMM7yW1AWJHGH+J945e+/ZVQAO2pi15d0RBAQrg+GVb/5HGn4lYOecoVKiuQ6V
 nF4c/c9YSlCGwiVHw+epcXi0ePdvQeQH5v+JvVYTp+opT3WzxYzWXQN5/Ap4a6tpOP1v
 ncp7wYeboVJwVJrXsUWyY8xNJVc7d2LNYigzTpTG/TVtAEGv7oKSHlUN/dIbTBM3j2pD
 XROxiTSN5Qdlw1x57TdU0MhX/9DIg59M5fiwdi93k1a1BucSE1Bg27Durska6ZRz80wI
 RMpsspbztMNJKThRriW8WZW7lRS7Tot8IWvPLhLCFoNuRGwyZAB0RlvP/vu/FzdnvzZI
 AkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284368; x=1699889168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1tGj/MlyT4QSlqWjO7+poXC4hkgbTT+jdn13urHGic=;
 b=b5KWyvPIq6VGqhFXAWlvIOoDkkygeqwxDC1AeMee1j8I/r3TMbOoFyBc2OLleuHfZ6
 pgQ9WEJ+N3LyTGUezXwZxCkGbKaUbAQgPV5j22UKyHLJLl++VlUSOp0HaZbCVFg2dz0f
 2vaniEsnVgKQlgikqCAJ5FdWCF4CUw0zNSLdJWZm5lW5n01EDrVgsiLDmXWCWbgXbSk8
 dNe4UcpE1nhcc038riOm1+XtUHvw1huOzvReI9jeEvOwE8vUe4aUTibS4FnObaSALDHQ
 fGVZHzWoBe9aepc+7BYAV+G+6oXPCF3MQZl5Xtx98UJgR3WzLibCvvz8QrtDb7/nSjq+
 7CHw==
X-Gm-Message-State: AOJu0YyFrBtmSjkLzlTIgh1aPXn1XAvJH00P0HyWJSRVwhiVBcwLvl3S
 SDuYn+cxjOiia30mG2IpKpPjHx50GkTMn1Zdd88=
X-Google-Smtp-Source: AGHT+IGPUHUllweAMLV63RhwV8ID1+y4MmE8cCcwEVH+v4OFR7sl1UeJyoCcdpxb6r3RNJO16m9F7w==
X-Received: by 2002:a17:906:70d1:b0:9df:3dfd:5698 with SMTP id
 g17-20020a17090670d100b009df3dfd5698mr3533617ejk.73.1699284367926; 
 Mon, 06 Nov 2023 07:26:07 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 jp6-20020a170906f74600b009ad89697c86sm4272647ejb.144.2023.11.06.07.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:26:07 -0800 (PST)
Message-ID: <8acc2ba8-9154-cf50-f0e3-8cb12bf96426@linaro.org>
Date: Mon, 6 Nov 2023 16:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 01/35] tcg: Introduce TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 28/10/23 21:44, Richard Henderson wrote:
> Add the enumerators, adjust the helpers to match, and dump.
> Not supported anywhere else just yet.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/devel/tcg-ops.rst |  2 ++
>   include/tcg/tcg-cond.h | 49 ++++++++++++++++++++++++++++++++----------
>   tcg/tcg.c              |  4 +++-
>   3 files changed, 43 insertions(+), 12 deletions(-)


> diff --git a/include/tcg/tcg-cond.h b/include/tcg/tcg-cond.h
> index 2a38a386d4..bf3fcf5968 100644
> --- a/include/tcg/tcg-cond.h
> +++ b/include/tcg/tcg-cond.h
> @@ -49,6 +49,9 @@ typedef enum {

Maybe update the enum comment, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       TCG_COND_GEU    = 0 | 4 | 0 | 1,
>       TCG_COND_LEU    = 8 | 4 | 0 | 0,
>       TCG_COND_GTU    = 8 | 4 | 0 | 1,
> +    /* "test" i.e. and then compare vs 0 */
> +    TCG_COND_TSTEQ  = 8 | 4 | 2 | 0,
> +    TCG_COND_TSTNE  = 8 | 4 | 2 | 1,
>   } TCGCond;


