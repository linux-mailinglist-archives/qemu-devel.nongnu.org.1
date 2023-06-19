Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76E734C0B
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB8uu-0003Ny-FA; Mon, 19 Jun 2023 03:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8ur-0003Nb-HA
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:03:09 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8up-0004gi-4P
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:03:09 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f86bc35f13so1300305e87.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687158185; x=1689750185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TrQUH4nDrUBjfAmmtHBg06Pye4LnpmhHYiTaYGkLyqg=;
 b=QY+wRDbj+17rPylYwX6KDoQhFiLJx021LUBrEKrKQD7bbQSLgQ+iSFvSJbl8QhMHbK
 pyI0Q7lW6rZgHt2u4K/YLrunMMfSvYysbDEIzNLVFlRCNP0Izi51bYxFQ6YBHC9ZtRc0
 skxN0sjUNd1SK8J4Ew5W0y6l6+9wt8LluxJJRo/s3D4z9AaRAIrsaNvkVZvg/A1nuEzH
 t+MoldKpvfkwVgnibJurNJCogkJzi9jcQkxRVvbm1agQcUccxFMZIMBerl1CqThAxGJW
 IccSkuYh33v/2JdxLDpxjdymS0md9Jj/kKQXVS+YGzwnh1trlN+iCgdeZ23YfLSjySh1
 dE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687158185; x=1689750185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TrQUH4nDrUBjfAmmtHBg06Pye4LnpmhHYiTaYGkLyqg=;
 b=IIUFAaL0YxK3ortX1F0mdXSdu6pFlEH0v52bEED1/w85FdwLLg0G+eRM3tnzfBWQsD
 V5so2aRnO6c7Ij+WWcajWtzUlREweFO8BdlSiB9IlxRSOjSEiEIhRgroRNRlGoNOdF2X
 WwXfv1vaTZfA5GK7Vj7l3y/Iw6cMiCUk7eQdwcSLntBv6hlhUBsJxUbRsnORtzdF52UG
 WF7ubPLyw4d3MPoELDPIGBfZSbhoaUjunEqBOpaopaL+PcdWBKdcpK70cScj+GcZO9dU
 fIwcaCSlPnEH8VbVvR5QhT21VIRRUbnTWlvsSGHJLfrLGgogeTQ7SQ7z8RoqosiNKE/Z
 mT5A==
X-Gm-Message-State: AC+VfDz2hEUmQDmj/O25x2YFMxkIyzBPJuzKuNOuUJTFDIfPkc9ygRxA
 1FrL1LE+ooON3OVNPLFLht4L4Q==
X-Google-Smtp-Source: ACHHUZ7AntS9itXo0EJbyFL6ljSW6jvKvIYBRSf0bRNPeD8dZnTMt7XjJpzbrXPykTFQs3fb/j4ERw==
X-Received: by 2002:a19:5004:0:b0:4f8:7503:2041 with SMTP id
 e4-20020a195004000000b004f875032041mr356683lfb.37.1687158185305; 
 Mon, 19 Jun 2023 00:03:05 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 d17-20020a5d6dd1000000b003095bd71159sm30831533wrz.7.2023.06.19.00.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:03:04 -0700 (PDT)
Message-ID: <89dbe257-bca0-1202-1469-4dfe7ee814f5@linaro.org>
Date: Mon, 19 Jun 2023 09:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/6] utils/osdep: Introduce qemu_close_range()
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>, David Hildenbrand <david@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Nikita Ivanov <nivanov@cloudlinux.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Xuzhou Cheng <xuzhou.cheng@windriver.com>
References: <20230616152737.23545-1-bmeng@tinylab.org>
 <20230616152737.23545-5-bmeng@tinylab.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152737.23545-5-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/16/23 17:27, Bin Meng wrote:
> This introduces a new QEMU API qemu_close_range() that closes all
> open file descriptors from first to last (included).
> 
> This API will try a more efficient call to close_range(), or walk
> through of /proc/self/fd whenever these are possible, otherwise it
> falls back to a plain close loop.
> 
> Co-developed-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   include/qemu/osdep.h |  1 +
>   util/osdep.c         | 47 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index cc61b00ba9..e22434ce10 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -560,6 +560,7 @@ int qemu_open_old(const char *name, int flags, ...);
>   int qemu_open(const char *name, int flags, Error **errp);
>   int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
>   int qemu_close(int fd);
> +int qemu_close_range(unsigned int first, unsigned int last);
>   int qemu_unlink(const char *name);
>   #ifndef _WIN32
>   int qemu_dup_flags(int fd, int flags);
> diff --git a/util/osdep.c b/util/osdep.c
> index e996c4744a..fd7dd2dbdf 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -411,6 +411,53 @@ int qemu_close(int fd)
>       return close(fd);
>   }
>   
> +int qemu_close_range(unsigned int first, unsigned int last)
> +{
> +    DIR *dir = NULL;
> +
> +#ifdef CONFIG_CLOSE_RANGE
> +    int r = close_range(first, last, 0);
> +    if (!r) {
> +        /* Success, no need to try other ways. */
> +        return 0;
> +    }
> +#endif
> +
> +#ifdef __linux__
> +    dir = opendir("/proc/self/fd");
> +#endif
> +    if (!dir) {
> +        /*
> +         * If /proc is not mounted or /proc/self/fd is not supported,
> +         * try close() from first to last.
> +         */
> +        for (int i = first; i <= last; i++) {
> +            close(i);
> +        }
> +
> +        return 0;
> +    }
> +
> +#ifndef _WIN32
> +    /* Avoid closing the directory */
> +    int dfd = dirfd(dir);
> +
> +    for (struct dirent *de = readdir(dir); de; de = readdir(dir)) {
> +        int fd = atoi(de->d_name);
> +        if (fd < first || fd > last) {
> +            /* Exclude the fds outside the target range */
> +            continue;
> +        }
> +        if (fd != dfd) {
> +            close(fd);
> +        }
> +    }
> +    closedir(dir);
> +#endif /* _WIN32 */

Poor ordering of ifdefs.

#ifdef __linux__
     DIR *dir = opendir("...");
     if (dir) {
         int dfd = ...
         loop
         closedir(dir);
         return;
     }
#endif

since the first ifdef is the only way dir can ever be non-null.

> +        for (int i = first; i <= last; i++) {

typeof(i) != typeof(first).


r~

