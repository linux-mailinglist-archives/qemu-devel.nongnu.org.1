Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34A4771EFD
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 12:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSxvH-000093-RY; Mon, 07 Aug 2023 06:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSxvB-00004r-QA; Mon, 07 Aug 2023 06:57:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSxvA-0001zg-5u; Mon, 07 Aug 2023 06:57:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D92D18A4A;
 Mon,  7 Aug 2023 13:57:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0ECCC1BFA5;
 Mon,  7 Aug 2023 13:57:00 +0300 (MSK)
Received: (nullmailer pid 206310 invoked by uid 1000);
 Mon, 07 Aug 2023 10:56:59 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Luca Bonissi <qemu@bonslack.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial for-8.1 3/3] Fixed incorrect LLONG alignment for
 openrisc and cris
Date: Mon,  7 Aug 2023 13:56:51 +0300
Message-Id: <6ee960823da8fd780ae9912c4327b7e85e80d846.1691405748.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691405748.git.mjt@tls.msk.ru>
References: <cover.1691405748.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Luca Bonissi <qemu@bonslack.org>

OpenRISC (or1k) has long long alignment to 4 bytes, but currently not
defined in abitypes.h. This lead to incorrect packing of /epoll_event/
structure and eventually infinite loop while waiting for file
descriptor[s] event[s].

Fixed also CRIS alignments (1 byte for all types).

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1770
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/exec/user/abitypes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 6191ce9f74..6178453d94 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -15,8 +15,16 @@
 #define ABI_LLONG_ALIGNMENT 2
 #endif
 
+#ifdef TARGET_CRIS
+#define ABI_SHORT_ALIGNMENT 1
+#define ABI_INT_ALIGNMENT 1
+#define ABI_LONG_ALIGNMENT 1
+#define ABI_LLONG_ALIGNMENT 1
+#endif
+
 #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
     || defined(TARGET_SH4) \
+    || defined(TARGET_OPENRISC) \
     || defined(TARGET_MICROBLAZE) \
     || defined(TARGET_NIOS2)
 #define ABI_LLONG_ALIGNMENT 4
-- 
2.39.2


