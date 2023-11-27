Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C167C7F96B9
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:07:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7P93-0006RO-RS; Sun, 26 Nov 2023 19:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7P8u-0006QB-HN
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7P8t-0005vq-3i
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701043585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FawdhyeOXGv7S65w6KadexojFIbWCM7dO53V7n01TDE=;
 b=Ac7AhkgQbjwR9hIdv7RzaCVVCNhMSgLDB9973QBkj4GyAfdQ9hueIKZpuk1iQ5AEKg+n1D
 Vs/uE36NqMT0LQnJG7H6nyzUZziS5bG42IMBOCb29smJtJUiCoA1Cd5pvJJRNgEo6RGz/f
 1YwVij+TXmi5q7k5eqQXjFv9hBdV8+Q=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-YZdOv-4vM9SEhYo7ZopMIw-1; Sun, 26 Nov 2023 19:06:24 -0500
X-MC-Unique: YZdOv-4vM9SEhYo7ZopMIw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3b84f2f1ad1so3167676b6e.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701043583; x=1701648383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FawdhyeOXGv7S65w6KadexojFIbWCM7dO53V7n01TDE=;
 b=iKCgC4atSIlHpIrmYPScutDdeBseQie3jn7Hmi3GotNKWde0iTxIHeedPfzVsD+tMm
 ZcwAX4lT0BhnpQgDANK+Cw8d/zRu7ExiOtPkdSLCuEsTJ7UfgAWseu2Q4jrCRL6TypP3
 V1XJqFfJxtrczCxuG8wk/MpDC+5yJ7guoPorEWAJePmyr565hZPidVIas6I+JdxBGzyh
 FDU8uKgty2jt7Agv1mte9FuZoIeXr5nMkMa+McZz2oHq3LdVhRnYp224v9Wo3/Z5QN9L
 ejfe7J14XEFIqhGsuK2ZpAyz8I9CTgsgQ9KL5zZLJcqh2cQV9arGwXw2ftmlhh3Fz8eE
 S5kg==
X-Gm-Message-State: AOJu0YwDCRUm93pYNkh1S46HTxgI3XHuXqI80vtwXzfTZ8/SjV+OgU/r
 wt51sTJBtVr5KNpo7uruIhUUlZRnL8lqcI8mFwq9w8J6aLaH1x1pOK2Q/KKRI7mQuSpSP6B9W5n
 MA85Jv0n8wk4mF5o=
X-Received: by 2002:a05:6808:618a:b0:3b2:ef9e:45af with SMTP id
 dn10-20020a056808618a00b003b2ef9e45afmr10857481oib.13.1701043583395; 
 Sun, 26 Nov 2023 16:06:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEePEX46zqcopzso76y3j6YqA/+Ffm0/PNwqV3QVlxTW4UaK8RFz5+dldmHjiks/k3GAf7b2A==
X-Received: by 2002:a05:6808:618a:b0:3b2:ef9e:45af with SMTP id
 dn10-20020a056808618a00b003b2ef9e45afmr10857468oib.13.1701043583138; 
 Sun, 26 Nov 2023 16:06:23 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a632d03000000b005897bfc2ed3sm6390025pgt.93.2023.11.26.16.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:06:22 -0800 (PST)
Message-ID: <db9450a1-8489-4a17-8c00-9e1967d55fbf@redhat.com>
Date: Mon, 27 Nov 2023 11:06:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] target/arm/kvm: Use a switch for kvm_arm_cpreg_level
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-12-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/23/23 15:42, Richard Henderson wrote:
> Use a switch instead of a linear search through data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm64.c | 32 +++++++++-----------------------
>   1 file changed, 9 insertions(+), 23 deletions(-)
> 

With the following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 504526b24c..61fb9dbde0 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -361,32 +361,18 @@ bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
>       }
>   }
>   
> -typedef struct CPRegStateLevel {
> -    uint64_t regidx;
> -    int level;
> -} CPRegStateLevel;
> -
> -/* All system registers not listed in the following table are assumed to be
> - * of the level KVM_PUT_RUNTIME_STATE. If a register should be written less
> - * often, you must add it to this table with a state of either
> - * KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
> - */
> -static const CPRegStateLevel non_runtime_cpregs[] = {
> -    { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
> -    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
> -};
> -
>   int kvm_arm_cpreg_level(uint64_t regidx)
>   {
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(non_runtime_cpregs); i++) {
> -        const CPRegStateLevel *l = &non_runtime_cpregs[i];
> -        if (l->regidx == regidx) {
> -            return l->level;
> -        }
> +    /*
> +     * All system registers are assumed to be level KVM_PUT_RUNTIME_STATE.
> +     * If a register should be written less often, you must add it here
> +     * with a state of either KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
> +     */
> +    switch (regidx) {
> +    case KVM_REG_ARM_TIMER_CNT:
> +    case KVM_REG_ARM_PTIMER_CNT:
> +        return KVM_PUT_FULL_STATE;
>       }
> -
   ^^^^

It is unrelated change and needs to be dropped?

>       return KVM_PUT_RUNTIME_STATE;
>   }
>   

Thanks,
Gavin


