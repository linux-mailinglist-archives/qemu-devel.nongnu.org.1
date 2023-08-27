Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C978B945
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:13:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiaX-0006Xr-9x; Mon, 28 Aug 2023 16:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaI-0005ko-88
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:39 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaF-0007pr-N7
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:37 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so450098566b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253494; x=1693858294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsIP+hLVoNZVL2chjKVfWZpIi2TdYp0OHNSsvbgsB80=;
 b=ChbXbzonPEVsTEkLBYGEkF1Xg4WGV4xAlFbB3O9W+P4NCztD7QX40Rl9M3OQW2c9tl
 59D+NwgkifznG6CW0TzFOdEOpRq/bnyQz1+Jre4yk8YL1UkRxTblNIlBUkLUxvN4vh94
 4UozfiR+5EYod2P0voG+bGlXAowqitMpeZ0zHWmSE2o8+sRKRkhfKVGUhNJDQ2lsJpQi
 PdJ2iGgBJpM1gusFxZEWfsrqiRxOlXz+JdyYIfJ4U0qMusYTcDamykpToJGTLBmiWXz+
 DqoMQ9aaGzq5yfoLgd+5qSTu62g3/r8fjWGB/ZtjhUOjAwcAtk5VerdP4or/UwST2Eol
 rQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253494; x=1693858294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsIP+hLVoNZVL2chjKVfWZpIi2TdYp0OHNSsvbgsB80=;
 b=OehPjsdguVhlvlGIkOiaTNg8NlHQ/nzx5yAMe9jgcf+7xNGlTfpg8E5gb7kDC4mwyt
 saX3X9jONRzZK5ULL7Qbde0gijwhtr62COYneCfyR3KhzqZs+FM+1fnMWGzZCXar0a5b
 gxgbIkDVaMrEQX3T4EG6qM6jCTk/giXrZOB0rQ+CZo/Lh5KTytE0dcNxS0Bh+GoqtAoR
 mMXWdgfjnOIVwof1hqVE7nyqVJgcXWOHfGbF5L/uY5nCPcLBDfJU7VokDTynAsp6vZHp
 2+VU8yKp3s+aUuhD0Un/OBKN4z9Ox34EExLBOyUVnz1ofRU/Aa7/TiShOIRR/plqddTK
 QPTw==
X-Gm-Message-State: AOJu0YwhrrnPBVLS5V3giSeS9TVucXrcs1ibso0T3PXhNLdSySgvlJwO
 ZSiGiBAUSuCfAkcNkeZg7nNWcYiu1IKZfw==
X-Google-Smtp-Source: AGHT+IFeFoMjcafqbk55YiDYn6TED22FEdCIONZl5+Klj0zoqdlKfWMnfXBm0rA23J8ZPsnZgLPR7Q==
X-Received: by 2002:a17:906:6b92:b0:969:93f2:259a with SMTP id
 l18-20020a1709066b9200b0096993f2259amr19296928ejr.73.1693253494002; 
 Mon, 28 Aug 2023 13:11:34 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 28/32] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
Date: Sun, 27 Aug 2023 17:57:42 +0200
Message-Id: <20230827155746.84781-29-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62e.google.com
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
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 544e45b3ef..7d26d09148 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -121,4 +121,36 @@ static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
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
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getloginclass(p, arg2));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 2775f89304..63e6c6d478 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -372,6 +372,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.40.0


