Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB1719C09
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:25:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hMW-0000ZN-Lr; Thu, 01 Jun 2023 08:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hMM-0000Sq-N7; Thu, 01 Jun 2023 08:24:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hML-0000hs-8O; Thu, 01 Jun 2023 08:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NnpBeUUg+cltRHYUyZY5RluKk1bnz8HwoK4B9WuSOY8=; b=yTOeA0mXw3nNOjXuY9cpT2yZAr
 Fm3UL5whgaSePoiW+c3CiXKTzKuPpt1Rjt0j8rUwZ6jgWTTZaLECwtiqykUpIkSia6BRCpFpEdQpn
 ZOZ7/xo6GlQUvK7e5HTUaO88qgD6741Jo9eUVG+nDX4mnGZZOMDqKFmx5REwvJOQpHAMcJcYqWKln
 63xUVQbgvr0wZcYg3D5NQO/9513Fk0zbmzmeTBfkDA6Zx//U6cJ/hthKu5TjyEuCWq7xwG9gc117H
 5QvYAwrLvY1tE7Db2csM5dfXegViQFx1tan2Ev+zMhgLh9q7SrfwIdzrENZ57QpaBK/qaHGe8BU6d
 Z/E/MeGLI15QyGMIxq5zLr0cBQvR7CFnaOQxOICd77GqI7qBPM5DvoqYTujr3Wy9FJBzrjeusi0ZS
 30wLm02/Y5KY2PYX+nOUlC2kx83SV5YxNO61KqbkfHE51WqcyjX3xJlSAsWzcAwjYsi7VjtlkEReG
 Bli5P6mFF3jALLC1E/eawdDGbPyAK9SB8zo7JdDvzCJvFff6uRVsWNcL6S1HEbbhRMbQ4r3j66mG0
 Y2VfG/d5UGpqEYGICcwGqx/+c2SGFXVqrryDhjN4pfGxvC9vbhe5CL0xFEHb6K/4P/8QxpztBrFFY
 AvTPIv8URfDMgt1PghruLmLVfOAgMP2dlJKZIJifE=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hM6-0006A7-Ec; Thu, 01 Jun 2023 13:24:42 +0100
Message-ID: <b354b585-9f7f-c068-8d3c-1a1eca03111d@ilande.co.uk>
Date: Thu, 1 Jun 2023 13:24:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230531211043.41724-1-shentey@gmail.com>
 <20230531211043.41724-7-shentey@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230531211043.41724-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 6/7] hw/ide/pci: Replace some magic numbers by constants
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/05/2023 22:10, Bernhard Beschow wrote:

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ide/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 0b26a4ce9f..a25b352537 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -320,7 +320,8 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>   
>   void bmdma_status_writeb(BMDMAState *bm, uint32_t val)
>   {
> -    bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
> +    bm->status = (val & 0x60) | (bm->status & BM_STATUS_DMAING)
> +                 | (bm->status & ~val & (BM_STATUS_ERROR | BM_STATUS_INT));
>   }
>   
>   static uint64_t bmdma_addr_read(void *opaque, hwaddr addr,

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


