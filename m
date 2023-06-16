Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA77334C5
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABMu-0004My-6B; Fri, 16 Jun 2023 11:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qABMr-0004MD-4l
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:05 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qABMo-0000eS-By
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:04 -0400
X-QQ-mid: bizesmtp84t1686929264tzo7kg5l
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 16 Jun 2023 23:27:43 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: iDzLjIm7mlbJhIxtyny+gy+H2geVvwX+VOUwjvgXXU1PuSf5oCk1Ncw+g9l2c
 Sy0LE1XOfvNLm8ZwCsA0UZ2aFXPaCitEw9PcUZH3rIgGUwmIuME81mIHFjx1UA8XT1n6zAn
 dqD5xxVrd03AMmUSyODRpDzMQR37SvI7GOfZ4wqC666cvvIL97IzjoSfAji6zKWwvCWUnH3
 wwR33Cq/TDmOwJ5t4BoDsJ4GKgoa0y36hm12RY8IyHILPIRuIJAskZXuven0vsJMxCIuKaD
 ZIChjNhWan1CFk+vragxOwnZMJqdbndeTUKqbH8G09LFq4KhbMofK+OxKqyaUm8vd8SwQqd
 UL14Z/0lIjwSMKbF1NPHCuUMes1O4T5CnSB3lv1v2FRCaylIDY=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 640512983429797124
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 1/6] tests/tcg/cris: Fix the coding style
Date: Fri, 16 Jun 2023 23:27:32 +0800
Message-Id: <20230616152737.23545-2-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616152737.23545-1-bmeng@tinylab.org>
References: <20230616152737.23545-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.155.67.158; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The code style does not conform with QEMU's. Correct it so that the
upcoming commit does not trigger checkpatch warnings.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 tests/tcg/cris/libc/check_openpf5.c | 57 ++++++++++++++---------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/tests/tcg/cris/libc/check_openpf5.c b/tests/tcg/cris/libc/check_openpf5.c
index 1f86ea283d..0037fbca4c 100644
--- a/tests/tcg/cris/libc/check_openpf5.c
+++ b/tests/tcg/cris/libc/check_openpf5.c
@@ -13,44 +13,41 @@
 #include <fcntl.h>
 #include <string.h>
 
-int main (int argc, char *argv[])
+int main(int argc, char *argv[])
 {
-  int i;
-  int filemax;
+    int i;
+    int filemax;
 
 #ifdef OPEN_MAX
-  filemax = OPEN_MAX;
+    filemax = OPEN_MAX;
 #else
-  filemax = sysconf (_SC_OPEN_MAX);
+    filemax = sysconf(_SC_OPEN_MAX);
 #endif
 
-  char *fn = malloc (strlen (argv[0]) + 2);
-  if (fn == NULL)
-    abort ();
-  strcpy (fn, "/");
-  strcat (fn, argv[0]);
+    char *fn = malloc(strlen(argv[0]) + 2);
+    if (fn == NULL) {
+        abort();
+    }
+    strcpy(fn, "/");
+    strcat(fn, argv[0]);
 
-  for (i = 0; i < filemax + 1; i++)
-    {
-      if (open (fn, O_RDONLY) < 0)
-	{
-	  /* Shouldn't happen too early.  */
-	  if (i < filemax - 3 - 1)
-	    {
-	      fprintf (stderr, "i: %d\n", i);
-	      abort ();
-	    }
-	  if (errno != EMFILE)
-	    {
-	      perror ("open");
-	      abort ();
-	    }
-	  goto ok;
-	}
+    for (i = 0; i < filemax + 1; i++) {
+        if (open(fn, O_RDONLY) < 0) {
+            /* Shouldn't happen too early.  */
+            if (i < filemax - 3 - 1) {
+                fprintf(stderr, "i: %d\n", i);
+                abort();
+            }
+            if (errno != EMFILE) {
+                perror("open");
+                abort();
+            }
+        goto ok;
+        }
     }
-  abort ();
+    abort();
 
 ok:
-  printf ("pass\n");
-  exit (0);
+    printf("pass\n");
+    exit(0);
 }
-- 
2.34.1


