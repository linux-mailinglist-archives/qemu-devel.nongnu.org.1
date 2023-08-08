Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8777740DC
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDT-0001my-Qm; Tue, 08 Aug 2023 13:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDM-0001J6-6P
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDJ-0003Dl-TD
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31771a876b5so4448354f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514583; x=1692119383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kZtTdznoH+U4bgfI/CMYaMU7x//qT+7OQ+XS9L//to=;
 b=R77DS3bPvX5rFmWX2soeJqz4Ie84EovIYroe5qz/hLkKdr7pOcrfe1sWRZoSbue3Gl
 Fpz+G+awji88FKD70eLOJ864IpjmBJaQTmWa2Dt759tqE0qHJvrvWc8vYABLDkqvvoTp
 QCVOK3pTYbV0qClxoAYpMUe3Mqg/UVW1giXVHRKx3/wz0O9VIBlJqx9sCcnq4PGbDkxV
 +hE3Vev7fb0MytKijqv9EegCULKZbY31mv5LbR208a6BvHcdO+w3eZeg5MbanrwN3Egi
 gp4v9P1x7f1hA98tZLXyyGC5SB7NNvVOm/avZBsMOWiLNHKOh/ayMBDopLNEuUdXxLz9
 HL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514583; x=1692119383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kZtTdznoH+U4bgfI/CMYaMU7x//qT+7OQ+XS9L//to=;
 b=VXS3M8p04oPlQ7v4I3Ai+NPaTwHzE7qoglXgubLnGACXinao+mxIrr7RnSEqlJMkEG
 qS08kfAVogmvEV9MuDsNKfyovqcGKHKjewngvON7IaUnlW82he34GmzCqnbXIr8guo6d
 e851AFRLSonfLzpFs+AFbAEGHk9Xc0N2bQmPUuzNGEqBm6RSO/JxI0duwQFAq+cSNUrC
 IRlKuhB8a8RM30C597iqtDOw4VuSjcWAEL1h8EZAVxCRhg5GGwd0rlOwlERSjLL8vqE0
 NCWYrdLVqNaBh3q9gkUnqRdfpcR9liTfwEjeDQg1xnhFQR1n8mPKNwHnxiicdAkRJmzK
 OC7w==
X-Gm-Message-State: AOJu0YzM7C13GHuEQvh7IdP6p0d380+4Muyeg7yCvsUMlAkqtNvsx0z4
 2PvPbQWtClhm9jmVMPRk5ZcKR5YPhYmxIA==
X-Google-Smtp-Source: AGHT+IH4It7B/Iv0RiSZhuk+2t/EwvWixwpMbzPseaAbBa8E8+YaomdPv0CAwCyGyV6uAaQCBGXWaw==
X-Received: by 2002:adf:df06:0:b0:317:5ed4:d821 with SMTP id
 y6-20020adfdf06000000b003175ed4d821mr38317wrl.55.1691514583058; 
 Tue, 08 Aug 2023 10:09:43 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 04/33] Declarations of h2t and t2h conversion functions.
Date: Tue,  8 Aug 2023 08:07:46 +0200
Message-Id: <20230808060815.9001-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

Declarations of functions that convert between host and target structs.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/qemu-os.h | 35 +++++++++++++++++++++++++++++++++++
 bsd-user/qemu.h            |  1 +
 2 files changed, 36 insertions(+)
 create mode 100644 bsd-user/freebsd/qemu-os.h

diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
new file mode 100644
index 0000000000..7ef4c55350
--- /dev/null
+++ b/bsd-user/freebsd/qemu-os.h
@@ -0,0 +1,35 @@
+/*
+ *  FreeBSD conversion extern declarations
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
+
+#ifndef QEMU_OS_H
+#define QEMU_OS_H
+
+/* qemu/osdep.h pulls in the rest */
+
+#include <sys/acl.h>
+#include <sys/mount.h>
+#include <sys/timex.h>
+#include <sys/rtprio.h>
+#include <sys/select.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+struct freebsd11_stat;
+
+#endif /* QEMU_OS_H */
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index c41ebfe937..1344c3fce6 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -38,6 +38,7 @@ extern char **environ;
 #include "exec/gdbstub.h"
 #include "qemu/clang-tsa.h"
 
+#include "qemu-os.h"
 /*
  * This struct is used to hold certain information about the image.  Basically,
  * it replicates in user space what would be certain task_struct fields in the
-- 
2.40.0


