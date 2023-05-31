Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C377179A9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:11:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Gup-0002mN-65; Wed, 31 May 2023 04:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4GuM-0002iI-RC; Wed, 31 May 2023 04:10:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4GuL-0006tg-EN; Wed, 31 May 2023 04:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RtQThHkIUffwrzZGLdBEvX5unZAVxr9cxjm6Q9LdgbI=; b=U4r+R5ZWW41ZPrx+z1xghr6n6l
 JUk8Whb+3ObEEqcOZyc9LZIhQHyOuXThhq5ngklU6OX/8/A6N8jPyXL3jwapaUWMz8GwldMfWaEYf
 arLZQ3LBcQM1M3Ee8hYQu3llpEXOeoIEmrKu7hP0hPsNjWFg/uo5IzHNa2LD0JkJ6so2IsHwTTuLE
 TEopdyA22Uipwn6857svRMSRu8nMw/pCvarHObZSta99P4BizDVwbGe5YQlVetjL+wZKC9MQyMguM
 iGld0oEXfKZBfsc9qBB3W9mrpsnaKKxDZJmeZNaoYadWCsJ4nvETWkxtWwT3X8sKhzUndotOLOm20
 OlQtg+OJwB710jnGt7qcRcj31oa5wAn0ifk7yO/eCIvujWE5L13WvLgDYi9WJ7HszeuIPdFa0deAp
 HGynwUXuI/jGQy56KqrlDxRDJNGVBq9xS0ff1jGgEoIr++ZUBTdvcU1Pznwi8A/Q+mU9bNDl8aalg
 GZmVjkAXizcBYGUy+SpLHimOwbwKrX7tIWx0fDpDBtRuSLQyFejggDqTSLOHh3Xrzf3y2NK63cuCY
 eR4V87qzZJGuAIA4X0h7VkTEskvyGhNLe2Rbtb10xWG1CeTi6HDK+9XwKGJ+c14MnGO37IGyzKWii
 R1mQxmdkPy4+SKESADyLbG9T62IOhOIxSYHG8vPdU=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4Gu8-0007UI-EX; Wed, 31 May 2023 09:10:04 +0100
Message-ID: <87e913c3-7fa7-6a05-1d49-ef424e878b65@ilande.co.uk>
Date: Wed, 31 May 2023 09:10:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230530102041.55527-1-thuth@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230530102041.55527-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/ppc/Kconfig: MAC_NEWWORLD should always select
 USB_OHCI_PCI
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/05/2023 11:20, Thomas Huth wrote:

> The PowerMacs have an OHCI controller soldered on the motherboard,
> so this should always be enabled for the "mac99" machine.
> This fixes the problem that QEMU aborts when the user tries to run
> the "mac99" machine with a build that has been compiled with the
> "--without-default-devices" configure switch.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/ppc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index a689d9b219..5dfbf47ef5 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -115,6 +115,7 @@ config MAC_NEWWORLD
>       select MAC_PMU
>       select UNIN_PCI
>       select FW_CFG_PPC
> +    select USB_OHCI_PCI
>   
>   config E500
>       bool

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


