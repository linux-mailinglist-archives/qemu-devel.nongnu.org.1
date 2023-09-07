Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE6799644
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfL-000118-LV; Sat, 09 Sep 2023 00:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfI-00010T-3K
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfF-0002wK-KG
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-307d20548adso2659627f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234023; x=1694838823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFf4JunziSOD7sjN6pr2SlP9OXljzV+aLcAeDFfEgaE=;
 b=YrvXXuPUV8InD3K71YBcbGtW0ntBxFF+glTcFYWtWSgsitPSEjPbo70M+RteGO8zy5
 U9fG3f9f2nnLeft7NnzhPJ8bkNInhZ+XIl/4P/VlniP8/dv9NCql2D2fO4lfRwF4nlQG
 bcc+XG+7ianLOA48bZRtfuuGsH/gupIgDjHz4UA5UwZw/o31V94ywXAagdMvZtdE1CQL
 0aCoss+o2nb+kNYA4uubtf3fYpoI5dWUNysANkP9dHOvTu9b0O8MdjwVjjDW2Ig+r1F+
 nXbzXJcXGMTA2BrNNKM3CKSPfSomfA/sxkQaLFBlJbp1xNPZK2Imuhdzobg0nJS8E8eW
 nAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234023; x=1694838823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFf4JunziSOD7sjN6pr2SlP9OXljzV+aLcAeDFfEgaE=;
 b=JJLZhCo/p7G/w4C2mkoR3mXrPhZ+ynuBjK7EBpDkrurBl0VyLPMyVBPkOasvm1XTuN
 P1/sAkGFUum6v0CcpRE54rGzCQIie3oVNtPqzU1MvL9zmP7SKtQ/FF51r0AzCNQ9GCM5
 VUPutyCae4hC7/WRlyzHUlaV+WpxyOnJVUem3JzhLignDwEUTIwUW2LyS1uwXC/hkHqS
 2YQJ6bDHEN8MG6kBSjoCGELkSRpYTMV/h6wAa2v/cSpFXIh1HW700YMSqW2Pcodd/Cir
 cSrQIdTjP2/CrkSIKtBzRgDnTEkYZKPoo3upYm9lVsxA5yrjOFW5WZvczpoFS3zt5Tcm
 Tl0Q==
X-Gm-Message-State: AOJu0YxSY+z4fl3RAA7N/krdAT+cnY2zNOUSu/b7H72idUuCoE+b7svR
 Mgqm2WkDNiC6kcmotN8yjtGcDTJH4HY=
X-Google-Smtp-Source: AGHT+IFZwRHMp1efhjo/w5B+yDh1TImdA0XRvMVEBJtPkmoUDRWl+8ccfO6AGNsF9FBactzDL1nvnA==
X-Received: by 2002:a5d:456b:0:b0:319:68ba:7c8e with SMTP id
 a11-20020a5d456b000000b0031968ba7c8emr3537466wrc.38.1694234023633; 
 Fri, 08 Sep 2023 21:33:43 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:43 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 08/23] bsd-user: Implement target_set_brk function in
 bsd-mem.c instead of os-syscall.c
Date: Thu,  7 Sep 2023 09:42:47 +0200
Message-ID: <20230907074302.79234-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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


