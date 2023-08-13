Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9479677A6BA
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpH-00080Y-81; Sun, 13 Aug 2023 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpF-0007zu-BL
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpD-0000mh-Bk
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-318015ade49so3234390f8f.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935929; x=1692540729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BL3xjDJvjzEgMaYToYQ6Bx56p2LIHs2TtBVlnMHlDaw=;
 b=OGMIl44FYsUlcHjbeu7cfznZbvmKT5d6jXpQEltrhvfGt+Pw8DWvmejNq1WFiS5tcO
 JdJvPa31uBHDqRFN09In+RF5eUF0CbHCKplurKmw6t4kSBGZYEPafoaVn1gqLoKw1kLf
 oFm0l39WCytBNPmTDbHl7l9uty1SuUPad49FDceNwOOVJUYLgxXQE2J4XE2nla/d/ixG
 3qnBNi24pBnPwS0EamterCEQvHrKvSgUS4c9ZD/m5Z8+KclE5kDB6cqfF6veihEYiLZ9
 XVWii9xwJoofHzbaADG9Y7/R2+HtmdX1/5yFblWxZixKKHXcZeXd2tphFI3dxjWn5LLp
 gNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935929; x=1692540729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BL3xjDJvjzEgMaYToYQ6Bx56p2LIHs2TtBVlnMHlDaw=;
 b=iGuYFC8cof5IMbKDeY5OpsgI5voS6XeLdkNYR950Ab3VvxjeojByKUpDEcCQmq4MZf
 MSjnD1pN0dcnts9AWMYaKXnsY7ImLW+FCpVu0Wwf1yMJik95Z2mZ2QBkiKnMcqDRzRSv
 KdFL6C/6Rn9aunne0K0TgpQ0PwG/8PXj6U9G/woJ02v/1XI7snecayB+009uexYhEIU9
 ikaIyUllilfXeRyvZ7Gy8eyf0Yq8BWYbFXUW12yWsmWIRi1iLBkB+qGZLu9oGONdMXWZ
 Pg13FNtmlyE7FfdUrVHXx5b4ngssRgdMboW2MCiAv5XgVwJscgcrWVBMUnvypg7jPuRd
 8w5g==
X-Gm-Message-State: AOJu0YzHAFN/NqaGFjxjugBnHp/3RibomxLtzLrfRge0/cYMbdx+98sp
 Am2bic+be3+Sp21m0EPjSWBbkujwj8U=
X-Google-Smtp-Source: AGHT+IFLzafRNGkwyVjblyp6UlDWeWNjOj1sxzamPt0DHR6yIeQo/7ms37aP8fdq+v2GG+GW9UeuyA==
X-Received: by 2002:a5d:40ce:0:b0:30e:19a8:4b0a with SMTP id
 b14-20020a5d40ce000000b0030e19a84b0amr5327511wrq.2.1691935929470; 
 Sun, 13 Aug 2023 07:12:09 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:09 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 01/32] Move _WANT_FREEBSD macros to include/qemu/osdep.h
Date: Sun, 13 Aug 2023 05:09:42 +0200
Message-Id: <20230813031013.1743-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42e.google.com
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


