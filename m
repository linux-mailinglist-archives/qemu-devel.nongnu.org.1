Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF07A3E8A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:28:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bs-0006ZQ-3v; Sun, 17 Sep 2023 18:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bp-0006YE-H2
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bn-0002wR-9s
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32155a45957so144425f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989466; x=1695594266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82PM6u/NCtIDdzLUc80xbOvNf5qmXl4JA7JhjNThRVs=;
 b=OPo4bxzkmGSOfuMHoxGKlf2GAGy3El69JWdCv7np7RhSEMAjK1/lJcNXuJF2reI+BJ
 C6CPci+3FJb7uqWITkNoKDxIJp0XanRJmOYEJUXLTrsshYyHUAgN3l8oVQQ0kb65UO4S
 e6L+U329W/9RRXxTUsOYDLNYtmVFH14N3ehcNojzgzJJTGxhLzs/i+GjjbQ2q7NTWPSu
 MsWbhEJbzXC5HP88Lk5uRmFOEAJl6RZoAIBFXUCholGb09P7CCuwet4vxoWan69iHnei
 uHcn7Co1IhN6iF0t4AJ3vti36nACkECg2DD3IWftlEEyDNCdwYRu09BmQSJ6DerVxpmI
 Qf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989466; x=1695594266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82PM6u/NCtIDdzLUc80xbOvNf5qmXl4JA7JhjNThRVs=;
 b=MYPeIqv87FMQTtePHIk1V02xYEIjZAlyJP3itPcMwVDW0TxcsL+3ci8sCXZN+hJi2e
 GjOIYYY1h1dWjK7f7/UrHM+coXV+rA1OG4CpreT2tQkCZso4vcQX13/bPbIi5wclTyb+
 kQktt+QL3cyiUnMqeSCgRWM1d6qrEaxlRi3zq16ppqCcbewR4C0R1ofD5tgDuqbp4Ubr
 YtbDtk2s06jV/lsr1aTEBZQgehu1YggF5UJ7MGU9ZMzni/CVzqjON9ZAFq0+jfAhCdxK
 nTfCutHsw3zSFmRrEUl7aulYuDsNvOjoh7riMJRtYTnp8jydKqpkzikbhvIUTBgI5II1
 JJLg==
X-Gm-Message-State: AOJu0YxovNHLruZ+4kaUh9HxFaaNP0oVWQ52blONXSEQenQOCT4idpgF
 ag1VxGgI5SZrHwcNSs+cwKcH7cRMEJc=
X-Google-Smtp-Source: AGHT+IGfYxxosHoD2vx2v2QUjbe7uv1dBR/BLhfPuPutDRm6QwWtslXuDRMIPnuscBRqvVK+5Jdw7Q==
X-Received: by 2002:adf:e9c6:0:b0:317:5e73:7594 with SMTP id
 l6-20020adfe9c6000000b003175e737594mr5863349wrn.28.1694989465727; 
 Sun, 17 Sep 2023 15:24:25 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:25 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 15/28] bsd-user: Implement several get/set system calls:
Date: Mon, 18 Sep 2023 01:22:32 +0300
Message-ID: <20230917222246.1921-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42d.google.com
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

getpid(2), getppid(2), getpgrp(2)
setreuid(2), setregid(2)
getuid(2), geteuid(2), getgid(2), getegid(2), getpgid(2)
setuid(2), seteuid(2), setgid(2), setegid(2), setpgid(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-proc.h           | 90 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 60 +++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 06b5b9e03c..9709939337 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -196,4 +196,94 @@ static inline abi_long do_bsd_setrlimit(abi_long arg1, abi_ulong arg2)
     return ret;
 }
 
+/* getpid(2) */
+static inline abi_long do_bsd_getpid(void)
+{
+    return get_errno(getpid());
+}
+
+/* getppid(2) */
+static inline abi_long do_bsd_getppid(void)
+{
+    return get_errno(getppid());
+}
+
+/* getuid(2) */
+static inline abi_long do_bsd_getuid(void)
+{
+    return get_errno(getuid());
+}
+
+/* geteuid(2) */
+static inline abi_long do_bsd_geteuid(void)
+{
+    return get_errno(geteuid());
+}
+
+/* getgid(2) */
+static inline abi_long do_bsd_getgid(void)
+{
+    return get_errno(getgid());
+}
+
+/* getegid(2) */
+static inline abi_long do_bsd_getegid(void)
+{
+    return get_errno(getegid());
+}
+
+/* setuid(2) */
+static inline abi_long do_bsd_setuid(abi_long arg1)
+{
+    return get_errno(setuid(arg1));
+}
+
+/* seteuid(2) */
+static inline abi_long do_bsd_seteuid(abi_long arg1)
+{
+    return get_errno(seteuid(arg1));
+}
+
+/* setgid(2) */
+static inline abi_long do_bsd_setgid(abi_long arg1)
+{
+    return get_errno(setgid(arg1));
+}
+
+/* setegid(2) */
+static inline abi_long do_bsd_setegid(abi_long arg1)
+{
+    return get_errno(setegid(arg1));
+}
+
+/* getpgid(2) */
+static inline abi_long do_bsd_getpgid(pid_t pid)
+{
+    return get_errno(getpgid(pid));
+}
+
+/* setpgid(2) */
+static inline abi_long do_bsd_setpgid(int pid, int pgrp)
+{
+    return get_errno(setpgid(pid, pgrp));
+}
+
+/* getpgrp(2) */
+static inline abi_long do_bsd_getpgrp(void)
+{
+    return get_errno(getpgrp());
+}
+
+/* setreuid(2) */
+static inline abi_long do_bsd_setreuid(abi_long arg1, abi_long arg2)
+{
+    return get_errno(setreuid(arg1, arg2));
+}
+
+/* setregid(2) */
+static inline abi_long do_bsd_setregid(abi_long arg1, abi_long arg2)
+{
+    return get_errno(setregid(arg1, arg2));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5cb6086230..7565e69e76 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -255,6 +255,66 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_setrlimit(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getpid: /* getpid(2) */
+        ret = do_bsd_getpid();
+        break;
+
+    case TARGET_FREEBSD_NR_getppid: /* getppid(2) */
+        ret = do_bsd_getppid();
+        break;
+
+    case TARGET_FREEBSD_NR_getuid: /* getuid(2) */
+        ret = do_bsd_getuid();
+        break;
+
+    case TARGET_FREEBSD_NR_geteuid: /* geteuid(2) */
+        ret = do_bsd_geteuid();
+        break;
+
+    case TARGET_FREEBSD_NR_getgid: /* getgid(2) */
+        ret = do_bsd_getgid();
+        break;
+
+    case TARGET_FREEBSD_NR_getegid: /* getegid(2) */
+        ret = do_bsd_getegid();
+        break;
+
+    case TARGET_FREEBSD_NR_setuid: /* setuid(2) */
+        ret = do_bsd_setuid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_seteuid: /* seteuid(2) */
+        ret = do_bsd_seteuid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setgid: /* setgid(2) */
+        ret = do_bsd_setgid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setegid: /* setegid(2) */
+        ret = do_bsd_setegid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_getpgrp: /* getpgrp(2) */
+        ret = do_bsd_getpgrp();
+        break;
+
+    case TARGET_FREEBSD_NR_getpgid: /* getpgid(2) */
+         ret = do_bsd_getpgid(arg1);
+         break;
+
+    case TARGET_FREEBSD_NR_setpgid: /* setpgid(2) */
+         ret = do_bsd_setpgid(arg1, arg2);
+         break;
+
+    case TARGET_FREEBSD_NR_setreuid: /* setreuid(2) */
+        ret = do_bsd_setreuid(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setregid: /* setregid(2) */
+        ret = do_bsd_setregid(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


