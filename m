Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CCAAF67E
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 11:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCxKC-0004RC-Qt; Thu, 08 May 2025 05:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uCxK9-0004Qn-4g
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:13:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uCxK6-00050s-8H
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:13:48 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axz3PBdRxom4fZAA--.28333S3;
 Thu, 08 May 2025 17:13:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxzxvAdRxouba8AA--.34274S2;
 Thu, 08 May 2025 17:13:37 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn, farosas@suse.de,
 thuth@redhat.com
Subject: [PATCH 1/1] loongarch: update cross-tools to support LSX/LASX
 instructions
Date: Thu,  8 May 2025 16:51:28 +0800
Message-Id: <20250508085128.2068372-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxvAdRxouba8AA--.34274S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

the old cross-tools not support LSX/LASX instructions, update
cross-tools to suspport LSX/LASX instructions.
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 docs/system/loongarch/virt.rst                         | 2 +-
 tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rst
index 7845878469..a1c5060c58 100644
--- a/docs/system/loongarch/virt.rst
+++ b/docs/system/loongarch/virt.rst
@@ -47,7 +47,7 @@ can be accessed by following steps.
 
 .. code-block:: bash
 
-  wget https://github.com/loongson/build-tools/releases/download/2022.09.06/loongarch64-clfs-6.3-cross-tools-gcc-glibc.tar.xz
+  wget https://github.com/loongson/build-tools/releases/download/2025.02.21/x86_64-cross-tools-loongarch64-binutils_2.44-gcc_14.2.0-glibc_2.41.tar.xz
   tar -vxf loongarch64-clfs-6.3-cross-tools-gcc-glibc.tar.xz  -C /opt
   export PATH=/opt/cross-tools/bin:$PATH
   export LD_LIBRARY_PATH=/opt/cross-tools/lib:$LD_LIBRARY_PATH
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 538ab53490..f82e83e7c2 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -37,7 +37,7 @@ RUN apt-get update && \
 
 RUN /usr/bin/pip3 install tomli
 
-RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
+RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2025.02.21/x86_64-cross-tools-loongarch64-binutils_2.44-gcc_14.2.0-glibc_2.41.tar.xz \
     | tar -xJC /opt
 
 ENV PATH $PATH:/opt/cross-tools/bin
-- 
2.34.1


