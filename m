Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD2777AAED
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:45:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzS-0007j8-FL; Sun, 13 Aug 2023 15:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzQ-0007iu-QB
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzP-0002Lq-7L
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so32836815e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955782; x=1692560582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BL3xjDJvjzEgMaYToYQ6Bx56p2LIHs2TtBVlnMHlDaw=;
 b=odi+VaeB8kAtJ5pY4QLftDxfnC2b7jaGIwaE302In1e8peVQTfcdAbZGOAfWuP2/GI
 nwIcKPaiUtSYhThzDaZZ0+O2+ZbZ4XdRrHEcek2Wvu8IZWpR0g2mj7FaaQ86q88mmcXb
 +zRPupamWyG24vXpuO76pleSpSbzECGllH3MrIZk7XNxsBBFhLOlDecEekuV1Hu5mjnY
 A4fQNhNJm7H7kRythn3URaryTyunPCwFrp6OdY8fYS3mlQ1+3S/Jvc09EYQC0DwsKtQP
 f7aVGki8JQwz8Fz033ho/vDRTDhAFXD5LzZzzCVTssDeaD838THoV/C9yJBIVE02FjUa
 nZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955782; x=1692560582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BL3xjDJvjzEgMaYToYQ6Bx56p2LIHs2TtBVlnMHlDaw=;
 b=AcEcb5O+WGlibN6w0bH94ttWJHY0E8oTGEizVwOfX5InRl0JgzoA6ayWJEEVBUp8GJ
 foeMgV5v8TOLGjW9koKEW9xgEEU6pz4If+7aIUJWxK3ZbT/VeVs9hml9RoKdIO7k3VPn
 e+GsF6O4I9lokivVAHp9CNUy2n/nT16TTpIwPKKG+se24fIOTFoiviiEL6o6yrezC0w1
 2UM7KYCcPFw7RoPUlEX3CUtCGC+bwbvG38Ii+25iH1/PvdUT2k8zYmln3b8/ESvlsr9a
 YhXAmnCri9xrWjvmAsxUaH95mWhADA5U9oAGtf1Ab9aAmGHXMAyqAijdkBnHtNkfO3xW
 gXig==
X-Gm-Message-State: AOJu0YxfoeutE+Ecc11BD+Q9wzKH1hlRuoEHQ0rIL3vsEGua5wALY4MZ
 jKvtDV86SjwFgGy2v39b9smjSnDihxU=
X-Google-Smtp-Source: AGHT+IHcfAMlVbsBfQhIdSIvlN04vhUOIcFfabHbBrG+MW4goPEtwcbGFSQnGRJw1l53PgYOhoRZsA==
X-Received: by 2002:a05:600c:b44:b0:3fe:6199:9393 with SMTP id
 k4-20020a05600c0b4400b003fe61999393mr6226040wmr.27.1691955781635; 
 Sun, 13 Aug 2023 12:43:01 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:01 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 01/32] Move _WANT_FREEBSD macros to include/qemu/osdep.h
Date: Sun, 13 Aug 2023 10:41:22 +0200
Message-Id: <20230813084153.6510-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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

From: Warner Losh <imp@bsdimp.com>

move _WANT_FREEBSD macros from bsd-user/freebsd/os-syscall.c to
include/qemu/osdep.h in order to pull some struct defintions needed
later in the build.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-syscall.c | 11 -----------
 include/qemu/osdep.h          | 13 +++++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index de36c4b71c..2224a280ea 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -17,17 +17,6 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
-
-/*
- * We need the FreeBSD "legacy" definitions. Rust needs the FreeBSD 11 system
- * calls since it doesn't use libc at all, so we have to emulate that despite
- * FreeBSD 11 being EOL'd.
- */
-#define _WANT_FREEBSD11_STAT
-#define _WANT_FREEBSD11_STATFS
-#define _WANT_FREEBSD11_DIRENT
-#define _WANT_KERNEL_ERRNO
-#define _WANT_SEMUN
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/path.h"
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cc61b00ba9..1ca94ad3de 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -88,6 +88,19 @@ QEMU_EXTERN_C int daemon(int, int);
 #define __USE_MINGW_ANSI_STDIO 1
 #endif
 
+/*
+ * We need the FreeBSD "legacy" definitions. Rust needs the FreeBSD 11 system
+ * calls since it doesn't use libc at all, so we have to emulate that despite
+ * FreeBSD 11 being EOL'd.
+ */
+#ifdef __FreeBSD__
+#define _WANT_FREEBSD11_STAT
+#define _WANT_FREEBSD11_STATFS
+#define _WANT_FREEBSD11_DIRENT
+#define _WANT_KERNEL_ERRNO
+#define _WANT_SEMUN
+#endif
+
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdbool.h>
-- 
2.40.0


