Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF3769CCD
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVpm-0003YC-8t; Mon, 31 Jul 2023 12:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpk-0003Xc-PN
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:24 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpj-0001LE-87
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821203; x=1722357203;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pwuf6o/0F5t0zy4EgnbrfJ4zxZA0+H1hwL82VW6bQ/w=;
 b=iNB2Qf/Y9tkIsoaMMG0dbHfxX60K7H89N+ptIjOH3NhNggVYqBJzMqw8
 af/XJF+/mI5UqBIcm3NruaRxl7PniZu5+g+Ve4gPQby+4oOL8hRn2FPne
 9Bej/RoKe2NT8hwX5RYVbqWzbUz5Nt81qWVI1UC+4SGiO0p4eURldze1d
 lZVHI0BkprenCrLdHtJxj6dN5n+WF+OF9qrv8ZbqCqViVtijVXuEiTncj
 Y9+Z/8yFV4evHjWem5PUrPI+7RZvEAvIXevPCZ2Mq+0YexNMHb8HDyZK/
 kfgM7s430Bi2001uXaqH4Nz3bL2ySpOloMw1nNzZLOkAF05ZD1R2Fx1Iy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993522"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993522"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984290"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984290"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:42 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [RFC PATCH 12/19] i386/kvm: Set memory to default private for
 KVM_X86_SW_PROTECTED_VM
Date: Mon, 31 Jul 2023 12:21:54 -0400
Message-Id: <20230731162201.271114-13-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731162201.271114-1-xiaoyao.li@intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.126 (failed)
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index df3a5f89396e..a96640512dbc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2614,6 +2614,7 @@ static void kvm_x86_sw_protected_vm_region_add(MemoryListener *listenr,
             exit(1);
         }
         memory_region_set_gmem_fd(mr, fd);
+        memory_region_set_default_private(mr);
     }
 }
 
-- 
2.34.1


