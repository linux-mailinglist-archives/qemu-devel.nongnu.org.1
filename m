Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FD765577
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP1H6-00062D-Os; Thu, 27 Jul 2023 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qOvVq-0005en-Ug
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:34:19 -0400
Received: from [192.55.52.136] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qOvVo-0004N7-SA
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690443256; x=1721979256;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CZ8gg+nNa89wYr9lWV4ihNg7W4Q9OKWDXIZ3tzCFFlM=;
 b=VytJjy4mWwngJY3rHu4Z9K4zbKT+PIsu6cKHKEIprB2FADMhzI0imCgY
 Rq+spbObn/WXFBENBmOuJP9Tjb4VhL7VI2rJijI5DDNFQei2mNCR5a4sz
 kUqt+UYZdmtB5L1iigOEi0HsjTpe5sb1BVPqMbyUXBQ2ahyu8p46Qq1w6
 KY+HZMDP0T21VfZ1EGASRzhRKHLs+Pl3LsywQdzr//gZadMe5AdJYsFcM
 vXWhkW1VVo9JQ5+/CQV2FG2bu4aDTY3JzjqABH1jfdHJ19WVioJV7o7aI
 HFmrCBiuJAg1XWqE8huOUAlHVhJkBYeuJyAtSVUivEkmveEarmrwaCW3/ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347842866"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; d="scan'208";a="347842866"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2023 00:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756547365"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; d="scan'208";a="756547365"
Received: from vmmteam.bj.intel.com ([10.240.192.110])
 by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 00:24:13 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com
Subject: [PATCH RFC v1 0/3] Support dynamic MSI-X allocation
Date: Thu, 27 Jul 2023 03:24:07 -0400
Message-Id: <20230727072410.135743-1-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.136 (failed)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Jul 2023 09:43:26 -0400
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

Before kernel v6.5, dynamic allocation of MSI-X interrupts was not
supported. Qemu therefore when allocating a new interrupt, should first
release all previously allocated interrupts (including disable of MSI-X)
and re-allocate all interrupts that includes the new one.

The kernel series [1] adds the support of dynamic MSI-X allocation to
vfio-pci and uses the existing flag VFIO_IRQ_INFO_NORESIZE to guide user
space, that when dynamic MSI-X is supported the flag is cleared.

This series makes the behavior for VFIO PCI devices when dynamic MSI-X
allocation is supported. When guest unmasks an interrupt, Qemu can
directly allocate an interrupt on host for this and has nothing to do
with the previously allocated ones. Therefore, host only allocates
interrupts for those unmasked (enabled) interrupts inside guest when
dynamic MSI-X allocation is supported by device.

During migration restore, Qemu calls vfio_enable_vectors() to enable
MSI-X and interrupts. Since the API causes that a number of irqs set to
host kernel are all allocated when enabling MSI-X, to avoid this, one
possible way is that Qemu first sets vector 0 to host kernel to enable
MSI-X with an invalid fd. After MSI-X enabling, the API can decide which
should be allocated via the event fd value. In this way, the interrupts
allocation on target would be the same as migration source.

Jing Liu (2):
  vfio/pci: enable vector on dynamic MSI-X allocation
  vfio/pci: dynamic MSI-X allocation in interrupt restoring

Reinette Chatre (1):
  vfio/pci: detect the support of dynamic MSI-X allocation

 hw/vfio/pci.c        | 84 +++++++++++++++++++++++++++++++++++++-------
 hw/vfio/pci.h        |  1 +
 hw/vfio/trace-events |  2 ++
 3 files changed, 74 insertions(+), 13 deletions(-)

-- 
2.27.0


