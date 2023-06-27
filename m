Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D318674007D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:12:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGb-0000ng-QL; Tue, 27 Jun 2023 12:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGV-0000UJ-Nr
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:10:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGM-0005r6-RW
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:10:03 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f96d680399so6563407e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882192; x=1690474192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8VqszCYj9oqwHFxWVNQZUykN/PvSJ3ab7nReTpSKM8=;
 b=XMhm8FgS8giBNBK5ETfbrA6xJ5oNX8WRTHa90LgBxgSEuqHi2XjhMOfLVrr1l7RHo5
 PTXSUv25u2pr8jgcyjPDsZKBgJsJMOP3zu7w6i2Q2wK5JcBbjHkVhDlIembD+DegUXFU
 hlAgNXXcngS2UPAQ+oSxM1THsn83DyeRPd6uKxS3S5yjiKWwN7EPEeQ8DUQbqI58iQ9m
 ePz6e2He2NflCCs9KurPBCU+17ADYY/WiVpxC257huHPqNPtnorDpVxRvk+RygqzCein
 p2TcLFUx/FblveNqwW4dAhe7jaA1LeyUXqA8tNQVMhcVsa9dw+lUtEHbrR3iPtFO6A/0
 ol+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882192; x=1690474192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8VqszCYj9oqwHFxWVNQZUykN/PvSJ3ab7nReTpSKM8=;
 b=mFo4s5ToUTc7G+BGmFu+R0lfpZ7P74DTwFB3l5W62tYMGIcxg1/X4Fn/G5jBWdy7g4
 LN9FFK2LFHADClWVFAeuzYmf5UBqDM5/yRb2lj046NMAdHAMAmUR8x6rAOv6htSJp+Hi
 6BpU9zdRfcCOPwerIkMZkNCMAf8ZAvxEH1cPFV/3DApfBGpB+FFvl+hOqathXvFIY0SB
 PsK7fI26l9MXtr8nlgec/PoUzd0U/m2Mv8xeFDdiBY9TCvu5GMcJenGRdnkXj2rV/Oew
 jd+9UGES09sgDgIvh0WUCUQcvJ7KVc4zbdynFFS7zKRACDLXOZ82zjmIa08ZnkshlHj5
 jDWQ==
X-Gm-Message-State: AC+VfDwl95tJ3k7tKFY+C65QwuQHKuU7dW2y4KAZLOd0gMoTVIp3aLUF
 npz63rTQaik3Dwkgdc3bzsB46A==
X-Google-Smtp-Source: ACHHUZ5B+rUefwpk0Vi+PVAiSCBretc0ET7lqhpOpdKyzJ5z/Nlhz1oxNOvbaPXtJk9EDcNqjO6OwA==
X-Received: by 2002:a05:6512:118d:b0:4f9:596d:c803 with SMTP id
 g13-20020a056512118d00b004f9596dc803mr17906428lfr.53.1687882192454; 
 Tue, 27 Jun 2023 09:09:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 14-20020a05600c020e00b003f8d6647661sm14109513wmi.15.2023.06.27.09.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 71F201FFD6;
 Tue, 27 Jun 2023 17:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 30/36] linux-user: Add "safe" parameter to do_guest_openat()
Date: Tue, 27 Jun 2023 17:09:37 +0100
Message-Id: <20230627160943.2956928-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

gdbstub cannot meaningfully handle QEMU_ERESTARTSYS, and it doesn't
need to. Add a parameter to do_guest_openat() that makes it use
openat() instead of safe_openat(), so that it becomes usable from
gdbstub.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621203627.1808446-3-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/qemu.h    |  2 +-
 linux-user/syscall.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index a5830ec239..9b8e0860d7 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -166,7 +166,7 @@ typedef struct TaskState {
 
 abi_long do_brk(abi_ulong new_brk);
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
-                    int flags, mode_t mode);
+                    int flags, mode_t mode, bool safe);
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz);
 
 /* user access */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fa83737192..ecd9f5e23d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8449,7 +8449,7 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
 #endif
 
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
-                    int flags, mode_t mode)
+                    int flags, mode_t mode, bool safe)
 {
     struct fake_open {
         const char *filename;
@@ -8476,7 +8476,11 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
     };
 
     if (is_proc_myself(pathname, "exe")) {
-        return safe_openat(dirfd, exec_path, flags, mode);
+        if (safe) {
+            return safe_openat(dirfd, exec_path, flags, mode);
+        } else {
+            return openat(dirfd, exec_path, flags, mode);
+        }
     }
 
     for (fake_open = fakes; fake_open->filename; fake_open++) {
@@ -8518,7 +8522,11 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
         return fd;
     }
 
-    return safe_openat(dirfd, path(pathname), flags, mode);
+    if (safe) {
+        return safe_openat(dirfd, path(pathname), flags, mode);
+    } else {
+        return openat(dirfd, path(pathname), flags, mode);
+    }
 }
 
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
@@ -9027,7 +9035,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return -TARGET_EFAULT;
         ret = get_errno(do_guest_openat(cpu_env, AT_FDCWD, p,
                                   target_to_host_bitmask(arg2, fcntl_flags_tbl),
-                                  arg3));
+                                  arg3, true));
         fd_trans_unregister(ret);
         unlock_user(p, arg1, 0);
         return ret;
@@ -9037,7 +9045,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return -TARGET_EFAULT;
         ret = get_errno(do_guest_openat(cpu_env, arg1, p,
                                   target_to_host_bitmask(arg3, fcntl_flags_tbl),
-                                  arg4));
+                                  arg4, true));
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
         return ret;
-- 
2.39.2


