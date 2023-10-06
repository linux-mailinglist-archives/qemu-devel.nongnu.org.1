Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3867BB5DF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoidT-0006lG-On; Fri, 06 Oct 2023 07:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qoidQ-0006aG-W1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:04:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qoidO-0005qb-HR
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:04:44 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MRC3Y-1r0lqE3yMe-00NAfC; Fri, 06 Oct 2023 13:04:39 +0200
Message-ID: <db65e8f3-b3d0-2edc-c0c1-b92cad7852ff@vivier.eu>
Date: Fri, 6 Oct 2023 13:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/20] q800: add support for booting MacOS Classic -
 part 2
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Aekkxkbm/ESY2VFguV/nT4FajgSm9ThL7cw223+mEMEF7B4WWAe
 tJwSaEPV5p6GNhIu9NLcd71LeCrf7R7FwEiWj/+GqzzmOajehuh03HTzCHv1nosv8ElPlOn
 sHN4galD2DAk7YGKjP7LThnWk+Df2JlePq0nzOjXI2mqzFHmhwciOi/KTVOr5m3dWALjUKT
 LNrPiNVygLUmTxdq3Uc+w==
UI-OutboundReport: notjunk:1;M01:P0:RhjrkywvQV0=;Re9CnYie2P+GDGHWsHSLdwdXdns
 NRmQ9rdZwRu6vnxQkM4jjE9nzHJuXSFkrqEEnDcsEyEdD/GumMlcht1k44T7FwpAnTagCx1aP
 p6f5C91UR6rZ0ITTDk7qHCFDap93V8/IBFxVdXMu/eAzFzqphpVdQ2MWeU/JulrFl6XpgdNoo
 G1hU3JbIcfRt9oYvoZGPiZ9W4inmwGf8Hyas2G+2eGtZd72agmUNHFI47GjfbuH8rCabOV9HS
 AVU4qWNilOITxTul6XCisI3aNabZaeBo2KiDqedRXzsoE0s1VhcUjn3gU5qYK/+AUfhBEvtPM
 Bv3c3kJLi05iYU7Nzdnf/avRq/ckIuAAfkzrbzNOHKmjzqaAM++X7FWYtrff5MN5G0xByIJXI
 /fWTQh3nHdJ2neJLzQOoUd3DehOW21baTwpLLU8/Fp+ZJ1vtDdXRBC+sWppdsZrbpudRa8df1
 ivaUZ0UIiqOFMsDS7kuadQEn6XSRKhTXgAiIbHCpEAHwLyQkwJmek9O0JyreziMR6w3qjNPdy
 81KskFtlbTXsPAwHYOgfSfbfYe/cA1FdKtQfW1MSC+jjZCRH6JsEwQoJs6l8w3ehC6tLB2Nla
 AQXQnzfi5QLEw7513tMaQA98WQeO0WmB/oCLmuYSQpJI8Am0KkkVAvZtDDLUOJH5gtHOiJOW7
 X4lZYAaulC6glbbZyHfPdbg/5VinQr93/E1z+c+u9Layi54Us7Hom1O+WN3PCwvDZVxd9rrN+
 q3rDmCCKruMHm7b9sl+HWhD3gaGigpdBvT0NH/aY1RG4s0mYVDJhQAXLwgx7e4363r2AuyM2A
 acqaKrschFKzcUGeAV0qY8qYN1C5g/TZe2u/ufq8mwhcyhG2/HD/TLphtzuRq2MX417K787NI
 1meh0IUrpnEffDw==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.797,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 04/10/2023 à 10:37, Mark Cave-Ayland a écrit :
> This series contains the remaining patches needed to allow QEMU's q800
> machine to boot MacOS Classic when used in conjunction with a real
> Quadra 800 ROM image. In fact with this series applied it is possible
> to boot all of the following OSs:
> 
>    - MacOS 7.1 - 8.1, with or without virtual memory enabled
>    - A/UX 3.0.1
>    - NetBSD 9.3
>    - Linux (via EMILE)
> 
> If you are ready to experience some 90s nostalgia then all you need is
> to grab yourself a copy of the Quadra 800 ROM (checksum 0xf1acad13) and a
> suitable install ISO as follows:
> 
>    # Prepare a PRAM image
>    $ qemu-img create -f raw pram.img 256b
> 
>    # Launch QEMU with blank disk and install CDROM
>    $ ./qemu-system-m68k \
>        -M q800 \
>        -m 128 \
>        -bios Quadra800.rom \
>        -drive file=pram.img,format=raw,if=mtd \
>        -drive file=disk.img,media=disk,format=raw,if=none,id=hd \
>        -device scsi-hd,scsi-id=0,drive=hd \
>        -drive file=cdrom.iso,media=cdrom,if=none,id=cd \
>        -device scsi-cd,scsi-id=3,drive=cd
> 
> And off you go! For more in-depth information about the installation process
> I highly recommend the installation guide over at emaculation.com [1].
> Compatibility is generally very good, and I'm pleased to report it is possible
> to run one of the most popular productivity apps from the 90s [2].
> 
> I'd like to add a big thank you to all the people who have helped me work on
> this series, including testing on real hardware, answering questions about
> MacOS Classic internals and helping to diagnose and fix bugs in the 68k
> emulation. In particular thanks go to Laurent Vivier, Finn Thain, Howard
> Spoelstra, Volker Rümelin, Richard Henderson, Martin Husemann, Rin Okuyama,
> Elliot Nunn, and SolraBizna.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> [1] https://www.emaculation.com/doku.php/qemu
> [2] https://www.youtube.com/watch?v=yI21gURQ1Ew
> 
> 
> v4:
> - Rebase onto master
> - Add R-B tag from Zoltan to patch 5
> - Adjust AUD_register_card() and add machine audiodev property for ASC to reflect Paolo's
>    recent audiodev changes
> 
> v3:
> - Rebase onto master
> - Add R-B tags from Laurent
> - Squash fixes from Volker into patch 7 ("audio: add Apple Sound Chip (ASC) emulation")
> - Change iwmregs from uint16_t to uint8_t in patch 12 ("swim: split into separate IWM
>    and ISM register blocks")
> 
> v2:
> - Rebase onto master
> - Add R-B tags from Phil and Laurent
> - Improve ASC logic for generating interrupts when FIFO underflow occurs
> - Rework ASC silence generation logic similar to Volker's original proposal
> - Update A/UX timer calibration hack to reflect the change of accesses now that
>    #360 is resolved
> 
> 
> Mark Cave-Ayland (20):
>    q800-glue.c: convert to Resettable interface
>    q800: add djMEMC memory controller
>    q800: add machine id register
>    q800: implement additional machine id bits on VIA1 port A
>    q800: add IOSB subsystem
>    q800: allow accesses to RAM area even if less memory is available
>    audio: add Apple Sound Chip (ASC) emulation
>    asc: generate silence if FIFO empty but engine still running
>    q800: add Apple Sound Chip (ASC) audio to machine
>    q800: add easc bool machine class property to switch between ASC and
>      EASC
>    swim: add trace events for IWM and ISM registers
>    swim: split into separate IWM and ISM register blocks
>    swim: update IWM/ISM register block decoding
>    mac_via: work around underflow in TimeDBRA timing loop in SETUPTIMEK
>    mac_via: workaround NetBSD ADB bus enumeration issue
>    mac_via: implement ADB_STATE_IDLE state if shift register in input
>      mode
>    mac_via: always clear ADB interrupt when switching to A/UX mode
>    q800: add ESCC alias at 0xc000
>    q800: add alias for MacOS toolbox ROM at 0x40000000
>    mac_via: extend timer calibration hack to work with A/UX
> 
>   MAINTAINERS                 |   6 +
>   hw/audio/Kconfig            |   3 +
>   hw/audio/asc.c              | 727 ++++++++++++++++++++++++++++++++++++
>   hw/audio/meson.build        |   1 +
>   hw/audio/trace-events       |  10 +
>   hw/block/swim.c             | 261 ++++++++-----
>   hw/block/trace-events       |   8 +
>   hw/m68k/Kconfig             |   3 +
>   hw/m68k/q800-glue.c         |  18 +-
>   hw/m68k/q800.c              | 138 ++++++-
>   hw/misc/Kconfig             |   6 +
>   hw/misc/djmemc.c            | 135 +++++++
>   hw/misc/iosb.c              | 133 +++++++
>   hw/misc/mac_via.c           | 234 +++++++++++-
>   hw/misc/meson.build         |   2 +
>   hw/misc/trace-events        |  10 +
>   include/hw/audio/asc.h      |  86 +++++
>   include/hw/block/swim.h     |  21 +-
>   include/hw/m68k/q800-glue.h |   4 +-
>   include/hw/m68k/q800.h      |  11 +
>   include/hw/misc/djmemc.h    |  30 ++
>   include/hw/misc/iosb.h      |  25 ++
>   include/hw/misc/mac_via.h   |   3 +
>   23 files changed, 1769 insertions(+), 106 deletions(-)
>   create mode 100644 hw/audio/asc.c
>   create mode 100644 hw/misc/djmemc.c
>   create mode 100644 hw/misc/iosb.c
>   create mode 100644 include/hw/audio/asc.h
>   create mode 100644 include/hw/misc/djmemc.h
>   create mode 100644 include/hw/misc/iosb.h
> 

Applied to my q800-for-8.2 branch.

Thanks,
LAurent

