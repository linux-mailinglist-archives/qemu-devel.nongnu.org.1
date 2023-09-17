Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B97A3E72
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bf-0006Tn-GW; Sun, 17 Sep 2023 18:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bd-0006TK-9t
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bb-0002uQ-7c
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32155a45957so144334f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989453; x=1695594253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzVZUygPnc0xMYEmryNsNXyk8Md93nZ92t99k9OH81k=;
 b=Xqbaq9JcLr5K4Vq2Npzg9x3mqw4+oAsddQ9Ou8gTc7LXTxXUhoyZ5X3568doniaDGP
 mrvQznpZ1CglZzmP/xMtezlVkyPWrnfvU3BSz44EuurU5Sz6QGlhUpu/59oqnj2QfcQJ
 fRqqRGYlcwpabTgushnguXH3u2aNBzey9xDlGvZ2yR8+wNXkPdeJEn3YQxRSYOK9v/xO
 +hHcFJHVJht+FBxjlMqZLYQx/QdL0JMnWIdZ6dVHMsi4jPI/00Zfc8UP0PNwaoOprVlr
 5bwpzU3UilGLEDoipsOGwUO7tVYTUYhQCzqUb5VFRlsJlEXGwp7zawjgm9mcT76wpeA6
 HMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989453; x=1695594253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzVZUygPnc0xMYEmryNsNXyk8Md93nZ92t99k9OH81k=;
 b=VvfZxmp+VwwndevVLbDiK6HDUDEh3YKMl0CCecIVaC72Bi7+S927774kUvBtPohtA1
 t9As6KMiDYK83dcD4UHpyvDiCVkRWj03i+VhuNzFM+FwNQys+6N0LTljZFpkI7hd3U8a
 p85UUeTBg+n1ZIDY7uFOhJDlOXfabOV8cm4UZmb8nIqIR51EcudGB3QcTPGg6J76czoa
 uaL2fKz8WTlgrN4UplDFPzShhFQuXxBiRshDq+wujnaW9rMqNSr2Es4IpFnd/NswkCD6
 lFapP79KMa6lI97GjEmOYT7E3lE2w5WtpTyBtA67LwP83XqBZgiduSj9+FJKVsr4CjkT
 AHNg==
X-Gm-Message-State: AOJu0YzivCtR9ExFNYxxAufAZsabR04cXtfrqPmW8x+Pbmd/D6eqj1kk
 myMMoJriYgpgsE1MIrVTNNZ+6lCcE94=
X-Google-Smtp-Source: AGHT+IGVQZR0f+rYJcCkDtp540l4S+NUvVWO5egJWZLBOz2aPHcHkZ2RsrqEKIt0ttdZWKxV/OB68Q==
X-Received: by 2002:adf:ce87:0:b0:317:57f0:fae with SMTP id
 r7-20020adfce87000000b0031757f00faemr5680328wrn.63.1694989453376; 
 Sun, 17 Sep 2023 15:24:13 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:13 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 05/28] bsd-user: add extern declarations for bsd-proc.c
 conversion functions
Date: Mon, 18 Sep 2023 01:22:22 +0300
Message-ID: <20230917222246.1921-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu-bsd.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 bsd-user/qemu-bsd.h

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
new file mode 100644
index 0000000000..b93a0b7fd5
--- /dev/null
+++ b/bsd-user/qemu-bsd.h
@@ -0,0 +1,38 @@
+/*
+ *  BSD conversion extern declarations
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
+#ifndef QEMU_BSD_H
+#define QEMU_BSD_H
+
+#include <sys/types.h>
+#include <sys/resource.h>
+
+/* bsd-proc.c */
+int target_to_host_resource(int code);
+rlim_t target_to_host_rlim(abi_llong target_rlim);
+abi_llong host_to_target_rlim(rlim_t rlim);
+abi_long host_to_target_rusage(abi_ulong target_addr,
+        const struct rusage *rusage);
+abi_long host_to_target_wrusage(abi_ulong target_addr,
+        const struct __wrusage *wrusage);
+int host_to_target_waitstatus(int status);
+void h2g_rusage(const struct rusage *rusage,
+        struct target_freebsd_rusage *target_rusage);
+
+#endif /* QEMU_BSD_H */
-- 
2.42.0


