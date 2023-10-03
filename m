Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2457B7545
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovQ-0004Bl-Nv; Tue, 03 Oct 2023 19:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovN-0004AL-BN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:33 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovL-0007DD-0k
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:33 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7a2a9e5451bso58465439f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376130; x=1696980930;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXNCT8uVBORK7tv8PpGRtzJSxuc5NgZcrHLSenHKxTc=;
 b=WL6lpS0aIoRyLXEm7Lu0on0wHlPAc+Dm77ZvispNHchVMrwy621OqwN7XRPa0PjjlR
 80YYLvECD442JHl0EcP67+DTK4kEKhC5Mrs6faYZeLFfg9Ya4iNbZmZpkCrgAwKzgdW5
 RqtDPhRMU4A02UynGT3rGRkxTcnwrw+CWKHrwf+Bumh7gZPJy3s985TG2Q7sFcXAgJwY
 Sy6YZIRceYA5LlUqTned37gw3f5L2+iKuYTTp8HLXkJBN31Mv97IihUKZUAH2WVl9+Im
 2sjreC5Gij+dpU3XHmbpf1gkcz84rjZN7xltw0iy3HI+XflKIQiSXnNi/MTbB9VoNS6e
 qxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376130; x=1696980930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXNCT8uVBORK7tv8PpGRtzJSxuc5NgZcrHLSenHKxTc=;
 b=Jszaua+0rwTB0XjlR14h8FWLzAxJiTZKdrjaS1J5zcRODct0XDLXGEu1vHCBqdiGVE
 r/gLJ1lEN0mnZpZb4B6JzHY6CUuxTzMQBYd81JMk9MtDO3gPbtaBgSdSLiPAA1cpfgvx
 de3oupqifNs0ZjN3hKlTwkQP5zfaqUmbJ9GsuNDaQ5k0nkuU+DVrxOLaUl3yoAmbPakF
 3BzJGY45aqtYSWlphqVNWRwH71U2bsq9JkPfYsZgfiLBASkAMqQeVDiMcGsHbOgbcRck
 W7Cn366BMkFVTOaHc4J79O0txcMB80YtujlfqfgG7VyGERn3KcVbuUoGrhK0piK9uZJ+
 50JQ==
X-Gm-Message-State: AOJu0Yx9l1q/q7tDM9Q2UEpPXPzn0bcBFTbw9LlTaesiVB6m3sFXU/1S
 nhdl89Bq5yh8Uhdic3sXm2Lzxt7kR3FH3t26tq8ytA==
X-Google-Smtp-Source: AGHT+IGcgKaQM5/o72V5tJG92Oz0a/1MC4XmMh29lPgmGK8By8b5Z1IU1/Yp1y3uJhNHaAcX69F7tQ==
X-Received: by 2002:a6b:e31a:0:b0:791:acd7:233f with SMTP id
 u26-20020a6be31a000000b00791acd7233fmr724023ioc.15.1696376129726; 
 Tue, 03 Oct 2023 16:35:29 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/51] bsd-user: Implement pdgetpid(2) and the undocumented
 setugid.
Date: Tue,  3 Oct 2023 17:31:49 -0600
Message-ID: <20231003233215.95557-26-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20230925182425.3163-26-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 2eaba141dcd..42bdd61904b 100644
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
index d614409e694..99af0f6b156 100644
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
2.41.0


