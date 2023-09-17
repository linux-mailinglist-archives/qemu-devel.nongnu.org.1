Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF267A3E7A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Br-0006YY-05; Sun, 17 Sep 2023 18:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bp-0006Y7-9W
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bm-0002wK-Hz
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:29 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso3445819f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989464; x=1695594264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLdkkdZEPKyUic0lLlf7pM01ehziiit06d6Q+F/iamk=;
 b=IA+kC3UBs/zn5cuLYV4iN8GBSD++tAjFQx8JH6b5E4AXh2nM/GziKXd651ZweO2485
 Rg1sWk5ncvjeAACCTmKqhuCMd1RG+nA/yDOeRpIw9sy2N0yFmoFjL/9SRT/X2rMYkcVr
 r1iYAzuXGOCfc0ZlBuFE0o3RmKeXmw9IiEgf4iLWaijk/GOv2UYBCNbNt2EA84G+NITs
 xhgMzGoylu5MuOTOKSo+UsH10wFFxJX063F9ErchhDEWJZCmMSkKd0kyqS9Fs6AUOTce
 MC6J+2RbtRdi3EjHKVzeSRaxNeCUzaHcTcV1lVCtj0mkki/nwP9BUK1pmZZ2cN39Ligt
 cUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989464; x=1695594264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLdkkdZEPKyUic0lLlf7pM01ehziiit06d6Q+F/iamk=;
 b=n6IuydNMcAZEC9BViGevtl+RbQAnpYDazFhstMxiGptRaEE2lGTnS4LP26S6CRiX2Y
 J1GkyR78/dyuMGNjrV16drYu0vEhCMZlZGVGHvBsPnQbsrvwZ2vnGbG2uevGHubTQzuS
 b8JB5IQHcNkF7bCx+W554Vpn2oRgoFi/FQWX1ZuhR/LtfVmnOQJu803+i9dRL61xxyZ6
 7M4yiDt9tlaOPxb/Qo5iC+6HazMhD4vhjTIbTOFCPmylLBC1J/7uQGSAgOTJ/4nlyT02
 M9MFESN5F2MbED0cciJd8epMS5fexEkhUzzsmbM9HW4Zs4IxwkDNLVF1kXYD5TlR8xo0
 r5DQ==
X-Gm-Message-State: AOJu0Yy34RfgzsHwsleezysmt6GBhJxye0MomYpzSC2x3/I2sklMl+xW
 QyR+RqDvEaSazu0IQjS7P8RxSuibKOQ=
X-Google-Smtp-Source: AGHT+IHYvJp2HPjUOz5zcUNQGz4nPWTdNEKGnUZgV4zqFzOSfCGNZ5w3oNJ8d5yP7P1TsZNHuNilyg==
X-Received: by 2002:a05:6000:18cf:b0:31f:8276:5d04 with SMTP id
 w15-20020a05600018cf00b0031f82765d04mr5797102wrq.34.1694989464373; 
 Sun, 17 Sep 2023 15:24:24 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:24 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 14/28] bsd-user: Implement getrlimit(2) and setrlimit(2)
Date: Mon, 18 Sep 2023 01:22:31 +0300
Message-ID: <20230917222246.1921-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
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
 bsd-user/bsd-proc.h           | 59 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 +++++
 2 files changed, 67 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 57fea173c2..06b5b9e03c 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -137,4 +137,63 @@ static inline abi_long do_bsd_getrusage(abi_long who, abi_ulong target_addr)
     return ret;
 }
 
+/* getrlimit(2) */
+static inline abi_long do_bsd_getrlimit(abi_long arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+
+    switch (resource) {
+    case RLIMIT_STACK:
+        rlim.rlim_cur = target_dflssiz;
+        rlim.rlim_max = target_maxssiz;
+        ret = 0;
+        break;
+
+    case RLIMIT_DATA:
+        rlim.rlim_cur = target_dfldsiz;
+        rlim.rlim_max = target_maxdsiz;
+        ret = 0;
+        break;
+
+    default:
+        ret = get_errno(getrlimit(resource, &rlim));
+        break;
+    }
+    if (!is_error(ret)) {
+        if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
+        target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
+        unlock_user_struct(target_rlim, arg2, 1);
+    }
+    return ret;
+}
+
+/* setrlimit(2) */
+static inline abi_long do_bsd_setrlimit(abi_long arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+
+    if (RLIMIT_STACK == resource) {
+        /* XXX We should, maybe, allow the stack size to shrink */
+        ret = -TARGET_EPERM;
+    } else {
+        if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
+        rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
+        unlock_user_struct(target_rlim, arg2, 0);
+        ret = get_errno(setrlimit(resource, &rlim));
+    }
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5d8693ed55..5cb6086230 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -247,6 +247,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_getrusage(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getrlimit: /* getrlimit(2) */
+        ret = do_bsd_getrlimit(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setrlimit: /* setrlimit(2) */
+        ret = do_bsd_setrlimit(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


