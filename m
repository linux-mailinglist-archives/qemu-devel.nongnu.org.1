Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4C78BBB0
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrn-0003gm-6n; Mon, 28 Aug 2023 19:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalri-0003fI-5S
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:50 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalre-0006hx-Vu
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:49 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-792623074edso111253839f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266105; x=1693870905;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFUI7syWjtHkv1X7CZsv+GWXf+3QN5j9BYV4aIXY14I=;
 b=CqDYtqjJrJTMVWSQGUUkCAonBBQDhGh/Wpf6Q0n37NzPopncUaKADzDBGUBRLnPpUs
 uDjRjOrTH+YL/kMjhyMPuywwFP7Xc81BHMyJptm79Gsi07QB1Fnr0+MKCNwQWVm+pI4P
 8oLrlXxlSEl8EOyNBkK3Z8X9B4MGxplLmll8IG0QpFjgDrXlbpDADQTjbXMiP4UHhL9Z
 Rt71STsykbKShVudKYl8M6x845D1kl0aXhpl5xQbvGLjI3Z7Ui2iLFOiZbio0em9sSfi
 4astNwN817+q73q02n/HTlALP56v3PJsCUVxTSGFc3ksc001RuOCDgj72VWso4QRYBgB
 zgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266105; x=1693870905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFUI7syWjtHkv1X7CZsv+GWXf+3QN5j9BYV4aIXY14I=;
 b=cpRsJ62VIRKyNyt5N2Yudqic+QwFYAgYsjXOqbAoY96iT6jz0FF6+h0GmdWk289cjq
 kn9QYCM+BFSdK2Fpo9BckAo6iqkbypoRWYW6jNJNw6NiNgTUnRJf1HrafTv4jUxVtxxj
 YCxNa4Gg1rwQhh7H91i+Ex9g+1uq5mGwgc0JIRo/S5WQBqnlybb/EJIFZAyB0jpax+Vn
 xRMZxZ4UTazuFHw/72Vh5CKymKxsSHp4d3wOrKzYPoQdUATjcV5RUWvId717CFT4VM2A
 fUGg7QdgI9+dFKdzjyGSe6Kxb84Hc/PX6iHtfRlE7Bve2zZfoZegSAsqJ1viDJpxKG8m
 izpw==
X-Gm-Message-State: AOJu0YwOp2YUR6+oUVJwjLUYXf/AqSOO0Cv1e9/R68IsjFpqxTOuRkXl
 IAyVHtNb9wowOla5hDjYHpqRHMWwCAGHlFiSY/Y=
X-Google-Smtp-Source: AGHT+IHxrsgKppXZod3TmlbfaDGvWE1C2qxTdt3tA500m0NezN1mgJSfUjXdyHN1sOC0/PDuyOA+3g==
X-Received: by 2002:a05:6e02:148f:b0:348:b086:2c4b with SMTP id
 n15-20020a056e02148f00b00348b0862c4bmr1292306ilk.9.1693266105345; 
 Mon, 28 Aug 2023 16:41:45 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/36] bsd-user: Declarations of h2t and t2h conversion
 functions.
Date: Mon, 28 Aug 2023 17:37:52 -0600
Message-ID: <20230828233821.43074-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Co-authored-by: Michal Meloun <mmel@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/qemu-os.h | 50 ++++++++++++++++++++++++++++++++++++++
 bsd-user/qemu.h            |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 bsd-user/freebsd/qemu-os.h

diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
new file mode 100644
index 00000000000..12adc50928c
--- /dev/null
+++ b/bsd-user/freebsd/qemu-os.h
@@ -0,0 +1,50 @@
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
+/* os-stat.c */
+abi_long h2t_freebsd11_stat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st);
+abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st);
+abi_long t2h_freebsd_fhandle(fhandle_t *host_fh, abi_ulong target_addr);
+abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh);
+abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
+    struct freebsd11_statfs *host_statfs);
+abi_long target_to_host_fcntl_cmd(int cmd);
+abi_long h2t_freebsd_stat(abi_ulong target_addr,
+        struct stat *host_st);
+abi_long h2t_freebsd_statfs(abi_ulong target_addr,
+    struct statfs *host_statfs);
+
+#endif /* QEMU_OS_H */
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index ca791e18b22..4cfd5c63371 100644
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
2.41.0


