Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8127EC8B3
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Itx-0006UI-Ts; Wed, 15 Nov 2023 11:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r3Itr-0006Th-RY
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:37:59 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r3Itj-0000ra-LT
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1700066266; bh=CL1tBmJdfg1o8X6S56EaYxtC620ylQ9H8523erZVxT8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OoerHE6/lAcRbS2hsnyyBQe1airLoKE3PqHY+f+i1lKeQPOBgRSuZ7Lv8ZjaSvyoj
 TGiG2b5wGN6lG4IvBTwrLyOfiSkpZm0XtDZi0NuWjWK7jBI0GfK4v8LF4UZg2bC/ig
 Oqt3QcGRpYTHft2zDs9oIT+5Q+cCkiP6D63iLh1Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Wed, 15 Nov 2023 17:37:39 +0100
Subject: [PATCH 1/2] linux-user/elfload: test return value of getrlimit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231115-qemu-user-dumpable-v1-1-edbe7f0fbb02@t-8ch.de>
References: <20231115-qemu-user-dumpable-v1-0-edbe7f0fbb02@t-8ch.de>
In-Reply-To: <20231115-qemu-user-dumpable-v1-0-edbe7f0fbb02@t-8ch.de>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700066266; l=813;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=CL1tBmJdfg1o8X6S56EaYxtC620ylQ9H8523erZVxT8=;
 b=0HrJ/EWHOum6ZLS6xk8GM17P8lDyCv2RJTEaubLBoCg7KWQxj2KrOvvWj7ltb7VUfzxcM/hmq
 7VBI2cwz/37AJgbVu+d3rQU3IW7RmihfN+TNJgaSgHe+xs0Y7vYXWTQ
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

Should getrlimit() fail the value of dumpsize.rlimit_cur may not be
initialized. Avoid reading garbage data by checking the return value of
getrlimit.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 linux-user/elfload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4cd6891d7b6a..799fe8497346 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4667,8 +4667,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     init_note_info(&info);
 
     errno = 0;
-    getrlimit(RLIMIT_CORE, &dumpsize);
-    if (dumpsize.rlim_cur == 0)
+    if (getrlimit(RLIMIT_CORE, &dumpsize) == 0 && dumpsize.rlim_cur == 0)
         return 0;
 
     corefile = core_dump_filename(ts);

-- 
2.42.1


