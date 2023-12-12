Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711B80E0A7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 02:03:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCrAU-0002Gl-Kv; Mon, 11 Dec 2023 20:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1rCrAR-0002Ga-Uh
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 20:02:35 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1rCrAQ-0005SK-7M
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 20:02:35 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b8958b32a2so3975145b6e.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 17:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702342952; x=1702947752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KyjKFLTPuXUtwRJxykHJUA/4Z7EQI7jBnbFZmRKB0Rk=;
 b=hTygUCVAmCYRLS3jLGg61F3Dx6cqjN77T4+fyBBC58sB4fbeslRb9WZxL0VN4L9gE/
 LAjHGCARsB0JKy8Zg4481+WnSHq8/VWUSGlRiNs9zEPqH0v9FtaLZYA8UaM7C13ERSKG
 zcB4gy8pECLkaXknx23dsnq60xFvuqe6oMu8KGaBf+Nz5GBKXZ/pgmc2Ht6CFEIn/PA0
 ykgE7OQ50Laj0b7G2hD/LZ4gX99o1Yn9ivq7YXM1WT3azPjNWyUONYM2RB6N/SMjZf7g
 6t4N80a4DJJIKKlNps9goNQswjxh4PkAi0YNX/lJK971oHwmI/J62K7ZCjFyVVous60k
 xz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702342952; x=1702947752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KyjKFLTPuXUtwRJxykHJUA/4Z7EQI7jBnbFZmRKB0Rk=;
 b=uubpx5xSDP++/537lXMVgsxZCIXpNLetMsbbyoBsjtdN6jKzK7QH8N3yX6csm9zykA
 H/bsD0mMmP0xbaZy1h/+tamWe2x0MzI+xx1dGoC0PoBS6UYCKmihFhXwThhXkI1gc5t/
 hLiwBymW04qAccA2vsAntuRvoNXClNxV+QsBYqDBfG9rndBx2RTrB2+8BAeCfrMNZUKn
 IPXryb0aFVba+PoIvBTbYFI8VmrjW4TlfJNNvze3+Wzg414Fm+rlRMnAj8TIGivwzuC1
 SY5GJbxPSMAaOEe0N5VR+amW7pdMaBaxVcfptZtUyUecDQUg97TKsV2LdBoO8RA/VkF6
 PFFg==
X-Gm-Message-State: AOJu0YxB+IwOMUW/14bK9mjF2sK6la51MRNBYIA3YkAGUz0YJo2AahCe
 sAs+MtoCKTZlS1yULzGSgsa3skxK8EY=
X-Google-Smtp-Source: AGHT+IHRR+JuXEWIF25Oas48KJfOmXZG09DS43xRUuiqOIzU3jgjX/UmtkWZMXyYrQnUr/5sV3ZRbw==
X-Received: by 2002:aca:1109:0:b0:3b8:b063:506e with SMTP id
 9-20020aca1109000000b003b8b063506emr5672297oir.111.1702342951638; 
 Mon, 11 Dec 2023 17:02:31 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::4b6f])
 by smtp.gmail.com with ESMTPSA id
 ey2-20020a056a0038c200b006cbb75d87d2sm6951517pfb.6.2023.12.11.17.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 17:02:31 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: qemu-devel@nongnu.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v2] vfio: Include libgen.h for basename API
Date: Mon, 11 Dec 2023 17:02:28 -0800
Message-ID: <20231212010228.2701544-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=raj.khem@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Glibc has two implementation one based on POSIX which is used when
libgen.h is included and second implementation is GNU implementation
which is used when string.h is included. The functions are no identical
in behavior. Musl C library does not implement the GNU version, but it
has provided a declaration in string.h but this has been corrected in
latest musl [1] which exposes places where it was being used from
string.h to error out especially when -Wimplicit-function-declaration is
treated as error.

| ../qemu-8.1.2/hw/vfio/pci.c:3030:18: error: call to undeclared function 'basename'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
|  3030 |     group_name = basename(group_path);

clang-17 treats this warning as error by default

[1] https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
v2: Add missing link for [1]

 hw/vfio/pci.c      | 1 +
 hw/vfio/platform.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c62c02f7b6..f043c93b9e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <libgen.h>
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 8e3d4ac458..a835ab03be 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -16,6 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include <libgen.h>
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
-- 
2.43.0


