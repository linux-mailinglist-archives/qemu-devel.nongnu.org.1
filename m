Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3CE7B3948
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 20:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmHmE-0002kJ-2b; Fri, 29 Sep 2023 13:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmB-0002k0-5M
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 13:59:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHm3-0005LK-4o
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 13:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9WEmyFht6FXDlx/+NUDTAjvtGL19Taqjiq3SSaSnXY4=; b=R41yJ09eVVerxCU+avJ2ByT0S5
 c2htpd9epipXm5MayRjZ3GbxAsBJzwpG80l2biDK7JPKDLpWivxAvRx2Rmdd5N5/C+tYkxvLjA1tm
 cHbCGNd1ZsOAdtZ3TZKG/J357In5mXoXXujGexz5ZBzvDVyxyxOFa4PYNcwTUfU95oZ64lOKrqd10
 6aEE8afsQPjTat+gfZfgr37mZacaSETfvcSQiTnyKkicTYudM9lLghaEfNQiHqp3CSC47Y45FBWVt
 6pHFhJETSBB9TASALfa718xxEXBLBcqgbqKso8ScgsBblHW0lrqlvOg6wO6JZ/Xh4m9Oqm1/KDLIJ
 a4oPQKTZLYTnizBqtPKoDAN4extwtjlVshE1ZfCJLlv1V45imL/AdL0A2dhINRVUmqAI4eS2Vb91+
 s7rcaHBDQ06x8nfmZabKfQvmAK/xNcSz8nTb/qXgphby9fi/xEjYO8nBoi3ef1nxFj/JVS/wAVimP
 ttU6SH7x+PSpmfrzODROq0tyKaSuCYhhJHwtVxVLcdYvU33O7zei2ziMAzwwv1eXeSdgWU36UUQTS
 bK7wtX+WNH6Ko/khEirGxmE1CswsepVvAe6COnrwm+B+vHCu/TbS2h8Z0X6OY4DTf853u/jQzAtzb
 FAubxT1RMuRd155rC4Nx9hVdimD7MBbz9XDTjRELI=;
Received: from [2a00:23c4:8baf:5f00:c237:5189:8121:f752]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHlo-00033Y-1i; Fri, 29 Sep 2023 18:59:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Fri, 29 Sep 2023 18:58:57 +0100
Message-Id: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:c237:5189:8121:f752
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 00/20] q800: add support for booting MacOS Classic - part 2
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


v3:
- Rebase onto master
- Add R-B tags from Laurent
- Squash fixes from Volker into patch 7 ("audio: add Apple Sound Chip (ASC) emulation")
- Change iwmregs from uint16_t to uint8_t in patch 12 ("swim: split into separate IWM
  and ISM register blocks")

v2:
- Rebase onto master
- Add R-B tags from Phil and Laurent
- Improve ASC logic for generating interrupts when FIFO underflow occurs
- Rework ASC silence generation logic similar to Volker's original proposal
- Update A/UX timer calibration hack to reflect the change of accesses now that
  #360 is resolved

Mark Cave-Ayland (20):
  q800-glue.c: convert to Resettable interface
  q800: add djMEMC memory controller
  q800: add machine id register
  q800: implement additional machine id bits on VIA1 port A
  q800: add IOSB subsystem
  q800: allow accesses to RAM area even if less memory is available
  audio: add Apple Sound Chip (ASC) emulation
  asc: generate silence if FIFO empty but engine still running
  q800: add Apple Sound Chip (ASC) audio to machine
  q800: add easc bool machine class property to switch between ASC and
    EASC
  swim: add trace events for IWM and ISM registers
  swim: split into separate IWM and ISM register blocks
  swim: update IWM/ISM register block decoding
  mac_via: work around underflow in TimeDBRA timing loop in SETUPTIMEK
  mac_via: workaround NetBSD ADB bus enumeration issue
  mac_via: implement ADB_STATE_IDLE state if shift register in input
    mode
  mac_via: always clear ADB interrupt when switching to A/UX mode
  q800: add ESCC alias at 0xc000
  q800: add alias for MacOS toolbox ROM at 0x40000000
  mac_via: extend timer calibration hack to work with A/UX

 MAINTAINERS                 |   6 +
 hw/audio/Kconfig            |   3 +
 hw/audio/asc.c              | 725 ++++++++++++++++++++++++++++++++++++
 hw/audio/meson.build        |   1 +
 hw/audio/trace-events       |  10 +
 hw/block/swim.c             | 261 ++++++++-----
 hw/block/trace-events       |   8 +
 hw/m68k/Kconfig             |   3 +
 hw/m68k/q800-glue.c         |  18 +-
 hw/m68k/q800.c              | 134 ++++++-
 hw/misc/Kconfig             |   6 +
 hw/misc/djmemc.c            | 135 +++++++
 hw/misc/iosb.c              | 133 +++++++
 hw/misc/mac_via.c           | 234 +++++++++++-
 hw/misc/meson.build         |   2 +
 hw/misc/trace-events        |  10 +
 include/hw/audio/asc.h      |  86 +++++
 include/hw/block/swim.h     |  21 +-
 include/hw/m68k/q800-glue.h |   4 +-
 include/hw/m68k/q800.h      |  11 +
 include/hw/misc/djmemc.h    |  30 ++
 include/hw/misc/iosb.h      |  25 ++
 include/hw/misc/mac_via.h   |   3 +
 23 files changed, 1763 insertions(+), 106 deletions(-)
 create mode 100644 hw/audio/asc.c
 create mode 100644 hw/misc/djmemc.c
 create mode 100644 hw/misc/iosb.c
 create mode 100644 include/hw/audio/asc.h
 create mode 100644 include/hw/misc/djmemc.h
 create mode 100644 include/hw/misc/iosb.h

-- 
2.39.2


