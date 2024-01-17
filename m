Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A5830E6C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 22:14:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQDEa-0002Lg-MN; Wed, 17 Jan 2024 16:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rQDEX-0002K6-K8; Wed, 17 Jan 2024 16:14:01 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rQDEV-0005t5-Fn; Wed, 17 Jan 2024 16:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q+28BYL1i5DpROBlZhwL+KUeS5I+nDWCo50k+dnYzE0=; b=JbuKnm6gTucZrTaENXvXDDtPzy
 f05aoZNWb0Iw880M9K+WIyAAZMyQxhNslCwPOJTO23lTECxyDylIpY2wcB8Fah8729WZafjtwtKYU
 K3h/Q4ZCORUlL3yp7NThFH0QnWZG0FPClV9+6rYb/hEdl2DkGSD5czby7NpWbG3SQWI4pYmcYjHdr
 bcpZvxg+QXHLHEKKf9i2tVka5DPJ+ruTIbiS+B55tYZTU0q7BRDLILaiuWAceO4QVXfafpATTZEMo
 Ok988ZJo3MFGWQEOFAlX03LFU1T6kcJ77WqWP+OoYerfavsrNA12d0StTHVBdEehKT43EU1G/wmm/
 9nxjisKqDTQJpaFeQrfKkASycsfYgRiczuUkk6ceCJaDIWrsoStI9bWI02BZAhoXxgKrLdhPromOr
 dj2svooDhz21+qR2uUPlUt1cNrgXX2bfgjch8g3ScYjOoxxomNspVAgmApzQPsoLORH3Kci5Fx+bJ
 FShONkfhPASrLOvocT2FWheD1H/R6K/GKetv1FsPWNPq53fdINU8kHABspUKTeNPWK9qpIK0C4SSD
 M9CeRgnSGHROWk/MkhVJpAKN6oktChPxfWCATmugm5K3azhFfHe3EjtswPQ75WBHfmrFDWmgopGiH
 zSTK3HHzBxscWLkSCULTABf9z8fl0EymKA3ZrX3gw=;
Received: from [2a00:23c4:8bb1:9800:cb4d:caec:ef2b:5d6e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rQDDr-0000KB-5A; Wed, 17 Jan 2024 21:13:23 +0000
Message-ID: <ec729430-816e-4235-9737-9df00d90d40e@ilande.co.uk>
Date: Wed, 17 Jan 2024 21:13:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240117155143.172890-1-pbonzini@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240117155143.172890-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:cb4d:caec:ef2b:5d6e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/i386: pcrel: store low bits of physical address in
 data[0]
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 17/01/2024 15:51, Paolo Bonzini wrote:

> For PC-relative translation blocks, env->eip changes during the
> execution of a translation block, Therefore, QEMU must be able to
> recover an instruction's PC just from the TranslationBlock struct and
> the instruction data with.  Because a TB will not span two pages, QEMU
> stores all the low bits of EIP in the instruction data and replaces them
> in x86_restore_state_to_opc.  Bits 12 and higher (which may vary between
> executions of a PCREL TB, since these only use the physical address in
> the hash key) are kept unmodified from env->eip.  The assumption is that
> these bits of EIP, unlike bits 0-11, will not change as the translation
> block executes.
> 
> Unfortunately, this is incorrect when the CS base is not aligned to a page.
> Then the linear address of the instructions (i.e. the one with the
> CS base addred) indeed will never span two pages, but bits 12+ of EIP

added

> can actually change.  For example, if CS base is 0x80262200 and EIP =
> 0x6FF4, the first instruction in the translation block will be at linear
> address 0x802691F4.  Even a very small TB will cross to EIP = 0x7xxx,
> while the linear addresses will remain comfortably within a single page.
> 
> The fix is simply to use the low bits of the linear address for data[0],
> since those don't change.  Then x86_restore_state_to_opc uses tb->cs_base
> to compute a temporary linear address (referring to some unknown
> instruction in the TB, but with the correct values of bits 12 and higher);
> the low bits are replaced with data[0], and EIP is obtained by subtracting
> again the CS base.
> 
> Huge thanks to Mark Cave-Ayland for the image and initial debugging,
> and to Gitlab user @kjliew for help with bisecting another occurrence
> of (hopefully!) the same bug.
> 
> It should be relatively easy to write a testcase that performs MMIO on
> an EIP with different bits 12+ than the first instruction of the translation
> block; any help is welcome.
> 
> Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL", 2022-10-11)
> Cc: qemu-stable@nongnu.org
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1964
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2012

And also:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1759

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/tcg-cpu.c   | 20 ++++++++++++++++----
>   target/i386/tcg/translate.c |  1 -
>   2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> index 6e881e9e276..fa956d35ecd 100644
> --- a/target/i386/tcg/tcg-cpu.c
> +++ b/target/i386/tcg/tcg-cpu.c
> @@ -68,14 +68,26 @@ static void x86_restore_state_to_opc(CPUState *cs,
>       X86CPU *cpu = X86_CPU(cs);
>       CPUX86State *env = &cpu->env;
>       int cc_op = data[1];
> +    uint64_t new_pc;
>   
>       if (tb_cflags(tb) & CF_PCREL) {
> -        env->eip = (env->eip & TARGET_PAGE_MASK) | data[0];
> -    } else if (tb->flags & HF_CS64_MASK) {
> -        env->eip = data[0];
> +        /*
> +         * To ensure that bits 0..11 do not change across the translation block,
> +         * PC-relative TBs use linear addresses, i.e. addresses that have the CS
> +         * base added, for data[0].  Add the CS base back before replacing the
> +         * low bits, and subtract it below just like for non-PC-relative TBs.
> +         */
> +        uint64_t pc = env->eip + tb->cs_base;
> +        new_pc = (pc & TARGET_PAGE_MASK) | data[0];
>       } else {
> -        env->eip = (uint32_t)(data[0] - tb->cs_base);
> +        new_pc = data[0];
>       }
> +    if (tb->flags & HF_CS64_MASK) {
> +        env->eip = new_pc;
> +    } else {
> +        env->eip = (uint32_t)(new_pc - tb->cs_base);
> +    }
> +
>       if (cc_op != CC_OP_DYNAMIC) {
>           env->cc_op = cc_op;
>       }
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index cadf13bce43..e193c74472b 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -6996,7 +6996,6 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>   
>       dc->prev_insn_end = tcg_last_op();
>       if (tb_cflags(dcbase->tb) & CF_PCREL) {
> -        pc_arg -= dc->cs_base;
>           pc_arg &= ~TARGET_PAGE_MASK;
>       }
>       tcg_gen_insn_start(pc_arg, dc->cc_op);

Many thanks for coming up with the fix for this :) My test case now works fine, so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


