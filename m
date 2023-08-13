Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A166D77AAFC
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzg-0007oH-Km; Sun, 13 Aug 2023 15:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGze-0007ne-55
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzc-0002OX-BE
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe12820bffso33126375e9.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955794; x=1692560594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N061FeldVaX4BPj8mc2L/kWBPacnM9wuo1qQS1JmhVg=;
 b=l/JlncKYX/94CfdbvX9+k1CpW+AS+QeJOYHo33QY3h0Gr9kyE9GbScr6/CXOMxP1e5
 g5A33lPrdJZMAAGSGAfU8uxHbBa9X2t9kOIn71VOQebG9XnkNzKXEuStzZuSRk4O9GMp
 5o2NoaqrNR97eQLVKSS3LX0bQN+YtdgXwzTWr1S5yP7oW7Z5ofTD2MNpAuwZwJuvsw75
 DwM5j7/SmchBLtTUjU7RmDig71d+InXXayzM5Mdt1bRvWydXbr5k3/FkoOgh636J/SlI
 n1K3fOI3erdpDpBaN/O+9b8/lUvUI7KXOJaVQRXqIeeJgMm1U6034PE8XDsPuVBBo4Js
 J2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955794; x=1692560594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N061FeldVaX4BPj8mc2L/kWBPacnM9wuo1qQS1JmhVg=;
 b=ba52VewGs1KsYidloXqrMIz+ii2Z7zXuDMZraI2tzCdMzks2IsE3PG0CMQ7rr3smQM
 8ZzVKJzpyLnuZX0a5Fb7wNu3dZ2Vb/Ycpnz61RXGrXvGt9RFIZTDBhNeimY2N2xY2LIk
 C3mm0uvpl2g4C2NgVFmw+qUiJeZvVhBszFsq3zJK2pp8DjUBsASOKJewLLul5vv62QYM
 O8V+tbTsDtBQR6XzKZuwNxNieuoOf9Rl+4YfE0j4R3/tU6IpnfOdUXzfzx3vX0g17blC
 uhsN9JyykG9uwA+zKY0wwRKkWTGBAM/vgScBjJQ9ZjsF8Osj5qkDjTyT9ulkSFgkDtjy
 ocCw==
X-Gm-Message-State: AOJu0Yw6ZgSbeAbgRhr9CqHyBX7Elqu2UbGXpBEnBH9v1lpPgsAQ1V0h
 MUAuKGo5NYIL6/e9B/In64hG8wUK1t4=
X-Google-Smtp-Source: AGHT+IFE7/G3g5sTYPXvcN+dDP7y9CRn5ma7Hf3Qr4tHno5mpZ4krHlAYYOIgPMj+XncOJFBke1Mcw==
X-Received: by 2002:a1c:7703:0:b0:3fb:403d:90c0 with SMTP id
 t3-20020a1c7703000000b003fb403d90c0mr6160180wmi.39.1691955794645; 
 Sun, 13 Aug 2023 12:43:14 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:14 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 12/32] Implement h2t_freebsd11_stat h2t_freebsd_nstat
Date: Sun, 13 Aug 2023 10:41:33 +0200
Message-Id: <20230813084153.6510-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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


