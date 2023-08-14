Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4EE77BEB1
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 19:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVb7T-0004EJ-Ll; Mon, 14 Aug 2023 13:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVb7R-0004Dn-KC
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 13:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVb7P-00026c-0U
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 13:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692033158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kpS03Xxlub/LkTWMEjYKZQonz77JApNQsbIObmdPUp0=;
 b=FMlaehGt3ZnzkkVRvWmgCGff0QDmNmSFacTnvLuXeBGj64P5ugvpJaruSbzUKMJAHZcM5y
 oH5QPuAiHQfPD9Cr4cT9nvwDzK4thR/XhGLXVPzoI3Ah09CCKbfrfrlXcvQzQvk6SMc10o
 NED5q1+/iUBuf9QTa0ziVE3J0TiarXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-JBFZWBZiNf2_EWMejEEUhg-1; Mon, 14 Aug 2023 13:12:34 -0400
X-MC-Unique: JBFZWBZiNf2_EWMejEEUhg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 625D3185A78B;
 Mon, 14 Aug 2023 17:12:33 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0EAE492C13;
 Mon, 14 Aug 2023 17:12:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Warner Losh <imp@bsdimp.com>
Cc: qemu-trivial@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Jason Wang <jasowang@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org
Subject: [PATCH] trace-events: Fix the name of the tracing.rst file
Date: Mon, 14 Aug 2023 19:12:28 +0200
Message-Id: <20230814171228.903273-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The file has been converted to .rst a while ago - make sure that the
references in the trace-events files are pointing to the right location
now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 bsd-user/trace-events         | 2 +-
 ebpf/trace-events             | 2 +-
 hw/nubus/trace-events         | 2 +-
 target/s390x/kvm/trace-events | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/trace-events b/bsd-user/trace-events
index 843896f627..2c1cb66726 100644
--- a/bsd-user/trace-events
+++ b/bsd-user/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.rst for syntax documentation.
 
 # bsd-user/signal.c
 user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
diff --git a/ebpf/trace-events b/ebpf/trace-events
index 411b1e2be3..b3ad1a35f2 100644
--- a/ebpf/trace-events
+++ b/ebpf/trace-events
@@ -1,4 +1,4 @@
-# See docs/devel/tracing.txt for syntax documentation.
+# See docs/devel/tracing.rst for syntax documentation.
 
 # ebpf-rss.c
 ebpf_error(const char *s1, const char *s2) "error in %s: %s"
diff --git a/hw/nubus/trace-events b/hw/nubus/trace-events
index e31833d694..9259d66725 100644
--- a/hw/nubus/trace-events
+++ b/hw/nubus/trace-events
@@ -1,4 +1,4 @@
-# See docs/devel/tracing.txt for syntax documentation.
+# See docs/devel/tracing.rst for syntax documentation.
 
 # nubus-bus.c
 nubus_slot_read(uint64_t addr, int size) "reading unassigned addr 0x%"PRIx64 " size %d"
diff --git a/target/s390x/kvm/trace-events b/target/s390x/kvm/trace-events
index 5289f5f675..380976b225 100644
--- a/target/s390x/kvm/trace-events
+++ b/target/s390x/kvm/trace-events
@@ -1,4 +1,4 @@
-# See docs/devel/tracing.txt for syntax documentation.
+# See docs/devel/tracing.rst for syntax documentation.
 
 # kvm.c
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
-- 
2.39.3


