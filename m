Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEEE7F130A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 13:19:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r53F8-0005Ik-Rs; Mon, 20 Nov 2023 07:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r53F1-0005Hg-7e; Mon, 20 Nov 2023 07:19:04 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r53Ez-00019j-2q; Mon, 20 Nov 2023 07:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wSIyu1c87+kdw6tqh3o2N+fuPl9pBDaG3HCyjVUszvM=; b=vms439mZQW5qmZgS2ESri4HSOA
 K2t57jO69lBHhbUV9EjbS3HjPPq4JScwSJ0HmkbuTHizgCHZ7YR5uhsYkZZRbHvv4qfSi9Fp2Utjw
 JX/sLLrhOhfTT8KigwzVEtdeKHahX0hgzqg/JcKSu2WLcPTUlqaH/0nj29/yz/BcyffhA6tr7xvZy
 1lUmSHlrsywwW8lIk8C0kmFdxKoO6LFUpXpvETn66S5Xnw9lBOkS2p6uMSv00Q9Oh8s1K3tU98tPq
 Lls6U8FBKiDYJ9efiHG+M1pvZEeyOGC6uVcbBTG8vaOYUQE09hGgIrbQVqWtSfPOEotQJAcWfAbqq
 3T7CGvDeJFRKNbxduE+rhT6Ft4AB3Vaai7zGm2nkwEogCD823uo1hANT13L9GmKtz+pZCUSG+Kukw
 /jSbLjHpmp3oTAax4puXemX0gwRVK8mZx+5kWsCwZ2dPraPtUiwS4/0aBfEkeCCXC7JDT2iI2+wo9
 NM1hksj5F/KkwHBUYQO9mT3i6WgFKDvnyQ0sXOa2daaGIwXgbNVYx4SyqNRi8XtOYhJvdJnZ1aBpr
 rjy+h+q3l8pDyR/GhWFdSBKCnPWNbUUXBZJ/Gtw/xT0mKV4s47/ZydIhN6FbYEiD0j5haEuhdn7op
 +t9s5IeAGwD33WS4d+KJUaiFFTf9tmjl+S73q2khw=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r53EZ-000ByU-5O; Mon, 20 Nov 2023 12:18:39 +0000
Message-ID: <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
Date: Mon, 20 Nov 2023 12:18:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, philmd@linaro.org, shentey@gmail.com,
 Rene Engel <ReneEngel80@emailn.de>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
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
In-Reply-To: <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode switching
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

On 19/11/2023 21:43, BALATON Zoltan wrote:

> On Thu, 16 Nov 2023, Mark Cave-Ayland wrote:
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
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>>
>> v3:
>> - Rebase onto master
>> - Move ide_portio_list[] and ide_portio_list2[] to IDE core to prevent duplication in
>>  hw/ide/pci.c
>> - Don't zero BARs when switching from native mode to legacy mode, instead always force
>>  them to read zero as suggested in the PCI IDE specification (note: this also appears
>>  to fix the fuloong2e machine booting from IDE)
> 
> Not sure you're getting this, see also:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg04167.html
> but this seems to break latest version of the AmigaOS driver for some reason. I 
> assume this is the BAR zeroing that causes this as it works with v2 series and 
> nothing else changed in v3 that could cause this. Testing was done by Rene Engel, 
> cc'd so maybe he can add more info. It seems to work with my patch that sets BARs to 
> legacy values and with v2 that sets them to 0 but not with v3 which should also read 
> 0 but maybe something is off here.

I've been AFK for a few days, so just starting to catch up on various bits and pieces.

The only difference I can think of regarding the BAR zeroing is that the BMDMA BAR is 
zeroed here. Does the following diff fix things?

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 47223b1268..2d3124ebd7 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -164,10 +164,10 @@ static uint32_t via_ide_cfg_read(PCIDevice *pd, uint32_t addr, 
int len)
      uint8_t mode = pd->config[PCI_CLASS_PROG];

      if ((mode & 0xf) == 0xa && ranges_overlap(addr, len,
-                                              PCI_BASE_ADDRESS_0, 24)) {
+                                              PCI_BASE_ADDRESS_0, 16)) {
          /* BARs always read back zero in legacy mode */
          for (int i = addr; i < addr + len; i++) {
-            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 24) {
+            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 16) {
                  val &= ~(0xffULL << ((i - addr) << 3));
              }
          }

>> - Add comments in pci_ide_update_mode() suggested by Kevin
>> - Drop the existing R-B and T-B tags: whilst this passes my local tests, the behaviour
>>  around zero BARs feels different enough here
>>
>> v2:
>> - Rebase onto master
>> - Mask the bottom 4 bits of PCI_CLASS_PROG in pci_ide_update_mode() in patch 1
>> - Add patch 2 to remove the default BAR addresses to avoid confusion
>> - Don't set PCI_INTERRUPT_PIN directly in via_ide_reset() as it is already set
>>  by pci_ide_update_mode() in patch 3, and reword the commit message accordingly
>> - Add Tested-By tags from Zoltan and Bernhard
>>
>>
>> Mark Cave-Ayland (4):
>>  ide/ioport: move ide_portio_list[] and ide_portio_list2[] definitions
>>    to IDE core
>>  ide/pci: introduce pci_ide_update_mode() function
>>  ide/via: don't attempt to set default BAR addresses
>>  hw/ide/via: implement legacy/native mode switching
>>
>> hw/ide/core.c             | 12 ++++++
>> hw/ide/ioport.c           | 12 ------
>> hw/ide/pci.c              | 84 +++++++++++++++++++++++++++++++++++++++
>> hw/ide/via.c              | 44 ++++++++++++++++----
>> include/hw/ide/internal.h |  3 ++
>> include/hw/ide/pci.h      |  1 +
>> 6 files changed, 137 insertions(+), 19 deletions(-)


ATB,

Mark.


