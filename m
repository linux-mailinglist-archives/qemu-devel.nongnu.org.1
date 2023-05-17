Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B444706241
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC72-0003W2-Fb; Wed, 17 May 2023 04:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6l-0002n7-9L
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6e-0000s1-8y
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:03 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MILnm-1ptkZx2BbY-00ELUV; Wed, 17
 May 2023 10:01:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/9] Linux user for 8.1 patches
Date: Wed, 17 May 2023 10:01:43 +0200
Message-Id: <20230517080152.108660-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jmkCMFBCt6Ub3+8cqkvliPRYZQt0jiq1OrIwI+GCZVKQReTIz6D
 VqPlZa+35N9nQLYQI/NJfxS4ek7u8p9S49/UkpOyI4dCQtJH3/vxL/Ia6Mxzv73/O54kYtx
 0GjVTRF4ald2g2JqAvPttRpwXN+cywN/5He6bwmc39fadpNNtDzjJwA5S1JjSVqsZLxOfJ9
 PLUPJo/sDK29qjUF6V3uA==
UI-OutboundReport: notjunk:1;M01:P0:P4rb4pypseY=;+Qo5WK5cTXBHAUTz6m1HfIk73bB
 u/45zL95S3932ri8rjo/ywCndsbD+d6+SGyhoiivs5zd0YbhIaqZqkgVcICKdfOtzSwPZh+3j
 XFvqZ5GyCaoR6sBet4A5C1QSE6bOwspInv5sbiV/QlLrVM9spQ0RiQbuaWhInuzF2Y27rJKDF
 mRtXOXrEtEoQTHEs0/Wwrm+R4jQJv6ekqWfvWiiGNnxSjXg2752ONllvwITnrAdZe+YKvXboh
 qces69BwmymHqxfWHKLhp39c9ZWK+ux26lcsrljAWUB6Ba+K5U/SJhWvhU8RGLTZ8iDC6xIGy
 nFscLVFDlcpd6n3JadqoNr89F9U5TqNuu7t19R1oTl00VMIXYkNFtCKqFSCyvYnDIxHiBHfB9
 RypfwuqkmnH3RsB9Gv3L/IXsqBvD39ChBh++caiWqwoq4AMNrWmLiLjyjeltEkr0COM6ELtqG
 EE0p+00gPK6QT4xmYWqmdbd66sBU+sDqvo9O1cvaHUs+iRvRurtHpPcUJ67JtCm6T7Ld4lEh8
 sqXG4g/L2qezhF5IpyVO48Fa5PV+SetjuxUGwVVrLKWoGJ2aHotOvJmqUQVlhO+VBfMhhT+Vc
 DaRgxLW71VXHBPZ8UwfSdn1At2MVE2rH5WFBLtSIkbwkRiHAEUrh/da7hXxPuXy9vBp3a7avw
 wehcNySNfzzrREnFBM7ePCT2+ICAxOcH14ZqE+MBJg==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

The following changes since commit 7c18f2d663521f1b31b821a13358ce38075eaf7d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-04-29 23:07:17 +0100)

are available in the Git repository at:

  https://github.com/vivier/qemu.git tags/linux-user-for-8.1-pull-request

for you to fetch changes up to 1e35d327890bdd117a67f79c52e637fb12bb1bf4:

  linux-user: fix getgroups/setgroups allocations (2023-05-17 07:20:29 +0200)

----------------------------------------------------------------
linux-user pull request 20230512-v4

add open_tree(), move_mount()
add /proc/cpuinfo for riscv
fixes and cleanup

----------------------------------------------------------------

Afonso Bordado (1):
  linux-user: Emulate /proc/cpuinfo output for riscv

Daniil Kovalev (1):
  linux-user: Fix mips fp64 executables loading

Michael Tokarev (1):
  linux-user: fix getgroups/setgroups allocations

Thomas Huth (1):
  linux-user/main: Use list_cpus() instead of cpu_list()

Thomas Weißschuh (5):
  linux-user: report ENOTTY for unknown ioctls
  linux-user: Add move_mount() syscall
  linux-user: Add open_tree() syscall
  linux-user: Add new flag VERIFY_NONE
  linux-user: Don't require PROT_READ for mincore

 linux-user/main.c          |   5 +-
 linux-user/mips/cpu_loop.c |   5 +-
 linux-user/qemu.h          |   1 +
 linux-user/syscall.c       | 207 ++++++++++++++++++++++++++++++-------
 4 files changed, 176 insertions(+), 42 deletions(-)

-- 
2.40.1


