Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5658F7B625E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:16:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZcD-0007Tn-Bu; Tue, 03 Oct 2023 03:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qnZcA-0007Ry-Si
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:14:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qnZc8-0001gY-Cx
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:14:41 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso96047966b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1696317278; x=1696922078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkiKnEYkM6j4qggxOGznItB/swiKFsiVyTm3GYtzm9w=;
 b=aiY7L+8NNUbyzpaJPdDGirdmZzkXKxuuumsWIf8dL38FmkpCuNG/o9dzaFBOcdrWRI
 B4dQw5bneMraXc/e44dUqarc4Qk/QLBPl9WOkHqPmznR9W0JJ8Vr6q+vMhGRSrJfLHtK
 vB/oV0ie3fYPIGy5sHjQa439W1sU799LXJWk5Yukzs+zZ6kQH4kN22YFLuWCVCPTDXyt
 f/Te2XxDByIRH0JOLfEvk7jwOhteIXLoad8pjbLGDq/MDOvu3BzAdWSXOZFW1xeO1L5h
 ct7s4U1/hVhboGbOD/ptEy4COxD42kIjmO6tZW7We8WGpITpynixFzbM/UUVOrIjnaNg
 Mbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696317278; x=1696922078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkiKnEYkM6j4qggxOGznItB/swiKFsiVyTm3GYtzm9w=;
 b=iuJLZsy7xTaQS3dq4OrzEGCmF2av7IxDZlbC07SUpvNWLd9XiSFqEH6kbzwdKhJ+xB
 aCqz8v/jVnsccDF6Gga97I9yNnTTCgvOzbZuf5/XsrpXAAzztgu5j59pMv91UhdiIYv6
 10D9vZcd/TJmRqXlSjaQgHgi014UsW6AC+/wTC1Gj/XhgEjb5fCyFoeKgTVNP5stcvx6
 WahN6Zdy77PkuCNFP4IxTUymV1KsceaM2hRvcXjYuGYDBbwXoBzTYhwAfobtjLH9hXGG
 CHYWeSjqJKPXZvpu3UC+JysyK2PG3+aB0PVatJWoCQEtCzpUtI8/KoCzQtYAgsldKCK7
 BeHQ==
X-Gm-Message-State: AOJu0YzTHAN0V2dupNwkuoKwTQqDOoVfqSXKUzx2WsJguCYfGyOXIYWz
 9IaR0QtZxvM2HdNWnIh3D9e0uRMWieIemyj0BA0=
X-Google-Smtp-Source: AGHT+IF+hrvXIcNN+MkDWKiHKBP7C2W6OroVn0mUkEsqfSaJVxL4vpsKb+FLy+6ws9Rwq5xm6OrRuA==
X-Received: by 2002:a17:906:eb82:b0:9ad:ef31:6ef6 with SMTP id
 mh2-20020a170906eb8200b009adef316ef6mr13726121ejb.20.1696317278510; 
 Tue, 03 Oct 2023 00:14:38 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a5d4710000000b003179d5aee67sm832196wrq.94.2023.10.03.00.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 00:14:38 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 2/5] softmmu: pass the main loop status to gdb "Wxx" packet
Date: Tue,  3 Oct 2023 09:14:24 +0200
Message-Id: <20231003071427.188697-3-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003071427.188697-1-chigot@adacore.com>
References: <20231003071427.188697-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x630.google.com
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

gdb_exit function aims to close gdb sessions and sends the exit code of
the current execution. It's being called by qemu_cleanup once the main
loop is over.
Until now, the exit code sent was always 0. Now that hardware can
shutdown this main loop with custom exit codes, these codes must be
transfered to gdb as well.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/sysemu/sysemu.h | 2 +-
 softmmu/main.c          | 2 +-
 softmmu/runstate.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 25be2a692e..73a37949c2 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -101,7 +101,7 @@ bool defaults_enabled(void);
 
 void qemu_init(int argc, char **argv);
 int qemu_main_loop(void);
-void qemu_cleanup(void);
+void qemu_cleanup(int);
 
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
diff --git a/softmmu/main.c b/softmmu/main.c
index 694388bd7f..9b91d21ea8 100644
--- a/softmmu/main.c
+++ b/softmmu/main.c
@@ -35,7 +35,7 @@ int qemu_default_main(void)
     int status;
 
     status = qemu_main_loop();
-    qemu_cleanup();
+    qemu_cleanup(status);
 
     return status;
 }
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 363a5ea8dd..ea9d6c2a32 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -834,9 +834,9 @@ void qemu_init_subsystems(void)
 }
 
 
-void qemu_cleanup(void)
+void qemu_cleanup(int status)
 {
-    gdb_exit(0);
+    gdb_exit(status);
 
     /*
      * cleaning up the migration object cancels any existing migration
-- 
2.25.1


