Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACBE77A6C8
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpI-00080w-Gu; Sun, 13 Aug 2023 10:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpG-00080K-IJ
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpE-0000mo-RZ
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe1d9a8ec6so25736335e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935931; x=1692540731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wf2Tilhe91EY1UAFxJ7h27O9Jy4Z0F8evRl+LBgLLVg=;
 b=r1JhGTBwQdla0PGsWZJRNFe7VzkaFNjikGDVNaukocXg2QiSv1cK9QC3yZFnfzs8Qx
 +kO5AjkeLGiedmdyhZV0v4PqxxxGf4026nZFckY4y/7/5MgX02JSJvO1oFSbB8OuBlV9
 2jjN9ip6A+/KyCOULEtRlDaxlHAyrj6fD+mlR2hxwFiuAw9MIxJn18ucKmM/Z3DWaV31
 ZZqyOCT84PNFHSM+y8SxAIxqbAT7fpctrcUzPFffCOYfxNPnQo0u+ULxkms5IU78zzBa
 KavmoATalBe6S5ArvGHASkY9xZgezdBplD9ntv2p5mHFxcaxxV04iM27zdYy7vKMFstU
 y8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935931; x=1692540731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wf2Tilhe91EY1UAFxJ7h27O9Jy4Z0F8evRl+LBgLLVg=;
 b=jpHR1zD82PJjyHv4LyaJ5l3+//tNO5jGJWwA4bsKTPJGRTBsk1NyW9OzqOmgPlsmL0
 Lp949HCW6ceOpXH8dxY45TF6l2n+hhDy4/ZDIaWgDnznH7JtWzhteXdrO4Hijl9UlFGh
 JxclVXimdLh2snqLMbe/eHSLzr5K4nmdAE9EvEeJ3uJGBOgZUziCQURxl5U4cfWSHTJ7
 u54pP0QhHzXpFwB3vVXAuZz/JRVhWtdxhTi3ZpIgSf2x7dEzS10MppGB0feJ3J25egQt
 04rXSrHBW+kMNmDl/uVEt1BuhPWSqjm8M5ewO6gHjRc6IC88gVf+xJwm5VfavEwqSGy4
 etpw==
X-Gm-Message-State: AOJu0YwEa9UZZieJbFTOStn/e5obzb4WuRVlvcC2Yfj+uh7rsZQF8Emx
 RrIvwQIVeT2JRIfpW1lsbl7xSXBga2Y=
X-Google-Smtp-Source: AGHT+IEoW0F4FQwwBySB/g0lD5i6MptHVDMB+qqu7NFPadOLnsx541F+yUSfKn/xCHELE3MfJpzkiA==
X-Received: by 2002:a5d:5608:0:b0:317:6855:dc24 with SMTP id
 l8-20020a5d5608000000b003176855dc24mr7985797wrv.21.1691935930871; 
 Sun, 13 Aug 2023 07:12:10 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:10 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 02/32] Disable clang warnings
Date: Sun, 13 Aug 2023 05:09:43 +0200
Message-Id: <20230813031013.1743-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
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


