Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A683270FFAF
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vlS-0001Bq-Hk; Wed, 24 May 2023 17:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlQ-0001Bi-RV
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlN-0001vP-UI
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/wf2LIiA96/UTok0wnH9i2X5KOWIWZoM7yuCpUX6JOg=; b=KkdCm5HgRBILUKqElWY4ugplHu
 gzvxuHorGf7rLQObdrMPJJO7X5QMfkrPsOvK5r6+jV0tlqoW0eyyBU78USrpaGq7l/yTIiddaMG7J
 9sUdjNGxYQFFMnkGcNodWbMpTrFCkq5Fn+7D06Wg+415JSyl/7pOd5cu15/2YxLcJBsxjrkPWrI2m
 zL500Mm7iQSJ9hm4QxpJxQSFFSipGgVtpBrzX5OicPuzUslQieINkBFx6od74u25w6ZeQ+rGq1vfa
 R3GOtfY9YicLr1I8Iox0rY9U+nE0wFjeY/t6+tb7OvUI96sVG2mKrWQaPGsytLTPgg8wa/NjjmOLs
 j1PW/LcNzGwGBeOdiMKghm6uTKmjxMHXDu1t7SACxbVXQsgVogo3/yfbOYVpDxxZIu5dGwLWso9ig
 +c35Em/Lm3krKqFDc/9PHOH9h0kW+ct9erUKF4cT6CrAnj/oxq0Kl37bao4fndDUyOlJXsohLIAIs
 ZmAFHyJNuFt5P1RZQr+YZEcw7bFPcGr0eM0VsXS1502jqlCL068n3Z7IidieF40uWyO5hDvLC3/Xm
 wo/U1CWgE2AmXLZN8O2+5sWbQG9+n2N8jG8Fq1RWTR8J+X+bWeaZhWDn2Ji9V2iTg/bFACVeMmOCb
 f5PoM4+hV5IMZ3++SXUOZEqTO3BG+t7jptA9nHelg=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlC-0005XR-NB; Wed, 24 May 2023 22:11:10 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:34 +0100
Message-Id: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 00/30] q800: add support for booting MacOS Classic
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


Mark Cave-Ayland (30):
  q800: fix up minor spacing issues in hw_compat_q800 GlobalProperty
    array
  q800: introduce Q800MachineState
  q800: rename q800_init() to q800_machine_init()
  q800: move CPU object into Q800MachineState
  q800: move ROM memory region to Q800MachineState
  q800: move GLUE device to Q800MachineState
  q800: introduce mac-io container memory region
  q800: reimplement mac-io region aliasing using IO memory region
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
  mac_via: fix rtc command decoding from PRAM addresses 0x0 to 0xf
  mac_via: fix rtc command decoding for the PRAM seconds registers
  mac_via: workaround NetBSD ADB bus enumeration issue
  mac_via: implement ADB_STATE_IDLE state if shift register in input
    mode
  mac_via: always clear ADB interrupt when switching to A/UX mode
  q800: add ESCC alias at 0xc000
  q800: add alias for MacOS toolbox ROM at 0x40000000
  mac_via: extend timer calibration hack to work with A/UX
  mac_via: work around QEMU unaligned MMIO access bug

 MAINTAINERS               |   7 +
 hw/audio/Kconfig          |   3 +
 hw/audio/asc.c            | 691 ++++++++++++++++++++++++++++++++++++++
 hw/audio/meson.build      |   1 +
 hw/audio/trace-events     |  10 +
 hw/block/swim.c           | 261 +++++++++-----
 hw/block/trace-events     |   8 +
 hw/m68k/Kconfig           |   3 +
 hw/m68k/q800.c            | 312 ++++++++++++++---
 hw/misc/Kconfig           |   6 +
 hw/misc/djmemc.c          | 154 +++++++++
 hw/misc/iosb.c            | 156 +++++++++
 hw/misc/mac_via.c         | 288 +++++++++++++++-
 hw/misc/meson.build       |   2 +
 hw/misc/trace-events      |  11 +
 include/hw/audio/asc.h    |  75 +++++
 include/hw/block/swim.h   |  21 +-
 include/hw/m68k/q800.h    |  50 +++
 include/hw/misc/djmemc.h  |  46 +++
 include/hw/misc/iosb.h    |  41 +++
 include/hw/misc/mac_via.h |   7 +-
 21 files changed, 1993 insertions(+), 160 deletions(-)
 create mode 100644 hw/audio/asc.c
 create mode 100644 hw/misc/djmemc.c
 create mode 100644 hw/misc/iosb.c
 create mode 100644 include/hw/audio/asc.h
 create mode 100644 include/hw/m68k/q800.h
 create mode 100644 include/hw/misc/djmemc.h
 create mode 100644 include/hw/misc/iosb.h

-- 
2.30.2


