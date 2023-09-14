Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC587A0EC8
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsa7-0003bt-HD; Thu, 14 Sep 2023 16:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsa2-0003NV-7D
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0001aA-FB
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401b0d97850so14117935e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721866; x=1695326666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvUkuMDUMC6zord5lIwDs3PjxQ4028j+e76aGZtjWv4=;
 b=S0xDzORKx4vtX/jWSdGvCmAfdJ/EKJsNM1DkbWvCK9/t3ggmU1Cxhsuj8p0jhfJIEz
 2CWbdgETROqgrGDZKQIG7rVLdbQkPF67wV65rl9a5zc+MM7Gw3ExUXLj9NddpGl98ZD7
 PKcbepGNMxMAZ/OX2qPyWAGwVuQCSr5bAyKy8Q+ZqrP+u0R+QyUNdlpnZQD/LNdP+MZN
 xsU7blRQM2h6As7Wl14wslLE9ZJdsabUt7ISq8cmGqfRpgqhZDhgmz8+/r5miLUNIFkh
 ZFNFItNkBvS1DtRfxx6NOl8Weh5k6g03/zFfi6QBXbQ7uuK3sV/j1kfvDtkn9KAj92nz
 aoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721866; x=1695326666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvUkuMDUMC6zord5lIwDs3PjxQ4028j+e76aGZtjWv4=;
 b=WIjy4GoUvpndAKFpRQDckaosS4AhpeCEKmcWh5ePznLPYbQKR4Y+SFYhfO6ZfiAEO4
 q2gOQOgS9ac+h1umS/PFcJM8QpHkN4Jds9jpZNPPVMnuQ960r5M1d92MYNrC3n9acQCG
 3RO57wc5Rfn3rUzsyF/W0q7g70VO2TluVnzQv7WJlgT9drNJyhRVSHCwZAj/0Rem8ppM
 EV5b0q9/1StezafKjk5aeUUmw13IgFOXrB6pGiKsmtYSq8L3AvzkGnQCfxBNegXlHn8J
 cSPZcksNb9skcSIfbVSrNAx+l2RZi1DgoFwXnqZOs+BF05957qFy7tUngfyhlhY/9lUQ
 sSAw==
X-Gm-Message-State: AOJu0YwpChdUTwjd4tYWXJMitZuYO8icdFht+mcnMRii+oQo/d3ZPPHE
 QwDHpeVSWLX6HQN4oW7Zpe/KWodRUO0=
X-Google-Smtp-Source: AGHT+IGSsxB8qjTkn2tnZBOux9uk3Q5sW78jHTrpW/a5Yuvo8btyTwVUsgHJ2x+akG+8uDLVwcTTmg==
X-Received: by 2002:a1c:770e:0:b0:3fb:b008:2003 with SMTP id
 t14-20020a1c770e000000b003fbb0082003mr5495692wmi.38.1694721865794; 
 Thu, 14 Sep 2023 13:04:25 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:25 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 15/23] bsd-user: Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), minherit(2)
Date: Thu, 14 Sep 2023 23:02:34 +0300
Message-ID: <20230914200242.20148-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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
 bsd-user/bsd-mem.h            | 37 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 20 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 5e885823a7..16c22593bf 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -99,4 +99,41 @@ static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
     return get_errno(msync(g2h_untagged(addr), len, flags));
 }
 
+/* mlock(2) */
+static inline abi_long do_bsd_mlock(abi_long arg1, abi_long arg2)
+{
+    if (!guest_range_valid_untagged(arg1, arg2)) {
+        return -TARGET_EINVAL;
+    }
+    return get_errno(mlock(g2h_untagged(arg1), arg2));
+}
+
+/* munlock(2) */
+static inline abi_long do_bsd_munlock(abi_long arg1, abi_long arg2)
+{
+    if (!guest_range_valid_untagged(arg1, arg2)) {
+        return -TARGET_EINVAL;
+    }
+    return get_errno(munlock(g2h_untagged(arg1), arg2));
+}
+
+/* mlockall(2) */
+static inline abi_long do_bsd_mlockall(abi_long arg1)
+{
+    return get_errno(mlockall(arg1));
+}
+
+/* munlockall(2) */
+static inline abi_long do_bsd_munlockall(void)
+{
+    return get_errno(munlockall());
+}
+
+/* minherit(2) */
+static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
+        abi_long inherit)
+{
+    return get_errno(minherit(g2h_untagged(addr), len, inherit));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 859492dee7..6eaa705cd3 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -503,6 +503,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_msync(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_mlock: /* mlock(2) */
+        ret = do_bsd_mlock(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_munlock: /* munlock(2) */
+        ret = do_bsd_munlock(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_mlockall: /* mlockall(2) */
+        ret = do_bsd_mlockall(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_munlockall: /* munlockall(2) */
+        ret = do_bsd_munlockall();
+        break;
+
+    case TARGET_FREEBSD_NR_minherit: /* minherit(2) */
+        ret = do_bsd_minherit(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


