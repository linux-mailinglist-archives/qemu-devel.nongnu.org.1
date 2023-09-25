Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF897ADFB8
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:43:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrSI-0002h1-Jz; Mon, 25 Sep 2023 15:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSG-0002es-C9
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:16 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSC-0004lF-N5
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 53C9E63731;
 Mon, 25 Sep 2023 22:41:07 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6422::1:2a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id geUBjG0OhCg0-7T42CIWK; Mon, 25 Sep 2023 22:41:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695670866;
 bh=IrCX98+BsHKhBATyxoue5K4vzQ6/d4/0Hs7S3KTK9FM=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WGZW/wygsfeliGPn25AjtNhNIVpXVOgTDqbham4jhZvUohndryQ3Mo7d+FWvKs90C
 fHPKXf2l96/0s9JemCWZeDqCPdNLuf4TeibA+w8ZFbMcO2f+IEvQ8tGCpMaeEJh8K+
 PQNeaDWqJAqikwackXCjLrLOH+v6L4YTiXUWH5Pg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 01/12] hw/core/loader: load_at(): check size
Date: Mon, 25 Sep 2023 22:40:29 +0300
Message-Id: <20230925194040.68592-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925194040.68592-1-vsementsov@yandex-team.ru>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This @size parameter often comes from fd. We'd better check it before
doing read and allocation.

Chose 1G as high enough empiric bound.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/core/loader.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4dd5a71fb7..4b67543046 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -281,11 +281,26 @@ ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
 
 /* ELF loader */
 
+#define ELF_LOAD_MAX (1024 * 1024 * 1024)
+
 static void *load_at(int fd, off_t offset, size_t size)
 {
     void *ptr;
-    if (lseek(fd, offset, SEEK_SET) < 0)
+
+    /*
+     * We often come here with @size, which was previously read from file
+     * descriptor too. That's not good to read and allocate for unchecked
+     * number of bytes. Coverity also doesn't like it and generate problems.
+     * So, let's limit all load_at() calls to ELF_LOAD_MAX at least.
+     */
+    if (size > ELF_LOAD_MAX) {
         return NULL;
+    }
+
+    if (lseek(fd, offset, SEEK_SET) < 0) {
+        return NULL;
+    }
+
     ptr = g_malloc(size);
     if (read(fd, ptr, size) != size) {
         g_free(ptr);
-- 
2.34.1


