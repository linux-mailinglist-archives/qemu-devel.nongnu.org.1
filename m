Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 830057818AA
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZu-0008Cd-Rz; Sat, 19 Aug 2023 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZj-00087E-GW
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZg-0004KN-EZ
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-319559fd67dso1572214f8f.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438531; x=1693043331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hO/8BCsb7ELKSZB3NHN4QJcV1kJINuEog0PQLfxugV0=;
 b=grVd1FJ6mqsDLruJ6Y/yf71AW14vWj3cHVFedjMMvlc3/dctxopT+6FOGEB+w/UWEJ
 kry3avODMkou4ZLGntSuNGsiXYmiV+aQCuFqn2n2OOHSnjHRD6PpvplHa5BfvjpNOPtF
 lBTsHR7qNYRRqlIdPzMZrGvShzKFziIWgBTOhlMtOiU7ltVo8lLya0KoU04ll3hZcd9F
 UGcsV1HXtPHSMgK0z7GHi7LtDpKN4FXCCmISJ3ElERMnCFcu6oIHn+iD+NIghiQITYvw
 sXRw4QRA5IH0Ya7CVtaOPgl061snBk5SsiYpRm0hKkNCcNsHY8h3sxQfwLn2RTHK68TI
 wpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438531; x=1693043331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hO/8BCsb7ELKSZB3NHN4QJcV1kJINuEog0PQLfxugV0=;
 b=LBb/aZNZ46GNWlu6wV24JGSV+BPj4uDSOjglHobvl8OVtRoDSC52G6N4xv7kPGjR7H
 IZFJSZKAYL+xMZb1iBGhG4k5q+AcNiA7dO/hLt07cHqtQYUnhvdPbgnlnD0+hG3XcdvY
 7E14t4Sa3f9fdWm/b48W7tbaxALXhf224Z8ccRwQZHHW6yJpR3BNPggfIQxzXQmozleg
 YxLOeKssUaDnmC7/VHj/6VGHicE4jOtOjomchljxfVAWNXv3YmYdKQetXl2LLKZ0epKB
 DWZ4QdtPB3cx9Zt+F0hC4DrA1D8HewwTgyzxRI/i4aOZ2JhGr7YDJIJdGna4OJa3/K2T
 FZMg==
X-Gm-Message-State: AOJu0Yw7YqIVDJJoVj1vXznGZLjD376THtrR0X4hX6effFw6aSH7cMlp
 A26KExZtP0wRHRNeNhtcaubdED2mYUY=
X-Google-Smtp-Source: AGHT+IFix/aUg+8SRyBPyEsrw2c/nzIZRsMVOj0x2t+GdOhV849QGsy2uefTpG5YWfocEkSh56+R7g==
X-Received: by 2002:adf:ef12:0:b0:314:3b1f:8ea2 with SMTP id
 e18-20020adfef12000000b003143b1f8ea2mr1191691wro.6.1692438530856; 
 Sat, 19 Aug 2023 02:48:50 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:50 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 08/22] Implement target_set_brk function in bsd-mem.c instead
 of os-syscall.c
Date: Sat, 19 Aug 2023 11:47:52 +0200
Message-Id: <20230819094806.14965-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42d.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Co-authored-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.c            | 38 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index e69de29bb2..6c123abf04 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -0,0 +1,38 @@
+/*
+ *  memory management system conversion routines
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
+#include "qemu/osdep.h"
+
+#include <sys/ipc.h>
+#include <sys/shm.h>
+
+#include "qemu.h"
+#include "qemu-bsd.h"
+
+struct bsd_shm_regions bsd_shm_regions[N_BSD_SHM_REGIONS];
+
+abi_ulong bsd_target_brk;
+abi_ulong bsd_target_original_brk;
+abi_ulong brk_page;
+
+void target_set_brk(abi_ulong new_brk)
+{
+
+    bsd_target_original_brk = bsd_target_brk = HOST_PAGE_ALIGN(new_brk);
+    brk_page = HOST_PAGE_ALIGN(bsd_target_brk);
+}
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 2920370ad2..c0a22eb746 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -59,10 +59,6 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt);
 safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
     off_t, offset);
 
-void target_set_brk(abi_ulong new_brk)
-{
-}
-
 /*
  * errno conversion.
  */
-- 
2.40.0


