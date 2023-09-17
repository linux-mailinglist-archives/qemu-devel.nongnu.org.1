Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3A97A3E78
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bl-0006X1-PJ; Sun, 17 Sep 2023 18:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bi-0006WE-Io
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bh-0002vX-1y
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-403012f27e3so44552475e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989459; x=1695594259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tcm4lmXBa5x1vWIwc3sC3J6lpJhMK9gQtwcOR8qWqPw=;
 b=EXX3Mq6UuiaYohZwEfDQJ4IuSAtsD2iE+CIfTmDbUNLHrZ654AdTWsEaWWVKxcY2Cp
 dQzkIoqYlRrXEl49X/PBrI1dJBTi7izAyC08zzPIpURY62W+zqYFnUi2K/x6GVJLC2s4
 3MVO8qDxV0zYkpVDrfEKe+Ita0tcGtI6/dTcmpCvPtvyjDTLinWj2F5my7Bbn1YVs6vm
 sqR5+JUMZojFwdIzn84K7Vj3mCov7lCA5CX5fpOKpegN5Ku2E+AjWhM73qr9/mIvOZug
 DwZ2SwXpOI4sYT3xmHYW7s2S3ExtzYYTI2+Fnvd1Vw3o8fula+6U7emraRktxlwv7ql8
 J0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989459; x=1695594259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tcm4lmXBa5x1vWIwc3sC3J6lpJhMK9gQtwcOR8qWqPw=;
 b=dWeKvfVeQgz970Ep1YDYk8EEPMmbnJ+yBgT5Hs318r2TmQViuDapVJgG5wCcyAn3aR
 6SXF/ApQlUc2JE8WGNYamfGA/DMOfOcqYOFtpKz7XqcYhwHNCwt0sgFebC+WI4KUV0O9
 w/AjZNdufR0dmYsW4rBIYdhl6KuSOYr0u404aOnkSkf9SCkvwk6o2b6LcXfwVtxEtl23
 cWbI51M8eTG0g6Ud6JtGEVq9L9UtF0nAreW7CQrB1bU7ZqlJsjJW/EwPiBGNs8Px44uV
 8FKhV+FcrhAf2G1oYg5HRIDeioVkwJGA1a0FowK1i/S8LyO8MsoyGw/YL8PVI2std/fc
 BvDw==
X-Gm-Message-State: AOJu0YysVy2R4CdqptcySEMlFkXlMTx36yfPPSWgpya4XgyCwH/KX6NB
 uLZvM7ZgGpWz5BApXykw0zqkOy7+440=
X-Google-Smtp-Source: AGHT+IFf7Z9ghCkuJdtx4HtCPqvcAxLB++Wbn7dRK2KGr9L9L7wxJ1rrG8TeDgu7bbZuzE+QQg9Phg==
X-Received: by 2002:a1c:7709:0:b0:3fe:e842:60a0 with SMTP id
 t9-20020a1c7709000000b003fee84260a0mr6839297wmi.31.1694989459422; 
 Sun, 17 Sep 2023 15:24:19 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:19 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 10/28] bsd-user: Get number of cpus.
Date: Mon, 18 Sep 2023 01:22:27 +0300
Message-ID: <20230917222246.1921-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.c | 23 +++++++++++++++++++++++
 bsd-user/bsd-proc.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 19f6efe1f7..78f5b172d7 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -119,3 +119,26 @@ int host_to_target_waitstatus(int status)
     return status;
 }
 
+int bsd_get_ncpu(void)
+{
+    int ncpu = -1;
+    cpuset_t mask;
+
+    CPU_ZERO(&mask);
+
+    if (cpuset_getaffinity(CPU_LEVEL_WHICH, CPU_WHICH_TID, -1, sizeof(mask),
+                           &mask) == 0) {
+        ncpu = CPU_COUNT(&mask);
+    }
+#ifdef _SC_NPROCESSORS_ONLN
+    if (ncpu == -1) {
+        ncpu = sysconf(_SC_NPROCESSORS_ONLN);
+    }
+#endif
+    if (ncpu == -1) {
+        gemu_log("XXX Missing bsd_get_ncpu() implementation\n");
+        ncpu = 1;
+    }
+    return ncpu;
+}
+
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 048773a75d..b6225e520e 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -26,6 +26,8 @@
 #include "gdbstub/syscalls.h"
 #include "qemu/plugin.h"
 
+int bsd_get_ncpu(void);
+
 /* exit(2) */
 static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
 {
-- 
2.42.0


