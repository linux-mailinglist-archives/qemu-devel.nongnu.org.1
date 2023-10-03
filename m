Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC8B7B754C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovr-0004UI-9D; Tue, 03 Oct 2023 19:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovk-0004M8-MR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:57 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovc-0007SO-0X
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:53 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79fa5d9f3a2so57662039f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376146; x=1696980946;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NCyHAC9bXim/1mXpJd490XbnS8liuXo8kxgl9Yya/4=;
 b=FDWWUnQ1/1qa/U0+1VFdwE6hqdijGcGJ5LpGf/hKMVLgwBYwxxP6NS/EIDiEKSo8ri
 YAVLyWaRRPEUJIsfLWi0ay+BNQNyLkYIgXhsrR23AvoudrID+TwJQERydceRo5KCyXWv
 fQUJIxYECFFrYsUoIElaM5Cq9iTFlO4SNY6naM9OXCa2PF+pFe5mV5LUmyHLKnBsXmOe
 9nS86NoHX/SBY7SLW9TfwiiKtVqf3pHujWIutUGONoD86rYsAC5FBB8nZz/sPyHWQ53X
 0YxzlwvKa2Jg7/Twv8sCi88pksrpG1PtLiwCmwccYyhjvTDIeiTh20rP3eC2rk6767WL
 my8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376146; x=1696980946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NCyHAC9bXim/1mXpJd490XbnS8liuXo8kxgl9Yya/4=;
 b=sLQ0tLNwvNm2hJmgOhION2jFWm+pok7pd5E3721A8aGvExWt5D/sKEAPHWhXSDvVpi
 UzUw+hB4Ka6LZqTFzsiutQMlEjIMQr21np1B///a3TebR20MxirJKJ/6Yc3+w8lP4XAr
 tDEa9S90xaMDplQiViUJ4rpFmy64Mc5plpCmvtuALQoxZujJ+I3cyzZ4SayMUhoKXfho
 twPomH+m1AUtfnxGo8EDGN8iXp7TJ+ktm6n32BvnmABCg/h3L0nR2WawvExlBVJ3u4I9
 yTSAmr4eQ6n3rUvg9WBRRdSrTR3ZNDUgHu7Hc7rLNNQCDJ1MPg2fiBOvfFxOLEgrcOsn
 N5Eg==
X-Gm-Message-State: AOJu0Yxm3WQlrzcmHOi+ixi6FrdgAvGpNlUNF8ljJGrQ72UJDJMkbbMO
 My+K89Hqy08vqQP4UM2eaOfCAo1tdlP0hkedugADng==
X-Google-Smtp-Source: AGHT+IGsOFW3d+6U1fFTOGki2d3Si6JtXpKrW6BN//d2GpH0FKZwc/xjXi3/J0QlZ1AbKvNshEQgPw==
X-Received: by 2002:a05:6602:228a:b0:79f:a25b:51c with SMTP id
 d10-20020a056602228a00b0079fa25b051cmr969801iod.11.1696376146172; 
 Tue, 03 Oct 2023 16:35:46 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:45 -0700 (PDT)
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
Subject: [PULL 43/51] bsd-user: Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), minherit(2)
Date: Tue,  3 Oct 2023 17:32:07 -0600
Message-ID: <20231003233215.95557-44-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2b.google.com
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
Message-Id: <20230925182709.4834-16-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 37 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 20 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 5e885823a79..16c22593bfd 100644
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
index 2525e0bc316..7a7ae26793f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -815,6 +815,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.41.0


