Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440F7BC653
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 11:04:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp3E7-0006Rl-Dp; Sat, 07 Oct 2023 05:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qp3E5-0006QE-G0
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 05:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qp3E3-0003JI-Uo
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 05:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696669434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zm348nb4qry0AIbdnSFqYs4rGeI+jJKG7axAkLfsgG8=;
 b=HLzQLtSW5ral60In0geNho329pMjCqM5f2t/CiD5JSEHzttpjMi1PKwmrO7zpTivV0uE+Z
 HAmXKpTcObgOjczcSPFOoUY6jAiv2bXvijQWwjqwe80/jGQZMLVTpjoDWh09k56Q15FtlB
 No97UEwb7M6kb9CGqYE7s83uhyjaq0g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-01MYAs8JNN-yTSjltO87aw-1; Sat, 07 Oct 2023 05:02:36 -0400
X-MC-Unique: 01MYAs8JNN-yTSjltO87aw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE19C3800E95;
 Sat,  7 Oct 2023 09:02:35 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.42.28.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4E42140E962;
 Sat,  7 Oct 2023 09:02:33 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com
Subject: [PATCH] target/riscv: Use a direct cast for better performance
Date: Sat,  7 Oct 2023 10:02:28 +0100
Message-ID: <20231007090232.3329594-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

RISCV_CPU(cs) uses a checked cast.  When QOM cast debugging is enabled
this adds about 5% total overhead when emulating RV64 on x86-64 host.

Using a RISC-V guest with 16 vCPUs, 16 GB of guest RAM, virtio-blk
disk.  The guest has a copy of the qemu source tree.  The test
involves compiling the qemu source tree with 'make clean; time make -j16'.

Before making this change the compile step took 449 & 447 seconds over
two consecutive runs.

After making this change, 428 & 422 seconds.

The saving is about 5%.

Thanks: Paolo Bonzini
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 target/riscv/cpu_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3a02079290..6174d99fb2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -66,7 +66,11 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
     CPUState *cs = env_cpu(env);
-    RISCVCPU *cpu = RISCV_CPU(cs);
+    /*
+     * Using the checked cast RISCV_CPU(cs) imposes ~ 5% overhead when
+     * qemu cast debugging is enabled, so use a direct cast instead.
+     */
+    RISCVCPU *cpu = (RISCVCPU *)cs;
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
 
-- 
2.41.0


