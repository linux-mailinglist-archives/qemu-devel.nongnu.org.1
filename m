Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08CE826D9B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:17:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoYo-0008Lm-CL; Mon, 08 Jan 2024 07:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMoYh-0008Kg-UN
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:16:49 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMoYd-0004ME-Be
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:16:46 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-336c8ab0b20so1798011f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704716200; x=1705321000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OR69e3lAZEVaVghEoQAGh/Ja5wlCsQaKny79C/W3rwE=;
 b=zUxVm+oLte03Jt7cDboUJwTXIFK2om2u64i2ObUEWfKbbraiPRd/Jq07wc38WrKPci
 D1V6g33BYLUFvccsNlvPLSeGaujfWWXTguatNOekpDkpcoK/VtnaQueib9wBOCmc7i/1
 G334WFwkgaIsBsnOzhmql7CVI8mDUEFmDMfmXUS5eZDoxvjjMzUogZnKADj5+DSfCvEF
 IagpfvtI3WRVajld6pXqc4+kEGDVkxENtPc4/LI3x0U6dk/ZMnB+1FCQ7YA5AN+ngLYC
 xAAFuc3jQse94pBenFfe5UEhfERpZKWogBMVpG40AO/0e7cPETtQy4u2I8VAwWt1lvGr
 IhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704716200; x=1705321000;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OR69e3lAZEVaVghEoQAGh/Ja5wlCsQaKny79C/W3rwE=;
 b=qLKfJGIOlZL744cPauJVg52pwvJjXuuM0qAMJ+95tC5/QiQefnj4nS00IS16imbOqW
 XgOKf9qgfKCx3uq0VoxI/y9xppwHU/7cT/bsdr4Xq2pS8g12y2BVuLPwN4j/PS+t2lE7
 H19Ah0yPX8a1P0aUNzFwCWQGwIOLXiKPr8mRAlRNZqfkpt0I3cV+DIfpxm7sXbvXw/L5
 nZTSo1Jwp71qiFy/CSL53hS8PG0bRnmLIndg8HfXfEpTuk/2gf6ROXGQftJJEq7mntrB
 mKbYgiPk04vEWMSMcYCLxqRHyBlm9cWQQ9kn0DvsnjWQiRJeoHJkf2cHsoraz4qlZfuE
 5f3w==
X-Gm-Message-State: AOJu0Yz9X57NO5i7tSA+cBer0lrxc8SQrFOJ0DHiSYTzMamTbhLo+qio
 1hkHUbbFEFUSaUWncNh/WZwPCyY907MCZA==
X-Google-Smtp-Source: AGHT+IFmsGrZM6k3vCfNAOLB7rx9AHC6m4kO+iz7DVxvs8exW/oL6Ja1st+89gOCD/9Ltj0a/Bj+eg==
X-Received: by 2002:a5d:6c61:0:b0:336:5fa3:5f6a with SMTP id
 r1-20020a5d6c61000000b003365fa35f6amr2341265wrz.0.1704716200161; 
 Mon, 08 Jan 2024 04:16:40 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfd001000000b0033672971fabsm7671953wrh.115.2024.01.08.04.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 04:16:39 -0800 (PST)
Message-ID: <e8bbea10-b256-418b-8b8a-fe0a65b1e2c1@linaro.org>
Date: Mon, 8 Jan 2024 16:16:36 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/33] linux-user: Split out mmap_h_lt_g
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

On 1/2/24 05:57, Richard Henderson wrote:
> Work much harder to get alignment and mapping beyond the end
> of the file correct.  Both of which are excercised by our
> test-mmap for alpha (8k pages) on any 4k page host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 156 +++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 125 insertions(+), 31 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 00003b8329..8b0a26e50d 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -552,6 +552,128 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
>       return mmap_end(start, last, start, last, flags, page_flags);
>   }
>   
> +/*
> + * Special case host page size < target page size.
> + *
> + * The two special cases are increased guest alignment, and mapping
> + * past the end of a file.
> + *
> + * When mapping files into a memory area larger than the file,
> + * accesses to pages beyond the file size will cause a SIGBUS.
> + *
> + * For example, if mmaping a file of 100 bytes on a host with 4K
> + * pages emulating a target with 8K pages, the target expects to
> + * be able to access the first 8K. But the host will trap us on
> + * any access beyond 4K.
> + *
> + * When emulating a target with a larger page-size than the hosts,
> + * we may need to truncate file maps at EOF and add extra anonymous
> + * pages up to the targets page boundary.
> + *
> + * This workaround only works for files that do not change.
> + * If the file is later extended (e.g. ftruncate), the SIGBUS
> + * vanishes and the proper behaviour is that changes within the
> + * anon page should be reflected in the file.
> + *
> + * However, this case is rather common with executable images,
> + * so the workaround is important for even trivial tests, whereas
> + * the mmap of of a file being extended is less common.
> + */
> +static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
> +                            int mmap_flags, int page_flags, int fd,
> +                            off_t offset, int host_page_size)
> +{
> +    void *p, *want_p = g2h_untagged(start);
> +    off_t fileend_adj = 0;
> +    int flags = mmap_flags;
> +    abi_ulong last, pass_last;
> +
> +    if (!(flags & MAP_ANONYMOUS)) {
> +        struct stat sb;
> +
> +        if (fstat(fd, &sb) == -1) {
> +            return -1;
> +        }
> +        if (offset >= sb.st_size) {
> +            /*
> +             * The entire map is beyond the end of the file.
> +             * Transform it to an anonymous mapping.
> +             */
> +            flags |= MAP_ANONYMOUS;
> +            fd = -1;
> +            offset = 0;
> +        } else if (offset + len > sb.st_size) {
> +            /*
> +             * A portion of the map is beyond the end of the file.
> +             * Truncate the file portion of the allocation.
> +             */
> +            fileend_adj = offset + len - sb.st_size;
> +        }
> +    }
> +
> +    if (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)) {
> +        if (fileend_adj) {
> +            p = mmap(want_p, len, host_prot, flags | MAP_ANONYMOUS, -1, 0);
> +        } else {
> +            p = mmap(want_p, len, host_prot, flags, fd, offset);
> +        }
> +        if (p != want_p) {
> +            if (p != MAP_FAILED) {
> +                munmap(p, len);
> +                errno = EEXIST;
> +            }
> +            return -1;
> +        }
> +
> +        if (fileend_adj) {
> +            void *t = mmap(p, len - fileend_adj, host_prot,
> +                           (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED,
> +                           fd, offset);
> +            assert(t != MAP_FAILED);
> +        }
> +    } else {
> +        size_t host_len, part_len;
> +
> +        /*
> +         * Take care to align the host memory.  Perform a larger anonymous
> +         * allocation and extract the aligned portion.  Remap the file on
> +         * top of that.
> +         */
> +        host_len = len + TARGET_PAGE_SIZE - host_page_size;
> +        p = mmap(want_p, host_len, host_prot, flags | MAP_ANONYMOUS, -1, 0);
> +        if (p == MAP_FAILED) {
> +            return -1;
> +        }
> +
> +        part_len = (uintptr_t)p & (TARGET_PAGE_SIZE - 1);
> +        if (part_len) {
> +            part_len = TARGET_PAGE_SIZE - part_len;
> +            munmap(p, part_len);
> +            p += part_len;
> +            host_len -= part_len;
> +        }
> +        if (len < host_len) {
> +            munmap(p + len, host_len - len);
> +        }
> +
> +        if (!(flags & MAP_ANONYMOUS)) {
> +            void *t = mmap(p, len - fileend_adj, host_prot,
> +                           flags | MAP_FIXED, fd, offset);
> +            assert(t != MAP_FAILED);
> +        }
> +
> +        start = h2g(p);
> +    }
> +
> +    last = start + len - 1;
> +    if (fileend_adj) {
> +        pass_last = ROUND_UP(last - fileend_adj, host_page_size) - 1;
> +    } else {
> +        pass_last = last;
> +    }
> +    return mmap_end(start, last, start, pass_last, mmap_flags, page_flags);
> +}
> +
>   static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>                                       int target_prot, int flags, int page_flags,
>                                       int fd, off_t offset)
> @@ -596,37 +718,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>       if (host_page_size == TARGET_PAGE_SIZE) {
>           return mmap_h_eq_g(start, len, host_prot, flags,
>                              page_flags, fd, offset);
> -    }
> -
> -    /*
> -     * When mapping files into a memory area larger than the file, accesses
> -     * to pages beyond the file size will cause a SIGBUS.
> -     *
> -     * For example, if mmaping a file of 100 bytes on a host with 4K pages
> -     * emulating a target with 8K pages, the target expects to be able to
> -     * access the first 8K. But the host will trap us on any access beyond
> -     * 4K.
> -     *
> -     * When emulating a target with a larger page-size than the hosts, we
> -     * may need to truncate file maps at EOF and add extra anonymous pages
> -     * up to the targets page boundary.
> -     */
> -    if (host_page_size < TARGET_PAGE_SIZE && !(flags & MAP_ANONYMOUS)) {
> -        struct stat sb;
> -
> -        if (fstat(fd, &sb) == -1) {
> -            return -1;
> -        }
> -
> -        /* Are we trying to create a map beyond EOF?.  */
> -        if (offset + len > sb.st_size) {
> -            /*
> -             * If so, truncate the file map at eof aligned with
> -             * the hosts real pagesize. Additional anonymous maps
> -             * will be created beyond EOF.
> -             */
> -            len = ROUND_UP(sb.st_size - offset, host_page_size);
> -        }
> +    } else if (host_page_size < TARGET_PAGE_SIZE) {
> +        return mmap_h_lt_g(start, len, host_prot, flags,
> +                           page_flags, fd, offset, host_page_size);
>       }
>   
>       if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

