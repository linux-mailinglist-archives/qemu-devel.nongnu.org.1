Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE167A3DFB
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUi-0004as-A9; Sun, 17 Sep 2023 17:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUd-0004aE-JL
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:51 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUc-0004Ib-5Q
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso3722838f8f.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986787; x=1695591587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLCu0wW1o+yl34lwKBXtNHDIXsCq3rTr0rq5b6L0+9E=;
 b=abwndNDAJCdia0vTFEb+6YETlohRzb4Hml4qYHR35s3zExPJJUfE7SrJs2mwZphbGZ
 rk9YkCvg+TKjTYjJRuEZexKiQgnYsBSW+JGNvmCB16jf4fv8iKVUiKxGhwUm7I10VRBy
 QfLCAmvtkOHDxOHAOodoscmA/fPnzy6oLKDLCjMcfAXsY4uDdV3PPd1e1i1pG0P8BZ5t
 76PI3SXulrKYKqUJ/s2n2UFPM+azYva2JRwz/9VdTbUdokME6riANJ9G4hJoOVg25K8e
 KK/xFoVPsMuXOdCd8/QTcaDo4nnYGSB5lgw382cQRqldZ6dBO2/j1ts8rvirF9xNdfoW
 ecZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986787; x=1695591587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLCu0wW1o+yl34lwKBXtNHDIXsCq3rTr0rq5b6L0+9E=;
 b=vz/5hdZfLROH0X8Nv2V1NctNRIfgf9BRJqC6TwbWGP/Ew0bCr/9JBF4a9rmsBxo9mw
 1tpI0jlHAscs3lNeAD2aYGX6ayIDPeCKwTUxy1KhfKnViIuqklTriqt30+g97kEI6U/i
 HXkV5MbRkd+7ikUXpCrkxWZgw9+S6tSwUICwTgBlrChUrmeh5O3IdRqRdjdRvCpFLf1w
 u2y7uEBQn5NXMN5rVfsR3amK16ZbW5eGvIDbG4sCXpqjH/cZoJRlxWHJ+o0gQYLdksFv
 hhiyg2wEpIuT+zDdsvZpopsxxlxZKjILrDRGDJwoKtE0D6Q4mvITsXy3yENQJQpuMcug
 mPmw==
X-Gm-Message-State: AOJu0YxvJb8n6HYf89MYh1rKx3yISn0SeWaTSAO8TnquAfykbYXLLdnn
 6LWzvbduig43pbjPoMFm89jTZsrXHrw=
X-Google-Smtp-Source: AGHT+IGCP+VJDwIZQmep0/6AeyskGmXbBpLRmSzrd0Yi5QmA9ZtAonoqgydwYMRF6/eTYVVVjDvPnw==
X-Received: by 2002:adf:a15b:0:b0:31f:fafe:a741 with SMTP id
 r27-20020adfa15b000000b0031ffafea741mr4312097wrr.67.1694986787337; 
 Sun, 17 Sep 2023 14:39:47 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:47 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 17/28] bsd-user: Add stubs for profil(2), ktrace(2),
 utrace(2) and ptrace(2).
Date: Mon, 18 Sep 2023 00:37:52 +0300
Message-ID: <20230917213803.20683-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42d.google.com
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
---
 bsd-user/bsd-proc.h           | 28 ++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index edbd408995..fff1d4cded 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -362,4 +362,32 @@ static inline abi_long do_bsd_issetugid(void)
     return get_errno(issetugid());
 }
 
+/* profil(2) */
+static inline abi_long do_bsd_profil(abi_long arg1, abi_long arg2,
+                                     abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
+/* ktrace(2) */
+static inline abi_long do_bsd_ktrace(abi_long arg1, abi_long arg2,
+                                     abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
+/* utrace(2) */
+static inline abi_long do_bsd_utrace(abi_long arg1, abi_long arg2)
+{
+    return -TARGET_ENOSYS;
+}
+
+
+/* ptrace(2) */
+static inline abi_long do_bsd_ptrace(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7b51f4f16e..1a760b1380 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -343,6 +343,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_issetugid();
         break;
 
+    case TARGET_FREEBSD_NR_profil: /* profil(2) */
+        ret = do_bsd_profil(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_ktrace: /* ktrace(2) */
+        ret = do_bsd_ktrace(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
+        ret = do_bsd_utrace(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_ptrace: /* ptrace(2) */
+        ret = do_bsd_ptrace(arg1, arg2, arg3, arg4);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


