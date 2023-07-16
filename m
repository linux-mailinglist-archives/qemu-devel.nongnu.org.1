Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E81F754FDC
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 18:50:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL4vr-00055u-Is; Sun, 16 Jul 2023 12:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qL4vp-00055g-Hw
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 12:49:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qL4vn-00061f-TL
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 12:49:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbf7fbe722so37562185e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jul 2023 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689526150; x=1692118150;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A+5UpKE89JuUqv1Mi2cdt98fjmMyB8x1jSoim03pwSo=;
 b=s7e3ISNMao+5nz/5TLqdbTGKMq2HvuPYxop5B1yRn6gc/v082GHNuYJ1VhfKiXCQpC
 Fk9NOlqQmRl4wDmVq2TCMziIn0BXUugu9UYhNZDxdPJOV2K50tsa18IhfiBI/xRsK3mG
 fvvU9XkZYMX08oEASfOdLCv6sSOTuh6L84fnaNDvUBQVrucHVRz8fueiIc1Y6Dj61UB9
 pb+oLkjMMAA/NYBOvBQW4F5XRCRNsZDDtIoeXmBNcgXAAUSn3VXYbdzfCRrJt0zO5VOO
 4ynqJQVACuQTKNKIBUikKyBbhC211CwQpIqH32+cxYVZ0rSSClKVZr9eQ856Q4dDY+eP
 CXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689526150; x=1692118150;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A+5UpKE89JuUqv1Mi2cdt98fjmMyB8x1jSoim03pwSo=;
 b=WU2X6+s5IzfhwfwyVFVRrTChzc+dPPYTEIcOylEMxWwdRSDUtz4/bSswHMWaKyZq0Q
 qCe+sCeAEx+O341bl6/S23+vJUF66EsW/d1j+xqMoKcI0NBn06ar5Jomo6UBiUoFuM9o
 zUPY/iwkxH+xpzDLA8eeioUginqwuqYJZIzC9EFTWpiRv5Ak/QflGrADNWrQFZOyt40h
 /RtHQnhet9ZfhQbIDoBDv0kCjds51KASd9v9XicPdFTbyJ7a1GIlYLOFf9ERQaUiX+oJ
 bl3XGYqRQ/xhJ/8k++qaE0PbapM00NDiC5jhDdxD+d5cH2aVg56hk6az2FozKmY8H77P
 m3nw==
X-Gm-Message-State: ABy/qLa4Fz3/R7ZWfNZ4YzIL/QhhHOnUvQShYYBJfgokWDL4pusj/Q+T
 T79pqUWnXDGn4P0Ww+PMwZ5PoQrAzeYZn/VDdK3g6g==
X-Google-Smtp-Source: APBJJlEMBM4lOcx7ndWcMMaj9Jt/q6CBpzOLMrOFRY45pkGDa2g9H+TvpHP9hQ9HOp2dqEOpg1KBlA==
X-Received: by 2002:a7b:c38d:0:b0:3fc:f9c:a3ed with SMTP id
 s13-20020a7bc38d000000b003fc0f9ca3edmr10367786wmj.22.1689526149968; 
 Sun, 16 Jul 2023 09:49:09 -0700 (PDT)
Received: from [192.168.1.205] ([51.219.12.49])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a5d6947000000b00313fd294d6csm17092729wrw.7.2023.07.16.09.49.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jul 2023 09:49:09 -0700 (PDT)
Message-ID: <47b8ab9f-9302-11ce-a6df-179beefce8de@linaro.org>
Date: Sun, 16 Jul 2023 17:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/47] tcg + linux-user patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230715135317.7219-1-richard.henderson@linaro.org>
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/15/23 14:52, Richard Henderson wrote:
> The following changes since commit 4633c1e2c576fbabfe5c8c93f4b842504b69c096:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2023-07-14 16:39:46 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230715
> 
> for you to fetch changes up to 76f9d6ad19494290eb2f00d33c6a582ce3447991:
> 
>    tcg: Use HAVE_CMPXCHG128 instead of CONFIG_CMPXCHG128 (2023-07-15 08:02:49 +0100)
> 
> ----------------------------------------------------------------
> tcg: Use HAVE_CMPXCHG128 instead of CONFIG_CMPXCHG128
> accel/tcg: Introduce page_check_range_empty
> accel/tcg: Introduce page_find_range_empty
> accel/tcg: Accept more page flags in page_check_range
> accel/tcg: Return bool from page_check_range
> accel/tcg: Always lock pages before translation
> linux-user: Use abi_* types for target structures in syscall_defs.h
> linux-user: Fix abi_llong alignment for microblaze and nios2
> linux-user: Fix do_shmat type errors
> linux-user: Implement execve without execveat
> linux-user: Make sure initial brk is aligned
> linux-user: Use a mask with strace flags
> linux-user: Implement MAP_FIXED_NOREPLACE
> linux-user: Widen target_mmap offset argument to off_t
> linux-user: Use page_find_range_empty for mmap_find_vma_reserved
> linux-user: Use 'last' instead of 'end' in target_mmap and subroutines
> linux-user: Remove can_passthrough_madvise
> linux-user: Simplify target_madvise
> linux-user: Drop uint and ulong types
> linux-user/arm: Do not allocate a commpage at all for M-profile CPUs
> bsd-user: Use page_check_range_empty for MAP_EXCL
> bsd-user: Use page_find_range_empty for mmap_find_vma_reserved

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


