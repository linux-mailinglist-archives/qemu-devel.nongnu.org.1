Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B47ADEA6
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:27:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHy-0001RR-Ur; Mon, 25 Sep 2023 14:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHt-0001OR-MI
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHr-0007Sd-S6
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4053cb57f02so58796915e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666386; x=1696271186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rpy9YRc98hoKi4x0RvdoeeuQK0Rj8grNwDEdhtMUgjI=;
 b=TIiuZnYtv/eB/GWP3XVXBT/2Mh32I45MArFaLua0NYlfleNSg4+vXtV2WabxJanVM8
 kYrx0o/5Up63xduo7EtHeAFaNNpu/tNFdOlf2NoNSbFuAtruq20AWLeNx5MdDtXb8zAP
 BZpomQXgPKEZMDguPexK4wultoNKw8sA9aZZfw068zLqqhZ46JojPfa3nqGuMOqjFF8J
 c9YkLBBa/l1ArA+58VIW1gye6DBA4aFpr527kzjxEQZRaKiaSjPA12p0xcvv7WgFHz91
 sHzRwbfIyFbFR40O5gL13RzsDDw4iwgI+7a0J8eLimN2+gAYZtbkess0Bv9L1Jhva960
 HE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666386; x=1696271186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rpy9YRc98hoKi4x0RvdoeeuQK0Rj8grNwDEdhtMUgjI=;
 b=rk0I0w5HjSstJpHsRBsSzEd7DpceyU8GxkwvnkLv10z/7OqpxDfwU8lj4LlXMd7qDC
 ObNa+0K9LdCyhPQvPW/1JjJWJifytF0YIDVVoCCP22+E0MQAgRICAH3lr7wQMZtRL/Ju
 4JShOH42FmwGyQAM1q1ly02umUY5sk9lYTB+Vca9TLzNiqXPoZgRdr++6t+Uaf+PB9um
 AKTJ2GIBt0nYYhBVSpP2M8lYiFagzfh3O415oxt8drY7jU25Us+zoflQKDqaXJRbli9i
 n2nbmlhrGJcqURoDXof/jNZOPbCp2JO7yC+x9p9V9pNLJfxIB6ZctPZZ40rRhKQBt6QZ
 gqXQ==
X-Gm-Message-State: AOJu0YzChQw/51QE342itMejNXhHzO9CjljS4OH8eYg6J+b3R8v72Xk8
 Y98jEfu4z/5zGVzM1B8nC2gohyg3h10=
X-Google-Smtp-Source: AGHT+IF1YcMQfeuq6FHDnIqi0tZ96rV5f1wue2Ta3aNCZMP3N9X+Fh7FkazXiz17oao/KyB4+zdUkA==
X-Received: by 2002:a7b:c456:0:b0:405:39b4:3145 with SMTP id
 l22-20020a7bc456000000b0040539b43145mr6859079wmi.2.1695666386257; 
 Mon, 25 Sep 2023 11:26:26 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:25 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 27/28] bsd-user: Implement rfork(2) system call.
Date: Mon, 25 Sep 2023 21:24:24 +0300
Message-ID: <20230925182425.3163-28-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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


