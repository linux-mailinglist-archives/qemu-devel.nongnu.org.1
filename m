Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC673799A9D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3mr-0005ia-Pm; Sat, 09 Sep 2023 15:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mq-0005bX-Bf
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mn-0003CK-Sr
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401d80f4ef8so33418385e9.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288308; x=1694893108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gc/mLGUX7ZmbD3sQ6kC2qyMy//ogtwOmV0rb8Xd2gcE=;
 b=Pe3/+dNiWtopVSfyYqDPZByFlQvp1Dp9bAYZWo82+886ECooEfmOh1B3hnDg19EEUF
 dm0xxNC10a3Qh0UzILsyt6W+wCyET1KudupSii+W7VydvPCmDuwcZx22IjQDlaO22K+v
 JF7J/i3kxd/XcSdx8rMSrREy5bk8PwWEGYH+dtvMu8Jvd85Ev3/VY/dMcfUhyQ5toiT+
 QyypEYjHx/PVVFg3hcbfUJjmCPpMv+MMq9O0UVw0FYBmlp56w5AJHk42TGF/ohLcAd1A
 8mDSjEeBG6ZxsuMmkeQKf/teCrkwSn5HCkyMlFQYEay965VNkoe/esMaHT1BB6oByOLS
 BVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288308; x=1694893108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gc/mLGUX7ZmbD3sQ6kC2qyMy//ogtwOmV0rb8Xd2gcE=;
 b=jZC+a8WhgUGSNaWIF95RqHb9Wl4LnbY957pmJea5TSEJ7ecCh2jiCWK7g8G2q4W9cD
 1hXWhUWbZkY2fC/C9az5aUi1pdQeeGttw4QpR+D49dNxUocGgapD7RGAb0yLDbownszL
 8DLbcVEIWmdaAw4yMG5msu1ojeBZraLhXuia59ECBrg62t1POL+t4yyifWMb0Nr7ngLv
 HB/SjeyVJ3XVtQ8+PZu8NsguUpcOBvjQRPye+4ODIRizye2wkqLfCl33BYfZnSjd2U45
 qYkl0PL57tRaGamgobINPuaHhlN6JDvVpgM33RvIchGrqWiptekezxb6k8HhuewWNoKW
 z4cQ==
X-Gm-Message-State: AOJu0YxaVNvRSaOtYCYbC9HseHomRQIXpsmPFrfGK4RLZhpa5Ys4qWVq
 RUbGysTGeahwSYJJWeqOvNqpKo5ezhc=
X-Google-Smtp-Source: AGHT+IEGNORC+HsmH1ORvSg9gKg13auyaK3UqTCNPibIV2zDyn6hvY/DqgseP5bAECDv/FIrjuQ09A==
X-Received: by 2002:a05:600c:21cd:b0:402:fe6d:6296 with SMTP id
 x13-20020a05600c21cd00b00402fe6d6296mr2925332wmj.9.1694288307617; 
 Sat, 09 Sep 2023 12:38:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:27 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 03/23] bsd-user: Declarations for ipc_perm and shmid_ds
 conversion functions
Date: Sat,  9 Sep 2023 22:36:44 +0300
Message-ID: <20230909193704.1827-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
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


