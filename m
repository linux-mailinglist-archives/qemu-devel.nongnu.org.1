Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33977AB00
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVH02-0007ya-D2; Sun, 13 Aug 2023 15:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzz-0007xp-Rf
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzy-0002UD-CA
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe167d4a18so34311685e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955817; x=1692560617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AudXPKhwqDesJedmS1mxJoP3DgO9Vt4WYBDjn+bY3BU=;
 b=h2kto4SsMo/Rpm4NUyqQOWPkAWSYU4lqoILIlRCxP+7Cs06gHwwIGKjne0wFsO5y6M
 8RFpJREFVnzeRShHyy+Fr3QyvIKVgt38f5BVBOVgFWnl2R1UNkE+hh8ULoOHA6JowEAE
 plNDUhhrHeB9tdKljoI8uU4/tFyMRyiMlcZ+bww3J3mycnQAK7YHLDhOVe1X1pGztuM1
 W5DkLBGwU5sriwOHSFXL8zewa9KgUQFpMv8xFyzyi3DUs/eOINTJepPYCqz3hKaQq5mi
 7hc2GxwWqVUKPEszpL60TXIgSuKwlAy7issNOUOEDuZcZq7SqZhEzNVle84JANC8VbU0
 kArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955817; x=1692560617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AudXPKhwqDesJedmS1mxJoP3DgO9Vt4WYBDjn+bY3BU=;
 b=lUtX+0GTBA/SWtnv7bjyZ9gPQQC9SRyPahsbErlGKEV9XcH+zpoR6XTbonZCSLQiz9
 NtzhRTlmXhufiBjjdzs2yKFAFqWagiA7GE41H77e8YJT1kztd7qSWrBUstrHKTOfM/yR
 6dFsTBUE1L7DgUM76Hym0sjrnICJ7fvzBUHQBK56Z1nE2xDsC0IWxE6UaQCF7v48f/pe
 so4lw4AUqdGNC/DnGANwyGcODHL/V9bGxyLMvKmx8LUGhbKZM9yPDm7DDH3GY+YCLu6r
 Xt7geNFlRCPQILLfr09hq54VSSmRPvv2qzM5+7w0yswrXdM41dZ9z0CFFzFKw27FWjvK
 5MuA==
X-Gm-Message-State: AOJu0Yz87zz+RjE/DLxAL8jpgB5B4Yy54/2JKLPd1E1ZYSnCtfAU1vYn
 z3GmgaNcTMEVbn4zzFOYQpdzRoqSMLc=
X-Google-Smtp-Source: AGHT+IGtJjAj16o0/rhBwLtPAlYJFm7KclzjrbulCetJdiqiUn4osfL+pGaZSvFrS57+I3agnH23Mw==
X-Received: by 2002:a05:600c:255:b0:3f7:3991:e12e with SMTP id
 21-20020a05600c025500b003f73991e12emr6008493wmj.1.1691955816800; 
 Sun, 13 Aug 2023 12:43:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:36 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 31/32] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Sun, 13 Aug 2023 10:41:52 +0200
Message-Id: <20230813084153.6510-32-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

From: Warner Losh <imp@bsdimp.com>

freebsd11_statfs
statfs
freebsd11_fstatfs
fstatfs
freebsd11_getfsstat
getfsstat

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-syscall.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 73616a5be0..916a754bf8 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -552,6 +552,30 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fhstatfs(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_statfs: /* statfs(2) */
+        ret = do_freebsd11_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_statfs: /* statfs(2) */
+        ret = do_freebsd_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd11_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd11_getfsstat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd_getfsstat(arg1, arg2, arg3);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


