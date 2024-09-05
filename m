Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDC96DD49
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Sep 2024 17:08:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smE5S-0006BV-PL; Thu, 05 Sep 2024 11:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mps@arvanta.net>) id 1smE5F-0006A4-8F
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:07:42 -0400
Received: from 93-87-244-166.static.isp.telekom.rs ([93.87.244.166]
 helo=fx.arvanta.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mps@arvanta.net>) id 1smE5C-00019B-3a
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:07:40 -0400
Received: from m1pro.arvanta.net (m1pro.arvanta.net [10.5.1.11])
 by fx.arvanta.net (Postfix) with ESMTP id B75494B3A;
 Thu, 05 Sep 2024 17:07:33 +0200 (CEST)
From: =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>
Subject: [PATCH v2 1/1] util/util/cpuinfo-riscv.c: fix riscv64 build on musl
 libc
Date: Thu,  5 Sep 2024 17:06:54 +0200
Message-ID: <20240905150702.2484-1-mps@arvanta.net>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=93.87.244.166; envelope-from=mps@arvanta.net;
 helo=fx.arvanta.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
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

build fails on musl libc (alpine linux) with this error:

../util/cpuinfo-riscv.c: In function 'cpuinfo_init':
../util/cpuinfo-riscv.c:63:21: error: '__NR_riscv_hwprobe' undeclared (first use in this function); did you mean 'riscv_hwprobe'?
   63 |         if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) == 0
      |                     ^~~~~~~~~~~~~~~~~~
      |                     riscv_hwprobe
../util/cpuinfo-riscv.c:63:21: note: each undeclared identifier is reported only once for each function it appears in
ninja: subcommand failed

add '#include "asm/unistd.h"' to util/cpuinfo-riscv.c fixes build

Signed-off-by: Milan P. Stanić <mps@arvanta.net>
---
 util/cpuinfo-riscv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 497ce12680..8cacc67645 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -9,6 +9,7 @@
 #ifdef CONFIG_ASM_HWPROBE_H
 #include <asm/hwprobe.h>
 #include <sys/syscall.h>
+#include <asm/unistd.h>
 #endif
 
 unsigned cpuinfo;
-- 
2.46.0


