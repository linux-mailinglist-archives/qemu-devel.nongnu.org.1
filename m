Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C78CF968
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 08:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU2m-0002xK-J2; Mon, 27 May 2024 02:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2h-0002tL-DU; Mon, 27 May 2024 02:41:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2e-0007An-Kw; Mon, 27 May 2024 02:41:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 630C06A3EE;
 Mon, 27 May 2024 09:41:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AA42CD83E6;
 Mon, 27 May 2024 09:40:56 +0300 (MSK)
Received: (nullmailer pid 50256 invoked by uid 1000);
 Mon, 27 May 2024 06:40:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 00/19] Patch Round-up for stable 7.2.12,
 freeze on 2024-06-07
Date: Mon, 27 May 2024 09:40:31 +0300
Message-Id: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.12:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2024-06-07, and the release is planned for 2024-06-09:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 690ceb71936f Philippe Mathieu-Daudé:
   gitlab-ci: Remove job building EDK2 firmware binaries
02 7bc1286b81d4 Palmer Dabbelt:
   gitlab/opensbi: Move to docker:stable
03 04f6fb897a5a Michael Tokarev:
   linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
04 ae6d91a7e9b7 Zhu Yangyang:
   nbd/server: do not poll within a coroutine context
05 4fa333e08dd9 Eric Blake:
   nbd/server: Mark negotiation functions as coroutine_fn
06 06479dbf3d7d Li Zhijian:
   backends/cryptodev-builtin: Fix local_error leaks
07 dcc5c018c7e6 Peter Maydell:
   tests/avocado: update sunxi kernel from armbian to 6.6.16
08 a88a04906b96 Thomas Huth:
   .gitlab-ci.d/cirrus.yml: Shorten the runtime of the macOS and FreeBSD jobs
09 4b00855f0ee2 Alexandra Diupina:
   hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
10 eb656a60fd93 Philippe Mathieu-Daudé:
   hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
11 6a5a63f74ba5 Ruihan Li:
   target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK
12 e6578f1f68a0 Mattias Nissler:
   hw/remote/vfio-user: Fix config space access byte order
13 41c685dc59bb Paolo Bonzini:
   target/i386: fix operand size for DATA16 REX.W POPCNT
14 40a3ec7b5ffd Paolo Bonzini:
   target/i386: rdpkru/wrpkru are no-prefix instructions
15 37e91415018d hikalium:
   ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
16 e4e62514e3cc Dongwon Kim:
   ui/gtk: Check if fence_fd is equal to or greater than 0
17 84d4b7285486 donsheng:
   target-i386: hyper-v: Correct kvm_hv_handle_exit return value
18 8225bff7c5db Paolo Bonzini:
   target/i386: disable jmp_opt if EFLAGS.RF is 1
19 f0f0136abba6 Paolo Bonzini:
   target/i386: no single-step exception after MOV or POP SS

