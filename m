Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B037A3DE2
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUU-0004Wp-0D; Sun, 17 Sep 2023 17:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUS-0004W1-CT
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUQ-0004Fk-ON
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32008e339adso940032f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986777; x=1695591577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HB1r6vri6wZU6JRWVjYo0sYtxx/vxZGkhUe0qob/CIg=;
 b=R2SMevOZv27Gvn2rHho2LD/ac/ZXiBFTDPmmTu2MWfiO6fbbFjLb6Zq1zhlL+hesXm
 x90YP4UmwwPYn4XUXIh4Z+jgmWqyCjumvY0lXaGKIHwi5SduJu2PN/uFDwL1m1DCWzpn
 oGYH4ZGB5OVh0iPctziHTyqM5VfGld2Hj2w5DnOd5CAX7V7lJ/AcOJtkYIytHW0VD1qX
 y+8Io8QFRaMWYIteqnYUtMfdUyF3G4+Qod2fWm+gh9flzIHCYKGeE+cFWqPZX3EDr7LN
 /HoRyhyQhJYb+WMekTo0vJ499GsSLqvIoW8fodQFSZ+lOp0anRPozKedC2WYnmaPVeE8
 Nwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986777; x=1695591577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HB1r6vri6wZU6JRWVjYo0sYtxx/vxZGkhUe0qob/CIg=;
 b=n+hQDTGHfsWO8YTF2H2pBVE8TkWPV5VbBbO0AVoW/w0Wp8ugP+q3Sb61Qt3RWR5gHQ
 7Z8h6XTKdJ8iqRdpYjKFqDD5XlkJECFLZQRbfcAWjGkNYdbb/dh5LS29ZOsEPLOE347r
 QCPud2ubkUFAsVSH3aTGi1f0iD7ulacfp8/GhSOho9FvZRUf6c9vQre4y81VPX3FINnN
 SAVTcncJ2ZDDZuXukLekyZMm1EYisMgKgtauKX1DGBhA1ODmKPgN0A7T89xVFh3xyoZ/
 S4YMAUZc59NMgS6U3jo7hNtxGumE/VGmAdMCGi+m2NgYZRQ09h6dUHfO4Rr9yoMY1llT
 hmlQ==
X-Gm-Message-State: AOJu0YxjVLnHRy6tgqZBNaSb7qptuy31oAQKjlEqRnis1JTOPMCP1DkW
 JZK2E9D7JvQePeB8fjf6ZKIajqFqfyQ=
X-Google-Smtp-Source: AGHT+IFZCj8rCHwjzuNAzBVr/0YIL35ldtP6tOpPdGHPrZKJaN/uveIuYZ6PQB3x5ZP0Ad/JGJKF1A==
X-Received: by 2002:a5d:4209:0:b0:31f:ef77:67e8 with SMTP id
 n9-20020a5d4209000000b0031fef7767e8mr4689613wrq.13.1694986776710; 
 Sun, 17 Sep 2023 14:39:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:36 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 08/28] bsd-user: Implement host_to_target_rusage and
 host_to_target_wrusage.
Date: Mon, 18 Sep 2023 00:37:43 +0300
Message-ID: <20230917213803.20683-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
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


