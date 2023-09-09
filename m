Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E491E799AA0
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n2-0005wr-Qh; Sat, 09 Sep 2023 15:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mw-0005tx-63
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mt-0003DY-KK
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401b393df02so36662775e9.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288314; x=1694893114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFf4JunziSOD7sjN6pr2SlP9OXljzV+aLcAeDFfEgaE=;
 b=smz9SaVEYU7sUGpsbBHMXm7s7bm4LJxxQSgpLcPP+pxPlXYDqnJENiCN+sb0zFlUCc
 bYNVHeWAGPbLH+6c3340/ODqWRCUA6mdDtAi4KYMdjon2TKbNYBaVJoOs30w1DKBthdp
 zUxdblHb3MoXhR+w4vff21yCqobT+65Wy8LRrF0zQhB/Sk4ZfxVg2wEOV6Pfw4TYid+T
 WNQLBmR+Mp6mjzSyV8TFKB3Lqfh4dyTyoG9396lIAgpI7jiBzTOKTkWnJMxIqlLjQyFS
 O2hpkMnlKPYweDtB/3ka5g9rc72JjplzYJx6n0AM2hOMz7kzkRUMwxjddESmzukSsEIi
 7XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288314; x=1694893114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFf4JunziSOD7sjN6pr2SlP9OXljzV+aLcAeDFfEgaE=;
 b=SApn55veIDCGVy/W44h5tK5AaCmyWPMS+o+WMvVVsoH5atQhytjr09bBvpmhPDE1Rb
 zzGgAA07zsvGxBa9ihPiQ98elEscpvDd64T9TyTtNFAlIrbkLNSYVWqysZFfST3st6Hc
 p+KC2Ja0XIGRAqyd6MoPIOVdqwHFwnlehTcFoDJJ2eqyakXLkII+8Z/eXfZNBpu2iomy
 ap24K37aLZi6vhjqgkpXmHsTXYIoBX3ZOU+ZHYstsaCtDvEsM7K/Wb3MIVgA+NzSu/Cj
 WfIMuztpuLDiZDlmAIeBJtAUSJM9wt+1zycCej38Y7cQ82D/3szxsYCp2OQuGpuASo15
 l+4Q==
X-Gm-Message-State: AOJu0YwxkaUpBzogVJyqEG3L34hXALxVV0a+sbxWRVPOaaC4Y6HmwGZQ
 OLDvwxLT29mCWPfz5Q6zT/nA/JBREns=
X-Google-Smtp-Source: AGHT+IEuixjfKzHphZC/dhpsZ96Z04hJ97+Mw4hyII4JNk60cdDap55Wfb9da/D/OJtgdI4a3QmtIg==
X-Received: by 2002:a05:600c:2945:b0:401:c297:affb with SMTP id
 n5-20020a05600c294500b00401c297affbmr5110888wmd.37.1694288313748; 
 Sat, 09 Sep 2023 12:38:33 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 08/23] bsd-user: Implement target_set_brk function in
 bsd-mem.c instead of os-syscall.c
Date: Sat,  9 Sep 2023 22:36:49 +0300
Message-ID: <20230909193704.1827-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
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
2.42.0


