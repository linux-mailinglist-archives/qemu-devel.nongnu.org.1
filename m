Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860C7A3DE3
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUq-0004dW-0O; Sun, 17 Sep 2023 17:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUh-0004bE-G2
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUf-0004JF-I7
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31f737b8b69so3715906f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986792; x=1695591592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQgG8CXW4u1VDTt9+gWEd2GeC9t1mY5/dGt9dMGKs/4=;
 b=RVQi+0X8dcXsBEPktSRddhidZItGpny4zGrE/JCSuzfbtzrVsuEiwvv3TWvNc6t/f2
 t2aThqlcqqQLazmmXCLNe8IQJYu5zX/G9+5lvjBsiZNPyhCw/jJMEvKfP3yOn0iySPgX
 DV+XnStUZSAo8NzqfP2prNIsMfVBnwtGV8MfdJzRR5SRiH35rD757ekhkrW2AxfoxxvB
 eYFoQYGeRGu0A8zRa0bjjOQhBHbe3Jx+nnFSdkeG/bClcNsqqw0j3h6iMNZwF0e3tYav
 0THMujrSbpE/Ov2OR+yJuj8Lhn/kqowTk4vwHfEcVVyncgAx3LgtltiGpKtr89EDirwh
 E3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986792; x=1695591592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQgG8CXW4u1VDTt9+gWEd2GeC9t1mY5/dGt9dMGKs/4=;
 b=cGGX64FtANBy9BFSYeCN07f7WBGtQ6LMqN0F8288ES52yFoaBLRf0iyjTRJz/lvOal
 NDC9gXCSn0qN/p2mAWLsW748Tuww3PrfgsVYcC1/5fgnmIrd/9cGz4PWD8wF9wDasbvM
 FbyI7paxG6VP62dGeXs43Y20uXQwCE4ZlRvxJ7xKWi8gmStjc0wq4+A2LHSJX9ql39iy
 iRvznotm1ICmOdWBf8QackWkI1iAX7au7Yasqa8bVqURMUBWPn7Flf7f/Ik5gQFxT7in
 dkxLt2pAPJGI0/UR/GV/m/I4utHALwRITQ0ooNqVFyPZxGrDVb79Ag43uCVw96CYrPeK
 UraA==
X-Gm-Message-State: AOJu0YxC42wIe6eFCe20FWjkyc8S53GKDXpJERX2f6jKhHFILKB8pxT4
 wMr5AoSP4pU3rXmzm74Lx5TCcOYJn3o=
X-Google-Smtp-Source: AGHT+IHp2SPsd0i34s0mE96R5ZR6A3pUIFvGxYj2dsm2Uyq6Mypl8vHaFZbRqQ84ZIwy9kzJSfeVMA==
X-Received: by 2002:a5d:420c:0:b0:31f:91ae:4509 with SMTP id
 n12-20020a5d420c000000b0031f91ae4509mr5846465wrq.40.1694986791984; 
 Sun, 17 Sep 2023 14:39:51 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:51 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 21/28] bsd-user: Implement procctl(2) along with necessary
 conversion functions.
Date: Mon, 18 Sep 2023 00:37:56 +0300
Message-ID: <20230917213803.20683-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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

Implement t2h_procctl_cmd, h2t_reaper_status, h2t_reaper_pidinfo and h2t/t2h reaper_kill conversion functions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.c    | 223 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   3 +
 2 files changed, 226 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 12d78b7fc9..6b8753f8e5 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -255,3 +255,226 @@ execve_end:
     return ret;
 }
 
+#include <sys/procctl.h>
+
+static abi_long
+t2h_procctl_cmd(int target_cmd, int *host_cmd)
+{
+    switch (target_cmd) {
+    case TARGET_PROC_SPROTECT:
+        *host_cmd = PROC_SPROTECT;
+        break;
+
+    case TARGET_PROC_REAP_ACQUIRE:
+        *host_cmd = PROC_REAP_ACQUIRE;
+        break;
+
+    case TARGET_PROC_REAP_RELEASE:
+        *host_cmd = PROC_REAP_RELEASE;
+        break;
+
+    case TARGET_PROC_REAP_STATUS:
+        *host_cmd = PROC_REAP_STATUS;
+        break;
+
+    case TARGET_PROC_REAP_KILL:
+        *host_cmd = PROC_REAP_KILL;
+        break;
+
+    default:
+        return -TARGET_EINVAL;
+    }
+
+    return 0;
+}
+
+static abi_long
+h2t_reaper_status(struct procctl_reaper_status *host_rs,
+        abi_ulong target_rs_addr)
+{
+    struct target_procctl_reaper_status *target_rs;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_rs, target_rs_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_rs->rs_flags, &target_rs->rs_flags);
+    __put_user(host_rs->rs_children, &target_rs->rs_children);
+    __put_user(host_rs->rs_descendants, &target_rs->rs_descendants);
+    __put_user(host_rs->rs_reaper, &target_rs->rs_reaper);
+    __put_user(host_rs->rs_pid, &target_rs->rs_pid);
+    unlock_user_struct(target_rs, target_rs_addr, 1);
+
+    return 0;
+}
+
+static abi_long
+t2h_reaper_kill(abi_ulong target_rk_addr, struct procctl_reaper_kill *host_rk)
+{
+    struct target_procctl_reaper_kill *target_rk;
+
+    if (!lock_user_struct(VERIFY_READ, target_rk, target_rk_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_rk->rk_sig, &target_rk->rk_sig);
+    __get_user(host_rk->rk_flags, &target_rk->rk_flags);
+    __get_user(host_rk->rk_subtree, &target_rk->rk_subtree);
+    __get_user(host_rk->rk_killed, &target_rk->rk_killed);
+    __get_user(host_rk->rk_fpid, &target_rk->rk_fpid);
+    unlock_user_struct(target_rk, target_rk_addr, 0);
+
+    return 0;
+}
+
+static abi_long
+h2t_reaper_kill(struct procctl_reaper_kill *host_rk, abi_ulong target_rk_addr)
+{
+    struct target_procctl_reaper_kill *target_rk;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_rk, target_rk_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_rk->rk_sig, &target_rk->rk_sig);
+    __put_user(host_rk->rk_flags, &target_rk->rk_flags);
+    __put_user(host_rk->rk_subtree, &target_rk->rk_subtree);
+    __put_user(host_rk->rk_killed, &target_rk->rk_killed);
+    __put_user(host_rk->rk_fpid, &target_rk->rk_fpid);
+    unlock_user_struct(target_rk, target_rk_addr, 1);
+
+    return 0;
+}
+
+static abi_long
+h2t_procctl_reaper_pidinfo(struct procctl_reaper_pidinfo *host_pi,
+        abi_ulong target_pi_addr)
+{
+    struct target_procctl_reaper_pidinfo *target_pi;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_pi, target_pi_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_pi->pi_pid, &target_pi->pi_pid);
+    __put_user(host_pi->pi_subtree, &target_pi->pi_subtree);
+    __put_user(host_pi->pi_flags, &target_pi->pi_flags);
+    unlock_user_struct(target_pi, target_pi_addr, 1);
+
+    return 0;
+}
+
+abi_long
+do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2, abi_ulong arg3,
+       abi_ulong arg4, abi_ulong arg5, abi_ulong arg6)
+{
+    abi_long error = 0, target_rp_pids;
+    void *data;
+    int host_cmd, flags;
+    uint32_t u, target_rp_count;
+    union {
+        struct procctl_reaper_status rs;
+        struct procctl_reaper_pids rp;
+        struct procctl_reaper_kill rk;
+    } host;
+    struct target_procctl_reaper_pids *target_rp;
+    id_t id; /* 64-bit */
+    int target_cmd;
+    abi_ulong target_arg;
+
+#if TARGET_ABI_BITS == 32
+    /* See if we need to align the register pairs. */
+    if (regpairs_aligned(cpu_env)) {
+        id = (id_t)target_arg64(arg3, arg4);
+        target_cmd = (int)arg5;
+        target_arg = arg6;
+    } else {
+        id = (id_t)target_arg64(arg2, arg3);
+        target_cmd = (int)arg4;
+        target_arg = arg5;
+    }
+#else
+    id = (id_t)arg2;
+    target_cmd = (int)arg3;
+    target_arg = arg4;
+#endif
+
+    error = t2h_procctl_cmd(target_cmd, &host_cmd);
+    if (error) {
+        return error;
+    }
+    switch (host_cmd) {
+    case PROC_SPROTECT:
+        data = &flags;
+        break;
+
+    case PROC_REAP_ACQUIRE:
+    case PROC_REAP_RELEASE:
+        if (target_arg == 0) {
+            data = NULL;
+        } else {
+            error = -TARGET_EINVAL;
+        }
+        break;
+
+    case PROC_REAP_STATUS:
+        data = &host.rs;
+        break;
+
+    case PROC_REAP_GETPIDS:
+        if (!lock_user_struct(VERIFY_READ, target_rp, target_arg, 1)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(target_rp_count, &target_rp->rp_count);
+        __get_user(target_rp_pids, &target_rp->rp_pids);
+        unlock_user_struct(target_rp, target_arg, 0);
+        host.rp.rp_count = target_rp_count;
+        /* XXX we should check target_rc_count to see if it is reasonable. */
+        host.rp.rp_pids = alloca(target_rp_count *
+                sizeof(struct procctl_reaper_pidinfo));
+        if (host.rp.rp_pids == NULL) {
+            error = -TARGET_ENOMEM;
+        } else {
+            data = &host.rp;
+        }
+        break;
+
+    case PROC_REAP_KILL:
+        error = t2h_reaper_kill(target_arg, &host.rk);
+        break;
+    }
+
+    if (error) {
+        return error;
+    }
+    error = get_errno(procctl(idtype, id, host_cmd, data));
+
+    if (error) {
+        return error;
+    }
+    switch (host_cmd) {
+    case PROC_SPROTECT:
+        if (put_user_s32(flags, target_arg)) {
+            return -TARGET_EFAULT;
+        }
+        break;
+
+    case PROC_REAP_STATUS:
+        error = h2t_reaper_status(&host.rs, target_arg);
+        break;
+
+    case PROC_REAP_GETPIDS:
+        /* copyout reaper pidinfo */
+        for (u = 0; u < target_rp_count; u++) {
+            error = h2t_procctl_reaper_pidinfo(&host.rp.rp_pids[u],
+                    target_rp_pids +
+                    (u * sizeof(struct target_procctl_reaper_pidinfo)));
+            if (error) {
+                break;
+            }
+        }
+        break;
+
+    case PROC_REAP_KILL:
+        error = h2t_reaper_kill(&host.rk, target_arg);
+        break;
+    }
+
+    return error;
+}
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 71a2657dd0..b7bd0b92a6 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -367,6 +367,9 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_setpriority(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_procctl: /* procctl(2) */
+        ret = do_freebsd_procctl(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
 
         /*
          * File system calls.
-- 
2.42.0


