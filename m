Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9A799866
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexeK-0006VF-W6; Sat, 09 Sep 2023 09:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexeI-0006Up-F4; Sat, 09 Sep 2023 09:05:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexeE-0003Oh-3E; Sat, 09 Sep 2023 09:05:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 58478205CE;
 Sat,  9 Sep 2023 16:06:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1F06626E21;
 Sat,  9 Sep 2023 16:05:12 +0300 (MSK)
Received: (nullmailer pid 354263 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 01/37] machine: Add helpers to get cores/threads per
 socket
Date: Sat,  9 Sep 2023 16:04:31 +0300
Message-Id: <20230909130511.354171-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
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

From: Zhao Liu <zhao1.liu@intel.com>

The number of cores/threads per socket are needed for smbios, and are
also useful for other modules.

Provide the helpers to wrap the calculation of cores/threads per socket
so that we can avoid calculation errors caused by other modules miss
topology changes.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230628135437.1145805-2-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a1d027be95bc375238e5b9292c6aa661a8ddef4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index b39ed21e65..903834c0db 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -193,3 +193,13 @@ void machine_parse_smp_config(MachineState *ms,
         return;
     }
 }
+
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
+{
+    return ms->smp.cores * ms->smp.clusters * ms->smp.dies;
+}
+
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
+{
+    return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
+}
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 90f1dd3aeb..ca2f0d3592 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -36,6 +36,8 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
 void machine_parse_smp_config(MachineState *ms,
                               const SMPConfiguration *config, Error **errp);
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms);
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms);
 
 /**
  * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices
-- 
2.39.2


