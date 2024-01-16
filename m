Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5B82EA17
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:34:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdxg-00005r-LB; Tue, 16 Jan 2024 02:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxT-0008TI-9r
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:05 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxR-00046E-5Q
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705390441; x=1736926441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NgnHzCTSCTKquyJpFiX89hXCatN92/in/Rwg+j2uyf8=;
 b=MrKkQ2e7vuDdS89xwWrKJpSqOoZw5fvh0ncazyM+1T5DIzt6Fy40OHBs
 HZAjuRkri9z7VQ8UPDyEBEbGs5aMnPYuLCSTe+s+xagVZdHwMF+k1Gl0Q
 OW/jT2gf7skx7zdhf4n5rzMHIPY3RU6IWSZ4d+1e4XmsdrypqPJaF5vl3
 vDlVktwSgKwK2VMrb/xSZLcO3M6wyQmr4qmJcuJSAOSnv54MLSWfgVwk6
 q0MjvkVCLKGWp/NqCTEU7R+Xk1AlVMIymf41SN8QN99C2ljs9y503ckjI
 8GZPtYdcLZBm9tit07/RzY2sxlKi/PLWPuZqB6GCSZ+d7XNLGI7s6yxLf w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6875712"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6875712"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 23:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="854266397"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; d="scan'208";a="854266397"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2024 23:33:54 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 1/9] MAINTAINERS: Update hw/core/cpu.c entry
Date: Tue, 16 Jan 2024 15:46:39 +0800
Message-Id: <20240116074647.3644821-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116074647.3644821-1-zhao1.liu@linux.intel.com>
References: <20240116074647.3644821-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The hw/core/cpu.c was split as hw/core/cpu-common.c and
hw/core/cpu-sysemu.c in the commit df4fd7d5c8a3 ("cpu: Split as
cpu-common / cpu-sysemu").

Update the related entry.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b406fb20c059..529313eba27e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1867,7 +1867,8 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
 S: Supported
-F: hw/core/cpu.c
+F: hw/core/cpu-common.c
+F: hw/core/cpu-sysemu.c
 F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
 F: hw/core/machine-smp.c
-- 
2.34.1


