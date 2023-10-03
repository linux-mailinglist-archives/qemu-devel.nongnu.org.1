Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392337B7565
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovn-0004QQ-I1; Tue, 03 Oct 2023 19:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovl-0004MH-L7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:57 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovR-0007Pn-Ch
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:52 -0400
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-79fc3d32a2fso60170339f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376136; x=1696980936;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ci9IVvBHiMF+Kz9t9dpXV7nFDmS/9Z/PKiZ4KFlDEC8=;
 b=EL0z/VGJ1wHeuZlsfVMFhXIzvdVMP1l18o0b55Y7ZZ445PL1B4FiP1/fpmwachEoGo
 mSG+REXbAAHQ8eq5iA94C1FtOUd4OX6CisuDUg+qX5qh5JPfZxyamGhdn98YibaJNtU7
 csu12xXn1q19ltSIV5AqEUIORvrYSunYEcXeJMbZwnujBB06PKm4oKG7bq47WD/gk2II
 cCCPgCm2Bp8CGvFrEkRR07YYRG3WT7xRI8RCnV7/5o4i7ZFUIB0dw2+nIul9b2ea7Nw+
 Fak8BOdULgBZfBF7qGn4CpayC+eve4KI1VCK8t4OGrbtt7i4jgOBFnFmxqSarisUZMo3
 OMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376136; x=1696980936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ci9IVvBHiMF+Kz9t9dpXV7nFDmS/9Z/PKiZ4KFlDEC8=;
 b=Q23oZCa0zKxarUdkz4g0dvzfVfeRkcaHwWPqVYnrT6vj0cNa6Y19gZC7lkhiHDzA2o
 2ljR/syH9GS2SO9Y5uYSxDOCjSgsTm4SWVrvrqgYnHiCbsD5iVXuouWY/XJnlWUDc06e
 Hp2HIDg+9z/avG41y5VP+Hk57NtgAOvZA+6ONFgpJZWyQ3r9oJWEpFtpptBO8E+6iZ8w
 W1Mqkh4TpS7h+6+aJ1IZ65pBhxW1x+r2uEVDTR2Px7F4cMVoaI7Mc7xEqU19lxmhRsuR
 ZdTEviImISMAA9kFBgjtTcP+pBlb7UpoUQ2nD+Ql2skbiRhYQHaHwQJzpyRL1oW/LiOA
 HtDw==
X-Gm-Message-State: AOJu0Yx/+BaH6g5pVO7Xd6oDKs38SAJ8CuVxMExAlrZUPcySVmxYh9Yw
 CmF1wJcKb6Wd8Zk34ldPfMJzmpgSSCTN0/iGaXSERkbK
X-Google-Smtp-Source: AGHT+IFCPkyodsoP7KEVRj3inRcDTDEVAL3WglJsXJD2pdw/bMGLW1eYlKvqHT2PEG0kB+snbPQgiw==
X-Received: by 2002:a6b:7841:0:b0:79f:e99b:474a with SMTP id
 h1-20020a6b7841000000b0079fe99b474amr865190iop.18.1696376136111; 
 Tue, 03 Oct 2023 16:35:36 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:35 -0700 (PDT)
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
Subject: [PULL 32/51] bsd-user: Introduce freebsd/os-misc.h to the source tree
Date: Tue,  3 Oct 2023 17:31:56 -0600
Message-ID: <20231003233215.95557-33-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d41;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd41.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182709.4834-5-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-misc.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 bsd-user/freebsd/os-misc.h

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
new file mode 100644
index 00000000000..8436ccb2f7d
--- /dev/null
+++ b/bsd-user/freebsd/os-misc.h
@@ -0,0 +1,28 @@
+/*
+ *  miscellaneous FreeBSD system call shims
+ *
+ *  Copyright (c) 2013-14 Stacey D. Son
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
+#ifndef OS_MISC_H
+#define OS_MISC_H
+
+#include <sys/cpuset.h>
+#include <sys/random.h>
+#include <sched.h>
+
+
+#endif /* OS_MISC_H */
-- 
2.41.0


