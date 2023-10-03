Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA567B752A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnov7-0003vy-Da; Tue, 03 Oct 2023 19:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov5-0003vJ-JI
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:15 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov3-0006gt-Ax
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:15 -0400
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-79fa5d9f3a2so57643839f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376111; x=1696980911;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4s+TJxjVa/sdg7uCzCwkoZKCJLn5htyPFKNsiln+QBw=;
 b=y4ZCvDNhdmWbtkn3yh9CtfmS+reM7iuB7S3IaNlPFex/TcZoh3tk5sTNdf/YqSeSFX
 nXSIcgLUa2TFdwPgRcuk4RD9I2GByQDdwIfMVpJprbED1Lai/q2fZDaxIxxO3GimFPj5
 n8xapsKZZHNjZPU9dojjhgP1Cxlt/AJw80r6vB8yA/3DRqEGCDOxGPAX9etc4nq6GKoX
 jp/GlXHbGDZjYvKWZxloZpcqD2JmOKcga84V10R+iV8rR/iQxT0FU390tMfS3Prv8QLi
 y0TTjjEDGzu0CqEVHKnsaCv2q4cbMccoqB66MfoZLQ8hA10o6iVq+GoVXVFdOm+kB/uY
 XoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376111; x=1696980911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4s+TJxjVa/sdg7uCzCwkoZKCJLn5htyPFKNsiln+QBw=;
 b=fVXoh4D12U2Z/jA54avjwUEh2ZTQqKIyCiEQzKs7P778u9/gYGD8VeHmikN/pX3G4i
 FDNe8qBIeCvokAdUI2UeexwdPX9+JakGxfHTzm5G6dfhX6VFRQVq28ydxEDzIibzRk+6
 yoHf293CCRhOPXe4H3tEES8yvdrN+e8UBRgYvWZbA9Zz9gNfSQ1IDGse6QJOXMj7b8KQ
 vE4d2nbwJWaGZZ/ZFgb7MKSsuitlCj2M6n813mGvpjZBrkLi9OnKGbYrVfmdiYyFTzuq
 llPtl3UQnyj+3CXah7VNbBRVC1Wgj2OlFk5d8Hfjd4oGWDxrP3PdEA0u1T/9pmvegQxV
 WD8w==
X-Gm-Message-State: AOJu0YykzHdTibyzVjtODSfa3ti1bzBi+xUjnPw339P9w62v+6MqrV05
 vSQPYSGJokUu76FPhmmiXrFhky7Y6G7/qJWMyEbEGpqW
X-Google-Smtp-Source: AGHT+IGHnT0CRyYakx1Jgv1pLjRzTb5shPJnnnPDviDb9N4EiawHfBGYiGFW2IcX0/2UzvuVuMc+kQ==
X-Received: by 2002:a6b:7e05:0:b0:792:7f26:dc95 with SMTP id
 i5-20020a6b7e05000000b007927f26dc95mr863243iom.14.1696376111521; 
 Tue, 03 Oct 2023 16:35:11 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:11 -0700 (PDT)
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
Subject: [PULL 05/51] bsd-user: add extern declarations for bsd-proc.c
 conversion functions
Date: Tue,  3 Oct 2023 17:31:29 -0600
Message-ID: <20231003233215.95557-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d41;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd41.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-6-kariem.taha2.7@gmail.com>
---
 bsd-user/qemu-bsd.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 bsd-user/qemu-bsd.h

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
new file mode 100644
index 00000000000..b93a0b7fd5b
--- /dev/null
+++ b/bsd-user/qemu-bsd.h
@@ -0,0 +1,38 @@
+/*
+ *  BSD conversion extern declarations
+ *
+ *  Copyright (c) 2013 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_BSD_H
+#define QEMU_BSD_H
+
+#include <sys/types.h>
+#include <sys/resource.h>
+
+/* bsd-proc.c */
+int target_to_host_resource(int code);
+rlim_t target_to_host_rlim(abi_llong target_rlim);
+abi_llong host_to_target_rlim(rlim_t rlim);
+abi_long host_to_target_rusage(abi_ulong target_addr,
+        const struct rusage *rusage);
+abi_long host_to_target_wrusage(abi_ulong target_addr,
+        const struct __wrusage *wrusage);
+int host_to_target_waitstatus(int status);
+void h2g_rusage(const struct rusage *rusage,
+        struct target_freebsd_rusage *target_rusage);
+
+#endif /* QEMU_BSD_H */
-- 
2.41.0


