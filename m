Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F3799640
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfD-0000yb-6f; Sat, 09 Sep 2023 00:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfB-0000xy-QR
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepf9-0002vP-DH
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so31491115e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234017; x=1694838817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gc/mLGUX7ZmbD3sQ6kC2qyMy//ogtwOmV0rb8Xd2gcE=;
 b=dfr8uBS0CDAuiqE/JRzDUZeP0lJLmz0QgMSFuA+c2KvjxKFAunRNsj0zzOnnSJ694+
 bC1KaHw1qWS3+lejUa7jNRg6YgolvpPLFdPMDJ6zzfZRoja27Hr01op5T1mSekiLz4d4
 P7dVpM22a6Qjl1+AxBgFigutMKVV4HjC1n+t7vb74tAGYTrB2qBhyW43s8fT2LIsqc+Z
 CljJHHLtuBHDCqevDlFEPsBYHwAK7Z6UtP+670TA4zkcf99nPDn8JhxVieZySp7TzIJg
 +CSJjtPJFwlrJ+MRU7Tl58iTjqI+FlJ2G6ab3BSiO6T7cFTlV1jOKMs/uwemW+XIITSA
 QvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234017; x=1694838817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gc/mLGUX7ZmbD3sQ6kC2qyMy//ogtwOmV0rb8Xd2gcE=;
 b=Pf/6m/pfnRdIk+okxbEz3CWOJHL/aMUj8LRKnV5VdDB8nBIErlbOjl6P3NK2HAyk32
 Te5HwEzFIwAPcJ1Ms4YxxIdbnw8bkZIwYygTp0/AJ8LS/OuECJ9LLUaxvAYiWkTE9PiP
 Rvkkaf1+I/avmRBlbm+OjyiokEz+kUHOQExMSSWjsezlnfNBdXkJPQVlXR+FLsAOPzyb
 0VgrNxabvFDoGBj04SG+lUijScHQrSx6ul/6POPJX0/wcNnGaTh0T5jbemG8lERuLpr2
 /Or5ffhrIoKkNHXd6lAo0oggF77TfjMf2TPyDuY8Jt6CLwSARF/4zOL0nHj3WEx3wncg
 wKvQ==
X-Gm-Message-State: AOJu0YxUogDK6rh2URPYijSm2ZshuBG88geaWB0zwx2CaL9G2dKzU3uy
 7TxuW2OCJw7gGEpSMx/Bb0iyF0vIYN8=
X-Google-Smtp-Source: AGHT+IF37nG4gP9CY5YyxTcLFTZkhBSxdfyCb5p6/0IJUipqLwvx/0IdlY9VyFyOD2nR0bm99mG6gA==
X-Received: by 2002:a05:600c:2901:b0:3fc:dd9:91fd with SMTP id
 i1-20020a05600c290100b003fc0dd991fdmr3375451wmd.40.1694234017384; 
 Fri, 08 Sep 2023 21:33:37 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 03/23] bsd-user: Declarations for ipc_perm and shmid_ds
 conversion functions
Date: Thu,  7 Sep 2023 09:42:42 +0200
Message-ID: <20230907074302.79234-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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


