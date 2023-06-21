Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E888738646
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByVF-0006iz-DY; Wed, 21 Jun 2023 10:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qByVD-0006gz-Hw
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qByVC-0000IA-1q
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687356484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9lBo45iBOx3ROsD8+uccm1MTNpEHRYqfkqJn9ffz3Y=;
 b=KinMmz5qlbGlNqWI12dxO0lGNlrN2/mVd3CrEGU34HwdLz9pwD467XhDS1N+G3Pxaheuut
 SjQs3d4HL4cE0wrJL2vWjdv5gXKyNhWJV5mVqaIE9KXVQyR2gWeTBboWNKt86XBe7JuYZy
 wuQ8ZaaRLFHGnaaTX3V4TESkZBtXhYQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-NVPWK22qMvaT6tEV0Uz--A-1; Wed, 21 Jun 2023 10:07:53 -0400
X-MC-Unique: NVPWK22qMvaT6tEV0Uz--A-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-543a89d0387so2557069a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687356467; x=1689948467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9lBo45iBOx3ROsD8+uccm1MTNpEHRYqfkqJn9ffz3Y=;
 b=T4KchVcfWMwOTm8isL4i9/urH1l07svBRp6sH6X8UB+GLZJNejk28U8rMHMseBSe7l
 YXEWn/TPuoHKHrOfYs2tkoZDImYg/bfigi6DfQVgeVtMc0cLa1NU7K+cPZ3LvJiTQ5of
 o7VIDouywPLoeXs2qoG1Ec6F2LNCJVnAkWqT3oNhFNYmm37xv2s4HXpjJH6gjjr32mpl
 ldmXMgtMXH483OPW/2C4t8NS9hnhs/Pd8oZJMbuAsF4H8imnz8fvt1MCHqnoqamqsXTk
 /2YDhW+qwYvZNlMofD97WIEqXDCaGAiHHmWpR52NiE0CnFSQ0RlBxtDMcgnE3ssU2zXc
 zCtQ==
X-Gm-Message-State: AC+VfDzm7xOEHAMFBLrOZR3c/r1ddeYP7eJs+qrNGNR+65wwhmCA3AEi
 VQU/qnnN6P/zPFQHQ0ybOjuQ3g5CJbHFDOlyOtV53awjKq12LVyPQ0RXLKW9E2R46/UzGdHybjC
 HJFrNQtg9CZNKhlJJDA66+k8=
X-Received: by 2002:a17:903:120e:b0:1b3:b200:a3d7 with SMTP id
 l14-20020a170903120e00b001b3b200a3d7mr11036544plh.52.1687356466966; 
 Wed, 21 Jun 2023 07:07:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RyUHnR3rbQZWD9m8X40YBKZ6wGkHFDdQ0lKXF/CUNBS0nOm4k+faY98LOtw+TdZPL8D9RfQ==
X-Received: by 2002:a17:903:120e:b0:1b3:b200:a3d7 with SMTP id
 l14-20020a170903120e00b001b3b200a3d7mr11036521plh.52.1687356466664; 
 Wed, 21 Jun 2023 07:07:46 -0700 (PDT)
Received: from localhost.localdomain ([115.96.199.101])
 by smtp.googlemail.com with ESMTPSA id
 y7-20020a17090322c700b001b4fee3ea25sm3502427plg.277.2023.06.21.07.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 07:07:45 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/acpi/bios-tables-test: use the correct slot on the
 pcie-root-port
Date: Wed, 21 Jun 2023 19:37:22 +0530
Message-Id: <20230621140723.462220-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230621140723.462220-1-anisinha@redhat.com>
References: <20230621140723.462220-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

PCIE ports only have one slot, slot 0. Hence, non-zero slots are not available
for PCIE devices on PCIE root ports. Fix test_acpi_q35_tcg_no_acpi_hotplug()
so that the test does not use them.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/bios-tables-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index ed1c69cf01..47ba20b957 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1020,9 +1020,9 @@ static void test_acpi_q35_tcg_no_acpi_hotplug(void)
         " -device pci-testdev,bus=nohprp,acpi-index=501"
         " -device pcie-root-port,id=nohprpint,port=0x0,chassis=3,hotplug=off,"
                                  "multifunction=on,addr=8.0"
-        " -device pci-testdev,bus=nohprpint,acpi-index=601,addr=8.1"
+        " -device pci-testdev,bus=nohprpint,acpi-index=601,addr=0.1"
         " -device pcie-root-port,id=hprp2,port=0x0,chassis=4,bus=nohprpint,"
-                                 "addr=9.0"
+                                 "addr=0.2"
         " -device pci-testdev,bus=hprp2,acpi-index=602"
         , &data);
     free_test_data(&data);
-- 
2.39.1


