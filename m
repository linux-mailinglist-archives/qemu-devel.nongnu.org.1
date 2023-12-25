Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C181E25B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 21:35:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHreR-0004Rn-B1; Mon, 25 Dec 2023 15:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rHreO-0004RN-7q
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 15:34:12 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rHreL-0004uy-8l
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 15:34:11 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bb85a202c2so2712132b6e.2
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 12:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703536447; x=1704141247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UPbL9faWqSfkweN3Yq5p9+TKnLVL9Th5khLFtR7JaPo=;
 b=tMRhm4CBHrwm6nUrmPEZ4mF3N+SAvZgnP8f5FoPrT+03Hyy3DZgY3AZAAHnR5ke020
 SgL49uqfn3W/KkMiax1U1On2aPkJ3qcpMg1n8gl+XY0c1PjF8U8fzcrhAUf1bvLVO5Pr
 0+Wid7IQ+2/nz+nX57hFVXxfiijTvbKuBL7rlwxf4GGr726KU+PZtW6GpUc0FAB4gKF5
 YIc+XPlfGeL4Lr1NUtKlBOL+Kx2YnHoR77UZcVXX66KTbkE2/itbJw3CCU2Qp0dPkb39
 gmkmPyUA/9p0BnNGC6mr61++p9+tiqlFIzoxfn31i6bZExigEdK13jcE7k14VCtzxthO
 +wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703536447; x=1704141247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UPbL9faWqSfkweN3Yq5p9+TKnLVL9Th5khLFtR7JaPo=;
 b=KbYBy4AmhtQEAposor0gcoG0og9QQKcCNhQRHBhiFxwgKhVjVR9vyEyxUmWkanSzxZ
 hsQXHZK8mVyBCVNo/gAapVP8uj6Aj5d4SsciZ1V2SC/RkAZfvCfLpF/aFTbJmFCNyU42
 4zJDoW0GUAeR7v0dRNP7iRVzk1VARpcdLi/YWKCj2vql/g6RF+qefwE1gIY7J7IAsXg2
 AIwxPngy1+XjokjERwnou4JjvV3zos1wojGbEKqgLwmcJknZk+5kGTszMbrgBJhlaCa2
 vFb0KKLsocAgSt89VyoI5AQfY6ckyNZzWTtgYSI6nbHXXkPdtz6ouXQ0GYOeysf4+GRl
 PD5w==
X-Gm-Message-State: AOJu0YxeuIZ9vxisN8rS+PM7Gf49ruGl4QV2RbTOyVLaMB/Xv4+YzHp4
 OJVKlQVlg/0RGeuLMUiBl2m35eSfc12BWg==
X-Google-Smtp-Source: AGHT+IFyAt5qfgSDuUJ3sB2hd0hOPOeTW0Zv8xopcoIrrIiz+DsjQ+uB/2ZYL04ebh+eO6NXBV2+lA==
X-Received: by 2002:a05:6808:2120:b0:3b8:969e:88d7 with SMTP id
 r32-20020a056808212000b003b8969e88d7mr8262265oiw.6.1703536447074; 
 Mon, 25 Dec 2023 12:34:07 -0800 (PST)
Received: from [192.168.110.87] (187.49.254.125.static.virtutel.net.au.
 [125.254.49.187]) by smtp.gmail.com with ESMTPSA id
 g8-20020a170902740800b001d0c641d220sm8473630pll.257.2023.12.25.12.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Dec 2023 12:34:06 -0800 (PST)
Message-ID: <28671cdd-c114-489c-a1c0-be11aacb7af9@linaro.org>
Date: Tue, 26 Dec 2023 07:33:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/i386: mask high bits of CR3 in 32-bit mode
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mcb30@ipxe.org, qemu-stable@nongnu.org
References: <20231222175951.172669-1-pbonzini@redhat.com>
 <20231222175951.172669-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222175951.172669-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

On 12/23/23 04:59, Paolo Bonzini wrote:
> CR3 bits 63:32 are ignored in 32-bit mode (either legacy 2-level
> paging or PAE paging).  Do this in mmu_translate() to remove
> the last where get_physical_address() meaningfully drops the high
> bits of the address.
> 
> Cc: qemu-stable@nongnu.org
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 5b86f439add..11126c860d4 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -238,7 +238,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>               /*
>                * Page table level 3
>                */
> -            pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
> +            pte_addr = ((in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18)) & a20_mask;
>               if (!ptw_translate(&pte_trans, pte_addr)) {
>                   return false;
>               }
> @@ -306,7 +306,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>           /*
>            * Page table level 2
>            */
> -        pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
> +        pte_addr = ((in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc)) & a20_mask;
>           if (!ptw_translate(&pte_trans, pte_addr)) {
>               return false;
>           }


