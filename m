Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278DD82AD7B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:32:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtFR-0007nK-2a; Thu, 11 Jan 2024 06:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtFI-0007lR-9c
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:13 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtFB-0006qt-Pm
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:09 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxzvD+0J9ljT8EAA--.12634S3;
 Thu, 11 Jan 2024 19:29:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx34f80J9l6+4PAA--.41647S3; 
 Thu, 11 Jan 2024 19:29:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: 
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Tianrui Zhao <zhaotianrui@loongson.cn>
Subject: [PULL 01/14] linux-headers: Synchronize linux headers from linux
 v6.7.0-rc8
Date: Thu, 11 Jan 2024 19:15:56 +0800
Message-Id: <20240111111609.899183-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240111111609.899183-1-gaosong@loongson.cn>
References: <20240111111609.899183-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx34f80J9l6+4PAA--.41647S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Use the scripts/update-linux-headers.sh to synchronize linux
headers from linux v6.7.0-rc8. We mainly want to add the
loongarch linux headers and then add the loongarch kvm support
based on it.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240105075804.1228596-2-zhaotianrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 include/standard-headers/linux/fuse.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index 6b9793842c..fc0dcd10ae 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -209,7 +209,7 @@
  *  - add FUSE_HAS_EXPIRE_ONLY
  *
  *  7.39
- *  - add FUSE_DIRECT_IO_RELAX
+ *  - add FUSE_DIRECT_IO_ALLOW_MMAP
  *  - add FUSE_STATX and related structures
  */
 
@@ -405,8 +405,7 @@ struct fuse_file_lock {
  * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
  *			symlink and mknod (single group that matches parent)
  * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
- * FUSE_DIRECT_IO_RELAX: relax restrictions in FOPEN_DIRECT_IO mode, for now
- *                       allow shared mmap
+ * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -445,7 +444,10 @@ struct fuse_file_lock {
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
-#define FUSE_DIRECT_IO_RELAX	(1ULL << 36)
+#define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
+
+/* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
+#define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 
 /**
  * CUSE INIT request/reply flags
-- 
2.25.1


