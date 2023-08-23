Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D59785127
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 09:08:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhy4-0006uR-1x; Wed, 23 Aug 2023 03:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qYhxw-0006l1-NJ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:07:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qYhxu-0004BH-6U
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:07:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fee769fcc3so34554465e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1692774460; x=1693379260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yyn+AiDtQ3Hy+Ma8ZvsngF4jC5rWKanopYp2FMK3k0Y=;
 b=STnq6cNw7gxT/JEGsvDJxFtZxL5rxe8odq5CFnI2B9AwyK9lT6XqThSxqVvlTar84s
 wacGLkZ1sjvQLwjfhGT67HOtkTfipH7fD9USG/TuE82uzkPTc+kfwcj8F+KR9RJhuMh5
 JdOxCUVkOKoItgiGAOsjvqbgnh9Aozkny7xJr4MdYY+FtRJD2y2M4O2gwle8MmaLSsfj
 Lmk4vxYsB5zsqfR5fzrxoRlfYAM6HufE/VSIzncoWl+fMxhoxVfIK70G9Y6Y2qk1zAAt
 CJ2rvzT95GjIz7A0GquYVWkLt4H+oR08bWU96xgGqT/oDPaPPBp3Lu66JN8XPBRb8L51
 +xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692774460; x=1693379260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yyn+AiDtQ3Hy+Ma8ZvsngF4jC5rWKanopYp2FMK3k0Y=;
 b=T4+WBbMXGJqMMWbBXqaQ5f6tDr4hQ/u64LetcThyO4Yr1zPC7n1pN/vAQbBRgE+z0q
 xtzWLCH6rHDyH1bC7hFCnwLpPgOpctteC0/ViafuljRk3W7+V82opfWHwxHmoA87ha3W
 E/9dJYwiJ360d9mugPL4Uxi9uHxWBGdjoc2a7z2RI/JLkwUZHhsS6O+klHPOaN5sCyqn
 6tVO+g0ABEOxzT3daSJ++BvdL//jgC6FzwAJUC0tEFfegQxQHyKeQunZT3rgeRsIxw3k
 y1jAhnYVTu/Ez/culsHorF5fnq2f07NXE9a0FvkBQ5eC0z6CQ+BbQH90k9oQpY6I0LFW
 vkMQ==
X-Gm-Message-State: AOJu0YyABPet+p8yx6CG+TFBmoRrPMFUiOM1cUyHy9L6BHWPLHStLP8K
 OCt5ClzZBj1SQr5qRuzkvJYquRSquEQ/jdWsARc=
X-Google-Smtp-Source: AGHT+IEodKnO8s5kjTfbhns2xVuRnYu8jqBl4hnnmLBIa//LVPsMBU6atS7OpUmXBbqczJYeV4wWRA==
X-Received: by 2002:a05:600c:b42:b0:3fe:d780:4f7a with SMTP id
 k2-20020a05600c0b4200b003fed7804f7amr9109813wmr.3.1692774459979; 
 Wed, 23 Aug 2023 00:07:39 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:d434:6b1d:751:97d0])
 by smtp.gmail.com with ESMTPSA id
 15-20020a05600c028f00b003fee8793911sm11887739wmk.44.2023.08.23.00.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 00:07:39 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 3/3] gdbstub: replace exit(0) with proper shutdown
Date: Wed, 23 Aug 2023 09:07:35 +0200
Message-Id: <20230823070735.363197-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This replaces the exit(0) call by a shutdown request, ensuring a proper
cleanup of Qemu. Otherwise, some connections could be broken without
being correctly flushed.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 gdbstub/gdbstub.c |  3 +--
 gdbstub/softmmu.c | 13 +++++++++++++
 gdbstub/user.c    |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 5f28d5cf57..358eed1935 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1298,7 +1298,6 @@ static void handle_v_kill(GArray *params, void *user_ctx)
     gdb_put_packet("OK");
     error_report("QEMU: Terminated via GDBstub");
     gdb_exit(0);
-    exit(0);
 }
 
 static const GdbCmdParseEntry gdb_v_commands_table[] = {
@@ -1818,7 +1817,7 @@ static int gdb_handle_packet(const char *line_buf)
         /* Kill the target */
         error_report("QEMU: Terminated via GDBstub");
         gdb_exit(0);
-        exit(0);
+        break;
     case 'D':
         {
             static const GdbCmdParseEntry detach_cmd_desc = {
diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index f509b7285d..fa9b09537d 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -434,6 +434,19 @@ void gdb_exit(int code)
     }
 
     qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
+
+    /*
+     * Shutdown request is a clean way to stop the QEMU, compared
+     * to a direct call to exit(). But we can't pass the exit code
+     * through it so avoid doing that when it can matter.
+     * As this function is also called during the cleanup process,
+     * avoid sending the request if one is already set.
+     */
+    if (code) {
+        exit(code);
+    } else if (!qemu_shutdown_requested_get()) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
 }
 
 /*
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 5b375be1d9..f3d97d621f 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -113,6 +113,8 @@ void gdb_exit(int code)
         gdb_put_packet(buf);
         gdbserver_state.allow_stop_reply = false;
     }
+
+    exit(code);
 }
 
 int gdb_handlesig(CPUState *cpu, int sig)
-- 
2.25.1


