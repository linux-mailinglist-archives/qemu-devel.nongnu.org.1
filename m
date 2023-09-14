Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3177A0EC4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZZ-0002uC-C2; Thu, 14 Sep 2023 16:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZX-0002tw-UP
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZW-0001Vn-7P
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40473f1fe9fso9773255e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721856; x=1695326656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F866fnYal64jgJhD1WaHqOztZB6EhKD+Jyo2iWQ5ErA=;
 b=MCWc3QkSmuZ/hwcC0mKX22WvaApTmJUgUWn6YT1wT7AJMv9Ki+4tX7cBtL2U2vhvEm
 C2z3Qa+1fKp7l43dN1h0/cQagCAUvWgKNFP6iFxNWu+YS7FUGi2CfKkMjjqWTiepRXo6
 q0R/ML96nDWcmGSG65R7yD0/Ln/oM3AkQAck32FIJrX+yhNMQa3lYY2v1VvqFkTeZmvA
 Xe93HCnxoukH4yVaCmov4D5meMgxB4bdkrEimcHjuVKgw71tSEBEyVKpN/CktP+VCiRc
 /dcdNSPjLQ431ECRoTa5RIBqUvxt58k9O49WFQv/ZYmlQPfWyoAUEZtZTd2QsVEwnpOp
 G5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721856; x=1695326656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F866fnYal64jgJhD1WaHqOztZB6EhKD+Jyo2iWQ5ErA=;
 b=ZkZSREBSTz80A/4Noo2NZJWVwCMnHcPBNBSAjpSUJhEUFz954IzWhACgOyg4WjcQzO
 3a2h4N/clJisOpRk9rQk9DtaKNAh8r445JtfB5OL7I/AgseXXtlpaHNh9oFTFmMI5s0H
 +gZOayVDK27K0cJo3ZOeVcB9a9tX+DGKuq5AzfdsMjseO9HB60MPHQEecpAEWzrZSVDE
 6H/lPkTvgGOecdOD2O5TW+UrpfNmUf1ZC4sUAYzNCxN3lvs/ObUBk4Yq2JdEdr8vLSBv
 34pBPDspFzH2T8mkA5lv+1N4MP1jl77dgQO+gpUQ6wYp8VpJNCFD8c0HWwmNKWAf8CuF
 HA9A==
X-Gm-Message-State: AOJu0YwEGOhyRZd5dXtO9RG7QheX27Gw79Rz4slk0riEdFO7eF3i6pRG
 eyGCtCvt8EpUO9M9ngdOwsbvw+K7Hl8=
X-Google-Smtp-Source: AGHT+IEhYgYUGPUPP+Cvc5DgQBceASnC67Y8TFAjRmq5uNUHF+IHzaZ/e06rnZKVfecADMCNO2J8zw==
X-Received: by 2002:a7b:c3c2:0:b0:3fe:d448:511a with SMTP id
 t2-20020a7bc3c2000000b003fed448511amr5595823wmj.9.1694721856164; 
 Thu, 14 Sep 2023 13:04:16 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:15 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 08/23] bsd-user: Implement target_set_brk function in
 bsd-mem.c instead of os-syscall.c
Date: Thu, 14 Sep 2023 23:02:27 +0300
Message-ID: <20230914200242.20148-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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


