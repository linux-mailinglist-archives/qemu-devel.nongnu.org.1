Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E9487BFE1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Mar 2024 16:24:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmvo-0007i0-BG; Thu, 14 Mar 2024 11:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvY-0007ML-71
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvW-0003o7-Gb
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KejdRbjD3mCxnDmdHfcSqh/anBmiXsqbBJYD+lMfvU=;
 b=Q5iGWSBs4QjimUZDTrBijAmJk0Pw1M5q0fZ2fy1cD2+IfdcC2ErB0fpKuXDUetQr1OXV3a
 P9sh6Ge5zuwwerCCU5PNSQNhlcgkpYYMRyj6UYJ3RhqmQNMmjIdG3nPTNNLrMWp9PRQDhR
 QTco9iUMssXI66k31SqNpXJ/rOTHA6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-_cnm6hk_P-uoRZIGvfoeHg-1; Thu, 14 Mar 2024 11:23:22 -0400
X-MC-Unique: _cnm6hk_P-uoRZIGvfoeHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07AB384FA83;
 Thu, 14 Mar 2024 15:23:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25DE517A8E;
 Thu, 14 Mar 2024 15:23:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v4 16/21] smbios: in case of entry point is 'auto' try to
 build v2 tables 1st
Date: Thu, 14 Mar 2024 16:22:57 +0100
Message-Id: <20240314152302.2324164-17-imammedo@redhat.com>
In-Reply-To: <20240314152302.2324164-1-imammedo@redhat.com>
References: <20240314152302.2324164-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

QEMU for some time now uses SMBIOS 3.0 for PC/Q35 machines by
default, however Windows has a bug in locating SMBIOS 3.0
entrypoint and fails to find tables when booted on SeaBIOS
(on UEFI SMBIOS 3.0 tables work fine since firmware hands
over tables in another way)

Missing SMBIOS tables may lead to some issues for guest
though (worst are: possible reactiveation, inability to
get virtio drivers from 'Windows Update')

It's unclear  at this point if MS will fix the issue on their
side. So instead of it (or rather in addition) this patch
will try to workaround the issue.

aka, use smbios-entry-point-type=auto to make QEMU try
generating conservative SMBIOS 2.0 tables and if that
fails (due to limits/requested configuration) fallback
to SMBIOS 3.0 tables.

With this in place majority of users will use SMBIOS 2.0
tables which work fine with (Windows + legacy BIOS).
The configurations that is not to possible to describe
with SMBIOS 2.0 will switch automatically to SMBIOS 3.0
(which will trigger Windows bug but there is nothing
QEMU can do here, so go and aks Microsoft to real fix).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/smbios/smbios.c | 52 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 9aad8f2df2..d9dda226e6 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1082,7 +1082,7 @@ static void smbios_entry_point_setup(SmbiosEntryPointType ep_type)
     }
 }
 
-void smbios_get_tables(MachineState *ms,
+static bool smbios_get_tables_ep(MachineState *ms,
                        SmbiosEntryPointType ep_type,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
@@ -1091,6 +1091,7 @@ void smbios_get_tables(MachineState *ms,
                        Error **errp)
 {
     unsigned i, dimm_cnt, offset;
+    ERRP_GUARD();
 
     assert(ep_type == SMBIOS_ENTRY_POINT_TYPE_32 ||
            ep_type == SMBIOS_ENTRY_POINT_TYPE_64);
@@ -1177,11 +1178,56 @@ void smbios_get_tables(MachineState *ms,
         abort();
     }
 
-    return;
+    return true;
 err_exit:
     g_free(smbios_tables);
     smbios_tables = NULL;
-    return;
+    return false;
+}
+
+void smbios_get_tables(MachineState *ms,
+                       SmbiosEntryPointType ep_type,
+                       const struct smbios_phys_mem_area *mem_array,
+                       const unsigned int mem_array_size,
+                       uint8_t **tables, size_t *tables_len,
+                       uint8_t **anchor, size_t *anchor_len,
+                       Error **errp)
+{
+    Error *local_err = NULL;
+    bool is_valid;
+    ERRP_GUARD();
+
+    switch (ep_type) {
+    case SMBIOS_ENTRY_POINT_TYPE_AUTO:
+    case SMBIOS_ENTRY_POINT_TYPE_32:
+        is_valid = smbios_get_tables_ep(ms, SMBIOS_ENTRY_POINT_TYPE_32,
+                                        mem_array, mem_array_size,
+                                        tables, tables_len,
+                                        anchor, anchor_len,
+                                        &local_err);
+        if (is_valid || ep_type != SMBIOS_ENTRY_POINT_TYPE_AUTO) {
+            break;
+        }
+        /*
+         * fall through in case AUTO endpoint is selected and
+         * SMBIOS 2.x tables can't be generated, to try if SMBIOS 3.x
+         * tables would work
+         */
+    case SMBIOS_ENTRY_POINT_TYPE_64:
+        error_free(local_err);
+        local_err = NULL;
+        is_valid = smbios_get_tables_ep(ms, SMBIOS_ENTRY_POINT_TYPE_64,
+                                        mem_array, mem_array_size,
+                                        tables, tables_len,
+                                        anchor, anchor_len,
+                                        &local_err);
+        break;
+    default:
+        abort();
+    }
+    if (!is_valid) {
+        error_propagate(errp, local_err);
+    }
 }
 
 static void save_opt(const char **dest, QemuOpts *opts, const char *name)
-- 
2.39.3


