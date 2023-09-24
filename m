Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C97457ACE5D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbTE-0003tZ-Kn; Sun, 24 Sep 2023 22:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbTA-0003kB-Mq
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT9-0000Ac-62
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31ff985e292so5152700f8f.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609425; x=1696214225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEpfVHQYJiHs/o3VXa4xKMUM5FKYuciwQMorXR+KT/8=;
 b=iSWxHcAIRYVBIgdbR5aH41IDO59L7utiP/XJ3u8Wy0eq0oevnCEia0rDrjbLWgOHum
 q7cqVO9SX1vfA8+N6H3SqoxWBSUlXAsjmDIbGEWOW6oBfX5WkP7/QvtRGa3deUI4ugfV
 qCdQ8E9zfXtJJmW5FNur3hr4JMc2RfRpVbmDo+T8l8hAESTqEwaXVsLIimBHVNtF1jzR
 Wwk4d/1vCSM1fFi8J0+wj9t9vhsvw03+8FwEtDq5muU5yNeTwrYr70AfVAwA8rcVs6wA
 Eq5ZJfqt8FFJ3qArxS5vcxFHP6SieahBgMuHnzQ4llbsHiJ9Rxq8sSQvltbKNUhah+j+
 oSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609425; x=1696214225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEpfVHQYJiHs/o3VXa4xKMUM5FKYuciwQMorXR+KT/8=;
 b=sNlGbXsQYy+5A8u1I4zXUG4HDjAyi5SqSAqTJXt0voZ1ZvjAODiF0onc/DyTkktKtj
 k0deHkgX01pakXc4K1i8NOXBIuE1z5PVuyjci2tT1yJUsSK9gRXhRJX7LBvSICunANqt
 33ZrSiiOvVu4QIrFHWNbIhiSKC+is1HpCaQNEwisMxlVD2pRSBFhSfDgoPIGyZ8M3fmy
 k42lkIozVw4NGcq08JbyFwQOJ9jmF4ex4C8Q6qowvrvmiAmWtp3Cshbe/uDJDn2UFBd9
 oP7sAFJk8eePJ6uITsBKUUTVVLiXC938l2z3HsbvEbC4bsp4KE0xqDBR4Gby2jsyeY48
 zTRQ==
X-Gm-Message-State: AOJu0YyP63O+eWeyoncinBzI7dCnJgYUeI+muuWh44xoz327DZCneFPn
 3GLUI4/32xpZ3zRI6c6Df36dSJkU0DM=
X-Google-Smtp-Source: AGHT+IFsC63pJBepY4CjQ7kqGZsNvkxk8CkBncfJHqnk0ltvZ03W2j8c9clsyXn1fJFYVSNZZ8fGvw==
X-Received: by 2002:adf:ec41:0:b0:319:67ac:4191 with SMTP id
 w1-20020adfec41000000b0031967ac4191mr4558157wrn.37.1695609425578; 
 Sun, 24 Sep 2023 19:37:05 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:37:05 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 28/28] bsd-user: Implement pdfork(2) system call.
Date: Mon, 25 Sep 2023 00:01:36 +0300
Message-ID: <20230924210136.11966-29-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 0a3cd0ef57..d641878034 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -258,4 +258,36 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
 
 }
 
+/* pdfork(2) */
+static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
+        abi_long flags)
+{
+    abi_long ret;
+    abi_ulong child_flag;
+    int fd;
+
+    fork_start();
+    ret = pdfork(&fd, flags);
+    if (ret == 0) {
+        /* child */
+        child_flag = 1;
+        target_cpu_clone_regs(cpu_env, 0);
+    } else {
+        /* parent */
+        child_flag = 0;
+        if (put_user_s32(fd, target_fdp)) {
+            return -TARGET_EFAULT;
+        }
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
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 4c4e773d1d..d04712f0a7 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -238,6 +238,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_rfork(cpu_env, arg1);
         break;
 
+    case TARGET_FREEBSD_NR_pdfork: /* pdfork(2) */
+        ret = do_freebsd_pdfork(cpu_env, arg1, arg2);
+        break;
+
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
         ret = do_freebsd_execve(arg1, arg2, arg3);
         break;
-- 
2.42.0


