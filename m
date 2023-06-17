Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD90733E6C
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Jun 2023 07:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAOdd-0005iE-Al; Sat, 17 Jun 2023 01:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qAOdT-0005cZ-CV
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 01:38:07 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qAOdR-0006f2-3X
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 01:38:06 -0400
X-QQ-mid: bizesmtp73t1686980183t54rkenr
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 17 Jun 2023 13:36:21 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: 0W2nZEwGN1CV64YHgFPWbG3s7NwuuM0G4I2ZM4DctYJcmoHOcWPBoGih3UVLa
 3pThDvf8pIMRIDiJm9I4Ke0Prv8/n1iNzW+5w7walOKNjoWtSsVsqImh/x1MN9D57NmyraS
 ndvAfmL1LGRX6PXo3Ns96gqhhQ5k/eEZTgoIwdm2pMpDOKXrwyto6CzO1+A2KgDAUiisAB3
 +VGTOUyUhBgogoRwCM6B0BjkyeCEQ20Y+KJ8yF/FX10tDjoXyP5jSHazfEyou8Dsp4rhH+U
 bSWpa8f1C+CnHw+jj12fFbjCavYmUyIX4+Jy1wD06zAZy+bUKzn0+dtVfoc78KRfKCat0t0
 e9ZeD+VzslwF2w0SX81R8ZDF26fXw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16182085494301429671
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>, Alberto Faria <afaria@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Nikita Ivanov <nivanov@cloudlinux.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Xuzhou Cheng <xuzhou.cheng@windriver.com>
Subject: [PATCH v3 0/6] net/tap: Fix QEMU frozen issue when the maximum number
 of file descriptors is very large
Date: Sat, 17 Jun 2023 13:36:15 +0800
Message-Id: <20230617053621.50359-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.154.221.58; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


Current codes using a brute-force traversal of all file descriptors
do not scale on a system where the maximum number of file descriptors
is set to a very large value (e.g.: in a Docker container of Manjaro
distribution it is set to 1073741816). QEMU just looks frozen during
start-up.

The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
doesn't need to manually close the fds for child process as the proper
O_CLOEXEC flag should have been set properly on files with its own
codes, QEMU uses a huge number of 3rd party libraries and we don't
trust them to reliably be using O_CLOEXEC on everything they open.

Modern Linux and BSDs have the close_range() call we can use to do the
job, and on Linux we have one more way to walk through /proc/self/fd
to complete the task efficiently, which is what qemu_close_range()
does, a new API we add in util/osdep.c.

V1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bmeng@tinylab.org/

Changes in v3:
- fix win32 build failure
- limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)

Changes in v2:
- new patch: "tests/tcg/cris: Fix the coding style"
- new patch: "tests/tcg/cris: Correct the off-by-one error"
- new patch: "util/async-teardown: Fall back to close fds one by one"
- new patch: "util/osdep: Introduce qemu_close_range()"
- new patch: "util/async-teardown: Use qemu_close_range() to close fds"
- Change to use qemu_close_range() to close fds for child process efficiently
- v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bmeng@tinylab.org/

Bin Meng (4):
  tests/tcg/cris: Fix the coding style
  tests/tcg/cris: Correct the off-by-one error
  util/async-teardown: Fall back to close fds one by one
  util/osdep: Introduce qemu_close_range()

Zhangjin Wu (2):
  util/async-teardown: Use qemu_close_range() to close fds
  net: tap: Use qemu_close_range() to close fds

 include/qemu/osdep.h                |  1 +
 net/tap.c                           | 23 ++++++------
 tests/tcg/cris/libc/check_openpf5.c | 57 ++++++++++++++---------------
 util/async-teardown.c               | 38 +------------------
 util/osdep.c                        | 48 ++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 78 deletions(-)

-- 
2.34.1


