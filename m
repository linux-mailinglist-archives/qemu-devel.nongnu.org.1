Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3359E7B2ECB
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 11:02:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Mp-0001xv-Tq; Fri, 29 Sep 2023 05:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Me-0001pX-Fv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MP-0008C4-C1
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azgp07v5+QOdek2AunJJzRtlE9aw2NAlB9y0wTULCmo=;
 b=Kkf3eG0gBLdxs4zwNxQqN2NohSWV9OzRwiTBEeZpKnyGlmR7/UrsQJoEC2eXZzFuvxHajA
 ddKvBaLcD9TSRWpvve3VvXE3Z4XbvIK0cwYg41nNEY2OvZtJVcpbzP+L3ykTO6BG0ENCV9
 xAbOBeYB5eTfqVGtKEl3QM3mV+cFlpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-ajcrBFjKOUKr4T_r8HXm-w-1; Fri, 29 Sep 2023 05:00:28 -0400
X-MC-Unique: ajcrBFjKOUKr4T_r8HXm-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86DA385A5BF;
 Fri, 29 Sep 2023 09:00:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C54E14171B6;
 Fri, 29 Sep 2023 09:00:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB30421E68A9; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 52/56] target/riscv: cpu: Fixup local variables shadowing
Date: Fri, 29 Sep 2023 10:50:49 +0200
Message-ID: <20230929085053.2789105-53-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Alistair Francis <alistair23@gmail.com>

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Bugs love to hide in such code.
Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
on polling error".

This patch removes the local variable shadowing. Tested by adding:

    --extra-cflags='-Wshadow=local -Wno-error=shadow=local -Wno-error=shadow=compatible-local'

To configure

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925043023.71448-3-alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f227c7664e..4140899c52 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -704,7 +704,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             CSR_MPMMASK,
         };
 
-        for (int i = 0; i < ARRAY_SIZE(dump_csrs); ++i) {
+        for (i = 0; i < ARRAY_SIZE(dump_csrs); ++i) {
             int csrno = dump_csrs[i];
             target_ulong val = 0;
             RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
@@ -747,7 +747,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                     CSR_VTYPE,
                     CSR_VLENB,
                 };
-        for (int i = 0; i < ARRAY_SIZE(dump_rvv_csrs); ++i) {
+        for (i = 0; i < ARRAY_SIZE(dump_rvv_csrs); ++i) {
             int csrno = dump_rvv_csrs[i];
             target_ulong val = 0;
             RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
-- 
2.41.0


