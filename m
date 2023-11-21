Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46EF7F2A19
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:17:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Noz-0002pD-A7; Tue, 21 Nov 2023 05:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r5NoW-0002lp-Ry; Tue, 21 Nov 2023 05:17:06 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r5NoU-00067D-CT; Tue, 21 Nov 2023 05:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=49YnGQcNLIlYioY4+ouse9IoED1Ic1hK742+j4kfgU4=; b=1iR6K7SHGNnJczI4vXsvTT1kk2
 4bOUjUzlurPP32v22sIhTnx+rmHfjRU0REM/ftCe3E+9r6NbgHDkycnsS6xB/xcTGAV0mwSb+1yY3
 HlzPy9hiQkbuGe4Yh4DtgZ0FVtj2AYYtyxj/sQ+fng30rTotJRxy8bT8oWVqU+Cvwg826dzNvWGr+
 GLL3520fx2P+TqCNhmf2ITYs+k9P7QkAm3HmT6LV3OOSK59ESdL+FR8YfLtA5VYmNzX2EM8pQqbKv
 LTjxrJTz7gSxjrTnFLyqWzdTs2dniDd4qgQhZgNbKVguFm41WnrHObyYjVT8qN0YKRJX15PmJwFIr
 lwfJxrrRkcOBPhyiHoBqGnK8HHCfi1wXP5IMjn3e9FeE68CXnMEQX/says5jywEe69gJetyuVIG4h
 GCdvZkOvI0SsQy0sxy/waiRT2fhUokXoKMh8MP2hOKU0LkMyC2mlrLIJrF7DBCLUafyTrONG/9GQb
 4NDfxm8/JQDzi4qJS/gMLXBQ39MMooG9AeAyh+68Y8uX/XiYF5Sq3L06ht18g1wX2d68lUR0+bT1t
 OVnKwjfBiuik+lxgztizMBGGMMi7YDTLcOGSuxOHZyaH6Xd9YD7LFaU7JMOpSOnsAoHBiHiuqOJe/
 l7PEKMvVw3ypKG+IupDyzUHfFRyP20Jm1hzSBOEdo=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r5No7-0008dB-6l; Tue, 21 Nov 2023 10:16:43 +0000
Message-ID: <a8e8043b-5442-4df1-82d1-5f6deb2a9ae2@ilande.co.uk>
Date: Tue, 21 Nov 2023 10:16:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kevin Wolf <kwolf@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 philmd@linaro.org, shentey@gmail.com, Rene Engel <ReneEngel80@emailn.de>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
 <63ff9c1a-5d05-985a-bf2f-69420b72db90@eik.bme.hu>
 <ZVtiV8XXHxS+cw8o@redhat.com>
 <fad96d99-bbdc-4330-bf40-974eb745e2d3@ilande.co.uk>
 <741ae757-f1da-586b-af97-123b0ebfbdb9@eik.bme.hu>
 <ZVx0dbWCMUbF4NVG@redhat.com>
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
In-Reply-To: <ZVx0dbWCMUbF4NVG@redhat.com>
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

On 21/11/2023 09:12, Kevin Wolf wrote:

> Am 20.11.2023 um 16:02 hat BALATON Zoltan geschrieben:
>> On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
>>> On 20/11/2023 13:42, Kevin Wolf wrote:
>>>> Am 20.11.2023 um 14:09 hat BALATON Zoltan geschrieben:
>>>>> On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
>>>>>> On 19/11/2023 21:43, BALATON Zoltan wrote:
>>>>>>> On Thu, 16 Nov 2023, Mark Cave-Ayland wrote:
>>>>>>>> This series adds a simple implementation of legacy/native mode
>>>>>>>> switching for PCI
>>>>>>>> IDE controllers and updates the via-ide device to use it.
>>>>>>>>
>>>>>>>> The approach I take here is to add a new pci_ide_update_mode()
>>>>>>>> function which handles
>>>>>>>> management of the PCI BARs and legacy IDE ioports for each mode
>>>>>>>> to avoid exposing
>>>>>>>> details of the internal logic to individual PCI IDE controllers.
>>>>>>>>
>>>>>>>> As noted in [1] this is extracted from a local WIP branch I have
>>>>>>>> which contains
>>>>>>>> further work in this area. However for the moment
>>>>>>>> I've kept it simple (and
>>>>>>>> restricted it to the via-ide device) which is good
>>>>>>>> enough for Zoltan's PPC
>>>>>>>> images whilst paving the way for future improvements after 8.2.
>>>>>>>>
>>>>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>>>>
>>>>>>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>>>>>>>>
>>>>>>>> v3:
>>>>>>>> - Rebase onto master
>>>>>>>> - Move ide_portio_list[] and ide_portio_list2[] to IDE core to
>>>>>>>> prevent duplication in
>>>>>>>>    hw/ide/pci.c
>>>>>>>> - Don't zero BARs when switching from native mode to legacy
>>>>>>>> mode, instead always force
>>>>>>>>    them to read zero as suggested in the PCI IDE specification
>>>>>>>> (note: this also appears
>>>>>>>>    to fix the fuloong2e machine booting from IDE)
>>>>>>>
>>>>>>> Not sure you're getting this, see also:
>>>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg04167.html
>>>>>>> but this seems to break latest version of the AmigaOS driver for
>>>>>>> some reason. I assume this is the BAR zeroing that causes this as it
>>>>>>> works with v2 series and nothing else changed in v3 that could cause
>>>>>>> this. Testing was done by Rene Engel, cc'd so maybe he can add more
>>>>>>> info. It seems to work with my patch that sets BARs to legacy values
>>>>>>> and with v2 that sets them to 0 but not with v3 which should also
>>>>>>> read 0 but maybe something is off here.
>>>>>>
>>>>>> I've been AFK for a few days, so just starting to catch up on various
>>>>>> bits and pieces.
>>>>>
>>>>> OK just wasn't sure if you saw my emails at all as it happened before that
>>>>> some spam filters disliked my mail server and put messages in the spam
>>>>> folder.
>>>>>
>>>>>> The only difference I can think of regarding the BAR zeroing is that the
>>>>>> BMDMA BAR is zeroed here. Does the following diff fix things?
>>>>>
>>>>> This helps, with this the latest driver does not crash but still
>>>>> reads BAR4
>>>>> as 0 instead of 0xcc00 so UDMA won't work but at least it boots.
>>>>
>>>> And disabling only the first four BARs is actually what the spec says,
>>>> too. So I'll make this change to the queued patches.
>>>
>>> That was definitely something that I thought about: what should happen
>>> to BARs outside of the ones mentioned in the PCI IDE controller
>>> specification? It seems reasonable to me just to consider BARS 0-3 for
>>> zeroing here.
>>>
>>>> If I understand correctly, UDMA didn't work before this series either,
>>>> so it's a separate goal and doing it in its own patch is best anyway.
>>>>
>>>> As we don't seem to have a good place to set a default, maybe just
>>>> overriding it in via_ide_cfg_read(), too, and making it return 0xcc01 in
>>>> compatibility mode is enough?
>>>
>>> It's difficult to know whether switching to legacy mode on the via-ide
>>> device resets BAR4 to its default value, or whether it is simply left
>>> unaltered. For 8.2 I don't mind too much as long as the logic is
>>> separate from the BAR zeroing logic (which will eventually be lifted up
>>> into hw/ide/pci.c).
>>
>> My original patch checked for BAR being unset and only reset to defailt in
>> that case so it won't clobber a value set by something (like pegasos2
>> firmware) but will set default for amigaone which does not program the BAR
>> just uses the default legacy mode (which is the default on real chip but we
>> have to make that happen on QEMU after reset). So setting it to default if
>> it's unset when switching to legacy seems like a safe bet and testing with
>> my patch did not find problem with that.
> 
> How about setting the default if it's unset on the first read after
> reset instead of only on switching modes? I'd like to avoid that the
> guest could observe surprising state changes, even if the OSes we're
> currently looking at don't do that. It just seems more robust than
> introducing random magic at arbitrary points.

Note that Zoltan's image will work with just the change suggested in 
https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg04331.html, but without 
BMDMA so any discussion re: default BAR addresses can be handled separately from the 
currently queued patches.

On real AmigaOne hardware BMDMA isn't well tested because it needs a hardware 
modification and configuration changes for U-Boot [1], and given that BAR4 isn't 
programmed by either the OS or the firmware, I'd be inclined to say that the fact it 
even works at all is because of a happy coincidence of bugs.

In the meantime the department of hacks has been looking at ways of trying to set BAR 
addresses during reset, and humbly submits the following for consideration:


diff --git a/hw/ide/via.c b/hw/ide/via.c
index 47223b1268..bec4a3d09b 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -30,6 +30,7 @@
  #include "qemu/module.h"
  #include "qemu/range.h"
  #include "sysemu/dma.h"
+#include "sysemu/reset.h"
  #include "hw/isa/vt82c686.h"
  #include "hw/ide/pci.h"
  #include "hw/irq.h"
@@ -118,6 +119,23 @@ static void via_ide_set_irq(void *opaque, int n, int level)
      qemu_set_irq(s->isa_irq[n], level);
  }

  #include "hw/irq.h"
@@ -118,6 +119,23 @@ static void via_ide_set_irq(void *opaque, int n, int level)
      qemu_set_irq(s->isa_irq[n], level);
  }

+static void via_ide_bar_reset(void *opaque)
+{
+    PCIIDEState *d = PCI_IDE(opaque);
+    PCIDevice *pd = PCI_DEVICE(d);
+    uint8_t *pci_conf = pd->config;
+
+    /*
+     * Some OSs e.g. AmigaOS rely on the default BMDMA BAR value being present
+     * to initialise correctly, even in legacy mode(!)
+     */
+    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4,
+                 0xcc00 | PCI_BASE_ADDRESS_SPACE_IO);
+
+    /* Unregister reset function */
+    qemu_unregister_reset(via_ide_bar_reset, opaque);
+}
+
  static void via_ide_reset(DeviceState *dev)
  {
      PCIIDEState *d = PCI_IDE(dev);
@@ -156,6 +174,9 @@ static void via_ide_reset(DeviceState *dev)
      pci_set_long(pci_conf + 0x68, 0x00000200);
      /* PCI PM Block */
      pci_set_long(pci_conf + 0xc0, 0x00020001);
+
+    /* Register separate function to set BAR values after PCI bus reset */
+    qemu_register_reset(via_ide_bar_reset, d);
  }

  static uint32_t via_ide_cfg_read(PCIDevice *pd, uint32_t addr, int len)


This works because the reset handlers are stored in an ordered list, so 
via_ide_bar_reset() is guaranteed to be called after the PCI bus reset occurs.


ATB,

Mark.

[1] https://intuitionbase.com/hints.php

