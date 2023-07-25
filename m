Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 552CE761A76
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIOt-0004TY-Sx; Tue, 25 Jul 2023 09:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIOe-0003qE-K5; Tue, 25 Jul 2023 09:48:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIOc-0001ts-SR; Tue, 25 Jul 2023 09:48:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC6B61610A;
 Tue, 25 Jul 2023 16:45:38 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6562F194CB;
 Tue, 25 Jul 2023 16:45:36 +0300 (MSK)
Received: (nullmailer pid 3370879 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 00/31] Patch Round-up for stable 8.0.4,
 freeze on 2023-08-05
Date: Tue, 25 Jul 2023 16:45:17 +0300
Message-Id: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.0.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0

Patch freeze is 2023-08-05, and the release is planned for 2023-08-07:

  https://wiki.qemu.org/Planning/8.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 4271f4038372 Laurent Vivier:
   virtio-net: correctly report maximum tx_queue_size value
02 ca2a5e630dc1 Fiona Ebner:
   qemu_cleanup: begin drained section after vm_shutdown()
03 2ad2e113deb5 Nicholas Piggin:
   hw/ppc: Fix clock update drift
04 dca4c8384d68 Helge Deller:
   linux-user: Fix accept4(SOCK_NONBLOCK) syscall
05 8af87a3ec7e4 Avihai Horon:
   vfio: Fix null pointer dereference bug in vfio_bars_finalize()
06 110b1bac2ecd Ilya Leoshkevich:
   target/s390x: Fix EPSW CC reporting
07 fed9a4fe0ce0 Ilya Leoshkevich:
   target/s390x: Fix MDEB and MDEBR
08 92a57534619a Ilya Leoshkevich:
   target/s390x: Fix MVCRL with a large value in R0
09 6da311a60d58 Ilya Leoshkevich:
   target/s390x: Fix LRA overwriting the top 32 bits on DAT error
10 b0ef81062d24 Ilya Leoshkevich:
   target/s390x: Fix LRA when DAT is off
11 baf21eebc3e1 Marcin Nowakowski:
   target/mips: enable GINVx support for I6400 and I6500
12 230dfd9257e9 Olaf Hering:
   hw/ide/piix: properly initialize the BMIBA register
13 7a8d9f3a0e88 Pierrick Bouvier:
   linux-user/syscall: Implement execve without execveat
14 e18ed26ce785 Richard Henderson:
   tcg: Fix info_in_idx increment in layout_arg_by_ref
15 d713cf4d6c71 Philippe Mathieu-Daudé:
   linux-user/arm: Do not allocate a commpage at all for M-profile CPUs
16 d921fea338c1 Mauro Matteo Cascella:
   ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023-3255)
17 d28b3c90cfad Andreas Schwab:
   linux-user: Make sure initial brk(0) is page-aligned
18 ea3c76f1494d Klaus Jensen:
   hw/nvme: fix endianness issue for shadow doorbells
19 15ad98536ad9 Helge Deller:
   linux-user: Fix qemu brk() to not zero bytes on current page
20 dfe49864afb0 Helge Deller:
   linux-user: Prohibit brk() to to shrink below initial heap address
21 eac78a4b0b7d Helge Deller:
   linux-user: Fix signed math overflow in brk() syscall
22 03b67621445d Denis V. Lunev:
   qemu-nbd: pass structure into nbd_client_thread instead of plain char*
23 5c56dd27a2c9 Denis V. Lunev:
   qemu-nbd: fix regression with qemu-nbd --fork run over ssh
24 736a1588c104 Jordan Niethe:
   tcg/ppc: Fix race in goto_tb implementation
25 22d2e5351a18 Ilya Leoshkevich:
   tcg/{i386, s390x}: Add earlyclobber to the op_add2's first output
26 761b0aa9381e Ilya Leoshkevich:
   target/s390x: Make CKSM raise an exception if R2 is odd
27 4b6e4c0b8223 Ilya Leoshkevich:
   target/s390x: Fix CLM with M3=0
28 53684e344a27 Ilya Leoshkevich:
   target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range inputs
29 a2025557ed4d Ilya Leoshkevich:
   target/s390x: Fix ICM with M3=0
30 9c028c057adc Ilya Leoshkevich:
   target/s390x: Make MC raise specification exception when class >= 16
31 ff537b0370ab Ilya Leoshkevich:
   target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13

