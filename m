Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8C756D9C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLUDL-0007RQ-RN; Mon, 17 Jul 2023 15:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qLUDG-0007Ou-BQ
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:48:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qLUDF-0007QH-0M
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rj05NNCg5YTRVB04LyaE6QrXgZDgVibkDvFshLkYG5g=; b=NInxbhzhP5LKZDw3oq7Nq3xdCq
 qIY66WLO+VaNtpFr59HRgZj0q+BBJjBvU347ods1P8jkcMpJKC7Wi54Tm0dVh1NSJRBzom5X1h3rJ
 iSFxZB0Yzt8roI45reQbPSWmfef6lrm33PNgzfQTy9XkqPof2G6HkCp6S2BBuUgfrAwtIx/O7lhUn
 xXxs0BRdQ89Y+bSG+FHNU6XlLkSBJVWbeAF/2o1q2/t5ReOikhh7x0RUZvGhblCmFQr/Qe7k6C4Fh
 ylAsXZI7IG/QFqJ5bgYrcu3oQcccvKTWpuyMDMV504A/ZIFaqq0wYTTJhZMpa9nQoVIrnwDosIDJ9
 ODn3QCzOFY4ueB/OfjlZvkD1X9YYmp3mCOzg7t9JA/+F4nNMEIT0LzMDlG82TPRGOQCDkba1+CJYn
 kWJ7bNU0wiLPWYU7/5IvgKKt+qr5I3fWa2H6yTtlLTkxKh3ITbv70H/DO/TtLpTdH8nRnRUbhhzjB
 es8dxihgbo870VR6FGWRyYRWHqsDh6dtehPn47ldwVU0MJAQHXJg2a40p1MjT6b3XzfTcgHjIxggy
 F1/1a52jYNAt6duevCN2SJqA7BogP8nA+PAtkx0yO1MA8haKlEBUHjP06xw+v6gVD0RbtVFDQ+wAV
 J91IDDBzU9P2yBfHjxxlPGmOO2Yvbi5f2+iRxAV8s=;
Received: from [2a00:23c4:8bae:1c00:dfd7:380:3565:1db7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qLUCt-0000FE-LJ; Mon, 17 Jul 2023 20:48:35 +0100
Message-ID: <3e95b0d7-412c-91a0-32e9-1793adeefa7a@ilande.co.uk>
Date: Mon, 17 Jul 2023 20:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20230716153519.31722-1-huth@tuxfamily.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230716153519.31722-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bae:1c00:dfd7:380:3565:1db7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/char/escc: Implement loopback mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 16/07/2023 16:35, Thomas Huth wrote:

> The firmware of the m68k next-cube machine uses the loopback mode
> for self-testing the hardware and currently fails during this step.
> By implementing the loopback mode, we can make the firmware pass
> to the next step.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/char/escc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 4f3872bfe9..4be66053c1 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -653,7 +653,9 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>           escc_update_irq(s);
>           s->tx = val;
>           if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { /* tx enabled */
> -            if (qemu_chr_fe_backend_connected(&s->chr)) {
> +            if (s->wregs[W_MISC2] & MISC2_LCL_LOOP) {
> +                serial_receive_byte(s, s->tx);
> +            } else if (qemu_chr_fe_backend_connected(&s->chr)) {
>                   /*
>                    * XXX this blocks entire thread. Rewrite to use
>                    * qemu_chr_fe_write and background I/O callbacks

Yes indeed, that helps things here :)

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


