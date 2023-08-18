Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6046F780944
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 12:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwCn-000533-1m; Fri, 18 Aug 2023 05:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwCl-0004ua-IP
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:55:43 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwCg-0007qx-QX
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352539; x=1723888539;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nVYcIdwdyKkgGNLz8MQrbz4I0Memc1hrI+C+lv2rwrM=;
 b=Tom3jlCPLp/s82ASTsNhxjnWdyuziEDtapS1L5UckuYBAllfdbTRZ+1t
 pmAJR6F3PUaH0DRIAcOxHIIWrBq7krp3v4jiIJaHHN5FYbC/1Auml2DqI
 KImWYRF89KoKVlN5Unh4fIl6WcVVHqKddFv+g7PsX/BNgUSFIKolGP9bO
 nZedW0Nl0xjtjugD5BWm5W8YtEGSpxjlj8/cDPlSBdxpIWR+1mS59jgBP
 gaf0MnBmKtHJ9tM23/us17lQi2rhYgiCp3RdGY4hsex2/cbwiePa8vMsJ
 QeUDlcPrAQhktfC2u98htD1jmkCCBG3DLVgBp1KkpbA62zmBETkjKTLUF g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371965756"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371965756"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849234853"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849234853"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:55:08 -0700
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
Subject: [PATCH v2 09/58] i386/tdx: Update tdx_cpuid_lookup[].tdx_fixed0/1 by
 tdx_caps.cpuid_config[]
Date: Fri, 18 Aug 2023 05:49:52 -0400
Message-Id: <20230818095041.1973309-10-xiaoyao.li@intel.com>
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

tdx_cpuid_lookup[].tdx_fixed0/1 is QEMU maintained data which reflects
TDX restrictions regrading how some CPUIDs are virtualized by TDX.

It's retrieved from TDX spec. However, TDX may change some fixed
fields to configurable in the future. Update
tdx_cpuid.lookup[].tdx_fixed0/1 fields by removing the bits that
reported from TDX module as configurable. This can adapt with the
updated TDX (module) automatically.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 3198bc9fd5fb..4518c79aecc8 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -369,6 +369,34 @@ static void get_tdx_capabilities(void)
     tdx_caps = caps;
 }
 
+static void update_tdx_cpuid_lookup_by_tdx_caps(void)
+{
+    KvmTdxCpuidLookup *entry;
+    FeatureWordInfo *fi;
+    uint32_t config;
+    FeatureWord w;
+
+    /*
+     * Patch tdx_fixed0/1 by tdx_caps that what TDX module reports as
+     * configurable is not fixed.
+     */
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        fi = &feature_word_info[w];
+        entry = &tdx_cpuid_lookup[w];
+
+        if (fi->type != CPUID_FEATURE_WORD) {
+            continue;
+        }
+
+        config = tdx_cap_cpuid_config(fi->cpuid.eax,
+                                      fi->cpuid.needs_ecx ? fi->cpuid.ecx : ~0u,
+                                      fi->cpuid.reg);
+
+        entry->tdx_fixed0 &= ~config;
+        entry->tdx_fixed1 &= ~config;
+    }
+}
+
 int tdx_kvm_init(MachineState *ms, Error **errp)
 {
     TdxGuest *tdx = (TdxGuest *)object_dynamic_cast(OBJECT(ms->cgs),
@@ -378,6 +406,8 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
         get_tdx_capabilities();
     }
 
+    update_tdx_cpuid_lookup_by_tdx_caps();
+
     tdx_guest = tdx;
 
     return 0;
-- 
2.34.1


