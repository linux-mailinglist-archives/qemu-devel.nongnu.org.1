Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B967A0F2C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAs-0003NQ-AH; Thu, 14 Sep 2023 16:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAf-0003Ct-Sw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAe-0006Kr-2J
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso1280201f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724158; x=1695328958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zuun86h4+Ki7eEXQiRwiN35p7fie3LoCiJTVqacEJnk=;
 b=fif4YFciEZshgIk6GV4FdVMiZ9dP+zVYslbvp8o24fj3C2NKU+w2VWD5JnDLr2ybNA
 7tNbEC7HKKE72ps4y1ZBsfN+S148fsoPBCdre3BNBpNMCcmucoHbdV6yUthBjrnqBPse
 8DWewfHcaYSkd67/6rqqYtjWFNOyeLAZmN7H24HFKvQInGk7SbztWLoWmnbDw2LRwfgi
 JgghbOGSMmky4TWbTc3rQl2V2aIXt2h9IAbLQhWDh5DiugUvHlAh42BtiIyIXu7QXjdd
 WSvMiUFMkJHs0M3W05UWJfhehxd5ndFKX+TINHmnREacf3ZMgjfnvAvBd3eXDmf+lOhv
 eiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724158; x=1695328958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zuun86h4+Ki7eEXQiRwiN35p7fie3LoCiJTVqacEJnk=;
 b=Tgx8rUCNpO8JchGRujzwvyS2vAbibpV4tprjmXg2o3aVNZzOCE2d3asZ8ZlO9/WbtE
 sywKbC/ZdEFELO4dX7LT68fBqdy1g0aGVfElzJuYvmguC2m1eue38C40MlOI6KW9Xmfu
 ymBUoIDDXWVS67nkecwIcfybZPg1FtRDkuHoXmFZ+v4+jYcDkdCUYzuyik679fnpKSD8
 SJjOns12sr39nD1j+qXp3/nKKSz0NcEuMn1bvRynpCResydF0NZ/idGuK3+D1ksH4Vtb
 IwKMY/zVKjIFLw2aN0acCY7gP0b+GuRRwOltxmBcV6HnppjlGTWX9FUBmpzj7QYV8HDt
 Uygg==
X-Gm-Message-State: AOJu0YwulqCdNvs+gLx5n+ZB48KINPSKrIKzDJPF+iWb0Q7nwb/a0x6o
 CNLyDfbsvBxvnfoy/A4YFi+wL/Y7eCo=
X-Google-Smtp-Source: AGHT+IH8PM6sXMRAIzIVBf7a/tGjf13xaSSf0DU9fFPwMRxoc/1cWn315Vpqd3WT93hZoq1OQEddOw==
X-Received: by 2002:a5d:538f:0:b0:319:67da:ed68 with SMTP id
 d15-20020a5d538f000000b0031967daed68mr5548894wrv.7.1694724158068; 
 Thu, 14 Sep 2023 13:42:38 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 08/23] bsd-user: Implement target_set_brk function in
 bsd-mem.c instead of os-syscall.c
Date: Thu, 14 Sep 2023 23:40:52 +0300
Message-ID: <20230914204107.23778-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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

The definitions and variables names matches the corresponding ones in
linux-user/syscall.c, for making later implementation of do_obreak easier

Co-authored-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.c            | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index e69de29bb2..8834ab2e58 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -0,0 +1,32 @@
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
+#include "qemu.h"
+#include "qemu-bsd.h"
+
+struct bsd_shm_regions bsd_shm_regions[N_BSD_SHM_REGIONS];
+
+abi_ulong target_brk;
+abi_ulong initial_target_brk;
+
+void target_set_brk(abi_ulong new_brk)
+{
+    target_brk = TARGET_PAGE_ALIGN(new_brk);
+    initial_target_brk = target_brk;
+}
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ae92a2314c..4c99760a21 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -60,10 +60,6 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt);
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
2.42.0


