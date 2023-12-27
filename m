Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C534081F1B7
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 20:56:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIZzQ-0002fp-Rc; Wed, 27 Dec 2023 14:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIZzN-0002fP-RV
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 14:54:50 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIZzM-0006SU-1P
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 14:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OYrFunPO9EL4YbbHCA0YdLwGsmPcsv8AWqLWkj+X6vg=; b=VyBJPCLxHXRTfobTSQai9FK2IV
 uACZcNxTfN+TCxhKKPKKycrv67076dgidGl16CG8+/FV6jsazxwRar4B38c5Vl30S/uYIj0HLiggn
 FnGdTJZLajVhrN6NjE2EilWxp6D+UTJNkthRGd0jv6g+pR4eubnBfkFNuVn4bLKLM3nA7C3QGb7eD
 RtrM+0kMNz9uT4Uz2mOgZaLDkVOcAc2jp0gQezxL9T68B/it0gLmst+l7HsN4XqU0VFZ5x8wukCBo
 Qe5NjdYFubsI6l8bd6n9p+9b7HrE7II3M6kuZ4JaPNaceo2FemkoiPiNmJnVkDlI6xnIx7ulgMQZS
 eH7vWk962OoM9bqUzPJHoKGuOQyKQSuAlPkym2dKNYR2H1mOXedOdvUSefYLCjTIDF96GGDDThryX
 I6kr205NGk+5V+hN8jxSSUC/Fk/q97Fim4Y/hdNrGwCaFdqKSoH//yKqkjw8iraJpJs2sgKo0uZX0
 JuvrnUTDPBp8fXRv3m2BuWAiMKTI51TQVEpCMGZwDf1r/FeRRk20hieFjJEl6AvNP/BhlJk1nMiTA
 NpjRFfeY88migZG7yuQ0eKmTo7LcGwEsvKQmu/P/vb2YcU6DUuntDmeLotp/XfqboEJx6gbMzMo0j
 PUSJTVp5FLx8PW04JSPvgVtupUtJJZaAG3pGgd1MI=;
Received: from [2a00:23c4:8bb0:f100:68ed:6797:e32e:ab13]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIZyn-0000Pp-Lu; Wed, 27 Dec 2023 19:54:17 +0000
Message-ID: <acea0511-e858-4b91-abc8-d122c9ef122f@ilande.co.uk>
Date: Wed, 27 Dec 2023 19:54:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20231221122939.11001-1-huth@tuxfamily.org>
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
In-Reply-To: <20231221122939.11001-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:68ed:6797:e32e:ab13
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/m68k/mcf5206: Embed m5206_timer_state in
 m5206_mbar_state
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

On 21/12/2023 12:29, Thomas Huth wrote:

> There's no need to explicitely allocate the memory here, we can
> simply embed it into the m5206_mbar_state instead.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/mcf5206.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
> index a46a23538d..183fd3cc08 100644
> --- a/hw/m68k/mcf5206.c
> +++ b/hw/m68k/mcf5206.c
> @@ -148,15 +148,11 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
>       m5206_timer_update(s);
>   }
>   
> -static m5206_timer_state *m5206_timer_init(qemu_irq irq)
> +static void m5206_timer_init(m5206_timer_state *s, qemu_irq irq)
>   {
> -    m5206_timer_state *s;
> -
> -    s = g_new0(m5206_timer_state, 1);
>       s->timer = ptimer_init(m5206_timer_trigger, s, PTIMER_POLICY_LEGACY);
>       s->irq = irq;
>       m5206_timer_reset(s);
> -    return s;
>   }
>   
>   /* System Integration Module.  */
> @@ -167,7 +163,7 @@ typedef struct {
>       M68kCPU *cpu;
>       MemoryRegion iomem;
>       qemu_irq *pic;
> -    m5206_timer_state *timer[2];
> +    m5206_timer_state timer[2];
>       DeviceState *uart[2];
>       uint8_t scr;
>       uint8_t icr[14];
> @@ -293,9 +289,9 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
>                                   uint16_t offset, unsigned size)
>   {
>       if (offset >= 0x100 && offset < 0x120) {
> -        return m5206_timer_read(s->timer[0], offset - 0x100);
> +        return m5206_timer_read(&s->timer[0], offset - 0x100);
>       } else if (offset >= 0x120 && offset < 0x140) {
> -        return m5206_timer_read(s->timer[1], offset - 0x120);
> +        return m5206_timer_read(&s->timer[1], offset - 0x120);
>       } else if (offset >= 0x140 && offset < 0x160) {
>           return mcf_uart_read(s->uart[0], offset - 0x140, size);
>       } else if (offset >= 0x180 && offset < 0x1a0) {
> @@ -333,10 +329,10 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint16_t offset,
>                                uint64_t value, unsigned size)
>   {
>       if (offset >= 0x100 && offset < 0x120) {
> -        m5206_timer_write(s->timer[0], offset - 0x100, value);
> +        m5206_timer_write(&s->timer[0], offset - 0x100, value);
>           return;
>       } else if (offset >= 0x120 && offset < 0x140) {
> -        m5206_timer_write(s->timer[1], offset - 0x120, value);
> +        m5206_timer_write(&s->timer[1], offset - 0x120, value);
>           return;
>       } else if (offset >= 0x140 && offset < 0x160) {
>           mcf_uart_write(s->uart[0], offset - 0x140, value, size);
> @@ -598,8 +594,8 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>   
>       s->pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
> -    s->timer[0] = m5206_timer_init(s->pic[9]);
> -    s->timer[1] = m5206_timer_init(s->pic[10]);
> +    m5206_timer_init(&s->timer[0], s->pic[9]);
> +    m5206_timer_init(&s->timer[1], s->pic[10]);
>       s->uart[0] = mcf_uart_create(s->pic[12], serial_hd(0));
>       s->uart[1] = mcf_uart_create(s->pic[13], serial_hd(1));
>   }

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This reminds me that there is one still remaining memory region left to convert in 
q800.c...


ATB,

Mark.


