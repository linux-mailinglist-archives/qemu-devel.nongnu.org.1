Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DF7A0EB2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZq-0003Fv-81; Thu, 14 Sep 2023 16:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZo-0003CB-IH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZa-0001Ya-JO
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-403012f27e1so14282845e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721861; x=1695326661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5y+mDYHYGwFH7Ie7hyZags2xvGxi9R9xwWRldskuV4=;
 b=KzyWUoqXUOI7XquBAAZtfHryY5AtzAZxBv+b1eML9J6iEXWLS36fvXXJ8JRpZk4+dD
 d1ZCiHesIaBRCe3TvQrRLpUEOXa4CXfb0XdXTh8ucpWwHhVFUfNeV6nr/QwyvVjWdDnU
 x27KmNcWqijHN39cDlXHAYPr3+dWn7c7lJbZuGFz6sf3Ut4zDWHL/5YybkCTZxTXUT1L
 CqymwDG2juXSEXEwIQ6K7V2JaIeQYsVTY+ycagJch6lzxrWGmFXXNvWl7e70JZFTgVai
 kNDemC3NclaRkl/ic+BG3F72UgZU1wUavAarEZVYIkqLTPhJt1PAeYjHfd0ywTcdR+Fb
 IqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721861; x=1695326661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5y+mDYHYGwFH7Ie7hyZags2xvGxi9R9xwWRldskuV4=;
 b=G9qWmh1301ntPfUfNzQGMP3m2tFMXyVvaCGiijEIDKS5R+5s2S7HEKMwZdses37FdI
 Ec7hhxSylRaIt+BlQZULrStFJBCqNRl/l4Dp5Jt57DBdLRMvX099UrPBMB36x8If6+UY
 J+3R72LfK1aCEGWYbU/kykLQzZtFsSQgXvsEqxjYLpK3e/y/gddburWLHIYhTaxtBAbr
 4ye5mYe7svRCNtwH4QEIG+yPzXlqVsJyrqMjk/vEKpilzij0yj79LoYjYiB/JXeaPPLh
 0D0m/G0eVux8loozSVW6qKEfHQnKnwMM1quooaHfOkTnu+QacGSB6nDIBLn6hSkrg46d
 Wjew==
X-Gm-Message-State: AOJu0Yw9IaS2dLgZN4Qzo8J+YSXG7i8HCQSUGfwiU6lUHBj55xunewPV
 R12f9HSFpKng+svQaMURRSu5HcXemxY=
X-Google-Smtp-Source: AGHT+IEcPRq5nvyRRpRxycFgXIIDS0pP+dGzmmzOkRyHyZ8o2owzIFXFgjWzxns0odub/aqutT/eow==
X-Received: by 2002:a05:600c:152:b0:400:57d1:4913 with SMTP id
 w18-20020a05600c015200b0040057d14913mr5536070wmm.9.1694721860844; 
 Thu, 14 Sep 2023 13:04:20 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:20 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 11/23] bsd-user: Introduce bsd-mem.h to the source tree
Date: Thu, 14 Sep 2023 23:02:30 +0300
Message-ID: <20230914200242.20148-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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

Preserve the copyright notice and help with the 'Author' info for
subsequent changes to the file.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 64 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 bsd-user/bsd-mem.h

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
new file mode 100644
index 0000000000..d865e0807d
--- /dev/null
+++ b/bsd-user/bsd-mem.h
@@ -0,0 +1,64 @@
+/*
+ *  memory management system call shims and definitions
+ *
+ *  Copyright (c) 2013-15 Stacey D. Son
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
+
+/*
+ * Copyright (c) 1982, 1986, 1993
+ *      The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef BSD_USER_BSD_MEM_H
+#define BSD_USER_BSD_MEM_H
+
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/mman.h>
+#include <sys/shm.h>
+#include <fcntl.h>
+
+#include "qemu-bsd.h"
+
+extern struct bsd_shm_regions bsd_shm_regions[];
+extern abi_ulong target_brk;
+extern abi_ulong initial_target_brk;
+
+#endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index c0a22eb746..7e2a395e0f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -35,6 +35,7 @@
 
 /* BSD independent syscall shims */
 #include "bsd-file.h"
+#include "bsd-mem.h"
 #include "bsd-proc.h"
 
 /* *BSD dependent syscall shims */
-- 
2.42.0


