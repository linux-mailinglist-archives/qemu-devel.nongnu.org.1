Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 185BC78B943
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiaL-0005cl-TZ; Mon, 28 Aug 2023 16:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaA-0005R9-Qr
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:30 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaia8-0007ov-Dh
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:30 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99bcc0adab4so475719166b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253486; x=1693858286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTmkbch1x0LOvGOCfdEY6bQHPYXVPXeFLnKoWA6XJJ4=;
 b=BZc3PxJN1VxBI0Nb1eyyBBK0w6WmcmK/arnWNXotA4j1WfelC78f1cDeMQiKZeMgUC
 roFWmlEjQWWZk4T3mdfBRWptCCFvmud3BuO0Y/uvv7eWIESatOB9HZ4iT51dyNlCqVF0
 kwoDIG5mv9wVnflhuAA5LKcR1GDsAVleZ3FlFksoY6aMz4Wr2cl/H1VdzAzWmouVq66c
 PZ9KWuXqjKMRTQFNFgRBME2I0TE7CR2GR+ux+27bctV6stDkL4Zu72JUB3M+GDJKd+Ti
 XQ03ByYx4K8KY6RsNYwLbsLsl+Li0n5ct9FeSObye0V5DBF8Wbwm75c5WtbAxIPPuo88
 811A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253486; x=1693858286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTmkbch1x0LOvGOCfdEY6bQHPYXVPXeFLnKoWA6XJJ4=;
 b=ZzCBhFrhOxZY7ky8Q1+PD+qY8aEC3Lngg6SPY26UP6IeHIv3UtfvSEm9HjUB8odDyJ
 xWb1GK/LryuBQr2hxHjXEwLZXSrFM2egNbyJh20K2s1hF5Y5rCHAZXVUszr6sRsH1dcX
 aRL8+4YG3SW7vubS3rZYXMCMsgSAt7JEg+R0YLBDSk9Pr3OQ3oH9vRAsbnlsbzRjijss
 wfOcS2SohXTY126K1EZFtIQqIRo1C86Ggo+DmvKyC4C7ang/lzo4VozZJM9IqH8Djumf
 z1n3zLeFn86qcr5ipcOzsYJR926cDu+3AmNzBCarfJy6TBD7iKwbenJyY38I8t9eJx9t
 484w==
X-Gm-Message-State: AOJu0YyxneoMiIag8rV90mNB/2NS5ApPoQLncRkXblT3YvCRAzhvrc52
 pVOv8KAbYBMVHc8QM1E/yW5/5d+5w2HWvw==
X-Google-Smtp-Source: AGHT+IEkcv5XXMZ+kTZ2cnf+8uX2OKWGNrx0Mvf5PhaP63if7WrCXCwJr57YrqeGk1wSOQ9DpCH63A==
X-Received: by 2002:a17:906:2215:b0:9a2:2635:daa9 with SMTP id
 s21-20020a170906221500b009a22635daa9mr9582962ejs.6.1693253486562; 
 Mon, 28 Aug 2023 13:11:26 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 25/32] bsd-user: Implement procctl(2) system call.
Date: Sun, 27 Aug 2023 17:57:39 +0200
Message-Id: <20230827155746.84781-26-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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
---
 bsd-user/freebsd/os-proc.c    | 114 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   3 +
 2 files changed, 117 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index a413109bc2..3e6903d8cd 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -351,3 +351,117 @@ h2t_procctl_reaper_pidinfo(struct procctl_reaper_pidinfo *host_pi,
     return 0;
 }
 
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
+    if (error)
+        return error;
+
+    switch (host_cmd) {
+    case PROC_SPROTECT:
+        data = &flags;
+        break;
+
+    case PROC_REAP_ACQUIRE:
+    case PROC_REAP_RELEASE:
+        if (target_arg == 0)
+            data = NULL;
+        else
+            error = -TARGET_EINVAL;
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
+        if (host.rp.rp_pids == NULL)
+            error = -TARGET_ENOMEM;
+        else
+            data = &host.rp;
+        break;
+
+    case PROC_REAP_KILL:
+        error = t2h_reaper_kill(target_arg, &host.rk);
+        break;
+    }
+
+    if (error)
+        return error;
+
+    error = get_errno(procctl(idtype, id, host_cmd, data));
+
+    if (error)
+        return error;
+
+    switch(host_cmd) {
+    case PROC_SPROTECT:
+        if (put_user_s32(flags, target_arg))
+            return -TARGET_EFAULT;
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
+            if (error)
+                break;
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
index 0f25187d63..43f4561301 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -364,6 +364,9 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_setpriority(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_procctl: /* procctl(2) */
+        ret = do_freebsd_procctl(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
 
         /*
          * File system calls.
-- 
2.40.0


