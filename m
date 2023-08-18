Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7028E780D9D
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05h-0004sb-1Z; Fri, 18 Aug 2023 10:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwGU-0004pU-Eu
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:59:35 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwFj-0000Gh-Fc
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352727; x=1723888727;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n6J9qyA7Bfj5B8pEb9VtkWEigfZf2sgdu905dTUQSJY=;
 b=lxFhBZUgTdA9nGY00GAN9LgaKmg6DNY7Osj18oNzNb/oTZuiSzTSWMP9
 MNrQ2f+9AzUnmQ0t1+w8+B8Egoa6FuoZHkQiOyiSbGDkhBSpBERr18zZX
 XGsaYg+ihnDH+lG9Jk1ZBWMophgrgO5LlynX+cj+SnVxbqDw8b/NZx3IQ
 Z8b1q3AVP3PVXSQ0IxXMPYyOLxhXi3D+8Y05qQ6Q0KDYszC4jsJzwWeAP
 +uhDl4ldnBNXbvH91ge+74C/xLypD6gWTTl3Jfy3ikpR45Gh5XqtvViNE
 CmxWBaGiTTkBacb+VxuQCQen8rd3hBACffXiCuCIubSPge+TNwmUTMZVY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371966557"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371966557"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235429"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235429"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:57:39 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 xiaoyao.li@intel.com, Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v2 38/58] i386/tdx: Call KVM_TDX_INIT_VCPU to initialize TDX
 vcpu
Date: Fri, 18 Aug 2023 05:50:21 -0400
Message-Id: <20230818095041.1973309-39-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818095041.1973309-1-xiaoyao.li@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

TDX vcpu needs to be initialized by SEAMCALL(TDH.VP.INIT) and KVM
provides vcpu level IOCTL KVM_TDX_INIT_VCPU for it.

KVM_TDX_INIT_VCPU needs the address of the HOB as input. Invoke it for
each vcpu after HOB list is created.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/kvm/tdx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 5b688eb39327..2d0efca6787b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -578,6 +578,22 @@ static void tdx_init_ram_entries(void)
     tdx_guest->nr_ram_entries = j;
 }
 
+static void tdx_post_init_vcpus(void)
+{
+    TdxFirmwareEntry *hob;
+    CPUState *cpu;
+    int r;
+
+    hob = tdx_get_hob_entry(tdx_guest);
+    CPU_FOREACH(cpu) {
+        r = tdx_vcpu_ioctl(cpu, KVM_TDX_INIT_VCPU, 0, (void *)hob->address);
+        if (r < 0) {
+            error_report("KVM_TDX_INIT_VCPU failed %s", strerror(-r));
+            exit(1);
+        }
+    }
+}
+
 static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
@@ -610,6 +626,8 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
 
     tdvf_hob_create(tdx_guest, tdx_get_hob_entry(tdx_guest));
 
+    tdx_post_init_vcpus();
+
     for_each_tdx_fw_entry(tdvf, entry) {
         struct kvm_tdx_init_mem_region mem_region = {
             .source_addr = (__u64)entry->mem_ptr,
-- 
2.34.1


