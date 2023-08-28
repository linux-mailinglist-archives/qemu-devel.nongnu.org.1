Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0690E78BB97
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsS-0003v4-WB; Mon, 28 Aug 2023 19:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003sh-Hn
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006q9-UN
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:19 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34ca192f8feso12440215ab.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266126; x=1693870926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAf9q2fDw0guLLS8QyB9ffSUo9hVGOLmg07hz6ALafE=;
 b=z8h/I3IjhtiJVCFAeABJEEqoAw6U88wmE/xRAEsEv5OuCj81YjOzPmY+J1w3SPl4+K
 O+I9JREYruPUBz2m4zyVGi7hlM5BDg4d7xMgE+f2RTM6MvCHfUQZ/4c1NDu+XYPXsCkD
 zcYwGIDKgMDIX2B27YYRD9XZOXu+tv9TwbFy8pSevjOfiIZogyJ+zoFC5/Z9vD4XorE6
 v12VeEfk7MUGA5SqpIcMRVBC3JsdI0sSu2lo8JQ7EhVizl1MNL5C7qqMuty7m77kffyW
 p5ylqn/HjCgT8UtjEmIqVdoJYrIeBL78tdmREZnrMCEbNYfUatzTXrIpPAoafezQ2o5G
 UUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266126; x=1693870926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hAf9q2fDw0guLLS8QyB9ffSUo9hVGOLmg07hz6ALafE=;
 b=NEpuszjz/D+DKPv0ASvLNe0R9ZFvMNrSdEj4MlzGTfHRtLgsqHRQUSBZH0OdiG/+yI
 EpfhfS3FtL1UxdwGQYanrDE2d4RiYeO8UZ5SF7LvsqpM1zQrdK+CZwNQjhiFrn6QhqAk
 sI2h+KrKEBQ+yBhd7UyWKO0c/OrFfW/JYtxjojCpl1UlsVjhax23fo3x1Nm95Qsc5eay
 3MMBKEEd4VkV+dz2Nso1HSttwNq66mAbhGi2i55c4MTxcO0fo3R8EhP8N04l8g601+ua
 2OQBolnKyE9+K6yT80UAIc30LgiZoUkUdii7HCK8F++9WPr3uQ2fd3eHPBdSSZZwvcM7
 bXjw==
X-Gm-Message-State: AOJu0Yxhs0v2HNKKSiGFkYeo8XpXUFxJsPqBWkIWbpY0+kK4cgApiglb
 3gcyPZsa1H+bq9ZbS6Ij2wqcy7Nt9OT3RLdKybU=
X-Google-Smtp-Source: AGHT+IF6OFTYk1mHlH7Mb5GPjXtm33brSm2ShKvF4+M5B0cvAYcvi2rw3qElsDNAtzNefZd3Zr3kGQ==
X-Received: by 2002:a05:6e02:13cf:b0:34b:ba9b:c764 with SMTP id
 v15-20020a056e0213cf00b0034bba9bc764mr15322574ilj.18.1693266126052; 
 Mon, 28 Aug 2023 16:42:06 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:05 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/36] bsd-user: Implement do_freebsd_realpathat syscall
Date: Mon, 28 Aug 2023 17:38:15 -0600
Message-ID: <20230828233821.43074-31-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12f;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12f.google.com
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

From: Mikaël Urankar <mikael.urankar@gmail.com>

Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index e31b2aab9e8..b20e2707745 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -634,4 +634,30 @@ static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
     return ret;
 }
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
+extern int __realpathat(int fd, const char *path, char *buf, size_t size,
+        int flags);
+/* https://svnweb.freebsd.org/base?view=revision&revision=358172 */
+/* no man page */
+static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    abi_long ret;
+    void *p, *b;
+
+    LOCK_PATH(p, arg2);
+    b = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+    if (b == NULL) {
+        UNLOCK_PATH(p, arg2);
+        return -TARGET_EFAULT;
+    }
+
+    ret = get_errno(__realpathat(arg1, p, b, arg4, arg5));
+    UNLOCK_PATH(p, arg2);
+    unlock_user(b, arg3, ret);
+
+    return ret;
+}
+#endif
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.41.0


