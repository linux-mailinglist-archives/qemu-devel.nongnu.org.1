Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 619507D3E84
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:04:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzGy-00029G-EH; Mon, 23 Oct 2023 14:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quzGw-00027w-5X; Mon, 23 Oct 2023 14:03:26 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quzGu-00060M-LD; Mon, 23 Oct 2023 14:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yU7AqehdW4OHHBu8KJvelvnNyNgY2a8GLk5ALpCMwV8=; b=09Uf9BGvZ2wAS3r+1JtbLVBMRE
 mt1PC8UTs7yhhXcLtacCnDczwp8wKcf4rMWq4zquYOUqnV9X1tfz01L37bVpk+qj0it8ZPqj/aWWg
 IL2Y1P9wwPHfUfiDa4We2RkP/oF+ZDG08Zdga6efYiTq/QUzFGLD1i864+kXr6FKAMPkxCbh3u9zT
 7LXNMFZ2p7h7Gaev0xhfachy+uYYpltJqT/CJv+zo2iNwKwN9msXo4QshIxsNQt6kxy+Pbiu97UDL
 hrqcnaVPEfGRxAtfWRjRh+NnusK+BWagnNmublQckyiFZAgXZGCaE661ygNsU6BhkJcc6sC+9/gKW
 bI/hWkzrfac0CoDa9iElXAVI+e+DRY1tGw4uO4pt2l117aVZ+czs2kJUczbyU+yk4T8tafd2zMMpt
 GybnBbZwClNzSRLN3j+bxws2sdrYxb/eo6V9K/753LZe9Sk/+DPWWC4eAvKf0MbkRW+UCgFvoU6uv
 WVjmnJFpHQlH2bXaYiBlg4cvKS3CP6C09ftVKU/01CImTEIvdJx2H/vJWYatZ4CCziwK1S4h87voD
 J9XTBwm4zleDJUzS4VZ1KvemxO4zI6qlTETs8Xk2pRqEWf86xKV9+ybaPPcHzPY2zW46jFMbn1U2B
 l49/JueZtTDcM8HwSzl23rUJmupV5/iNssKUqSqgM=;
Received: from [2a00:23c4:8bb0:3200:776d:f8ec:db63:d979]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quzGj-0005Sm-7i; Mon, 23 Oct 2023 19:03:17 +0100
Message-ID: <e40f5640-943e-4a6a-bf18-2f02f4827766@ilande.co.uk>
Date: Mon, 23 Oct 2023 19:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, balaton@eik.bme.hu,
 philmd@linaro.org
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
 <1C2A3DE2-A4E8-42D3-BE70-710AA8EB53E7@gmail.com>
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
In-Reply-To: <1C2A3DE2-A4E8-42D3-BE70-710AA8EB53E7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:3200:776d:f8ec:db63:d979
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/2] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
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

On 22/10/2023 23:10, Bernhard Beschow wrote:

> Am 19. Oktober 2023 13:04:50 UTC schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>> This series adds a simple implementation of legacy/native mode switching for PCI
>> IDE controllers and updates the via-ide device to use it.
>>
>> The approach I take here is to add a new pci_ide_update_mode() function which handles
>> management of the PCI BARs and legacy IDE ioports for each mode to avoid exposing
>> details of the internal logic to individual PCI IDE controllers.
>>
>> As noted in [1] this is extracted from a local WIP branch I have which contains
>> further work in this area. However for the moment I've kept it simple (and
>> restricted it to the via-ide device) which is good enough for Zoltan's PPC
>> images whilst paving the way for future improvements after 8.2.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> I've successfully tested this series on top of my pc-via branch, so for the series:
> Tested-by: Bernhard Beschow <shentey@gmail.com>
> 
> I've added comments to the first patch.
> 
> Best regards,
> Bernhard

Thanks a lot! I'll make the change to the switch() statement and then post an updated 
v2 later this evening.

>> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>>
>> Mark Cave-Ayland (2):
>>   ide/pci.c: introduce pci_ide_update_mode() function
>>   hw/ide/via: implement legacy/native mode switching
>>
>> hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
>> hw/ide/via.c         | 20 +++++++++-
>> include/hw/ide/pci.h |  1 +
>> 3 files changed, 109 insertions(+), 2 deletions(-)


ATB,

Mark.


