Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F637B753E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:39:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovI-00047P-SA; Tue, 03 Oct 2023 19:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovG-00045h-Aw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:26 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovE-000719-M8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:26 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79fe6da0095so60241539f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376123; x=1696980923;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tN2OEe5rYzQGfb+nOOMon2seHs5SrR+EQ42mg0JPMFg=;
 b=oRtvZQN/ok44oUDkrKAQJLiElIfAAADDhzzQHhinGmjDVcDOz1VNHG63sshI4+c/B8
 T60vOK/eDdoOvHbtx53o2tnwamDtAGNMYWgTQFBDOOKdOXHw1OA3K2IuDXb/sQ4VJ+2L
 JKui/M9OzbLDyxtiDzfNmB8ADYp7Iv9wl3A6iAoNqGb9xh6O8fVHZpp5A9vz9JPXcnln
 YmU+nsdwK3rpuzVq9QTARHo1MbIxDSLLuj+zqrAJPTWfay+Z/C4HYCUY2o1PZVH18iFl
 f2E6fFrjwPNpTxFsrQyyOH8yZcsVlWMKzF2YXT4k/08bg48LG/jI5siSZ9VPjaJUxyo1
 Re0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376123; x=1696980923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tN2OEe5rYzQGfb+nOOMon2seHs5SrR+EQ42mg0JPMFg=;
 b=FJyGCu4/dkt+qF+k9W3vfrfoMMJTKgkt29RbhD3x98fZWzu6NhHJVBYd3wYy7avNvA
 +XVrNSCPSEsv1U8uxkhG+U2DYghsn4yK0ztwclzS26pR+Sg/Ku0OBwu3Mr9p4uLJWcOA
 8dwLQNt8ii0JxPS2qWyYOIbjvXIz62qo9H0ZNs9eijH2fGMH4M1pi1rxtxMHuiAPKS+t
 7lyYHBwJ7PjWnN53WXUVgEprd6c9/ucX+AnIKObMwSYq6eLE/sz03axyYh/MR/6g72DW
 k9R3C1gmYHy55XInBn8zNWWi5WlrwpXyqIYaEhjLpEul50UQ0z0vMwYXVV8YE1cEY43U
 hPFA==
X-Gm-Message-State: AOJu0YyO0rtMV/BZp9qrKA2Umx7L1OG3yBfbFX0SrBDVgU4A7OPNeSrE
 YaNT+dSZFo4J9vvqSc6GrO50zLU19YM0jgHhJIdLAA==
X-Google-Smtp-Source: AGHT+IGu73C870FKUKyG6qdiMQofMSs+XPxu0tSixF/UVsAwldP05qJ6CzVK6ArPBhsKGAqD3rpasw==
X-Received: by 2002:a05:6602:220e:b0:786:f352:e3d4 with SMTP id
 n14-20020a056602220e00b00786f352e3d4mr983515ion.7.1696376123392; 
 Tue, 03 Oct 2023 16:35:23 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 18/51] bsd-user: Implement getpriority(2) and setpriority(2).
Date: Tue,  3 Oct 2023 17:31:42 -0600
Message-ID: <20231003233215.95557-19-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d34;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd34.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-19-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 2c1a9ae22fa..9a8912361f6 100644
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
index 1a760b13808..71a2657dd0f 100644
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
2.41.0


