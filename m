Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA9743CA5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4g-0007bW-N5; Fri, 30 Jun 2023 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4f-0007ax-27
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4c-0003Mi-Hj
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313e34ab99fso2025410f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131325; x=1690723325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRhCAakrEPIhhwkjbQqX6qZEbetcXESvazfsDHoPFvs=;
 b=RMz1tbrSPx1JOTe3Klwj+xUvY4wBZJaFu8Hvrlq00ABSgLVY3Zh+DNwluYtuHJ3+iU
 RfaTL3oUzvKuzLQJMEHZNv1MmvnVIw5QJD1JiVHqDvQNx1+GzdU7BZYRvcZGJCz1TUCr
 iAq04tLs9af1G1ryJFOvlElv2xnqKse4qKsDF/YPqtXqXKMNfLZaF+vsXG1y/tJR+Ca7
 LLsgGh4n4xHVuQ5LDKeVupv5BKGaDeg4dOnyOaDyqwTCWnSTwVODXx2C8OPKtl2GvDht
 8tL89/yu81dOyipPcp//ehMkED/2wt8CNBeiGQawsJ03i+UJijOeydiqI7zinRmCiCXz
 QGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131325; x=1690723325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRhCAakrEPIhhwkjbQqX6qZEbetcXESvazfsDHoPFvs=;
 b=LWnbBYlN+yF19xiD+qh7BDOUh2LwYMNzBEZ5wRItadqL0LIPaZU6Po8xQ4iBGIwzPD
 KTeL7W3C84Y3K/fsBJFukvgEDoINhCkF6AJGjabLVv7H4mMAgxGMVtZHM6dNG3X1RS+B
 /IpF7WL7nRl5QHYmFtj03xxBhUeVESb0qhNFTWWBSGvbkpT74Rt3O05SkxEXNODbx/ww
 Lp4XTxmp3EwhWxCjZwniVp4NXpVj1DrBxNvbbsIhJF4GXzwcHHGu31POSkAqzmOdE+aP
 Sxz6Jmu/MU5tOgU3s7TqYS639q/vw2H6oZpYACc2xFsZJ+3wx/KWcJQkZTiZhrKxNRbJ
 /Nww==
X-Gm-Message-State: ABy/qLZaUWBTpFWLGv7oxh1Lb4nIWIH8cQsmxjUSHwQkLq/zaegqAYZF
 EF9TYHnJeuNEC/Tr0R7xitvj206mgUFf6pugM8OReQ==
X-Google-Smtp-Source: APBJJlH7LOXHP7Mq+MRRtMEGUSirtC3D0qVxQjGX+v+9xXRoJYagiiiGrSrANXXA9qSugGt3UwFjSA==
X-Received: by 2002:adf:ead2:0:b0:30d:d85c:4472 with SMTP id
 o18-20020adfead2000000b0030dd85c4472mr1954864wrn.62.1688131324899; 
 Fri, 30 Jun 2023 06:22:04 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 05/24] linux-user: Split TARGET_PROT_* out of syscall_defs.h
Date: Fri, 30 Jun 2023 15:21:40 +0200
Message-Id: <20230630132159.376995-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move the values into the per-target target_mman.h headers

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_mman.h |  3 +++
 linux-user/generic/target_mman.h |  4 ++++
 linux-user/mips/target_mman.h    |  2 ++
 linux-user/syscall_defs.h        | 11 -----------
 linux-user/xtensa/target_mman.h  |  2 ++
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/linux-user/aarch64/target_mman.h b/linux-user/aarch64/target_mman.h
index e7ba6070fe..7f15cab25e 100644
--- a/linux-user/aarch64/target_mman.h
+++ b/linux-user/aarch64/target_mman.h
@@ -1 +1,4 @@
+#define TARGET_PROT_BTI         0x10
+#define TARGET_PROT_MTE         0x20
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/generic/target_mman.h b/linux-user/generic/target_mman.h
index 7b888fb7f8..39a650e751 100644
--- a/linux-user/generic/target_mman.h
+++ b/linux-user/generic/target_mman.h
@@ -1,6 +1,10 @@
 #ifndef LINUX_USER_TARGET_MMAN_H
 #define LINUX_USER_TARGET_MMAN_H
 
+#ifndef TARGET_PROT_SEM
+#define TARGET_PROT_SEM                 0x08
+#endif
+
 /* These are defined in linux/mmap.h */
 #define TARGET_MAP_SHARED               0x01
 #define TARGET_MAP_PRIVATE              0x02
diff --git a/linux-user/mips/target_mman.h b/linux-user/mips/target_mman.h
index d1d96decf5..e9f3905a52 100644
--- a/linux-user/mips/target_mman.h
+++ b/linux-user/mips/target_mman.h
@@ -1,3 +1,5 @@
+#define TARGET_PROT_SEM                 0x10
+
 #define TARGET_MAP_NORESERVE            0x0400
 #define TARGET_MAP_ANONYMOUS            0x0800
 #define TARGET_MAP_GROWSDOWN            0x1000
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 118a8ac7da..9387ed422d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1251,17 +1251,6 @@ struct target_winsize {
 
 #include "termbits.h"
 
-#if defined(TARGET_MIPS) || defined(TARGET_XTENSA)
-#define TARGET_PROT_SEM         0x10
-#else
-#define TARGET_PROT_SEM         0x08
-#endif
-
-#ifdef TARGET_AARCH64
-#define TARGET_PROT_BTI         0x10
-#define TARGET_PROT_MTE         0x20
-#endif
-
 #include "target_mman.h"
 
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
diff --git a/linux-user/xtensa/target_mman.h b/linux-user/xtensa/target_mman.h
index d1d96decf5..e9f3905a52 100644
--- a/linux-user/xtensa/target_mman.h
+++ b/linux-user/xtensa/target_mman.h
@@ -1,3 +1,5 @@
+#define TARGET_PROT_SEM                 0x10
+
 #define TARGET_MAP_NORESERVE            0x0400
 #define TARGET_MAP_ANONYMOUS            0x0800
 #define TARGET_MAP_GROWSDOWN            0x1000
-- 
2.34.1


