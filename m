Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 848457B7540
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovG-00044P-JW; Tue, 03 Oct 2023 19:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovD-00041v-3R
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:23 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovA-0006qR-9Y
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:22 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so14837939f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376119; x=1696980919;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7VRFr4gHk91MagU57mxTPEhJmPz5+DN76M+3LJyxsA=;
 b=3FeLSFVnivgvxTLodcbyaV+PWwF17To8sjkZNQOHcHsQbwlXIcgPrJy7utrrTlpoXe
 7ZXFd9qv98yyHZyrsXMc+QaEAPxfvYuSs9+g8QU6W3H2+bufLV/ajA4vREAG1ok+Oi4a
 nEi/v5ilVvff3T9rvyx6hgC1V5mxmf4ChVqDyXdixsj1PK6g+v7Hr1So/2FotGfnQbvV
 amFHrpbZJ5a4EclFJWO998RfeLPdfNf2BNE7odHmj8AZhEtFFliC0fM4Z+QedEvxJ8Hw
 f5zn4JvNBc8QgNRCEXybkWaYzE6dG/a15goolbPPv9ean9Ysw0dIDwwVQcEmwxeNwpUZ
 1VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376119; x=1696980919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C7VRFr4gHk91MagU57mxTPEhJmPz5+DN76M+3LJyxsA=;
 b=mWlVoKL2pp9eCztqOn2LM2O7KlzRNXq/F6gmwc+1CJ+WCN7XTK3x0hCqFBqGtvKxnu
 3GLSd4Yzly2OcYZI6P80/vkklulPUUvjZUJLqTtcyYmXyY2d6PMVG9xTf/q1D8oKAMIL
 ylPonGqw1coHPdkW8JoGL4hUWOQEU1hU8GMBHcOvrN0VjixGt8rbT4ZyLS3Gd5CNz0yl
 BO9QA0v0uKYPQT1tfmiAr6aTnpEfMBmjdni2aiovoctW+iE8RBxe7Km3XcQeCkBfPowA
 mNgZVVqLZIsFsbRAUeP6d5AOj+yfhy3oV7otQp3bkb4dJnmoHsKVDBzVfdVlM65TlDeU
 6QUA==
X-Gm-Message-State: AOJu0Yxlk3RRMoQ+E8V+QKSExKWcfDge93siritPXJYLFegbXXRt1YMu
 6E8ApOPAULj7AQj3BbWSlr1ObXuGa04/Zq9fhfkygg==
X-Google-Smtp-Source: AGHT+IEbBdmKKfbHwDq0CPzm+u8y/OaUYYygPT0FNV9jBQxLPC6xSVZkVB8UBcNwtiso3ONvfera8w==
X-Received: by 2002:a05:6602:2c4c:b0:79f:e800:ea95 with SMTP id
 x12-20020a0566022c4c00b0079fe800ea95mr4015629iov.3.1696376118823; 
 Tue, 03 Oct 2023 16:35:18 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:18 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/51] bsd-user: Implement getrusage(2).
Date: Tue,  3 Oct 2023 17:31:37 -0600
Message-ID: <20231003233215.95557-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd30.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-14-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 13 +++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index cb7c69acb0c..133c1b0eaf8 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -124,4 +124,17 @@ static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* getrusage(2) */
+static inline abi_long do_bsd_getrusage(abi_long who, abi_ulong target_addr)
+{
+    abi_long ret;
+    struct rusage rusage;
+
+    ret = get_errno(getrusage(who, &rusage));
+    if (!is_error(ret)) {
+        host_to_target_rusage(target_addr, &rusage);
+    }
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 44cbf52f087..5d8693ed550 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -243,6 +243,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_getlogin(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getrusage: /* getrusage(2) */
+        ret = do_bsd_getrusage(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.41.0


