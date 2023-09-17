Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FD67A3E6C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:25:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bv-0006ah-KH; Sun, 17 Sep 2023 18:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bt-0006aI-UU
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Br-0002xC-86
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-402c46c49f4so42357505e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989469; x=1695594269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGH2XqlCKs+v6ITttHKED17bHsAug7I+bG1RPQmNFlY=;
 b=LcXvvf+LmtYz47iTgOAEjQxJ7WRgb3ar9i4DOzggAmdpgwhufVHq1FFzLWHbEora5f
 8n37xFM1MqZs6wS8kE+ZGoq4YeE64sw604bHt2gh4UUffaA2FBcw1lvHY2uGlC8tg6cj
 nlns2Iq0Hg8ICFW8HOMMyux7O/tSsdWo3ew6f60dWz0FgTZN/Rcjidu0gdVmPoUwDYFe
 +U/IUO4UyurfrbfaDUxTx9sbQoa/RAZreJXPgpZTETcxzDChZqsrmbx7OmG1hP2LfySG
 Qfdlp410kBlypEI8/OkfG04iA/AP70Nd9Z3R6AC6EcBf+S5MD2d+a50P2jcKDTzGucHR
 aK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989469; x=1695594269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGH2XqlCKs+v6ITttHKED17bHsAug7I+bG1RPQmNFlY=;
 b=vUJkwE2fS7GIFEMtYKXDvVKsPLZw495qyDQhddgMHdm1AQTmKddKcGyCeprvE5uH+V
 xpe0EzQ3v/RXDNjNE7LMKWB1i7c4pOmgnoQUApRM8zycHi9HaknMaL4ajOap0r2WpCWj
 n9A8Ag5A8lzocYkmFqg+gTHEFApx+mJpzVNeoyT3zpguF17jDYnndTHkmZB3hbDEPTt6
 mEWu5HxWKAwXyIcJnHuR3sbFPFb8YEMvooKVGVAawn2sxk95/0W2a3OWkqqtdbu68C0n
 GYeohu01ugo0J72IqhMmZT/znPj9o3B1fx3XJPy2xGcIaZCHOHs6tm4B5CGLHe3L87tM
 FRMA==
X-Gm-Message-State: AOJu0YwAUOMPKSnsjZZ3SbxZCfo/CVJEyPhHSKF/pNtgfyuS2nYKTOq8
 7qV0eh765BZep+yS1hJTP2d2q37II2k=
X-Google-Smtp-Source: AGHT+IFsGu0vx0DjF1Rf3MlNa/mOJt4cu2OEhGIjBmqqD1SFxhVKbm24LAG1gFew9X21d1lGx6gKSA==
X-Received: by 2002:adf:ef90:0:b0:317:e515:d623 with SMTP id
 d16-20020adfef90000000b00317e515d623mr6225831wro.60.1694989469575; 
 Sun, 17 Sep 2023 15:24:29 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:29 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 18/28] bsd-user: Implement getpriority(2) and
 setpriority(2).
Date: Mon, 18 Sep 2023 01:22:35 +0300
Message-ID: <20230917222246.1921-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
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
---
 bsd-user/bsd-proc.h           | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index fff1d4cded..89792d26c6 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -390,4 +390,28 @@ static inline abi_long do_bsd_ptrace(abi_long arg1, abi_long arg2,
     return -TARGET_ENOSYS;
 }
 
+/* getpriority(2) */
+static inline abi_long do_bsd_getpriority(abi_long which, abi_long who)
+{
+    abi_long ret;
+    /*
+     * Note that negative values are valid for getpriority, so we must
+     * differentiate based on errno settings.
+     */
+    errno = 0;
+    ret = getpriority(which, who);
+    if (ret == -1 && errno != 0) {
+        return -host_to_target_errno(errno);
+    }
+
+    return ret;
+}
+
+/* setpriority(2) */
+static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
+                                          abi_long prio)
+{
+    return get_errno(setpriority(which, who, prio));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 1a760b1380..71a2657dd0 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -359,6 +359,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_ptrace(arg1, arg2, arg3, arg4);
         break;
 
+    case TARGET_FREEBSD_NR_getpriority: /* getpriority(2) */
+        ret = do_bsd_getpriority(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setpriority: /* setpriority(2) */
+        ret = do_bsd_setpriority(arg1, arg2, arg3);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


