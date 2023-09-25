Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 876CE7ADEBA
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHy-0001R3-VN; Mon, 25 Sep 2023 14:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHu-0001OY-R9
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHt-0007Sz-C4
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-405497850dbso51113895e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666388; x=1696271188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEpfVHQYJiHs/o3VXa4xKMUM5FKYuciwQMorXR+KT/8=;
 b=aKhi0QAG4tG261DmFLKRxaQayxq2/6eenTYcaaArYL6C2WErMj4tApV21ctFotjp5z
 jVIaZ9br6wAlUGOpHPlEVXfF9XKlTmVOJGhg9YXu6+jXjqM1jU1pomZo1HcflG7FkUA+
 6JzpW/h5FVYTbiTqsYZx2QbsvUtVYwgF3A/Zw/V4vabhen43JRolHiHEv+T3HqxVqbFM
 PYRXC5xPtPKJcnnde38QYMalMeshJ3nercoFgXAOGkLt5vU1Vx03ZRNJ8/z0l+5LGUMX
 9Hl6QGOnz2TaR9feZLYivzgQD/HHXwkpsKVVTSvpSN2zcGbKhwevdoeEpBEVA/tAPcw1
 R/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666388; x=1696271188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEpfVHQYJiHs/o3VXa4xKMUM5FKYuciwQMorXR+KT/8=;
 b=D2Es86lICNOla8w+3AVbiU2pTrIwx3aSE2G46KqzZR5irRHrHjuyluLxmucbtjhb1f
 BfBJl4JPfTCJ2DouQBF6gbSvPq60X6Ue2iW0cQujmGvT9qg9SuitgsIIX8MdPEhjtado
 HqmcdfsqAgsidAZTWV3Kuwz+phgi+l++5LWwYXEwQToxed9OL6kLrXF9B915tLD3gY/f
 neEdGBva+6DWT6xi7TgnutnC8UVXi2zA20gSHcUp3gMV9LpvKSYi+SB7CDvBojyhT83J
 bo2qIeu90Q7B+OaZSBOchUdhfnpQLoN7lp/tF7ukJtxjNpYj1bmf7kaFLBLzEunU+fHq
 vTZA==
X-Gm-Message-State: AOJu0YwLzNqmbFakqO9QPcXLFCWPNbh4xYrInX37EC3maaBgJD0nf21Y
 gqOHY7cT/6MzUDzq2d6Z4TzSaKqRnus=
X-Google-Smtp-Source: AGHT+IGLmlvUt9EqS8k4MlaUcLuFmVRb6plx4ex5f/4yxJ8YsiBUpsNK6jiEj24XyEPraiMk/7niCw==
X-Received: by 2002:a05:600c:3658:b0:405:1bfb:ff14 with SMTP id
 y24-20020a05600c365800b004051bfbff14mr7379331wmq.9.1695666387606; 
 Mon, 25 Sep 2023 11:26:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:27 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 28/28] bsd-user: Implement pdfork(2) system call.
Date: Mon, 25 Sep 2023 21:24:25 +0300
Message-ID: <20230925182425.3163-29-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
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


