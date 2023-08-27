Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2F878B92C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZa-0001jD-Dw; Mon, 28 Aug 2023 16:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZY-0001ib-B4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:52 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZW-0007nE-52
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:52 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99d937b83efso475918066b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253448; x=1693858248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EMdXrfH+xePejoOiwwGdtX0Hn6WMJbM7pyz92IZwhk=;
 b=OCGY+DbtZzlJJ6YDxYzFugoXryZvwEIQ9SDdu/2/UxGI8E7UsENmL6tKbtiQ6MmFRH
 bz/0REnrCyqHq128aL/oFBJytpUtt3Ku1wRaE78xJMpaifRXlpgh+wKRji6JQnZERGdr
 jTrV5b+TB5liPtoB/TceYu418770Tz2NoOkzZ8hNOkWRUMT2f314INmjbmme8gdn65ux
 WhUJRUZOqicohG7VY7EUxztkFSQmGU7cHTOUDZOeEOYIhfl+axEhYhQ6Tu4MzpNGeft8
 nWYkBZh+1OaIfv54bF/dnQmWeJ+jKXqZQq+et0jbMb9MPovsKSI3rXD5B19yJq9qIttF
 4lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253448; x=1693858248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EMdXrfH+xePejoOiwwGdtX0Hn6WMJbM7pyz92IZwhk=;
 b=aVKcbIC7w89vjZYM8I1x1wOpNyEi+351351xaJGCmSnnTstm2NVGWhofgLYv0OnxbL
 isyrP+ZaEX2zocjuPUW/G6ciQzeeHDLaO6ig+9URi3I/Jgw/7eGSBWOh0NIXWkotxH7f
 ORBnaRWiAl+GS5YFsblNkYlA2L9He2ZA4qurwp0EfJfbymNbf79cFbbEN79hJ5m9Qgsa
 buYqqN1yCXk42TT+KAref3lfil1Negcl9PanLt+AmjHK2mhH5wWV25awQECtTaYglCzb
 tSag1+OO6YIOF5sjsvtSKn30OV0hqOORUgHXldjKgUw2L3PZ641KK+IkJbi9iNnsSLFS
 VL6w==
X-Gm-Message-State: AOJu0YyyZ1LLFm6dosrB3Dj6SxrtkGRgUa/hrbteYM7QaJDqv//VEiyM
 Ou4yQ/Wp/Vn62tA0Aij6ipkDkiTPFINVGg==
X-Google-Smtp-Source: AGHT+IFeJ8HOei2pMQPAky0ZRCZltSMCehB7pxvIjYgBrvF0j/Wg21CuGGLBb8e/L1MpbjYLzF8vuQ==
X-Received: by 2002:a17:907:7622:b0:9a1:f5b1:c867 with SMTP id
 jy2-20020a170907762200b009a1f5b1c867mr10531658ejc.41.1693253448052; 
 Mon, 28 Aug 2023 13:10:48 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:47 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 23/32] bsd-user: Implement t2h procctl control request
 commands and h2t reaper status struct conversion.
Date: Sun, 27 Aug 2023 17:57:37 +0200
Message-Id: <20230827155746.84781-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62d.google.com
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
 bsd-user/freebsd/os-proc.c | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 396f258a64..f069472156 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -249,3 +249,55 @@ execve_end:
     return ret;
 }
 
+#include <sys/procctl.h>
+
+static abi_long
+t2h_procctl_cmd(int target_cmd, int *host_cmd)
+{
+
+    switch(target_cmd) {
+    case TARGET_PROC_SPROTECT:
+        *host_cmd = PROC_SPROTECT;
+        break;
+
+    case TARGET_PROC_REAP_ACQUIRE:
+        *host_cmd = PROC_REAP_ACQUIRE;
+        break;
+
+    case TARGET_PROC_REAP_RELEASE:
+        *host_cmd = PROC_REAP_RELEASE;
+        break;
+
+    case TARGET_PROC_REAP_STATUS:
+        *host_cmd = PROC_REAP_STATUS;
+        break;
+
+    case TARGET_PROC_REAP_KILL:
+        *host_cmd = PROC_REAP_KILL;
+        break;
+
+    default:
+        return (-TARGET_EINVAL);
+    }
+
+    return 0;
+}
+
+static abi_long
+h2t_reaper_status(struct procctl_reaper_status *host_rs,
+        abi_ulong target_rs_addr)
+{
+    struct target_procctl_reaper_status *target_rs;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_rs, target_rs_addr, 0))
+        return -TARGET_EFAULT;
+    __put_user(host_rs->rs_flags, &target_rs->rs_flags);
+    __put_user(host_rs->rs_children, &target_rs->rs_children);
+    __put_user(host_rs->rs_descendants, &target_rs->rs_descendants);
+    __put_user(host_rs->rs_reaper, &target_rs->rs_reaper);
+    __put_user(host_rs->rs_pid, &target_rs->rs_pid);
+    unlock_user_struct(target_rs, target_rs_addr, 1);
+
+    return 0;
+}
+
-- 
2.40.0


