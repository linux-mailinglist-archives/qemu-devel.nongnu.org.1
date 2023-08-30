Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C078D785
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNsf-0004lY-95; Wed, 30 Aug 2023 12:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=599fd62c5=graf@amazon.de>)
 id 1qbNqg-0003J5-7G; Wed, 30 Aug 2023 12:15:18 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=599fd62c5=graf@amazon.de>)
 id 1qbNqd-0003sd-Qo; Wed, 30 Aug 2023 12:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1693412115; x=1724948115;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fULBujyPlQf2dUsEIaA2XAQI1K5vJQP8bEkwjEx3xeE=;
 b=OoInMejkNgaRX/1/3ksUfrV6AtHyL0dq02GF4i8tDa8iuQ6QiL/jRqhz
 5NepIavhez3CIiv/j9RKz6xXX5EMUL/hTRZrW3wZGYy1YYo8hv6xzf6Lk
 Swe3XKdCJnFHKDdGo6cMPc12F6PNNBL/knRlSP1JbdRRLJWxxjDEnV+mx w=;
X-IronPort-AV: E=Sophos;i="6.02,214,1688428800"; d="scan'208";a="1151585335"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com)
 ([10.25.36.210]) by smtp-border-fw-9103.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 16:14:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix)
 with ESMTPS id 4559080EB2; Wed, 30 Aug 2023 16:14:40 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 16:14:39 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 16:14:36 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>, Cameron Esfahani
 <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Mads Ynddal
 <mads@ynddal.dk>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Subject: [PATCH v2 03/12] hvf: Increase number of possible memory slots
Date: Wed, 30 Aug 2023 16:14:16 +0000
Message-ID: <20230830161425.91946-4-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230830161425.91946-1-graf@amazon.com>
References: <20230830161425.91946-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.171.188.200;
 envelope-from=prvs=599fd62c5=graf@amazon.de; helo=smtp-fw-9103.amazon.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

For PVG we will need more than the current 32 possible memory slots.
Bump the limit to 512 instead.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Move max slot number to define
---
 include/sysemu/hvf_int.h  | 4 +++-
 accel/hvf/hvf-accel-ops.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 718beddcdd..36aa9b4eff 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -17,6 +17,8 @@
 #include <Hypervisor/hv.h>
 #endif
 
+#define HVF_MAX_SLOTS 512
+
 /* hvf_slot flags */
 #define HVF_SLOT_LOG (1 << 0)
 
@@ -40,7 +42,7 @@ typedef struct hvf_vcpu_caps {
 
 struct HVFState {
     AccelState parent;
-    hvf_slot slots[32];
+    hvf_slot slots[HVF_MAX_SLOTS];
     int num_slots;
 
     hvf_vcpu_caps *hvf_caps;
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3c94c79747..7aee0d6f72 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -88,7 +88,7 @@ struct mac_slot {
     uint64_t gva;
 };
 
-struct mac_slot mac_slots[32];
+struct mac_slot mac_slots[HVF_MAX_SLOTS];
 
 static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
 {
-- 
2.39.2 (Apple Git-143)




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




