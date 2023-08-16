Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216C77DBA5
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 10:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWBW7-0007Pq-0H; Wed, 16 Aug 2023 04:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qWBW1-0007PE-0S
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 04:04:29 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qWBVx-0008LP-7G
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 04:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692173065; x=1723709065;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Au+n1jD6aC77wN2D+CQqGqThM9CEtJEwH0a/7m9E0dk=;
 b=iw13FjkaMP/A2oX8bFcrFgCc4s1W1GSWjHHHRrPW/Cwre1vMtsqzdGYr
 jCl7ANrdYiaYXCPZFiULsEvhDBhZOXf35JgfiBawsVvtpaxulMaSIIWd4
 GGtWel51rx0rSDkrFA8/YiaEz/xcQk87P4WKR9ZDhwphO43yssgUV/sw/
 kh9PYNHERfwS7VR3vkQHZb/ePy/v+5uzq70yR8CZx4jk7GTh5VcZ2uYOK
 vMyMWby60kCOcFZ2WuCdpc5+v7w6mhPzl2IjpPkZjSBJ15BHFhsJHFVsl
 30Meh9KJ4v/2BhOq6Jyf/un/q21X3VUKvAhvZjXOqvASh7lzfu1MIRSft A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403450814"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; d="scan'208";a="403450814"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 01:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711035453"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; d="scan'208";a="711035453"
Received: from pc.sh.intel.com ([10.238.200.75])
 by orsmga006.jf.intel.com with ESMTP; 16 Aug 2023 01:04:18 -0700
From: Qian Wen <qian.wen@intel.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, babu.moger@amd.com,
 Qian Wen <qian.wen@intel.com>
Subject: [PATCH v3 0/2] Fix overflow of the max number of IDs for logic
 processor and core
Date: Wed, 16 Aug 2023 16:06:56 +0800
Message-Id: <20230816080658.3562730-1-qian.wen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CPUID.1.EBX[23:16]: Maximum number of addressable IDs for logical
processors in this physical package.
CPUID.4:EAX[31:26]: Maximum number of addressable IDs for processor cores
in the physical package.

The current qemu code doesn't limit the value written to these two fields.
If the guest has a huge number of cores, APs (application processor) will
fail to bring up and the wrong info will be reported.
According to HW behavior, setting max value written to CPUID.1.EBX[23:16]
to 255, and CPUID.4:EAX[31:26] to 63.

---
Changes v2 -> v3:
  - Add patch 2.
  - Revise the commit message and comment to be clearer.
  - Using MIN() for limitation.
Changes v1 -> v2:
  - Revise the commit message and comment to more clearer.
  - Rebased to v8.1.0-rc2.

Qian Wen (2):
  target/i386: Avoid cpu number overflow in legacy topology
  target/i386: Avoid overflow of the cache parameter enumerated by leaf 4

 target/i386/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

base-commit: 0d52116fd82cdd1f4a88837336af5b6290c364a4
-- 
2.25.1


