Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB107106FC
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q263n-0007Ym-Va; Thu, 25 May 2023 04:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263L-0007Ut-Bi
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263J-0001os-6G
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685002228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkKQUfjL3wE0QSB8TZN27tG7NeesjqAFU0QKdSba0Zc=;
 b=MHfAmZqbLFUR/ieJdVhbCewvZAdVo1J4P6+KdQtcXtVdViW8ziByjpMPAgmCJklAudvJBE
 RZ+53HiFubTVqfHcRy/yNk2yS5hFF0GRtHC5mhSLqCYM1LHBG/yTH/+IXjvdHqR9SGhOua
 /+SfLXLdN5vFDuZiymiNBbGTWEU0bpg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-qGHMK3RIOfC2iBcLEnXMPA-1; Thu, 25 May 2023 04:10:25 -0400
X-MC-Unique: qGHMK3RIOfC2iBcLEnXMPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0911185A78B;
 Thu, 25 May 2023 08:10:24 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BFEE40C1258;
 Thu, 25 May 2023 08:10:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 2/4] tests/qtest: Check for virtio-blk before using -cdrom
 with the arm virt machine
Date: Thu, 25 May 2023 10:10:14 +0200
Message-Id: <20230525081016.1870364-3-thuth@redhat.com>
In-Reply-To: <20230525081016.1870364-1-thuth@redhat.com>
References: <20230525081016.1870364-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

The arm "virt" machine needs "virtio-blk-pci" for devices that get attached
via the "-cdrom" option. Since this is an optional device that might not
be available in the binary, we should check for the availability of this
device first before using it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/bios-tables-test.c | 2 +-
 tests/qtest/cdrom-test.c       | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 159e4edb8f..ed1c69cf01 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2164,7 +2164,7 @@ int main(int argc, char *argv[])
             }
         }
     } else if (strcmp(arch, "aarch64") == 0) {
-        if (has_tcg) {
+        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_virt_tcg);
             qtest_add_func("acpi/virt/acpihmatvirt",
                             test_acpi_virt_tcg_acpi_hmat);
diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index d1cc375849..f2a8d91929 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -264,9 +264,13 @@ int main(int argc, char **argv)
         const char *armmachines[] = {
             "realview-eb", "realview-eb-mpcore", "realview-pb-a8",
             "realview-pbx-a9", "versatileab", "versatilepb", "vexpress-a15",
-            "vexpress-a9", "virt", NULL
+            "vexpress-a9", NULL
         };
         add_cdrom_param_tests(armmachines);
+        if (qtest_has_device("virtio-blk-pci")) {
+            const char *virtmachine[] = { "virt", NULL };
+            add_cdrom_param_tests(virtmachine);
+        }
     } else {
         const char *nonemachine[] = { "none", NULL };
         add_cdrom_param_tests(nonemachine);
-- 
2.31.1


