Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B298275B5
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:48:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMsmh-0005jc-Hv; Mon, 08 Jan 2024 11:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMsme-0005fU-JA
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:47:29 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMsmc-0008O5-PQ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:47:28 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3366ddd1eddso2229166f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 08:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704732445; x=1705337245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3QLcArUfRYwNhpnoc8w9K8Ko4kzk0tTKn4jj/s0ot3k=;
 b=Tyu7S21owzEHZU3BUeKsI6R6bFLoLaf6lp4rkVDFwfZKzb239ojI++0bcmW2FgZOn8
 fFrTVq761Um11Yw45CdjmSOBKK7oSENHzb977dJSzdFd9VLCA5ef0J5RCMOMY2yIepLA
 MdPP9P+3Cy3lIlHMON90eLqQtvKZrR15ce6WM7FM+zMYmZDz0NLVPWeq96WjC/5O0Z69
 UE3id1sDq8pp49czRAFbCoFLaiZeJJVQed/yiY6V27qaIwbZGjOQcLg0fQdor/ER+oqi
 2qxLEZdwv+xjyZcUNVEjD9YqXL54CkQ9PKN/oKLBFToCA/zqvvk5bADhbTKIYyd0lG6G
 B/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704732445; x=1705337245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QLcArUfRYwNhpnoc8w9K8Ko4kzk0tTKn4jj/s0ot3k=;
 b=l1r3Z2H4POJnzi1J1ksAplSn+wucqcMuS4jBqryyx1QecLjbqj+xtHh8Kx1UxmGlGT
 VEDHe4fLu9t1k7fnaUsG1vEr8Cs6YrSDyIa4+oRQ5Bp0IceIEl0XOfz41nev0XYQIxiI
 6JNBRhSjNRkZaKzg+jUHoOlVSPQozx7epiOUKxTAfeQJqCjANpJqbt1Q39bUJ0O7Uhns
 r4WqJSVc0qIzOLSJ+xU8kqedmXXvfvYDOPoC4ZTkqEiWfqgcavY7zXp/5ZB6gnFek9P+
 MKY9X7IlawmwKLvyPtWYqc+8JFgVMJv6HQmWOp9mI0lHe2AdWIVB6x1ocyvfECJxd6i0
 4gAQ==
X-Gm-Message-State: AOJu0Yxmy30Ts31R5xUXaRRC+HmL9tQVxZagKoW79jXhqFKiytZzmUD0
 XMF0mLQXTjg3O3Codgd7AwA6m+bzLCTKYIIXTfrxGN9kMXo=
X-Google-Smtp-Source: AGHT+IGY7PbMTz19dkl7XyxzhIIXZUz4CViIiZijfsp2VUf52FTzt1kD9QPkwFsyiA/XqVpSL4cb0w==
X-Received: by 2002:a5d:500b:0:b0:336:7472:8768 with SMTP id
 e11-20020a5d500b000000b0033674728768mr1222202wrt.141.1704732445022; 
 Mon, 08 Jan 2024 08:47:25 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a5d4bd1000000b00336a1f6ce7csm102034wrt.19.2024.01.08.08.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 08:47:24 -0800 (PST)
Message-ID: <017d7a83-de74-4a3a-a509-94eed9ce1f44@linaro.org>
Date: Mon, 8 Jan 2024 17:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] accel/tcg: Remove tb_invalidate_phys_page() from
 system emulation
Content-Language: en-US
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231130205600.35727-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231130205600.35727-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

ping?

On 30/11/23 21:56, Philippe Mathieu-Daudé wrote:
> Since previous commit, tb_invalidate_phys_page() is not used
> anymore in system emulation. Make it static for user emulation
> and remove its public declaration in "exec/translate-all.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20231130203241.31099-1-philmd@linaro.org>
> ---
>   include/exec/translate-all.h |  1 -
>   accel/tcg/tb-maint.c         | 24 +-----------------------
>   2 files changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
> index 88602ae8d8..85c9460c7c 100644
> --- a/include/exec/translate-all.h
> +++ b/include/exec/translate-all.h
> @@ -23,7 +23,6 @@
>   
>   
>   /* translate-all.c */
> -void tb_invalidate_phys_page(tb_page_addr_t addr);
>   void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
>   
>   #ifdef CONFIG_USER_ONLY
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 3d2a896220..da39a43bd8 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -1021,7 +1021,7 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
>    * Called with mmap_lock held for user-mode emulation
>    * NOTE: this function must not be called while a TB is running.
>    */
> -void tb_invalidate_phys_page(tb_page_addr_t addr)
> +static void tb_invalidate_phys_page(tb_page_addr_t addr)
>   {
>       tb_page_addr_t start, last;
>   
> @@ -1160,28 +1160,6 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>   #endif
>   }
>   
> -/*
> - * Invalidate all TBs which intersect with the target physical
> - * address page @addr.
> - */
> -void tb_invalidate_phys_page(tb_page_addr_t addr)
> -{
> -    struct page_collection *pages;
> -    tb_page_addr_t start, last;
> -    PageDesc *p;
> -
> -    p = page_find(addr >> TARGET_PAGE_BITS);
> -    if (p == NULL) {
> -        return;
> -    }
> -
> -    start = addr & TARGET_PAGE_MASK;
> -    last = addr | ~TARGET_PAGE_MASK;
> -    pages = page_collection_lock(start, last);
> -    tb_invalidate_phys_page_range__locked(pages, p, start, last, 0);
> -    page_collection_unlock(pages);
> -}
> -
>   /*
>    * Invalidate all TBs which intersect with the target physical address range
>    * [start;last]. NOTE: start and end may refer to *different* physical pages.


