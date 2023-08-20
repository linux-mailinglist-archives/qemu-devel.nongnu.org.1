Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D413781EC0
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 17:37:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXkT7-0002Ke-Mo; Sun, 20 Aug 2023 11:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXkT5-0002K7-LK
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:35:55 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXkT3-00039k-Hm
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:35:55 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34c5fec2a95so4457045ab.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692545752; x=1693150552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u3G3RFZ2vPews5Y0NW2miwoknsaTs0sqmCXzCbjQ04Y=;
 b=DJIcM3Gd3RFrA7FgCLoO/yC+HZnw6FC5Onbksy9jAT81M5kfy/GRAprhp3UZsTQwWx
 dbXvuGa+OUPWEHQjCtOzbV18gbDkbBqksERXjyFDYe3Upqk/0LvmuYWKuQPXUTNWYjNf
 dLibC26A4D91go4agIbzny+6Gr+cEaRFunk8RjHnCC91zMVRFcUs5KSAbZR4513zviKX
 w+GBQp0OlnBn5t0Mj/QjcNbBm9o/aAClIjBbTn68LWA6EzOZ6lW20A0Oz3bfRTJbypNs
 QMcwt/bMVzHKzcvM+o7/947gwABYpMhW6WUFZnd7IJtRS6x/xMVGinNjv7u101eaO0gJ
 +uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692545752; x=1693150552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u3G3RFZ2vPews5Y0NW2miwoknsaTs0sqmCXzCbjQ04Y=;
 b=cwxHXLs9o/PfcZBBwpDf2TTGqA2SF9YSm1loRKZREBm+kCOrqEGGn52p22wowJLrwS
 HXQbWiq/uI5kNRxC2K58UBeyLpHfebBivX3N69ojI9bdcEJNArHrQYkU8m9IBDlSagFA
 VrIr02ks5RcRQlsbvEs0kZZA9Gc3SlrI3Q1gfWUZx1dbzb/kbH9vqy7qziJZ4C4DTa3M
 Y5Sbtqgl/DtQa7KA1cJazg3FUNUjcZ2tHhTUPDqaMe4+D+GVFQy1OMfXQmgV5szezNHU
 XjOW4j5OCagPzxllFp1+C2we1eMzXEKd/BR7uQu2AUc/3sQ9d6EpBTsOvSG5u7+OB89v
 8wzA==
X-Gm-Message-State: AOJu0YwYOz4H5zEpuT9ywJJodpeoaY6vrKgQiCsWvbFLpAD0CL1foG1w
 +Qua4DlyUt263veXTfLMWOnz7g==
X-Google-Smtp-Source: AGHT+IHb4wLM5je/cnKDhuIdqzzfOTrU9aJ1qfR7kBj0MtCMFMpt2vONTksBKwar8jTE5RLt+PjtVA==
X-Received: by 2002:a05:6e02:1a87:b0:348:cab1:4d5c with SMTP id
 k7-20020a056e021a8700b00348cab14d5cmr6814503ilv.10.1692545751822; 
 Sun, 20 Aug 2023 08:35:51 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 s28-20020a63925c000000b0056ae1af610asm1539887pgn.58.2023.08.20.08.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 08:35:51 -0700 (PDT)
Message-ID: <a19d1f1d-c303-c413-86ad-7edfb237cb7f@linaro.org>
Date: Sun, 20 Aug 2023 08:35:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 22/22] Add stubs for vadvise(), sbrk() and sstk()
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-23-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-23-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:48, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> The above system calls are not supported by qemu.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 21 +++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index f737b94885..274178bef7 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -407,4 +407,25 @@ static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
>       return get_errno(shmdt(g2h_untagged(shmaddr)));
>   }
>   
> +static inline abi_long do_bsd_vadvise(void)
> +{
> +    /* See sys_ovadvise() in vm_unix.c */
> +    qemu_log("qemu: Unsupported syscall vadvise()\n");
> +    return -TARGET_ENOSYS;
> +}

I see EINVAL not ENOSYS.

> +static inline abi_long do_bsd_sbrk(void)
> +{
> +    /* see sys_sbrk() in vm_mmap.c */
> +    qemu_log("qemu: Unsupported syscall sbrk()\n");
> +    return -TARGET_ENOSYS;
> +}
> +
> +static inline abi_long do_bsd_sstk(void)
> +{
> +    /* see sys_sstk() in vm_mmap.c */
> +    qemu_log("qemu: Unsupported syscall sstk()\n");
> +    return -TARGET_ENOSYS;
> +}

I see EOPNOTSUPP not ENOSYS.

I don't see any point in logging these.


r~

