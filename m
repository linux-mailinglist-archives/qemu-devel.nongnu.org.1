Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 243ECB81C11
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 22:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyyjR-0007tJ-P5; Wed, 17 Sep 2025 16:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyyjO-0007t0-V1
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:26:23 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyyjN-0003uy-93
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=2+kq3Eq4UP3InnlakAuwNiofbxXHE/tI9tY1Tkj6K4k=; b=ksCOH04C89p/DNyEl2ycUso17N
 E5vcsPZ1Mo4HD5TT9tYg5VXrDfzbzBBY4n+Dvdj+UQk7kVXZC7s5xBauMGEQM2jO1+rE6/JP57ZjK
 KU4Gxw/uozyxTNgTpc3wByDQZYlycmbOiq0V+P2SF2c9Q8HV12qdwvOPAlR9x2E84qjd2msvQnjtS
 LalM95H4WyucTYxWJ4SD5LJJB30apFqk284j0Z2hkPnm5m54zEe2iZMOsEp+8oBbbtI4H1z/JgbBJ
 Nc9uyw+R2LAOzSPSBNvUtY7NzWxwxLrVWYf54nYxfQVzVfS6srN/FtMoOAFkdLq0xTm97hQtn7zLv
 dhBwLO/3drhrqAlTQNe05n3tqYml/kLSn1Sq3dYSn87DR8LVxO2G7ZqsBjSDBNMafn4YV8/a7dBl+
 fWje2Cyvs+X89PweqQEVwze5LblRpMjJecyaE2CTwir6Vdu4bIeakAJ9qRXQo5K7iwpDWkDROYecI
 xqdgY4XBy9SIkJLELVPrPSgSBZAarDUzfO13gkB28Yst4OLpTgFokctNKdv1kzsPStKWFP1X6lvPy
 mkegS8x5LDeugCQFeNfGCuFbc/NoGnY5HDcqvVnhJyJgfI59W42r0iWk6MYJFJuRfr9AXejO9nl7J
 A9zFWpqZAzrcU/54qkytHe3Ltrp2hFaZ317MOa5R8=;
Received: from [2a02:8012:2f01:0:ff11:26c7:ce3f:b269]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyyhK-000AMM-2Y; Wed, 17 Sep 2025 21:24:18 +0100
Message-ID: <a0b6d92e-6cb7-4d78-b327-0120d9264749@ilande.co.uk>
Date: Wed, 17 Sep 2025 21:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20250905115128.376295-1-richard.henderson@linaro.org>
 <20250905115128.376295-5-richard.henderson@linaro.org>
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
In-Reply-To: <20250905115128.376295-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:ff11:26c7:ce3f:b269
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 4/7] target/sparc: Loosen decode of RDPSR for v7
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

On 05/09/2025 12:51, Richard Henderson wrote:

> For v7, bits [18:0] are ignored.
> For v8, bits [18:14] are reserved and bits [13:0] are ignored.
> 
> Fixes: 668bb9b755e ("target/sparc: Move RDPSR, RDHPR to decodetree")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 74848996ae..1c6403ad8a 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -158,14 +158,16 @@ CALL    01 i:s30
>   }
>   
>   {
> -  RDPSR             10 rd:5  101001 00000 0 0000000000000
> -  RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
> +  [
> +    RDHPR_hpstate       10 rd:5  101001 00000 0 0000000000000
> +    RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
> +    RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
> +    RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
> +    RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
> +    RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
> +  ]
> +  RDPSR                 10 rd:5  101001 ----- - -------------
>   }
> -RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
> -RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
> -RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
> -RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
> -RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
>   
>   {
>     WRPSR             10 00000 110001 ..... . .............  @n_r_ri

This looks like it matches the behaviour of the old decoder.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


