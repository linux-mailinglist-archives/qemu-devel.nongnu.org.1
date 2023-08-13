Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630277A6D0
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:18:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpL-00084p-Vu; Sun, 13 Aug 2023 10:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpJ-00082G-Qb
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpH-0000nN-V0
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31965c94001so1339301f8f.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935934; x=1692540734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkgWqRz4geLx9aemdUjq4n01eDTu0bv8Yaoroe/JYUY=;
 b=VkF+1GVjdWixf2fMZw1MZ/wNnBVF5lQf23ISJ+HmwDS5dLtDwDWlpq9sd5JQkUydiS
 kSWf61nTM3eei+yEqIaffWwgSyQeD1DjKEq+7ran2mCbYe9gyy1zAxWKFt1BH0iH00y+
 6LNLvYYG7Aw9c5p/6Xzyi8CUsLO8xonLUZAx+Xmcy4EuqUz5tdQJ866xs4ZU5FF9HTq9
 pq70uXjW+9zxoIfRdLiNZTMCErGKLrbZR9T/9bN1jkXrlL0BKsErHsux+ICVdIKJes47
 Jwy0Jj35Hi8DGCGsS4cyKYoR0fJ2deWkG6oTKe82jT/MUPJUqwMILq98Bi/2y6lfKKvN
 Kxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935934; x=1692540734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkgWqRz4geLx9aemdUjq4n01eDTu0bv8Yaoroe/JYUY=;
 b=FKejyskWCEAFaTFVkssUQk6UEmdC/G8X9IP3PMlr1Zo4kSik5RtNTBK4ckSJ49uOgB
 eGCcogjZIq0Sm6GyWS4LRSswSHgTo3cYqMBt8lS7GMcjnGGX1WXHBKnON66Cx7oSIpYB
 6Q1YekFFEEfDU667LSwqnA2p/lt8CiYdqUd7I+ntNr9BaFKvs/eswrQyRvb0PWlBIo0w
 /zIFAfVZvAQOo3vBR2W3pcxT5x7sP2rggRLcRzYN0+b62iMQj40T0e1NKObEdLxCVG0O
 N6aM9dVoMqz7WJwIt4ZrR8UqgF8pqR0DFL33F7oIT2AikvLeayDBF6SAGdWAvK0NEIll
 uHQw==
X-Gm-Message-State: AOJu0YwNBRY6FXMdypYtr0lvccXWLEddE1WjOyzUFgZOFhxNTU96qXLf
 rUEbbSP3D1o0RVuTgV28HA4QfTnl6IM=
X-Google-Smtp-Source: AGHT+IHBSzDD4LaGZ3Lao4GnkO1FyYFXq/8t+fZbmB6o6M6IkEptKpKGfeCyoWhb2nPoXnxOe+PXoA==
X-Received: by 2002:a05:6000:136d:b0:317:7eec:5e9d with SMTP id
 q13-20020a056000136d00b003177eec5e9dmr5719951wrz.16.1691935933868; 
 Sun, 13 Aug 2023 07:12:13 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:13 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Michal Meloun <mmel@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 04/32] Declarations of h2t and t2h conversion functions.
Date: Sun, 13 Aug 2023 05:09:45 +0200
Message-Id: <20230813031013.1743-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

Declarations of functions that convert between host and target structs.

Co-authored-by: Michal Meloun <mmel@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/qemu-os.h | 50 ++++++++++++++++++++++++++++++++++++++
 bsd-user/qemu.h            |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 bsd-user/freebsd/qemu-os.h

diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
new file mode 100644
index 0000000000..12adc50928
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
index 656f38db56..2725fdd7ac 100644
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
2.40.0


