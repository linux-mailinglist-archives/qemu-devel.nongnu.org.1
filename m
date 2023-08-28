Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9B778BBBC
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrn-0003ha-QL; Mon, 28 Aug 2023 19:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrf-0003fD-W6
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:48 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrc-0006gC-36
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:47 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso143408639f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266102; x=1693870902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPIB6HdkWJYoYxy/vDMHclCeIpDJl74Je8/wClovGdA=;
 b=J1xPAnZtbivMxziqLnNbrjl140bVNANmqOdWpJT0PrXCfq2C2Bf9RqyoHlBjiCaP3M
 FCk0JDTHEvnMtsmpIkBqKTVEQX04vXmgg4TApHALdSNcbuSeIP4zLpG2P99XjlfrmGtc
 DfbcHPXJN0L9s2bVIZRR+tDsW7EtHbvkmM31mlAnNhx4N1k+22vF/iaGC3Q+q3a1OKJH
 rxQiSHAVbFqcJOV8amJ3dIwUDvPAMUj6QH2T9MzCOnBws86WiqETvJcB3nEvB+MTfoqz
 P3r0JYG29SZRV4frkZ8GDTulsIYn8Jcp0QI0aPZcmqy0QC6v+LW9rhbsIcY/7UxXaKQu
 a1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266102; x=1693870902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPIB6HdkWJYoYxy/vDMHclCeIpDJl74Je8/wClovGdA=;
 b=asTMnVgkn2QpwY5X6iBM6kkmOX2u86g71BMRAzocWGt8aiUJ1zFQL6A9GrruL4TVnB
 Q1S/43OGZLmeoWFEG1WSrAICl5sFM1sC/nBv92ZtVMU1VxeTihDDw+WrwcQcyvHtOZMf
 9bq83aG1GPBl20f4k5u8RxY1j19CQut88SjfyhpqlHY1cxSHOHAodAytrc7OeUVbQ4li
 6iKo9nl3it0EUVOEN8JDctUYx33ri9OeziIKcOqQpiDWk0PRt2JvIbp6r+rqjZO6Hoc0
 cRHLZyZgtuWT2hFVn2nwcADMX8XMZHvR2yFJb079LzHTCrYUzazxHUN2gwS71IsK8nWN
 yg5g==
X-Gm-Message-State: AOJu0YzR9+rE2n+bj/eue8ee0+5qOBAojA2C0uTg9mgx9NM4z9tcjO1c
 nXausLOYJ9G3YTxboA3qOx40v00cGQCWh2VrjWU=
X-Google-Smtp-Source: AGHT+IF0OBd/VZ6gkWjjjd0jB0Zy6wuL36Lmb0VNx/KdQtD4eybWFaQhWerKuRF9dBpEwDCV0gSnbg==
X-Received: by 2002:a05:6e02:12e2:b0:34c:ecc8:98e0 with SMTP id
 l2-20020a056e0212e200b0034cecc898e0mr7655968iln.11.1693266102343; 
 Mon, 28 Aug 2023 16:41:42 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/36] bsd-user: Move _WANT_FREEBSD macros to
 include/qemu/osdep.h
Date: Mon, 28 Aug 2023 17:37:49 -0600
Message-ID: <20230828233821.43074-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2c.google.com
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
index de36c4b71c6..2224a280ea2 100644
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
index 21ef8f16995..2cae135280c 100644
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
2.41.0


