Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6387334CD
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:30:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABOB-00079l-GP; Fri, 16 Jun 2023 11:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qABO5-0006eK-0I
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:29:21 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qABO3-0000x4-2R
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:29:20 -0400
X-QQ-mid: bizesmtp84t1686929260tuaizq5u
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 16 Jun 2023 23:27:37 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: 3M0okmaRx3hOczSSgobv3atsboJvVmW0y1/dlpyRhGnE3hhqNL1E0n/rfO7fY
 0jDD9C+mlJum3zX54r8o9aSzYd0NG4IoWWegIa8+YzbYS8JjjSrwdWksXuxdBpTTkHt4jgT
 WV6Kr070NVBcD194qTIqWltZ+tXKyD3ZizUXIc4KMWGp0OnmrZQ2wwORwrnW4yBebycBJ1t
 qgZ4mqCFvD0x/j+fvYfmyBfrbgmBY+uU7gmy3MJ322SufiULoojs3QFLED/KBRwOflLKK2I
 gKE1CBkhswNFSDE6n6lP+8K+tHm69lh0UugEvQN+aJfJAaaEn4PexSc0dCJirsNzy2NCukb
 B/2A6kf2Za1IHMHlmIA+8+GmkwkULfQeUbzHRRn
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5602026970593767646
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Nikita Ivanov <nivanov@cloudlinux.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Xuzhou Cheng <xuzhou.cheng@windriver.com>
Subject: [PATCH v2 0/6] net/tap: Fix QEMU frozen issue when the maximum number
 of file descriptors is very large
Date: Fri, 16 Jun 2023 23:27:31 +0800
Message-Id: <20230616152737.23545-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.155.67.158; envelope-from=bmeng@tinylab.org;
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
does, a new API we add in utils/osdep.c.

Changes in v2:
- Change to use qemu_close_range() to close fds for child process efficiently
- v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bmeng@tinylab.org/

Bin Meng (4):
  tests/tcg/cris: Fix the coding style
  tests/tcg/cris: Correct the off-by-one error
  util/async-teardown: Fall back to close fds one by one
  utils/osdep: Introduce qemu_close_range()

Zhangjin Wu (2):
  util/async-teardown: Use qemu_close_range() to close fds
  net: tap: Use qemu_close_range() to close fds

 include/qemu/osdep.h                |  1 +
 net/tap.c                           | 23 ++++++------
 tests/tcg/cris/libc/check_openpf5.c | 57 ++++++++++++++---------------
 util/async-teardown.c               | 37 +------------------
 util/osdep.c                        | 47 ++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 78 deletions(-)

-- 
2.34.1



