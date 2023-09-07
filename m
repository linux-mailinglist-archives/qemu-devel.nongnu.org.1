Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 557947971BA
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDAJ-0004LP-7O; Thu, 07 Sep 2023 07:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qeDA5-0004HC-6s
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:27:02 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qeD9z-00063z-GB
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:27:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso807488f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1694086013; x=1694690813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLRBFV9EhtGpydKvDDv3lCKaLKWsHuB0nFrWrdJFf/M=;
 b=gjYIo4dmNxRsY33Los0VHGldmJM7RHfgkpvsbzayEaMApL+Jt+JHQSk7pCif2VqjJn
 ZNmyVMeb5pHP5pHA+mczqC+88zFRe855RmjwslsHyGnqVJSvGRbHGNhG2oMZ926gRjAv
 8JbQob0GtjpDHgk8u3KAF9ZELrY7god+/8JSlyR1yMbmhOL87k8p90w990N2FAS3wgrk
 04cOduLd0NaM/BzP5LDYWNTRvsj+wgVnFjmieC9kFu1B43Rt/7G4k46ncj+uxxA98N6Y
 N7dE1poXiiYY71lOvCaoGPTRYAMwfK/6uUu31xRqQv0tS99CIb37iMuUQ1Y6Y5LiNcZ/
 0Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694086013; x=1694690813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLRBFV9EhtGpydKvDDv3lCKaLKWsHuB0nFrWrdJFf/M=;
 b=Ph8tAmd/h7LYV2T6wHT3OjyAlYpGkbqrxFmPvMnG2X2E9WG0pcsRB7YLuXBZM4DLuX
 SkjEYehap6M7Dl0URTGHBTMxEpVQkrfC944zORO9Ap7D7JIyqS/c/AYYqdYO8nS8VuU2
 IyGi4JmvrgW0Kw4Qxpq1G8PD6B/jalcp1wGi5GgfDY1/M2yr+jlaqxfniwMXevqZWZ9v
 P3glmqmmyidjongnvErk8KNgO3ectU0V2SmbaxB1z9H8N1Njt+utQPS2uBeEZ9LPWOgN
 xtGYVX1SbWWgYxWWFBLVx4y7Rgky6KsMWT2gcx2CR8zV9A1IGE5ZBrqykhChCY61UFLJ
 1FOg==
X-Gm-Message-State: AOJu0YyI8TZxFl/Ae5onQMAtcxNENevjJPWo/dANqlzoO36+Qb7PQnkP
 D+RmM4J5Z5txN8W9j34+ySbVaNX82kUo8F2cO/k=
X-Google-Smtp-Source: AGHT+IEztf6EtQFwUzx1VOehChxj09HS/eRrmL5GSot+V2tkobbzRXz7kzDkbjv9flx3YedwIrUpjQ==
X-Received: by 2002:adf:f249:0:b0:317:690e:7b39 with SMTP id
 b9-20020adff249000000b00317690e7b39mr4641657wrp.12.1694086013364; 
 Thu, 07 Sep 2023 04:26:53 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:c2c3:52c5:8306:a161])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfe6c3000000b00317909f9985sm22998755wrm.113.2023.09.07.04.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 04:26:52 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 2/5] softmmu: pass the main loop status to gdb "Wxx" packet
Date: Thu,  7 Sep 2023 13:26:37 +0200
Message-Id: <20230907112640.292104-3-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907112640.292104-1-chigot@adacore.com>
References: <20230907112640.292104-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index ee27e26048..d4e2e59e45 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -794,9 +794,9 @@ void qemu_init_subsystems(void)
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


