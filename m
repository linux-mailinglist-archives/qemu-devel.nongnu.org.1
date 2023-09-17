Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7183C7A3DEC
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUR-0004VX-C4; Sun, 17 Sep 2023 17:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUO-0004T3-Jg
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:36 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUM-0004FE-V0
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32001d16a14so1218528f8f.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986773; x=1695591573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzVZUygPnc0xMYEmryNsNXyk8Md93nZ92t99k9OH81k=;
 b=cpvDejG/LpqRAZ20Aji8NjPHw6ttRogMi8RLNFC6q183KpFWj6iKKWlBqwH7pLucI3
 md5qb+GSM0EyRO+yonek0OrhcLIeKnjfHRx8K3ytoFlWI59VLZxkjRIhepX18iVxYDUz
 TomzBAoZaNedOwxMvvIAY79N7yRWe95t5zLGwNJiiwB/eNFiKLFabGLtcZELrKxizaoi
 M+cQdBng6Jl2RKQZmyc4MoW+2JFmqeikEIC4jHGA7or9GmGVR9rqP6d0htnzxrC/Da4B
 hI+BOKtrtqfo8c0eLqGm4RI4L1yys674TwuMFO+afaPrV7JIzkkkHT6cBhicStFCxClv
 ahoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986773; x=1695591573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzVZUygPnc0xMYEmryNsNXyk8Md93nZ92t99k9OH81k=;
 b=asVE6ePCQ1ax2yzYjSBCfoYroEREVPnSIbIvvrgX5VhcfQ31Y/bHQLbtCEfU7pDtzd
 oV+QKbmrI13a6DKlfMjO8qMVOg9TXAjObDUvaquRedEXmbPldqhADJ10sPRACOuV7NXR
 CJbAw15EPTLsdc/WoBhNZ5CAPNOkzrZAIi9urbTdLYkSOhtCFDQvp6668IunNexTHTzQ
 FO1i+Wtk+6pIAY1EnJ0xfE39WVcGk7cKmbLlAsdOj8goGCg/UnM14KV8q7wxL+hQ1/wM
 hvLCFTkVnsSNZ0JE9wqRgTHyKkK0/7EujbRUDp2mEClFLqzYp+IZkuDN8ZaDKDpH4bhj
 3tnw==
X-Gm-Message-State: AOJu0Yw+3THg6tp+73GLXJrkd6ljKJXzKi5/qc4X9yBo7UG1HWSK9FBF
 lvBkHdzqJHywrA1EgYw8Hj86stpdaJo=
X-Google-Smtp-Source: AGHT+IHZk6WHin2euna1pbj+jufI4q+OVRFPEyEchBra9+OP02GD90RfvxASLCmoB46OqPhl5gUI0g==
X-Received: by 2002:a5d:54c1:0:b0:31f:97e2:a924 with SMTP id
 x1-20020a5d54c1000000b0031f97e2a924mr6098382wrv.14.1694986773340; 
 Sun, 17 Sep 2023 14:39:33 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 05/28] bsd-user: add extern declarations for bsd-proc.c
 conversion functions
Date: Mon, 18 Sep 2023 00:37:40 +0300
Message-ID: <20230917213803.20683-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42d.google.com
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


