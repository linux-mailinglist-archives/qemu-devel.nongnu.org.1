Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EEB8324C1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 07:47:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQiea-00012b-9M; Fri, 19 Jan 2024 01:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rQieU-00012J-KJ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 01:46:54 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rQieS-0006R0-RZ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 01:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705646813; x=1737182813;
 h=message-id:date:mime-version:to:cc:from:subject:
 content-transfer-encoding;
 bh=3pOu2TlHLp4Gw1kuTw80hDfDipa9mQm3xsM62NhMzj0=;
 b=Hf3TOxzp/UlyWJsqbIxYpA8qc7LeN0Ztwv0Kn0dRlt39CD887jXon9iH
 2V8s/JgWJYkTry57oaP6N4vj9g/nvG21qnBouOiw0PZdX8zoqJmfzAIhu
 MSgt10bmn3gETwqhLHluWOed+LjmjfpVR+Cio9KtCE9uALb8PyCvwIWGy
 kFPT3cEL44pGZIKPGBvMAEvK8iCAkMENe34iRVlM8Iu6u2jYkCJ/5adTs
 ofNra0Jx2RHNWa03SwIW5WLXbsG0oixJyizYyQSQ8Cpi1n80aA77LFYeo
 7Nrkb0pA1uJ7aqk4uOGQpNIySsFCm0Ejxd2c5sWiv26AHIjqfelis4aZ4 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19259595"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; d="scan'208";a="19259595"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 22:46:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="500682"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.2.234])
 ([10.238.2.234])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 22:46:48 -0800
Message-ID: <825f29d7-9112-45a2-b4a3-7d3b54c3c0a2@intel.com>
Date: Fri, 19 Jan 2024 14:46:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lei Wang <lei4.wang@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Why invtsc (CPUID_APM_INVTSC) is unmigratable?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

I'm wondering why CPUID_APM_INVTSC is set as unmigratable_flags. Could 
anyone explain it?

When the host supports invtsc, it can be exposed to guest.
When the src VM has invtsc exposed, what will forbid it to be migrated 
to a dest that also supports VMs with invtsc exposed?

