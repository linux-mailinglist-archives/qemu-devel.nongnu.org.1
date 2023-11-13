Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA77E9D88
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 14:45:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2XEG-0005Kb-ET; Mon, 13 Nov 2023 08:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2XEE-0005Jz-NV
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2XEC-0006dT-Pm
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699883027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fwIqFs1fFKeiPTlzxsVE5zsucOt+bQbn+hhgLM+qEg=;
 b=Lr2+ZLjRPVitCdHKKleslY1qkaRDJLb5uPVHLcByTWfKc/9pRh/q5vGhX7r2zeOOnH+mVq
 3lPnIk6RBZAp4IbGouPl9eJekh9pnzct7G6mD9PQGbpOnfPiuxLDPuc/UQESiX8Dae2Cg5
 3pMOOd3cnXTCeHb4HbxiRY45BGqRVmI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-X0glAJ0CN6WVdn7WpGEteg-1; Mon,
 13 Nov 2023 08:43:45 -0500
X-MC-Unique: X0glAJ0CN6WVdn7WpGEteg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AFA63822E80;
 Mon, 13 Nov 2023 13:43:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CDB5502C;
 Mon, 13 Nov 2023 13:43:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 31B7B21E6A28; Mon, 13 Nov 2023 14:43:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair@alistair23.me, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com, qemu-arm@nongnu.org
Subject: [PATCH 2/2] hw: Replace anti-social QOM type names (again)
Date: Mon, 13 Nov 2023 14:43:44 +0100
Message-ID: <20231113134344.1195478-3-armbru@redhat.com>
In-Reply-To: <20231113134344.1195478-1-armbru@redhat.com>
References: <20231113134344.1195478-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

QOM type names containing ',' result in awful UI.  We got rid of them
in v6.0.0 (commit e178113ff64 hw: Replace anti-social QOM type names).
A few have crept back since:

    xlnx,cframe-reg
    xlnx,efuse
    xlnx,pmc-efuse-cache
    xlnx,versal-cfu-apb
    xlnx,versal-cfu-fdro
    xlnx,versal-cfu-sfr
    xlnx,versal-crl
    xlnx,versal-efuse
    xlnx,zynqmp-efuse

These are all device types.  They can't be plugged with -device /
device_add, except for "xlnx,efuse" (I'm not sure that one is
intentional).

They *can* be used with -device / device_add to request help.
Usability is poor, though: you have to double the comma, like this:

    $ qemu-system-aarch64 -device xlnx,,pmc-efuse-cache,help

They can also be used with -global, where you must *not* double the
comma:

    $ qemu-system-aarch64 -global xlnx,efuse.drive-index=2

Trap for the unwary.

"xlnx,efuse", "xlnx,versal-efuse", "xlnx,pmc-efuse-cache",
"xlnx-zynqmp-efuse" are from v6.2.0, "xlnx,versal-crl" is from v7.1.0,
and the remainder are new.

Rename them all to "xlnx-FOO", like commit e178113ff64 did.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/system/arm/xlnx-versal-virt.rst     | 2 +-
 include/hw/misc/xlnx-versal-cframe-reg.h | 2 +-
 include/hw/misc/xlnx-versal-cfu.h        | 6 +++---
 include/hw/misc/xlnx-versal-crl.h        | 2 +-
 include/hw/nvram/xlnx-efuse.h            | 2 +-
 include/hw/nvram/xlnx-versal-efuse.h     | 4 ++--
 include/hw/nvram/xlnx-zynqmp-efuse.h     | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index a6a77b3799..edf2e48109 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -212,7 +212,7 @@ To use a different index value, N, from default of 1, add:
 
 .. code-block:: bash
 
-  -global xlnx,efuse.drive-index=N
+  -global xlnx-efuse.drive-index=N
 
 .. warning::
   In actual physical Versal, BBRAM and eFUSE contain sensitive data.
diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
index a14fbd7fe4..f403b00e31 100644
--- a/include/hw/misc/xlnx-versal-cframe-reg.h
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -23,7 +23,7 @@
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "qemu/fifo32.h"
 
-#define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx,cframe-reg"
+#define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx-cframe-reg"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameReg, XLNX_VERSAL_CFRAME_REG)
 
 #define TYPE_XLNX_VERSAL_CFRAME_BCAST_REG "xlnx.cframe-bcast-reg"
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index 86fb841053..8c581c0797 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -22,13 +22,13 @@
 #include "hw/misc/xlnx-cfi-if.h"
 #include "qemu/fifo32.h"
 
-#define TYPE_XLNX_VERSAL_CFU_APB "xlnx,versal-cfu-apb"
+#define TYPE_XLNX_VERSAL_CFU_APB "xlnx-versal-cfu-apb"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
 
-#define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx,versal-cfu-fdro"
+#define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx-versal-cfu-fdro"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUFDRO, XLNX_VERSAL_CFU_FDRO)
 
-#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx,versal-cfu-sfr"
+#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx-versal-cfu-sfr"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUSFR, XLNX_VERSAL_CFU_SFR)
 
 REG32(CFU_ISR, 0x0)
diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index 2857f4169a..dfb8dff197 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -13,7 +13,7 @@
 #include "hw/register.h"
 #include "target/arm/cpu.h"
 
-#define TYPE_XLNX_VERSAL_CRL "xlnx,versal-crl"
+#define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
 
 REG32(ERR_CTRL, 0x0)
diff --git a/include/hw/nvram/xlnx-efuse.h b/include/hw/nvram/xlnx-efuse.h
index 58414e468b..cff7924106 100644
--- a/include/hw/nvram/xlnx-efuse.h
+++ b/include/hw/nvram/xlnx-efuse.h
@@ -30,7 +30,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/qdev-core.h"
 
-#define TYPE_XLNX_EFUSE "xlnx,efuse"
+#define TYPE_XLNX_EFUSE "xlnx-efuse"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxEFuse, XLNX_EFUSE);
 
 struct XlnxEFuse {
diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
index a873dc5cb0..86e2261b9a 100644
--- a/include/hw/nvram/xlnx-versal-efuse.h
+++ b/include/hw/nvram/xlnx-versal-efuse.h
@@ -29,8 +29,8 @@
 
 #define XLNX_VERSAL_EFUSE_CTRL_R_MAX ((0x100 / 4) + 1)
 
-#define TYPE_XLNX_VERSAL_EFUSE_CTRL  "xlnx,versal-efuse"
-#define TYPE_XLNX_VERSAL_EFUSE_CACHE "xlnx,pmc-efuse-cache"
+#define TYPE_XLNX_VERSAL_EFUSE_CTRL  "xlnx-versal-efuse"
+#define TYPE_XLNX_VERSAL_EFUSE_CACHE "xlnx-pmc-efuse-cache"
 
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalEFuseCtrl, XLNX_VERSAL_EFUSE_CTRL);
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalEFuseCache, XLNX_VERSAL_EFUSE_CACHE);
diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx-zynqmp-efuse.h
index 6b051ec4f1..f5beacc2e6 100644
--- a/include/hw/nvram/xlnx-zynqmp-efuse.h
+++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
@@ -29,7 +29,7 @@
 
 #define XLNX_ZYNQMP_EFUSE_R_MAX ((0x10fc / 4) + 1)
 
-#define TYPE_XLNX_ZYNQMP_EFUSE "xlnx,zynqmp-efuse"
+#define TYPE_XLNX_ZYNQMP_EFUSE "xlnx-zynqmp-efuse"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPEFuse, XLNX_ZYNQMP_EFUSE);
 
 struct XlnxZynqMPEFuse {
-- 
2.41.0


