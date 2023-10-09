Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1627BED9F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 23:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpyBn-0000Z6-2w; Mon, 09 Oct 2023 17:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpyBl-0000Ya-En
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 17:53:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpyBY-0006Aj-4w
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 17:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wfmqd6CwruCqxgT7+kbIbaqxGLL4jt8PLuIDRWU6MQg=; b=neXUQt3rAUZaajC++DAv+KgB5a
 itAQGFT1nc9r+/C/vwgLn5QFMc0pIIAeAFnePEm6gzRxmyvPuHeF51LzXqukvqWC+Ht2gBoKpa6eT
 VoVrPDhv/pBX+FSC7ta2rY3R9HSe41FEqDRFyztja/eHgS61W6V/82klKBi1z72F7pmXKGiw3euna
 99KbYn6KkwMoiztkY5SFkx/cVr98e2xzQsAdh2OEfYe4nbA455N46sZZcUomZyAm1FvBBE0Qe60r0
 B/pm5L8e2oHVzSttBbxSLRIHp6F0HSDtd8Rm8KlmIuOftNDpAYYHgVHc2k8khxYtBZsBT61n5udT5
 RWkOTwKcLkdrslXa02Yg3e2WvbjFAYju9tppZPN/5vnYpMG8txkNvvOOxS2XuKJlXH9mEVGb4yZuj
 ZyABM+Sar2kNKVrauHQrakSK8ZNkYY6NheG5CoiXnpOeFY4ckojoLpFL+6eGDAhnjNGKGfluWce95
 w3NP8O+CPGMo6WDC41mqW2A7pZzeL8eJOmEP2lXM34VepxKocgoaJkVAhE5S/wZcl2rTLfPNoHU3A
 EjVT2Ux8L7HEB6v6zsnkFMMI/EPMVRQNAnBuCmCeY4lI41hl2sapRQ+XY8EYShlpmVwPMaUGBqv0p
 +5gmdx7Fy57WXx7Ack+d46K2lKd8t4n5PlUj2QBOo=;
Received: from [2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpyBR-00061H-US; Mon, 09 Oct 2023 22:53:05 +0100
Message-ID: <52b540c1-b625-48b7-b927-ce690a71f104@ilande.co.uk>
Date: Mon, 9 Oct 2023 22:52:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
References: <20231009092434.50356-1-philmd@linaro.org>
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
In-Reply-To: <20231009092434.50356-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/sparc: Clean up global variable shadowing
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/10/2023 10:24, Philippe Mathieu-Daudé wrote:

> Fix:
> 
>    target/sparc/translate.c:2823:66: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
>                                                                     ^
>    include/tcg/tcg.h:579:17: note: previous declaration is here
>    extern TCGv_env tcg_env;
>                    ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index f92ff80ac8..26ed371109 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2820,19 +2820,19 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> -static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
> +static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env env)
>   {
>       TCGv_i32 r_tl = tcg_temp_new_i32();
>   
>       /* load env->tl into r_tl */
> -    tcg_gen_ld_i32(r_tl, tcg_env, offsetof(CPUSPARCState, tl));
> +    tcg_gen_ld_i32(r_tl, env, offsetof(CPUSPARCState, tl));
>   
>       /* tl = [0 ... MAXTL_MASK] where MAXTL_MASK must be power of 2 */
>       tcg_gen_andi_i32(r_tl, r_tl, MAXTL_MASK);
>   
>       /* calculate offset to current trap state from env->ts, reuse r_tl */
>       tcg_gen_muli_i32(r_tl, r_tl, sizeof (trap_state));
> -    tcg_gen_addi_ptr(r_tsptr, tcg_env, offsetof(CPUSPARCState, ts));
> +    tcg_gen_addi_ptr(r_tsptr, env, offsetof(CPUSPARCState, ts));
>   
>       /* tsptr = env->ts[env->tl & MAXTL_MASK] */
>       {

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


