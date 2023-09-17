Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CADA7A3DF2
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUV-0004Xk-OG; Sun, 17 Sep 2023 17:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUU-0004XF-5W
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:42 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUS-0004G1-MC
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32155a45957so123104f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986779; x=1695591579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tcm4lmXBa5x1vWIwc3sC3J6lpJhMK9gQtwcOR8qWqPw=;
 b=AUBhNGNwI9dB8GA256jlzRu30udyGfPEqcmSodVLA99c5hCmz07UcK5ASUWwhOvNcU
 77RVmJfw91loss8itbTRRoIU0dBTYFe987IsshsS8F9YyzQjt7n4OOFjpva8QMdWtPvv
 dD8s3Xyj+RCcknGHOt8obxUQpyLfBY2ldkJZHEY0SZm9Lnyww9wdK2ILe9NByo3OHoXl
 pSB7TTgrc5Qmv38q0VdP2TmsWx20Wzv9elluKpvD5Hpkgb9Uzn2nlRnKpOmtSB75V786
 qzypZEAjFkmbcRgQwV1Eu1D31cZODP8XYJRh5u79unyB03uV7Sck6uI52pnsB4IC40Pr
 SMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986779; x=1695591579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tcm4lmXBa5x1vWIwc3sC3J6lpJhMK9gQtwcOR8qWqPw=;
 b=w9q3uC6uePcEa5zrx39MvVLTHN3dspTyilTXM9i1/1d2Jm2AsVgcAKIJ82lOWCZs0w
 yp/dvaIdHM489dy2LCS8iD3sv2fJfV0OYsotosqmJd4Wt1ATaL/ajAaafqmkluHO8aff
 TOBcVZ2T0DdjPACAak3fgb3I73ktE+1inl4mg7FpaQdJ7nUSkmR77dPIx9X1iBFI4cXq
 WV5alBC45c/trIbLQ74Q7JbuL0J9v29WyZRtRzh+PcfZUrnpZ1HVuP5gzRCGRd9gR7jw
 CzaMk1h3vm5EqR0UsGqqSSgHmpzuvmccFMw7Hs1FqE0oil7iOAODwGq6D4e0z1I1mnbw
 cfLw==
X-Gm-Message-State: AOJu0YywLyX2dFz8SeQ7u3ZpCg108pMdS707vW1fkZJ+7S8ZjbMRTqxn
 ZvdgaArbD2AC3vDnOMchjM8QGAZSweg=
X-Google-Smtp-Source: AGHT+IFtZS6Gam5M4/Oi8Wum+d8M6P6mV0aNMlLMZ+f7wVI5QRNXgHEvIjU82toIuqpMn2wSLgTMmQ==
X-Received: by 2002:adf:ce87:0:b0:317:57f0:fae with SMTP id
 r7-20020adfce87000000b0031757f00faemr5639275wrn.63.1694986779060; 
 Sun, 17 Sep 2023 14:39:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 10/28] bsd-user: Get number of cpus.
Date: Mon, 18 Sep 2023 00:37:45 +0300
Message-ID: <20230917213803.20683-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
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


