Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB9A7ADF15
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:37:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqK4-00085a-De; Mon, 25 Sep 2023 14:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK0-0007zv-1o
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqJy-0007jE-86
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso29567905e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666516; x=1696271316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVq1uGHM9oV6angmlbXbZLjFliHdEcoHMR8Uy2q0vLA=;
 b=ZY5uWpV8F/RElbx2KCBqDdB2Or5CyGCpW5LllpD34aF1aUFsIwtqHSywixGNDZazBK
 nuCvEPKYKZCe8pDDlCkpYvQILvdSKJz8G2e+pRdu6pMlpZiwnpJfJYz4zzwD4OUTYC4j
 yIGwfeDMbmDef6r9CQANLJ/0bFr+/l42I1/pjIQCmIDQh6O3H0Dxiv6rhIDf4KcGV3EZ
 KkQ8lnMSVjlaT1S03iq0ua6r1g24qGZcpkil+JlLIxuqThM+JZZGB5c+9xV7YYV9TQXw
 /chMIisqtfcJ06l5ZVd4vVnf95mjoWcBgQp3UUSub3EEmzSm5vgFx1HVRGuYQ/u0r6ch
 5yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666516; x=1696271316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVq1uGHM9oV6angmlbXbZLjFliHdEcoHMR8Uy2q0vLA=;
 b=ifvzb1/0mE+6ldQVy3Z+Ck75BnXbXGVc9a5KrHhRyktLzljko9tMEwBfMIYJDNew9f
 WthrecoDi5eHz3Ox8Q3h3DR3YgsmD+F3o0d2EWlp3MG4ZJZiEsVr0LZ1yQVWnK6DSHwi
 Hr427QlkWSDEN3iE9s9OpJqqapLjdJ7yJT4hxkwxPNvgeNMZYwl2YdFSs5DR8ci4lQTM
 9ZEt1NmdWb7gyC+2cMuLpdFOc0obsXMmMidDZFC5J5TzTBhJe61sO4OJBYWQfCZ/0K+R
 IagJOlr5Lj+GqKpvV7jGg596KwUiqFCOMrhCWfGIC6PFJWyb1QmHrOsU3ZooxhVrc4jx
 j6Cg==
X-Gm-Message-State: AOJu0YzKsW/PH+TLBJcFgR1K0BlzqLOL/9myJTzRwpW1MELuDskpz7Kq
 MbIb2mnO+wzr48oVRq99noAvuMrwddA=
X-Google-Smtp-Source: AGHT+IFTsePQ4fIi27R3SK/LCPCBtO9NG6H2qF21lCov2D2ymkArF5u2tKpYYgtnsResuXJfUPB3Fg==
X-Received: by 2002:a5d:4fc5:0:b0:31f:ebb5:cd51 with SMTP id
 h5-20020a5d4fc5000000b0031febb5cd51mr303443wrw.33.1695666516333; 
 Mon, 25 Sep 2023 11:28:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 03/23] bsd-user: Declarations for ipc_perm and shmid_ds
 conversion functions
Date: Mon, 25 Sep 2023 21:26:49 +0300
Message-ID: <20230925182709.4834-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 bsd-user/qemu-bsd.h

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
new file mode 100644
index 0000000000..46572ece7d
--- /dev/null
+++ b/bsd-user/qemu-bsd.h
@@ -0,0 +1,45 @@
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
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/resource.h>
+#include <sys/sem.h>
+#include <sys/shm.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/uuid.h>
+#include <sys/wait.h>
+#include <netinet/in.h>
+
+/* bsd-mem.c */
+void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
+        struct target_ipc_perm *target_ip);
+void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
+        struct ipc_perm *host_ip);
+abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_shmid_ds(abi_ulong target_addr,
+        struct shmid_ds *host_sd);
+
+#endif /* QEMU_BSD_H */
-- 
2.42.0


