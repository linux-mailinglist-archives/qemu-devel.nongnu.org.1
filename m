Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4178B91E
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYg-00085x-3Y; Mon, 28 Aug 2023 16:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYe-00085l-9U
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:56 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYb-0007Mn-Th
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:56 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99357737980so465110066b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253392; x=1693858192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETrIkboCdNG5TY6Olv4gNscxKovUUjaRuzTvH5OG5es=;
 b=HffbjqPwN8YiBfcZnG8/RFU7oxYvouiDTWF4bwGz4omEKE9D5H7KtKpYZ+UukBhhVp
 zG6r2kWi2RsU5JDcbn1wnXB0uQY9P3uKCADupb6P9pbI3uEpATl8qvxCs/fxOQ96atwV
 WFgkC0HBPdaSn0aINyM1yr+TOfoF+QBrMsI9y/bQFIWyTzrOBgxdpLZOOs+bH82ApDNW
 ALC+7pzTgkeG0YYmNC+3Y4eRuRP0z+HyICOH27+LEla9ubCO2v4MSBgNfN8pbOZDcMNX
 FI8N/nlWvLEibuISjxWYYtOJ4uQB2t1CBYRJqZYmiQxc/DGiEYzSZNg/TIzLz4y5Qo+r
 h5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253392; x=1693858192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETrIkboCdNG5TY6Olv4gNscxKovUUjaRuzTvH5OG5es=;
 b=fsw1gSi90x7AqYpiwTNrOW9I3XH5zyJmnjUU68ykQV/U5F9qqVrJ+a5Fnryl49durT
 ZLGdi91bjJFMhELxbquU7eYZkAeH3VVCaUep6iT8C55BUB43wnWSmLkjZpHGC7u2B2Pq
 X/GiYyB9z3eO2HYf3GvlYBQsR6+xZvIf90DbwpqQV6aZ6xy0Dp79H5Wy3gX/+uTkdB20
 MAC1TUPyKBfjThNb0MDZnr4o1e63qRhuNBVsxihFnK1Inx4PrQV5xrF9HGmuMBC/oHFX
 YcKN0flbqF4pTrg3d9dWkSs3lKWPX10Qn28kC4NDtI1V6IyA5JRlGHNvCDK/ZACOCqJh
 gykg==
X-Gm-Message-State: AOJu0YxFZ1bO0by7JcATu9nnU2S9GVOMLQIDttQaZZZAy0e5ajigeKQ7
 cZmXYWAJooPuAT0XiKwXhAiOJ87oV1ZaSw==
X-Google-Smtp-Source: AGHT+IH/clYZWHFwv+qNl3TTmuIabmmgZ7ismPJwgZ5dhfUvsp7n9Oh56FLuB9ur/QU7hE7LSn9RCw==
X-Received: by 2002:a17:907:75fb:b0:9a4:ea7a:d0bb with SMTP id
 jz27-20020a17090775fb00b009a4ea7ad0bbmr7398200ejc.76.1693253392280; 
 Mon, 28 Aug 2023 13:09:52 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:09:52 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 05/32] bsd-user: add extern declarations for bsd-proc.c
 conversion functions
Date: Sun, 27 Aug 2023 17:57:19 +0200
Message-Id: <20230827155746.84781-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x632.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
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
2.40.0


