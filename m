Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBAC82D59E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:14:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJ2L-0002io-DZ; Mon, 15 Jan 2024 04:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPJ2D-0002bi-K8
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:13:33 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPJ2B-0003eA-Qw
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705310012; x=1736846012;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cPTFTjHYeztJDEtqEZptetatSBNJ9F8NjdrBTb2oE88=;
 b=I45jVrR281IJLEH4MGnc0gaialLD5IRnf/rTKpLaS4T6Gkr5X3gGHo8Q
 HOhuIxO6X+eeRwsJYwChZ8kF60u2laUxzArem0nM72LNY5n3HM1olLdfp
 ogMQtWOK/GJDTSUxqsZJ3e3eQOSS4vjdR7l3Pluk3mjgMDLf13knrzAJo
 S35q8N1wRoQAkC3lyosFvzDXMhmhX4mObz4OlSCxB7BHhAMl9uLirQVdP
 JTX11NR08HTxaTQ6Qwnss/Zvvj+spJpPi+l8YZFgdLn4pAKjolmobIpFL
 9xv3Q+zr2S9Qhk0rs6jr+e/Wfp5dLtWxukSpCQQ11ps6a4Zemjy/r5eol Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="12928485"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="12928485"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 01:13:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="902720568"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="902720568"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2024 01:13:26 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH 0/2] i386/cpu: Two minor fixes for
 x86_cpu_enable_xsave_components()
Date: Mon, 15 Jan 2024 04:13:23 -0500
Message-Id: <20240115091325.1904229-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, SPF_HELO_NONE=0.001,
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

The two bugs were introduced when xsaves feature was added by commit
301e90675c3f ("target/i386: Enable support for XSAVES based features").

Xiaoyao Li (2):
  i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when CPUID_EXT_XSAVE is not
    available
  i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI and
    FEAT_XSAVE_XSS_HI leafs

 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.34.1


