Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29D7A0EB3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZQ-0002rD-Ej; Thu, 14 Sep 2023 16:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZN-0002qm-OF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZM-0001Sc-8Z
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40473f1fe9fso9771535e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721846; x=1695326646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1JJvYfQaijMliqHhsRQy54P2Tgf046fCUOip2mqXz4=;
 b=NSMp2FYTzDiWTtcTwAcKjTcHm5I/l6loimuSq6rvqkf2ZQrNjk5Xb+aQDoYl6N+Pj7
 vr1uOdEPHJkDiI1N5vZht7kgGkNjwdgYkx8uPWov9x1J2RBlPKEarauWvdLlfnwX9rxP
 3URiSMhgmnN0M4ucAGcuRZqMluAK56lSPbAJ+nQH24SZKdlpLrwwHBduSmaM8dH6s25o
 nlBY7UeNu7tPd7/NuhEXDMI16crG3S19AwWoNUtsepAlpRQT9ZqJkbL1+tpr+CPZGDNW
 5+eVFj+uD0q8Maa6EJRBkX5iJyoWNFm6P3Py+qKtZ+9/+Qjzzbmd/hX2G5WVaKt85/CW
 /BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721846; x=1695326646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1JJvYfQaijMliqHhsRQy54P2Tgf046fCUOip2mqXz4=;
 b=P0HGIQ9CFQZSha2uge7uYq4j0dgG5+JpA+6eKEj8jnnOotqMJqPm7thEJCDEuUXGm0
 HimkXrIrYSsp1XMiC+QFog2bhy1+5yggKN1mjXSDpxdXxftG0SjryDVyM3UzoXe0EgeS
 UAdvTOgxEEOdVlL/TYGjxXHhKxXnBArVIvzFfpkCHxQc5f8FYSPlX94CIlXxFF1jMO1z
 HFxDu6bvFzNCAFFps5EcmxVdSMfLv3bHKW0TkO+ZaNyyWbYfZlyUOdjqnA6jMexG7jM/
 yiM0qTE3d0XGiyDH1L7Jh9Md9Y+zeBDQpBTs3nvBk5wxvzXtY0tNuYSovl6nDUf/mQKq
 huFQ==
X-Gm-Message-State: AOJu0Yz2oebrZ27rMh2f4O340fg6hsXBGHGjr1/paWmRelQYa/peVB1J
 UOZhAzUQxYb7EybRtKeH+WV3vBAlkbI=
X-Google-Smtp-Source: AGHT+IH36bohLuLbyDCNDSnj/HZ6a+t5AujjX9kFFu6brnsh3pfdMfImMtJEUg6GQVHWbNZb8vfW4w==
X-Received: by 2002:a7b:ca47:0:b0:3fe:4cbc:c345 with SMTP id
 m7-20020a7bca47000000b003fe4cbcc345mr5675389wml.41.1694721846599; 
 Thu, 14 Sep 2023 13:04:06 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:06 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 01/23] bsd-user: Implement struct target_ipc_perm
Date: Thu, 14 Sep 2023 23:02:20 +0300
Message-ID: <20230914200242.20148-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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
 bsd-user/syscall_defs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index e4825f2662..39a9bc8ed7 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -55,6 +55,23 @@ struct target_iovec {
     abi_long iov_len;   /* Number of bytes */
 };
 
+/*
+ * sys/ipc.h
+ */
+struct target_ipc_perm {
+    uint32_t    cuid;       /* creator user id */
+    uint32_t    cgid;       /* creator group id */
+    uint32_t    uid;        /* user id */
+    uint32_t    gid;        /* group id */
+    uint16_t    mode;       /* r/w permission */
+    uint16_t    seq;        /* sequence # */
+    abi_long    key;        /* user specified msg/sem/shm key */
+};
+
+#define TARGET_IPC_RMID 0   /* remove identifier */
+#define TARGET_IPC_SET  1   /* set options */
+#define TARGET_IPC_STAT 2   /* get options */
+
 /*
  *  sys/mman.h
  */
-- 
2.42.0


