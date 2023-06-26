Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1574473DD0E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBV-0002vD-KU; Mon, 26 Jun 2023 07:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBM-0002uK-Sw
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBL-0000Xb-6Q
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/S6qyTBc6TH7FdAe5KsHnG9S25rCXrSryg8HIOYMkQ=;
 b=bnf83QadTw15f1UBib3ck+c51Ml8ydre9+jUZM+NprLsniLfpGWj/omeVskNVQL2gXrkeY
 qocUvgnYH5aoTDxoTNQ+Ta9PZEhKz4lUcU0Sf9O7zSy11sjUkSEnIgxYfIqxr6UBNNC2JM
 kYxRs3aULmIak2C/1n/Df4gJI/Z4/No=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-AAydx8J9OBuuh9uAYytPPQ-1; Mon, 26 Jun 2023 07:14:53 -0400
X-MC-Unique: AAydx8J9OBuuh9uAYytPPQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fb40ec952bso630455e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778091; x=1690370091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/S6qyTBc6TH7FdAe5KsHnG9S25rCXrSryg8HIOYMkQ=;
 b=eCMuSLMNrrW5FG2SpgnNnglhQhFNnIUUUgyTRmqFZ8G0EbfOK/EaClqGT430mVDQXL
 zHdSpR/2JLtUElhpp8Jl0iUrCuPH/ru3itHsQ12HDxyFbORHmhRv/KCXR+6Szkj2u/+Y
 AgcOlG5cZawxU09R77QuFJDFqhT7kGzVeOFvgVdbrwAYQJqYrLPkotUPmfgeRadB93ub
 o+JECJ90NgZmJ5aJuGsKUdhOcovBwjuce1lqmSU4LOf0RIWGSysyZf7J/T6vZNuLFSNr
 IveKOirEEF9S4JLa1gn0rBv1eTdn5zaA2jIeLAQ3nRPMqbETbJ59CcMCquBGGp1Mf+PP
 D1+w==
X-Gm-Message-State: AC+VfDx5QcRBn7a/i+VSugihFj/oq3LvVorKYZjGqcbrTOFYjkV28Lj3
 zws1vrweqo+jLKNnSbqmQoEXjgploDb7h3neOnHQnXWYc3IQq3EwdLqF066QyOtdo0wl4NBLm+e
 Vasl20uq/ugMw0KKbdShw6u1G1uAqoHX0xovPMSmbBausQgEvWN4pPwJbAnBBqvI9eZV8/a4xrC
 o=
X-Received: by 2002:a05:600c:21a:b0:3fa:7810:8cbf with SMTP id
 26-20020a05600c021a00b003fa78108cbfmr8900592wmi.3.1687778091554; 
 Mon, 26 Jun 2023 04:14:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59Crv9cAGxW/lBOraSPml83ypF2GtPx4a6sWc95hl9ZqN/u/R0mlerhtJTgtnAhkc7WliyFQ==
X-Received: by 2002:a05:600c:21a:b0:3fa:7810:8cbf with SMTP id
 26-20020a05600c021a00b003fa78108cbfmr8900582wmi.3.1687778091213; 
 Mon, 26 Jun 2023 04:14:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a5d514d000000b0030e56a9ff25sm7021409wrt.31.2023.06.26.04.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 03/18] numa: Validate cluster and NUMA node boundary if required
Date: Mon, 26 Jun 2023 13:14:30 +0200
Message-ID: <20230626111445.163573-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gavin Shan <gshan@redhat.com>

For some architectures like ARM64, multiple CPUs in one cluster can be
associated with different NUMA nodes, which is irregular configuration
because we shouldn't have this in baremetal environment. The irregular
configuration causes Linux guest to misbehave, as the following warning
messages indicate.

  -smp 6,maxcpus=6,sockets=2,clusters=1,cores=3,threads=1 \
  -numa node,nodeid=0,cpus=0-1,memdev=ram0                \
  -numa node,nodeid=1,cpus=2-3,memdev=ram1                \
  -numa node,nodeid=2,cpus=4-5,memdev=ram2                \

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:2271 build_sched_domains+0x284/0x910
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-268.el9.aarch64 #1
  pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : build_sched_domains+0x284/0x910
  lr : build_sched_domains+0x184/0x910
  sp : ffff80000804bd50
  x29: ffff80000804bd50 x28: 0000000000000002 x27: 0000000000000000
  x26: ffff800009cf9a80 x25: 0000000000000000 x24: ffff800009cbf840
  x23: ffff000080325000 x22: ffff0000005df800 x21: ffff80000a4ce508
  x20: 0000000000000000 x19: ffff000080324440 x18: 0000000000000014
  x17: 00000000388925c0 x16: 000000005386a066 x15: 000000009c10cc2e
  x14: 00000000000001c0 x13: 0000000000000001 x12: ffff00007fffb1a0
  x11: ffff00007fffb180 x10: ffff80000a4ce508 x9 : 0000000000000041
  x8 : ffff80000a4ce500 x7 : ffff80000a4cf920 x6 : 0000000000000001
  x5 : 0000000000000001 x4 : 0000000000000007 x3 : 0000000000000002
  x2 : 0000000000001000 x1 : ffff80000a4cf928 x0 : 0000000000000001
  Call trace:
   build_sched_domains+0x284/0x910
   sched_init_domains+0xac/0xe0
   sched_init_smp+0x48/0xc8
   kernel_init_freeable+0x140/0x1ac
   kernel_init+0x28/0x140
   ret_from_fork+0x10/0x20

Improve the situation to warn when multiple CPUs in one cluster have
been associated with different NUMA nodes. However, one NUMA node is
allowed to be associated with different clusters.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230509002739.18388-2-gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1000406211f..46f8f9a2b04 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1262,6 +1262,45 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
     g_string_free(s, true);
 }
 
+static void validate_cpu_cluster_to_numa_boundary(MachineState *ms)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    NumaState *state = ms->numa_state;
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+    const CPUArchId *cpus = possible_cpus->cpus;
+    int i, j;
+
+    if (state->num_nodes <= 1 || possible_cpus->len <= 1) {
+        return;
+    }
+
+    /*
+     * The Linux scheduling domain can't be parsed when the multiple CPUs
+     * in one cluster have been associated with different NUMA nodes. However,
+     * it's fine to associate one NUMA node with CPUs in different clusters.
+     */
+    for (i = 0; i < possible_cpus->len; i++) {
+        for (j = i + 1; j < possible_cpus->len; j++) {
+            if (cpus[i].props.has_socket_id &&
+                cpus[i].props.has_cluster_id &&
+                cpus[i].props.has_node_id &&
+                cpus[j].props.has_socket_id &&
+                cpus[j].props.has_cluster_id &&
+                cpus[j].props.has_node_id &&
+                cpus[i].props.socket_id == cpus[j].props.socket_id &&
+                cpus[i].props.cluster_id == cpus[j].props.cluster_id &&
+                cpus[i].props.node_id != cpus[j].props.node_id) {
+                warn_report("CPU-%d and CPU-%d in socket-%" PRId64 "-cluster-%" PRId64
+                             " have been associated with node-%" PRId64 " and node-%" PRId64
+                             " respectively. It can cause OSes like Linux to"
+                             " misbehave", i, j, cpus[i].props.socket_id,
+                             cpus[i].props.cluster_id, cpus[i].props.node_id,
+                             cpus[j].props.node_id);
+            }
+        }
+    }
+}
+
 MemoryRegion *machine_consume_memdev(MachineState *machine,
                                      HostMemoryBackend *backend)
 {
@@ -1355,6 +1394,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
         numa_complete_configuration(machine);
         if (machine->numa_state->num_nodes) {
             machine_numa_finish_cpu_init(machine);
+            if (machine_class->cpu_cluster_has_numa_boundary) {
+                validate_cpu_cluster_to_numa_boundary(machine);
+            }
         }
     }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a385010909d..6b267c21ce7 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -274,6 +274,7 @@ struct MachineClass {
     bool nvdimm_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
+    bool cpu_cluster_has_numa_boundary;
     SMPCompatProps smp_props;
     const char *default_ram_id;
 
-- 
2.41.0


