Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD1736238
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 05:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBSDj-0003BT-AD; Mon, 19 Jun 2023 23:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qBSDh-0003BG-Ie
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 23:39:53 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qBSDf-0007ij-Hz
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 23:39:53 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id B1C0011EFBC;
 Tue, 20 Jun 2023 03:39:49 +0000 (UTC)
From: ~foxes <foxes@git.sr.ht>
Date: Thu, 08 Jun 2023 17:07:59 +0800
Subject: [PATCH qemu 1/2] semihosting: Added to support GDB_O_APPEND flag of
 host_open()
Message-ID: <168723238949.9156.9853906656288727865-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~foxes <foxes687@andestech.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Foxes Hung <foxes687@andestech.com>

Signed-off-by: Foxes Hung <foxes687@andestech.com>
---
 semihosting/syscalls.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index 68899ebb1c..1a5d39da01 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -281,6 +281,9 @@ static void host_open(CPUState *cs, gdb_syscall_complete_=
cb complete,
     if (gdb_flags & GDB_O_TRUNC) {
         host_flags |=3D O_TRUNC;
     }
+    if (gdb_flags & GDB_O_APPEND) {
+        host_flags |=3D O_APPEND;
+    }
     if (gdb_flags & GDB_O_EXCL) {
         host_flags |=3D O_EXCL;
     }
--=20
2.38.5


