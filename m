Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72859CDD601
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Dec 2025 07:30:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYeqs-00041D-GS; Thu, 25 Dec 2025 01:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1vYeqq-00040y-En
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 01:29:32 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1vYeqo-0001rv-6l
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 01:29:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 00A94178B37;
 Thu, 25 Dec 2025 09:28:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F13B340636;
 Thu, 25 Dec 2025 09:29:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 0/2] gdbstub: re-do unlinking of unix socket before bind
Date: Thu, 25 Dec 2025 09:29:17 +0300
Message-ID: <20251225062919.685146-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Prior discussion is at
https://lore.kernel.org/qemu-devel/ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru/

In short: when adding unlink() before bind() for unix socket
in gdbstub/user.c, a previous patch introduced dependency of
linux-user binaries on qemu-sockets.c, which is more problematic
for usually-static binaries.  The monitor_get_fd stub which were
also needed is another example why this might not be the right
approach.

This patchset reverts the previous commit (with fixes for current
code), and adds just a single unlink() to the original code which
handled unix sockets directly.

Michael Tokarev (2):
  Revert "gdbstub: Try unlinking the unix socket before binding"
  gdbstub: unlink the unix socket before bind()

 gdbstub/user.c    | 30 +++++++++++++++++++++++++++---
 stubs/meson.build |  2 --
 util/meson.build  |  2 --
 3 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.47.3


