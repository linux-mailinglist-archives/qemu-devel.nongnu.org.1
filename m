Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FCF7E139F
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 14:24:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzd5h-0000F5-3q; Sun, 05 Nov 2023 08:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qzd5f-0000Er-Hu
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 08:22:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qzd5d-0004cm-Pw
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 08:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=awCpCMYwhetWW/A4XnXZiWCkQguf+Q0+OAXa+zaxBBE=; b=fQPVbUvlFx+bqXAT41BBsXpq+c
 snDHMFLKC2U6Uob2eXorRxJ+Oq871h4kZ1Nyd6xGGYGAfsH5QdG1qTH9/754q34o8wm0TIeBJPqGP
 e4QqSKXdqzHrt8Izrjn5xESnXCtD/zFBNd1YmC/QoA15ucUZdfXCvQPKHGmr2GCcnbhR2z3uFR3PU
 BD5Ple0vSARoQuZ58/1kKZgGTOKU9dM5S/sDx2oFKarVsSe3BZ7icp5zAej/OF6wIGuL1tPuOGvI1
 HnHl0YvzGEJOpOYCmWuuz04suYpUKHnOj+pxeradfWnhH4jDs3lCasMHyDEkN7KO6uvO6WVSXIEL0
 cTvDHt0mQmNrvdprZxtR8mDxYK/i/S9jnYwy4r9KXMLgNRGBVuBvpgtR6O3+3Nwe0HJk4FKtKcfX8
 G1pLbE+xQ4I/u0VW0FpunLwE65k96EVRObk7LnMLfTup4ftD4SFRZpKgj9uZRRMkrLe0poL49+Rif
 djO7vPsezCBCQ3ZfaQI5ACLdVHZTPUNI4bTW2F+o2wfHfsk0R/FyWQz6BI2H5XuSspYTE7NdgJ4aM
 RNRkoHWpm8slvh2lOB+SIaqZKWZD0LsYTqpYgBh5/GMljYv0xB8eusq1yhOQwcKyf/l2z5IBHu3E5
 WYl7R9J0cQRGuycCvVFXck8obAowTdVX/XJ88MMd0=;
Received: from [2a00:23c4:8bb0:5400:7e14:8a70:c9ef:7e3d]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qzd5M-0009bg-1u; Sun, 05 Nov 2023 13:22:44 +0000
Message-ID: <6e8467eb-a825-4f22-a542-b519c07417bf@ilande.co.uk>
Date: Sun, 5 Nov 2023 13:22:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231101041132.174501-1-richard.henderson@linaro.org>
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
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:7e14:8a70:c9ef:7e3d
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 00/21] target/sparc: Cleanup condition codes etc
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

On 01/11/2023 04:11, Richard Henderson wrote:
> This was part of my guess for some of the performance problems.
> 
> I saw compute_all_sub quite high in the profile at some point, and I
> believe that the test case has a partially rotated loop such that "cmp"
> is in a delay slot, and so the gen_compare fast path for CC_OP_SUB is
> not visible to the conditional branch that uses the output of the compare.
> Which means that helper_compute_psr gets called more often that we'd like.
> 
> Since almost all Sparc instructions that set cc also have a version of
> the instruction that does not set cc, we can trust that the compiler
> has only used the cc-setting version when it is actually required.
> Thus, unlike CISC processors, there is very little scope for optimization
> of the flags -- we might as well compute them immediately.
> 
> Move away from CC_OP to explicit computation of conditions.  This is
> modeled on target/arm for the (mostly) separate representation of the bits.
> We can pack icc.[NV] and xcc.[NV] into the same target_ulong, but Z and C
> cannot share.  (For "normal" setting of Z, we could share, but it is
> possible to set xcc.Z and !icc.Z via explicit write to %ccr, and for
> that we have to have two variables.)
> 
> After removing CC_OP, clean up the handling of conditions so that we can
> minimize additional setcond required for env->cond.
> 
> Finally, inline some division, which can make use of the new out-of-line
> exception path, which means we can expand UDIVX and SDIVX with very few
> host insns.  The 64/32 UDIV insn needs only a few more.  Leave UDIVcc and
> SDIV* out of line, as the overflow and saturation computation in these
> cases is really too large to inline.
> 
> r~

I've tested this series by running through my OpenBIOS boot tests for SPARC32 and 
SPARC64 and didn't spot any obvious regressions, so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

> Richard Henderson (21):
>    target/sparc: Introduce cpu_put_psr_icc
>    target/sparc: Split psr and xcc into components
>    target/sparc: Remove CC_OP_LOGIC
>    target/sparc: Remove CC_OP_DIV
>    target/sparc: Remove CC_OP_ADD, CC_OP_ADDX, CC_OP_TADD
>    target/sparc: Remove CC_OP_SUB, CC_OP_SUBX, CC_OP_TSUB
>    target/sparc: Remove CC_OP_TADDTV, CC_OP_TSUBTV
>    target/sparc: Remove CC_OP leftovers
>    target/sparc: Remove DisasCompare.is_bool
>    target/sparc: Change DisasCompare.c2 to int
>    target/sparc: Always copy conditions into a new temporary
>    target/sparc: Do flush_cond in advance_jump_cond
>    target/sparc: Merge gen_branch2 into advance_pc
>    target/sparc: Merge advance_jump_uncond_{never,always} into
>      advance_jump_cond
>    target/sparc: Pass displacement to advance_jump_cond
>    target/sparc: Merge gen_op_next_insn into only caller
>    target/sparc: Record entire jump condition in DisasContext
>    target/sparc: Discard cpu_cond at the end of each insn
>    target/sparc: Implement UDIVX and SDIVX inline
>    target/sparc: Implement UDIV inline
>    target/sparc: Check for invalid cond in gen_compare_reg
> 
>   linux-user/sparc/target_cpu.h |   17 +-
>   target/sparc/cpu.h            |   58 +-
>   target/sparc/helper.h         |   12 +-
>   target/sparc/insns.decode     |    7 +-
>   linux-user/sparc/cpu_loop.c   |   11 +-
>   linux-user/sparc/signal.c     |    2 +-
>   target/sparc/cc_helper.c      |  471 ------------
>   target/sparc/cpu.c            |    1 -
>   target/sparc/helper.c         |  171 ++---
>   target/sparc/int32_helper.c   |    5 -
>   target/sparc/int64_helper.c   |    5 -
>   target/sparc/machine.c        |   45 +-
>   target/sparc/translate.c      | 1333 ++++++++++++++-------------------
>   target/sparc/win_helper.c     |   56 +-
>   target/sparc/meson.build      |    1 -
>   15 files changed, 789 insertions(+), 1406 deletions(-)
>   delete mode 100644 target/sparc/cc_helper.c
> 


ATB,

Mark.


