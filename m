Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD0E88A2CC
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 14:46:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokeJ-0006Mi-Ax; Mon, 25 Mar 2024 09:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rojxH-0002g9-Cd; Mon, 25 Mar 2024 09:01:38 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rojxF-0001pz-9k; Mon, 25 Mar 2024 09:01:35 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com BF729C0029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1711371686;
 bh=xIIe5O6x22a7VBvnMNb4j1rhvzWw+lgcaBik4NeVUwc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=br2SgbIcp6hGyWtlKkpxMybxSKPqb+IyrhrB6E8mMUSlpcE7LtiRsHaRMrQhyYZzg
 C1TgwzxZ6BZXu1ANtkPXvpZ92JOrr5YcArZhEX3vwPFgcJ0x/sq0rAMoggLE6FAPEn
 k3QymuuY1XLMmMM7lYegSnKq5K62ANXdc1OpTBLAYKZvCikJ4XvhrwC5sSUAWfYPsC
 q7xNwMppU+xJVYQ+9iL++P+4rWRwUG/S127yFvUOieaMRf6o5pM8ZCDORsNU6Gdark
 BFHa4EpPvlzwQh31yY1/zh7Jswf6cvs+nRgmutiDWMjmHrnpt8TiaaIQAuPK/87eC3
 Dudqx6DDAvX7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1711371686;
 bh=xIIe5O6x22a7VBvnMNb4j1rhvzWw+lgcaBik4NeVUwc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=qLCSWfKbxk6jcHHTpDr5dkwYLQY609xuMEu1XKIpeMORkxupv2Wmi6dmTax3HiCV8
 /KkxGxYt1H2wleY+sSl/4zGTlR5k8wQ5+uLa0ifokITz3qhph3BkZQVkqNlf3WUmrq
 yEu3EOUhTaADFeWUYSIdeFDyMhBzn+yjVellR5vi+oYShPA1QjoYKLgH7mMWHETvSv
 ShA6oRD9o09s1WXwfWxDKyOEU6PIo7x/Ne5pbgKn3VhbcfV85dOQPFa5GHfzP96Sly
 2TkmXm0LzWAcdoGfg1wv/d/rP0AkVreiLWAwzgcDD7ksC7z0tpx8JNtlsZ6eJebIUQ
 UUpe/Xu6GUV7Q==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <dbarboza@ventanamicro.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <apatel@ventanamicro.com>, <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <palmer@dabbelt.com>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail
 with vendor-specific SBI
Date: Mon, 25 Mar 2024 16:01:16 +0300
Message-ID: <20240325130116.13194-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b7fff1e9-f2b3-4a45-8966-1dbd76263457@ventanamicro.com>
References: <b7fff1e9-f2b3-4a45-8966-1dbd76263457@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 25 Mar 2024 09:45:59 -0400
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

kvm_riscv_handle_sbi() may return not supported return code to not trigger
qemu abort with vendor-specific sbi.

Added SBI related return code's defines.

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---

Changes since v1:
        -Add Fixes and Revied-by lines.
 target/riscv/kvm/kvm-cpu.c         |  5 +++--
 target/riscv/sbi_ecall_interface.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80..a4f84ad950 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1404,7 +1404,7 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         if (ret == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
         } else {
-            run->riscv_sbi.ret[0] = -1;
+            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
         }
         ret = 0;
         break;
@@ -1412,7 +1412,8 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         qemu_log_mask(LOG_UNIMP,
                       "%s: un-handled SBI EXIT, specific reasons is %lu\n",
                       __func__, run->riscv_sbi.extension_id);
-        ret = -1;
+        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
+        ret = 0;
         break;
     }
     return ret;
diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
index 43899d08f6..0279e92a36 100644
--- a/target/riscv/sbi_ecall_interface.h
+++ b/target/riscv/sbi_ecall_interface.h
@@ -69,4 +69,15 @@
 #define SBI_EXT_VENDOR_END              0x09FFFFFF
 /* clang-format on */
 
+/* SBI return error codes */
+#define SBI_SUCCESS                  0
+#define SBI_ERR_FAILURE             -1
+#define SBI_ERR_NOT_SUPPORTED       -2
+#define SBI_ERR_INVALID_PARAM       -3
+#define SBI_ERR_DENIED              -4
+#define SBI_ERR_INVALID_ADDRESS     -5
+#define SBI_ERR_ALREADY_AVAILABLE   -6
+#define SBI_ERR_ALREADY_STARTED     -7
+#define SBI_ERR_ALREADY_STOPPED     -8
+
 #endif
-- 
2.34.1


