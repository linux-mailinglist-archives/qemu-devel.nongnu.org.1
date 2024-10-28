Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713199B22E5
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 03:39:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Fe8-0002ZL-QK; Sun, 27 Oct 2024 22:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t5Fe5-0002Yu-Bq
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:38:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t5Fe3-0002GD-4h
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:38:17 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxeeEU+R5n9ssXAA--.50131S3;
 Mon, 28 Oct 2024 10:38:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx18AR+R5nE_sgAA--.13349S3;
 Mon, 28 Oct 2024 10:38:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>, kvm@vger.kernel.org
Subject: [PATCH v3 1/3] linux-headers: Add unistd_64.h
Date: Mon, 28 Oct 2024 10:38:07 +0800
Message-Id: <20241028023809.1554405-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241028023809.1554405-1-maobibo@loongson.cn>
References: <20241028023809.1554405-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx18AR+R5nE_sgAA--.13349S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

since 6.11, unistd.h includes header file unistd_64.h directly on
some platforms, here add unistd_64.h on these platforms. Affected
platforms are ARM64, LoongArch64 and Riscv. Otherwise there will
be compiling error such as:

linux-headers/asm/unistd.h:3:10: fatal error: asm/unistd_64.h: No such file or directory
 #include <asm/unistd_64.h>

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 scripts/update-linux-headers.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index c34ac6454e..203f48d089 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -163,6 +163,7 @@ EOF
     fi
     if [ $arch = arm64 ]; then
         cp "$hdrdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
+        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-arm64/"
     fi
     if [ $arch = x86 ]; then
         cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
@@ -185,6 +186,11 @@ EOF
     fi
     if [ $arch = riscv ]; then
         cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
+        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-riscv/"
+        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-riscv/"
+    fi
+    if [ $arch = loongarch ]; then
+        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-loongarch/"
     fi
 done
 arch=
-- 
2.39.3


