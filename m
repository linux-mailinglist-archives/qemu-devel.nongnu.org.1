Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E22828B62
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:43:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNG7j-0006gm-PT; Tue, 09 Jan 2024 12:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNG7f-0006dp-7U
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:42:43 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNG7a-000848-Gp
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:42:41 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6dde882e5ccso363763a34.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704822155; x=1705426955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=53lziAUMWxraWZMqgeq7a80JdQqfRhcqMRb3/zt6Asw=;
 b=lZ5MMW4WbLGiJB0BYCXMvitV+r+Ev4VUFpxVttD3xiKvGs5j5jwDZrBDMDwZJj+qHf
 AjDO7xho3S8DcTsdA9cc8bKMbNHLiScBf68Rl12/OXufXmjLaFvQrLWZK4ITMZQnqd26
 G0GF30C4nmlS3yE+XUSwa+96hMA7k/ZA+QzZYMrLicKar44rF36FlJF6djJRJvKMoHLD
 53J51M4+lsDQPfuLIKCxECD8PCjtscQvPD8QJGtHTH5h0jJdNlhR3Ta0qrgi6sXVTmyx
 XdmcXAvLwbT/KbZO+T9zLKZDpiiRAMMwldpSbu3xkMYLIBt+bSePEOW7hN816S0zZLh3
 lj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704822155; x=1705426955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53lziAUMWxraWZMqgeq7a80JdQqfRhcqMRb3/zt6Asw=;
 b=TTjX2dG0EI8aeZ7AR3LIWedeSFnrlYhtSVMdEmomrsP/aqD6V+9doiIUUzjMB1YwFX
 X7T1YHyaVLSVzidsdRGnMAItxHRsMwhHdtaR4ZWP3PqrKq2x/z+5HA9GURON2AWoad5w
 bGTo23HUyO8KmT/zC2uF1/jdDVwgJgvp95VDgbhVje5Cpl5zJPC0ryl/fMF+58p7xFSY
 Nvqkrzy/70ii4OMJRW9Oc2jBsOxLnWFAmBGIgg8neBOP5X79pXo3+kcbK36BTMOg9w/j
 7Z4Z5DhTqbgpctwttmlGvp24zJrchDPe8O6RHtAtRq58c9jyWDeIbYq90XyLwwJq6ZGC
 lwcw==
X-Gm-Message-State: AOJu0YxpawoiQbO/MLHXsFzli/SpgWkdwASmkIg1s3xgj+AY2hB4ZFrA
 HtePN3FvTRoYAIZ55c1nmr0swl9e/UC7Zg==
X-Google-Smtp-Source: AGHT+IHxUMMYJ/vAbIQlNFckjGkIgPJs+GLjgPsKFbCHiyvDz5gA/hBhrn4ZU0Ho1Nznt8vVdOJHEA==
X-Received: by 2002:a05:6870:b613:b0:206:2550:d22d with SMTP id
 cm19-20020a056870b61300b002062550d22dmr4904922oab.46.1704822155304; 
 Tue, 09 Jan 2024 09:42:35 -0800 (PST)
Received: from [192.168.47.227] ([172.58.111.136])
 by smtp.gmail.com with ESMTPSA id
 pt7-20020a0568709e4700b002064e3ae6e7sm535893oab.0.2024.01.09.09.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 09:42:34 -0800 (PST)
Message-ID: <0195c274-0d5c-484b-9475-84a4d16bfae8@linaro.org>
Date: Wed, 10 Jan 2024 04:42:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user: Allow gdbstub to ignore page protection
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20240108233821.201325-1-iii@linux.ibm.com>
 <20240108233821.201325-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240108233821.201325-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 1/9/24 10:34, Ilya Leoshkevich wrote:
> gdbserver ignores page protection by virtue of using /proc/$pid/mem.
> Teach qemu gdbstub to do this too. This will not work if /proc is not
> mounted; accept this limitation.
> 
> One alternative is to temporarily grant the missing PROT_* bit, but
> this is inherently racy. Another alternative is self-debugging with
> ptrace(POKE), which will break if QEMU itself is being debugged - a
> much more severe limitation.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   cpu-target.c | 55 ++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index 5eecd7ea2d7..69e97f78980 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -406,6 +406,15 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>       vaddr l, page;
>       void * p;
>       uint8_t *buf = ptr;
> +    int ret = -1;
> +    int mem_fd;
> +
> +    /*
> +     * Try ptrace first. If /proc is not mounted or if there is a different
> +     * problem, fall back to the manual page access. Note that, unlike ptrace,
> +     * it will not be able to ignore the protection bits.
> +     */
> +    mem_fd = open("/proc/self/mem", is_write ? O_WRONLY : O_RDONLY);

Surely this is the unlikely fallback, and you don't need to open unless the page is 
otherwise inaccessible.

I see no handling for writes to pages that contain TranslationBlocks.


r~

>   
>       while (len > 0) {
>           page = addr & TARGET_PAGE_MASK;
> @@ -413,22 +422,33 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>           if (l > len)
>               l = len;
>           flags = page_get_flags(page);
> -        if (!(flags & PAGE_VALID))
> -            return -1;
> +        if (!(flags & PAGE_VALID)) {
> +            goto out_close;
> +        }
>           if (is_write) {
> -            if (!(flags & PAGE_WRITE))
> -                return -1;
> +            if (mem_fd == -1 ||
> +                pwrite(mem_fd, ptr, len, (off_t)g2h_untagged(addr)) != len) {
> +                if (!(flags & PAGE_WRITE)) {
> +                    goto out_close;
> +                }
> +                /* XXX: this code should not depend on lock_user */
> +                p = lock_user(VERIFY_WRITE, addr, l, 0);
> +                if (!p) {
> +                    goto out_close;
> +                }
> +                memcpy(p, buf, l);
> +                unlock_user(p, addr, l);
> +            }
> +        } else if (mem_fd == -1 ||
> +                   pread(mem_fd, ptr, len, (off_t)g2h_untagged(addr)) != len) {
> +            if (!(flags & PAGE_READ)) {
> +                goto out_close;
> +            }
>               /* XXX: this code should not depend on lock_user */
> -            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
> -                return -1;
> -            memcpy(p, buf, l);
> -            unlock_user(p, addr, l);
> -        } else {
> -            if (!(flags & PAGE_READ))
> -                return -1;
> -            /* XXX: this code should not depend on lock_user */
> -            if (!(p = lock_user(VERIFY_READ, addr, l, 1)))
> -                return -1;
> +            p = lock_user(VERIFY_READ, addr, l, 1);
> +            if (!p) {
> +                goto out_close;
> +            }
>               memcpy(buf, p, l);
>               unlock_user(p, addr, 0);
>           }
> @@ -436,7 +456,12 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>           buf += l;
>           addr += l;
>       }
> -    return 0;
> +    ret = 0;
> +out_close:
> +    if (mem_fd != -1) {
> +        close(mem_fd);
> +    }
> +    return ret;
>   }
>   #endif
>   


