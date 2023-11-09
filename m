Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8747E6A46
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:03:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13kE-0003IM-6R; Thu, 09 Nov 2023 07:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13k1-000304-0P
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:02:35 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jz-0001ej-4P
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531351; x=1731067351;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uAiLwZBVoB2283ODF/W1km9gijtCWMu83BRnwvnJuBY=;
 b=l2AvmOqDsZYnpvs23JzB5gAk0Ddb86Ij7K8AO+V29oQIAnyVTkn8T5VJ
 pxQA2ZWkl0Mxk1e7ebgdfEnCIziS0aozYmpKGHFIa21YURdl9B81+Ykj9
 QRtxFnVOI3OoKEZxiWolh+QvAZzpWCzXcDdvhcLMIH4EeOvymWbkrsijm
 MSgV5JdzZYoUWrRx8mJfk5VuOQEQV11uhE95hnOSo5E84yE0kkRHeiqik
 wfDLFdmHH0pTjCjH/5SviQ2aMGcahktWRRs7kCfpKEYt6OwE+JHIRZHbt
 XNsXPHvkbwV1w8etEfvu6+g+tMdV+iQVrGBQ4URNYATcGCTUw6Z+A/MWt w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305934"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305934"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11516265"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:02:13 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 20/20] hw/i386: Activate IOMMUFD for q35 machines
Date: Thu,  9 Nov 2023 19:45:29 +0800
Message-Id: <20231109114529.1904193-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 55850791df..a1846be6f7 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -95,6 +95,7 @@ config Q35
     imply E1000E_PCI_EXPRESS
     imply VMPORT
     imply VMMOUSE
+    imply IOMMUFD
     select PC_PCI
     select PC_ACPI
     select PCI_EXPRESS_Q35
-- 
2.34.1


