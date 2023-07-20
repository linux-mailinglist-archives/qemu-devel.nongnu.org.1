Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8675B03A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:40:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTsk-00072y-Go; Thu, 20 Jul 2023 09:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs7-0006hv-Ds
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs1-0007Vv-L8
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689860343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SRuakU3+08O8Smp7TbuocnrPScngGYbY/YYX8l1EPtA=;
 b=UBtXJ3HWBez1xecsXg4NKctalOj1AMcr8OTWu6tPSDD/EtkCS4dK+U1rGren3pIK7FBsLI
 jXy11XpjndI5SDuuOrGNzLcleK2Yh1EP5wWkuQL4tNCQpKG+Aikm5+U2aK+gi97mHNGdKe
 ycOfOtY5Yj2S1ak65kAatCbPJe0sogc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-LHgH9xoGO96-w32XqGbrhA-1; Thu, 20 Jul 2023 09:39:02 -0400
X-MC-Unique: LHgH9xoGO96-w32XqGbrhA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2BD7800CB2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 13:39:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 651FB4A9005;
 Thu, 20 Jul 2023 13:39:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	anisinha@redhat.com
Subject: [PATCH for-8.1 0/6] x86: acpi pci fixes
Date: Thu, 20 Jul 2023 15:38:52 +0200
Message-Id: <20230720133858.1974024-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Working on PXB acpi-index support takes unexpectedly long so
pushing out self sufficient fixes from my PXB queue that do not
have dependency on other patches.

patch 2/6 is regression fix for making acpi-index work with Windows guests
patch 5/6 is ACPI spec compliance fix

tested with rhel9, WS2012R2, WS2022, WinXPsp3

PS:
 WinXP boots (but it doesn't expose device properties so I have no idea
 how to check 'PCI Label Id' or if it's even supported there)
 
Igor Mammedov (6):
  tests: acpi: x86: whitelist expected blobs
  x86: acpi: workaround Windows not handling name references in Package
    properly
  tests: acpi: x86: update expected blobs
  tests: acpi: whitelist expected blobs
  acpi: x86: remove _ADR on host bridges
  tests: acpi: update expected blobs

 hw/i386/acpi-build.c                          |  11 ++++++-----
 tests/data/acpi/pc/DSDT                       | Bin 6488 -> 6830 bytes
 tests/data/acpi/pc/DSDT.acpierst              | Bin 6411 -> 6741 bytes
 tests/data/acpi/pc/DSDT.acpihmat              | Bin 7813 -> 8155 bytes
 tests/data/acpi/pc/DSDT.bridge                | Bin 12615 -> 13701 bytes
 tests/data/acpi/pc/DSDT.cphp                  | Bin 6952 -> 7294 bytes
 tests/data/acpi/pc/DSDT.dimmpxm               | Bin 8142 -> 8484 bytes
 tests/data/acpi/pc/DSDT.hpbridge              | Bin 6451 -> 6781 bytes
 tests/data/acpi/pc/DSDT.hpbrroot              | Bin 3343 -> 3337 bytes
 tests/data/acpi/pc/DSDT.ipmikcs               | Bin 6560 -> 6902 bytes
 tests/data/acpi/pc/DSDT.memhp                 | Bin 7847 -> 8189 bytes
 tests/data/acpi/pc/DSDT.nohpet                | Bin 6346 -> 6688 bytes
 tests/data/acpi/pc/DSDT.numamem               | Bin 6494 -> 6836 bytes
 tests/data/acpi/pc/DSDT.roothp                | Bin 9873 -> 10623 bytes
 tests/data/acpi/q35/DSDT                      | Bin 8361 -> 8355 bytes
 tests/data/acpi/q35/DSDT.acpierst             | Bin 8378 -> 8372 bytes
 tests/data/acpi/q35/DSDT.acpihmat             | Bin 9686 -> 9680 bytes
 tests/data/acpi/q35/DSDT.acpihmat-noinitiator | Bin 8640 -> 8634 bytes
 tests/data/acpi/q35/DSDT.applesmc             | Bin 8407 -> 8401 bytes
 tests/data/acpi/q35/DSDT.bridge               | Bin 11590 -> 11968 bytes
 tests/data/acpi/q35/DSDT.core-count2          | Bin 32501 -> 32495 bytes
 tests/data/acpi/q35/DSDT.cphp                 | Bin 8825 -> 8819 bytes
 tests/data/acpi/q35/DSDT.cxl                  | Bin 9673 -> 9655 bytes
 tests/data/acpi/q35/DSDT.dimmpxm              | Bin 10015 -> 10009 bytes
 tests/data/acpi/q35/DSDT.ipmibt               | Bin 8436 -> 8430 bytes
 tests/data/acpi/q35/DSDT.ipmismbus            | Bin 8449 -> 8443 bytes
 tests/data/acpi/q35/DSDT.ivrs                 | Bin 8378 -> 8372 bytes
 tests/data/acpi/q35/DSDT.memhp                | Bin 9720 -> 9714 bytes
 tests/data/acpi/q35/DSDT.mmio64               | Bin 9491 -> 9485 bytes
 tests/data/acpi/q35/DSDT.multi-bridge         | Bin 12770 -> 13208 bytes
 tests/data/acpi/q35/DSDT.noacpihp             | Bin 8241 -> 8235 bytes
 tests/data/acpi/q35/DSDT.nohpet               | Bin 8219 -> 8213 bytes
 tests/data/acpi/q35/DSDT.numamem              | Bin 8367 -> 8361 bytes
 tests/data/acpi/q35/DSDT.pvpanic-isa          | Bin 8462 -> 8456 bytes
 tests/data/acpi/q35/DSDT.tis.tpm12            | Bin 8967 -> 8961 bytes
 tests/data/acpi/q35/DSDT.tis.tpm2             | Bin 8993 -> 8987 bytes
 tests/data/acpi/q35/DSDT.viot                 | Bin 9470 -> 9464 bytes
 tests/data/acpi/q35/DSDT.xapic                | Bin 35724 -> 35718 bytes
 38 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.39.3


