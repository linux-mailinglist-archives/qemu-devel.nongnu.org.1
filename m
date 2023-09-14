Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A2A7A0F27
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAg-00038k-O0; Thu, 14 Sep 2023 16:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAa-00037q-F5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAW-0006IW-Vn
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40472f9db24so10683005e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724151; x=1695328951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVq1uGHM9oV6angmlbXbZLjFliHdEcoHMR8Uy2q0vLA=;
 b=jwNHZpkJfosNz5xOeyuFP7W96mfDviETPAzudqcSdlyHFWoKXUhPO3bOjaSc/7kcUE
 C5HgZZr+49wLaByjIbs3PgE0Wl8nICDaicVYoqnKMKSHdBJnjTQKpMMFfh1O/KMv0nwR
 LdwTngDyoxHgD9FqRZo0QRFk2/kIugtNL++MblM7xCJJY65dKCkuPcTYwClmRJWTuOIN
 hW3tsp+AsztgpEpH3+QtPMpLb0S5fAtEqN62NnBZxHFLqgmt2kcGdXyZC9Rs8gvXLKu/
 c1seL+9BIgjaxasEemTJ7P/d1TaCT218ILVye4vTqTsfObmuwWdUsgNyTdINj1yqlYSM
 drKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724151; x=1695328951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVq1uGHM9oV6angmlbXbZLjFliHdEcoHMR8Uy2q0vLA=;
 b=KdR+/fHK/VCxrb8bPStfR61g4ojj0IsDFOjf424gQTOhsb+tv1oq6e399IcbtjOyuT
 6xnPr+njPLHhDLXOiUOFQmpfVaHt0YjqEgqlpl6tXwqbXPlv/6QLDpvyqI12PwqcJ/wG
 S6f05jVGZrOP0NRDh17fdOoIb3ujBOvRzK7GURzUedIwi7XqnTVJiiaVcduPVEZYX68/
 mNxBigSj8lgdo3iYEoh+ifT7X7gYNJL5Fu0/nv9AtCIsYIMzIctCpguA/4xRxSsr1jLs
 vWAbLielaVyTuNNiLJDYbiXZ8du7E+byAm3wRSjlaNDhRwXN8Zom6B5y1TE3kPAlu/lY
 8kxw==
X-Gm-Message-State: AOJu0Yyn6Ioe6c4Mmbpmk1zLTkNB9gPGiTkoolUiTBk2ziZebVcugsLc
 t8Fdu357Y0SUi0t5XNYO26Z83UPq6SM=
X-Google-Smtp-Source: AGHT+IH45ePvhxLS4ku0+R4Dw4OYQfEmX/Aj7WB3FiuU4GCfQ7cBJP5Z6LhoO7JK+I1tWTYRpQLnmQ==
X-Received: by 2002:adf:fe8f:0:b0:31f:82eb:8a70 with SMTP id
 l15-20020adffe8f000000b0031f82eb8a70mr5623298wrr.37.1694724151369; 
 Thu, 14 Sep 2023 13:42:31 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:30 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 03/23] bsd-user: Declarations for ipc_perm and shmid_ds
 conversion functions
Date: Thu, 14 Sep 2023 23:40:47 +0300
Message-ID: <20230914204107.23778-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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


