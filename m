Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 356298355A8
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 13:30:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRWwH-0005Xh-VG; Sun, 21 Jan 2024 07:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRWwG-0005XX-38
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 07:28:36 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRWwE-0005tM-7V
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 07:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/S/GSygUh2t/uezBD5kHT6jlK7MTpL6uDoUrFmN5P0=; b=fnIe7N/jxMKYhorONpPIBMvzx1
 rq/jD1G6F8ck3jvgvBVW/jSkU0o8LKyiNKzDuGm83xh+AX8uNylm06mnSXyVFySmy9y3Uz8vhnd9x
 1jj0UnrkFwjplP5lybTUG1tKCHLdRMtnhEnVqwJeeW4hbJuK8W1iDCx54SW+Ws3Tp4bG0ozCdebvD
 Uwv8bLDLh7M6HdCuJfcSq+eBhQMaEUUD0AfY3Ty+OL3D2pEJzwylwRl3VasUBf9E7De6Mgv2ESfl3
 eBCPeMbn8jdfsmMLxH0qsBYrDrT+Bp9DwyJ4ljBlpqNGJNxXwPVJANJQ6+RFLRZ7B0jyV+bi5wO3t
 kRRcNyCh+dP+mdyUv8eYGpPqDYdo48DolCpGl1bdF0eDIQ1nCXIi55nFR3Wpx7IFa3K1gAQs80lNJ
 Wo6jDeH/1ulEw+XsPT71l7ReH78gRc8W7LN9lj7SkSuo0r93wFjFz/Gbc6zTlWs08pnaBU7/63hTA
 NL4xbs6j4HGE/ljI+nqWaFQk+VbYUehI1+OVZvLKae0A8wXAN+m8EjOwFDQ8D+9bc6igaARf5p4zR
 Yaerxi2ETbdeyXcVWQaCDJRTQ5ZxfzmCf1j5w1IQUJVy/+DanvbTsiOFAJksp1xTZeW+UU6Wrie6K
 LGZ81KyXmKqiB0XhUro3go4m5AbFecSPnqkCUix0g=;
Received: from [2a00:23c4:8bb1:9800:5dbf:d3e3:d848:4670]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRWvE-000Cep-1z; Sun, 21 Jan 2024 12:27:36 +0000
Message-ID: <561fe2bf-4236-479b-b68b-02a92741230e@ilande.co.uk>
Date: Sun, 21 Jan 2024 12:28:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, pbonzini@redhat.com, fam@euphon.net,
 hpoussin@reactos.org, deller@gmx.de, linux@roeck-us.net,
 qemu-devel@nongnu.org
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
 <9ceaeead-107a-4766-b5da-a9060ddeddf4@tls.msk.ru>
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
In-Reply-To: <9ceaeead-107a-4766-b5da-a9060ddeddf4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:5dbf:d3e3:d848:4670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] esp-pci: fixes for Linux and MS-DOS
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

On 20/01/2024 13:09, Michael Tokarev wrote:

> 12.01.2024 16:15, Mark Cave-Ayland:
>> This series contains fixes for the esp-pci device (am53c974 or dc390) for a
>> few issues spotted whilst testing the previous ESP series.
>>
>> Patches 1-3 are fixes for issues found by Helge/Guenter whilst testing the
>> hppa C3700 machine with the amd53c974/dc390 devices under Linux, whilst patch
>> 4 fixes an issue that was exposed by testing MS-DOS and Windows drivers.
>>
>> With this series applied on top of the reworked ESP device, it is possible to
>> boot Linux under qemu-system-hppa without any errors and also boot and install
>> Win98SE from a DC390 PCI SCSI controller (no IDE!) using an MS-DOS boot floppy.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Based-on: 20240112125420.514425-1-mark.cave-ayland@ilande.co.uk
>>
>>
>> Mark Cave-Ayland (4):
>>    esp-pci.c: use correct address register for PCI DMA transfers
>>    esp-pci.c: generate PCI interrupt from separate ESP and PCI sources
>>    esp-pci.c: synchronise setting of DMA_STAT_DONE with ESP completion
>>      interrupt
>>    esp-pci.c: set DMA_STAT_BCMBLT when BLAST command issued
> 
> Is it worth to pick up for stable?  Especially the first one.
> It's interesting this bug is here for a very long time.. :)

Good question! I did my comprehensive boot tests with this series on top of the core 
ESP series so I can't say that I've tested this series on its own. Then again other 
than the DMA_STAT_DONE patch which is a timing change, the rest of the patches are 
fixing specific edge cases which were already broken so I would be surprised if 
anything broke.


ATB,

Mark.


