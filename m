Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A67EC8B4
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ity-0006UN-4r; Wed, 15 Nov 2023 11:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r3Its-0006Tq-D5
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:38:00 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r3Itm-0000rb-Vq
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1700066266; bh=qxXamQTO5EoE2my1lcK0XNmqaLU9AUm9JbNb0ypAEuY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=H+nCyvZWXC8DfAICmjWTxZgJ0eIhabUNWs3LBEFi2yk0VOv/n07Db9glL9SjBEegH
 nWZrFL3XQyPYB7+n+r5NXml/gI4QKrgt7tPULmqZa8McUuG2RtinXkDtUNKwY07KQW
 1sGgxe3YX6FVSVB5XXsZ4sJftx53y3s11TO0cdA0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Wed, 15 Nov 2023 17:37:40 +0100
Subject: [PATCH 2/2] linux-user/elfload: check PR_GET_DUMPABLE before
 creating coredump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231115-qemu-user-dumpable-v1-2-edbe7f0fbb02@t-8ch.de>
References: <20231115-qemu-user-dumpable-v1-0-edbe7f0fbb02@t-8ch.de>
In-Reply-To: <20231115-qemu-user-dumpable-v1-0-edbe7f0fbb02@t-8ch.de>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700066266; l=1019;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=qxXamQTO5EoE2my1lcK0XNmqaLU9AUm9JbNb0ypAEuY=;
 b=DF52vlE2rNj9bhBR1JyAnsc85yatvg5Ys2ohKEFJ74EYMNKDMqmcI5FfbXqeaYsY90tJkszPz
 I2UYlRTKo/aBg/EtrSrmZ3bN8HOGMt/NLKZfw5TrukCkP6UZH6YC43i
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

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 linux-user/elfload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 799fe8497346..76d5740af0ca 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2,6 +2,7 @@
 #include "qemu/osdep.h"
 #include <sys/param.h>
 
+#include <sys/prctl.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
 
@@ -4667,6 +4668,10 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     init_note_info(&info);
 
     errno = 0;
+
+    if (prctl(PR_GET_DUMPABLE) == 0)
+        return 0;
+
     if (getrlimit(RLIMIT_CORE, &dumpsize) == 0 && dumpsize.rlim_cur == 0)
         return 0;
 

-- 
2.42.1


