Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA8707832
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 04:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzTec-0005BD-WB; Wed, 17 May 2023 22:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTeZ-0005A7-R5
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:07 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTeU-0008F5-L3
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684377962; x=1715913962;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=qnWfb9hkooDpADyTqUEyDgZ2+WuSlil5+fqo5AwuI5M=;
 b=iBQkcXUuxLMVnhe49jU78UdnK2apdEXW/rJbzMtEYfNi0WdgLyZ3Mhe8
 FRGI06t8S9oWLIO2JP8Nw8kKdm6MMpvP5X98P58Cy9O0dFVcCpNQiBFsg
 J4DOWeNwg4rKmg/tOA9wgf8o2V0SWjAXkesGtOScj2SsksTSgzhD1pN4P
 a+acnNI7ntYUmG02DrxUIZliFUceoLrDFHEu8Zq5gHND+Prk9K+ikftEe
 dmmo5qTHSsBYrGcVcCBp2XZUy7rRRoO1YtuXE1gwePhx6oIJRKu7E4Xmx
 U9pqoLvyZSSsSj7vi3atBudA0ujNHNJ+WG2Bke6THtwJSmYOH+P9GYOsz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147083"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="380147083"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466703"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="652466703"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost)
 ([10.209.143.168])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:45:57 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
Date: Wed, 17 May 2023 19:45:53 -0700
Message-Id: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGRZWQC/x2NQQrCMBAAv1L27NJmtZF6FXyAV/GwSTY2oLEkW
 pTSv5t4HJhhFsiSgmQ4NAskmUMOz1hAbRqwI8ebYHCFgTradr3aY/IWX99JCJ3MaMlprZgGN2g
 ojeEsaBJHO9bK7FonHuuD7xjfj+pMSXz4/J8XOJ+OcF3XH6fHoJeIAAAA
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=1747;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=qnWfb9hkooDpADyTqUEyDgZ2+WuSlil5+fqo5AwuI5M=;
 b=6oT1KtD5b4/SFfQBd1NDLYZ2CM9xW4vAc340QFuWUMHD+FjqmjIFvtkNiNNGAzkBXc+O8veKR
 0Zzcls8SX0rAtPIvXplaRy0hEG4leNVeB1wdMG/tliFJXmFp1BiK/Vx
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

Type 2 devices are not yet a reality.  Developing core kernel support
is difficult without some test device to model against.

Define a type 2 device 'cxl-accel'.  This device is derived from the
type 3 device and retains all that functionality for now.

Mock up a couple of accelerator features (Back Invalidate [BI] and
Unordered IO [UIO]) as examples for the RFC.  These have no
functionality other than to report the features as present for software
to key off of.

Defining these devices in qemu can be done with the following example:

...
  -device cxl-accel,bus=sw0p0,volatile-memdev=cxl-ac-mem5,id=cxl-dev5,sn=0xCAFE0005
...

NOTE: I'm leaving off Michael Tsirkin for now because this is really
rough and I'm mainly sending it out because it was talked about in the
CXL community call on 5/16.

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (5):
      hw/cxl: Use define for build bug detection
      hw/cxl: Refactor component register initialization
      hw/cxl: Derive a CXL accelerator device from Type-3
      hw/cxl/accel: Add Back-Invalidate decoder capbility structure
      hw/cxl: Add UIO HDM decoder register fields

 docs/system/devices/cxl.rst    | 11 ++++++
 hw/cxl/cxl-component-utils.c   | 80 +++++++++++++++++++-----------------------
 hw/mem/cxl_type3.c             | 39 ++++++++++++++++++++
 include/hw/cxl/cxl_component.h | 51 +++++++++++++++++++--------
 include/hw/cxl/cxl_device.h    | 16 +++++++++
 include/hw/pci/pci_ids.h       |  1 +
 6 files changed, 141 insertions(+), 57 deletions(-)
---
base-commit: 8eb2a03258313f404ca0c8609a8f9009b9b4318c
change-id: 20230517-rfc-type2-dev-c2d661a29d96

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


