Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1922718098
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LLc-0007AC-LH; Wed, 31 May 2023 08:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLO-00078U-Tg
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLL-0006kk-Ny
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HgIL3wcpT3xjOv235N/hzA2HcPIdV72O3KpqbB8sHRo=; b=YO6ibPX/QI7AyQ3aUL6cDZBVdR
 SUdaTu2WUy7eOW9CQAZzzZBUAAADT8DcOFYf3oUxkFs44SFSNsOMVdGenOipbCKldFh6EVKwVER7c
 P0qjtzn/E3NE3MQjv1/am94Ja25UAJMrmOE5anfswi2SxJioV63WzSH9JgElfNLMUYiXdZ5SAXKBV
 HuWiJubZ6RLGq5OhrBQk+/JGccox5l1H7q5BfAU1Y4sE8rjV6Q68in9OJjBkJmfwqrZBVXljqYCh/
 qJEoojLQHYO/34Tae92fuN2XIyzTkOsgLRDa0XNBSqpB+TAxqtloaQLi2hDNEQMkfThPrLMvrnJLd
 BJvKMjMStXyt8MPZYrTdtK9tK2ohuPmDq8uakUUY2AZs0C2m2nO+u+VCG3YrQ8s++BDLcUJ7MzF3h
 eJLuuhQ2DThe4UFVPXFfF7K2b3OU878EEP5Q3xE40mwTaEJ0IYzfoBu0WEbQTQuDFr64huDi6HIOf
 OSSXbS7Pg9aSZRiOVmzXkoZYuB8heP7D3wUH7D6335HXm17w8dt79oVmnNFislOuC7gXMORPz49RC
 ELGOb0PVVSD4ppo+KoVF6UE8ejK2avxediLyR+z2P3wgY8hHC3AToF68ZbMfwCaEyL09IG6jvW0lP
 DibjPEH0bvgo+5FYQemTCZDIpV5nkjH2UPqAyV7mQ=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LL8-0008vd-HF; Wed, 31 May 2023 13:54:14 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:37 +0100
Message-Id: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 00/23] q800: add support for booting MacOS Classic - part 1
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

[MCA: the original series has now been split into 2 separate parts based upon
Phil's comments re: QOM parenting for objects in Q800MachineState. Part 1
consists of the Q800MachineState patches along with QOM parenting fixes and
the 2 mac_via RTC patches.]

This series contains the remaining patches needed to allow QEMU's q800
machine to boot MacOS Classic when used in conjunction with a real
Quadra 800 ROM image. In fact with this series applied it is possible
to boot all of the following OSs:

  - MacOS 7.1 - 8.1, with or without virtual memory enabled
  - A/UX 3.0.1
  - NetBSD 9.3
  - Linux (via EMILE)

If you are ready to experience some 90s nostalgia then all you need is
to grab yourself a copy of the Quadra 800 ROM (checksum 0xf1acad13) and a
suitable install ISO as follows:

  # Prepare a PRAM image
  $ qemu-img create -f raw pram.img 256b

  # Launch QEMU with blank disk and install CDROM
  $ ./qemu-system-m68k \
      -M q800 \
      -m 128 \
      -bios Quadra800.rom \
      -drive file=pram.img,format=raw,if=mtd \
      -drive file=disk.img,media=disk,format=raw,if=none,id=hd \
      -device scsi-hd,scsi-id=0,drive=hd \
      -drive file=cdrom.iso,media=cdrom,if=none,id=cd \
      -device scsi-cd,scsi-id=3,drive=cd

And off you go! For more in-depth information about the installation process
I highly recommend the installation guide over at emaculation.com [1].
Compatibility is generally very good, and I'm pleased to report it is possible
to run one of the most popular productivity apps from the 90s [2].

I'd like to add a big thank you to all the people who have helped me work on
this series, including testing on real hardware, answering questions about
MacOS Classic internals and helping to diagnose and fix bugs in the 68k
emulation. In particular thanks go to Laurent Vivier, Finn Thain, Howard
Spoelstra, Volker Rümelin, Richard Henderson, Martin Husemann, Rin Okuyama,
Elliot Nunn, and SolraBizna.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[1] https://www.emaculation.com/doku.php/qemu
[2] https://www.youtube.com/watch?v=yI21gURQ1Ew


v2:
- Split series into 2 parts (this is part 1)
- Update QOM parenting for objects in Q800MachineState (Phil)
- Split GLUE device into separate glue.c and glue.h files
- Split TYPE_DP8393X and dp8393xState into dp8393x.h
- Add R-B tags from Laurent (where I still believe they are valid)


Mark Cave-Ayland (23):
  q800: fix up minor spacing issues in hw_compat_q800 GlobalProperty
    array
  q800: add missing space after parent object in GLUEState
  q800: introduce Q800MachineState
  q800: rename q800_init() to q800_machine_init()
  q800: move CPU object into Q800MachineState
  q800: move ROM memory region to Q800MachineState
  q800: move GLUE device into separate q800-glue.c file
  q800: move GLUE device to Q800MachineState
  q800: introduce mac-io container memory region
  q800: reimplement mac-io region aliasing using IO memory region
  q800: move VIA1 device to Q800MachineState
  q800: move VIA2 device to Q800MachineState
  hw/net/dp8393x.c: move TYPE_DP8393X and dp8393xState into dp8393x.h
  q800: move dp8393x device to Q800MachineState
  q800: move ESCC device to Q800MachineState
  q800: move escc_orgate device to Q800MachineState
  q800: move ESP device to Q800MachineState
  q800: move SWIM device to Q800MachineState
  q800: move mac-nubus-bridge device to Q800MachineState
  q800: don't access Nubus bus directly from the mac-nubus-bridge device
  q800: move macfb device to Q800MachineState
  mac_via: fix rtc command decoding from PRAM addresses 0x0 to 0xf
  mac_via: fix rtc command decoding for the PRAM seconds registers

 MAINTAINERS                 |   3 +
 hw/m68k/meson.build         |   2 +-
 hw/m68k/q800-glue.c         | 252 ++++++++++++++++++
 hw/m68k/q800.c              | 505 +++++++++++++-----------------------
 hw/misc/mac_via.c           |  13 +-
 hw/net/dp8393x.c            |  32 +--
 include/hw/m68k/q800-glue.h |  50 ++++
 include/hw/m68k/q800.h      |  62 +++++
 include/hw/net/dp8393x.h    |  60 +++++
 9 files changed, 619 insertions(+), 360 deletions(-)
 create mode 100644 hw/m68k/q800-glue.c
 create mode 100644 include/hw/m68k/q800-glue.h
 create mode 100644 include/hw/m68k/q800.h
 create mode 100644 include/hw/net/dp8393x.h

-- 
2.30.2


