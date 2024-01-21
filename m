Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4F8355AB
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 13:30:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRWxl-0006Cr-CC; Sun, 21 Jan 2024 07:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRWxg-0006Av-Vs
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 07:30:05 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRWxd-0005zX-CZ
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 07:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pv5DdezbC3EYmMlo2jshDuTrLowtepUMobjpW4Pluek=; b=f8KRdd0SArGLetApTlgJ1lpxsh
 jIqWZUlED+n6AGv/Y0EA1YZJtpTMGwEo4KuFbXPaizPaLRolqLe8HgUYFaiOOJJjTm/Szn91CYLlU
 JtpFh3FJpBeGSjyN89/ZdXu4y+xzLfxiwVwdUE3ze5KJMxo0JJGyizre2CVtZuQAeCaR5iguK4SpX
 0heWgWkqmdHrp27km9pyg0W6cugdAsoP3wZ53BOPYbDzGJ32etubUfEhD6UuGjs5o/cd8xHC3zRd6
 lC01AOIOG7qoc3PPjRFnov0uELDi1kpX7XLKnPCRMmAXenYAUm3UqHLeFRX5LhRfpLIfrPET3rxx+
 FHzQ9gNVsTOmDURIxwQS1wzdXJzKQ3qKrWsXiPh4h7P11z6ZAxdnt/HMzKqrlvHxuyTIxpJeTEETg
 9rtQzTCeqi95MCQGK8Km4Jm9G7sf0R8DALT0nvErDEbBsefQqKuxA5qonJY/iUp6xUnmWJx00Bj9Z
 QHYRUTh6/mVrgDBm6FryaE+SdbVFLMAFWzb1d/ArshtNutDcaMV391Qnk8et1wWGkQC0tz7OniiAm
 snO8FuaHLyBzxy5rWFH3rRbbd6SODgPVLCr1meZBG+C/5diNotiSuHHkNk11DVrGhx0dof1duK4Jg
 U+iPDztwkL5NscVCPXW5PxzZZahASVcT1kUMaysqE=;
Received: from [2a00:23c4:8bb1:9800:5dbf:d3e3:d848:4670]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRWx1-000CfL-DE; Sun, 21 Jan 2024 12:29:27 +0000
Message-ID: <3a88e9b4-f185-4439-9b11-5cbaba1a75f8@ilande.co.uk>
Date: Sun, 21 Jan 2024 12:29:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu, qemu-devel@nongnu.org, elliotnunn@fastmail.com
References: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
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
In-Reply-To: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:5dbf:d3e3:d848:4670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/3] nubus: add nubus-virtio-mmio device
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

On 11/01/2024 10:29, Mark Cave-Ayland wrote:

> This series introduces a new nubus-virtio-mmio device which can be plugged into
> the q800 machine to enable a 68k Classic MacOS guest to access virtio devices
> such as virtio-9p-device (host filesharing), virtio-gpu (extended framebuffer
> support) and virtio-tablet-device (absolute positioning).
> 
> Once the nubus-virtio-mmio device has been plugged into the q800 machine, virtio
> devices can be accessed by a Classic MacOS guest using the drivers from the
> classicvirtio project at https://github.com/elliotnunn/classicvirtio.
> 
> The nubus-virtio-mmio device is purposefully designed to be similar to the
> virtio-mmio interface used by the existing 68k virt machine, making use of a
> similar memory layout and the goldfish PIC for simple interrupt management. The
> main difference is that only a single goldfish PIC is used, however that still
> allows up to 32 virtio devices to be connected using a single nubus card.
> 
> Patch 1 fixes an alignment bug in the existing nubus-device Declaration ROM code
> whereby some ROM images could trigger an assert() in QEMU, patch 2 increases the
> maximum Declaration ROM size (to aid development), whilst patch 3 adds the
> nubus-virtio-mmio device itself.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> [Patches still needing review: 2, 3]
> 
> v3:
> - Rebase onto master
> - Update patch 1 alignment calculation to use intermediatery uint8_t rom_ptr
>    variable, add Phil's R-B tag
> - Add patch 2 to increase maximum Declaration ROM size to 1MB
> 
> v2:
> - Rebase onto master
> - Adjust comment in patch 1 as suggested by Phil
> 
> 
> Mark Cave-Ayland (3):
>    nubus-device: round Declaration ROM memory region address to
>      qemu_target_page_size()
>    nubus.h: increase maximum Declaration ROM size from 128k to 1Mb
>    nubus: add nubus-virtio-mmio device
> 
>   hw/nubus/meson.build                 |   1 +
>   hw/nubus/nubus-device.c              |  18 +++--
>   hw/nubus/nubus-virtio-mmio.c         | 102 +++++++++++++++++++++++++++
>   include/hw/nubus/nubus-virtio-mmio.h |  36 ++++++++++
>   include/hw/nubus/nubus.h             |   2 +-
>   5 files changed, 154 insertions(+), 5 deletions(-)
>   create mode 100644 hw/nubus/nubus-virtio-mmio.c
>   create mode 100644 include/hw/nubus/nubus-virtio-mmio.h

Ping?


ATB,

Mark.


