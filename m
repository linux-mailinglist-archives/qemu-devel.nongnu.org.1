Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20A75C4EC
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 12:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMnd3-0007FP-4c; Fri, 21 Jul 2023 06:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qMnd1-0007F9-Lu
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qMnd0-00035f-8w
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689936293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8W3GJN6YpoLxrkwLjaQfMAb4M5dgQh5CfSUKNliKKek=;
 b=X6JIPhQRLPsrpc4s4e8/GVw/jTEZ7TLgPcxgYQWPwqa+4glHFB9YWALTOpOyF065/lX+F4
 rPgk/RbTyXBsyctNmaUKV3ZpqJhhmvP8x58ip/oz/uYZIA4ZM4Jc9Odkin0R3yR9gL0bJF
 mMjCOi+roxohKfqP806pUx3Rw71gxjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-F-0SFr2FNgKGTr0n3vXf6Q-1; Fri, 21 Jul 2023 06:44:49 -0400
X-MC-Unique: F-0SFr2FNgKGTr0n3vXf6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0F3A86F122;
 Fri, 21 Jul 2023 10:44:48 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA05CC2C857;
 Fri, 21 Jul 2023 10:44:45 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, imammedo@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH] numa: Skip invalidation of cluster and NUMA node boundary for
 qtest
Date: Fri, 21 Jul 2023 20:44:37 +1000
Message-ID: <20230721104437.1199866-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There are warning messages printed from tests/qtest/numa-test.c,
to complain the CPU cluster and NUMA node boundary is broken. Since
the broken boundary is expected, we don't want to see the warning
messages.

  # cd /home/gavin/sandbox/qemu.main/build
  # MALLOC_PERTURB_=255 QTEST_QEMU_BINARY=./qemu-system-aarch64           \
    G_TEST_DBUS_DAEMON=../tests/dbus-vmstate-daemon.sh                    \
    QTEST_QEMU_IMG=./qemu-img                                             \
    QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
    tests/qtest/numa-test --tap -k
      :
    qemu-system-aarch64: warning: CPU-0 and CPU-4 in socket-0-cluster-0   \
    have been associated with node-0 and node-1 respectively.             \
    It can cause OSes like Linux to misbehave
      :

Skip the invalidation of CPU cluster and NUMA node boundary when
qtest is enabled, to avoid the warning messages.

Fixes: a494fdb715 ("numa: Validate cluster and NUMA node boundary if required")
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f0d35c6401..1c5136e735 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1271,7 +1271,7 @@ static void validate_cpu_cluster_to_numa_boundary(MachineState *ms)
     const CPUArchId *cpus = possible_cpus->cpus;
     int i, j;
 
-    if (state->num_nodes <= 1 || possible_cpus->len <= 1) {
+    if (qtest_enabled() || state->num_nodes <= 1 || possible_cpus->len <= 1) {
         return;
     }
 
-- 
2.41.0


