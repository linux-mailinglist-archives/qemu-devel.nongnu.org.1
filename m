Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB27AEB399
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Jun 2025 12:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5ro-0001Hg-2N; Fri, 27 Jun 2025 05:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5rQ-0007xI-Hy
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5rO-0008Jt-V7
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751018346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7aV5kYUD3FMHdr5gwVD7bRiMIzO9kLW9pomDugGafM=;
 b=Ij3xnncyBcOrgOMWSdAikcjAeI8aJKTc+zLNSQ7yrH0t3Np2l/Jlyt32qpSmSdhzyIOMOK
 SNu8jCAHGUFaT8CUlNZJEFPKk8a/e2a5Kf4b4AsKNYYxPAJt+TBsjUr1x7OJmpkSm3Vgkt
 4sZRYMzBgxYjuihuLh0PtLBIFLemcD0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-6NdjrTPTNdOZcOQ7swWITA-1; Fri,
 27 Jun 2025 05:59:01 -0400
X-MC-Unique: 6NdjrTPTNdOZcOQ7swWITA-1
X-Mimecast-MFC-AGG-ID: 6NdjrTPTNdOZcOQ7swWITA_1751018340
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CC7B18011F9; Fri, 27 Jun 2025 09:59:00 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8AE219560A7; Fri, 27 Jun 2025 09:58:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v4 30/32] tests/qtest/bios-tables-test: Prepare for addition
 of acpi pci hp tests
Date: Fri, 27 Jun 2025 11:55:19 +0200
Message-ID: <20250627095620.3300028-31-eric.auger@redhat.com>
In-Reply-To: <20250627095620.3300028-1-eric.auger@redhat.com>
References: <20250627095620.3300028-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Soon we will introduce new tests related to ACPI PCI hotplug and
acpi-index that will use a new reference blob:

tests/data/acpi/aarch64/virt/DSDT.acpipcihp
tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- switch Sign-off's (Jonathan)
---
 tests/qtest/bios-tables-test-allowed-diff.h      | 2 ++
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | 0
 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | 0
 3 files changed, 2 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..02f4f0b29f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
+"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.49.0


