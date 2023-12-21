Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F6D81C03B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:35:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQgD-0006U2-Gq; Thu, 21 Dec 2023 16:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rGQfy-00061K-J5
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:33:55 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rGQfw-0002qz-Hb
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:33:54 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d41bb4da91so284705ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 13:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703194429; x=1703799229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y9AYMIru17thpFDzRob28Epie/dzyeV92pBFqt/hmWs=;
 b=kmGD1PSGZSDmLWUIdRY6dLIwwLe18bykbDU7zHkWqPIwegMF9ZduwVZXewRTRqgv7z
 RGjC11EF/f239BmyfXOQ3BzlITFqtyvcfVSHSGBFi+5RWiQIGr4y+h9NbzH3QKuFbIxK
 URyI75VpSbPl80XBeyLe8ouNNClyA8K19aJxEUr3Fg/LQaXrFmlg6doDStlhhp20mjFO
 xAPg0CHsNwI6B+ZCMxzhGIMENJRYhQFSY282S3fjqdf/oKfNOTGfkbHtv/o5sRH98U9r
 32CASRgr6UQKZqFnFTEgFIYRjI9w2EZE552FFdfdTxAzLKJ1H5fhxXwPxNaAfadAr8vi
 c3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703194429; x=1703799229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y9AYMIru17thpFDzRob28Epie/dzyeV92pBFqt/hmWs=;
 b=ah6zSQAIUenZUfNLQft8/wCbONADI2N68x2Y5mcnraHfij9gGpEuTOsFeiQ8Ki2pC0
 hsFSgv3eem5CFLLK+HRUfjU7abKC/kpzH7a1mOSgidGa2yYMJ1N0bhrBjqs0FldXDI6E
 TqP75ztw8SfYIZ7mPavTV4PjDuxM4M1wsincjQ99ki2vaRbk8jcvkIEZBoPbna53yG6r
 Qyhpr7jBrkSmQj4lGUp+Jtb2ikbNvRL/vvE5scpjZWpMgntWP75DG2zo9+3W/jRkjR/5
 V3nstpzjV0vZzm2oO3vmyRkfrCNConaYDTYFioEBKW+vNWL6wI7LL4JgPeBRcNESaJVT
 7kaw==
X-Gm-Message-State: AOJu0YzcSmxqEYy60G37fsYCYoH/kIL+j02c3BpJ8pfIEFfd44deCGil
 56qObmCkMh4Nr5fTv0RR92a1N9OIZP2mCg==
X-Google-Smtp-Source: AGHT+IEJ9oTdYLK4Cq2vAgLnE2pWskejBMl+0YvnFgcsAPMVCol4S8qTbHUdk7dDLyEc5b34Osd7MQ==
X-Received: by 2002:a17:902:b18d:b0:1d0:bba1:57c1 with SMTP id
 s13-20020a170902b18d00b001d0bba157c1mr229899plr.78.1703194429308; 
 Thu, 21 Dec 2023 13:33:49 -0800 (PST)
Received: from ?IPV6:2001:8004:5170:1dd0:f3d2:7d7a:220f:5fe7?
 ([2001:8004:5170:1dd0:f3d2:7d7a:220f:5fe7])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a170902eacc00b001ce5b859a59sm2088315pld.305.2023.12.21.13.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 13:33:48 -0800 (PST)
Message-ID: <1082dfde-644b-4887-bd0f-35b8cea6be26@linaro.org>
Date: Fri, 22 Dec 2023 08:33:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386: Fix physical address truncation
To: Michael Brown <mcb30@ipxe.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <25995a01-720e-485a-b7c2-36ec612a888b@ipxe.org>
 <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/22/23 02:49, Michael Brown wrote:
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
> The original truncation code (now ten years old) appears to be wholly
> redundant in the current codebase.  With paging disabled, the CPU
> cannot be in long mode and so the maximum address size for any
> executed instruction is 32 bits.  This will already cause the linear
> address to be truncated to 32 bits, and there is therefore no way for
> get_physical_address() to be asked to translate an address outside of
> the 32-bit range.
> 
> Fix by removing the address truncation in get_physical_address().
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
> Signed-off-by: Michael Brown <mcb30@ipxe.org>
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 5b86f439ad..707f7326d4 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -582,12 +582,6 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
>   
>       /* Translation disabled. */
>       out->paddr = addr & x86_get_a20_mask(env);
> -#ifdef TARGET_X86_64
> -    if (!(env->hflags & HF_LMA_MASK)) {
> -        /* Without long mode we can only address 32bits in real mode */
> -        out->paddr = (uint32_t)out->paddr;
> -    }
> -#endif

If the extension is not needed, then the a20 mask isn't either.

But I think there are some missing masks within mmu_translate that need fixing at the same 
time:

>             /*
>              * Page table level 3
>              */
>             pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;

Bits 32-63 of cr3 must be ignored when !LMA.

>         /*
>          * Page table level 2
>          */
>         pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
>         if (!ptw_translate(&pte_trans, pte_addr)) {
>             return false;
>         }
>     restart_2_nopae:

Likewise.

Looking again, it appears that all of the actual pte_addr calculations have both 
PG_ADDRESS_MASK and a20_mask applied, and have verified that bits beyond MAXPHYSADDR are 
zero via rsvd_mask.


r~

