Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4DBF6EE4
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 15:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCs6-0000F1-Rc; Tue, 21 Oct 2025 09:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs0-0000DI-Mi
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCry-0007wi-DZ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LASpbnvht/YRs8V6TqUYEzVhvHS/fJVgPnoGaPTlRA=;
 b=WxJ2qdT64cdhue3q9jRsHeotu8/VLR1E+wdXdd9suuFmVxk9D9yFTvSV0nbiS4vxoYkOlp
 5tWtZ1Rj+VGijBXYM1HgMmPTmqUH34R40fsbh2shnGQHoLJO+4LN+4RoEgw/G6E+L+C1rp
 bV6UBy71cgRunDLoJcEt4Ieo23E1iek=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519--2jaLvmdMDKuUkIuQ0NSQA-1; Tue,
 21 Oct 2025 09:57:41 -0400
X-MC-Unique: -2jaLvmdMDKuUkIuQ0NSQA-1
X-Mimecast-MFC-AGG-ID: -2jaLvmdMDKuUkIuQ0NSQA_1761055060
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC4CD1956050; Tue, 21 Oct 2025 13:57:39 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DFD419560A2; Tue, 21 Oct 2025 13:57:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PULL 1/6] qapi/machine-s390x: add QAPI event SCLP_CPI_INFO_AVAILABLE
Date: Tue, 21 Oct 2025 15:57:30 +0200
Message-ID: <20251021135735.96145-2-thuth@redhat.com>
In-Reply-To: <20251021135735.96145-1-thuth@redhat.com>
References: <20251021135735.96145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>

Add QAPI event SCLP_CPI_INFO_AVAILABLE to notify the availability
of Control-Program Identification data in QOM.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251016121708.334133-1-shalini@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/machine-s390x.json | 21 +++++++++++++++++++++
 hw/s390x/sclpcpi.c      |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 966dbd61d2e..8412668b671 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -119,3 +119,24 @@
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
   'features': [ 'unstable' ]
 }
+
+##
+# @SCLP_CPI_INFO_AVAILABLE:
+#
+# Emitted when the Control-Program Identification data is available
+# in the QOM tree.
+#
+# Features:
+#
+# @unstable: This event is experimental.
+#
+# Since: 10.2
+#
+# .. qmp-example::
+#
+#     <- { "event": "SCLP_CPI_INFO_AVAILABLE",
+#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+##
+{ 'event': 'SCLP_CPI_INFO_AVAILABLE',
+  'features': [ 'unstable' ]
+}
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 7aa039d5100..68fc1b809bf 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -54,6 +54,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/ebcdic.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-events-machine-s390x.h"
 #include "migration/vmstate.h"
 
 typedef struct Data {
@@ -106,6 +107,9 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
     e->timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
 
     cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
+
+    qapi_event_send_sclp_cpi_info_available();
+
     return SCLP_RC_NORMAL_COMPLETION;
 }
 
-- 
2.51.0


