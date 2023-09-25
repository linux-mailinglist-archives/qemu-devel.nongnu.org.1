Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A67ADEF3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:34:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHc-0001IM-9w; Mon, 25 Sep 2023 14:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHZ-0001HA-EM
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHX-0007Ia-Sd
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4053c6f0e50so62761815e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666364; x=1696271164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0Dqs0KOjTr5dCbbJ1YQtsQ7bJYAtc0s59yQIYeZ8Mk=;
 b=lTDYqArZLdyXyfZYQe3FXOxA34H07wssWn4PmlhAqECN1yoCb1BWqqToDlLjJ64ECX
 QbraEsxMm/o5Dc2Q+ObaxcYywZrEvj3reTvR8YLR+Pp1GuWBOnq7Mux078qgERtZIMmI
 /kRSBNQWm4ArShWNFuwrsIbEjm9LQnSY/9UbjrEl4pV71XpvRsIbTd4mSEIOBDKwQ8db
 ZJuj7vC51CGdLIzkYYvUVAVuR6sFdDryM37yvAzWMDN/Z7x36PtQXXoNEyhNtSGRVqWF
 3vcwzkdFwoN6K+TitNkkt2j8It796OVy3EQX66IZrlbcEjXJQmwcJeFd+CdctD0YgtdS
 H53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666364; x=1696271164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0Dqs0KOjTr5dCbbJ1YQtsQ7bJYAtc0s59yQIYeZ8Mk=;
 b=SXOLjRyWI3B1KyVlh16mReXB08XQSRQH8MWikkJuyIREgP2BALF6hIwkxM+BLsnj7e
 G9n6fQKAM4KsQfsM503qk0estQPYaLxV3sov2g0n2c5NHwi6+iZ7HMS79Wt2V91pqxZL
 Bbm6bWffo/IWalyLz8672NR2riE2AlwZW67hrNDcrcrExw81fgC7Qox9qsBxwVa4ALvU
 F86g3OJeFqBlxRFg3k4xRB/lRVFdPd4XxhY6bIxZF8P14qEPOCDCBW+Rky2nBsolkb7S
 wM4kTHxIuQR6/dGWKHoGQSQnyyoJTs8AsiF57B6O3e+8SMVktbuCRTp+h1N5WAkj6CkF
 8yrA==
X-Gm-Message-State: AOJu0YyNp2iG230sT6M/8JKVUqcWJb8vzMYk6S840gy7T0moDxu5phrO
 T2k8cAb33JD67spARnOvfaXMX5tEPOQ=
X-Google-Smtp-Source: AGHT+IFZMzjPM3rHs/DlYhZ0cBn5NLYBLi00bWf9jZnW3sdrbfzUeQ86PRuW5IixW9i9dfJkpTg/VA==
X-Received: by 2002:a7b:c416:0:b0:404:74e3:27a4 with SMTP id
 k22-20020a7bc416000000b0040474e327a4mr6504110wmi.40.1695666363746; 
 Mon, 25 Sep 2023 11:26:03 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:03 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 10/28] bsd-user: Get number of cpus.
Date: Mon, 25 Sep 2023 21:24:07 +0300
Message-ID: <20230925182425.3163-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.c | 24 ++++++++++++++++++++++++
 bsd-user/bsd-proc.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 19f6efe1f7..ca3c1bf94f 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -119,3 +119,27 @@ int host_to_target_waitstatus(int status)
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
+
+    if (ncpu == -1) {
+        ncpu = sysconf(_SC_NPROCESSORS_ONLN);
+    }
+
+    if (ncpu == -1) {
+        gemu_log("XXX Missing bsd_get_ncpu() implementation\n");
+        ncpu = 1;
+    }
+
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


