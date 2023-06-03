Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B7720D80
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:58:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5HSM-00024Y-Ql; Fri, 02 Jun 2023 22:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5HSL-00024E-It
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:57:29 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5HSK-0004n9-11
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:57:29 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5555a3266cbso1986232eaf.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685761046; x=1688353046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4LUSbQCV7KNxvV3319rMDJooyYLHV5o6FgCMDTtTQdU=;
 b=z0fZlbfzgr6ptSSrBS/n2f/A1J7KDnwIQPatXRxT9myviinPJmmTlEm5beCTW+fAhu
 jdu7Z+5UUMNSMipyi0IsCNSK+6sm2IM1o+2t2cLlnB14YcKWNNPI9+ZQq9fsJ9pXMMJj
 fxA+TAp+R1pZK3WQYBawF0z9sSTeIQslHZXv4lnFh1kJR5qdSn8yCeNsKQH3va7Jh8m9
 9teuV+RjvjFYHQmyB4nGnWy/NyporNnlR8Zfu7dIsHdqBiwwIFDkQ/I15VycaD4JRyH9
 Agj7RkkSSaFDcPmKzTnGIlh6Dc8nH/KAMhJEGSG4TPlCLNmlAQjjGo8N9NISWRsAQYyR
 BfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685761046; x=1688353046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4LUSbQCV7KNxvV3319rMDJooyYLHV5o6FgCMDTtTQdU=;
 b=gB+nsCXHwCdpKCPDmbcO3CV4B0F5TVEykdlbQzH+kKtOdUXV1NVnd1M4xwwYUMriQh
 6dFWljIG39uEOkdUeQEdY7vngUQMvYzNp7fUimY0RPZ6xz/gjco1Goo6CIs7n9XKUci8
 r5q3p3IW7bf0DxfW9h4sH8sAE5/HgjoSJedYkBD6FaMRsR0LsxiTxEp5xn3M1HG5VKI+
 QYOxPYm8iRrY2U8wKhCUc1N3VHhq6gTmRS5/eT4OD707RY6XAW8Lh9J0PMT3cwVxiMpy
 TUrbd2U0UmaFKp613MbPHlXT7rPwaR8YmHPLA0COjD/9XLJM2g6mY5UswnSUVNmuIuzy
 yPWg==
X-Gm-Message-State: AC+VfDwirKImLwnE1LHQfy/56USlwCd9yzWj4w3bJJNUMSK6vl44wurJ
 WMoVny2ER1jFxBTJgLIXV4zytS6NpiYhZ4lKTgc=
X-Google-Smtp-Source: ACHHUZ5ZKStPobEjKAO5G/8c5gt9chrSsjgfU0L0JfN6yBzLq00T/TXocp9GbOVZUKHspThCQnfJFQ==
X-Received: by 2002:a05:6808:293:b0:398:2177:f2c0 with SMTP id
 z19-20020a056808029300b003982177f2c0mr1974907oic.54.1685761046581; 
 Fri, 02 Jun 2023 19:57:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 fa2-20020a17090af0c200b00256353eb8f2sm3817326pjb.5.2023.06.02.19.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 19:57:26 -0700 (PDT)
Message-ID: <85f76944-5657-4680-4e24-fd69c37c3b67@linaro.org>
Date: Fri, 2 Jun 2023 19:57:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC v2] linux-user/riscv: Add syscall riscv_hwprobe
Content-Language: en-US
To: Robbin Ehn <rehn@rivosinc.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-riscv@nongnu.org
References: <f59f948fc42fdf0b250afd6dcd6f232013480d9c.camel@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f59f948fc42fdf0b250afd6dcd6f232013480d9c.camel@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 02:41, Robbin Ehn wrote:
> +struct riscv_hwprobe {
> +    int64_t  key;
> +    uint64_t value;
> +};

This needs to use abi_llong and abi_ullong, as the guest may not have the same alignment 
requirements as the host.


> +        case RISCV_HWPROBE_KEY_MVENDORID:
> +            pair->value = cfg->mvendorid;
> +            break;

You must use __get_user and __put_user to handle host vs guest endianness.  All over.


> +        case RISCV_HWPROBE_KEY_CPUPERF_0:
> +            pair->value = RISCV_HWPROBE_MISALIGNED_UNKNOWN;

Is that really what you want to expose here?  FAST is always going to be true, in that 
handling the unaligned access in the host is going to be faster than in the emulated guest.

> +        default:
> +            pair->key = -1;
> +        break;

Misalignment.

> +#if defined(TARGET_RISCV)
> +    case TARGET_NR_riscv_hwprobe:
> +        {
> +            struct riscv_hwprobe *host_pairs;
> +
> +            /* flags must be 0 */
> +            if (arg5 != 0) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            /* check cpu_set */
> +            if (arg3 != 0) {
> +                int ccpu;
> +                size_t cpu_setsize = CPU_ALLOC_SIZE(arg3);
> +                cpu_set_t *host_cpus = lock_user(VERIFY_READ, arg4,
> +                                                 cpu_setsize, 0);
> +                if (!host_cpus) {
> +                    return -TARGET_EFAULT;
> +                }
> +                ccpu = CPU_COUNT_S(cpu_setsize, host_cpus);

Where does CPU_ALLOC_SIZE and CPU_COUNT_S come from?

> +                unlock_user(host_cpus, arg4, cpu_setsize);
> +                /* no selected cpu */
> +                if (ccpu == 0) {
> +                    return -TARGET_EINVAL;
> +                }

I suppose you're just looking to see that the set is not empty?


r~

