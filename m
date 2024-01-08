Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05228269EB
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 09:56:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMlR3-0004Em-1j; Mon, 08 Jan 2024 03:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMlR0-0004E8-Eg
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:56:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMlQy-0000z7-RO
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:56:38 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e43e4890cso12018735e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 00:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704704195; x=1705308995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uG7hz9I4GBIL+psk7p6I3Fzacu4K1HkHj8+deLnK4MY=;
 b=pQjIWC0gVAEpp9mcSxPp82MLo6UfKrQWcyCQZXBjhPks86D8dJHe7fdRSnHJ3cLGTQ
 8xGUbkRg5ZDN1LbpS1iSaJaPHPtTLdtQsVEu+qI23lJg09aSl4iVbQq4W8LLbevaP1qS
 vx5zzMsG23MwF7B9AKdU56uJFPCPHssv3EBY23rL2qyGt8GkixGgmSBG65RWEwwUp72m
 kRWl8wkhJ/rSoF80BKrlxTXMxSVdrerPaLxTNZYHuX+SbejqhQ73HFLepwIXCHGddlgR
 8ebeRQhHNqkn42i8fEtMaoW0eZUWctrf+SH9vHyE7fPUA0cNoskFsllbEKprXyUtgrEq
 fOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704704195; x=1705308995;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uG7hz9I4GBIL+psk7p6I3Fzacu4K1HkHj8+deLnK4MY=;
 b=FbHgwmyNZn/iIFAr1zyXR/t6xfmhZGkZj4zbM+uIJ4vcwkTeCZS4h+OOs2dTIHcLZA
 2wYJ8EEekb58F9UJpNcq+OTLYmuyV/5TqBxz8NRR/W1X/mRl0HHKnzocCnA/PPHmMDIY
 V/EkSfGfLaFypLF45XowfsR9WdiYYvOZSkmypQtcNu++ru7rPFf7UM0DhJgeZ2SNd2tr
 E6d1ItoAB4HbDaHiiu0hcl8spwey1KNULpPyzTXeOh3s5x/33aB24RYcLtt9AKHg7gWZ
 6P3n0xHjHmC9t5ng7oFWcaDFseRu5aKxzb33pfne26nfpBqNu9jKmUtc82Tw7K+MaTcj
 qlyQ==
X-Gm-Message-State: AOJu0YzrFyWJrv8XRg1qaS6FQnPY7eFaMNhk8Z3KwdCiFhW6ZnjTyZw8
 vFnPVuOriqSbsDo5EOLg2yQtkp2Me4WYEV94T9lF47zx2MQ=
X-Google-Smtp-Source: AGHT+IFjB/Gvzi2ayjjy0Bo/8A6lqVmFdCuo68fQeV4wxYcTb/hV/PDqdbH7y+AhBuP9k45orwFpTw==
X-Received: by 2002:a05:600c:1908:b0:40e:34df:fcb7 with SMTP id
 j8-20020a05600c190800b0040e34dffcb7mr1137360wmq.134.1704704195403; 
 Mon, 08 Jan 2024 00:56:35 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a05600c4e4900b0040e38859c47sm10272245wmq.16.2024.01.08.00.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 00:56:35 -0800 (PST)
Message-ID: <031b9674-97c6-4d95-bd08-4ff6fa2761cf@linaro.org>
Date: Mon, 8 Jan 2024 12:56:33 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/33] linux-user/hppa: Simplify init_guest_commpage
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
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
> If reserved_va, then we have already reserved the entire
> guest virtual address space; no need to remap page.
> If !reserved_va, then use MAP_FIXED_NOREPLACE.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c166faabab..96d8d4f84c 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1969,16 +1969,21 @@ static inline void init_thread(struct target_pt_regs *regs,
>   
>   static bool init_guest_commpage(void)
>   {
> -    void *want = g2h_untagged(LO_COMMPAGE);
> -    void *addr = mmap(want, qemu_host_page_size, PROT_NONE,
> -                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +    /* If reserved_va, then we have already mapped 0 page on the host. */
> +    if (!reserved_va) {
> +        int host_page_size = qemu_real_host_page_size();
> +        void *want, *addr;
>   
> -    if (addr == MAP_FAILED) {
> -        perror("Allocating guest commpage");
> -        exit(EXIT_FAILURE);
> -    }
> -    if (addr != want) {
> -        return false;
> +        want = g2h_untagged(LO_COMMPAGE);
> +        addr = mmap(want, host_page_size, PROT_NONE,
> +                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
> +        if (addr == MAP_FAILED) {
> +            perror("Allocating guest commpage");
> +            exit(EXIT_FAILURE);
> +        }
> +        if (addr != want) {
> +            return false;
> +        }
>       }
>   
>       /*

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

