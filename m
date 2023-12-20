Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0B08197BF
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 05:24:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFo6y-0005ev-Tf; Tue, 19 Dec 2023 23:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rFo6p-0005eQ-Pf
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:23:04 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rFo6n-0001bJ-2y
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:23:03 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6d9f7af8918so4503119a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 20:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703046180; x=1703650980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1Q1idOu3jJk0c815k5YX9I+4Fbw8G70RZvfaSmXaQI=;
 b=Vc86uawqOXbxoEeHeLRbwJlBABVr2JZmLIRRVJyuTuzHyWHxq/MeRMnokbmCr7EWVE
 FYw9FEdMJejuPWn6lVlfFT9QYKKNu41cZLTfU0NhBtQGXhkyujWMH51OeeDHjGQ1BUyk
 tlmFMQZhNt/ndlKgT6jbdswBh9CEs3wE78KXExKQ1lDlKP2jOfXek53CbHh/5X7yqnQu
 WltbDZbJI2fqRnstOkVMCgbLF761WjJIEJxlv6NQ1UT0iPCKGXHr1VEcgwWtBKRBYAmM
 OPylf6ErxbcTZzLDRjYRyuq9UNKXllgWbX0MzKIhRcrcN9t0UaEl08Vb1TOHJfAK4acJ
 z9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703046180; x=1703650980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w1Q1idOu3jJk0c815k5YX9I+4Fbw8G70RZvfaSmXaQI=;
 b=SR8cYjcHD09sKp62LFUH7fA+DL44PSV2VjyIZx4j9znkqdsZDC36j2fnr4wb8OaOO4
 OlzxrB7t1qQXmhJtPJOkyjFH+YzaJMTTW9qgHDv6CMOGqG8Unmg53FqvZyz9592XtNZ+
 2FoQURncrRCL9OvnaIu3PUxrvL+zqnzokjqx3EbuRnoxDRzdS0Y9O0/YJOAlR2oMkY1J
 oc0k0ksC/OB9tj9gMjR3ppYgtsp2nVk7KeyrqaZarsIqUxzXTQJsijfEjdJ4A26E84Cw
 1wNXKjAFffXlDubA18pEPLG3xk7wwEzX/NSq+j1lYHTIoU5H/an5aJLVBBtclzctoLby
 8rtw==
X-Gm-Message-State: AOJu0YxdMsr/i/zQlQDrrwqd7mLwHaukAaHhNq6LRn/3q9hpkq4W7KrY
 zyK4v3bkZke31lqSve06kXlVrA==
X-Google-Smtp-Source: AGHT+IHdGv192kcmjYQhK6eoSLu37VdhMPt9TG7vS/H35isApmDuKwi/1oo5N/svlfHHhDXzVdK2NQ==
X-Received: by 2002:a05:6830:143:b0:6d9:bc86:d02 with SMTP id
 j3-20020a056830014300b006d9bc860d02mr18036001otp.23.1703046179802; 
 Tue, 19 Dec 2023 20:22:59 -0800 (PST)
Received: from [192.168.1.13] ([43.252.112.169])
 by smtp.gmail.com with ESMTPSA id
 d6-20020aa78146000000b006d945660076sm496427pfn.59.2023.12.19.20.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 20:22:59 -0800 (PST)
Message-ID: <49047cf7-de12-4761-9082-dc5638d249a2@linaro.org>
Date: Wed, 20 Dec 2023 15:22:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix physical address truncation when PAE is
 enabled
Content-Language: en-US
To: Michael Brown <mcb30@ipxe.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <0102018c7d0026c1-fd5f0b50-48fd-4552-be0a-cbb6070b5e14-000000@eu-west-1.amazonses.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0102018c7d0026c1-fd5f0b50-48fd-4552-be0a-cbb6070b5e14-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 12/18/23 23:56, Michael Brown wrote:
> The address translation logic in get_physical_address() will currently
> truncate physical addresses to 32 bits unless long mode is enabled.
> This is incorrect when using physical address extensions (PAE) outside
> of long mode, with the result that a 32-bit operating system using PAE
> to access memory above 4G will experience undefined behaviour.
> 
> The truncation code was originally introduced in commit 33dfdb5 ("x86:
> only allow real mode to access 32bit without LMA"), where it applied
> only to translations performed while paging is disabled (and so cannot
> affect guests using PAE).
> 
> Commit 9828198 ("target/i386: Add MMU_PHYS_IDX and MMU_NESTED_IDX")
> rearranged the code such that the truncation also applied to the use
> of MMU_PHYS_IDX and MMU_NESTED_IDX.  Commit 4a1e9d4 ("target/i386: Use
> atomic operations for pte updates") brought this truncation into scope
> for page table entry accesses, and is the first commit for which a
> Windows 10 32-bit guest will reliably fail to boot if memory above 4G
> is present.
> 
> Fix by testing for PAE being enabled via the relevant bit in CR4,
> instead of testing for long mode being enabled.  PAE must be enabled
> as a prerequisite of long mode, and so this is a generalisation of the
> current test.
> 
> Remove the #ifdef TARGET_X86_64 check since PAE exists in both 32-bit
> and 64-bit processors, and both should exhibit the same truncation
> behaviour when PAE is disabled.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
> Signed-off-by: Michael Brown <mcb30@ipxe.org>
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 5b86f439ad..3d0d0d78d7 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -582,12 +582,10 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
>   
>       /* Translation disabled. */
>       out->paddr = addr & x86_get_a20_mask(env);
> -#ifdef TARGET_X86_64
> -    if (!(env->hflags & HF_LMA_MASK)) {
> -        /* Without long mode we can only address 32bits in real mode */
> +    if (!(env->cr[4] & CR4_PAE_MASK)) {
> +        /* Without PAE we can address only 32 bits */
>           out->paddr = (uint32_t)out->paddr;
>       }
> -#endif

This is not the correct refactoring.

I agree that what we're currently doing is wrong, esp for MMU_PHYS_IDX, but for the 
default case, if CR0.PG == 0, then CR4.PAE is ignored (vol 3, section 4.1.1).

I suspect the correct fix is to have MMU_PHYS_IDX pass through the input address 
unchanged, and it is the responsibility of the higher level paging mmu_idx to truncate 
physical addresses per PG_MODE_* before recursing.


r~

r~


>       out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>       out->page_size = TARGET_PAGE_SIZE;
>       return true;


