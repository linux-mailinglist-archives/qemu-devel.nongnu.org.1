Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697007A3DF0
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:41:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUX-0004YG-Hb; Sun, 17 Sep 2023 17:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUV-0004Xy-S2
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUU-0004GG-9D
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31f7638be6eso3714876f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986780; x=1695591580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30VV4yt2ro3MiuAoHh+3abDe9zHvykVDAdOKnvHSpvs=;
 b=YvNQqqmDtJbN51NnUm+tIlWmFsCKM5c6OBcjksenmCGS0WYvCfGUmVP34nB2KYv7hb
 hw5idC9r3JlaHoC+Cyi7g7g5qhVaK8rqKB+WmmKjb+DAO9JbtzM69xZK6glofmB5Zp+M
 Dp6Kc4ug5kQNTxHXQWlR0v7US+oesMTW5QcD5icsmnKLxaEb785xb+/AH2utQ1rcAchj
 1rgiQtsml6nmTF3OKChHzHEXibzoExQ034y5OM9J/I3aMvYnHR91QVQ8xPWiOn1k1A2C
 UEIhc0U49MFeZU30vUqJPFNfoDRsIbjJegFm3gtcbKSYtO0TGMiIO8I3HGunA+mD0tl8
 SEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986780; x=1695591580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30VV4yt2ro3MiuAoHh+3abDe9zHvykVDAdOKnvHSpvs=;
 b=FbXpX957MOcTfx790wMvelX8sU7SH6UkBlPIkatG1pTH2MnlK9Z3kJisu2rAuv1EqL
 LOLI6bindW3QVPf67045Cye5S6vEnNbiKnDXNJwJHU46o8LHdNw6jatvsMC5sumTflhG
 cQZsBwNvwni7jllgpemHNjUZrPcNLVu+qpNozeyJ2kF5gt6h7Yc4Ff6x4H8ZqLWZKHeh
 YmdBQWoY0o3Piv9xmahbeQI/wPDnDhxI+ajkchcBx6OpO6GpOkOtiEVq3T/klVRUuhtV
 hoiGAKaBNHZ8KQz8CUjl914NRKpYESyg+NBNV+BmDAYbj451iC/0Km5zROHcE3qWUPwE
 ZP2g==
X-Gm-Message-State: AOJu0YzQCGywrQRFiLsW2ATF3EGn7bkhDtf1QP0mFmDqE9ikqYEfDXzh
 dU3k3wP3zq1ElFn9M4wUH4+qeE05VBA=
X-Google-Smtp-Source: AGHT+IFe7BsZLaRJpx3TcxsvWyFc9p/eOsNjNARo8akm4BOaN8B/9n5jLuNEWxFzkxaNshoADq3yjw==
X-Received: by 2002:a5d:5746:0:b0:31f:db58:993e with SMTP id
 q6-20020a5d5746000000b0031fdb58993emr5514400wrw.66.1694986780307; 
 Sun, 17 Sep 2023 14:39:40 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:39 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 11/28] bsd-user: Implement getgroups(2) and setgroups(2)
 system calls.
Date: Mon, 18 Sep 2023 00:37:46 +0300
Message-ID: <20230917213803.20683-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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
 bsd-user/bsd-proc.h           | 44 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++
 2 files changed, 53 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index b6225e520e..7b25aa1982 100644
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
index fa60df529e..535e6287bd 100644
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
2.42.0


