Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D978B944
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZX-0001iF-UU; Mon, 28 Aug 2023 16:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZW-0001dg-2d
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:50 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZT-0007mu-Fj
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:49 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99de884ad25so484573066b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253445; x=1693858245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPaJlwWvW4Ocf8/31j+3OB7HSlabElE5TQ7jHnnbRPc=;
 b=TqW9IQMH9Gg0gRkLaTRWjczNIJFWFp8220viOrJZ9PBUtWSuleQpYbMPrX3pRNqVau
 zT9DUjasO4KVSQ6NV+5za9Wg0k4nXSh4/HKSXXx9hR7E5Zn7oJkziIzQpezkyD/4Gei0
 CmKzk7uTyYf/GYzP9/pmHphuBGRvTAAxyzhEbhiXqPOL7Y2o88GEblRJjBFR3aRTOM1M
 sqi7eNLlIsy3Pv3M+fVfmbeQ6ggUol2l993q6UPvk0OnPZ3mwvv1bXZBy2hSg9Qpla8j
 6kkGshwFFUGSZXfAqxnaiYUK4mJvGaEcdn+j5KvenUo6zrPFzpngQbWozN15JIZrCcyV
 XQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253445; x=1693858245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPaJlwWvW4Ocf8/31j+3OB7HSlabElE5TQ7jHnnbRPc=;
 b=EUS5kkR3gNEh5/384oTZccb6JZsNh3lJC9NdDtOqSlfsWCi2jGNsztROX1TOUl+Ww9
 lNAfNCNUOeD/ghEnVa0cOXLiAbCFIoZfn05pZqsbrU+soKh4VVIFA8SKiMvc7Z4j2hN7
 7FC0qsq3z4r9IVlLwT4IIC9Sc3Db/YiIXeW6Vv0YcUrANyv+IIuKI7iY4h4bIfmQRgdN
 e1QC71ZrQ3AcPUxRitjiDgBrfD7w0jWXNrPSwyP7L1aAnAG4ftGV+eAV+5mLwFkodW4E
 m/tSY3bbgdjeDLP+DPJQ3tKFPnD4NinNwn71vd78R/q20u1/hW58x0oeWif9bd1j6Zb0
 9+Xg==
X-Gm-Message-State: AOJu0YxJThoaNi8EE9Rk4VqnEeqpn2Ar6QXzM2uUJduLZvV6ifHyYOxO
 wHntOeoMBO54deKlN3FDiW4rth1Aaw4erw==
X-Google-Smtp-Source: AGHT+IHNWH09W8cqnqlTfm2yldjmlCnAi9N96bPSKvwENS2esiQGmUNC7l6aVAjt1PB0nGNPc7c0rw==
X-Received: by 2002:a17:907:6087:b0:9a2:1bd8:a6a with SMTP id
 ht7-20020a170907608700b009a21bd80a6amr9960448ejc.41.1693253445125; 
 Mon, 28 Aug 2023 13:10:45 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:44 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 22/32] bsd-user: Implement freebsd_exec_common,
 used in implementing execve/fexecve.
Date: Sun, 27 Aug 2023 17:57:36 +0200
Message-Id: <20230827155746.84781-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x633.google.com
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
 bsd-user/freebsd/os-proc.c | 177 +++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 5cd800e607..396f258a64 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -72,3 +72,180 @@ out:
     return ret;
 }
 
+/*
+ * execve/fexecve
+ */
+abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
+        abi_ulong guest_envp, int do_fexec)
+{
+    char **argp, **envp, **qargp, **qarg1, **qarg0, **qargend;
+    int argc, envc;
+    abi_ulong gp;
+    abi_ulong addr;
+    char **q;
+    int total_size = 0;
+    void *p;
+    abi_long ret;
+
+    argc = 0;
+    for (gp = guest_argp; gp; gp += sizeof(abi_ulong)) {
+        if (get_user_ual(addr, gp)) {
+            return -TARGET_EFAULT;
+        }
+        if (!addr) {
+            break;
+        }
+        argc++;
+    }
+    envc = 0;
+    for (gp = guest_envp; gp; gp += sizeof(abi_ulong)) {
+        if (get_user_ual(addr, gp)) {
+            return -TARGET_EFAULT;
+        }
+        if (!addr) {
+            break;
+        }
+        envc++;
+    }
+
+    qarg0 = argp = g_new0(char *, argc + 9);
+    /* save the first agrument for the emulator */
+    *argp++ = (char *)getprogname();
+    qargp = argp;
+    *argp++ = (char *)getprogname();
+    qarg1 = argp;
+    envp = g_new0(char *, envc + 1);
+    for (gp = guest_argp, q = argp; gp; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp)) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+        if (!addr) {
+            break;
+        }
+        *q = lock_user_string(addr);
+        if (*q == NULL) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+        total_size += strlen(*q) + 1;
+    }
+    *q++ = NULL;
+    qargend = q;
+
+    for (gp = guest_envp, q = envp; gp; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp)) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+        if (!addr) {
+            break;
+        }
+        *q = lock_user_string(addr);
+        if (*q == NULL) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+        total_size += strlen(*q) + 1;
+    }
+    *q = NULL;
+
+    /*
+     * This case will not be caught by the host's execve() if its
+     * page size is bigger than the target's.
+     */
+    if (total_size > MAX_ARG_PAGES * TARGET_PAGE_SIZE) {
+        ret = -TARGET_E2BIG;
+        goto execve_end;
+    }
+
+    if (do_fexec) {
+        if (((int)path_or_fd > 0 &&
+            is_target_elf_binary((int)path_or_fd)) == 1) {
+            char execpath[PATH_MAX];
+
+            /*
+             * The executable is an elf binary for the target
+             * arch.  execve() it using the emulator if we can
+             * determine the filename path from the fd.
+             */
+            if (get_filename_from_fd(getpid(), (int)path_or_fd, execpath,
+                        sizeof(execpath)) != NULL) {
+                memmove(qarg1 + 2, qarg1, (qargend-qarg1) * sizeof(*qarg1));
+		qarg1[1] = qarg1[0];
+		qarg1[0] = (char *)"-0";
+		qarg1 += 2;
+		qargend += 2;
+                *qarg1 = execpath;
+#ifndef DONT_INHERIT_INTERP_PREFIX
+                memmove(qarg1 + 2, qarg1, (qargend-qarg1) * sizeof(*qarg1));
+                *qarg1++ = (char *)"-L";
+                *qarg1++ = (char *)interp_prefix;
+#endif
+                ret = get_errno(execve(qemu_proc_pathname, qargp, envp));
+            } else {
+                /* Getting the filename path failed. */
+                ret = -TARGET_EBADF;
+                goto execve_end;
+            }
+        } else {
+            ret = get_errno(fexecve((int)path_or_fd, argp, envp));
+        }
+    } else {
+        int fd;
+
+        p = lock_user_string(path_or_fd);
+        if (p == NULL) {
+            ret = -TARGET_EFAULT;
+            goto execve_end;
+        }
+
+        /*
+         * Check the header and see if it a target elf binary.  If so
+         * then execute using qemu user mode emulator.
+         */
+        fd = open(p, O_RDONLY | O_CLOEXEC);
+        if (fd > 0 && is_target_elf_binary(fd) == 1) {
+            close(fd);
+            /* execve() as a target binary using emulator. */
+            memmove(qarg1 + 2, qarg1, (qargend-qarg1) * sizeof(*qarg1));
+            qarg1[1] = qarg1[0];
+            qarg1[0] = (char *)"-0";
+            qarg1 += 2;
+	    qargend += 2;
+            *qarg1 = (char *)p;
+#ifndef DONT_INHERIT_INTERP_PREFIX
+            memmove(qarg1 + 2, qarg1, (qargend-qarg1) * sizeof(*qarg1));
+            *qarg1++ = (char *)"-L";
+            *qarg1++ = (char *)interp_prefix;
+#endif
+            ret = get_errno(execve(qemu_proc_pathname, qargp, envp));
+        } else {
+            close(fd);
+            /* Execve() as a host native binary. */
+            ret = get_errno(execve(p, argp, envp));
+        }
+        unlock_user(p, path_or_fd, 0);
+    }
+
+execve_end:
+    for (gp = guest_argp, q = argp; *q; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp) || !addr) {
+            break;
+        }
+        unlock_user(*q, addr, 0);
+    }
+
+    for (gp = guest_envp, q = envp; *q; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp) || !addr) {
+            break;
+        }
+        unlock_user(*q, addr, 0);
+    }
+
+    g_free(qarg0);
+    g_free(envp);
+
+    return ret;
+}
+
-- 
2.40.0


