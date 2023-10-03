Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919327B752B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnova-0004FS-HP; Tue, 03 Oct 2023 19:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovW-0004Ee-PH
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:43 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovH-00077d-DD
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:42 -0400
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-79fbbb2bed0so12694439f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376126; x=1696980926;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzrnmNRArI5YZLKP54kV4TVNyU5J4UUrUXJQ/E152oI=;
 b=lcMnqVVdFImCWDT5CLciz2VyEOeuOL6Iov2ksGwf75PcqvPqBSxwzJKmZBokJqnQBe
 ghIxD5ArHqBpogc2DaJVpAeJ+pRrCYLjxDlmuZ/RO0FEUFKwnkF7rwpCie5DlB1M/UUh
 4R32bCUZAfRIX8vs8GnPFwi3aPiN4juGS3SeVkASZqNP0ubllv6zzXJhVoEQ6IFapFHD
 oBZdTZumRoYlkog+srl5Gkt3hsGqlVQsCqo8eSEMi5+tNOKhWKMtuZ47J6UeFZdEfmvY
 L25AXDtRqY2CD8tPkiun+Sspu8w0bqjladyeB69q66K7YF4bH3xipL/0NAY+saXshSrY
 AgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376126; x=1696980926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XzrnmNRArI5YZLKP54kV4TVNyU5J4UUrUXJQ/E152oI=;
 b=lEPS912//S+1OcQFumjUGpGKG50F6SOPcyD8ZzoyntVweYh3Mgs0hUBVO/+EyfUXrP
 7fJTemS9pXM5PU5q0l+C9D/bap2C3VuaehSuSYe1MVBmGpH+6Q2bQ6HGtCvqrR31Vz7T
 j/JR0CzqBCE0WnXsLRJo9j0aFAPOb/BCCMXxEOvu4kFd7imuDnLkq+J8dNY3SkNNXW4E
 aNdbcNUJ6lIiOW+lx5VEOftM4/fUi7eqPq3iE4WgpPrK97EtDVAqYodLIQJ9FVTbhIOk
 wIOnl/0DUAds1f1a930rjkDJujaXxjz0+9AVYfAidDKY13yvHkcbCZxJv3Ci4IDQE66c
 sCUQ==
X-Gm-Message-State: AOJu0Yyam8Dq3c43BoblCilNCqH1WTZ27gk5e/xad7Nex/QPMTl/ugqQ
 0m8a5jxHboIqcVgOOpcqCqBRshivsELjlvg2/U274Hqr
X-Google-Smtp-Source: AGHT+IEOM6zCTFwEwwYHJOFC6Z92TAqv1Eg04bCd4ztp56QCTf5GFBqIn8nUxX3MhljOaMezxPFmxA==
X-Received: by 2002:a6b:740d:0:b0:790:aed5:d0b0 with SMTP id
 s13-20020a6b740d000000b00790aed5d0b0mr578583iog.0.1696376126114; 
 Tue, 03 Oct 2023 16:35:26 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:25 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 21/51] bsd-user: Implement procctl(2) along with necessary
 conversion functions.
Date: Tue,  3 Oct 2023 17:31:45 -0600
Message-ID: <20231003233215.95557-22-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d44;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd44.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-22-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.c    | 223 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   3 +
 2 files changed, 226 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 12d78b7fc98..4e67ae4d56c 100644
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
+        host.rp.rp_pids = g_try_new(struct procctl_reaper_pidinfo,
+            target_rp_count);
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
index 71a2657dd0f..b7bd0b92a65 100644
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
2.41.0


