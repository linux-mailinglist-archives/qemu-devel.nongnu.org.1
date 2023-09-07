Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF2799648
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:36:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfY-00015b-KP; Sat, 09 Sep 2023 00:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfQ-00012R-KD
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfO-0002xS-3c
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401b5516104so28926405e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234032; x=1694838832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nAYdR+eSimunrq+5ySm3v4Uk13qn/HpDgGI/X8dRrQ=;
 b=QxT8L1rLtjr8N8212QIr84PEYxwxQM+G4+OeA7+bV8X5TS6s4+KWWJHVuTqcRnuRQB
 wjT6NpkfdpIkzbfTWjqpw3lI2eNRGH3iUn9hf48RDwuzeBS3zuBcE+jlw/zmY6CulnM1
 ClxiMcdnnQ1I+fPBpucmtvJde8Un1xyAI5Ef2+jwPU7CckyqeuokEigvdqLL5F8YWpNs
 eR7WsBb3cp23klK0ZMXJyA/xedpi3u6Uu+rfVaDmWw7SdBKeSe04Jz22t4+KQ8skmPOR
 AbcFqU1Ywl3njT1cOepwwEi5evExfgbNGlJ323QFpQjQYVnK5bwkLPXXoZhyafesOH7K
 f6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234032; x=1694838832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0nAYdR+eSimunrq+5ySm3v4Uk13qn/HpDgGI/X8dRrQ=;
 b=f9dYcf+m82eaTOVVDcdei8SVne3X1JQC8TxmLQZr2S/hRiRZEnp5Gy/yQ2bgXifmlB
 CnAANvaGWYkA2Giv3ls+2kXi7nb2fLX0oBU1sW6BmuJX0pKFx7GzaIiCagNsZtTs5Zuv
 SCZNc7PEBbNH00igG3ZahhBlCySVD6QHhCe1UiWMDKIvtRR9O+vtM0yxjs+yL0ZK0r6d
 miKFLQUtn0st4Xd8855jiS26Tebh1XsUZR8uGrMHyafuZXafubiaz6msw42NUfz0Ij/o
 a3kWt0QEAkigy9CfM6KY//ITY/udIXY5B8qRZeWisYs2jprRJWZ6tGzrODwEgmOVuPL8
 Zl5Q==
X-Gm-Message-State: AOJu0YyOUgdEb1SsDG0UwjrCJezCNUKWruvOt5w4WxbI1FrH09FWVMK4
 6NfJLtPDDZqdulXlwXLgYTDNRug7GKI=
X-Google-Smtp-Source: AGHT+IE+jLnLYskFB1OpGlI7kPhbzFrEeQJC0eDFsLCXv8NQz32d+wH3aseNdeZc/FfsPGXXQ/7vNw==
X-Received: by 2002:a5d:4851:0:b0:316:ee7f:f9bb with SMTP id
 n17-20020a5d4851000000b00316ee7ff9bbmr3367393wrs.65.1694234032377; 
 Fri, 08 Sep 2023 21:33:52 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:52 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 15/23] bsd-user: Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), minherit(2)
Date: Thu,  7 Sep 2023 09:42:54 +0200
Message-ID: <20230907074302.79234-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


