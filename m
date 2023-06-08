Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B987357CF
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:06:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEYg-0001QU-BA; Mon, 19 Jun 2023 09:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qB85z-00006m-Ki
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:10:37 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qB85y-0002dK-6f
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:10:35 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id C456911EEF0;
 Mon, 19 Jun 2023 06:10:32 +0000 (UTC)
From: ~foxes <foxes@git.sr.ht>
Date: Thu, 08 Jun 2023 17:06:37 +0800
Subject: [PATCH qemu] gdbstub: Fixed gdb_open() does not work issue while an
 extra 'x' is being added when converting '%s' to a pointer
Message-ID: <168715503265.6607.10546290838930135420-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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
X-Mailman-Approved-At: Mon, 19 Jun 2023 09:04:35 -0400
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
 gdbstub/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index 02e3a8f74c..4c6b5f728b 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -126,7 +126,7 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const cha=
r *fmt, ...)
             case 's':
                 i64 =3D va_arg(va, uint64_t);
                 i32 =3D va_arg(va, uint32_t);
-                p +=3D snprintf(p, p_end - p, "%" PRIx64 "/%x" PRIx32, i64, =
i32);
+                p +=3D snprintf(p, p_end - p, "%" PRIx64 "/%" PRIx32, i64, i=
32);
                 break;
             default:
             bad_format:
--=20
2.38.5

