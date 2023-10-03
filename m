Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D67B752D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovE-00042h-He; Tue, 03 Oct 2023 19:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovA-0003z2-9P
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:21 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov8-0006pv-Kk
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:20 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79fa416b7ffso60872039f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376117; x=1696980917;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAZ4CluLSnk0lLew81sItiili5rTiFhyUaEMqNMoRMs=;
 b=InlRV+GrrLWiwbT94sXnLHeuAce6qQAuuJ1yf25QtFQP6t5U4CbYbImR6bi+q8oaB7
 6wNeGppXW/p+CUvRV+M7eaton6tk3fNwkBm0J2SGRtI2sqIXm1dt8QEG3/uasDwh+pzA
 wARkKaoNhEKXY8aNNuiIctWd+ua27yTwwe78f8qT4w+iaGMJWPtF6S53CckLkTnmS0LI
 ZRGkDXHJb82bb3aFTnIX1gV98L+KMivpvmLkWa3MG/bBWFwwtsRP4bE2zzn4H9rMZfd3
 5BDCkBp5FQEp3uBk98154wWKTliiFp2rzPxXwziZIaLQCkgQJK1fpF/bUfyKPUVzRsH8
 l6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376117; x=1696980917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAZ4CluLSnk0lLew81sItiili5rTiFhyUaEMqNMoRMs=;
 b=JZsUSYzv+MLDLHGkEfDEBB5s5mndhATxijJY0rA09N11GQwSwHa6vBsc5GH1yCT4aR
 D9YmtRWjj8AuBiapix4Crhwt9yl1Vu7iaHDpCyEnjXdI1FVQBIjeKxW49Ac1nYdCKq6i
 w6N+ljhQ3F/aFVX6+yzxheuwZQaaS2FRrhiufv5adax26aiq0MyhV/YyZXdGQAekOpN2
 H/gf2iVpMKmlQbkEJfSs7qXsG7UfOM0YsEBNxlR5CrFH49M9+sWassFSBSAI60pgxY9i
 JHqHOQUhHA/8pGZHW3SQw+9ORk3mbxcqhbTvq9QbKiyUVFRgTOjAk7vhnNPv5MVnOLiK
 f7MQ==
X-Gm-Message-State: AOJu0YyV8bx0vbrR0sTwACvflIjl3YKl1+LA80wTVsAzJmxT2Y4DdRLW
 t67jCVKrTWJLgP1W+w1zKUi32gB4SE9c7A+7oapd3Q==
X-Google-Smtp-Source: AGHT+IF53ey32ANStuXRcWk9D8de1+JirYX4n7HCg5044cYeS2waK8s6bP9CkJIuMdnjKefApoJCpw==
X-Received: by 2002:a6b:ea15:0:b0:790:a010:4c42 with SMTP id
 m21-20020a6bea15000000b00790a0104c42mr1035876ioc.13.1696376117069; 
 Tue, 03 Oct 2023 16:35:17 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:16 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 11/51] bsd-user: Implement getgroups(2) and setgroups(2) system
 calls.
Date: Tue,  3 Oct 2023 17:31:35 -0600
Message-ID: <20231003233215.95557-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d31;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd31.google.com
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
Message-Id: <20230925182425.3163-12-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 44 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++
 2 files changed, 53 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index b6225e520ea..7b25aa19829 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -41,4 +41,48 @@ static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
     return 0;
 }
 
+/* getgroups(2) */
+static inline abi_long do_bsd_getgroups(abi_long gidsetsize, abi_long arg2)
+{
+    abi_long ret;
+    uint32_t *target_grouplist;
+    g_autofree gid_t *grouplist;
+    int i;
+
+    grouplist = g_try_new(gid_t, gidsetsize);
+    ret = get_errno(getgroups(gidsetsize, grouplist));
+    if (gidsetsize != 0) {
+        if (!is_error(ret)) {
+            target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 2, 0);
+            if (!target_grouplist) {
+                return -TARGET_EFAULT;
+            }
+            for (i = 0; i < ret; i++) {
+                target_grouplist[i] = tswap32(grouplist[i]);
+            }
+            unlock_user(target_grouplist, arg2, gidsetsize * 2);
+        }
+    }
+    return ret;
+}
+
+/* setgroups(2) */
+static inline abi_long do_bsd_setgroups(abi_long gidsetsize, abi_long arg2)
+{
+    uint32_t *target_grouplist;
+    g_autofree gid_t *grouplist;
+    int i;
+
+    grouplist = g_try_new(gid_t, gidsetsize);
+    target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 2, 1);
+    if (!target_grouplist) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < gidsetsize; i++) {
+        grouplist[i] = tswap32(target_grouplist[i]);
+    }
+    unlock_user(target_grouplist, arg2, 0);
+    return get_errno(setgroups(gidsetsize, grouplist));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index fa60df529ef..535e6287bde 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -223,6 +223,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_exit(cpu_env, arg1);
         break;
 
+    case TARGET_FREEBSD_NR_getgroups: /* getgroups(2) */
+        ret = do_bsd_getgroups(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setgroups: /* setgroups(2) */
+        ret = do_bsd_setgroups(arg1, arg2);
+        break;
+
+
         /*
          * File system calls.
          */
-- 
2.41.0


