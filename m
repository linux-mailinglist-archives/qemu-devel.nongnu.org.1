Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5313F7C99DE
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 18:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs3WS-0006U7-DG; Sun, 15 Oct 2023 11:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qs3WP-0006Tw-Sv
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 11:59:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qs3WO-0000j1-9Z
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 11:59:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-406619b53caso37649525e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697385553; x=1697990353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j82v/FP2QkeS+tKHeH6P8h7s09UTPxNaWIHje65lX88=;
 b=ffBmfjZQpveMn8+ceFoqKjK3PU3LEvOB2Fc1k9BeQmkRSVCldisidkQNUfN/IgyvRJ
 kx872hdQEqBRLqZ4RgSUP6PbyYbUIez3dPmvEeRtOT7VzdmCQd3Xk2mhds7L1g4xDedb
 7Q1gUm1EQB323wrNBioH5CCRX9u9l4Lz+ukVQ+IePGlZuz566x/PuMuvfPExACxZiyGt
 VOFjKT4BmF2pjlDGP6GaA2Nt/IPkc3WgQOE5ZzuimJkCErn/Ds9mHT1Gk8qlEnX7CQWr
 32LK94C2LUFBf26gYlgfqgy9WKDjC7W5gwsPV4WAqo3mGKArdjQSqBllGOQAD543RDX+
 +5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697385553; x=1697990353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j82v/FP2QkeS+tKHeH6P8h7s09UTPxNaWIHje65lX88=;
 b=etQROW17ibH8XNzsMNaJyCo8fQqxwxkYWdCw4DbwvcG2cQi1w4H3pPnmfyfQRS9Pfd
 xEBT+UGEQYinaHstwVdJEPtq+62T3r8j2+k3x+eM1pZ0rjt9CqO9lbC7IMT2lMohFncJ
 ouFMfZmZwzOW5hqhTWLWh3OnBR8dWd6ecpltM2ArdcGDs0J+UFyc0L4mIWoHdIr6rYZk
 b6Y5yJpjaWxaAPSPv937+WUkd1guC8i6QK7Vzht0VVckW49il1bDozVlTy5ad5kB5Sjh
 gTlG8gXpBhhrK0Lp6vK1fWsbOFxO6i0JGgM+wi70B4nEtb1Kqajt3ZWBkAsEMGMpetpl
 iZMg==
X-Gm-Message-State: AOJu0YwNVcnjTOt+cFWUJbte61a+rkvNV6PhXODm5SS28W6l8YLA0MQ4
 m+0kuKke06Pw5uDUw00RJfmiuQ==
X-Google-Smtp-Source: AGHT+IHAj7NB8uaxIbdKf7IIpADNWHm+MXh1DPotcd8bPOtERGB8bOBcgpbZ2s3mn/Vfu23CBAyG4Q==
X-Received: by 2002:a05:600c:2195:b0:406:53aa:7a5f with SMTP id
 e21-20020a05600c219500b0040653aa7a5fmr27971760wme.10.1697385553467; 
 Sun, 15 Oct 2023 08:59:13 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 k27-20020a05600c1c9b00b0040531f5c51asm4884233wms.5.2023.10.15.08.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 08:59:13 -0700 (PDT)
Message-ID: <81fbd234-0280-61ad-32a4-d785a4640f21@linaro.org>
Date: Sun, 15 Oct 2023 17:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] tcg: drop unused tcg_temp_free define
Content-Language: en-US
To: Mike Frysinger <vapier@gentoo.org>, richard.henderson@linaro.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20231015010046.16020-1-vapier@gentoo.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231015010046.16020-1-vapier@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 15/10/23 03:00, Mike Frysinger wrote:
> Use of the API was removed a while back, but the define wasn't.

The cleanup started in commit 47f7313d81 ("tcg: Create
tcg/tcg-temp-internal.h") and the last use got removed
in d5920b7280 ("tcg: Remove TCGv from tcg_gen_qemu_{ld,st}_*").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>   include/tcg/tcg-op.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 80cfcf8104b6..3ead59e4594d 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -52,7 +52,6 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
>   typedef TCGv_i32 TCGv;
>   #define tcg_temp_new() tcg_temp_new_i32()
>   #define tcg_global_mem_new tcg_global_mem_new_i32
> -#define tcg_temp_free tcg_temp_free_i32
>   #define tcgv_tl_temp tcgv_i32_temp
>   #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
>   #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
> @@ -60,7 +59,6 @@ typedef TCGv_i32 TCGv;
>   typedef TCGv_i64 TCGv;
>   #define tcg_temp_new() tcg_temp_new_i64()
>   #define tcg_global_mem_new tcg_global_mem_new_i64
> -#define tcg_temp_free tcg_temp_free_i64
>   #define tcgv_tl_temp tcgv_i64_temp
>   #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
>   #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64


