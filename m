Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C948C7A3E73
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bt-0006a1-Hf; Sun, 17 Sep 2023 18:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Br-0006ZM-KL
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bp-0002wn-Vg
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so3439527f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989468; x=1695594268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLCu0wW1o+yl34lwKBXtNHDIXsCq3rTr0rq5b6L0+9E=;
 b=CY5gR8BKr0ucGVvVf7kE0aBRqi0JiVHAB4FVqmg1t+7iqNLTIAIcdya64pVeVEqtI5
 zfU5xgkfATGiuBe3Rw6kUkwr3/RyIqYwOZrYu8Pqf9jIVAxFZ+yA3GQP5qoUfsY2yUhG
 h2GDvxvN1KJYnncbGSbCSVnxRiN/5pOTdNjD1wNaixbAwEif+NAI0cs7WAanfU8M2mv7
 QkOtyVq0i+d8xaO5Zn/ACuWgXW43KuG9gHxP+7PndtRCGSHmqh8sdBrnsQVE5qLFptUf
 dhv0NIgfOCxEiWM3sz7PVgB/spvd+Aqu7j1EexAh3q9KZk1bW1RZbW0Nay6N4MYKe+v1
 jNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989468; x=1695594268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLCu0wW1o+yl34lwKBXtNHDIXsCq3rTr0rq5b6L0+9E=;
 b=JYGgyvkJbNh4xOMz1TQxJC5goq1dqX5Tpf8ZUIPqvhSNrKOabB/xGlP9RauDbDiS/M
 IozgZc6sc5zFnMTNpLB6TIgx/oprB02Q+oaFdqlVA8JLQWVn/mF8XF3CKbX8c/XdINT9
 6L3yqeVldyM9D0/1Hor6pi1gZVGPbvsaY52Z+mF3NeE7N8Mk548OyPyWseYzbBVVTMHQ
 DGGFpnHBRj6Sd7oHeA96AXID6svdb3xsRy25nWnG9OGC20vCXwlH9Ja1ZSLmx/Ri6W15
 fAhlC/f6OxY3IBWY//hUpDJ9IqZ1BP/yxTCrMEmAECdy58bg8Ja4X3xLgKv3o1L870hH
 kssw==
X-Gm-Message-State: AOJu0YxZ6hPc5/5fDdS9QADGH1F2UZHvuJuUqa2WrsUzmqGP8KV92oHK
 pR6Eij7eQOqshYS87VXwFhQ+BkztHE8=
X-Google-Smtp-Source: AGHT+IEYsU6ybJeyII9W/c8MU/3aGY2BcJZS16WdH9h1WVIvglbXzIEjhtEUvj/pRjPXG1WH39sQgA==
X-Received: by 2002:a5d:5091:0:b0:317:dada:2417 with SMTP id
 a17-20020a5d5091000000b00317dada2417mr5836132wrt.31.1694989468363; 
 Sun, 17 Sep 2023 15:24:28 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:28 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 17/28] bsd-user: Add stubs for profil(2), ktrace(2),
 utrace(2) and ptrace(2).
Date: Mon, 18 Sep 2023 01:22:34 +0300
Message-ID: <20230917222246.1921-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
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


