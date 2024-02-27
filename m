Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F5869CF8
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 17:59:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0mB-0005Jv-Cw; Tue, 27 Feb 2024 11:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf0m6-0005Ih-JK
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf0m5-00054z-1Z
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709053068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQdBQ55XBD1zKpk7OKKORm1TNObn+aTFGDtbgCuAoGo=;
 b=SjCItQPpiE4p7IknjqF/uRSWNS9XoiConCcQsmdVvexrZpo7Y4+RXgrTZHtLgMfqiF9lUM
 jD0UA6KTVueH5dpgNRMqxlo5U5a2wmNn4fllKaEiC/rucJVJ+BWEasC06aMTQLJYaeCYHw
 uxLm8n8gedzoHJyRrntn45RG8DDMO3Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-NgxUnkcwOT6kYJt9dzVygA-1; Tue,
 27 Feb 2024 11:57:43 -0500
X-MC-Unique: NgxUnkcwOT6kYJt9dzVygA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 727773814E91;
 Tue, 27 Feb 2024 16:57:43 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63D902166B5E;
 Tue, 27 Feb 2024 16:57:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com, jasowang@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com
Subject: [PATCH v6 1/3] qdev: Add a granule_mode property
Date: Tue, 27 Feb 2024 17:55:48 +0100
Message-ID: <20240227165730.14099-2-eric.auger@redhat.com>
In-Reply-To: <20240227165730.14099-1-eric.auger@redhat.com>
References: <20240227165730.14099-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce a new enum type property allowing to set an
IOMMU granule. Values are 4k, 8k, 16k, 64k and host.
This latter indicates the vIOMMU granule will match
the host page size.

A subsequent patch will add such a property to the
virtio-iommu device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

---
v5 -> v6
- remove #include "hw/virtio/virtio-iommu.h" (Zhenzhong)

v4 -> v5
- remove code that can be automatically generated
  and add the new enum in qapi/virtio.json (Philippe).
  Added Phild's SOB. low case needs to be used due to
  the Jason generation.

v3 -> v4:
- Add 8K
---
 qapi/virtio.json                    | 18 ++++++++++++++++++
 include/hw/qdev-properties-system.h |  3 +++
 hw/core/qdev-properties-system.c    | 14 ++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index a79013fe89..95745fdfd7 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -957,3 +957,21 @@
 
 { 'struct': 'DummyVirtioForceArrays',
   'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'] } }
+
+##
+# @GranuleMode:
+#
+# @4k: granule page size of 4KiB
+#
+# @8k: granule page size of 8KiB
+#
+# @16k: granule page size of 16KiB
+#
+# @64k: granule page size of 64KiB
+#
+# @host: granule matches the host page size
+#
+# Since: 9.0
+##
+{ 'enum': 'GranuleMode',
+  'data': [ '4k', '8k', '16k', '64k', 'host' ] }
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 06c359c190..626be87dd3 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -8,6 +8,7 @@ extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_mig_mode;
+extern const PropertyInfo qdev_prop_granule_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -47,6 +48,8 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 #define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
                        MigMode)
+#define DEFINE_PROP_GRANULE_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_granule_mode, GranuleMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1a396521d5..b45e90edb2 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -679,6 +679,20 @@ const PropertyInfo qdev_prop_mig_mode = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- GranuleMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(GranuleMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_granule_mode = {
+    .name = "GranuleMode",
+    .description = "granule_mode values, "
+                   "4k, 8k, 16k, 64k, host",
+    .enum_table = &GranuleMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
-- 
2.41.0


