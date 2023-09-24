Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 251147ACE3F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSj-0003G2-04; Sun, 24 Sep 2023 22:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSg-0003E5-1m
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSe-00004t-Es
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so5244888f8f.3
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609395; x=1696214195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NgIQuhS1pWjXF2WQJZ+g0h0EHjHQYwR2fjodfnfROY=;
 b=i0xfpNW25WBvJlMwe4u7yVSqaigpP+sOOdXXGCREHf4wmGRoN5QG1lJdJI0czeZs4s
 /0wxauyjYbBLxKtf5Hi+tAtDg6CBRW2J8XUoXxMSqP55U/2zQyXohYh311N9vOKV5+qs
 K1n/JvCE+tvtOsm76HvFahCbq1ROnjDrENBq6iB2WEDLJAJXKTE1jFqGzBaTb5ev6Y5f
 LlGmS7uW8URkf3rJd3Khz+dJwWj8TR4sy0YUk2XekhDpc2NOcNI4BM1NdHJiIuMt7oJH
 iNjeCE5coxX5EeWupuFMkqssoTbpVlaWYBcA7kt5BorfHiO+Y9lTy5v9vJS36BLcCLSn
 cpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609395; x=1696214195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NgIQuhS1pWjXF2WQJZ+g0h0EHjHQYwR2fjodfnfROY=;
 b=ac0MQBWNDO/fACiFhMqp2NyaOJ1M52Ua007e02GP8P0UpvUggfz86qM9GsvfZnPniS
 Dzl5JhKs8LKJzp4yeI1DBCaWwPl+Uu5HeVx4NPMgvpsXzWtv+NJqqZG22ofir9v+osNF
 We3RGRSjke1UeG0nWn2wrWwMAicGocEHkXEljPzBgeKr1twt5/p2iKSmbOKR9G2O5ZI0
 /ABr0BWuu70hDuaQaU19IoTkFP1Zg2Nsdwn/ajt8R3AQwDVGc5IudPshAEYMRLNqtsmU
 Ju3bgxqFzNxmOb8tadVQOC/TA4Qh9P7idXlTB0mCIfD4vSNBa3aqu9GNg+dVcjbtMzFC
 4v9w==
X-Gm-Message-State: AOJu0Yzvtg3py4RbfcPzHFe79Mf8th0GAoDsOab3eBFprPDfIDsLvcAq
 AKEsb0PkbzwwxD/PxpZj6geTytPoEz4=
X-Google-Smtp-Source: AGHT+IEk/dY95L6UU4NiAV7C9veI7JKD7aOX5ncWtjNB8pguRg0HV8IpD9ntdEBxmNKtr0Kz4pKfIw==
X-Received: by 2002:a5d:44ca:0:b0:31f:d52a:82af with SMTP id
 z10-20020a5d44ca000000b0031fd52a82afmr4458668wrr.49.1695609394808; 
 Sun, 24 Sep 2023 19:36:34 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:34 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 05/28] bsd-user: add extern declarations for bsd-proc.c
 conversion functions
Date: Mon, 25 Sep 2023 00:01:13 +0300
Message-ID: <20230924210136.11966-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
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


