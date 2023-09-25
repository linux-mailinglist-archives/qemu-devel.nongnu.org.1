Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8407ADFAF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrSM-0002jW-Kk; Mon, 25 Sep 2023 15:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSJ-0002he-9g
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:19 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSH-0004o7-M7
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 5996B60196;
 Mon, 25 Sep 2023 22:41:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6422::1:2a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id geUBjG0OhCg0-XrxFpo6z; Mon, 25 Sep 2023 22:41:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695670875;
 bh=xFkYfoa8y8fALQ7GpWsKjC977uIrpJDrmNygB6lM1io=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=iowMtKug7yHxfkWWoMYC3jtRiT8buFdE5Bq6Aen/2Wwd/sLMZnye9taslCeOAbYiN
 NNP3ZryE4aekflLbtZ8yH7BuMfYj8W7kxv/ZiL0iuRQUP93hTa75Vdt34MbJlbTwWi
 4+LH0P2D0i5bXbylvBzz1B3Wr4+qjUy22CTHsIVI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 11/12] hw/core/loader: read_targphys(): add upper bound
Date: Mon, 25 Sep 2023 22:40:39 +0300
Message-Id: <20230925194040.68592-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925194040.68592-1-vsementsov@yandex-team.ru>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coverity doesn't like using "untrusted" values, coming from buffers and
fd-s as length to do IO and allocations. And that's make sense. The
function is used three times with "untrusted" nbytes parameter. Let's
introduce at least empirical limit of 1G for it.

While being here make the function static, as it's used only here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/core/loader.c    | 13 ++++++++++---
 include/hw/loader.h |  2 --
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index aa02b27089..48cff6f59e 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -101,17 +101,24 @@ ssize_t load_image_size(const char *filename, void *addr, size_t size)
     return actsize < 0 ? -1 : l;
 }
 
+#define READ_TARGPHYS_MAX_BYTES (1024 * 1024 * 1024)
 /* read()-like version */
-ssize_t read_targphys(const char *name,
-                      int fd, hwaddr dst_addr, size_t nbytes)
+static ssize_t read_targphys(const char *name,
+                             int fd, hwaddr dst_addr, size_t nbytes)
 {
     uint8_t *buf;
     ssize_t did;
 
+    if (nbytes > READ_TARGPHYS_MAX_BYTES) {
+        return -1;
+    }
+
     buf = g_malloc(nbytes);
     did = read(fd, buf, nbytes);
-    if (did > 0)
+    if (did > 0) {
         rom_add_blob_fixed("read", buf, did, dst_addr);
+    }
+
     g_free(buf);
     return did;
 }
diff --git a/include/hw/loader.h b/include/hw/loader.h
index c4c14170ea..e29af233d2 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -264,8 +264,6 @@ ssize_t load_ramdisk(const char *filename, hwaddr addr, uint64_t max_sz);
 
 ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src, size_t srclen);
 
-ssize_t read_targphys(const char *name,
-                      int fd, hwaddr dst_addr, size_t nbytes);
 void pstrcpy_targphys(const char *name,
                       hwaddr dest, int buf_size,
                       const char *source);
-- 
2.34.1


