Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE564707834
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 04:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzTev-0005Df-Vh; Wed, 17 May 2023 22:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTeb-0005Ad-54
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:09 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTeV-0008FG-Eg
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684377963; x=1715913963;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=ALosJLPeK/xQ//Ur5NIceXWhZEbxkQaR0DQfbRf0RQM=;
 b=EntQMmvDMkFfZkvoONi+zI2I1j1ZQoWPrW3nC0NizOhllgKbpZ0+UE7L
 VVcf808VsiYI68AeiFtu0kSOFCW1JvKbUCq1tQMBUJclP9hziBLpDryA5
 IYFAdM4mgOi3M1aSYeIHHv0BUdcmWXkPS4KWm6lcM7vgqkQM9EaK3iH6x
 n2N6heh1yYxdVZDem6IfmjlO7wqowFtvKD9rGE9IO8GcJRgJH8aIFmCtH
 ZOggz80+0IU6q3L/Vdm1Uoq+0Dk2SwMJ7RDHNqnJ08AxUtYB3l6/i7q2D
 H+2Ni3IKim1zTBfPRxtm/g11N9aOYhY6by63TkBVUI0zcj2G3NmQNEiH4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147094"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="380147094"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466710"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="652466710"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost)
 ([10.209.143.168])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:45:59 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 17 May 2023 19:45:54 -0700
Subject: [PATCH RFC 1/5] hw/cxl: Use define for build bug detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-rfc-type2-dev-v1-1-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=1245;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=ALosJLPeK/xQ//Ur5NIceXWhZEbxkQaR0DQfbRf0RQM=;
 b=PTXLvgQFzxf6kFAXs/JRAWGbNfCHUPHulVnutVi+rrKIFhXkSG47HH5dDRPWhMLgGJcr8nGGR
 KT5/B7ZTijJDdHPdhFyfIS7WU2ze14Xt2rLktKwvF3c8GLqVY5beLQx
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Received-SPF: pass client-ip=192.55.52.88; envelope-from=ira.weiny@intel.com;
 helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Magic numbers can be confusing.

Use the range size define for CXL.cachemem rather than a magic number.
Update/add spec references.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/hw/cxl/cxl_component.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 52b6a2d67f40..bca2b756c202 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -10,7 +10,7 @@
 #ifndef CXL_COMPONENT_H
 #define CXL_COMPONENT_H
 
-/* CXL 2.0 - 8.2.4 */
+/* CXL 3.0 - 8.2.3 */
 #define CXL2_COMPONENT_IO_REGION_SIZE 0x1000
 #define CXL2_COMPONENT_CM_REGION_SIZE 0x1000
 #define CXL2_COMPONENT_BLOCK_SIZE 0x10000
@@ -173,7 +173,9 @@ HDM_DECODER_INIT(3);
     (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
 #define CXL_SNOOP_REGISTERS_SIZE   0x8
 
-QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
+/* CXL 3.0 8.2.3 Table 8-21 */
+QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
+                    CXL_SNOOP_REGISTERS_SIZE) >= CXL2_COMPONENT_CM_REGION_SIZE,
                    "No space for registers");
 
 typedef struct component_registers {

-- 
2.40.0


