Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0C81BB70
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 17:04:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGLWL-00027J-9f; Thu, 21 Dec 2023 11:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGLWE-00023Q-W1
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 11:03:31 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGLWC-0005MD-SK
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 11:03:30 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ba46a19689so763943b6e.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 08:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703174606; x=1703779406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7VdbZU6qjxU/tHJ3izWuTFvqYJeXZwBxtkN6XSz1N4=;
 b=aLlB/ZoacIIFMgucagp0rvI+AqgPABc86aNe7ozhr8YhIbWTghODNhuUxtlDsa34WD
 qnGmwTP7SXAeJKF7lXdEJPZjp37PzNc0aC5wJTzHq9zHyJ+OTIHmoGmGyTH33ZkImW7y
 yynbtizinXNQQcqjllIVBhNtTnuXtvgLGJ4wKwNtv08TW7G001IptvzAuqtUbuvxF2xG
 hSvfFYCoB3PY74p0IxBy1/gsMorzT1C2lBCUAfCudtsCsavWhoBxQMEx8xlaoiHHNAJ6
 vtuKsor6WuJA5/qTTMfQ6B/DPGldDiWzQC+gbIczMO30NhNSOa0jbfSg1PPYgTwdC2UR
 LXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703174606; x=1703779406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7VdbZU6qjxU/tHJ3izWuTFvqYJeXZwBxtkN6XSz1N4=;
 b=dVuPxWVYc+Ui5Ha0sP5gV7WoTh+uT2LM083jJfkkPOJCnv/j0Yi9XSpRPPyPZRb+aL
 yyD3e2eYUZ7GnIGVVZ84zcVR5aG/yVdCtRQOz4Naznigw4HcGw/iLAZKyLMLyRORovpm
 8AaDXzreS0sfuQj6YHg/hqmqSIxNg/o2NKzOZNFjkKX5b1jex38bFM3OXS92sXJrDi4+
 +F/lK9eiL2AehXmzd179LTx4XwZ24VWAUBgShg/mV06eXeBfHrtkh5VtorFbc2C0cwiV
 cqE4GKnvpWONMD+Q8XTtL10jRG1SkrovmWfTBiOlLBbHR8nUt4MzFEu4cCxVPGFbNVln
 3j4A==
X-Gm-Message-State: AOJu0YyfmpmaWJcLhKDQ7qhoUNlmtooIz/Oor2FZzLj9e9VHTx+igrw8
 PCa/khTQY/IzAc6x10b/mJXYSg==
X-Google-Smtp-Source: AGHT+IG7iZE0/U9OBt8niAInm0RedTVIRE6WF5IwYlu9fIwuhaUqgG9KWRVMmQIvsBE27uecEtVyqA==
X-Received: by 2002:a05:6359:c1a:b0:170:936d:8afe with SMTP id
 gn26-20020a0563590c1a00b00170936d8afemr1503076rwb.49.1703174606478; 
 Thu, 21 Dec 2023 08:03:26 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 o184-20020a6341c1000000b005c6aa4d4a0dsm1766670pga.45.2023.12.21.08.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:03:25 -0800 (PST)
Message-ID: <9e7b9bce-7cd2-46b5-8868-c68c237cb232@ventanamicro.com>
Date: Thu, 21 Dec 2023 13:03:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv/csr: Rename groups of interrupts
Content-Language: en-US
To: Vadim Shakirov <vadim.shakirov@syntacore.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20231221113628.41038-1-vadim.shakirov@syntacore.com>
 <20231221113628.41038-2-vadim.shakirov@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231221113628.41038-2-vadim.shakirov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 12/21/23 08:36, Vadim Shakirov wrote:
> In AIA spec in 5.1 chapter says that "... the AIA categorizes the counter
> overflow interrupt (code 13) as a local interrupt. It is assumed furthermore
> that any future definitions for reserved interrupt numbers 14 and 15 will
> also be local interrupts" and than LCOFI belongs to LOCAL_INTERRUPTS
> 
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d69bff5a67..36f807d5f6 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1120,18 +1120,18 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
>   /* Machine constants */
>   
>   #define M_MODE_INTERRUPTS  ((uint64_t)(MIP_MSIP | MIP_MTIP | MIP_MEIP))
> -#define S_MODE_INTERRUPTS  ((uint64_t)(MIP_SSIP | MIP_STIP | MIP_SEIP | \
> -                                      MIP_LCOFIP))
> +#define S_MODE_INTERRUPTS  ((uint64_t)(MIP_SSIP | MIP_STIP | MIP_SEIP))
>   #define VS_MODE_INTERRUPTS ((uint64_t)(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP))
>   #define HS_MODE_INTERRUPTS ((uint64_t)(MIP_SGEIP | VS_MODE_INTERRUPTS))
> +#define LOCAL_INTERRUPTS   ((uint64_t)(MIP_LCOFIP))
>   
>   #define VSTOPI_NUM_SRCS 5
>   
>   static const uint64_t delegable_ints = S_MODE_INTERRUPTS |
> -                                           VS_MODE_INTERRUPTS;
> +                                      VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
>   static const uint64_t vs_delegable_ints = VS_MODE_INTERRUPTS;
>   static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
> -                                     HS_MODE_INTERRUPTS;
> +                                HS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
>   #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
>                            (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) | \
>                            (1ULL << (RISCV_EXCP_ILLEGAL_INST)) | \
> @@ -1163,7 +1163,7 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>       SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
>       SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS;
>   static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP |
> -                                              SIP_LCOFIP;
> +                                              LOCAL_INTERRUPTS;
>   static const target_ulong hip_writable_mask = MIP_VSSIP;
>   static const target_ulong hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
>                                                  MIP_VSEIP;
> @@ -2471,7 +2471,7 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
>                                   uint64_t new_val, uint64_t wr_mask)
>   {
>       RISCVException ret;
> -    uint64_t mask = env->mideleg & S_MODE_INTERRUPTS;
> +    uint64_t mask = env->mideleg & (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
>   
>       if (env->virt_enabled) {
>           if (env->hvictl & HVICTL_VTI) {
> @@ -2693,7 +2693,7 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
>       }
>   
>       if (ret_val) {
> -        *ret_val &= env->mideleg & S_MODE_INTERRUPTS;
> +        *ret_val &= env->mideleg & (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
>       }
>   
>       return ret;

