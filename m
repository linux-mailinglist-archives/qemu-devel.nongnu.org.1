Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB1739832
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:35:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCEqL-0006dM-Ri; Thu, 22 Jun 2023 03:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCEqJ-0006d4-1x
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:34:59 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCEqH-0001Ux-15
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:34:58 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHX3R-1qGJJf3VBZ-00DW7Q; Thu, 22 Jun 2023 09:34:55 +0200
Message-ID: <e62cc656-b313-0b21-531c-44a5e5a480af@vivier.eu>
Date: Thu, 22 Jun 2023 09:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/24] q800: add support for booting MacOS Classic -
 part 1
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ohZP+/5W6dL9xnjHCEdF0wjvuzy6Zf/TL6F8bEeSPKX31KvvZwh
 1lfuq+35psPz1jje1WuiS5Fjz0VhC5r+W2cc4F/5quGYQqw75Q8NgM3FVQ5DJpp3bqaAIFC
 ArAICoHGSOppbF+jMDFVHXIvlrGgm82unmEMvOYM8goU8wd8lyfAWKr/f9KCOScQe61mJ0+
 tIlRwIjQ75iNDPC8gjcdA==
UI-OutboundReport: notjunk:1;M01:P0:gonCbJLCFxQ=;o7Ks8539/Li1p866k2TAS5CS34v
 iwUm9idWtVrVvoSSePkIfYMAVNcdiOCV5C/0qAk8004ZySzfw392AIraSj4ykuz90B3swoeeM
 1YDjBHoaRPcF5fMLP+Dsz0qy2PrhaU94q5Tj/APQU25QNs18s2kya7tdQvqGXr0ANKFS3dOkW
 E6PFQIUupAKtpbpUQ3IZZvQsvt0WD2iDJj58HRkHouWKFrdRvoTeE96I9uxFBPZo+E+F0CywB
 zYTyUBi3XGCuoYg/Z8nNltF7zqz3OB71gmkwK0ZtEYtZEyQ5HLQ/npafb99v0qGLS8p14A6bP
 u30gEv6JrJEMj5e1/kAgfSk3K1om19weeRflteeXxH4c+0wFwOhcMEfGvYy7+Tay6LtG4fS9g
 WAgocn6Z8e9t52aIt+1+56Ucm+X8PWuUrgcevOafSuijPXgGqH0uETTkQIOIbdxH6TCC0eBbd
 6rCv6PwAUu/CtJ2GBWhF+R75nqktlz1hwHCkZCuRqTMLh0/dx4Iu4k03KbIoDAJunTayQvxNo
 5kFtjsXz60xrhm1/cLtA8+VERHEM0AGXgP7AirHAry1scyMPv61+xoi6t5gcn18ugoE2WFX/a
 Q5GdbE32YOGRd7jfqAVw6UP8wycVFAjRt0/Yc1gIrshxYIJhg7jPd7/1HvN4p4kiYLEBP3XuG
 JlwC3Y5yQbivhDPQCPdDuaAITOe32owo61XMO1eqPQ==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 21/06/2023 à 10:53, Mark Cave-Ayland a écrit :
> [MCA: the original series has now been split into 2 separate parts based upon
> Phil's comments re: QOM parenting for objects in Q800MachineState. Part 1
> consists of the Q800MachineState patches along with QOM parenting fixes and
> the 2 mac_via RTC patches.]
> 
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
> Patches missing review tags: 8 (new)
> 
> v4:
> - Rebase onto master
> - Add R-B tags from Phil and Laurent
> - Use qdev_realize() in patch 5 as suggested by Markus
> - Add new patch 8 to switch q800-glue.c to use the DEFINE_TYPES macro
>    as suggested by Phil
> 
> v3:
> - Add R-B tags from Phil and Laurent
> - Add missing headers in patches indicated by Phil
> - Change patch 5 to use valid_cpu_types Machine class property and the cpu_type
>    Machine property to initialise the CPU
> - Remove osdep.h header from dp8393x.h in patch 13 noticed by Phil
> - Change sysbus_realize_and_unref() to sysbus_realize() in patch 19
> - Use memory_region_add_subregion() instead of sysbus_mmio_map() in patch 19
> 
> v2:
> - Split series into 2 parts (this is part 1)
> - Update QOM parenting for objects in Q800MachineState (Phil)
> - Split GLUE device into separate glue.c and glue.h files
> - Split TYPE_DP8393X and dp8393xState into dp8393x.h
> - Add R-B tags from Laurent (where I still believe they are valid)
> 
> 
> Mark Cave-Ayland (24):
>    q800: fix up minor spacing issues in hw_compat_q800 GlobalProperty
>      array
>    q800: add missing space after parent object in GLUEState
>    q800: introduce Q800MachineState
>    q800: rename q800_init() to q800_machine_init()
>    q800: move CPU object into Q800MachineState
>    q800: move ROM memory region to Q800MachineState
>    q800: move GLUE device into separate q800-glue.c file
>    q800-glue.c: switch TypeInfo registration to use DEFINE_TYPES() macro
>    q800: move GLUE device to Q800MachineState
>    q800: introduce mac-io container memory region
>    q800: reimplement mac-io region aliasing using IO memory region
>    q800: move VIA1 device to Q800MachineState
>    q800: move VIA2 device to Q800MachineState
>    hw/net/dp8393x.c: move TYPE_DP8393X and dp8393xState into dp8393x.h
>    q800: move dp8393x device to Q800MachineState
>    q800: move ESCC device to Q800MachineState
>    q800: move escc_orgate device to Q800MachineState
>    q800: move ESP device to Q800MachineState
>    q800: move SWIM device to Q800MachineState
>    q800: move mac-nubus-bridge device to Q800MachineState
>    q800: don't access Nubus bus directly from the mac-nubus-bridge device
>    q800: move macfb device to Q800MachineState
>    mac_via: fix rtc command decoding from PRAM addresses 0x0 to 0xf
>    mac_via: fix rtc command decoding for the PRAM seconds registers
> 
>   MAINTAINERS                 |   3 +
>   hw/m68k/meson.build         |   2 +-
>   hw/m68k/q800-glue.c         | 249 +++++++++++++++++
>   hw/m68k/q800.c              | 526 ++++++++++++++----------------------
>   hw/misc/mac_via.c           |  13 +-
>   hw/net/dp8393x.c            |  32 +--
>   include/hw/m68k/q800-glue.h |  50 ++++
>   include/hw/m68k/q800.h      |  66 +++++
>   include/hw/net/dp8393x.h    |  60 ++++
>   9 files changed, 635 insertions(+), 366 deletions(-)
>   create mode 100644 hw/m68k/q800-glue.c
>   create mode 100644 include/hw/m68k/q800-glue.h
>   create mode 100644 include/hw/m68k/q800.h
>   create mode 100644 include/hw/net/dp8393x.h
> 

Queued

Thanks,
Laurent

