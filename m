Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7317F7B2ED1
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 11:02:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Mr-0001z8-Ji; Fri, 29 Sep 2023 05:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Mf-0001q0-F3
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MP-0008C6-Br
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MovP6uA9rAExPQL+1e2QSD2zaYRa2z2+ns2RMsw7fak=;
 b=SDbUdTD32TyltWU8jgqVpoywEgmKWajrr0ckOBVWh8lvz3gaQ4BtK4UTUvA05HhaH+6zqa
 ft+KRDnXcbLIa49Odpqayoj3nixMBWdJVsHbDCw07og86JZQ8VzAZzMqqCfhM1LAAVNz/R
 m9VXf68fdDr74gNjN6X+u4UXAhMJr3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-gFInJY1DMNiSHWw9YMepnQ-1; Fri, 29 Sep 2023 05:00:28 -0400
X-MC-Unique: gFInJY1DMNiSHWw9YMepnQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84E73805BA7;
 Fri, 29 Sep 2023 09:00:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F630492B05;
 Fri, 29 Sep 2023 09:00:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EDFC621E68AA; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 53/56] target/riscv: vector_helper: Fixup local variables
 shadowing
Date: Fri, 29 Sep 2023 10:50:50 +0200
Message-ID: <20230929085053.2789105-54-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Message-ID: <20230925043023.71448-4-alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/riscv/vector_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3fb05cc3d6..cba02c1320 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -516,7 +516,7 @@ ProbeSuccess:
                 k++;
                 continue;
             }
-            target_ulong addr = base + ((i * nf + k) << log2_esz);
+            addr = base + ((i * nf + k) << log2_esz);
             ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
             k++;
         }
@@ -4791,9 +4791,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t vma = vext_vma(desc);                                        \
-    target_ulong i_max, i;                                                \
+    target_ulong i_max, i_min, i;                                         \
                                                                           \
-    i_max = MAX(MIN(s1 < vlmax ? vlmax - s1 : 0, vl), env->vstart);       \
+    i_min = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
+    i_max = MAX(i_min, env->vstart);                                      \
     for (i = env->vstart; i < i_max; ++i) {                               \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
-- 
2.41.0


