Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFF680AD40
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 20:41:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBghj-0003yj-21; Fri, 08 Dec 2023 14:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rBghd-0003y7-8t
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:40:01 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rBghb-0007vJ-7d
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KmCuIcj61sgiUz9I4H/UgtMyhTxKtd9JTDyus0VXTPA=; b=b1rbtHofalQesKulDVKWObbsta
 rMAaOs2kLWyQ5JPFXGgZggMuiSk/MoK+7nypvAZ9wxA7T/Oz/E2Mv6m0XyTBJMYEfV9J8EU158n+B
 4e45GGTOZTXW8ZudMa8/6WYCTTfE1SJdfkx08ExRVyOamd9NQJNYRmZCQAFCWEQcvjY+hPrnqac17
 Hqpecyda/B/vEqE550Pz1nXTT+REO4FyhTCBbj3+gfas80sZwhtw6vCUdWCZJPYUogIi+Xux75fCD
 qhxk9NkyIRiLJfpdTFBX0RAapeZNpeC9BjtcVXpVVznO+ugag7MRUXOCkcKfLC5VrIrz1ILXen+fP
 mvH8JOMg4ATTiUweJoxwAd5xzOqOg6qnC63SLQHlDndwFYn9IxKWah2HSgweqY8b3dnvx/8miLl9h
 mDc0UqRdwQQL1QBo05BJ0fZOuPAj+T8Mf0wrm4LTLStFdG/mHYREss8TIshEz+I0cwNdGjBDWPDI5
 YGHck1dNHnBHkXuiUtgEnDIkHnGKFUu91uipZLvXmwF5VIDxy5P51yfWybDFJmHKDOxg/70+xY8Ih
 VO0J/jqBiBwS1Uu8FOBGg2adCZ6MMhG0u+0EiAeFxyp5fAt0Rvg0yg96DUI/iWoALrioTXbKzTHEf
 Y+gAg9ysjMiCY/ldQgqsu9SdfTGGLvRSCp/9YcCHo=;
Received: from [2a00:23c4:8bb0:f100:9601:9e38:9395:46ea]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rBgh5-0008m0-Vj; Fri, 08 Dec 2023 19:39:32 +0000
Message-ID: <9fdf9865-0761-4757-b0a6-1658f9a02d4d@ilande.co.uk>
Date: Fri, 8 Dec 2023 19:39:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
References: <20231208020619.117-1-zhiwei_liu@linux.alibaba.com>
 <8a876325-92bb-46e6-8ba5-47405dbb00c7@linaro.org>
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
In-Reply-To: <8a876325-92bb-46e6-8ba5-47405dbb00c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:9601:9e38:9395:46ea
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH for 8.2] accel/tcg/cputlb: Fix iotlb page alignment check
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

On 08/12/2023 17:42, Richard Henderson wrote:

> On 12/7/23 18:06, LIU Zhiwei wrote:
>> For ram memory region the iotlb(which will be filled into the xlat_section
>> of CPUTLBEntryFull) is calculated as:
>>
>> iotlb = memory_region_get_ram_addr(section->mr) + xlat;
>>
>> 1) xlat here is the offset_within_region of a MemoryRegionSection, which maybe
>> not TARGET_PAGE_BITS aligned.
> 
> The reason we require these bits to be zero is because
> (A) The lowest bits must be zero so that we may test alignment,
> (B) The "middle" bits, above alignment and below TARGET_PAGE_BITS,
>      are used for TLB_FLAGS_MASK.
> 
> If iotlb has these bits non-zero, the softmmu comparison will not work correctly.
> 
>> 2) The ram_addr_t returned by memory_region_get_ram_addr is always
>> HOST PAGE ALIGNED.
> 
> RAM blocks can have larger alignment than host page.  See QEMU_VMALLOC_ALIGN and 
> qemu_ram_mmap.
> 
> But I can see a path by which it *is* only host page aligned, which could fail if the 
> guest has larger alignment than the host.  Fortunately, this is rare -- only alpha, 
> cris, openrisc and sparc64 have 8k pages, and tricore has 16k pages, while supporting 
> system mode.  Hexagon has 64k pages but does not yet support system mode.
> 
> We should fix that, but I don't think it's urgent.

FWIW I did check the MMU configuration with the m68k test case, and I can see that 
the ROM configures the MMU to use 8k pages.

>> So we cann't assert the sum of them is TARGET_PAGE_BITS aligend.
>> A fail case has been give by the link:
>> https://lore.kernel.org/all/b68ab7d3-d3d3-9f81-569d-454ae9c11b16@linaro.org/T/
> 
> I think the macfb device is at fault here, not your assert.

The memory region is set up using a standard memory_region_init_rom() and 
memory_region_add_subregion() combination (see 
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/nubus/nubus-device.c?ref_type=heads#L79) 
so should it be that the ROM memory region must be aligned to TARGET_PAGE_MASK?

This feels odd because I don't believe there are any other alignment restrictions for 
the memory API, and if there are, shouldn't the assert() fire during 
memory_region_add_subregion() rather than during the first memory access at runtime?


ATB,

Mark.


