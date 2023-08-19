Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA887818A6
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZy-0008Ds-O6; Sat, 19 Aug 2023 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZv-0008D1-Bk
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZs-0004Np-Kb
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso1817072f8f.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438542; x=1693043342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JAfWqMnHgpL9IoIVe+auJYPOPEmTFIAYeHKJ4xSGEk=;
 b=mJ0iPUjOjLy8EjwDPfR1G3dBM3GbD1R0K2nVsqrcZ2TrVb3WHATR9mXYvMlI7bfHaR
 WLI0rXTWgvKXi6YNUoFhIiqefZ0ubcZMHIzLg+GNpQkyLACvvnbuVTDZ6xPlkhubtvCK
 e8hMt73iVM4hGaanpOfPucR4/f98SN/HB1RR/MUJEjpKUYclZCwDA1ilEZB4lz4yETai
 JXMdJGgvq3vW8Y6o1laZqWaGp9Kwcd5hbGbQXZNjw4jJbOVaYwLBbSrRyt2QG8qaemIr
 dmJ6QdzQnno+6aFUSP4Vj1SorEFPaz1YC3CxbwckafHXaAwxmVmRu57yLl9ggaFTpyHd
 MXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438542; x=1693043342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JAfWqMnHgpL9IoIVe+auJYPOPEmTFIAYeHKJ4xSGEk=;
 b=R5zC/djOQ5ljbGFtuKyyNZiSGT7sOkCwWG0wIiJSWQb2nXqmvWK+RsO23u95sAanDZ
 ATUINZAZInDH8b6WVN7JIwHii/WmBo/2PeXAkndreux8XA2w/r2KuTD/hySiuNp9zAoU
 JcJHiiCrW12yqKzErD8ZkhYodkq3yykl/dwjwWGBZn29UrgI4dn3fRnijdj+43nB1/lD
 ND8fNKrLHsElycFtgcZ3E6QaVGRHXzNqKXIJBzvvVeo39SrQ+jq3bJNIM6lZe9eodGBB
 aCuP6hxJhgYtPK33GopR74suVoYrMBPpO6wKQxzhuOFc6jxxT7eb1cWl1SORAv4mCScX
 iqCw==
X-Gm-Message-State: AOJu0YwZ4syOcxW5Y0geGB6ul1zKLTMvO+584VEpcLMBNLAmdze6a2/T
 8ajsVV0NaBmeQeLhMB8AJrerh7G2tA4=
X-Google-Smtp-Source: AGHT+IHzqmHnqQ0xwuh5wjhmaFMTbjxEB9vtylQox9UDBaZFysUCWYn/zETRvOojbJg4R2zVzuZ9gw==
X-Received: by 2002:adf:ec8a:0:b0:317:de66:259b with SMTP id
 z10-20020adfec8a000000b00317de66259bmr1123791wrn.15.1692438542476; 
 Sat, 19 Aug 2023 02:49:02 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:02 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 11/22] Introduce bsd-mem.h to the source tree
Date: Sat, 19 Aug 2023 11:47:55 +0200
Message-Id: <20230819094806.14965-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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

To preserve the copyright notice and help with the 'Author' info for
subsequent changes to the file.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 65 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 bsd-user/bsd-mem.h

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
new file mode 100644
index 0000000000..fed7b7cd80
--- /dev/null
+++ b/bsd-user/bsd-mem.h
@@ -0,0 +1,65 @@
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
+extern abi_ulong bsd_target_brk;
+extern abi_ulong bsd_target_original_brk;
+extern abi_ulong brk_page;
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
2.40.0


