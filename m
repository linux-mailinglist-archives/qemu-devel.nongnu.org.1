Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0437A3DF6
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:42:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUs-0004er-E2; Sun, 17 Sep 2023 17:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUq-0004dx-GU
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:40:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUn-0004KL-J7
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:40:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40434d284f7so40367785e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986800; x=1695591600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szw1D363NLaMzZ2nlSVnjBnf+JZRVRfS7yebtBMdM4M=;
 b=P8RimxH4z2uoHAy1VT75+HOpPchEgzmqb24USh4tv4UGja+txlXsIIremkKdRfPREb
 T/4ixt8+2FjXO+OlGTb0f/hu/Wmg5r3pNUBmvoJGx2N27I8nI2kJhzQnkyOFCbCbh0Pl
 KuxyIR0c/1F+srGGVncpweJhRXe0t0WFfvb3/Imfx9g+nVeJPJcEXsCjdRrAVGdzy886
 NgKSEbCAgYMaFqI2+P220Kq8RELDFK8qZRuTK6oVPDC3SWmB8Lpsd2cTQoBL4dudKnbi
 LRDfC2Klmhld6Fis7y0gjnx8mp77dm/Lwckv5z1tWlwauV8WfNOX+rfDgegitMLUkZa4
 kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986800; x=1695591600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=szw1D363NLaMzZ2nlSVnjBnf+JZRVRfS7yebtBMdM4M=;
 b=S8UlmyJIxnjoQeX2gTxVZ7upjmUumAVocrPcARDQHvKjYilsN2nLnarZ2l9WCd/lrK
 My2GFUSC8yN0svx8v95rM23wjNGypFZP2cFYKaXbelMkIx6awKA8S38oiMMOKgavr+ZY
 0OjBwm7vzY9AnydOgnx4vNQG4kMN9lzgvlPqJXbPWt12TNinK2bEA3zKoVwJ5sE1d5JN
 NqaWCjv3izE34VDtWr+UtwGo9iZq07eZ/owg+feqgDDH7nBJcsvcnrjGt5hkvfHIALgK
 YWOnmH1HNhjFWy1SF+9BWjyPZ1EzHljL482HIib2poDqS1cWj8UuUcD66CxyVdolxcV6
 V1ig==
X-Gm-Message-State: AOJu0Yy3twSEpS9BvbSEAkFtsakse9ubmedK2E/VZvHJ4dJJViSjY26S
 UtMRrx3opPK+xisEEUSmqSIRNkZ2Bus=
X-Google-Smtp-Source: AGHT+IEBlc6rJN//1+hAPNfBWPD8SgJWd3dW7vdgeSqMBV4ujjGkEp2ODBZW5oP9OeIE5iynVNgR0w==
X-Received: by 2002:a05:600c:ac5:b0:402:bbe3:827c with SMTP id
 c5-20020a05600c0ac500b00402bbe3827cmr6555673wmr.31.1694986799936; 
 Sun, 17 Sep 2023 14:39:59 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:59 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 28/28] bsd-user: Implement pdfork(2) system call.
Date: Mon, 18 Sep 2023 00:38:03 +0300
Message-ID: <20230917213803.20683-29-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index a406ef7db8..563bac8818 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -251,4 +251,36 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
 
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


