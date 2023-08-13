Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7977AAF6
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:47:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzU-0007jn-0s; Sun, 13 Aug 2023 15:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzS-0007j9-1v
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzQ-0002Ly-GK
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so32836955e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955783; x=1692560583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wf2Tilhe91EY1UAFxJ7h27O9Jy4Z0F8evRl+LBgLLVg=;
 b=NNsJPjj6gdiE9AY9Ov/JoS7/Hs8GeNYSor4fQT2unef8qpKwqxwhHLl4VjJmHIB060
 jK1Qe0obXzHXBKgg841QZDh7OOCtapYvYFsra38n0rRRYP57L2AfhI1C7bblfKHCILtI
 BQyFzekV/NbACeHdI2ro6wTOtBCFhafZtbSb9FwHvMk2yotlguB9I3e5/r1AF96gGsSe
 iRPT3XzXRHn0vE8v9OrefQOMqDw9rmu9dX2LfmWzMMWSnrgXBEfjyuoNvh11hYsOdqXf
 IjoGT8YsgB7rOE1e9Nvh2eCBExjob36qdPe0BmhNXifCDBonnetDEImHzlP6geoAvgBJ
 QmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955783; x=1692560583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wf2Tilhe91EY1UAFxJ7h27O9Jy4Z0F8evRl+LBgLLVg=;
 b=gwKWko5mtQtj3/sv8m+B0EcVEY/+YoBhODGVmHNmTQV+jXnlQuldUJHgmqtW6LCyo/
 14LIHHliawTlbtyx60vvN7MPJ4D6Sw03MqI1dCcc6kUdtWwyrrqygkjIuygqcePJBQLG
 g0ZKNakYi+BRVm8Zcn69OCHENnyxO4I+zJezxo3Wt+p8UzLZCnIGZOUAYxu4fND0AlKC
 I5z6MaMTEC1ZvnVXj5cuArlYne87eGs8Q0SZFSqHsqtnjtl1c6CvO76yjMMDHdsACBT/
 MVsbuvDXzqyq6GDmvO+otgncf+9qe7GECJZky71TNsM5nqk4lxoCFxR2EOAGdMQY8ATu
 736A==
X-Gm-Message-State: AOJu0YxQI/McC40RoOJIhpTfdmUYE5KoFNSvsGvWv6e1iVaTeiLdNcwq
 VkDYjOxTO+cgaqGmPYhhlE00NKnfOFA=
X-Google-Smtp-Source: AGHT+IFInV8UhjWI+ZflgrLcCsBVQM+KlNAGX3zAvLCgJ0jeErryAQuyUv4rW7uP2Cqb7+ye8jb1Eg==
X-Received: by 2002:a7b:c44f:0:b0:3fb:abd0:2b52 with SMTP id
 l15-20020a7bc44f000000b003fbabd02b52mr6218222wmi.13.1691955782772; 
 Sun, 13 Aug 2023 12:43:02 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:02 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 02/32] Disable clang warnings
Date: Sun, 13 Aug 2023 10:41:23 +0200
Message-Id: <20230813084153.6510-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Implement PRAGMA_DISABLE_PACKED_WARNING and PRAGMA_REENABLE_PACKED_WARNING macros in include/qemu/compiler.h.

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index a309f90c76..b037442518 100644
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
2.40.0


