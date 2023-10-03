Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C877B7567
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovd-0004HS-33; Tue, 03 Oct 2023 19:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovb-0004Gc-1I
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:47 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovY-0007RG-0f
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:46 -0400
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-79fc3d32a2fso60172639f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376142; x=1696980942;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toTg5XymdIq2DzzIW6fWIsDHgRoIQT+xw06H9JfCJnM=;
 b=PSkApX6NmnhZjKaBmHRJtcD8bY+AteuQhtfqVuootL0q3+SZuQfCmB13ok2gi/r46N
 3QuwEgnIAFc2ow7F2S2i8sRtuqne3UGHTK16REXi4k5xlL+HdnrRsdEcxgIItKp3G+KI
 aWg+WpUgmvNnJtQX/EWSCFL0LnyTr/A37fAxdNnuqWLEKDbB4rYK3s3hcwZHHs3WX/Hw
 jDJk95j2P/DtAYkoEUwsJOGOBskwPbPQxozRxvVzYK4ZeXFrTMhJwdG/Lse3jXr6a+7G
 D7W4xOhLmymkW2HT20Dpli09ccQA9kwTVrLpWCiHFRZP/qlGw22Ey00xao8jbuUkMJue
 wPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376142; x=1696980942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toTg5XymdIq2DzzIW6fWIsDHgRoIQT+xw06H9JfCJnM=;
 b=kSqCmFJIn5pZx11Aq6xBQcoVRglB3ATQ0d3c8TXFY9R6Dy/x4hjtHVTJF43/iT/sbD
 hs5KmUtfvZ9RLghJAmxNZG7jGB82dj4DeE1neNy4ZAkli9rQ9Ygg3VMXiWkQOA4nnHJh
 tkT4Y5aZ81cSugy1QPbYxdKR21SW2kr78ZVsYsQpARV/pPhmhS9aYbRUeLia/s/vt2ii
 k1/mIUsoSw4dZCto+YQa2Hj2qW/j9PXeSC9J2yhxdlzWlBRi5r8QyD9urpo1ZCJPp8a1
 5Op90OKvSeSY1Y9VULit4QsfdOlqTFN+j1DjkFjQgTBCG05P8tXqhJxvNAJA+fZBaE0S
 lqkw==
X-Gm-Message-State: AOJu0YzqIsMmiIHatfflhUgKCHR8TzkuBvKpsrRe9j/DyD5LYyWqaTwA
 WEdTyurd8qbCLDB7asVWYQzebWe8m0nh4mLh68UGKuFZ
X-Google-Smtp-Source: AGHT+IGiD29wlcXmF7+48ZnH/u2i1ITbKGOxX/BJd8+QJRZMALPSFj8TRI+1ELOoWnB9jIPkzcP7VQ==
X-Received: by 2002:a5d:9943:0:b0:787:ff98:c38c with SMTP id
 v3-20020a5d9943000000b00787ff98c38cmr1100009ios.10.1696376142413; 
 Tue, 03 Oct 2023 16:35:42 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 39/51] bsd-user: Introduce bsd-mem.h to the source tree
Date: Tue,  3 Oct 2023 17:32:03 -0600
Message-ID: <20231003233215.95557-40-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d42;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd42.google.com
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

Preserve the copyright notice and help with the 'Author' info for
subsequent changes to the file.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-12-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 64 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 bsd-user/bsd-mem.h

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
new file mode 100644
index 00000000000..d865e0807d8
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
index c9d34b59bbe..7887ad4c0c6 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -35,6 +35,7 @@
 
 /* BSD independent syscall shims */
 #include "bsd-file.h"
+#include "bsd-mem.h"
 #include "bsd-proc.h"
 
 /* BSD dependent syscall shims */
-- 
2.41.0


