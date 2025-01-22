Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D8FA18DD1
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 09:48:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taWNd-0002w1-F3; Wed, 22 Jan 2025 03:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taWNb-0002vQ-2S; Wed, 22 Jan 2025 03:46:31 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taWNY-0002y5-Uz; Wed, 22 Jan 2025 03:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737535589; x=1769071589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0Zj1pK2FHXf1BvAq4W768QzuPxnMz2DRuJqlcMCtTe0=;
 b=Z2z5fDBwbzDLPiFVpyWBtWaCijETEsFp4KYguP3Ywj4Y1SsSIOqnfcsA
 MYbigi9wIC6ra4eWGMaG/xJ79YTgRUMhOa2nIARa1iLZy8Q99fjXIrVPd
 /JSvNf72yaKm+ZEVQk1IHDlEmiDwSX1CBtk07c2bSBHHbqhYKyKRm7V5R
 mYA1p+8FeCGBG5X6rB7/Vr188zkHxGFGImzhleXZL3rhrlp0EW96yMRiq
 wOGk54L6gQnv86Cwjt848alAMaiPgUuu7GQRWeHBsDyU9wxFW38pfUp4e
 sqmcsVlrqyH8d086imRl+TedI/kWZFnGT+btDd3KfiBPck6rkJ6tVRo1J Q==;
X-CSE-ConnectionGUID: IFr8fyUSSYC9iptTIrqAxA==
X-CSE-MsgGUID: tsOPEmBVSlm1rshOZ53Ffw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="60451591"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="60451591"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 00:46:28 -0800
X-CSE-ConnectionGUID: 9iOaAaR8SoSnqJLZfdS3gg==
X-CSE-MsgGUID: WRTm5araTDWKtHiVkDMGcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="112049932"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 00:46:23 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 4/5] i386/kvm: Support event with masked entry format in KVM
 PMU filter
Date: Wed, 22 Jan 2025 17:05:16 +0800
Message-Id: <20250122090517.294083-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122090517.294083-1-zhao1.liu@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

KVM_SET_PMU_EVENT_FILTER of x86 KVM supports masked events mode, which
accepts masked entry format event to flexibly represent a group of PMU
events.

Support masked entry format in kvm-pmu-filter object and handle this in
i386 kvm codes.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC v1:
 * Bump up the supported QAPI version to 10.0.
---
 accel/kvm/kvm-pmu.c   | 91 +++++++++++++++++++++++++++++++++++++++++++
 qapi/kvm.json         | 68 ++++++++++++++++++++++++++++++--
 target/i386/kvm/kvm.c | 39 +++++++++++++++++++
 3 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
index cbd32e8e21f8..9d68cd15e477 100644
--- a/accel/kvm/kvm-pmu.c
+++ b/accel/kvm/kvm-pmu.c
@@ -62,6 +62,16 @@ static void kvm_pmu_filter_get_event(Object *obj, Visitor *v, const char *name,
             str_event->u.x86_default.umask =
                 g_strdup_printf("0x%x", event->u.x86_default.umask);
             break;
+        case KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY:
+            str_event->u.x86_masked_entry.select =
+                g_strdup_printf("0x%x", event->u.x86_masked_entry.select);
+            str_event->u.x86_masked_entry.match =
+                g_strdup_printf("0x%x", event->u.x86_masked_entry.match);
+            str_event->u.x86_masked_entry.mask =
+                g_strdup_printf("0x%x", event->u.x86_masked_entry.mask);
+            str_event->u.x86_masked_entry.exclude =
+                event->u.x86_masked_entry.exclude;
+            break;
         default:
             g_assert_not_reached();
         }
@@ -160,6 +170,87 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
             event->u.x86_default.umask = umask;
             break;
         }
+        case KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY: {
+            uint64_t select, match, mask;
+
+            ret = qemu_strtou64(str_event->u.x86_masked_entry.select,
+                                NULL, 0, &select);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Invalid %s PMU event (select: %s): %s. "
+                           "The select must be a "
+                           "12-bit unsigned number string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_masked_entry.select,
+                           strerror(-ret));
+                g_free(event);
+                goto fail;
+            }
+            if (select > UINT12_MAX) {
+                error_setg(errp,
+                           "Invalid %s PMU event (select: %s): "
+                           "Numerical result out of range. "
+                           "The select must be a "
+                           "12-bit unsigned number string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_masked_entry.select);
+                g_free(event);
+                goto fail;
+            }
+            event->u.x86_masked_entry.select = select;
+
+            ret = qemu_strtou64(str_event->u.x86_masked_entry.match,
+                                NULL, 0, &match);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Invalid %s PMU event (match: %s): %s. "
+                           "The match must be a uint8 string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_masked_entry.match,
+                           strerror(-ret));
+                g_free(event);
+                goto fail;
+            }
+            if (match > UINT8_MAX) {
+                error_setg(errp,
+                           "Invalid %s PMU event (match: %s): "
+                           "Numerical result out of range. "
+                           "The match must be a uint8 string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_masked_entry.match);
+                g_free(event);
+                goto fail;
+            }
+            event->u.x86_masked_entry.match = match;
+
+            ret = qemu_strtou64(str_event->u.x86_masked_entry.mask,
+                                NULL, 0, &mask);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Invalid %s PMU event (mask: %s): %s. "
+                           "The mask must be a uint8 string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_masked_entry.mask,
+                           strerror(-ret));
+                g_free(event);
+                goto fail;
+            }
+            if (mask > UINT8_MAX) {
+                error_setg(errp,
+                           "Invalid %s PMU event (mask: %s): "
+                           "Numerical result out of range. "
+                           "The mask must be a uint8 string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_masked_entry.mask);
+                g_free(event);
+                goto fail;
+            }
+            event->u.x86_masked_entry.mask = mask;
+
+            event->u.x86_masked_entry.exclude =
+                str_event->u.x86_masked_entry.exclude;
+            break;
+        }
         default:
             g_assert_not_reached();
         }
diff --git a/qapi/kvm.json b/qapi/kvm.json
index 93b869e3f90c..a673e499e7ea 100644
--- a/qapi/kvm.json
+++ b/qapi/kvm.json
@@ -29,11 +29,14 @@
 #
 # @x86-default: standard x86 encoding format with select and umask.
 #
+# @x86-masked-entry: KVM's masked entry format for x86, which could
+#                    mask bunch of events.
+#
 # Since 10.0
 ##
 { 'enum': 'KVMPMUEventEncodeFmt',
   'prefix': 'KVM_PMU_EVENT_FMT',
-  'data': ['raw', 'x86-default'] }
+  'data': ['raw', 'x86-default', 'x86-masked-entry'] }
 
 ##
 # @KVMPMURawEvent:
@@ -67,6 +70,40 @@
   'data': { 'select': 'uint16',
             'umask': 'uint8' } }
 
+##
+# @KVMPMUX86MaskedEntry:
+#
+# x86 PMU events encoding in KVM masked entry format.
+#
+# Encoding layout:
+# Bits   Description
+# ----   -----------
+# 7:0    event select (low bits)
+# 15:8   (umask) match
+# 31:16  unused
+# 35:32  event select (high bits)
+# 36:54  unused
+# 55     exclude bit
+# 63:56  (umask) mask
+#
+# Events are selected by (umask & mask == match)
+#
+# @select: x86 PMU event select, which is a 12-bit unsigned number.
+#
+# @match: umask match.
+#
+# @mask: umask mask.
+#
+# @exclude: Whether the matched events are excluded.
+#
+# Since 10.0
+##
+{ 'struct': 'KVMPMUX86MaskedEntry',
+  'data': { 'select': 'uint16',
+            'match': 'uint8',
+            'mask': 'uint8',
+            'exclude': 'bool' } }
+
 ##
 # @KVMPMUFilterEvent:
 #
@@ -80,7 +117,8 @@
   'base': { 'format': 'KVMPMUEventEncodeFmt' },
   'discriminator': 'format',
   'data': { 'raw': 'KVMPMURawEvent',
-            'x86-default': 'KVMPMUX86DefalutEvent' } }
+            'x86-default': 'KVMPMUX86DefalutEvent',
+            'x86-masked-entry': 'KVMPMUX86MaskedEntry' } }
 
 ##
 # @KVMPMUFilterProperty:
@@ -125,6 +163,29 @@
   'data': { 'select': 'str',
             'umask': 'str' } }
 
+##
+# @KVMPMUX86MaskedEntryVariant:
+#
+# The variant of KVMPMUX86MaskedEntry with the string, rather than
+# the numeric value.
+#
+# @select: x86 PMU event select.  This field is a 12-bit unsigned
+#     number string.
+#
+# @match: umask match.  This field is a uint8 string.
+#
+# @mask: umask mask.  This field is a uint8 string.
+#
+# @exclude: Whether the matched events are excluded.
+#
+# Since 10.0
+##
+{ 'struct': 'KVMPMUX86MaskedEntryVariant',
+  'data': { 'select': 'str',
+            'match': 'str',
+            'mask': 'str',
+            'exclude': 'bool' } }
+
 ##
 # @KVMPMUFilterEventVariant:
 #
@@ -138,7 +199,8 @@
   'base': { 'format': 'KVMPMUEventEncodeFmt' },
   'discriminator': 'format',
   'data': { 'raw': 'KVMPMURawEventVariant',
-            'x86-default': 'KVMPMUX86DefalutEventVariant' } }
+            'x86-default': 'KVMPMUX86DefalutEventVariant',
+            'x86-masked-entry': 'KVMPMUX86MaskedEntryVariant' } }
 
 ##
 # @KVMPMUFilterPropertyVariant:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index bab58761417a..97b94c331271 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5974,6 +5974,13 @@ static bool kvm_config_pmu_event(KVMPMUFilter *filter,
             code = X86_PMU_RAW_EVENT(event->u.x86_default.select,
                                      event->u.x86_default.umask);
             break;
+        case KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY:
+            code = KVM_PMU_ENCODE_MASKED_ENTRY(
+                       event->u.x86_masked_entry.select,
+                       event->u.x86_masked_entry.mask,
+                       event->u.x86_masked_entry.match,
+                       event->u.x86_masked_entry.exclude ? 1 : 0);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -6005,6 +6012,21 @@ static int kvm_install_pmu_event_filter(KVMState *s)
         g_assert_not_reached();
     }
 
+    /*
+     * The check in kvm_arch_check_pmu_filter() ensures masked entry
+     * format won't be mixed with other formats.
+     */
+    kvm_filter->flags = filter->events->value->format ==
+                        KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY ?
+                        KVM_PMU_EVENT_FLAG_MASKED_EVENTS : 0;
+
+    if (kvm_filter->flags == KVM_PMU_EVENT_FLAG_MASKED_EVENTS &&
+        !kvm_vm_check_extension(s, KVM_CAP_PMU_EVENT_MASKED_EVENTS)) {
+        error_report("Masked entry format of PMU event "
+                     "is not supported by Host.");
+        goto fail;
+    }
+
     if (!kvm_config_pmu_event(filter, kvm_filter)) {
         goto fail;
     }
@@ -6632,6 +6654,7 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
 {
     KVMPMUFilter *filter = KVM_PMU_FILTER(child);
     KVMPMUFilterEventList *events = filter->events;
+    uint32_t base_flag;
 
     if (!filter->nevents) {
         error_setg(errp,
@@ -6639,12 +6662,21 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
         return;
     }
 
+    /* Pick the first event's flag as the base one. */
+    base_flag = events->value->format ==
+                KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY ?
+                KVM_PMU_EVENT_FLAG_MASKED_EVENTS : 0;
     while (events) {
         KVMPMUFilterEvent *event = events->value;
+        uint32_t flag;
 
         switch (event->format) {
         case KVM_PMU_EVENT_FMT_RAW:
         case KVM_PMU_EVENT_FMT_X86_DEFAULT:
+            flag = 0;
+            break;
+        case KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY:
+            flag = KVM_PMU_EVENT_FLAG_MASKED_EVENTS;
             break;
         default:
             error_setg(errp,
@@ -6653,6 +6685,13 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
             return;
         }
 
+        if (flag != base_flag) {
+            error_setg(errp,
+                       "Masked entry format cannot be mixed with "
+                       "other formats.");
+            return;
+        }
+
         events = events->next;
     }
 }
-- 
2.34.1


