Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B447A3DFA
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:42:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUq-0004dq-QR; Sun, 17 Sep 2023 17:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUn-0004cZ-7E
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:40:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUk-0004Jv-DV
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32001d16a14so1218684f8f.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986797; x=1695591597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JgC3jMOFItmqfccCsYXb/PVYrME+XvZhR9KVu34CAU=;
 b=bJxmezm3cVG+QmOsrBBcIrrVnKCONWPulKQR6UcBRSLvwOZ+8z3Svu3vZzHsZX8dYA
 KRkTjpSq31C7y9xYt9Pv+TM2A6vHLmRf4RQFlLgzfs5RJbXsoKAhlqaJQANWk1JZLO0Y
 nckRRNZKf/0wFwDvo4bOUOgZMu6FWc1caODNxpMqwrjptlrbZZF68mjNH4yelMbYNQ+7
 C/g/tSEg2Y2buNHUbOfg38BBgzmvtJx+zVWUH51oxOT5jAwIfoAJhOQzmT44Q9G3ZO5g
 VtsLz1iHxAB9mcmw6T+HLYYoiIpAl0BV4C/fytACjX/l0WMVn3Wm2k5n1qLK33NGoEy5
 mo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986797; x=1695591597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JgC3jMOFItmqfccCsYXb/PVYrME+XvZhR9KVu34CAU=;
 b=PULT49szHUR5g1zpyXsg3tDecVxdfGvG2xANznYJTAuM36KO5MzYgaS6AmBKDYo+lC
 oZaOG66kaM50t4R8JdfltcdXgSGQrTu9ZG5reRsm4T16JWlZz64ZtIIf7RXc09vAfFPJ
 idQZiMGcl0Tec08UJmvy9D9hg4gIXBQO/2Ozi40N6KOVKWmnoN8/vFJHk4gA+1DDDR07
 SllyN03AIm+ggF5HEAlf5v6NpFgGJ7bj+tHArssQsvNB7EBgTDQy5TMDhPDBkoUKpysw
 NZOTrE2PslW4o8uzmR3qOTk0ez7F3TB5tolXaggaGLR2GJV1aNQdSC4zB5bLQzcA7Agc
 s0RQ==
X-Gm-Message-State: AOJu0Yw1PQHB5tcjrZcxNsxJVRSTSz6JEdgvanU8IJU/RfhH4F0Qa7ig
 KZ0BPmgIleFqgzj+cxzGp9SkCDSrmSg=
X-Google-Smtp-Source: AGHT+IG6fo/Ez1xkwekNSbjK9+ZyjZzKF8pcED9NQH4M+zUBmGNjTdI4rjh6nR6wqEX0nBdBbFk8pg==
X-Received: by 2002:a5d:62c6:0:b0:31c:6420:fff with SMTP id
 o6-20020a5d62c6000000b0031c64200fffmr6144973wrv.62.1694986796662; 
 Sun, 17 Sep 2023 14:39:56 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:56 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 25/28] bsd-user: Implement pdgetpid(2) and the undocumented
 setugid.
Date: Mon, 18 Sep 2023 00:38:00 +0300
Message-ID: <20230917213803.20683-26-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 1866f0b2d6..47bcdcf8a3 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -34,6 +34,8 @@ pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage *rusage);
 pid_t safe_wait6(idtype_t idtype, id_t id, int *status, int options,
     struct __wrusage *wrusage, siginfo_t *infop);
 
+extern int __setugid(int flag);
+
 /* execve(2) */
 static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong argp,
         abi_ulong envp)
@@ -155,4 +157,25 @@ static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
     return ret;
 }
 
+/* pdgetpid(2) */
+static inline abi_long do_freebsd_pdgetpid(abi_long fd, abi_ulong target_pidp)
+{
+    abi_long ret;
+    pid_t pid;
+
+    ret = get_errno(pdgetpid(fd, &pid));
+    if (!is_error(ret)) {
+        if (put_user_u32(pid, target_pidp)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* undocumented __setugid */
+static inline abi_long do_freebsd___setugid(abi_long arg1)
+{
+    return get_errno(__setugid(arg1));
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index d614409e69..99af0f6b15 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -383,6 +383,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_getloginclass(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_pdgetpid: /* pdgetpid(2) */
+        ret = do_freebsd_pdgetpid(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___setugid: /* undocumented */
+        ret = do_freebsd___setugid(arg1);
+        break;
+
     case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
         ret = do_bsd_utrace(arg1, arg2);
         break;
-- 
2.42.0


