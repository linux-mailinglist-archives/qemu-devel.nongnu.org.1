Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F29857ADECB
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:32:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHx-0001P6-5P; Mon, 25 Sep 2023 14:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHs-0001OD-JH
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHq-0007S1-Uc
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40537481094so69792035e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666384; x=1696271184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ui1+qIKrTBmzcr3qsqV9UD7vfUvAao2pDCb7RttOZ4I=;
 b=W6oJHPFOIuphTNRhXbhRLTofCTATYEcIGvW+6i+on63Na3ryUODozVBp4chHtANES6
 wLfFjpHyIUkQfoLEOHgFDKejUipKCgnx2Nf9yngvcJQM9u90x0mDYCBKiWTp6Z0E0AM1
 UUozN8h3WzDCvZf6wLzXyg31t5+SBFeaMr/246sf1U5oe3glhOKd5a/+KkU2hh4JprA7
 4VjCScWPk4vIG/q0F7Sma7c+6EwVKLZBkndx3MN0bYcnscpa+aNrwu9pYVGN5hgqxSDo
 pD26OXkuURo3cAqKZj9gDhdr6kJdXCK/hZ8vuNZEgQsPu1tfHBm/caMNDJZMbe0RardY
 3FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666384; x=1696271184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ui1+qIKrTBmzcr3qsqV9UD7vfUvAao2pDCb7RttOZ4I=;
 b=humkFKIvRp7Y2wFPwsuIJ3UbU9dlfVHMuQuKkprekZFLQrLULiMemi0ixGcaCPxs0i
 H7444jCZLnwg173pasjllDWJUC0PHp4ngI4q5ypo1yF8aCciNdbS+GPoXgn5ULzYaZDm
 p7pwho4rcSrttDEgM0n3MtUF483ioQkM8XMz4V0K5SHPTnN9Mep3Oa0+aL0mRuURaa/O
 Rf2gSZkU1nT9crznv8vunr7KE7mgK4d5Uorb6H3qpVd49LhnWoeEkpwzzn5iY1N4IUSZ
 PwOxst8OmVZlAiqhHuc/F11gFRv/Z9wjU4waPsJL0nva9Dvi9X24yf/2SMXaQgogOQ+4
 2E8A==
X-Gm-Message-State: AOJu0YwlJ2w5tmUEpQGyGKuC4s5gMCbW7A3v9ZOibmC/GiHmrv/mQlZJ
 L715lz8WCKSgjavJPHRxScU4Zq+iWZ4=
X-Google-Smtp-Source: AGHT+IFC1k4RisdKNAi8Fa2MlLPSFM9sBnMRLYrZo0iO1eb0YGsCjYqjF2yW/2IvQ8LEynV+X/Pwlw==
X-Received: by 2002:a7b:c847:0:b0:401:b652:b6cf with SMTP id
 c7-20020a7bc847000000b00401b652b6cfmr6969590wml.13.1695666383698; 
 Mon, 25 Sep 2023 11:26:23 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:23 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 25/28] bsd-user: Implement pdgetpid(2) and the undocumented
 setugid.
Date: Mon, 25 Sep 2023 21:24:22 +0300
Message-ID: <20230925182425.3163-26-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 2eaba141dc..42bdd61904 100644
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
@@ -162,4 +164,25 @@ static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
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
+    return -TARGET_ENOSYS;
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


