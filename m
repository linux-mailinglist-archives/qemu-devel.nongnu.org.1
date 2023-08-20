Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B92781E6B
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 17:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjxe-0000cK-N7; Sun, 20 Aug 2023 11:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjxa-0000by-GX
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:03:22 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjxX-0005NV-Lj
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:03:21 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34ac2e3064cso7474305ab.1
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692543798; x=1693148598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHyNteRwgNhTDLpwoQFqMheIGtBKBG1AQRAOSPbDdNI=;
 b=a6EJ2rWW7WPwEckGUH3l2SAZkBviUSco50HgvDYIw/0IJUAzyKhOP3nfgBI/Idoq+B
 IzZ3wGHXhxmiK51Q8/oBceLEHMWeawKQ8PfEhrixIlJZGi5GU4cB/jxg1JrZbY4FR2S3
 hzcGHi3RM8LNog+B1WEFh49plFVvpKZfM9aSv9HhVmqduPfbcrrwcY61b/f/aSx5wR5F
 esa71nUgXCAWPJ5Mpmr5Skr9zyNpc7oI1CJE3wJEp4Cwf070wTvL5iolwR2GDfcIUZYW
 r4wr9/WoLs4cnDl3OD1uGhrBIoDWQqbKTDZpNRqSLznMoSStFjq1HRZmpuvAmje6fxY+
 EduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692543798; x=1693148598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHyNteRwgNhTDLpwoQFqMheIGtBKBG1AQRAOSPbDdNI=;
 b=OsHsjxHpsC71BF5drBragiwKNQiXNkb6biZM++3QF72jSwkvxt2IStuPaJseA9i90I
 dvxgofrBSnhPoOn57eSWxRSYinSusM2/Ho7XA63RWqeu75fr0JFe6pfl3R1mm2/o8FWy
 qYSQxsFGc8p/ETupbmc/B0Dwuncua8UgFjXe1VRaxFvNzAhnRDxxJPoc7FStkBp/sFrr
 XsuXygGq9yLo7OdRd/Rps+XaGSikXiBm7muG+NXIkHf+1PTcMFD8/9hBwXUyEy9enFEk
 SmuWP5g4hhnJVAqG+dlkf404A7diP/eSqveUBk/AKBRbNRBAMndMnkKMR87HEK4CgGFF
 fw3A==
X-Gm-Message-State: AOJu0Yww3jVbZZXh6dD2Yp2xKrXgYRWGV83BdKedm3wydZIhR6MjBKBi
 dw4xLTCCh+arCzyCT4cf63Wp1Q==
X-Google-Smtp-Source: AGHT+IE3kM8cPo5KQW2TiXZGisUR/6Px6Yon1x2l1TAX/KcTSefatuFo+/6f6+IoiCQ0BOXexzXSlA==
X-Received: by 2002:a05:6e02:17ce:b0:32c:9c5e:900c with SMTP id
 z14-20020a056e0217ce00b0032c9c5e900cmr7291570ilu.8.1692543798093; 
 Sun, 20 Aug 2023 08:03:18 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a638c4b000000b005637030d00csm4872335pgn.30.2023.08.20.08.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 08:03:17 -0700 (PDT)
Message-ID: <404b85e2-2c62-e354-2a00-72637cfc1697@linaro.org>
Date: Sun, 20 Aug 2023 08:03:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/22] Implement do_obreak function
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=c3=abl_Urankar?= <mikael.urankar@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-18-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-18-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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
> Co-authored-by: Mikaël Urankar <mikael.urankar@gmail.com>
> 
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 85 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  7 +++
>   2 files changed, 92 insertions(+)
> 
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index edbccd3111..6f33148eb7 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -167,4 +167,89 @@ static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
>       return ret;
>   }
>   
> +#ifdef DO_DEBUG
> +#define DEBUGF_BRK(message, args...) \
> +    do { fprintf(stderr, (message), ## args); } while (0)
> +#else
> +#define DEBUGF_BRK(message, args...)
> +#endif

We are trying to get rid of all of this old-style debugging.
We are replacing them with tracepoints.

> +
> +/* do_brk() must return target values and target errnos. */
> +static inline abi_long do_obreak(abi_ulong new_brk)
> +{
> +    abi_long mapped_addr;
> +    int new_alloc_size;
> +
> +    DEBUGF_BRK("do_brk(" TARGET_ABI_FMT_lx ") -> ", new_brk);
> +
> +    if (!new_brk) {
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (!new_brk)\n", bsd_target_brk);
> +        return bsd_target_brk;
> +    }
> +    if (new_brk < bsd_target_original_brk) {
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk < bsd_target_original_brk)\n",
> +                   bsd_target_brk);
> +        return bsd_target_brk;
> +    }

These two cases may be combined, since original_brk will never be 0.

> +
> +    /*
> +     * If the new brk is less than the highest page reserved to the target heap
> +     * allocation, set it and we're almost done...
> +     */
> +    if (new_brk <= brk_page) {
> +        /*
> +         * Heap contents are initialized to zero, as for anonymous mapped pages.
> +         */
> +        if (new_brk > bsd_target_brk) {
> +            memset(g2h_untagged(bsd_target_brk), 0, new_brk - bsd_target_brk);
> +        }
> +        bsd_target_brk = new_brk;
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk <= brk_page)\n",
> +                   bsd_target_brk);
> +        return bsd_target_brk;
> +    }
> +
> +    /*
> +     * We need to allocate more memory after the brk... Note that we don't use
> +     * MAP_FIXED because that will map over the top of any existing mapping
> +     * (like the one with the host libc or qemu itself); instead we treat
> +     * "mapped but at wrong address" as a failure and unmap again.
> +     */
> +    new_alloc_size = HOST_PAGE_ALIGN(new_brk - brk_page);

We removed all HOST_PAGE_ALIGN from brk in linux-user this cycle.

> +    mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
> +                                        PROT_READ | PROT_WRITE,
> +                                        MAP_ANON | MAP_PRIVATE, -1, 0));
> +
> +    if (mapped_addr == brk_page) {
> +        /*
> +         * Heap contents are initialized to zero, as for anonymous mapped pages.
> +         * Technically the new pages are already initialized to zero since they
> +         * *are* anonymous mapped pages, however we have to take care with the
> +         * contents that come from the remaining part of the previous page: it
> +         * may contains garbage data due to a previous heap usage (grown then
> +         * shrunken).
> +         */
> +        memset(g2h_untagged(bsd_target_brk), 0, brk_page - bsd_target_brk);
> +
> +        bsd_target_brk = new_brk;
> +        brk_page = HOST_PAGE_ALIGN(bsd_target_brk);
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr == brk_page)\n",
> +            bsd_target_brk);
> +        return bsd_target_brk;
> +    } else if (mapped_addr != -1) {
> +        /*
> +         * Mapped but at wrong address, meaning there wasn't actually enough
> +         * space for this brk.
> +         */
> +        target_munmap(mapped_addr, new_alloc_size);
> +        mapped_addr = -1;
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr != -1)\n", bsd_target_brk);
> +    } else {
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (otherwise)\n", bsd_target_brk);
> +    }

It may require additional work in target_mmap, but you probably want to use MAP_FIXED | 
MAP_EXCL here.  On the linux-user side we changed to use MAP_FIXED_NOREPLACE, which is 
approximately the same thing.


r~

