Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A537740C5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:10:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDU-0001pj-IP; Tue, 08 Aug 2023 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDI-0001Hz-Oq
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDG-0003Cz-62
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe5eb84d43so17442065e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514580; x=1692119380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNZTycRhT1z+dhPCDuZivfVDPfYQWNMB+t8hhmuprEQ=;
 b=JFfBCZ2N+9pEOm2YShc9wq70os/owS1Sz2ZYuDwcno49NYtdhVueSbxNX5V7ezPPX9
 D5IgEBUXmy/ek1244ZyXxGPW4nYGmMfe3uEA0PwlkDma7Sso2pDGUX/R5OmzVPPo0n0Q
 byXEybK+noQCCmN6XoLETELMlyDiqrIzWepNgHpjuLaO44q0mNxkkAW3SwGrJ5VnVGGk
 ImKsoUy3EKiMFE/fiuG7yigOh/j17h/bwIb5DTOC3857+WAT09H0RSesfXOVh6O4MxvP
 xAXyp5MOjWrh37K9sErcI708sYVe9/bvAYpuMiJYmn8qFpQMgtu2pXSyXJzjD/SCrUmb
 KYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514580; x=1692119380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNZTycRhT1z+dhPCDuZivfVDPfYQWNMB+t8hhmuprEQ=;
 b=TKcWZsNS479YIHEJBudYWtPvaIbSe6XZZp4P2+4hQmnkqPPuVSf4upMGL1YZ6GLxz+
 1OvyDr/irIq3FvQ6T/D5WCReNwIyp5wpRSPwpu4AKb9mzaWsPSEdgFZSv+Gv4kPDSyyr
 LKmpP+CfKrZ6+HniLgcH7i4VS00A9fR2K0GkEjbSUBHabEYZWqScrrlbVmZAxmnS7UDh
 BmTxdOkl2WaMXP+ZMkstY1zy4zKdlUYkeCrYaZIWRUHRiBr9vy1S2Fwlf35T+TPFqgCd
 5HoI2ztuVFDEar7G6kJuLX92gjmChW1bj2hJTqyNUsuFBHnB1VN+DNUYOMfeLSP7SRp+
 tPsg==
X-Gm-Message-State: AOJu0YzACJ41ko9tyzQKRTBt+Z6MYgof2izir4tHDpAZzfqMNSVqOhbn
 xHNFQKGnACrNeEjInKmdtUpOjLsBCeu4+Q==
X-Google-Smtp-Source: AGHT+IFM7AjUdHGKAl6INKYfPWV1qaPijwOLdEADoDQk3CMqq6/E/yyvu9qOfw/mbWvxva7EkFc7yg==
X-Received: by 2002:a5d:45d1:0:b0:317:f4c2:a99c with SMTP id
 b17-20020a5d45d1000000b00317f4c2a99cmr60803wrs.32.1691514579716; 
 Tue, 08 Aug 2023 10:09:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:39 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 01/33] Move _WANT_FREEBSD macros to include/qemu/osdep.h
Date: Tue,  8 Aug 2023 08:07:43 +0200
Message-Id: <20230808060815.9001-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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


