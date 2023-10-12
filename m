Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 493827C6401
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn59-00080n-Ql; Thu, 12 Oct 2023 00:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn56-0007qW-Sz
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn55-0002q4-5D
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c735473d1aso4483275ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084029; x=1697688829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5qNubiA8onwCKWVttMekgYaY69rAP/cGoiwSwhJmMs=;
 b=Mj63SOYjinn7N8r+wFNYt3ZFKhMo4hFo3PyFPWAC/b3ialxVPrOgzSFiY+sL0OvamX
 XFkVxUVEh3ucHAf80QqFdFvzbB6RQaKQM9SYCsf33Jkr3VtkaOv4nHFhOVrWeSiA0zeR
 DRaoxU4Gkd6NOK++U+AvxyJXM5UYK0u1IrJ0Az+NgAG3AeFOmCl5bZoa81Tvo9u0/TGF
 5eszv8fr4VfE8PBiJljkxJw9HjVx3bzbf7uM7IMkw/764g4P1tPbPci5hu7DOTEbUxf6
 Rw+x4tNEo0OCjQE0Y20F582o5EWhXTWc9jXi9RMNAXa8QYFbKZ+oH22kQxIGVjSXU2jZ
 jJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084029; x=1697688829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5qNubiA8onwCKWVttMekgYaY69rAP/cGoiwSwhJmMs=;
 b=wy4eseOzgbm+pNN584xYAzcEa/23Vyqfx9/IY7Z9QYFf1OdXZ+GmdrocNqRnUfan2X
 yR8sSsYTmRhvlL3tMJvXlHJYprXEaDgFM48Jb++rR3S9zf7FS33ULiG3Lk4L7Iwkft/w
 pMJCUedxFsOnEE2bKihhokno2IqzMVTYqJk7OzVUAuM1OLUlciMRdp4N8Hw45280rhFs
 LWk0ESi9rjdQGtBx6R2tzlUBvrkwDPcxUqp5rBVFcF5qzlC1Ri3mXWfIvTvRdqgebkDD
 IeZOcxFXPPwNmMfjPQpjLAB+DSHBbLUv4wrOVFl66P6IOQ2tmJ/xA7Z3lKjYgAytc65h
 I5ug==
X-Gm-Message-State: AOJu0Yz+YIf33O/n9IyzuGdGqqyMBHgOtkTGiIGWYRYYVjlcTlj7dCIo
 prz+J4/1BY/KKuBSwHg5DmzNcrrq38xfCw==
X-Google-Smtp-Source: AGHT+IHM+PZCbHYwq1KcnzetWSnXqi0HHH3B+ggFhZ1SYBfZJGCXZ2xfPSbT+csD+J9wioD28rA9oQ==
X-Received: by 2002:a17:902:f115:b0:1c9:dd73:dc9e with SMTP id
 e21-20020a170902f11500b001c9dd73dc9emr831616plb.44.1697084029268; 
 Wed, 11 Oct 2023 21:13:49 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/54] gdbstub: replace exit calls with proper shutdown for
 softmmu
Date: Thu, 12 Oct 2023 14:10:45 +1000
Message-ID: <20231012041051.2572507-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Clément Chigot <chigot@adacore.com>

This replaces the exit calls by shutdown requests, ensuring a proper
cleanup of Qemu. Features like net/vhost-vdpa.c are expecting
qemu_cleanup to be called to remove their last residuals.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231003071427.188697-6-chigot@adacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/gdbstub/syscalls.h | 9 +++++++++
 gdbstub/gdbstub.c          | 5 +++--
 gdbstub/system.c           | 6 ++++++
 gdbstub/user.c             | 6 ++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index 243eaf8ce4..54ff7245a1 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -110,4 +110,13 @@ int use_gdb_syscalls(void);
  */
 void gdb_exit(int code);
 
+/**
+ * gdb_qemu_exit: ask qemu to exit
+ * @code: exit code reported
+ *
+ * This requests qemu to exit. This function is allowed to return as
+ * the exit request might be processed asynchronously by qemu backend.
+ */
+void gdb_qemu_exit(int code);
+
 #endif /* _SYSCALLS_H_ */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1532118d1..1e96a71c0c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1324,7 +1324,7 @@ static void handle_v_kill(GArray *params, void *user_ctx)
     gdb_put_packet("OK");
     error_report("QEMU: Terminated via GDBstub");
     gdb_exit(0);
-    exit(0);
+    gdb_qemu_exit(0);
 }
 
 static const GdbCmdParseEntry gdb_v_commands_table[] = {
@@ -1843,7 +1843,8 @@ static int gdb_handle_packet(const char *line_buf)
         /* Kill the target */
         error_report("QEMU: Terminated via GDBstub");
         gdb_exit(0);
-        exit(0);
+        gdb_qemu_exit(0);
+        break;
     case 'D':
         {
             static const GdbCmdParseEntry detach_cmd_desc = {
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 48976873d2..783ac140b9 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -435,6 +435,12 @@ void gdb_exit(int code)
     qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
 }
 
+void gdb_qemu_exit(int code)
+{
+    qemu_system_shutdown_request_with_code(SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
+                                           code);
+}
+
 /*
  * Memory access
  */
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 7ab6e5d975..dbe1d9b887 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -113,6 +113,12 @@ void gdb_exit(int code)
         gdb_put_packet(buf);
         gdbserver_state.allow_stop_reply = false;
     }
+
+}
+
+void gdb_qemu_exit(int code)
+{
+    exit(code);
 }
 
 int gdb_handlesig(CPUState *cpu, int sig)
-- 
2.41.0


