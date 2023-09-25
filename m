Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E2B7ADEC8
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:31:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKC-0008N8-Sh; Mon, 25 Sep 2023 14:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK6-0008DW-7f
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK4-0007ko-8k
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:45 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32333fb6beeso191066f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666522; x=1696271322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zuun86h4+Ki7eEXQiRwiN35p7fie3LoCiJTVqacEJnk=;
 b=UCOP7AKBMYMp4ktGtuQ5DK1lVJ3G20xwGGP86TavUsJpTyP+X5xwZ2krtnB77Ej7E8
 2fKAbS55Gqb9QO090bRptNMgmOLKUlf3ETAiRN6Sn2sNQ9ov0T2RfZjPoDA0nLLQwY4/
 0TaFFxUnl10Bk8ZtL/XyddFsOK9hHcvaGOZEVOQUzlTPh/jG2+Tqa5p7KqPF3AHwsuvd
 xk6aqbOEiUubwVgW72csig1L2D8aDn/p1XjEGLBxJCSxTNCaPJpmK9AV2H2eL9oHIpti
 CbOPiaZ/Hs1DwqL5XxZ8Zk8sw8dqZEd0aIV3MjcCeSW7oDs/hm7qjG/aMxjnuRkl5fBk
 Wkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666522; x=1696271322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zuun86h4+Ki7eEXQiRwiN35p7fie3LoCiJTVqacEJnk=;
 b=TmxhR8xFVMVfRLpu7oO6Hwa6IBsocdTMzNMoNPP9R9bnt0S1yDH5EDzi5XwcUbAnip
 W08gXguKP8ArbmwwkwbB5KTnam87q/dvaHO1vlwvlc/oNskQ8mIuA+TvUDyDVjbRGEqa
 sZGLrG88tiyYqYrI/6pP6SpNg9pO4aF5A1CW2Wi7KDq7oMx2Pw7KZeus4D3fz3EoJs5r
 s3/5+BvqqmDW2OFRHTSPxnv0t0l2scYvb4xPeDACHKudCQcFFUSZ56G+qsq0gVp1vump
 ZDYgo2Pwp1XfCIybd07ULYAEygY6unuOQiWIeafzmCdp8f6YLTdI154/W8vYzd24nsXG
 9zdA==
X-Gm-Message-State: AOJu0YxyZE6xQajve6Zd0EMeL/xfhQqnMq39B3UPf0frNbjK0amn1sP1
 UstH7Suf2N1N9B5Orp2d8QQJGuzKGpA=
X-Google-Smtp-Source: AGHT+IHS5m6gT3nIscK1qyodPO1eiiiDcMwBe81UW0YK09rOiWqiaRkFrJACi6H+HEzMCULCncM4fg==
X-Received: by 2002:a5d:52c9:0:b0:314:3e77:f210 with SMTP id
 r9-20020a5d52c9000000b003143e77f210mr6082787wrv.59.1695666522472; 
 Mon, 25 Sep 2023 11:28:42 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 08/23] bsd-user: Implement target_set_brk function in
 bsd-mem.c instead of os-syscall.c
Date: Mon, 25 Sep 2023 21:26:54 +0300
Message-ID: <20230925182709.4834-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
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


