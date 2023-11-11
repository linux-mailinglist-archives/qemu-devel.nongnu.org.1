Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E26807E8AAD
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 12:25:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1m5o-00079I-0S; Sat, 11 Nov 2023 06:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r1m5m-000796-A1; Sat, 11 Nov 2023 06:23:58 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r1m5k-00042C-Lq; Sat, 11 Nov 2023 06:23:58 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c54c8934abso39106841fa.0; 
 Sat, 11 Nov 2023 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699701833; x=1700306633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FZmQ+a+9heO16zZ/im+mfz3nzFesc3B/VlAYkHw5wFk=;
 b=Q4twtRxdIs12D1xTMTQvxW/22Ywrf+7GapRP/55DOwwkWXiUMOSGqtKkiit/4M5fpI
 p1YbaTV5XlXZzVegqX2QBah0Rz9VLAFwdT1jC4G4nB6Dofa0D2BSSETFGXbflobbdHX0
 oKKh0bqC4X+B9skqj95W7ta3EPNoWJC8gaPHW4S1eKEd9mdkiSh2MOvjwVk/uW1M5vCf
 WcC6bWCqZSWyE9xePVLW0wRVILXZ92YKszwWK4PUXfgQPFXmNN7AiylYS5keaxUX+O0C
 vE8qKoK7uinsJNg6DNH927PniFJe6jaqQc4jSH9t6ROwXTvgusHxziba+h1QTvplHM8b
 xd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699701833; x=1700306633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZmQ+a+9heO16zZ/im+mfz3nzFesc3B/VlAYkHw5wFk=;
 b=T1Cks9RpgnWt18KILdK+g7lx3367tdhivlJlEy1I74yiwHHDEHXzficgJhQMFDVh7f
 EBJrgi7SGUNsBmSUMWJ6m2n47nsGlsoB0Y+KiQ63Mfby+dZbbWmTn56jiYXvedlThUXm
 H9sSqEdLkYwwH8Ns/6W8jkd1B+hXkIrKeoxgUFX4UvCrM82YNbAxu10GWmVK9N1f+qy4
 W9CiYIJKhGO8H1PXC8VUV7fbjzPAN+rpfzS4X+qE4B9L5jefZpRQl7wPULDjPguEU+/B
 75eoQSJ9OZ/LPymGENodSPXNLzjOf+7+Gv+7DZ+GHG1EGSYH/uD2q6OGp0H62zL9CfI0
 55Hg==
X-Gm-Message-State: AOJu0YyyUw16qqzx45FTCI4f2m5vMEjjqi1lTdsFoV9ylMyudg3/saal
 BRcFZeBlXt8YZ2E0U98uCGYkCGwC7BeS3g==
X-Google-Smtp-Source: AGHT+IGE9sJHau0/24bRZdYHacJWn6zDCU9fu3hkNf4oEQe1ZOP5xO+YX/Dblk7KnEeh1HkWSzBRYQ==
X-Received: by 2002:a2e:8709:0:b0:2c5:11fe:53b2 with SMTP id
 m9-20020a2e8709000000b002c511fe53b2mr1255581lji.37.1699701832409; 
 Sat, 11 Nov 2023 03:23:52 -0800 (PST)
Received: from localhost.localdomain ([37.130.110.151])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a2e700b000000b002c288388153sm210126ljc.136.2023.11.11.03.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 03:23:51 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] linux-user: xtensa: fix signal delivery in FDPIC
Date: Sat, 11 Nov 2023 03:22:52 -0800
Message-Id: <20231111112252.1387418-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In FDPIC signal handlers are passed around as FD pointers. Actual code
address and GOT pointer must be fetched from memory by the QEMU code
that implements kernel signal delivery functionality. This change is
equivalent to the following kernel change:
9c2cc74fb31e ("xtensa: fix signal delivery to FDPIC process")

Cc: qemu-stable@nongnu.org
Fixes: d2796be69d7c ("linux-user: add support for xtensa FDPIC")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/xtensa/signal.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index f5fb8b5cbebe..32dcfa522919 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -157,6 +157,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 {
     abi_ulong frame_addr;
     struct target_rt_sigframe *frame;
+    int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
+    abi_ulong handler = 0;
+    abi_ulong handler_fdpic_GOT = 0;
     uint32_t ra;
     bool abi_call0;
     unsigned base;
@@ -165,6 +168,17 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     frame_addr = get_sigframe(ka, env, sizeof(*frame));
     trace_user_setup_rt_frame(env, frame_addr);
 
+    if (is_fdpic) {
+        abi_ulong funcdesc_ptr = ka->_sa_handler;
+
+        if (get_user_ual(handler, funcdesc_ptr)
+            || get_user_ual(handler_fdpic_GOT, funcdesc_ptr + 4)) {
+            goto give_sigsegv;
+        }
+    } else {
+        handler = ka->_sa_handler;
+    }
+
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -185,14 +199,21 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     if (ka->sa_flags & TARGET_SA_RESTORER) {
-        ra = ka->sa_restorer;
+        if (is_fdpic) {
+            if (get_user_ual(ra, ka->sa_restorer)) {
+                unlock_user_struct(frame, frame_addr, 0);
+                goto give_sigsegv;
+            }
+        } else {
+            ra = ka->sa_restorer;
+        }
     } else {
         /* Not used, but retain for ABI compatibility. */
         install_sigtramp(frame->retcode);
         ra = default_rt_sigreturn;
     }
     memset(env->regs, 0, sizeof(env->regs));
-    env->pc = ka->_sa_handler;
+    env->pc = handler;
     env->regs[1] = frame_addr;
     env->sregs[WINDOW_BASE] = 0;
     env->sregs[WINDOW_START] = 1;
@@ -212,6 +233,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->regs[base + 3] = frame_addr + offsetof(struct target_rt_sigframe,
                                                 info);
     env->regs[base + 4] = frame_addr + offsetof(struct target_rt_sigframe, uc);
+    if (is_fdpic) {
+        env->regs[base + 11] = handler_fdpic_GOT;
+    }
     unlock_user_struct(frame, frame_addr, 1);
     return;
 
-- 
2.39.2


