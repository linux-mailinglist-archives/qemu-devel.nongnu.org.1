Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E98781E649
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:22:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3d4-0007VP-FO; Tue, 26 Dec 2023 04:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rI3d0-0007Uv-Pb
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:21:34 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rI3cy-0007Xj-Ov
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:21:34 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce10b5ee01so815458a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703582491; x=1704187291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WRFhmqa4MVy3cGMvRBHO+TZSMH0tR1rOwEbQqCyrZWk=;
 b=Y68h4Gj3SXampDAefnf8AIKfOBzKT+jv/1zS1rhJ6xWpmzeZlL3U1BbWdolAa6NgP3
 8RHlE9bQ/zA/spRqU8EjYSccQr31a+NPt4gO1sByF0OLJ539kXyQU+dwbia0FulswCtP
 xcVeM4PZKYzAtH2kf1gApq3Y84AHvTfLhyN4KV6DZ7vh4fnMVJkmQc6MDgv7AR6DtCvB
 /QmWnyayOjbfjAxOBZOxlAExKicvwnsPsJRnIScBqQCioT7cuTl460gt5S7GbNKU4S5b
 fKcQaa+Xv4wLfqDS83fVv/qDWavg2LMS1sk4tQrMGWxhhzzk1PXrVVr2JJ0FVjxhMunP
 KH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582491; x=1704187291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WRFhmqa4MVy3cGMvRBHO+TZSMH0tR1rOwEbQqCyrZWk=;
 b=DO83owIUZ+fJl44NtPjOjpj4Yi8yQjq1TyuP6MIq8kPgtWXsdeE+d2wNMFIkQG1qOe
 i9HjhSzPjxu9kmjTx//8ViDNm4bK9qvRjGACmngPO4jPpe700bOv8v0gIgdP+SrDlE6t
 afL1+J9/2bzV4b89Pc6PEe022sX/J8JbWjqIltJQn/8AatMA1a9R2XUNOEF4bcH9u9rW
 mBWMjWmimWZozPwLf1EvXScPl3yRgvgFIAact6b7oYDn+5n04mQngXw6yQDTj5kvVrOW
 9SWuvtqzUcGrEuRyJBvfq9vret10wKJ38NvuGszf+4kU9KkAG+4uKpV3HRA9DjkQqSJr
 Wdrw==
X-Gm-Message-State: AOJu0Yy8hoO4BvTVC3b5Bbvd2orTZe2nDuEbiWJj72hb8Nn8w83IHw89
 63oJ8q5Y8L57cSat90WYO7ncXgXv+rdMpA==
X-Google-Smtp-Source: AGHT+IEgMHnCzA+EkexEZYpDMqJW9oyeFr6JSN/z6gOSvzT6ChCR6XgNK7T2DVN8e9J8h6rzgOvyiQ==
X-Received: by 2002:a05:6a20:3d1a:b0:18f:97c:384e with SMTP id
 y26-20020a056a203d1a00b0018f097c384emr8617249pzi.40.1703582490723; 
 Tue, 26 Dec 2023 01:21:30 -0800 (PST)
Received: from [192.168.68.110] (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 d12-20020a631d0c000000b005cdc081bd2asm8938462pgd.24.2023.12.26.01.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 01:21:30 -0800 (PST)
Message-ID: <4b3554bd-3d7b-46dc-a873-b6c7af1357a0@ventanamicro.com>
Date: Tue, 26 Dec 2023 06:21:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix mcycle/minstret increment behavior
To: Xu Lu <luxu.kernel@bytedance.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, lihangjing@bytedance.com,
 xieyongji@bytedance.com, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20231226040500.82813-1-luxu.kernel@bytedance.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231226040500.82813-1-luxu.kernel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
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

Michael,

This is a good candidate for qemu-trivial. Already acked.


Thanks,

Daniel

On 12/26/23 01:05, Xu Lu wrote:
> The mcycle/minstret counter's stop flag is mistakenly updated on a copy
> on stack. Thus the counter increments even when the CY/IR bit in the
> mcountinhibit register is set. This commit corrects its behavior.
> 
> Fixes: 3780e33732f88 (target/riscv: Support mcycle/minstret write operation)
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>   target/riscv/csr.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index fde7ce1a5336..c50a33397c51 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -907,11 +907,11 @@ static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
>   static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>                                            bool upper_half, uint32_t ctr_idx)
>   {
> -    PMUCTRState counter = env->pmu_ctrs[ctr_idx];
> -    target_ulong ctr_prev = upper_half ? counter.mhpmcounterh_prev :
> -                                         counter.mhpmcounter_prev;
> -    target_ulong ctr_val = upper_half ? counter.mhpmcounterh_val :
> -                                        counter.mhpmcounter_val;
> +    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> +    target_ulong ctr_prev = upper_half ? counter->mhpmcounterh_prev :
> +                                         counter->mhpmcounter_prev;
> +    target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
> +                                        counter->mhpmcounter_val;
>   
>       if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>           /*
> @@ -919,12 +919,12 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>            * stop the icount counting. Just return the counter value written by
>            * the supervisor to indicate that counter was not incremented.
>            */
> -        if (!counter.started) {
> +        if (!counter->started) {
>               *val = ctr_val;
>               return RISCV_EXCP_NONE;
>           } else {
>               /* Mark that the counter has been stopped */
> -            counter.started = false;
> +            counter->started = false;
>           }
>       }
>   

