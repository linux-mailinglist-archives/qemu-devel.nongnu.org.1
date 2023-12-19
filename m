Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 055F38192F0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 23:04:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFiAb-0006w3-BT; Tue, 19 Dec 2023 17:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFiAP-0006vj-K6
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 17:02:22 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFiAN-0005zc-RH
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 17:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CDz1pmJwksozvW7Z2rp565r/82PJJ4cqsnaySfNJYzo=; b=pgPFglBlTP8x23471JOe5fEVv7
 volhscbihBTfH72IMxV13J/dkJSz/poavc/P826bPgwV/jJjCKTEgTYQTqNQwH2uo9Hm7g98taS0B
 waGMdaXl8pOvMXRxGNS+SJntyaUVBOiJKPXAbavdztoyDo1PjgwCt6TjzTVzF6MqAJvwywHcWZByo
 3iHRWtW+DhwaDjyJcUV5JmIqQsb4ZsupvSlqvxlfXIIFpXihuF4G5INPsoz7DINPA/hN/n0vj5MYI
 QBmFY6NK+TOn44MSOUKlDCzeTSewx7Id2GHS4GLU+Iy7w4bQA7CPjUebvDigbygBGNLQSI6HoOeFs
 wkZ3FMWNcoQrogewRWE/Ze/7Zj7dsarCVDVUHx7mU8JBGS3IpmvF6jRLwzUAM1l8s2dyai0DWzlN0
 VrRDgdjt61f/Ac1gQqBLMPqICSKUVT63du7RuCsvi/spaVsjNluLDeP1Xv7SpiuW2uKEL5N6tYjZH
 zQARGxUOaNV0AyO2ryJJIZPIBSsVhnZuUH6VJtd7tvKBm1/JaDhmujAPxhflOI6Qe9cvrfAFNszBO
 zZ9Nm6ZXrKsbo/hrlUS+EUcwEdXaX2QlhtHgkHbbOoD4xs7VM02C87GiujuZs3YZa3pNVZB88NuRz
 bV2q/gs1FOxOnY0LxDbh+e0kScFDqjrq03Yo2AiIM=;
Received: from [2a00:23c4:8bb0:f100:795a:8119:c46d:d080]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFi9t-0008a0-8S; Tue, 19 Dec 2023 22:01:53 +0000
Message-ID: <885390b4-2098-4db3-979b-cc45a30f8dd8@ilande.co.uk>
Date: Tue, 19 Dec 2023 22:02:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-12-mark.cave-ayland@ilande.co.uk>
 <20231216212038.45ece9fb@fedora>
 <40d000e3-a5d2-d63f-8cb8-46a73810a9e1@eik.bme.hu>
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
In-Reply-To: <40d000e3-a5d2-d63f-8cb8-46a73810a9e1@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:795a:8119:c46d:d080
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 11/12] next-cube.c: replace sysmem with
 get_system_memory() in next_cube_init()
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

On 16/12/2023 21:31, BALATON Zoltan wrote:

> On Sat, 16 Dec 2023, Thomas Huth wrote:
>> Am Fri, 15 Dec 2023 20:00:08 +0000
>> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>>
>>> Removing the intermediate variable helps simplify the code in next_cube_init().
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/m68k/next-cube.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>>> index d9a1f234ec..73deef25ca 100644
>>> --- a/hw/m68k/next-cube.c
>>> +++ b/hw/m68k/next-cube.c
>>> @@ -974,7 +974,6 @@ static void next_cube_init(MachineState *machine)
>>>      MemoryRegion *dmamem = g_new(MemoryRegion, 1);
>>>      MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
>>>      MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
>>> -    MemoryRegion *sysmem = get_system_memory();
>>>      const char *bios_name = machine->firmware ?: ROM_FILE;
>>>      DeviceState *pcdev;
>>>
>>> @@ -996,7 +995,8 @@ static void next_cube_init(MachineState *machine)
>>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(pcdev), &error_fatal);
>>>
>>>      /* 64MB RAM starting at 0x04000000  */
>>> -    memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
>>> +    memory_region_add_subregion(get_system_memory(), 0x04000000,
>>> +                                machine->ram);
>>>
>>>      /* Framebuffer */
>>>      sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
>>> @@ -1010,19 +1010,19 @@ static void next_cube_init(MachineState *machine)
>>>      /* BMAP memory */
>>>      memory_region_init_ram_flags_nomigrate(bmapm1, NULL, "next.bmapmem", 64,
>>>                                             RAM_SHARED, &error_fatal);
>>> -    memory_region_add_subregion(sysmem, 0x020c0000, bmapm1);
>>> +    memory_region_add_subregion(get_system_memory(), 0x020c0000, bmapm1);
>>>      /* The Rev_2.5_v66.bin firmware accesses it at 0x820c0020, too */
>>>      memory_region_init_alias(bmapm2, NULL, "next.bmapmem2", bmapm1, 0x0, 64);
>>> -    memory_region_add_subregion(sysmem, 0x820c0000, bmapm2);
>>> +    memory_region_add_subregion(get_system_memory(), 0x820c0000, bmapm2);
>>>
>>>      /* KBD */
>>>      sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
>>>
>>>      /* Load ROM here */
>>>      memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
>>> -    memory_region_add_subregion(sysmem, 0x01000000, rom);
>>> +    memory_region_add_subregion(get_system_memory(), 0x01000000, rom);
>>>      memory_region_init_alias(rom2, NULL, "next.rom2", rom, 0x0, 0x20000);
>>> -    memory_region_add_subregion(sysmem, 0x0, rom2);
>>> +    memory_region_add_subregion(get_system_memory(), 0x0, rom2);
>>>      if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
>>>          if (!qtest_enabled()) {
>>>              error_report("Failed to load firmware '%s'.", bios_name);
>>> @@ -1051,7 +1051,7 @@ static void next_cube_init(MachineState *machine)
>>>      /* DMA */
>>>      memory_region_init_io(dmamem, NULL, &next_dma_ops, machine, "next.dma",
>>>                            0x5000);
>>> -    memory_region_add_subregion(sysmem, 0x02000000, dmamem);
>>> +    memory_region_add_subregion(get_system_memory(), 0x02000000, dmamem);
>>>  }
>>
>> Mostly a matter of taste, but I'd prefer to keep it like it was before - I
>> dislike calling functions multiple times if one time is sufficient.
> 
> The get_system_memory() function will only return a pointer to a static variable 
> though so it's not expensive to call it multiple times and introducing a local 
> variable just adds one more name for it to look up when reading the code so I 
> generally prefer using it directly as it would likely be inlined by the compiler anyway.

I don't really have a preference either way (it was mainly inspired by looking at 
existing code), so if Thomas would prefer that as maintainer then that's fine with me.

> That's also matter of taste but all the memory regions the next patch moves to 
> machine state aren't really needed as these are only used for creating a mem region 
> and adding it as subregion to system memory so one MemoryRegion *mr variable would be 
> enough (and a meybe one more for alias regions) that are reused for all of these 
> without storing them in machine state where they aren't used any more so no need to 
> srore them.

Embedding the memory regions in the machine state is simply encapsulating them in 
into a container, as we already do for static memory regions used by devices. Also if 
you don't keep track of the memory regions, presumably they will leak when QEMU 
terminates?

> Also I think in memory region call backs the void *opaque parameter don't need a QOM 
> cast as these are registered here with already the wanted type for opaque so no need 
> to check that every time the memory region is accessed.

I don't think that will be an issue here, and I quite like that it provides an extra 
layer of type safety.


ATB,

Mark.


