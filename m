Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AFFA3F6BD
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 15:05:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbg-0000b7-Ia; Fri, 21 Feb 2025 09:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWt-0006Vj-HI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:03 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWr-00015K-V5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:03 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id F20D3205367A; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F20D3205367A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=3pzDnrprb6W1VYdl5vOoM64mVHrM28Az9FZTRNDrrEA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dvOHf9DCVZgN2lJ1OOmjDO2LgcLzxVM0v/D1cWCYc0nHpCSD/3Tr9bbs+9RZ4qoBI
 rdz4lbOWiLR9hmpf8ZkJdZ0Civu58rG8DmAbUjRKyjR29cfI7jV4/DTdut2QwJ4Lio
 TDFMvk3WfqxT2EeBznjNZz5uSJG0lxo9mLa8B/g4=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 14/19] target/i386/hvf: drop unused headers
Date: Fri, 21 Feb 2025 00:36:22 -0800
Message-Id: <1740126987-8483-15-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:11 -0500
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

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/x86_decode.c | 3 ---
 target/i386/hvf/x86_emu.c    | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 31285952ad..ffece4773b 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -20,10 +20,7 @@
 
 #include "panic.h"
 #include "x86_decode.h"
-#include "vmx.h"
 #include "x86_emu.h"
-#include "x86_mmu.h"
-#include "x86_descr.h"
 
 #define OPCODE_ESCAPE   0xf
 
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 304c1ef396..84f97ed386 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -40,11 +40,7 @@
 #include "x86_decode.h"
 #include "x86.h"
 #include "x86_emu.h"
-#include "x86_mmu.h"
 #include "x86_flags.h"
-#include "vmcs.h"
-#include "vmx.h"
-#include "hvf-i386.h"
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
-- 
2.39.5 (Apple Git-154)


