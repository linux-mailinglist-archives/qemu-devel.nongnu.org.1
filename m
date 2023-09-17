Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D487A3E7D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bj-0006WN-9H; Sun, 17 Sep 2023 18:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bg-0006Uh-IG
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Be-0002v4-VT
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40434d284f7so40603095e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989457; x=1695594257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HB1r6vri6wZU6JRWVjYo0sYtxx/vxZGkhUe0qob/CIg=;
 b=HVO+od+YHIqeqL+K9uvvu8fHfmUlH2JT3lmYm7X6OxRVof5sSIaWQQE1X5r/KqWIoO
 fO0eel5urOgstgIeB1FEZc8qfsbKHPvj/7gZ0rNZ8uTi8GUlFtfnq2rwoLlIbBnRHqnd
 JYw2R5u2PrZ84U97aHM1etfYA84FGjobQzKH9/Ciu2FFNZrf0iVhRFnsq/5ESmAyFPyr
 B9cRo699bLeEMGD+RkAzoa94YK6WVI7netQ7XngHUmRV3cc3CBD3JrsJKfwvt0ybAgo8
 1RZolcL0KHW5UrLsOKj7dCDewDOfUoCzCGdYFlqnkJY2UnivdciAQmR0yWkJ/GIFt5mC
 DjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989457; x=1695594257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HB1r6vri6wZU6JRWVjYo0sYtxx/vxZGkhUe0qob/CIg=;
 b=re6xiNTGsEqvYTJzqsqsGtTJkDlhiuyzOubJGQSg7U5mAlQHcrTsYZ7AsfS6H0/T1e
 e6vKGFY0pLOOHpj0AW8ODXLJa57K0YF2fvrEbBODPa7fgzP+0EGUM5kv6nxohu+vue+5
 ZHC1R2ng1KUz2NXvROX7jP4R0+sPN9dkYsnQ6IVOt9WFvQ0NzXaRAgh+lnOuGZ24rWAj
 Lrj/AjJYtwEi6gSyWTMzfYBIUqxqwEjFu5yGpAo5JUOo2xC4hdSBhLsmNoqXwDzO2jq+
 VJbBBtx8H17HNa6h6FUECeguzIJ0/16ye70TOM0LXnvqBOF6dVIVPy1ZwDZFEe5PTiyi
 pQHw==
X-Gm-Message-State: AOJu0Yz1SCaBdjfviLE6qMt/aGAhseW5FmI5CwgtlFdhHgobor+BfMk9
 p8zpjTZdkXUzjqCGDu6u/qQZFxPYdBU=
X-Google-Smtp-Source: AGHT+IHS2Vr1b0i/4X2ZCA5GdcRhy93Nd8fzBsdsnp3Fc7xbTlqD5W5sfy/i0PAnDt0fwBr9Xd0sWA==
X-Received: by 2002:a05:6000:38e:b0:31f:fdd8:7d56 with SMTP id
 u14-20020a056000038e00b0031ffdd87d56mr4943623wrf.12.1694989456886; 
 Sun, 17 Sep 2023 15:24:16 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:16 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 08/28] bsd-user: Implement host_to_target_rusage and
 host_to_target_wrusage.
Date: Mon, 18 Sep 2023 01:22:25 +0300
Message-ID: <20230917222246.1921-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-proc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 19e39a2f76..aa386ff482 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -48,3 +48,57 @@ abi_llong host_to_target_rlim(rlim_t rlim)
     return tswap64(rlim);
 }
 
+void h2g_rusage(const struct rusage *rusage,
+                struct target_freebsd_rusage *target_rusage)
+{
+    __put_user(rusage->ru_utime.tv_sec, &target_rusage->ru_utime.tv_sec);
+    __put_user(rusage->ru_utime.tv_usec, &target_rusage->ru_utime.tv_usec);
+
+    __put_user(rusage->ru_stime.tv_sec, &target_rusage->ru_stime.tv_sec);
+    __put_user(rusage->ru_stime.tv_usec, &target_rusage->ru_stime.tv_usec);
+
+    __put_user(rusage->ru_maxrss, &target_rusage->ru_maxrss);
+    __put_user(rusage->ru_idrss, &target_rusage->ru_idrss);
+    __put_user(rusage->ru_idrss, &target_rusage->ru_idrss);
+    __put_user(rusage->ru_isrss, &target_rusage->ru_isrss);
+    __put_user(rusage->ru_minflt, &target_rusage->ru_minflt);
+    __put_user(rusage->ru_majflt, &target_rusage->ru_majflt);
+    __put_user(rusage->ru_nswap, &target_rusage->ru_nswap);
+    __put_user(rusage->ru_inblock, &target_rusage->ru_inblock);
+    __put_user(rusage->ru_oublock, &target_rusage->ru_oublock);
+    __put_user(rusage->ru_msgsnd, &target_rusage->ru_msgsnd);
+    __put_user(rusage->ru_msgrcv, &target_rusage->ru_msgrcv);
+    __put_user(rusage->ru_nsignals, &target_rusage->ru_nsignals);
+    __put_user(rusage->ru_nvcsw, &target_rusage->ru_nvcsw);
+    __put_user(rusage->ru_nivcsw, &target_rusage->ru_nivcsw);
+}
+
+abi_long host_to_target_rusage(abi_ulong target_addr,
+        const struct rusage *rusage)
+{
+    struct target_freebsd_rusage *target_rusage;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_rusage, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    h2g_rusage(rusage, target_rusage);
+    unlock_user_struct(target_rusage, target_addr, 1);
+
+    return 0;
+}
+
+abi_long host_to_target_wrusage(abi_ulong target_addr,
+                                const struct __wrusage *wrusage)
+{
+    struct target_freebsd__wrusage *target_wrusage;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_wrusage, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    h2g_rusage(&wrusage->wru_self, &target_wrusage->wru_self);
+    h2g_rusage(&wrusage->wru_children, &target_wrusage->wru_children);
+    unlock_user_struct(target_wrusage, target_addr, 1);
+
+    return 0;
+}
+
-- 
2.42.0


