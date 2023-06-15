Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B797311BC
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 10:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9hzB-0002eU-4h; Thu, 15 Jun 2023 04:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q9hz8-0002dx-Jc
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 04:05:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q9hz6-0002lo-F8
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 04:05:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30fc50d843aso3160144f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686816335; x=1689408335;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOJX6NZJboIKh9l5WjP2c1Cfn1o40z0DcsnSg7vaJzc=;
 b=bLGHPcePVE7/Zr3RmSpohgkj0fc2pXdRn/0F6Evlw3d+3Lb+13VEwIHTZiiLtLVB94
 LZLnb6VaIy5ks/run2nwfBRhHWmIgx7JusHjdzQFJoBvSzRQwKiZaa0wdFnxIRsGeWdo
 DvtOULaEESFw0Aphl4qqVb6yVzSNEXmAUBFQ2L6uUS/HthLeKXdAqWen8NJcw2wm5i1e
 goH4cPsuPOJnnQ/6yJEjtmy7We9ZYxWSw3Hnf4X0mDhE3fy48mpHxePFnnM2EgZpzcYQ
 FVRIjce2ALic6uHWfrCE5KmWQt/UOvhYDk/jhSPU90OUrP+2vKFil5nXlUGpm+XZEobP
 +Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686816335; x=1689408335;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kOJX6NZJboIKh9l5WjP2c1Cfn1o40z0DcsnSg7vaJzc=;
 b=bQg1O1SXe2XLnJmGacNhIX0XU9wDUGWME/+Jfvpfg6YXkmzw4BY6K5Bq6ntWe6+x7M
 6gFicuDHnn16Ld3EB/m1E2SOOy99V/Tpg3YaBVgMIA0/H9HEqqZ/xRiYdPw7E5r1vtOz
 QBDFXJjgG5RdTzXz2bcijyksLs8ix+JsOXAYfLBRcnShwQbmEUsqUTwsytZLc7sx3p40
 Fjx5Yk0xb8TYQqgsCAbyQlUAnC8BPWMu2fIUBpJ73N0Ob4oOvJwDCKpvkOrzMi4CJqiw
 HWijd/K7lrEZx01OYoohG8GtzYU2qtJPK4MGQyJpzo/wjh8Y3X6a1kgJQ10bXAf8rNAv
 /Fmg==
X-Gm-Message-State: AC+VfDwtBfwl+kBYMX3RXfJBt+erLfI0xoNlYyEQxHNiO3w8Y5pYbU0Q
 ueOa8kWe/b1LzyjpgVw8d93mUw==
X-Google-Smtp-Source: ACHHUZ5FEj2j/vGPZi8iZqoC2smU/K8V+ebpq3oSnXyLamtLPyDuyss/77Y/aEAtYUWTqgMt0m0mEg==
X-Received: by 2002:adf:f1d0:0:b0:30e:3ccf:d4b1 with SMTP id
 z16-20020adff1d0000000b0030e3ccfd4b1mr10150134wro.4.1686816334629; 
 Thu, 15 Jun 2023 01:05:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a5d5306000000b003110ab70a4fsm3628863wrv.83.2023.06.15.01.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jun 2023 01:05:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABF411FFBB;
 Thu, 15 Jun 2023 09:05:33 +0100 (BST)
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-3-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Riku Voipio
 <riku.voipio@iki.fi>
Subject: Re: [RFC v2 2/6] Add the libnative library
Date: Thu, 15 Jun 2023 08:59:39 +0100
In-reply-to: <20230607164750.829586-3-fufuyqqqqqq@gmail.com>
Message-ID: <87r0qd5ewi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  common-user/native/libnative.c | 65 ++++++++++++++++++++++++++++++++++
>  include/native/libnative.h     | 11 ++++++
>  include/native/native-func.h   | 11 ++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 common-user/native/libnative.c
>  create mode 100644 include/native/libnative.h
>  create mode 100644 include/native/native-func.h
>
> diff --git a/common-user/native/libnative.c b/common-user/native/libnativ=
e.c
> new file mode 100644
> index 0000000000..d40e43c6fe
> --- /dev/null
> +++ b/common-user/native/libnative.c
> @@ -0,0 +1,65 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "native/libnative.h"
> +#include "native/native-func.h"
> +
> +#define STR_MACRO(str) #str
> +#define STR(num) STR_MACRO(num)
> +
> +#if defined(TARGET_I386) || defined(TARGET_X86_64)
> +
> +/* unused opcode */
> +#define __PREFIX_INSTR \
> +    ".byte 0x0f,0xff;"
> +
> +#define NATIVE_CALL_EXPR(func) \
> +    __PREFIX_INSTR             \
> +    ".word " STR(func) ";" : ::
> +#endif
> +
> +#if defined(TARGET_ARM) || defined(TARGET_AARCH64)
> +
> +/* unused syscall number */
> +#define __PREFIX_INSTR \
> +    "svc 0xff;"
> +
> +#define NATIVE_CALL_EXPR(func) \
> +    __PREFIX_INSTR             \
> +    ".word " STR(func) ";" : ::

I think we can do a little better and encode the ABI parameters in the
expression. I hacked up an example for Aarch64 which:

  - uses HLT instead of SVC (as user-space should never see a halt)
  - encodes the size of in and out args
  - terminates the sequence with HLT 0

Using HLT gives us 16 bits of encoding informaion per instruction while
still looking vaguely sane in debuggers/in_asm dumps. Decoding this in
the translator is left as an exercise for the reader:

--8<---------------cut here---------------start------------->8---
experiment: encode ABI parameters in libnative

3 files changed, 85 insertions(+), 13 deletions(-)
configure                      |  2 +-
include/native/native-func.h   | 21 ++++++++++++
common-user/native/libnative.c | 75 +++++++++++++++++++++++++++++++++++----=
---

modified   configure
@@ -1821,7 +1821,7 @@ native_flag_i386=3D"-DTARGET_I386"
 native_flag_x86_64=3D"-DTARGET_X86_64"
 native_flag_mips=3D"-DTARGET_MIPS"
 native_flag_mips64=3D"-DTARGET_MIPS64"
-native_flag_arm=3D"-DTARGET_ARM"
+native_flag_arm=3D"-DTARGET_ARM -marm"
 native_flag_aarch64=3D"-DTARGET_AARCH64"
=20
 (config_host_mak=3Dcommon-user/native/config-host.mak
modified   include/native/native-func.h
@@ -8,4 +8,25 @@
 #define NATIVE_STRCMP 0x1005
 #define NATIVE_STRCAT 0x1006
=20
+/*
+ * Argument encoding. We only really care about 3 types. The two base
+ * register sizes (32 and 64) and if the value is a pointer (in which
+ * case we need to adjust it g2h before passing to the native
+ * function).
+ */
+#define TYPE_NO_ARG  0x0
+#define TYPE_I32_ARG 0x1
+#define TYPE_I64_ARG 0x2
+#define TYPE_PTR_ARG 0x3
+
+/* Add an alias for the natural register size, it might be easier to
+ * pass this in */
+#if UINTPTR_MAX =3D=3D 0xFFFFFFFF
+  #define TYPE_INT_ARG TYPE_I32_ARG
+#elif UINTPTR_MAX =3D=3D 0xFFFFFFFFFFFFFFFFu
+  #define TYPE_INT_ARG TYPE_I64_ARG
+#else
+  #error TBD pointer size
 #endif
+
+#endif /* __NATIVE_FUNC__ */
modified   common-user/native/libnative.c
@@ -1,5 +1,6 @@
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdint.h>
=20
 #include "native/libnative.h"
 #include "native/native-func.h"
@@ -20,15 +21,27 @@
=20
 #if defined(TARGET_ARM) || defined(TARGET_AARCH64)
=20
-/* unused syscall number */
+/*
+ * HLT is an invalid instruction for userspace and usefully has 16
+ * bits of spare immeadiate data which we can stuff data in.
+ */
+
 #define __PREFIX_INSTR \
-    "svc 0xff;"
+    "hlt 0xffff;"
=20
-#define NATIVE_CALL_EXPR(func) \
-    __PREFIX_INSTR             \
-    ".word " STR(func) ";" : ::
+#define WRAP_NATIVE_CALL(id, types)                          \
+    do {                                                     \
+        __asm__ volatile(                                    \
+            __PREFIX_INSTR "\n\t"                            \
+            "hlt  %c0\n\t"                                   \
+            "hlt  %c1\n\t"                                   \
+            "hlt  0\n\t"                                     \
+            : /* no outputs */                               \
+            : "i" (id), "i" (types)                          \
+            : "memory");                                     \
+    } while (0)
=20
-#endif
+#endif /* TARGET_ARM || TARGET_AARCH64 */
=20
 #if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
=20
@@ -38,28 +51,66 @@
=20
 #endif
=20
+static inline const uint32_t encode_1out_3in(int rtype, int arg1, int arg2=
, int arg3)
+{
+    return (rtype & 0xf) |
+        ((arg1 & 0xf) << 4) |
+        ((arg2 & 0xf) << 8) |
+        ((arg3 & 0xf) << 12);
+}
+
+static inline const uint32_t encode_0out_3in(int arg1, int arg2, int arg3)
+{
+    return encode_1out_3in(TYPE_NO_ARG, arg1, arg2, arg3);
+}
+
+static inline const uint32_t encode_1out_2in(int rtype, int arg1, int arg2)
+{
+    return encode_1out_3in(rtype, arg1, arg2, TYPE_NO_ARG);
+}
+
 void *memcpy(void *dest, const void *src, size_t n)
 {
-    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCPY));
+    const uint32_t args =3D encode_1out_3in(TYPE_PTR_ARG,
+                                          TYPE_PTR_ARG, TYPE_PTR_ARG,
+                                          TYPE_INT_ARG);
+    WRAP_NATIVE_CALL(NATIVE_MEMCPY, args);
 }
=20
 int memcmp(const void *s1, const void *s2, size_t n)
 {
-    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCMP));
+    const uint32_t args =3D encode_1out_3in(TYPE_INT_ARG,
+                                          TYPE_PTR_ARG, TYPE_PTR_ARG,
+                                          TYPE_INT_ARG);
+    WRAP_NATIVE_CALL(NATIVE_MEMCMP, args);
 }
+
 void *memset(void *s, int c, size_t n)
 {
-    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMSET));
+    const uint32_t args =3D encode_1out_3in(TYPE_PTR_ARG,
+                                          TYPE_PTR_ARG,
+                                          TYPE_INT_ARG,
+                                          TYPE_INT_ARG);
+    WRAP_NATIVE_CALL(NATIVE_MEMSET, args);
 }
 char *strcpy(char *dest, const char *src)
 {
-    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCPY));
+    const uint32_t args =3D encode_1out_2in(TYPE_PTR_ARG,
+                                          TYPE_PTR_ARG,
+                                          TYPE_PTR_ARG);
+    WRAP_NATIVE_CALL(NATIVE_STRCPY, args);
 }
 int strcmp(const char *s1, const char *s2)
 {
-    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCMP));
+    const uint32_t args =3D encode_1out_2in(TYPE_INT_ARG,
+                                          TYPE_PTR_ARG,
+                                          TYPE_PTR_ARG);
+    WRAP_NATIVE_CALL(NATIVE_STRCMP, args);
 }
 char *strcat(char *dest, const char *src)
 {
-    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCAT));
+    const uint32_t args =3D encode_1out_2in(TYPE_PTR_ARG,
+                                          TYPE_PTR_ARG,
+                                          TYPE_PTR_ARG);
+    WRAP_NATIVE_CALL(NATIVE_STRCAT, args);
 }

--8<---------------cut here---------------end--------------->8---

It would be nice if we could pass the string of the function name as
well but I wasn't able to find the best way to get the address of the
string into the inline assembler. However that could be added later if
we want to make the interface even more generic.



> +
> +#endif
> +
> +#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
> +
> +/* unused bytes in syscall instructions */
> +#define NATIVE_CALL_EXPR(func) \
> +    ".long " STR((0x1 << 24) + (func << 8) + 0xC) ";" : ::
> +
> +#endif
> +
> +void *memcpy(void *dest, const void *src, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCPY));
> +}
> +
> +int memcmp(const void *s1, const void *s2, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCMP));
> +}
> +void *memset(void *s, int c, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMSET));
> +}
> +char *strcpy(char *dest, const char *src)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCPY));
> +}
> +int strcmp(const char *s1, const char *s2)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCMP));
> +}
> +char *strcat(char *dest, const char *src)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCAT));
> +}
> diff --git a/include/native/libnative.h b/include/native/libnative.h
> new file mode 100644
> index 0000000000..d3c24f89f4
> --- /dev/null
> +++ b/include/native/libnative.h
> @@ -0,0 +1,11 @@
> +#ifndef __LIBNATIVE_H__
> +#define __LIBNATIVE_H__
> +
> +void *memcpy(void *dest, const void *src, size_t n);
> +int memcmp(const void *s1, const void *s2, size_t n);
> +void *memset(void *s, int c, size_t n);
> +char *strcpy(char *dest, const char *src);
> +int strcmp(const char *s1, const char *s2);
> +char *strcat(char *dest, const char *src);
> +
> +#endif /* __LIBNATIVE_H__ */
> diff --git a/include/native/native-func.h b/include/native/native-func.h
> new file mode 100644
> index 0000000000..d48a8e547a
> --- /dev/null
> +++ b/include/native/native-func.h
> @@ -0,0 +1,11 @@
> +#ifndef __NATIVE_FUNC_H__
> +#define __NATIVE_FUNC_H__
> +
> +#define NATIVE_MEMCPY 0x1001
> +#define NATIVE_MEMCMP 0x1002
> +#define NATIVE_MEMSET 0x1003
> +#define NATIVE_STRCPY 0x1004
> +#define NATIVE_STRCMP 0x1005
> +#define NATIVE_STRCAT 0x1006
> +
> +#endif


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

