Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF316781EBF
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 17:32:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXkO3-0000sO-G0; Sun, 20 Aug 2023 11:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXkO1-0000s0-Dq
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:30:41 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXkNz-00027n-70
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:30:41 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1c0fcbf7ae4so1903956fac.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692545438; x=1693150238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gWA1rsa3Zngk5L0icJ3nN8WQR+WE6QqP+bdZA8fErZY=;
 b=YllXd1v405Aut4ZX/WStiK0Xdd2NhXWC6VGRciKIQSOpQAPCtj5X/Fk833RMROZUtR
 tZmxmEydww4VAwWr2dumSY8nz/5o/V6YaFT7S8mfQou7/oYPGg7nEfw2afA1CKHql5Zc
 Lc4c968rBq943Gf8BJrhUSeKbPr0qjjqKzi1sYZpSQLgdmTvdKbE6/F8VO40t0IiRQfr
 C8xcYZn+wmk1MkY2rezfBt43E30TAmux41ZilDggi7o4klSgLNKyLzV6+I7JpgRmv1MI
 fYoogFytLsjLzQzIm0LNy9lNVdC57+Uh5uxX2fQbNoSBY3lZjKg7qXM3AP8eitKEU6vE
 ZOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692545438; x=1693150238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gWA1rsa3Zngk5L0icJ3nN8WQR+WE6QqP+bdZA8fErZY=;
 b=QkedNWFVeerhcnoyhofc8IeSYk3oaQlaw81wKID+ekedTc/GjN3fJfR6V1BVCM7cyj
 iUuVsjD07UORMZi8bfNzarDgFeinixIbZyVZ2+Fd2RExPncHNmF4xF3T9nTbpuXRTzk2
 Oin0KQPJzutiz+EKFsUXp6N95lPlJWaGhHYAwIhbMJlCAXuWdab8CdkJa6+/gksMQdr7
 HKPClKnwp+87eOrw/CPAOsJSgvXB8XK45gBKP4r3z5hflokAQv8WvkSNVD4aaUsn3Uyh
 ba8F5DxH5D4zV54oMkF4TKwEf4gXLpxmu2SfRu70uL6pPWcZJ7McdlPoOHL6TqKRFttj
 v3aQ==
X-Gm-Message-State: AOJu0Yy9JsdxGdXGMchYGMurhrFAiCvt1jbL+OFfiPKR84U6uowPc+/S
 B5Q8LIQxDvFgudgqQUdcfigxWw==
X-Google-Smtp-Source: AGHT+IES0hwK+HvAJ1QpEeH5w1qGhiuIofrh0XvHT51SgGZf4w9Q8BELiFEDX41k59cy4L0tOznaaQ==
X-Received: by 2002:a05:6870:64a8:b0:1a6:b183:b0ab with SMTP id
 cz40-20020a05687064a800b001a6b183b0abmr6605455oab.40.1692545436966; 
 Sun, 20 Aug 2023 08:30:36 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 cx17-20020a17090afd9100b00262eccfa29fsm6367804pjb.33.2023.08.20.08.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 08:30:36 -0700 (PDT)
Message-ID: <eb0506c6-f9bd-5a1f-870b-b6d07dd337ea@linaro.org>
Date: Sun, 20 Aug 2023 08:30:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 21/22] Implement shmat(2) and shmdt(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-22-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-22-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 8/19/23 02:48, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 72 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  8 ++++
>   2 files changed, 80 insertions(+)
> 
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index 221ad76d8c..f737b94885 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -335,4 +335,76 @@ static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
>       return ret;
>   }
>   
> +/* shmat(2) */
> +static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
> +{
> +    abi_ulong raddr;
> +    abi_long ret;
> +    void *host_raddr;
> +    struct shmid_ds shm_info;
> +    int i;
> +
> +    /* Find out the length of the shared memory segment. */
> +    ret = get_errno(shmctl(shmid, IPC_STAT, &shm_info));
> +    if (is_error(ret)) {
> +        /* Can't get the length */
> +        return ret;
> +    }
> +
> +    mmap_lock();
> +
> +    if (shmaddr) {
> +        host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);

Missing

     if (!guest_range_valid_untagged(shmaddr, shm_info.shm_segsz)) {
         return -TARGET_EINVAL;
     }

> +    } else {
> +        abi_ulong mmap_start;
> +
> +        mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
> +
> +        if (mmap_start == -1) {
> +            errno = ENOMEM;
> +            host_raddr = (void *)-1;
> +        } else {
> +            host_raddr = shmat(shmid, g2h_untagged(mmap_start),
> +                shmflg); /* | SHM_REMAP XXX WHY? */

With reserved_va, the entire guest address space is mapped PROT_NONE so that it is 
reserved, so that the kernel does not use it for something else.  You need the SHM_REMAP 
to replace the reservation mapping.

> +/* shmdt(2) */
> +static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
> +{
> +    int i;
> +
> +    for (i = 0; i < N_BSD_SHM_REGIONS; ++i) {
> +        if (bsd_shm_regions[i].start == shmaddr) {
> +            bsd_shm_regions[i].start = 0;
> +            page_set_flags(shmaddr,
> +                shmaddr + bsd_shm_regions[i].size, 0);
> +            break;
> +        }
> +    }
> +
> +    return get_errno(shmdt(g2h_untagged(shmaddr)));
> +}

Hmm, bug with linux-user as well, because here we should re-establish the reserved_va 
reservation.

Also, we should not be using a fixed sized array.  Nothing good happens when the array 
fills up.


r~

