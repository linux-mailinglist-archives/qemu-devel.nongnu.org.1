Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB78B7818A1
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZs-0008Au-T4; Sat, 19 Aug 2023 05:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZQ-0007sV-AF
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:43 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZN-0004GR-SY
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3179ed1dfbbso1577009f8f.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438512; x=1693043312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sy3MH2Hdjio08FhOS5Y/B8VYj6jvphQt1UIdvsQBktQ=;
 b=pwI1JKJTx/NmuZNo09D5QKoA/rRKmin14XcBMj+GVVY8+HnoeNSiavmCDww5Mwo+w1
 yS7HCGmsOPc3/J4ywITOLv7LGvs1EjNkS9rEHQtTONTiKtRE77pr8nAbz6y/67g7ycyF
 QwXysN6N46MUqS7rQBXegVoPRAaMKGHQ22ECoKLU5zoTbVH59CDzMQBtaaZTAqhjD2RA
 l6zyEpQj90v3RLY/dJFx9W8290oqzVBMtqcUKIDZduOjIKV9aP2xXvhCBJpTbMi8UI0D
 W5haP3IfVpQLFincyDsVs5M8Iq68VDedOsPsDhJG1fMUdUTngw34zkg22kx+jFUg/vBu
 ZxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438512; x=1693043312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sy3MH2Hdjio08FhOS5Y/B8VYj6jvphQt1UIdvsQBktQ=;
 b=aDZj6hgGQMuodVLp/f82GycFubEwFdawwGGfWDXLBwjlprdQmIeV4Z+u6PSwXaBFaT
 22KZYn6yyPBGIZzvy6NX66rRMC4zCmOcMEATcAfyK3/wBkWjXnRYSZjU2vzI6TEfg4aF
 OX+qDbM09cC5/145RcDt5+gUmGLqsTboVnomklUK9GuVJqlZ9b2HX4XZBS0Y6Uf7SBfD
 swOabnV92s1Z7y/VRW3iKyYKujPsVWXJT2XF8gbiUN76s/Bws/N1PL09kGvK6pfHrtDU
 tSIZOL1H2BZaDdAvhZe4+dYeDjd1Q/FynK05uey7GEg2xSqFRpPPnT0/FMApjffgccx9
 jQ1w==
X-Gm-Message-State: AOJu0YxuaVlNf+PwqFc4Rai/MGu7yEM57y9wAc3krsm892bwIwnX2NZf
 3AhJqGL6BerlpRJuri2vXxZ+zsBLzq4=
X-Google-Smtp-Source: AGHT+IG7/Q6kKooAwECNHW/f4UIAVzxYB0JSX44r0Mve3oiUSQm40zrWUtXBcPRDAbtrxLVmJlelOg==
X-Received: by 2002:a5d:65c5:0:b0:319:76a2:36e9 with SMTP id
 e5-20020a5d65c5000000b0031976a236e9mr1196856wrw.56.1692438511713; 
 Sat, 19 Aug 2023 02:48:31 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:31 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 03/22] Declarations for ipc_perm and shmid_ds conversion
 functions
Date: Sat, 19 Aug 2023 11:47:47 +0200
Message-Id: <20230819094806.14965-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x435.google.com
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
---
 bsd-user/qemu-bsd.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 bsd-user/qemu-bsd.h

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
new file mode 100644
index 0000000000..f98942ea91
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
+abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,
+        abi_ulong target_addr);
+abi_long host_to_target_ipc_perm(abi_ulong target_addr,
+        struct ipc_perm *host_ip);
+abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_shmid_ds(abi_ulong target_addr,
+        struct shmid_ds *host_sd);
+
+#endif /* QEMU_BSD_H */
-- 
2.40.0


