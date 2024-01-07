Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA62826476
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 15:15:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTuh-0002VZ-3v; Sun, 07 Jan 2024 09:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMTuf-0002VA-4o; Sun, 07 Jan 2024 09:14:05 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMTud-0000AN-1Y; Sun, 07 Jan 2024 09:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=plcq/vaPaY56OH3vaZcFNB47c3OIAM4rPUVR8J0bxrg=; b=EDkUctoC5koLoJFNi5PVdiqa4a
 g/TZincBGi+3F/KzeO8ta84SFy1mn4S0q+mhvEJQi6TX6XY4CiBh8xYuMunJeLvfv/2ju6jq41llV
 9bjMvSQSvipAxSnXuoZYT3hH0V053xFxcOU8DL9LcaUxJIIK60HJp254ECTdglaG8RLAxLRkyl3lm
 CMP0qqqDBuUIWQ8TRqHAdJh94UwxLBlpsfbBVGxfEsFPEkuoaOMmI7Op/IHY7+bo8hQWsxcJ4cVrw
 g8WfHslq+8zEEjBy9tkLUDL0xWaygAmmlkCnAjBwXHiGgObnAN57r0TWTrHM0j18fGcUd28LdYkdf
 bNfVRDFPkChEqd8NXYxUFn1xENWk/1Jm2MWWFzYPZmKaiqBYWZt8VUt0TkhilUMf6dy4LAhbxqE69
 chZVTAZafPtbSsB0dx4qE4shnSoQHI64r/eoGje028ZWq8uaHJMTLN8e33+piOpztOAn0gVmnzuM5
 UC+q0lJ2p0eCocDUwl/9BZ/ceKEJA2tqM3mrvpU2R4Oavmx35l8onuv0+xfN+ACWHz6p+HQS1ckZH
 is4juqrtF0E76GGnSk+Ucmptkhwf14kQ7qfadSGXPTEwe1PjjiG6dOb2k8lb5pcPnI1ouMC8I/VZ3
 nPut+cRLqqdXsRmKGFgDm1JVUBVtLpP+caEOAT3fs=;
Received: from [2a00:23c4:8bb1:9800:d580:3d66:e68a:4949]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMTtt-0003hh-Lm; Sun, 07 Jan 2024 14:13:21 +0000
Message-ID: <8e46217c-f28b-43b0-bea3-583d4b3cf42b@ilande.co.uk>
Date: Sun, 7 Jan 2024 14:13:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
References: <20240106210531.140542-1-shentey@gmail.com>
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
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:d580:3d66:e68a:4949
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 00/11] hw/isa/vt82c686: Implement relocation and
 toggling of SuperI/O functions
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

On 06/01/2024 21:05, Bernhard Beschow wrote:

> This series implements relocation of the SuperI/O functions of the VIA south
> bridges which resolves some FIXME's. It is part of my via-apollo-pro-133t
> branch [1] which is an extension of bringing the VIA south bridges to the PC
> machine [2]. This branch is able to run some real-world X86 BIOSes in the hope
> that it allows us to form a better understanding of the real vt82c686b devices.
> Implementing relocation and toggling of the SuperI/O functions is one step to
> make these BIOSes run without error messages, so here we go.
> 
> The series is structured as follows: Patches 1-3 prepare the TYPE_ISA_FDC,
> TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL to relocate and toggle (enable/disable)
> themselves without breaking encapsulation of their respective device states.
> This is achieved by moving the MemoryRegions and PortioLists from the device
> states into the encapsulating ISA devices since they will be relocated and
> toggled.
> 
> Inspired by the memory API patches 4-6 add two convenience functions to the
> portio_list API to toggle and relocate portio lists. Patch 5 is a preparation
> for that which removes some redundancies which otherwise had to be dealt with
> during relocation.
> 
> Patches 7-9 implement toggling and relocation for types TYPE_ISA_FDC,
> TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL. Patch 10 prepares the pegasos2 machine
> which would end up with all SuperI/O functions disabled if no -bios argument is
> given. Patch 11 finally implements the main feature which now relies on
> firmware to configure the SuperI/O functions accordingly (except for pegasos2).
> 
> v4:
> * Drop incomplete SuperI/O vmstate handling (Zoltan)
> 
> v3:
> * Rework various commit messages (Zoltan)
> * Drop patch "hw/char/serial: Free struct SerialState from MemoryRegion"
>    (Zoltan)
> * Generalize wording in migration.rst to include portio_list API (Zoltan)
> 
> v2:
> * Improve commit messages (Zoltan)
> * Split pegasos2 from vt82c686 patch (Zoltan)
> * Avoid poking into device internals (Zoltan)
> 
> Testing done:
> * `make check`
> * `make check-avocado`
> * Run MorphOS on pegasos2 with and without pegasos2.rom
> * Run Linux on amigaone
> * Run real-world BIOSes on via-apollo-pro-133t branch
> * Start rescue-yl on fuloong2e
> 
> [1] https://github.com/shentok/qemu/tree/via-apollo-pro-133t
> [2] https://github.com/shentok/qemu/tree/pc-via
> 
> Bernhard Beschow (11):
>    hw/block/fdc-isa: Move portio_list from FDCtrl to FDCtrlISABus
>    hw/block/fdc-sysbus: Move iomem from FDCtrl to FDCtrlSysBus
>    hw/char/parallel: Move portio_list from ParallelState to
>      ISAParallelState
>    exec/ioport: Resolve redundant .base attribute in struct
>      MemoryRegionPortio
>    exec/ioport: Add portio_list_set_address()
>    exec/ioport: Add portio_list_set_enabled()
>    hw/block/fdc-isa: Implement relocation and enabling/disabling for
>      TYPE_ISA_FDC
>    hw/char/serial-isa: Implement relocation and enabling/disabling for
>      TYPE_ISA_SERIAL
>    hw/char/parallel-isa: Implement relocation and enabling/disabling for
>      TYPE_ISA_PARALLEL
>    hw/ppc/pegasos2: Let pegasos2 machine configure SuperI/O functions
>    hw/isa/vt82c686: Implement relocation and toggling of SuperI/O
>      functions
> 
>   docs/devel/migration.rst       |  6 ++--
>   hw/block/fdc-internal.h        |  4 ---
>   include/exec/ioport.h          |  4 ++-
>   include/hw/block/fdc.h         |  3 ++
>   include/hw/char/parallel-isa.h |  5 +++
>   include/hw/char/parallel.h     |  2 --
>   include/hw/char/serial.h       |  2 ++
>   hw/block/fdc-isa.c             | 18 +++++++++-
>   hw/block/fdc-sysbus.c          |  6 ++--
>   hw/char/parallel-isa.c         | 14 ++++++++
>   hw/char/parallel.c             |  2 +-
>   hw/char/serial-isa.c           | 14 ++++++++
>   hw/isa/vt82c686.c              | 66 ++++++++++++++++++++++++++++------
>   hw/ppc/pegasos2.c              | 15 ++++++++
>   system/ioport.c                | 41 +++++++++++++++++----
>   15 files changed, 172 insertions(+), 30 deletions(-)

I think this series generally looks good: the only thing I think it's worth checking 
is whether portio lists are considered exclusive to ISA devices or not? (Paolo?).

The portio_list_set_enabled() API looks interesting, and could be considered for use 
by my PCI IDE mode-switching changes too.

Apologies I don't have a huge amount of time for review right now, but I wanted to 
feed back that generally these patches look good, and if people are happy with the 
portio list changes then this series should be considered for merge.


ATB,

Mark.


