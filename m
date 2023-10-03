Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102717B7517
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnova-0004Fe-PL; Tue, 03 Oct 2023 19:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovY-0004FE-BK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:44 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovV-0007Qe-6H
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:44 -0400
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-79faf4210b2so57699239f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376140; x=1696980940;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enWxn1UiA0RiRwD9f+pbmm7z2XRqILatx/jv7cDD9xY=;
 b=V+7rP5znmNxti0xymyZZZW52NeCzjJAwI7ExzqGzCWg5kyUy5heV7yaOHTdw+GLNFT
 QD4mR169sgzWC+5e6+vRHcaZiGxn5XfWY1F1JoJN9eolFSWibttR2fWM1B+0YAJpmtm5
 ioPLcHEPaI6nVLrvo8MrG/vEi3q5HOF3zms5qxpUPnqfBw6O+TF/mya9iZVH1Ejv44HY
 w0pmu+ZGmOgr2oWC0uMI5kHvctmrvW18bD4MroEdJ6xFa7IaHftHrYmJdWa7wfF2sSIK
 +mJBUCUky4Rh0cVMUnfnmzHbl0dHeEJULV2yVqFuH4oCeFn+e2ynUSZl1yzs6EIo7YkG
 XLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376140; x=1696980940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enWxn1UiA0RiRwD9f+pbmm7z2XRqILatx/jv7cDD9xY=;
 b=U2MHQ0wCQdm72gdGPFwq1/vmnVULrqNRHP0hPydjg+MpraPJhEhrXGHOqH6kBVm5LX
 ls619OWdEv3UInNbnQWFIn31t5o8mfKpKN2uPL9NShds4X8HQudWvTjoccdmW4ZTm5mt
 B6mvjWhwzw6mtb2KhWU8//iij3uILzZmZtNTV4HWra6d3/G3/m4pmRdkNzOyFzfMPEva
 jil0+EBj+/xddNK7Ks5KSaFBXQaiBB+J1+IAjA0jOifgbqXp0c/ppd+8KfknlJRWzKT4
 JsTq28RQl0GwogFlFqnFaOwK2cavHhjl/EBHnxmeSooC6JBpAdTETdjoCo5n2ILOmxmK
 L8bg==
X-Gm-Message-State: AOJu0YwWfHeEPANBGOwP7/cFPwKn9GEoZOeMpeiYXjg0dhPx7hj02P54
 AvIulaelxt6y4aCYP5ITc4LFwElSSB8QSe4iF/ky4GGQ
X-Google-Smtp-Source: AGHT+IG1PN+TTC13IgUFUMmXjQSeDrl8VXPgpUcimciK6K0BCojl31ibeyV1qW42AtXaoy+fBavJrw==
X-Received: by 2002:a5d:9943:0:b0:79f:d194:d6e2 with SMTP id
 v3-20020a5d9943000000b0079fd194d6e2mr1054224ios.10.1696376139827; 
 Tue, 03 Oct 2023 16:35:39 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 36/51] bsd-user: Implement target_set_brk function in bsd-mem.c
 instead of os-syscall.c
Date: Tue,  3 Oct 2023 17:32:00 -0600
Message-ID: <20231003233215.95557-37-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d44;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd44.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20230925182709.4834-9-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.c            | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index e69de29bb2d..8834ab2e588 100644
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
index 5fb42b2c218..c9d34b59bbe 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -67,10 +67,6 @@ safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
 safe_syscall6(pid_t, wait6, idtype_t, idtype, id_t, id, int *, status, int,
     options, struct __wrusage *, wrusage, siginfo_t *, infop);
 
-void target_set_brk(abi_ulong new_brk)
-{
-}
-
 /*
  * errno conversion.
  */
-- 
2.41.0


