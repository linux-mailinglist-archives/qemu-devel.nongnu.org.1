Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F377B7B69
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxus-0000b3-BT; Wed, 04 Oct 2023 05:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxuf-0000Qh-8c
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:11:26 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxub-0008GV-FT
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=la3DnexzjKJ2VWQ3FEcpYc89QBSaDfH6XwFkmopflPg=; b=P5pYkeuXY+LgK4IK0J5l0D7zP5
 MzX9krW0ZIlWNSWxMA8NRt7XNX2NbAd8Lbdlh+opZSopJlPiEIvOpHk3oeS9rR28b/jwUEVcCTwVe
 /MtCsJlemrYpdozwec/zNBKZlkclZlCrl2ruObbfwiThODDXn/VZwCrymF3iw2WjGnjP5rnomGSkV
 P0LOBB8EGQQig7K58U7nEBh8guxRZDl16mXk7sVV/39zVZhe99YxWlHtQTfxDuklvLTLtfwHCy2jg
 pNurtGbo+7F63mHnkyhNmonW/xrHiAr5OayJqHa3vM56ySQPcbj2bWZ9Cz5+99Mnf4p17VCxgxnVv
 agpgR+Sr4WR0sUdFGEMb86H5y9gouVga4vHuGH3xotPOYbg7ZHS6nmp4O3jaTWfZ9BuCy7iydb36s
 OLV1K/Ou/SqcGU0vvtBOE+bkSGpnlo20cqGaRl19ywAhLoqDk2DC3snjIYnV8RACxQWNymFI2l+Hn
 8StpmVxCdo/gmrsvvarQFPRvg3zalJzUnGwJO2+nf5BftrEwvjdgE4eEA181gXZgaIPGUmQstlTSz
 0JPOVX25bGQ4bVXBUCHi0yEp2rrwUXXreNeHisqZLr/wjdiZLf6Gbp8TKkvi24i/1Vd31hAal7B7x
 H2QUMTemJINy/az0Wwb4oDritdGX8qFDaaN18Zuyg=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxuL-0007Wj-K8; Wed, 04 Oct 2023 10:11:09 +0100
Message-ID: <174835fa-5480-4eb3-a8ce-5e852c005bac@ilande.co.uk>
Date: Wed, 4 Oct 2023 10:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230930132351.30282-1-huth@tuxfamily.org>
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
In-Reply-To: <20230930132351.30282-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/5] m68k: Instantiate ESP and next-net in the next-cube
 machine
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

On 30/09/2023 14:23, Thomas Huth wrote:

> Mark Cave-Ayland recently asked me about the ESP patches for the
> next-cube machine that I once posted a long time ago, but never
> got it merged (since Mark is currently working on improving the
> ESP device). With his help, I dusted off the ESP patch, but we
> had to discover that the firmware also wants to see the NIC
> device in the MMIO region, otherwise it often crashes or hangs.
> So here's now the current set of patches for the next-cube machine.
> Both, the ESP SCSI controller and the NIC do not properly work
> yet, but at least the next-cube firmware gets much further now
> during it selftest, so I think this is a good base for future
> work and experiments.
> 
> Thomas Huth (5):
>    hw/m68k/next-cube: Mirror BIOS to address 0
>    hw/scsi/esp: Work around problem with PIO data read for the NeXT-Cube
>      machine
>    m68k: Instantiate the ESP SCSI controller for the NeXTcube machine
>    hw/m68k/next-cube: Remove unused NEXTDMA_EN code
>    m68k: Add NeXTcube network controller
> 
>   hw/m68k/next-cube.c         | 194 +++++++++----
>   hw/net/meson.build          |   1 +
>   hw/net/next-net.c           | 538 ++++++++++++++++++++++++++++++++++++
>   hw/scsi/esp.c               |   2 +-
>   include/hw/m68k/next-cube.h |  10 +
>   5 files changed, 692 insertions(+), 53 deletions(-)
>   create mode 100644 hw/net/next-net.c

Thanks Thomas! So... just looking at this series (along with the existing NeXT 
files), it is obvious that the NeXT code hasn't been touched for some time. The 
problem I see with trying to bring the code in line with our current standards is 
that there are still quite a lot of experimental parts within it, so it's not always 
even clear what the correct behaviour should be without quite a bit of 
experimentation and testing.

If the plan is to keep the NeXT code and to work on it over time, then I'm inclined 
to say merge this series as-is so at least it provides test cases for hardware such 
as ESP, brings upstream up-to-date with Bryce's original work, and allow a future 
cleanup. So on this basis:

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


