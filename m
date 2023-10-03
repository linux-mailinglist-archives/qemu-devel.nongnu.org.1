Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2F7B7550
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovD-00041Z-KJ; Tue, 03 Oct 2023 19:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov9-0003xn-84
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:19 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov7-0006ph-NW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:18 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79f95cd15dfso58506839f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376116; x=1696980916;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FAk+UvZhi8lAunIPUyYc1Eov2CJXu6KRzN3IKE5mSs=;
 b=nHbrOhc+JIHn8E/18Qd+LQCidWORKbCg2slFxOA8LShoZR+SjeLfj+XVe0HLYnzGos
 yPFNgLgoaTsSVb6ACqDkrDdcSUx0H0QXCBpM0OryI4aNlwO/cn1oBdpkhyrsy8MTokN8
 x/lf04sE5MMqfKA919dsKD4Z99yUY5a4Ga8duBHqSL+LG1U15zVcMcAQcVE3OP9u8hGV
 co0Oqp1Gv3jbiyCzycgQjRsYkGrHR1HZA6p3gTe/iu61lb9EzZEnQVhFuYOR3bNtWOdX
 OsLJQZP5ZPyB3fRO8HJgz6hcRLabxnr99J0aWRNRL/hSb1gDOAuoM8Rcnus9ZGCh8Drw
 wiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376116; x=1696980916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FAk+UvZhi8lAunIPUyYc1Eov2CJXu6KRzN3IKE5mSs=;
 b=Wyy7VTWyWk/P3mH8yXEgIgyTcuJwAtBBGdiZibJZmywSzPSkZSGo2gckAl/Fkt07xP
 vHQsGfOMqPuTWcJ7u5Syo8LD42TleCHEDEwk7hHZ7WvYahNUVHjiWWEzKoZfQKz3RSRT
 2oPwGD2dxyuD20vivdSWzwH6bj3rLiQRB1xmI2pE7nbBIZzHNODTzZABqLh63WkzyY9g
 LhF7DH1ivglKzaYCtx+oo4MawRIML343WHXevZpsKTZIupLHqZe/WQxTwrcAFBN+ujxq
 bQAJK03p65YvP9OO+YsLvWlvVEJxl5Fu4rVBjXR7Exa2bjMdaZp+W+2Ycuvupeb1qpcu
 yYrw==
X-Gm-Message-State: AOJu0Yx4K4fG0rotSaj+e09rcE8QbcVUidvH5KeA1j3x4pPmDHqkCwbo
 esXjdQvceEnSnuqiduQpcGOuy5MUZUaoyMie54wFFw==
X-Google-Smtp-Source: AGHT+IGRgjFxlsD69e0vWVBL+UzIOcI8W4zqbyGYNbaD2jGXCR/6TyzlRaJFbu05Vb/KM5fRyXW7Ng==
X-Received: by 2002:a6b:7b05:0:b0:791:280:839e with SMTP id
 l5-20020a6b7b05000000b007910280839emr875375iop.16.1696376116160; 
 Tue, 03 Oct 2023 16:35:16 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 10/51] bsd-user: Get number of cpus.
Date: Tue,  3 Oct 2023 17:31:34 -0600
Message-ID: <20231003233215.95557-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-11-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.c | 24 ++++++++++++++++++++++++
 bsd-user/bsd-proc.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 19f6efe1f78..ca3c1bf94f4 100644
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
index 048773a75dd..b6225e520ea 100644
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
2.41.0


