Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A67ADEA0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHt-0001OK-B8; Mon, 25 Sep 2023 14:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHr-0001NJ-5n
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHp-0007Ri-4O
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-404314388ceso76769605e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666382; x=1696271182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyM+L5pDaFr2bIbdcn+AZXO2bqBFg5Oap17M0Gq1JLg=;
 b=E2abJttN5wuu7dVIojnwBKQS5frlFPfiGRNu5lTbbcB5qZ20M25IYae73yIbQroxSI
 fM7+HLd7NSZGhJN+48hggcYEBgiqrXP3QrL0Ou3kMyz+kkduq77NZlPZfhrFOZsxjtHg
 lZDFPfK/i5FpQ70JdUeS3S3FbGO1e2XhS5BfItuUS4Y65wZKW8BG+an/Fvu+x1cg2AQf
 gjSzLb8R/tMLN6GW3C0FDLZqcqv/HWEJMkybsiquFaSf9yntvBToCJ4i39sxxi4sF7iz
 qJMKCz0ClJ8TVqkkWyVAp5i15ZEWGuHfmPR4DDv1Oy3Khlun0/Ebo0cVxRMAXq4AJ7yT
 wqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666382; x=1696271182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyM+L5pDaFr2bIbdcn+AZXO2bqBFg5Oap17M0Gq1JLg=;
 b=Q0Ij4ewg1eaUTS2iduxADZMEPgjPZ+SF1jJ0kCDXcf9903npIwXSogYQ3YjQ8y59Ag
 pGffnhWJiGETAA60IgkSSeL3STTGpMEWnHsoKZKp5v1WQhfywiF8UQUvsOTKleJXclg+
 mx9RXMq5Zhu9FeyAnT3q54VC0/rHnQLRiWDZ1vu9Rot5BTOyr067tRobOfHV3SwI1Rvb
 9SjW48ieCULqrrB6+2iMVcQAeemqnY2CbhHIu9+DlddctMMXbvLFZ6333jpBVKA01s/P
 gAWiLIFLip//CmyNOp3my9krrRX5eO+YCODtsZ+a9t2e4TZW2c6ihntDHfNYgs4gKpPl
 6FiQ==
X-Gm-Message-State: AOJu0YyA8Wf46ei2M/IOxHgKBlQaU/vJWKi72iu0Ez5U4c3X4Dx/RleD
 m7DDkZdMic3dwKKTwvvlR8lEk/FyQAM=
X-Google-Smtp-Source: AGHT+IEkHbYuTgHWv+mkxtanFD6QdU5w9dG2k7sqRIHUi0i4bjFfuKLWTsEA9mYuRVa7ui3Q5Q45nA==
X-Received: by 2002:a05:600c:895:b0:405:95ae:4aa7 with SMTP id
 l21-20020a05600c089500b0040595ae4aa7mr1858609wmp.10.1695666382481; 
 Mon, 25 Sep 2023 11:26:22 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:22 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 24/28] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
Date: Mon, 25 Sep 2023 21:24:21 +0300
Message-ID: <20230925182425.3163-25-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 04bce755e5..2eaba141dc 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -130,4 +130,36 @@ static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
     return ret;
 }
 
+/* setloginclass(2) */
+static inline abi_long do_freebsd_setloginclass(abi_ulong arg1)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setloginclass(p));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* getloginclass(2) */
+static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getloginclass(p, arg2));
+    unlock_user(p, arg1, arg2);
+
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 55e68e4815..d614409e69 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -375,6 +375,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_ktrace(arg1, arg2, arg3, arg4);
         break;
 
+    case TARGET_FREEBSD_NR_setloginclass: /* setloginclass(2) */
+        ret = do_freebsd_setloginclass(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_getloginclass: /* getloginclass(2) */
+        ret = do_freebsd_getloginclass(arg1, arg2);
+        break;
+
     case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
         ret = do_bsd_utrace(arg1, arg2);
         break;
-- 
2.42.0


