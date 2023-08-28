Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E2078BBA5
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrm-0003gk-Vb; Mon, 28 Aug 2023 19:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrg-0003fE-05
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:48 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrc-0006gH-Vt
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:47 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34bb72ffb1fso13414845ab.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266103; x=1693870903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nM7Uf06w0wMTd6N1re2AAxx7TTOheoegcX2ZAbmHQ9U=;
 b=cxqRz7OTUKEN9CO5n0/7oJAnFZnB+zzx+AZeD3Fjs6pufaFKwsN1rKS+YhxFXnk0nH
 qv3pw8lSd+o7262cnKQh+fAQaRh+eOFS0GRtesS8dTmlFzNh2n3mvqHlM4KKm45lhXM2
 YlZlnt3ihBqwjzm/gqGtBFfjfCWDzA3LIZezr00Pxny9y5Ldx22Oqhei/7kfjdOEcCGl
 GhR8mVTYj9SsSNW0nHoiMSK0Wu5I2J5P3V0OrG/Wl3AFkTlm2A4y1IlP4KSl+ZelBypV
 9owbdGOvwwKqicuH5cye2XsLgBmSC10ZclH9oi3anj7r9lLgDWGt9/i/+rEXQQXfBAOQ
 AB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266103; x=1693870903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nM7Uf06w0wMTd6N1re2AAxx7TTOheoegcX2ZAbmHQ9U=;
 b=e1OC+im5exDXqKDNoLyF9MpMD6DW+vRE3pnJ3b91kLVS3RQDnaqunjF6cuPSQc+fkb
 /EBxNRmyLVWMF7n7yjT89JghH0sRiv1C5sI1eKRs0pGPJ4pPr9I6u4F7yPvc+5DTXY8w
 skqZb4EEl36llMDQFE/TadDbs+bequPJWlLgQnsJHoStLth2ORt5svkTXbL/dXCV4Mb6
 mG+jV4XuPbT3jqHk7zQ4A/aLVjeOoyqEyzcxJlMNKckaWR8bC3cLE1DiihUouvSkq/pX
 YCK6OFTouKxqtYKsF/BMjzcsY9MrqUEfwGhFQKL6VLFNuDoGele/2eG8vjFlkBHz2BtG
 7/iA==
X-Gm-Message-State: AOJu0Yxe3ZYI8+oeb3+KohvIk2h22jckv42pO32feKJyn5fOBIJrd6Rh
 fLi1la0FPx0oXD2y9P8k0WmPI2Ak3OLpWnp05Gg=
X-Google-Smtp-Source: AGHT+IGaSMX4ldnm7pyU+qmMdi1DyJwNLjPcXxUBvOq8xNvthRoS+ZKdUBd77ojjowxinwwJK8PJIg==
X-Received: by 2002:a05:6e02:1d96:b0:348:dba4:6418 with SMTP id
 h22-20020a056e021d9600b00348dba46418mr20913100ila.6.1693266103606; 
 Mon, 28 Aug 2023 16:41:43 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/36] bsd-user: Disable clang warnings
Date: Mon, 28 Aug 2023 17:37:50 -0600
Message-ID: <20230828233821.43074-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::134;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x134.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Implement PRAGMA_DISABLE_PACKED_WARNING and
PRAGMA_REENABLE_PACKED_WARNING macros in include/qemu/compiler.h.

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 include/qemu/compiler.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index a309f90c768..b0374425180 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -22,6 +22,36 @@
 #define QEMU_EXTERN_C extern
 #endif
 
+/*
+ * Tricky points:
+ * - Use __builtin_choose_expr to avoid type promotion from ?:,
+ * - Invalid sizes result in a compile time error stemming from
+ *   the fact that abort has no parameters.
+ * - It's easier to use the endian-specific unaligned load/store
+ *   functions than host-endian unaligned load/store plus tswapN.
+ * - The pragmas are necessary only to silence a clang false-positive
+ *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
+ * - We have to disable -Wpragmas warnings to avoid a complaint about
+ *   an unknown warning type from older compilers that don't know about
+ *   -Waddress-of-packed-member.
+ * - gcc has bugs in its _Pragma() support in some versions, eg
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
+ *   include the warning-suppression pragmas for clang
+ */
+#ifdef __clang__
+#define PRAGMA_DISABLE_PACKED_WARNING                                   \
+    _Pragma("GCC diagnostic push");                                     \
+    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
+    _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
+
+#define PRAGMA_REENABLE_PACKED_WARNING          \
+    _Pragma("GCC diagnostic pop")
+
+#else
+#define PRAGMA_DISABLE_PACKED_WARNING
+#define PRAGMA_REENABLE_PACKED_WARNING
+#endif
+
 #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define QEMU_PACKED __attribute__((gcc_struct, packed))
 #else
-- 
2.41.0


