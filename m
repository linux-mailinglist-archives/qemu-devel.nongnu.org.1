Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE677A6C6
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:15:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpx-0008HI-2H; Sun, 13 Aug 2023 10:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpk-0008Cc-JF
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpj-0000uZ-0q
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:44 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso3127286f8f.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935961; x=1692540761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6d4ida95YXswhkmIxPn0YCekqtd6+n6y0mTtEISBT8=;
 b=V42FUXdLakZIWEE5NTj9/CLeCiYMgUr2Kb4aUqKj4kjdGLkNa4UR0+QAL2SL2P1Dm2
 e8fEgw3X2tlbGUxLyxRSg2Cf1Lsqn4jZRBbla1g8tUGipk4HWmzjDJ8aGRwYTW6ivzLM
 qXMdgyASExcqIra0yKdvkmhYVZE7qsutIl0KgaEWYyAEzbbgQ4ynWxOpXjR7dXhYzUfw
 0LOggeBWhXXox00wykt9EWVnJuU/nTabTT3IuWXwbiwVte48BRTcKIn3nksrFjYSQ6Ym
 t4MQZLuaqSDV8oZAigyQ0BIxBab3baIfPChS4+8y4Ylv59BafUtd40a7M7i9wcugefYj
 VUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935961; x=1692540761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6d4ida95YXswhkmIxPn0YCekqtd6+n6y0mTtEISBT8=;
 b=K9t/5m5G5Q1j1iJIAyBWYojda2b8B0jmWd/RHjQdGyCHETJxZe9MO2jiSLFg2qkZNL
 zPdkIMZgqoZa0epJAzrVONf7LX9+RQKiaSOK0aeu95k7B3zy7rAcbFvtlTlI6UqSPmyd
 TFyyqWbJLdWU8B5/IjxQgdbG993K5igC6KWK5JecAwr09xLQasR9r7uAVOrl+68g1Mze
 PbC/+qxGXV8DYhnRhtPbRmGMTFcovHlboqXc0Bn7knRrvk/T79vw99Q3gEeU8CGS/L5+
 yJmyNX/+WdZXRatImWrVEuvd5O2TXHJvzxmo8ny94pi/ucl8y/3nQhht/f/NZLevFPLU
 MpCw==
X-Gm-Message-State: AOJu0YzCKhfSif6aDobbjaQz/B3WrcH2QnChI0wwtNC00RCEQxUKO84U
 aQAQO16JYYm2GcTkiodEslSDbnteT0E=
X-Google-Smtp-Source: AGHT+IEz1+Cip2zztXWfqk4xO2t4fVH8tnpQBZ/12aBlxq3IA5CPnTxYJ3GYdaCQhIIB6hrjEwPlWQ==
X-Received: by 2002:a5d:5347:0:b0:317:67bf:337f with SMTP id
 t7-20020a5d5347000000b0031767bf337fmr4633678wrv.2.1691935961409; 
 Sun, 13 Aug 2023 07:12:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:41 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 27/32] Implement do_freebsd_realpathat syscall
Date: Sun, 13 Aug 2023 05:10:08 +0200
Message-Id: <20230813031013.1743-28-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x430.google.com
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

From: Mikaël Urankar <mikael.urankar@gmail.com>

Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index e31b2aab9e..cf56c778ae 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -634,4 +634,30 @@ static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
     return ret;
 }
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
+extern int __realpathat(int fd, const char *path, char *buf, size_t size,
+        int flags);
+// https://svnweb.freebsd.org/base?view=revision&revision=358172
+// no man page
+static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    abi_long ret;
+    void *p, *b;
+
+    LOCK_PATH(p, arg2);
+    b = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+    if (b == NULL) {
+        UNLOCK_PATH(p, arg2);
+        return -TARGET_EFAULT;
+    }
+
+    ret = get_errno(__realpathat(arg1, p, b, arg4, arg5));
+    UNLOCK_PATH(p, arg2);
+    unlock_user(b, arg3, ret);
+
+    return ret;
+}
+#endif
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


