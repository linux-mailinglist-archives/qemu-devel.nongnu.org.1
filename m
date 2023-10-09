Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D1C7BEABE
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 21:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpw6M-00074P-DS; Mon, 09 Oct 2023 15:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpw6K-00073r-Rx
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 15:39:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpw6J-0002Z3-DA
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 15:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=od/z5RQzsklyDW4fuo16kR7Cl3x4mUpDp1yMlMzcxQ8=; b=F4WgctcZBCfnY2V2jvJboV1W25
 4q4DOk1uLkyw8dOGseZsBWbqsRjq9QAq7/VPgrrfjOfUEtbrQsMvLdvTFL9Vw7AFx2ga/9NDAledB
 RUzzWF6NTvt0sq8QMciJH/moyoiX8SCdfPc5Ai+bQzzLVE7OFZTkR8P1G5lZHKsCTtwdykAqj3L9X
 Dua9isfVj5g7bFi5spO/4+Qq19mJCfdIuwVfiRhhhrWAUVxRc+RqP+XpPMtqB/tK2XiKXclLOlYvA
 b2XFYH2hSjwXvU9PzgqvXpBUAP7ZfUayuX/z866NtX1h1RP3Fp4aGZXTnlSjYVdVph7bKL5d0/wGq
 t6P3x4lwz8HJA9kvxMOuqJ9Htw2V5ajuZ9yZR5IKgS22O1IQKbJQi8On04J6bbp6Ww8D6nIjbQQ4x
 9S01YdbcLkv750OIYmkxsCrOBK4kaZ4Htq2GSgixfowFH8EGSbIF0wDErYN4hcJjt1B2PIOKbvrel
 5wjwLXu2C28B1hztf8HP0ITHGOKwWkN25WTlAsQsWkYxu3IKY2nLayXxqn62KWnh3K53GnykvhTT+
 W/l3r2t/q+Q1hDFgGbWBpdc71XM0m3vhxZQuufpqIB9S9oZe55oH7qvZelltFrWnEIwHfn1vjxTWF
 cAQQ+HSWU9D2r0u0HiAsxSS1dXCCWhQONU5llwLWQ=;
Received: from [2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpw69-0005F1-96; Mon, 09 Oct 2023 20:39:29 +0100
Message-ID: <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
Date: Mon, 9 Oct 2023 20:39:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Natalia Portillo <claunia@claunia.com>
References: <20231007072313.22108-1-huth@tuxfamily.org>
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
In-Reply-To: <20231007072313.22108-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
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

On 07/10/2023 08:23, Thomas Huth wrote:

(added Natalia who was the GSoC mentor for the NeXT cube work)

> The machine is incomplete, and unfortunately the hoped-for improvements
> never happened. So it's maybe best if we mark this machine as deprecated
> and finally remove it again in case it gets into the way of a code
> refactoring or other reasons.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 3b074b9ed4..2f6dadd12f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -253,6 +253,14 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>   better reflects the way this property affects all random data within
>   the device tree blob, not just the ``kaslr-seed`` node.
>   
> +``next-cube`` m68k machine (since 8.2)
> +''''''''''''''''''''''''''''''''''''''
> +
> +The machine never got fully implemented and can only show the firmware prompt.
> +Given the incomplete state and slow progress on improvements, it might get
> +removed again without replacement.
> +
> +
>   Backend options
>   ---------------

I'm torn a bit by this one - on the one hand the NeXT code could do with some love, 
but then given that the code already uses qdev/QOM then there isn't really much in 
the way of maintenance burden. The main concern for me at the moment is the use of 
the old-style memory accessors that pre-date the memory API.

With my latest ESP patches I think it shouldn't be too hard to update the NeXT DMA 
controller to get SCSI working, so perhaps we can leave it for now if it doesn't 
cause too many problems?

Natalia, any comments from your side? In particular what sources did you point Bryce 
towards in order to reverse engineer the NeXT hardware?


ATB,

Mark.


