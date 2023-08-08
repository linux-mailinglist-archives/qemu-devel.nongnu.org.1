Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3DB7740CF
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDY-00023Y-CL; Tue, 08 Aug 2023 13:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDV-0001wA-61
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDT-0003HD-8k
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe4b45a336so34063425e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514593; x=1692119393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWdOTFt4f+afS8Gf1cP+Ss1h3B7hDQKDrDxkrbbQ9wY=;
 b=MrFV9kwdvTKcDVX8X9Vn9ETGfK8H5k8saMciuDWKEcdNwokAzw6zp5cF1Mv/rflU/N
 ej1E0W3+C3Nfey7IDsgqzIstw4pohIWJ9YMrhy+zpbxcYdqYz6T62zkxnkPxj1zKNYn5
 eJFxCH6jOaAD2UD7CpcMVEFM+dv2JnZnyyx0qGVgDwqw2GfX3kVMXBwsqryXArkFHGiE
 lpOjqkce7jMXR2JvJgIsI4M3342DbnUnMdhwaBoAJ+JZnBVsdLVLgLEbENdrOWt7JM7A
 D3+qKx5aRQTmZzMbQ8ftxGXST9UksretY65DuiXAygi6w6gqXzXxTbyqpRjn9SKnlr23
 blew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514593; x=1692119393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWdOTFt4f+afS8Gf1cP+Ss1h3B7hDQKDrDxkrbbQ9wY=;
 b=CainPdMDkGHWZWwd5DgA5FrScbJeCAhZErwV9PWMeRz71wrnEBws10o3ZAbV/Qbe7q
 N/ZyYEkSoQtNBgJVncfSfWjDxsuq4Mh9I3OOpSeXEBkiXaDRERxMcgaN1/MaDYeA95wK
 yyeqhevOg6cYzM8q68V4lx3vI50s+MOE+9gxBogX9zf+liE85hsaY0VXwauMAK0BkmUH
 /S0kaUpjWdzhPOCl9If957knltQuPl5SsjICkQLiGLxAry6cYXCXAuLWJTZfYJoL0yhP
 W2bbWgYMN+Lu8/e8HVFL3lI7ZHQV73eSYGXsfPDSq3zWV5VTAbrsLkJhy/Nc7jQHHTcu
 LSCA==
X-Gm-Message-State: AOJu0YzNBjYSqfwcM2A/dP+4005uo6K5do5YvARmXtKU0pSapdQE9VwE
 DU1H14mky111B9Q0MueZYOWqMkApfgrBWA==
X-Google-Smtp-Source: AGHT+IFQ6WhttzaDWXRjOKrrNbS2CRthF/WLMEIpiZfCAVbHmRetY5V84aGlcgIgmtKho8/Oj5+pRg==
X-Received: by 2002:a5d:6050:0:b0:317:9537:d746 with SMTP id
 j16-20020a5d6050000000b003179537d746mr62780wrt.2.1691514593144; 
 Tue, 08 Aug 2023 10:09:53 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:52 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 13/33] Implement host-target convertion functions
Date: Tue,  8 Aug 2023 08:07:55 +0200
Message-Id: <20230808060815.9001-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Implement the stat converstion functions:
h2t_freebsd11_stat
h2t_freebsd_nstat

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 bsd-user/freebsd/os-stat.c

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
new file mode 100644
index 0000000000..8c73f7402c
--- /dev/null
+++ b/bsd-user/freebsd/os-stat.c
@@ -0,0 +1,94 @@
+/*
+ *  FreeBSD stat related conversion routines
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
+#include "qemu.h"
+
+/*
+ * stat conversion
+ */
+abi_long h2t_freebsd11_stat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st)
+{
+    struct target_freebsd11_stat *target_st;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_st, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    memset(target_st, 0, sizeof(*target_st));
+    __put_user(host_st->st_dev, &target_st->st_dev);
+    __put_user(host_st->st_ino, &target_st->st_ino);
+    __put_user(host_st->st_mode, &target_st->st_mode);
+    __put_user(host_st->st_nlink, &target_st->st_nlink);
+    __put_user(host_st->st_uid, &target_st->st_uid);
+    __put_user(host_st->st_gid, &target_st->st_gid);
+    __put_user(host_st->st_rdev, &target_st->st_rdev);
+    __put_user(host_st->st_atim.tv_sec, &target_st->st_atim.tv_sec);
+    __put_user(host_st->st_atim.tv_nsec, &target_st->st_atim.tv_nsec);
+    __put_user(host_st->st_mtim.tv_sec, &target_st->st_mtim.tv_sec);
+    __put_user(host_st->st_mtim.tv_nsec, &target_st->st_mtim.tv_nsec);
+    __put_user(host_st->st_ctim.tv_sec, &target_st->st_ctim.tv_sec);
+    __put_user(host_st->st_ctim.tv_nsec, &target_st->st_ctim.tv_nsec);
+    __put_user(host_st->st_size, &target_st->st_size);
+    __put_user(host_st->st_blocks, &target_st->st_blocks);
+    __put_user(host_st->st_blksize, &target_st->st_blksize);
+    __put_user(host_st->st_flags, &target_st->st_flags);
+    __put_user(host_st->st_gen, &target_st->st_gen);
+    /* st_lspare not used */
+    __put_user(host_st->st_birthtim.tv_sec, &target_st->st_birthtim.tv_sec);
+    __put_user(host_st->st_birthtim.tv_nsec, &target_st->st_birthtim.tv_nsec);
+    unlock_user_struct(target_st, target_addr, 1);
+
+    return 0;
+}
+
+abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st)
+{
+    struct target_freebsd11_nstat *target_st;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_st, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    memset(target_st, 0, sizeof(*target_st));
+    __put_user(host_st->st_dev, &target_st->st_dev);
+    __put_user(host_st->st_ino, &target_st->st_ino);
+    __put_user(host_st->st_mode, &target_st->st_mode);
+    __put_user(host_st->st_nlink, &target_st->st_nlink);
+    __put_user(host_st->st_uid, &target_st->st_uid);
+    __put_user(host_st->st_gid, &target_st->st_gid);
+    __put_user(host_st->st_rdev, &target_st->st_rdev);
+    __put_user(host_st->st_atim.tv_sec, &target_st->st_atim.tv_sec);
+    __put_user(host_st->st_atim.tv_nsec, &target_st->st_atim.tv_nsec);
+    __put_user(host_st->st_mtim.tv_sec, &target_st->st_mtim.tv_sec);
+    __put_user(host_st->st_mtim.tv_nsec, &target_st->st_mtim.tv_nsec);
+    __put_user(host_st->st_ctim.tv_sec, &target_st->st_ctim.tv_sec);
+    __put_user(host_st->st_ctim.tv_nsec, &target_st->st_ctim.tv_nsec);
+    __put_user(host_st->st_size, &target_st->st_size);
+    __put_user(host_st->st_blocks, &target_st->st_blocks);
+    __put_user(host_st->st_blksize, &target_st->st_blksize);
+    __put_user(host_st->st_flags, &target_st->st_flags);
+    __put_user(host_st->st_gen, &target_st->st_gen);
+    __put_user(host_st->st_birthtim.tv_sec, &target_st->st_birthtim.tv_sec);
+    __put_user(host_st->st_birthtim.tv_nsec, &target_st->st_birthtim.tv_nsec);
+    unlock_user_struct(target_st, target_addr, 1);
+
+    return 0;
+}
+
-- 
2.40.0


