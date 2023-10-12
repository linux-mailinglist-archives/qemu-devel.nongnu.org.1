Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D07C6405
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn55-0007gQ-SR; Thu, 12 Oct 2023 00:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4w-0007Bv-0h
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:43 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4u-0002nM-0Y
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:41 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-578b4981526so416719a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084017; x=1697688817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJca2D3xLzWN20qSAvD8QUUb8osMMM5a5yjhh4er46Q=;
 b=Eq9hLxKnMTnhF7sIj6P7PsiM+zInVghRRmj2oDCv7ygIhDfrvrQMTrWHrDf3Ui7HQU
 HogUtSzu58VmEL9rLMn8oOWnx9KCyNdOzYYRYAIyClZgGI+Lym9Ujt96gSsvAT4XBD4f
 InQlpIl3B94KkP+dwPSSYSukGmRx9Ilz1O4cQ7ldF7wLx9Jvsqt0Z+sYZjEzF9wAdSak
 nZWHHz/LthmBfy54n3SifY/eZ+jAo2yv2jsP+aJAhuM0WTZ8veCaDZzrQW0BULEd1HNr
 OvfwutchKsQo6cUwFEaeYT3XIUfK7PqcPH4ntteVt1mO3b8eO+uEQwpcu7qqNURTvbNB
 gbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084017; x=1697688817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJca2D3xLzWN20qSAvD8QUUb8osMMM5a5yjhh4er46Q=;
 b=UrVQukZZPBLfXGfHxsz5WCFwpl5DHlv5uEJP+Sz8qgaYaWFsNjCkOkurl32pzBoNRb
 BhIao+4K4pRnREQCWSlhAcQ9Zfqy0ghnrScs6WBDYaNfcF6FZ7AUgpPDI5n+l4Tmjtbo
 GsFfdk174sdeGA2Oso5aN6XA79+M/VmXRKSyLWHK7NNuYYAxF4lCwX43ePa/0SLk2/xp
 aEO2GS+MRpcB285H8ylBRaDyVXw1Tf/a+mYno6e+Z9Ifn/YMxaUBDFRr+bYaTwDSvqbI
 ZcRwIcR5eP45F3+ggsd+kI9yAvwOpLPYgwijoo8x7NjwgFaxL1jhVDBlhiVGUvWHqUrI
 Us3A==
X-Gm-Message-State: AOJu0YzvkghbPrlNDZRDFKz0gWJbTpfjiSCq6cAPf4yK3RRJigZSnDq8
 lW33IHB3QCUFzL3ZaYzD6YnjeCYkUhJ+Vw==
X-Google-Smtp-Source: AGHT+IGnWqMproBOO4w1cwu3Yi+JDaFDjMrIuO9HXq2+bg28cUPokGhtALFYWnT1UMuNwlFKNBgzTQ==
X-Received: by 2002:a05:6a20:4287:b0:16b:aad0:effe with SMTP id
 o7-20020a056a20428700b0016baad0effemr17356568pzj.62.1697084017161; 
 Wed, 11 Oct 2023 21:13:37 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/54] softmmu: add means to pass an exit code when requesting
 a shutdown
Date: Thu, 12 Oct 2023 14:10:41 +1000
Message-ID: <20231012041051.2572507-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

As of now, the exit code was either EXIT_FAILURE when a panic shutdown
was requested or EXIT_SUCCESS otherwise.
However, some hardware could want to pass more complex exit codes. Thus,
introduce a new shutdown request function allowing that.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231003071427.188697-2-chigot@adacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/sysemu/runstate.h |  2 ++
 system/runstate.c         | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 08afb97695..c8c2bd8a61 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -68,6 +68,8 @@ void qemu_system_wakeup_request(WakeupReason reason, Error **errp);
 void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
 void qemu_register_wakeup_notifier(Notifier *notifier);
 void qemu_register_wakeup_support(void);
+void qemu_system_shutdown_request_with_code(ShutdownCause reason,
+                                            int exit_code);
 void qemu_system_shutdown_request(ShutdownCause reason);
 void qemu_system_powerdown_request(void);
 void qemu_register_powerdown_notifier(Notifier *notifier);
diff --git a/system/runstate.c b/system/runstate.c
index 1652ed0439..363a5ea8dd 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -385,6 +385,7 @@ void vm_state_notify(bool running, RunState state)
 
 static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
+static int shutdown_exit_code = EXIT_SUCCESS;
 static int shutdown_signal;
 static pid_t shutdown_pid;
 static int powerdown_requested;
@@ -664,6 +665,13 @@ void qemu_system_killed(int signal, pid_t pid)
     qemu_notify_event();
 }
 
+void qemu_system_shutdown_request_with_code(ShutdownCause reason,
+                                            int exit_code)
+{
+    shutdown_exit_code = exit_code;
+    qemu_system_shutdown_request(reason);
+}
+
 void qemu_system_shutdown_request(ShutdownCause reason)
 {
     trace_qemu_system_shutdown_request(reason);
@@ -725,7 +733,9 @@ static bool main_loop_should_exit(int *status)
         if (shutdown_action == SHUTDOWN_ACTION_PAUSE) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
-            if (request == SHUTDOWN_CAUSE_GUEST_PANIC &&
+            if (shutdown_exit_code != EXIT_SUCCESS) {
+                *status = shutdown_exit_code;
+            } else if (request == SHUTDOWN_CAUSE_GUEST_PANIC &&
                 panic_action == PANIC_ACTION_EXIT_FAILURE) {
                 *status = EXIT_FAILURE;
             }
-- 
2.41.0


