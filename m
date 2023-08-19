Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 971CC78189E
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIaL-0000Dz-41; Sat, 19 Aug 2023 05:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaH-0008Ro-Sq
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIaE-0004Rk-KL
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fee843b44cso29195e9.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438565; x=1693043365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+L871gKAezQf99S6rDk0v5Re5KqfhLUHH5G1ZAfQZk=;
 b=Av6vigx+KhDMujQLINPh9xBjPQ2ERsN4A/AEaekoKRWRAKFP+n+dm/ZCz5yPUaEujN
 XJHtown2Uk5KXAo6Jf/xlLZaCk9oTAEiCBwMGhY9aNQPLBAGmbCUWhIe3s9fkrDZe/4z
 RzQFx4+Id1CuIOBrGGKrbpQ1XE8vmbF/1La1sdWs/uGt7vQZkPYe59ja7+T+/+fzhaHQ
 h/Qiyo5AoZ17Sqiz2qhg+rek/C2Z9x+IvQkGqni7SiVhCZYGq2RT+TB6EV0hngsTLrMc
 pCk9FV41BtcOK7MZ8GgS4xxQjoV/vOZsTfCVpR5zxwucm6bhCic7IvN19VMXztBbLg09
 sThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438565; x=1693043365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+L871gKAezQf99S6rDk0v5Re5KqfhLUHH5G1ZAfQZk=;
 b=Dvx4nz7eSlOsF9L73jBTeMUdeSf6CU15iYmB0Sza9fl+ka/bYWFTvTvjHjYbcWJYDa
 728XR6jryVKshTITYkYKzG0AgRB/e6LvTWMmX/6DIUQR4GGoINoZDfl95u/DMvxTHoYO
 ozh6n2W7cpzlqU65mxx5Spkb62C+UW11v4OX61JFES5k0BMaXui80AoDVtXc8VrCxG9n
 8NDmc2R8XAFrWPRsGLnHq2R6hSCjqVrD0fehiBlVYW3NV6kTzbvbFNCMAoWhI+YCSQFg
 5tny0ReP3gZFVc9MyJ7zKKVqzK9YrRNsD0LDcQSExkerFK47CL7ILgts2Ybb6IlLl3n/
 /0Zw==
X-Gm-Message-State: AOJu0YxpPBKxxAcC0AJPHY77BBT0urLtTxNZ5lpQ072qajHE24zcdIxl
 KxSNbC5YVjTIi6qVlUYSg91O4/pRavs=
X-Google-Smtp-Source: AGHT+IGK0et7uEpkrKTyHHZce2lZIM+rqeC64c4woAvSS1qeK+BBeSiOVgPpZI4M+TG3ZmHS1M5KJQ==
X-Received: by 2002:a05:600c:2193:b0:3f7:3991:e12e with SMTP id
 e19-20020a05600c219300b003f73991e12emr1203551wme.1.1692438564552; 
 Sat, 19 Aug 2023 02:49:24 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:24 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 16/22] Implement mincore(2)
Date: Sat, 19 Aug 2023 11:48:00 +0200
Message-Id: <20230819094806.14965-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f76881519c..edbccd3111 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -144,4 +144,27 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
     return get_errno(minherit(g2h_untagged(addr), len, inherit));
 }
 
+/* mincore(2) */
+static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
+        abi_ulong target_vec)
+{
+    abi_long ret;
+    void *p, *a;
+
+    a = lock_user(VERIFY_WRITE, target_addr, len, 0);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+    p = lock_user_string(target_vec);
+    if (p == NULL) {
+        unlock_user(a, target_addr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mincore(a, len, p));
+    unlock_user(p, target_vec, ret);
+    unlock_user(a, target_addr, 0);
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 96469f6a63..1db0907504 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -527,6 +527,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_minherit(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_mincore: /* mincore(2) */
+        ret = do_bsd_mincore(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.40.0


