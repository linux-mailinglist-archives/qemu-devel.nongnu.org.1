Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D33AC5A99
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 21:22:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJzsb-0005Jr-Of; Tue, 27 May 2025 15:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uJzsS-0005J1-2Z
 for qemu-devel@nongnu.org; Tue, 27 May 2025 15:22:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uJzsN-0007vd-NM
 for qemu-devel@nongnu.org; Tue, 27 May 2025 15:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=m8bEWoUXls00jnm5oLmkQjOeYFyjKBwb2vYpSvweXk4=; b=p0WgScbNNBu2NYvRqvQnsGz2Mq
 zcYVXyaf5zrK9UusLsm/sUaH9PEafas7npLHku23/uwe75norEI13r9f2oEKWOhXD2yO4avmsqdwJ
 TXe8zSnI00u8SB3+yU1m2WkYINtnZitQaSOrlj0gH3HBhDFy5kIfMF+vW4mH/dPJjtgqDDXMB9GpM
 MKtKeMmsmNuQ8FQTJ4IgxH0DTlhsFZAAnqPXPNUmHF37cf7neFqyS5pAXtry+8HujZZ2hohIGAwIk
 OghG8f2mOgx8oRqUbDbH+uV3PiJ3TgC/8p8Gdx8VbVljf3lEhDPoZoW/Np34gHPOUs/4DDwobh1ta
 x+aiw7ppNP26fE0ewzJ1goSmnJaQclkT6QE33TqNNCA3M7GmKTBkJE8kj78YxxzuAYauugILObR6H
 HXQ51lojEgYuGgqhXjTzM5A2vUP2isS6U0pcjz0Wmued8L7z/X9XcR1Mh1qX5pkMeAFKrdta/UwHr
 wNJpbbMLdfMvgKkJ5BNItK5uNz+aUZwl139t28gsc6y5LZYKdOpLaC9lWK4FV0JUPzeCrCGn8rpdc
 T6LEspvByMbrVvvbxRggdPC1R30hQwsOr8dO2Pj0WJZov5HBKUM0UzvUZqlLwTlFJBwsej/Rb0qL6
 iTdUtglnTgNDLVej1Mc8jXQMRpGTP1oLXmIKVVFvs=;
Received: from [2a02:8012:2f01:0:7607:4cc5:5176:1da8]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uJzqy-000229-O3; Tue, 27 May 2025 20:20:49 +0100
Message-ID: <aed43e5f-21a0-49a8-a779-e4619d1e9fde@ilande.co.uk>
Date: Tue, 27 May 2025 20:22:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20250425093513.863289-1-chigot@adacore.com>
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
In-Reply-To: <20250425093513.863289-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:7607:4cc5:5176:1da8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/sparc: don't set FSR_NVA when comparing unordered
 floats
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

On 25/04/2025 10:35, Clément Chigot wrote:

> FSR_NVA should be set when one of the operands is a signaling NaN or
> when using FCMPEx instructions. But those cases are already handled
> within check_ieee_exception or floatxx_compare functions.
> Otherwise, it should be left untouched.
> 
> FTR, this was detected by inf-compare-[5678] tests within gcc
> testsuites.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   target/sparc/fop_helper.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
> index c25097d07f..b57da7c9ea 100644
> --- a/target/sparc/fop_helper.c
> +++ b/target/sparc/fop_helper.c
> @@ -446,7 +446,6 @@ static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
>       case float_relation_greater:
>           return 2;
>       case float_relation_unordered:
> -        env->fsr |= FSR_NVA;
>           return 3;
>       }
>       g_assert_not_reached();

Thanks! I've added Richard's R-B and applied this to my qemu-sparc branch.


ATB,

Mark.


