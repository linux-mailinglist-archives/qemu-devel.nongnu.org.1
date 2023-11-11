Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 775597E89C3
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 09:16:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1j8n-00059Y-BA; Sat, 11 Nov 2023 03:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r1j8k-00059D-V5
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 03:14:51 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r1j8i-0008Lo-KS
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 03:14:49 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b56b618217so1592519b6e.0
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 00:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699690487; x=1700295287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwWf4jd51u1PpvyuN+Of1I4010hXbBFJlAgHfWjN6E4=;
 b=QTnrQXpXs1RM1mhZuqJA3Fn5b1yxZLS+T6967k5leLhRUlxqrj63FgMVLAQCdiv1JK
 p4ANQWxJAlBWlDQhLHsU+KHGHEDOco9SeYDhkWrGVRXrtVjES2rK7cXICEY4nFDk90Yq
 lQrasHqNee3ybwVrd+KE0D4R+zmjZQgr/7npqlctLi+gQ6VedVZY7zFU+2cfiC5P9tH5
 aHooBYfrpOIPXw6LOysjX/qsopnyRLLm9YTYSenTxN9rC/L1LgGM4RKv5NIBSUXkxBCa
 9Km4xtBwRo0Boi/0lAmV5oryQxPDsA4nnriN4hdetWmy/38/pPmOnO4j6kINFPV6qhyU
 VOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699690487; x=1700295287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwWf4jd51u1PpvyuN+Of1I4010hXbBFJlAgHfWjN6E4=;
 b=BcElg2ZVUrSueT4Q9BgMht5alhXEOGmv+B6U8j3jzE01HFGfp1BVwU9ElVsFjAitjN
 jx40+JyjsRid44hKltcLP69UYCJ1m7iMjXozNfm7F1WBd6O0ysKFx8mRKg5eAP2zX4A4
 z/vMTno0Xekg5ZTwZIxXibzD35yyL/PhZz3tvC0ss5G4BmAK3dg9JRbo2qB3KE8SwUxv
 8+zuoGT7kFXitEA84ei6d5igNX4Jvz3laC8gMxCeDVR3rOb7AsL7G3iBfmjtcBDSLrbe
 hN3YFEZNNc0afnpYXjHO6zSJP7cD1slSq8sOTy4iqG2++T3xNG96YoAITdpxSQMaG+Ng
 ilCw==
X-Gm-Message-State: AOJu0YweCdFoA3s/oO4CngbZ8cqxFG1tDa8DYc0JmlS6cxmFmvSaRBn+
 gQIDY4IMlSS5m0umrTberbKUpQ==
X-Google-Smtp-Source: AGHT+IHcZm1w2xggTtj3s9dsTbKFJ7u5QAqdtJfYbYNK5z9yqUoVQHlJxAu7I7qWrQ5CL+WNtA8kqA==
X-Received: by 2002:a05:6808:13c7:b0:3b2:dd36:dec0 with SMTP id
 d7-20020a05680813c700b003b2dd36dec0mr2526880oiw.4.1699690487291; 
 Sat, 11 Nov 2023 00:14:47 -0800 (PST)
Received: from [192.168.68.107] (201-69-66-14.dial-up.telesp.net.br.
 [201.69.66.14]) by smtp.gmail.com with ESMTPSA id
 bi5-20020a056a02024500b0059b2316be86sm753727pgb.46.2023.11.11.00.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Nov 2023 00:14:46 -0800 (PST)
Message-ID: <def7be54-9c16-4825-9921-c569adc8e79e@ventanamicro.com>
Date: Sat, 11 Nov 2023 05:14:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/riscv: Add Zicboz block size to hwprobe
To: Palmer Dabbelt <palmer@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 armbru@redhat.com, Richard Henderson <richard.henderson@linaro.org>
References: <20231110173716.24423-1-palmer@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231110173716.24423-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22c.google.com
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



On 11/10/23 14:37, Palmer Dabbelt wrote:
> Support for probing the Zicboz block size landed in Linux 6.6, which was
> released a few weeks ago.  This provides the user-configured block size
> when Zicboz is enabled.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   linux-user/syscall.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 65ac3ac796..7caacf43d6 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8808,6 +8808,8 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
>   #define     RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
>   #define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
>   
> +#define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
> +
>   struct riscv_hwprobe {
>       abi_llong  key;
>       abi_ullong value;
> @@ -8860,6 +8862,10 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
>           case RISCV_HWPROBE_KEY_CPUPERF_0:
>               __put_user(RISCV_HWPROBE_MISALIGNED_FAST, &pair->value);
>               break;
> +        case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
> +            value = cfg->ext_zicboz ? cfg->cboz_blocksize : 0;
> +            __put_user(value, &pair->value);
> +            break;
>           default:
>               __put_user(-1, &pair->key);
>               break;

