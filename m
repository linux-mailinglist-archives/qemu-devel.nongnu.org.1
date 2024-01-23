Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BAE83899E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:51:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSCSW-0001Kz-N1; Tue, 23 Jan 2024 03:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCST-0001Je-IB; Tue, 23 Jan 2024 03:48:37 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSQ-0004tD-Es; Tue, 23 Jan 2024 03:48:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6471E4666D;
 Tue, 23 Jan 2024 11:49:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 25B3F699EB;
 Tue, 23 Jan 2024 11:48:31 +0300 (MSK)
Received: (nullmailer pid 3828097 invoked by uid 1000);
 Tue, 23 Jan 2024 08:48:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 00/20] Patch Round-up for stable 7.2.9,
 freeze on 2024-01-27
Date: Tue, 23 Jan 2024 11:48:18 +0300
Message-Id: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The following patches are queued for QEMU stable v7.2.9:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2024-01-27, and the release is planned for 2024-01-29:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* d3007d348ada Kevin Wolf:
   block: Fix crash when loading snapshot on inactive node
02* 5a7f21efaf99 Kevin Wolf:
   vl: Improve error message for conflicting -incoming and -loadvm
03* bb6e2511eb48 Kevin Wolf:
   iotests: Basic tests for internal snapshots
04* 5cb0e7abe163 Xu Lu:
   target/riscv: Fix mcycle/minstret increment behavior
05* 4ad87cd4b225 Michael Tokarev:
   chardev/char.c: fix "abstract device type" error message
06* 82a65e3188ab Peter Maydell:
   hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
07* e358a25a97c7 Ilya Leoshkevich:
   target/s390x: Fix LAE setting a wrong access register
08* 52a21689cd82 Peter Maydell:
   .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large
09 410c2a4d75f5 Anastasia Belova:
   load_elf: fix iterator's type for elf file processing
10 b5e0d5d22fbf Richard Henderson:
   target/i386: Fix 32-bit wrapping of pc/eip computation
11 a58506b748b8 Richard Henderson:
   target/i386: Do not re-compute new pc with CF_PCREL
12 2926eab89699 guoguangyao:
   target/i386: fix incorrect EIP in PC-relative translation blocks
13 729ba8e933f8 Paolo Bonzini:
   target/i386: pcrel: store low bits of physical address in data[0]
14 3b14a555fdb6 Gerd Hoffmann:
   hw/pflash: refactor pflash_data_write()
15 5dd58358a570 Gerd Hoffmann:
   hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
16 284a7ee2e290 Gerd Hoffmann:
   hw/pflash: implement update buffer for block writes
17 84a6835e004c Mark Cave-Ayland:
   hw/scsi/esp-pci: use correct address register for PCI DMA transfers
18 6b41417d934b Mark Cave-Ayland:
   hw/scsi/esp-pci: generate PCI interrupt from separate ESP and PCI sources
19 1e8e6644e063 Mark Cave-Ayland:
   hw/scsi/esp-pci: synchronise setting of DMA_STAT_DONE with ESP completion interrupt
20 c2d7de557d19 Mark Cave-Ayland:
   hw/scsi/esp-pci: set DMA_STAT_BCMBLT when BLAST command issued

(commit(s) marked with * were in previous series and are not resent)

