Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D83F7ADEB8
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKI-0000JP-VO; Mon, 25 Sep 2023 14:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKA-0008Pz-4c
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK7-0007oH-Vp
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31f7638be6eso6818940f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666526; x=1696271326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K19uu8/17P76Q44mQCDZAyL1sOi2UHp67TYKWHLTGQs=;
 b=LvAMN74pwHPT81kE921/wYL+RcecqW6mTyANL3lCVdFyuyKLeTXe4EPkarAWYY1nrB
 wBBpYDRjd+RTeg6hhlb/NLGHLs4T5XaTMr5f1EKpsqCUebXp1YbJUGGPa05PPIK9VEG2
 jSDUGdvPg/ccJXUqHFOE05AbMDBCy29dSIiGo+TIIYWQuFAtMX3V9ztj1RppsjRbldKM
 IXq2moBMFCH0U/VW/PJbuF/q3q8plyeRorsRUARTtdZupY8JON4WICbUs8EWNO9CJQoT
 /qcgHvl3okHxyIELFsg7lJicWwZ0sulfPV8rhugIn4rX1qq80vgCumRaIm5RvzXuQAYz
 bing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666526; x=1696271326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K19uu8/17P76Q44mQCDZAyL1sOi2UHp67TYKWHLTGQs=;
 b=UVR+vpxAUf/eDCJxFZcd68D9m0kPlNJJ0AILLWelRn9cT7ZVDVBwv+IrfuCyFpi5B1
 fSpNE3iXHoZBuuuocf3dC2rxYLUlsVs/iW5oxVFRnPSJGsp6YsGLm6mOkrJhhqJMXyVd
 a3B6LluruuKm2vBvp1D2ILHNPzCrimF095hG7i07yl4fXwqhi2CntCNxtPcvfAsg+WCF
 DhY/5L5GsR3u7Z4+5Cf4HOBZoDO2IgwNRBsXauKCuhR3PIN2GtYJVSpAKFmyqgzTOWW0
 vvJffzcB0e/naKWtU8dlkSRE4z5/qrrlEGgIWQcLQ+yz6JKQa7eZIG/o6bxSwiZNxjNd
 sVRA==
X-Gm-Message-State: AOJu0YyI75U10+u9MnUE8iO4ashWPxtCYoyz+lSQNMA/pZOR3NhBoPyX
 6E4rQeB2F5kZc2xTZX7eAqcINZzglzM=
X-Google-Smtp-Source: AGHT+IEOez4bIg8FU728XRr8y9D0Ss5NT+njMs3bSsBm7Qf08/gbQxv9IrrhLg+ZsNEiCzSdGnjKxQ==
X-Received: by 2002:a5d:6b51:0:b0:31f:f99c:600a with SMTP id
 x17-20020a5d6b51000000b0031ff99c600amr6210560wrw.46.1695666526159; 
 Mon, 25 Sep 2023 11:28:46 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:45 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 11/23] bsd-user: Introduce bsd-mem.h to the source tree
Date: Mon, 25 Sep 2023 21:26:57 +0300
Message-ID: <20230925182709.4834-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x430.google.com
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
index 4c99760a21..42cd52a406 100644
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


