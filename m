Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F41272669A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wTQ-0000BX-KF; Wed, 07 Jun 2023 12:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wTH-0008Ox-Ff
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:57:22 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wTF-0001nO-Vs
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:57:19 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-62b68ce199bso15270196d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686157036; x=1688749036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcBYnv0Q5hRVAWcJGt6sLApFKby4ljDsg3FDGA0assE=;
 b=YjXdW8L52xbS5+33vJ8zDOqLQR8rRv8JlCdJhGj5W7mujpB976rx/ERORYbYrCvAiI
 lTtFmw/lG4L/DH0iBS2PPwHZbFFhtHeHWSV/hJx18DGXkcfNnyQcJvIRRwKeoT95WgcK
 T9/w9wSEg9EMMWh4znhsrMVaNASoh1znB5zucWiLosqvLpA5j0QUz3Q/GbRphqRyeE+2
 2a7QRK3mATM+ScHq4yE7PIVHfgnO1NWE2NXgK+4Q4e8GuQJ72TIUDx+RZ55UrTMImgzW
 ft+PUm+sBoVadftyEH/f3H/2HvwstYgbzJMM8NS2oJ0LbzCRZ9i39UXI8EQ04Cre+81W
 4Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686157036; x=1688749036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcBYnv0Q5hRVAWcJGt6sLApFKby4ljDsg3FDGA0assE=;
 b=LWWK2q6eZzTYWVuL2+0GQVsti8oW8WkzupWThwrA1uDtiYzfd/cK97z1Jp/8lToh3W
 /tLb/8IIyQYCp8GgUbcZDWZ2Jrj/5qce5z7RPNrwPYIpY0xtmpVTd9PwUEb3Zsb0i3bm
 u1xakIRxoR1V+mf2IpfS1DI1c68rKSD9lFZ2yaMqpj9OyA8zBOHkLC6NYyyZ3OQPbFGf
 cKj0sptEQzRc+npfj4fHA3NzhGMMDlz1XpgPwPCMCf75cG7XH49VipVX9wwPHeBnf1wS
 G0Dc5cYE5PhqlFHJPAIAym8pGmyVN3koWdp7WQGbKvQXv+RFRQpF8Eu4qh1W37pH9/gw
 mMcw==
X-Gm-Message-State: AC+VfDyskfUosRkveNT9STN1kP3Gx5eIiah7PuBxpMWJX4FQircXMuig
 gxImp85pX2M3SWF1W/rGH2IpxTmWg7/eFWAQoQ8=
X-Google-Smtp-Source: ACHHUZ6wnxTBDA3U/pbZxhcNpzhDRKmtk5lBOKLhP5JBCZ8xmnNW3293oFu9iOg36OofVLaEdy55nQ==
X-Received: by 2002:a17:90b:918:b0:259:1a50:5719 with SMTP id
 bo24-20020a17090b091800b002591a505719mr2395504pjb.1.1686156555438; 
 Wed, 07 Jun 2023 09:49:15 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.226])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a001e00b00250bf8495b3sm1671808pja.39.2023.06.07.09.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 09:49:15 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: [RFC v2 2/6] Add the libnative library
Date: Thu,  8 Jun 2023 00:47:46 +0800
Message-Id: <20230607164750.829586-3-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 common-user/native/libnative.c | 65 ++++++++++++++++++++++++++++++++++
 include/native/libnative.h     | 11 ++++++
 include/native/native-func.h   | 11 ++++++
 3 files changed, 87 insertions(+)
 create mode 100644 common-user/native/libnative.c
 create mode 100644 include/native/libnative.h
 create mode 100644 include/native/native-func.h

diff --git a/common-user/native/libnative.c b/common-user/native/libnative.c
new file mode 100644
index 0000000000..d40e43c6fe
--- /dev/null
+++ b/common-user/native/libnative.c
@@ -0,0 +1,65 @@
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "native/libnative.h"
+#include "native/native-func.h"
+
+#define STR_MACRO(str) #str
+#define STR(num) STR_MACRO(num)
+
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+
+/* unused opcode */
+#define __PREFIX_INSTR \
+    ".byte 0x0f,0xff;"
+
+#define NATIVE_CALL_EXPR(func) \
+    __PREFIX_INSTR             \
+    ".word " STR(func) ";" : ::
+#endif
+
+#if defined(TARGET_ARM) || defined(TARGET_AARCH64)
+
+/* unused syscall number */
+#define __PREFIX_INSTR \
+    "svc 0xff;"
+
+#define NATIVE_CALL_EXPR(func) \
+    __PREFIX_INSTR             \
+    ".word " STR(func) ";" : ::
+
+#endif
+
+#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
+
+/* unused bytes in syscall instructions */
+#define NATIVE_CALL_EXPR(func) \
+    ".long " STR((0x1 << 24) + (func << 8) + 0xC) ";" : ::
+
+#endif
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCPY));
+}
+
+int memcmp(const void *s1, const void *s2, size_t n)
+{
+    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCMP));
+}
+void *memset(void *s, int c, size_t n)
+{
+    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMSET));
+}
+char *strcpy(char *dest, const char *src)
+{
+    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCPY));
+}
+int strcmp(const char *s1, const char *s2)
+{
+    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCMP));
+}
+char *strcat(char *dest, const char *src)
+{
+    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCAT));
+}
diff --git a/include/native/libnative.h b/include/native/libnative.h
new file mode 100644
index 0000000000..d3c24f89f4
--- /dev/null
+++ b/include/native/libnative.h
@@ -0,0 +1,11 @@
+#ifndef __LIBNATIVE_H__
+#define __LIBNATIVE_H__
+
+void *memcpy(void *dest, const void *src, size_t n);
+int memcmp(const void *s1, const void *s2, size_t n);
+void *memset(void *s, int c, size_t n);
+char *strcpy(char *dest, const char *src);
+int strcmp(const char *s1, const char *s2);
+char *strcat(char *dest, const char *src);
+
+#endif /* __LIBNATIVE_H__ */
diff --git a/include/native/native-func.h b/include/native/native-func.h
new file mode 100644
index 0000000000..d48a8e547a
--- /dev/null
+++ b/include/native/native-func.h
@@ -0,0 +1,11 @@
+#ifndef __NATIVE_FUNC_H__
+#define __NATIVE_FUNC_H__
+
+#define NATIVE_MEMCPY 0x1001
+#define NATIVE_MEMCMP 0x1002
+#define NATIVE_MEMSET 0x1003
+#define NATIVE_STRCPY 0x1004
+#define NATIVE_STRCMP 0x1005
+#define NATIVE_STRCAT 0x1006
+
+#endif
-- 
2.34.1


