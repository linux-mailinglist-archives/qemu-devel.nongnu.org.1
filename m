Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDB377BE21
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVaU8-0000WR-3R; Mon, 14 Aug 2023 12:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaU6-0000WC-1I
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:32:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaU4-0004xq-Gx
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:32:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bbf8cb61aeso28355855ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692030718; x=1692635518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgieqkv4AvDj0uYBJOPb/yUDnPBp/9usJYWOJeI9mbM=;
 b=PawWzh8/T9vP1mnpqVJT2WsoxYQJMFzb8ha+8iOoRawr8k4lUELJMx6Gt0G84OhzrG
 z38yHY+hmlNLpjSYFfQWpjvC/ftY9hyz3VwE+1Yf9U5RizARgKpbUKcaUjzJxxPgsQZ6
 gFbRzUXf/j9E5WMJW2PIIzvrLRynT9VAZxynQd7W3pMVEbmniPyA5J40n6hjnna0S193
 z859ZEQVHW35glipuCBowzVlOn0o9S7kjUzrz8Hj3aEfQ0sD/OuveuS7p/l/lWl37RIW
 NHSVz9wQWItfJIjHQKPI2nJ3lydy+Rray+aF9Ne3FtSHBfYXkz+VRSf4BI3dslZHriCT
 HV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692030718; x=1692635518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgieqkv4AvDj0uYBJOPb/yUDnPBp/9usJYWOJeI9mbM=;
 b=ZNoIo7KCA+xmrlXBtaGkulZ4Wz67KqxWTtwpW7J28wF4IZVy2UJJwViZE8XXociiiy
 sjfZct9ar7njm+iokbXTHf6Y12QHIEONlofkgVWboEKHFKYTIYYjofoPaC1KX0VJ7tLp
 XVeCFNySfC9bk85MrSTCD5FXZIOZyyiwPkBn4LwmBkj42b7uStNNYk8dJar0lMncvLR5
 cutoBLauODX5VdP68ClPRoAU4MOGID0usf0mH5KbtXnNvSgFvb2MHBlCu37TgOKTl8xB
 KHIeotrRetsfkcZTQ87QMsbqVHVEIR1WlwVFLfQO/sQke5XO5K6/tZ7vIsRBiBUcRguY
 kuGA==
X-Gm-Message-State: AOJu0YyhMFVhvf/1CpvrfrYh0C8RHxRzpbXCXaeibc9SFVW1bSuBCElB
 SFAL0KxcNARhA+RxxaI1pFU=
X-Google-Smtp-Source: AGHT+IFKuI2AK6nDDzdfu+hhIYmneMnCeXgmNoV3QtX3Zx517pcoCqGtvImwRlsk0KFkUJVzfLAMDw==
X-Received: by 2002:a17:903:1cc:b0:1b8:a2af:fe23 with SMTP id
 e12-20020a17090301cc00b001b8a2affe23mr6873016plh.2.1692030718438; 
 Mon, 14 Aug 2023 09:31:58 -0700 (PDT)
Received: from wheely.local0.net ([61.68.161.249])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001b8a3a0c928sm9613263plc.181.2023.08.14.09.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 09:31:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/4] replay: allow runstate shutdown->running when replaying
 trace
Date: Tue, 15 Aug 2023 02:31:34 +1000
Message-Id: <20230814163135.187882-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814163135.187882-1-npiggin@gmail.com>
References: <20230814163135.187882-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When replaying a trace, it is possible to go from shutdown to
running with a reverse-debugging step. This can be useful if the
problem being debugged triggers a reset or shutdown.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/sysemu/runstate.h |  1 +
 replay/replay.c           |  2 ++
 softmmu/runstate.c        | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 7beb29c2e2..85a1167ccb 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -9,6 +9,7 @@ void runstate_set(RunState new_state);
 RunState runstate_get(void);
 bool runstate_is_running(void);
 bool runstate_needs_reset(void);
+void runstate_replay_enable(void);
 
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 
diff --git a/replay/replay.c b/replay/replay.c
index 0f7d766efe..e64f71209a 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -272,6 +272,8 @@ static void replay_enable(const char *fname, int mode)
         /* go to the beginning */
         fseek(replay_file, HEADER_SIZE, SEEK_SET);
         replay_fetch_data_kind();
+
+        runstate_replay_enable();
     }
 
     replay_init_events();
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index f3bd862818..9fd3e57485 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -174,6 +174,12 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE__MAX, RUN_STATE__MAX },
 };
 
+static const RunStateTransition replay_runstate_transitions_def[] = {
+    { RUN_STATE_SHUTDOWN, RUN_STATE_RUNNING},
+
+    { RUN_STATE__MAX, RUN_STATE__MAX },
+};
+
 static bool runstate_valid_transitions[RUN_STATE__MAX][RUN_STATE__MAX];
 
 bool runstate_check(RunState state)
@@ -181,6 +187,19 @@ bool runstate_check(RunState state)
     return current_run_state == state;
 }
 
+void runstate_replay_enable(void)
+{
+    const RunStateTransition *p;
+
+    assert(replay_mode == REPLAY_MODE_PLAY);
+
+    for (p = &replay_runstate_transitions_def[0]; p->from != RUN_STATE__MAX;
+         p++) {
+        runstate_valid_transitions[p->from][p->to] = true;
+    }
+
+}
+
 static void runstate_init(void)
 {
     const RunStateTransition *p;
-- 
2.40.1


