Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656F704E10
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6K-0004MA-Ak; Tue, 16 May 2023 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6G-0004Jm-Gj
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu69-00061s-Vj
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mm9NA-1qPPA33jKi-00i9dY; Tue, 16
 May 2023 14:48:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/9] Linux user for 8.1 patches
Date: Tue, 16 May 2023 14:48:01 +0200
Message-Id: <20230516124810.90494-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JjjP0mGBjGmx13ZWCcLD4onP/eDmyhu1pzaVRQvgLYdZu7Ketv2
 gxHDQVTMJhd8Tco/FeEQmUlEXPDamtquRWM5W+MkGExrg9KcoavX5gwmH2m+50u54KEiK3d
 p0dzBCjQSxW5Vw47EJNn2kz8uTWEXY25nqfcKQVv7NU/AxzV6+xP9xr3BoWqwBj8uqFdzQw
 wC70HvgHwX0lDnAS4cc4A==
UI-OutboundReport: notjunk:1;M01:P0:JESgLJpBdlM=;xZGvayY9fSlOZd6gNdw3O4pwInR
 IVNaR6uHBuO+WzyHzsCA302NPELFVGpFlcLOqHoMnoIk7bLahr6yzQYugj1Xip9Ox6YIumVYW
 +UUgLJa5Ot0B17xk/P59hgCsEwwUy0ixRWKAcP/oCpAK+s93r6RgrSJe3AtODqi23qt5sv2WB
 A4D8AigOIjsiSfegnQctBnc0OjZyfg80HSH4/oHVIi10Pk1UYdjG7UASwEdTb/P2qzkQsI+UW
 FEA/kRMva5/vrZWgnQ6MLHvWZWtD5tCzw03TqWFK+Ypt+Bm02Fap22wul2fhVcEMOxpKZqy9H
 lZw4NoTut6y2JsOqDXKp3WkfU/IVIXK+IsuPRwHpgj1xTL2ttrOLvdv+I7BiNrsegn/tu8rTO
 5Eey8EJmKGBke99zI9He6PDdLLQheSC6alGcnhbls6S4XNnrvfHGGhVWgHK3L9LRiIijOsEsz
 kTIHOnq+QUS/YF/AOoa1Ve5ihVHEfRkRBYy49GOhUathUjTKhO7kyis5lG33Fi0yRhgk7iIho
 iUyShe/QAStewr+KxYciRjeHrCBB0+fjlgjci1KJo5ruWeBlmXT/llvHd9hXUXbjoL5oyJXJ/
 vELPjrTlR91/3g82egtlQ+GoNxGog1Lq2NDImTjzIdJGATpHS++6qb7PhIpUEsvoR/7T6q8fa
 P4kOHX1Dn5zU54QFxMMQQQGX8riaKe72ZPqSwizeVw==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

The following changes since commit 7c18f2d663521f1b31b821a13358ce38075eaf7d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-04-29 23:07:17 +0100)

are available in the Git repository at:

  https://github.com/vivier/qemu.git tags/linux-user-for-8.1-pull-request

for you to fetch changes up to c490496e85047d516b31f93ea0e14819e0ab5cf5:

  linux-user: fix getgroups/setgroups allocations (2023-05-16 12:48:09 +0200)

----------------------------------------------------------------
linux-user pull request 20230512-v3

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

 linux-user/main.c                 |   5 +-
 linux-user/mips/cpu_loop.c        |   5 +-
 linux-user/qemu.h                 |   1 +
 linux-user/syscall.c              | 207 ++++++++++++++++++++++++------
 tests/tcg/riscv64/Makefile.target |   1 +
 tests/tcg/riscv64/cpuinfo.c       |  31 +++++
 6 files changed, 208 insertions(+), 42 deletions(-)
 create mode 100644 tests/tcg/riscv64/cpuinfo.c

-- 
2.40.1


