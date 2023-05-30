Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3CC716EA6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 22:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45xL-0003C1-I5; Tue, 30 May 2023 16:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45xJ-0003BH-DD
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:28:33 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45xH-0003Fl-Vk
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:28:33 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6af6db17a27so1844545a34.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685478510; x=1688070510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UMtlq8L6UjwdgNcOBPm2LO1d8v8PMDEiWTlyYYIUpfQ=;
 b=hQ/gn9NePKnZ7Q7t8ri9i8QhxS+LOfG+bHWUROPzn+jX6OXIjr6Uaz8eGD5ma9ojoQ
 w1PinmvtEZuHg2BfbwXtqoLkWWza6CoUHDU3wP1RAMxer3gmEAY2WNyDftl0v9S498ol
 lJbnuW/fEUobLgJa5EBOciDQE1Rja5JoUAJKaR08DvxaMLwl1er28jBEDh165SjMFKzI
 XPUGG5zEAW6EidRkHFug/c9P8mxUHnMWAdACwKjg5B6R4+WI8aSbDqxuajAnp8sevj/x
 NO2lG43XXyolC8ynuirTdsa5D2RvveYxCAM4r91NlMO+VPFEyJOKYbZQG8m3flTEO/4V
 Y7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685478510; x=1688070510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMtlq8L6UjwdgNcOBPm2LO1d8v8PMDEiWTlyYYIUpfQ=;
 b=GE5HIXXdKVAsQOeXV4DJeuEvWCeQedOACAUnXcDVq5uK77/AdYpQ5nptAaFlYesHe6
 EV59oxL7einF6jO41ACUWJN002HvadrKRyX8feZARGuBPygMb7WPCtT5etdl1oohKMkz
 Ad2b2yqyhdDvu57kRl0OtqrJGG8XrrE0IA1G/niyjzdX8GoU9+P3Ie8LhQ1moxB3O0EN
 n+sDCyZIRh3ad1E4NSFrq0ApAZGX6wsU5uUlJ8rOVtlgEvNXL2Q08GX3PN/ug0XEdjQn
 MnXario8xl8yqKdkTk4h7HANxV/isnXtd81yqGtHsXdW2EqTmIxBs3/ctksn7F4NSRJv
 SVbg==
X-Gm-Message-State: AC+VfDxMhVZ0WT1vUsz7DeaO57cmO/hOtNK+uXQWJlMa/6MMtLTf/cjx
 J+zzn+9fujst8l+cG0i6Q3DxxQ==
X-Google-Smtp-Source: ACHHUZ5vG4b5m9ag3/73L6BvBO8Vl4zQy5TH4bConGl4mDHNnjIgAMp1InX+Y7yoQsF7F3SoMm++JQ==
X-Received: by 2002:a05:6830:1002:b0:6af:8b05:dac5 with SMTP id
 a2-20020a056830100200b006af8b05dac5mr248348otp.19.1685478509958; 
 Tue, 30 May 2023 13:28:29 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 c7-20020a9d7847000000b006ad3ed04973sm5946813otm.8.2023.05.30.13.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 13:28:29 -0700 (PDT)
Message-ID: <0b5ea8ce-48fe-22b8-7247-90d8fe727b1d@ventanamicro.com>
Date: Tue, 30 May 2023 17:28:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] target/riscv: Remove redundant assignment to SXL
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230529121719.179507-1-liweiwei@iscas.ac.cn>
 <20230529121719.179507-5-liweiwei@iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230529121719.179507-5-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 5/29/23 09:17, Weiwei Li wrote:
> SXL is initialized as env->misa_mxl which is also the mxl value.
> So we can just remain it unchanged to keep it read-only.
> 
> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6ac11d1f11..25345f3153 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1321,10 +1321,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>   
>       mstatus = (mstatus & ~mask) | (val & mask);
>   
> -    if (xl > MXL_RV32) {
> -        /* SXL field is for now read only */
> -        mstatus = set_field(mstatus, MSTATUS64_SXL, xl);
> -    }
>       env->mstatus = mstatus;
>   
>       /*

