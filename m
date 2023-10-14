Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CEF7C9305
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 08:41:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrYKM-0005M1-PZ; Sat, 14 Oct 2023 02:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qrYKF-0005Jp-Sd; Sat, 14 Oct 2023 02:40:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qrYKD-000222-6q; Sat, 14 Oct 2023 02:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KjpvjkumV3l1qDGzg5tyVYtOVwdF1r3RIOwBPvPoK88=; b=Cz8rZ3gGY+gJ/dtAANLC4WuMe7
 d9jOqNMrUraG4O/iPm2gff6R2sfZG+sJQoqJI8Y+Pdb1DtA81xCbGYg6ls50iXAEuBkzWruH/0uRL
 Yy+qIQvCqmzqKeM7z3s0DA/2nBTFd6A3UiiaxB0y3FjJoElDpMdSNjDTeMRoRNtfev9bcsD1bRRMp
 PgMvufnEXkt5ddpnZ6HJZYHurV1EhjmP4pNTi6lDP6jbiF78jE+IZnuec13vlrukURCCK28j1IHpe
 PfdI5VtL+FqtfBCOyRPvM9xrH5lgubgyu8PEdyohmfIRf5MPCQFDRkAyzxCh4mmGy/l11HVd1xawu
 36bWKJ/3GlAiBtIJAGGDOpbNYTlEbXN4Rc/Suppc/KnO/IRY1JVcZsb7Umb85+bSYS3lAwywPmfyK
 AO+2ymOiTmAm0kXB/DTDXS3l4FEFoffEQrnDgc1VwFkZaPjyFIVwhDOgiAUQ/phieNhDRIVlBSwVm
 qtkJAnM7Brc21AQPaFcNfkkfeJ5pdN6ZkMMJuB8OM4r91a51p96JwVIfiqJTvBu/EkIC3jU8Orihe
 71nCbG2dzo5nwHQe3a8rDM92SpQ4Ayz+CFrhc8H9C8IccK1M+Qso2j0rFmZ/83br27DViWDbEGa9X
 jnMvfuWjixWdWvlN0Uodpn/XUk4nmPESL9dBVRoI8=;
Received: from [2a00:23c4:8baf:fd00:1033:b5d6:92a3:359f]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qrYK0-00073L-D7; Sat, 14 Oct 2023 07:40:28 +0100
Message-ID: <b5da70d0-6e91-413d-93da-b1748c68d001@ilande.co.uk>
Date: Sat, 14 Oct 2023 07:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gavin Shan <gshan@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231013141131.1531-1-philmd@linaro.org>
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
In-Reply-To: <20231013141131.1531-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:1033:b5d6:92a3:359f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/10] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
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

On 13/10/2023 15:11, Philippe Mathieu-Daudé wrote:

> Hi,
> 
> This series add support for (async) FIFO on the transmit path
> of the PL011 UART.
> 
> Since v2:
> - Added R-b tags
> - Addressed Richard comments on migration
> 
> Since v1:
> - Restrict pl011_ops[] impl access_size,
> - Do not check transmitter is enabled (Peter),
> - Addressed Alex's review comments,
> - Simplified migration trying to care about backward compat,
>    but still unsure...
> 
> Philippe Mathieu-Daudé (9):
>    util/fifo8: Allow fifo8_pop_buf() to not populate popped length
>    util/fifo8: Introduce fifo8_peek_buf()
>    hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
>    hw/char/pl011: Extract pl011_write_txdata() from pl011_write()
>    hw/char/pl011: Extract pl011_read_rxdata() from pl011_read()
>    hw/char/pl011: Warn when using disabled transmitter
>    hw/char/pl011: Check if receiver is enabled
>    hw/char/pl011: Rename RX FIFO methods
>    hw/char/pl011: Add transmit FIFO to PL011State
>    hw/char/pl011: Implement TX FIFO
> 
>   include/hw/char/pl011.h |   2 +
>   include/qemu/fifo8.h    |  37 +++++++++--
>   hw/char/pl011.c         | 140 +++++++++++++++++++++++++++++-----------
>   util/fifo8.c            |  28 ++++++--
>   hw/char/trace-events    |   4 +-
>   5 files changed, 161 insertions(+), 50 deletions(-)

Looks like patch 10 where all the interesting stuff is didn't make it to the list? 
Patchew also agrees here: 
https://patchew.org/QEMU/20231013141131.1531-1-philmd@linaro.org/.


ATB,

Mark.


