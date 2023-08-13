Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B247277A6BE
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpq-0008CM-6f; Sun, 13 Aug 2023 10:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpV-00088g-El
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpS-0000qn-4N
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:28 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3177f520802so2659374f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935944; x=1692540744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N061FeldVaX4BPj8mc2L/kWBPacnM9wuo1qQS1JmhVg=;
 b=EBS9jbHPMqVt4WdG8anZspNFrDjbXGAojWFd65omPkbUNi4nj45QLCYKC5ddFRTnuy
 IJS1gJ5QgkNGRJLrhq4G5eML/mvdiKvqhBeYJGBtIP44+7DvfLfcr3owGbLptuFN1hG6
 Rr0/QrNcvq0dJnXZtEnIe/xmH8J7NiOUYuvTMOH9z5EsAjrx1vtfqoVeTeavjrfRnr0T
 a3FONE1tR2RDJFHUPZOXz/7srG7+YVZcQ8uakBn/s7gPsMNxdVw5Gi2Dx8d5qaIPrRX1
 NECHjYdyasSU67JpZvcH6EmPT20bvyOLe13aIi1ZDG2X+Q3/4nJEp2/die0tg4ZZZ2ry
 x08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935944; x=1692540744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N061FeldVaX4BPj8mc2L/kWBPacnM9wuo1qQS1JmhVg=;
 b=FAyHtCyoeYUmj7w1e0uk30GYl7pnLlcMdVYri0TyLBU70ylcmV/gCcM+p8jofpJvxA
 hh9QibMpNxlQR8P0+TypMUqhoCHHa3wtEPvHhTojO9pHyoAs3NrCDmSXxxwFncp/vUDI
 n3MLIR5cRZBudO5LBfjKhbE+P7ES7U+ZPMC62ptMpWpUUpwRl9TjHRZ45QmChcxjtLV5
 PjseJKvuFjq8ogsPXY2EKoRicoZigHnItOd4BdFnaS/TCrR87zXIqgK+QPum7djL3zbm
 Zxd/kBzsAH1Cfu8F6oKYBmzft8026FJgxrTTOFjoAHb2AVNvFs+DPJ+B9vt7VJIVKaUy
 laRA==
X-Gm-Message-State: AOJu0Yz3Hg84wFips5oOQUeiiXhdkBMLCuxWNkrZGpQmi8vHIdqYpwYC
 AWi7UQobTV5JlCz+VIlKgwcsZQtXEZE=
X-Google-Smtp-Source: AGHT+IGHiYoJwY3lYOAaGg4clz8+bK7bglTzLC2qhR+/aHdR1RCzbT61VibvS+2apLFTdBX7D9CmlA==
X-Received: by 2002:adf:f384:0:b0:317:de66:259b with SMTP id
 m4-20020adff384000000b00317de66259bmr8466445wro.15.1691935943022; 
 Sun, 13 Aug 2023 07:12:23 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:22 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 12/32] Implement h2t_freebsd11_stat h2t_freebsd_nstat
Date: Sun, 13 Aug 2023 05:09:53 +0200
Message-Id: <20230813031013.1743-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x435.google.com
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

Implement the stat conversion functions:
h2t_freebsd11_stat
h2t_freebsd_nstat

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


