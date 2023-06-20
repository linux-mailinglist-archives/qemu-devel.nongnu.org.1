Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7207B73721C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeZU-0003aS-Ro; Tue, 20 Jun 2023 12:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1qBeZP-0003ZD-7h
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:07 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1qBeZJ-000542-BR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687279861; x=1718815861;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Rj80g4SpcaK+O5Lyev0GdIQ3Ow+U6i9UoPUwFBN8IhM=;
 b=aPtP2egbLRym6OZ93or+xBea0C/FBycKiCLT95oe8SVtdfVnko2B0Tx0
 NpQavr4k7W0RW82/PYXFrx6VB+j9buzwpZ6lbExmFmyW7jVqM8ff3OtO0
 jfrZ47Eg+Cdbr6P0/Ip9e54MMoo8Sq2lZm24VguJXFK/a4DM5m9M/L748
 HRwUL5nWUfyFAlWhrhAifnE9RnsG+uBVbo0oV6OVli2KyUNuv+AhiWgee
 9eU34O3DdXV2J5yGLWI5yz5mNDf/iPj/Z1wr06e/fwq9ztAtSvyKALCdR
 V8ErG49754DuIwp4ZIuxHawa5S+mgXfrGKQyw6GGv7PAPO1VOw9IXEWsG A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389218029"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; d="scan'208";a="389218029"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 09:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691499954"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; d="scan'208";a="691499954"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 09:50:55 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 0/3] Add symbols for memory listener priority
Date: Tue, 20 Jun 2023 09:50:46 -0700
Message-Id: <cover.1687279702.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=isaku.yamahata@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The hard-coded value, 10, is used for memory_listener_register().  Add symbolic
values for priority of struct MemoryLister.  Replace those hard-coded values
with symbols.

The background is KVM guest memory[1] or TDX support.  I'd like to add one more
memory listener whose priority is higher than the KVM memory listener.  And I
don't want to hard-code 10 + 1.

[1] KVM gmem patches
https://github.com/sean-jc/linux/tree/x86/kvm_gmem_solo

Isaku Yamahata (3):
  exec/memory: Add symbolic value for memory listener priority for accel
  exec/memory: Add symbol for memory listener priority for dev backend
  exec/memory: Add symbol for the min value of memory listener priority

 accel/hvf/hvf-accel-ops.c         | 2 +-
 accel/kvm/kvm-all.c               | 5 +++--
 hw/arm/xen_arm.c                  | 2 +-
 hw/i386/xen/xen-hvm.c             | 2 +-
 hw/remote/proxy-memory-listener.c | 2 +-
 hw/virtio/vhost.c                 | 2 +-
 hw/xen/xen-hvm-common.c           | 2 +-
 hw/xen/xen_pt.c                   | 4 ++--
 include/exec/memory.h             | 4 ++++
 target/arm/kvm.c                  | 1 +
 target/i386/hax/hax-mem.c         | 2 +-
 target/i386/nvmm/nvmm-all.c       | 2 +-
 target/i386/whpx/whpx-all.c       | 2 +-
 13 files changed, 19 insertions(+), 13 deletions(-)


base-commit: cab35c73be9d579db105ef73fa8a60728a890098
-- 
2.25.1


