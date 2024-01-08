Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A1826AE2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 10:40:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMm64-0004lJ-Ul; Mon, 08 Jan 2024 04:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMm63-0004ju-3D
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 04:39:03 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMm61-0004Nv-De
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 04:39:02 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-336990fb8fbso1585037f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 01:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704706739; x=1705311539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vDixlcU1XxwPxhGLWk/uMbdm1TE/wn893iJbxbxxk/A=;
 b=Ryc03H10UWORvc1rxBnsvmlV0kM1F2UWk0xPPmbPd2RPYn7Dk0eFOijawTjg0Ee3Mr
 un/2N0nKmcSFyAzsaXX6y26KbpS9M8NQUy7cTp+MkxxmphYUzyCCwV+qhq+3ykvG1Z/R
 71oXUBDoP+LOTlFb/UJKZ0cQb63qrav3uqwZAa+RddN3Hb2PJ0uvTdvqw7OYRTQZYSr4
 mcd2bMNi6Ak7iuainCUI8WSgclVp4ww36rJ/DJ7Wu6SeUIO3K8DazUJFe8s6uatUet26
 G45hec7wSL9XKZ0oEcqisYlOgt//UtEQ9BMUb2amTEHxtSIuYrpvNHRvt4tYUjPgUIhR
 S+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704706739; x=1705311539;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDixlcU1XxwPxhGLWk/uMbdm1TE/wn893iJbxbxxk/A=;
 b=ZKM4OvZjc/jAo52iof/muBGCJDkKxI51zN9QiFVV8GLvH/cy//+WtN53RUF2U2sqsJ
 ipVOlJ9GVt6HzcVJX11XNXZNFiimtcXlfiKBNt0Tdq1IJT39LXmxB7rxM+FpivuQeghR
 LPRUG2zU6ddeejVHCFbJsI7QaZyvpQthXQVLomcfsd70VJwDwQzoOpWaW0Ur5dmDhOM1
 CehUA1JlLnhi1mYLW2UO78kaS6qPffIVLxiR/OGERD7nccFaXMsJ3s/3Wr7qEKRJLTju
 MxeDkIoCnlTA94dqS1Nl0PJQytQnLV6zRzgYvV0Z4+f+dAU+orBn3Lc0jEHK6/bFWaKv
 emtw==
X-Gm-Message-State: AOJu0YynWx34zVIacrgY0btcQpR8oOac8pCApNkSL5k23lpw0rCyI9+2
 Nrt+2SbAfD4xZxLxJUxDzfby86SuwX089w==
X-Google-Smtp-Source: AGHT+IG/RtHeQ3xqt83F/MAssug9BMQ4m27cSlzS66z2Mp53vqsiq/9O3lJhly9eiN2M2IJN+qIGQw==
X-Received: by 2002:adf:fe8c:0:b0:337:689e:6616 with SMTP id
 l12-20020adffe8c000000b00337689e6616mr948739wrr.10.1704706738745; 
 Mon, 08 Jan 2024 01:38:58 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 i14-20020adfefce000000b00336e69fbc32sm7299020wrp.102.2024.01.08.01.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 01:38:58 -0800 (PST)
Message-ID: <070c8e36-b208-4f3a-9725-64a3deaf9441@linaro.org>
Date: Mon, 8 Jan 2024 13:38:53 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/33] linux-user/arm: Remove qemu_host_page_size from
 init_guest_commpage
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x434.google.com
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
> Use qemu_real_host_page_size.
> If the commpage is not within reserved_va, use MAP_FIXED_NOREPLACE.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 4fcc490ce6..2e2b1b0784 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -459,6 +459,7 @@ enum {
>   static bool init_guest_commpage(void)
>   {
>       ARMCPU *cpu = ARM_CPU(thread_cpu);
> +    int host_page_size = qemu_real_host_page_size();
>       abi_ptr commpage;
>       void *want;
>       void *addr;
> @@ -471,10 +472,12 @@ static bool init_guest_commpage(void)
>           return true;
>       }
>   
> -    commpage = HI_COMMPAGE & -qemu_host_page_size;
> +    commpage = HI_COMMPAGE & -host_page_size;
>       want = g2h_untagged(commpage);
> -    addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
> -                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
> +                MAP_ANONYMOUS | MAP_PRIVATE |
> +                (commpage < reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
> +                -1, 0);
>   
>       if (addr == MAP_FAILED) {
>           perror("Allocating guest commpage");
> @@ -487,12 +490,12 @@ static bool init_guest_commpage(void)
>       /* Set kernel helper versions; rest of page is 0.  */
>       __put_user(5, (uint32_t *)g2h_untagged(0xffff0ffcu));
>   
> -    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
> +    if (mprotect(addr, host_page_size, PROT_READ)) {
>           perror("Protecting guest commpage");
>           exit(EXIT_FAILURE);
>       }
>   
> -    page_set_flags(commpage, commpage | ~qemu_host_page_mask,
> +    page_set_flags(commpage, commpage | (host_page_size - 1),
>                      PAGE_READ | PAGE_EXEC | PAGE_VALID);
>       return true;
>   }

To confirm if I understand correctly, when using a reserved va, the 
contiguous address space is reserved using mmap, thus 
MAP_FIXED_NOREPLACE would fail when hitting it?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

