Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52E7ACE3E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbTB-0003k7-0C; Sun, 24 Sep 2023 22:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT9-0003jd-Vo
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT8-0000AR-CJ
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40537481094so52885515e9.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609424; x=1696214224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rpy9YRc98hoKi4x0RvdoeeuQK0Rj8grNwDEdhtMUgjI=;
 b=GQue1tV61go6bCXqi2Zt1Sl2QxQqEr4sb6yZlWwXM4YkJumPfIiapbY7QdAFB/2f/z
 0Sl8L7RSsagH1jWdvvV1tyllzyHY+0k/jKUQtCMO9wSvCULf7GUwv/WUorbU/OSV9jBQ
 U/FcEnJ9/ugU324u4HZa1etbRM72Q7bimY5Ei+1jhGr1MHDzmq5CsVbZI5bumCidLuuL
 etjpN7TOsQ3npn/fd1DA05W1p8m33zCMpuJJ2qEUCHW+0EAAzim59LYPkqDj3KwaMGDQ
 2BQOc1vfLc7yvok9EQ8X7UMtMX8QXHEbhxZ18WzjO8K356m8FXcc9350j0dIorGXyh6t
 lq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609424; x=1696214224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rpy9YRc98hoKi4x0RvdoeeuQK0Rj8grNwDEdhtMUgjI=;
 b=VkbN+cLwAXgdZzIVmSAjfyK4rlpDaGyqI8k5S78ezpc32l5lKH/x4qa/jNfgQggsBR
 a6M/Hpp4VUVzrHFOJGUflS+ajtGuo86o0SUzjT0NCQ7ViSyW/8WsIEPFPDLuLEDyx2Lx
 k87/iGHghgRmfbtbs1U3T7aIOczo0dBI+QBBuvzwpkAm/3ff9NSorZSsncRK1M+Mlm/j
 co17iwg+1PxIUXiKc2RL5QfKaxdOPle5UXas+YamqbYIILQtXpABq1qdf812kz3IRLC+
 VhPiXtKsdWuTO+msBPebjSIMxZlw38EwHwcfpqiDrs0ojNrkBHgSuBEe1oMiwyUeck/F
 DJgA==
X-Gm-Message-State: AOJu0Yy56Ps+pdyiTPJ89ME39eooyb79ERgQjMnDDUwyrVLhBPlLa51Z
 jSABxilYKimrfAV50nd0BoRI9wHm1FA=
X-Google-Smtp-Source: AGHT+IGuVKAWA5+XWJwOGJG040wQDnU/LIM3Jjfq4O1hzAtH2ZgUv8LcwYn1iSmNbnA6n0lqgwLVuA==
X-Received: by 2002:adf:ed43:0:b0:31f:a25d:e9a with SMTP id
 u3-20020adfed43000000b0031fa25d0e9amr4638693wro.46.1695609424451; 
 Sun, 24 Sep 2023 19:37:04 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:37:04 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 27/28] bsd-user: Implement rfork(2) system call.
Date: Mon, 25 Sep 2023 00:01:35 +0300
Message-ID: <20230924210136.11966-28-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-proc.h    | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 7b2e6a9f79..0a3cd0ef57 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -219,4 +219,43 @@ static inline abi_long do_freebsd_vfork(void *cpu_env)
     return do_freebsd_fork(cpu_env);
 }
 
+/* rfork(2) */
+static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
+{
+    abi_long ret;
+    abi_ulong child_flag;
+
+    /*
+     * XXX We need to handle RFMEM here, as well.  Neither are safe to execute
+     * as-is on x86 hosts because they'll split memory but not the stack,
+     * wreaking havoc on host architectures that use the stack to store the
+     * return address as both threads try to pop it off.  Rejecting RFSPAWN
+     * entirely for now is ok, the only consumer at the moment is posix_spawn
+     * and it will fall back to classic vfork(2) if we return EINVAL.
+     */
+    if ((flags & TARGET_RFSPAWN) != 0) {
+        return -TARGET_EINVAL;
+    }
+    fork_start();
+    ret = rfork(flags);
+    if (ret == 0) {
+        /* child */
+        child_flag = 1;
+        target_cpu_clone_regs(cpu_env, 0);
+    } else {
+        /* parent */
+        child_flag = 0;
+    }
+
+    /*
+     * The fork system call sets a child flag in the second return
+     * value: 0 for parent process, 1 for child process.
+     */
+    set_second_rval(cpu_env, child_flag);
+    fork_end(child_flag);
+
+    return ret;
+
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index cb9425c9ba..4c4e773d1d 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -234,6 +234,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_vfork(cpu_env);
         break;
 
+    case TARGET_FREEBSD_NR_rfork: /* rfork(2) */
+        ret = do_freebsd_rfork(cpu_env, arg1);
+        break;
+
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
         ret = do_freebsd_execve(arg1, arg2, arg3);
         break;
-- 
2.42.0


