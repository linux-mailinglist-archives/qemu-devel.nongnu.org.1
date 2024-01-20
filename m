Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E635B833686
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 22:47:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRJ9z-0006sT-Dx; Sat, 20 Jan 2024 16:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rRJ9x-0006s7-P7
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 16:45:50 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rRJ9v-00089r-Jc
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 16:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1705787141; bh=dbh+bIjKa1C8kqFOnFCmAjsBglPryxzUjTBooCsU9zc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BdEn63ZLi8t/QSNAcWBoluRf/uwvULQwNvu0usC1Ag9zMnW2+ZXLcCdpCTA2br5HL
 in77vuUbDkWebtJwLYr67LXkTo8HLz28rdElrkrsbzxEXsl4cwKOhFblEBa4IlnZJH
 uRM96LcwgYx+SKW84QrN9qftyxOkk9B1e5E1a+w4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sat, 20 Jan 2024 22:45:25 +0100
Subject: [PATCH v3 2/2] linux-user/elfload: check PR_GET_DUMPABLE before
 creating coredump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240120-qemu-user-dumpable-v3-2-6aa410c933f1@t-8ch.de>
References: <20240120-qemu-user-dumpable-v3-0-6aa410c933f1@t-8ch.de>
In-Reply-To: <20240120-qemu-user-dumpable-v3-0-6aa410c933f1@t-8ch.de>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705787141; l=1100;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=dbh+bIjKa1C8kqFOnFCmAjsBglPryxzUjTBooCsU9zc=;
 b=aLfoaPrngn/sYo9CWNAgWa4woJiFVVM8K9S6WpDwjTJVCWqZJ/BQeXeXgZoCrvazNl+dsqUfK
 4MUeXI5FeQ9BDC7xcOenMfuaHhvmb26Jma01xeBN/06/FZ9+B7IToBZ
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A process can opt-out of coredump creation by calling
prctl(PR_SET_DUMPABLE, 0).
linux-user passes this call from the guest through to the
operating system.
From there it can be read back again to avoid creating coredumps from
qemu-user itself if the guest chose so.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 linux-user/elfload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c5968719380a..daf7ef843564 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2,6 +2,7 @@
 #include "qemu/osdep.h"
 #include <sys/param.h>
 
+#include <sys/prctl.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
 
@@ -4667,6 +4668,11 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     init_note_info(&info);
 
     errno = 0;
+
+    if (prctl(PR_GET_DUMPABLE) == 0) {
+        return 0;
+    }
+
     if (getrlimit(RLIMIT_CORE, &dumpsize) == 0 && dumpsize.rlim_cur == 0) {
         return 0;
     }

-- 
2.43.0


