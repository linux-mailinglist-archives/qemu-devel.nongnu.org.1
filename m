Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3C7ACE5E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:40:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbT4-0003bf-AN; Sun, 24 Sep 2023 22:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT1-0003Zf-Mg
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSz-00008k-Ty
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4050bd2e33aso57896455e9.2
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609416; x=1696214216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8myFaMuRwtNV88tZcliLDFGNAk+0SshlfIoUoSyXCDo=;
 b=mePgnZjQ3SMkuzRYy5wxNjBkaD2GpCP5ZBu9sF7xmgerx4eB4C/H0+7y6Y2zjnufbF
 84EzREPMgIkuO2QHmTzNjkOzA/PK3b2S+4SeMKhoyk8bS8trpZE/hwRD+KQZPf31wO5n
 /6ji0he+lcjEicLh4voWNksKCECNeJeQZ5n5VEyxBNAPJJmGpwKmBexBqw+74ykhpAJ7
 4hNMEkegs8Rrh6mYu/ahL59b4syFiRnvKAQpf6obigOXrySLtJ1UqTq0tXhEmY1Ibdxd
 9Vs0nUD26Uo1XThCm46m6NWN2P1sPjCt91NMmfpKNy3hOpf07Jv0d24IsFp4STsNqLyf
 RH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609416; x=1696214216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8myFaMuRwtNV88tZcliLDFGNAk+0SshlfIoUoSyXCDo=;
 b=ZxOObh70aUVyT7Kyyse6jfbD+9U9BCod0bwEIxIbhNAzVcsOi4RWoHJ0NF6OvAmGz1
 qOBrMP4zvv41qcRzUtDUxAIE2Hur4l/n8JIV9pa3Yfco7S8vQgmRF9e1yaSeGx44UXU3
 Of6iL/c4+ydLevRrLHQXCMu7Vhfmf52Og/kczGjwz09N5eZCBwMwaHS5sCIjake/UuBN
 PdWnX+hpKDTL1lNqWcLSxlVg4J7DqVXFqh/fzInBHYcqOy/D2VHtrnjo8fb2UtIUhXmH
 qTwLmW3LzYJ8TkKx+3e2fOo23eYS0SVB2fNzhbGWKdpUlkmnVb/IFVkRNA+JoIeVCI46
 QTlg==
X-Gm-Message-State: AOJu0Yx+SQVqbv6X1nMn1mI7IRFtNzTsq/65p1eaG9ygSY0Jd1DwnJVp
 nfxNQqrM3/8e3VuZzKL8gcOqPZMWnjc=
X-Google-Smtp-Source: AGHT+IGiBuZTvXXpv1euO0uxZxUne5mStVUDsEPTeNgGysOr0faLhTIUZqKArPW5OrOBvGt55CLRog==
X-Received: by 2002:a05:600c:2481:b0:405:4a78:a890 with SMTP id
 1-20020a05600c248100b004054a78a890mr4908384wms.8.1695609416112; 
 Sun, 24 Sep 2023 19:36:56 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:55 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 21/28] bsd-user: Implement procctl(2) along with necessary
 conversion functions.
Date: Mon, 25 Sep 2023 00:01:29 +0300
Message-ID: <20230924210136.11966-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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

Implement t2h_procctl_cmd, h2t_reaper_status, h2t_reaper_pidinfo and h2t/t2h reaper_kill conversion functions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.c    | 222 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   3 +
 2 files changed, 225 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 12d78b7fc9..6c0c7a9d67 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -255,3 +255,225 @@ execve_end:
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
+    g_autofree union {
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
+        host.rp.rp_pids = g_try_new(struct procctl_reaper_pidinfo,target_rp_count);
+
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


