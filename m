Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7C7CB33F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:18:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT5w-0002tx-Rf; Mon, 16 Oct 2023 15:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsT5s-0002tg-6m
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:17:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsT5p-0004w8-V5
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p740/83dhNpJWhv2bWpPz1XQRdtZN8Oqdr4U3BAi2IA=; b=miuBgEQizJDLIUBJwld+rE9nME
 ZW7Zu0J24bZFDanRdhOEikBGX7ykI1HgsDYGGh6d7aEqt2TO+7DbG2X0ffQ8304SwyieUVB1TBcw+
 5SKIhNJ6Klz4O/Kvx1OXduyqK0kWdZHSVojahXT+K9I4elgtEkEQyNRI6LQ1aSWvC1fxcfNS7Ckhc
 ZD21ZEw6nmyB/n293rcQONb3BFLrA00f9WB2VYCRRSl/3z+MrSMxCPtDn3AoQXsdj/grj+kDLcOl4
 Orhje5ZLyX7Mq3JtIp/gaKtO6WQ1tRkO0xMAyNIcbvwzLuGNXYaYvZlUK6kJpeh42azqGh4tffVtS
 JA6rU23QvwTkGwtGSFGPc4KxjCREfWl96nfCILzftGNlh3a5PRZjdxmfT/BOlBt5RJZ7Rg5atLhde
 dAbOAkxaRJZA8RMlEPOFXdHSiweKbB+Y9iaksw0X4N7jPQQKt/8Nh9odzgPuscLnk4TFbUaoHiQhB
 +ZrmMAViqUUTLFPLw9YAU5EyJKSIpdq7BOkMw9Hhxh8CizIBRDrNUz2BMoM2J7TagoALYY7ZxBsRu
 saP7L1wHmFgGPGRN5Ofx/3S6DWpv28d8ev2XRYX+UaJT8AzbaNSq+7jGQDHorWE813qJA2v4NBDz3
 XaB3gL3Npx0MsWe359QTt6x2e+vj1At24JbAsgZJ0=;
Received: from [2a00:23c4:8baf:fd00:ce7b:a14e:3566:a0fe]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsT5d-000431-3i; Mon, 16 Oct 2023 20:17:25 +0100
Message-ID: <7c4c0538-b1ce-417f-8ed5-266f0ee08f97@ilande.co.uk>
Date: Mon, 16 Oct 2023 20:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231015232454.391788-1-richard.henderson@linaro.org>
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
In-Reply-To: <20231015232454.391788-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:ce7b:a14e:3566:a0fe
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/sparc: Clear may_lookup for npc == DYNAMIC_PC
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

On 16/10/2023 00:24, Richard Henderson wrote:

> With pairs of jmp+rett, pc == DYNAMIC_PC_LOOKUP and
> npc == DYNAMIC_PC.  Make sure that we exit for interrupts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Mark, I wonder if this will cure some of your lost interrupt issues.
> Spotted while looking at issues from the JMPL+RETT+RETURN patch.
> 
> r~

Yes, I believe it does! I've just tried this on my Solaris 8 image and I no longer 
see any lockups when wiggling the mouse :)  Presumably this needs a CC: qemu-stable 
and a Fixes: tag along with:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

> ---
>   target/sparc/translate.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index f92ff80ac8..8fabed28fd 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -5654,10 +5654,10 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>               break;
>           }
>   
> +        may_lookup = true;
>           if (dc->pc & 3) {
>               switch (dc->pc) {
>               case DYNAMIC_PC_LOOKUP:
> -                may_lookup = true;
>                   break;
>               case DYNAMIC_PC:
>                   may_lookup = false;
> @@ -5667,10 +5667,24 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>               }
>           } else {
>               tcg_gen_movi_tl(cpu_pc, dc->pc);
> -            may_lookup = true;
>           }
>   
> -        save_npc(dc);
> +        if (dc->npc & 3) {
> +            switch (dc->npc) {
> +            case JUMP_PC:
> +                gen_generic_branch(dc);
> +                break;
> +            case DYNAMIC_PC:
> +                may_lookup = false;
> +                break;
> +            case DYNAMIC_PC_LOOKUP:
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +        } else {
> +            tcg_gen_movi_tl(cpu_npc, dc->npc);
> +        }
>           if (may_lookup) {
>               tcg_gen_lookup_and_goto_ptr();
>           } else {


ATB,

Mark.


