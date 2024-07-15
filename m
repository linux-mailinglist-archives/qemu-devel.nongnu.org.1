Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7004930DBD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 07:54:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEe1-0001s3-IO; Mon, 15 Jul 2024 01:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTEdw-0001nZ-R8; Mon, 15 Jul 2024 01:53:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTEdu-00078g-QO; Mon, 15 Jul 2024 01:53:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A0BE7A3CE;
 Mon, 15 Jul 2024 08:52:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A4BFB108AB2;
 Mon, 15 Jul 2024 08:52:48 +0300 (MSK)
Received: (nullmailer pid 564521 invoked by uid 1000);
 Mon, 15 Jul 2024 05:52:48 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.13 00/19] Patch Round-up for stable 7.2.13,
 frozen on 2024-07-14
Date: Mon, 15 Jul 2024 08:52:45 +0300
Message-Id: <qemu-stable-7.2.13-20240715074912@cover.tls.msk.ru>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following patches are queued for QEMU stable v7.2.13:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2024-07-14 (frozen), and the release is planned for 2024-07-16:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 3973615e7fba Mark Cave-Ayland:
   target/i386: fix size of EBP writeback in gen_enter()
02* 2c3e4e2de699 Alexey Dobriyan:
   virtio-net: drop too short packets early
03* b1cf266c82cb Gerd Hoffmann:
   stdvga: fix screen blanking
04* 54b27921026d Ilya Leoshkevich:
   linux-user: Make TARGET_NR_setgroups affect only the current thread
05* 521d7fb3ebdf Richard Henderson:
   tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
06* e030d08c2fc0 Thomas Huth:
   gitlab-ci.d/buildtest: Merge the --without-default-* jobs
07* 0054dc8bde40 Marc-André Lureau:
   Update lcitool and fedora to 37
08* d639cf79783a Paolo Bonzini:
   ci, docker: update CentOS and OpenSUSE Python to non-EOL versions
09* 641b1efe01b2 Thomas Huth:
   tests: Update our CI to use CentOS Stream 9 instead of 8
10* 7c7d369b33f0 Alex Bennée:
   tests: don't run benchmarks for the tsan build
11* f51f90c65ed7 Thomas Huth:
   gitlab-ci: Disable the riscv64-debian-cross-container by default
12* 903916f0a017 Chuang Xu:
   i386/cpu: fixup number of addressable IDs for processor cores in the 
   physical package
13* 76bccf3cb9d9 Richard Henderson:
   target/arm: Fix VCMLA Dd, Dn, Dm[idx]
14* bd385a5298d7 Kevin Wolf:
   qcow2: Don't open data_file with BDRV_O_NO_IO
15* 2eb42a728d27 Kevin Wolf:
   iotests/244: Don't store data-file with protocol in image
16* 7e1110664ecb Kevin Wolf:
   iotests/270: Don't store data-file with json: prefix in image
17* 7ead94699861 Kevin Wolf:
   block: Parse filenames only when explicitly requested
18 7aa6492401e9 Stefano Garzarella:
   virtio: remove virtio_tswap16s() call in vring_packed_event_read()
19 a0124e333e21 Maxim Mikityanskiy:
   char-stdio: Restore blocking mode of stdout on exit

(commit(s) marked with * were in previous series and are not resent)

