Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B373D508
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 00:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDY4m-0006I7-5o; Sun, 25 Jun 2023 18:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qDY4f-0006Hc-Ib
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 18:19:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qDY4d-00086X-Nh
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 18:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=07NiddXzi0YZ4G/DQbwEiQZouvxwJc1ed19ZOdvD68E=; b=Rz6XGWazXy3IfH21x1PupYRJs4
 gqS1jPCDQJ2KViJ+1h/Q4Xj6vjO+ZIbnIZFXmadNWF3YlZfVIidLuaHhBZTuQKTPElOGAi3I9nq7z
 xyld/xOeKnyo3y+xu4sIwtZNjQiq1M7uHOeX3624qZLbeJWhCn0W8PmRCRZB+c/92hzBzrE4Vi+3o
 WnyvzqfZXXya8IY8TOb6mBJUs9t6IP2oSKkTnLLvQfkzq/4hmxvCxRrwmiLBSEln7fONK4QGyG8OY
 40fOiPVdP5ttbxVsoBKt0DyY8Xl66vb8GVxueNnIwI3eQZJrfNO6UW5i7a364Fxuy85uq6oiMc/gQ
 kqQzi8yzOOqWqCBjXYLYpUgTF3KBb28KLs/OvWarZlutW9v2gYc+yIhJKpXfP2vVj50+LZ+vRr30E
 PAn5oLeOtHC4jGvvVSlekU0x2NHMlAMIJaEqHZ/pf8D79kBGAIbRzYCjwuLmgWAbegy1NDRh2IpOa
 QZhXet4CelxalMYEsgLEwjd/Di6Q+UQGdwK7cAgBj2R1gJNEQXuBPRIC4m7Ie8oRGz3ztPVlb0rGS
 NZnHS1yu44XTxjE2JBBaCsZdvx/0rwn1bVJE+k1+Vke2zLWbdjryz3K+FFvfK4+chGyEgwJm+sc9q
 JhOCvUd1TAz462UpBvlvPRax6E95jPDFIn9DLlVhY=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qDY4M-0002Qj-92; Sun, 25 Jun 2023 23:18:58 +0100
Message-ID: <a5de2959-491c-034d-c070-ed0aba9c83c7@ilande.co.uk>
Date: Sun, 25 Jun 2023 23:18:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <0e8c4da9-2b33-dc24-77b0-cea5bdd905a3@linaro.org>
 <0da13e10-27d4-ff12-656d-291bff2e1b70@ilande.co.uk>
 <773ac3d3-a7a1-13eb-7434-67e0db9b64c9@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <773ac3d3-a7a1-13eb-7434-67e0db9b64c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 00/24] q800: add support for booting MacOS Classic -
 part 1
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 22/06/2023 11:07, Philippe Mathieu-Daudé wrote:

> On 21/6/23 16:06, Mark Cave-Ayland wrote:
>> On 21/06/2023 10:42, Philippe Mathieu-Daudé wrote:
>>
>>> On 21/6/23 10:53, Mark Cave-Ayland wrote:
>>>> [MCA: the original series has now been split into 2 separate parts based upon
>>>> Phil's comments re: QOM parenting for objects in Q800MachineState. Part 1
>>>> consists of the Q800MachineState patches along with QOM parenting fixes and
>>>> the 2 mac_via RTC patches.]
>>>>
>>>> This series contains the remaining patches needed to allow QEMU's q800
>>>> machine to boot MacOS Classic when used in conjunction with a real
>>>> Quadra 800 ROM image. In fact with this series applied it is possible
>>>> to boot all of the following OSs:
>>>>
>>>>    - MacOS 7.1 - 8.1, with or without virtual memory enabled
>>>>    - A/UX 3.0.1
>>>>    - NetBSD 9.3
>>>>    - Linux (via EMILE)
>>>>
>>>> If you are ready to experience some 90s nostalgia then all you need is
>>>> to grab yourself a copy of the Quadra 800 ROM (checksum 0xf1acad13) and a
>>>> suitable install ISO as follows:
>>>>
>>>>    # Prepare a PRAM image
>>>>    $ qemu-img create -f raw pram.img 256b
>>>>
>>>>    # Launch QEMU with blank disk and install CDROM
>>>>    $ ./qemu-system-m68k \
>>>>        -M q800 \
>>>>        -m 128 \
>>>>        -bios Quadra800.rom \
>>>>        -drive file=pram.img,format=raw,if=mtd \
>>>>        -drive file=disk.img,media=disk,format=raw,if=none,id=hd \
>>>>        -device scsi-hd,scsi-id=0,drive=hd \
>>>>        -drive file=cdrom.iso,media=cdrom,if=none,id=cd \
>>>>        -device scsi-cd,scsi-id=3,drive=cd
>>>>
>>>> And off you go! For more in-depth information about the installation process
>>>> I highly recommend the installation guide over at emaculation.com [1].
>>>> Compatibility is generally very good, and I'm pleased to report it is possible
>>>> to run one of the most popular productivity apps from the 90s [2].
>>>
>>> Could you add an Avocado test for this machine? See how the
>>> MipsFuloong2e test (tests/avocado/machine_mips_fuloong2e.py)
>>> handles the firmware (RESCUE_YL_PATH).
>>
>> In theory it is possible to do this, but how do we handle booting proprietary OS 
>> ISOs that are still within copyright?
> 
> Just provide the hash. You are not redistributing anything.

Another couple of questions: even without distributing the ROM or ISO, do I still 
need to provide URLs to these resources? I see that ISOs generally have URLs but 
given that the Mac sites hosting these images tend to be quite small, I'm not sure 
that providing a link to these sites within QEMU is something they would be 
particularly happy with.

I'm also not sure what is the best way to set up the test to confirm boot is working 
correctly. Ideally we would want to boot a MacOS install CD to the desktop, but there 
isn't an easy way to determine when this has occurred. Perhaps take a screendump 
every 2s or so and use tesseract-ocr to parse for when the menu bar appears on screen?


ATB,

Mark.


