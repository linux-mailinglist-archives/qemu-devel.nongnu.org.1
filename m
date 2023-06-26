Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA073E421
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:04:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDogQ-0006i9-T6; Mon, 26 Jun 2023 12:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofj-00063z-UT
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofg-0007vM-VM
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=hW0s1c8e1UsxtzGVHH7+LYCD3AGCQmiksLNLzFW2NbNNaBKiTpXLz5FvG06RSaqL4YiQuC
 ZgBF8pJiD7+R2RCC9EyS4s3PIWyCKD+4UXerb29OVRQlIcxFoW7/+FWpelKCjgKySeSIJ4
 o/GdHabVFig6aZ3fWE+kD32dkh/eAes=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-JGssa1uoMBmcavcqdpcQFQ-1; Mon, 26 Jun 2023 12:02:29 -0400
X-MC-Unique: JGssa1uoMBmcavcqdpcQFQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6544e70f973so1422798b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795337; x=1690387337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=gidmT2XJNwNXDn5+FdmmgOfGTGCbyt2SdAGbdR7KRPvtTRqBsbKKDQ4auJq/FErN08
 UMAy6axnBbdihYfkqECh9k1PmeqgzVrCm0ekkLmupRhi3zhoWKcnaaI+sKUiUVod5ecK
 uNwP+nNkyg8edKPf5eIF5EtuF1YAUKKwzMJVhZUs4gRHldWpa5Jy66EPa1tZwJDiSM26
 vDMfBBmo712iDKIMKZ8NK/SiBsWZQRzKGE1f+JUo701kZfqgBWCciUf84RQ7h+lC/dX1
 dee4+Rb0LwXOkLjZ5nq4cZeM1QzU0L5kIkRthVAJ9xe+6RInbOLjZXbaRLDnMRhKl2kW
 7Plw==
X-Gm-Message-State: AC+VfDwKyM0xmLR6V6bvAFmxreT+Iexwfw8Te71wvYq6sos5r3pvZm9u
 FqHQk4FS7QoS+XYVapIak+tpSwBH+c7PI7LME0jwF3n/aJ19tiOg9gKtQOlyZ/Q3c3f/H4BRj8j
 5KpXIy0513LEslI8cNfffS1V4E98qR9mg407lt/ZOJus48SWUS2/oGYlS9tabQsbtIlBb/B/+zg
 c=
X-Received: by 2002:a05:6a00:1504:b0:668:9735:573c with SMTP id
 q4-20020a056a00150400b006689735573cmr20089505pfu.15.1687795337002; 
 Mon, 26 Jun 2023 09:02:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uj2cHM/cPeJ7YqSKP8pFnjeIELD1AENrTYMzF2jnE56X+X9KjLxbI3qe5BOUykPb7vpm3jw==
X-Received: by 2002:a05:6a00:1504:b0:668:9735:573c with SMTP id
 q4-20020a056a00150400b006689735573cmr20089470pfu.15.1687795336588; 
 Mon, 26 Jun 2023 09:02:16 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 l23-20020a62be17000000b0065ebeb9bb23sm4120174pff.149.2023.06.26.09.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:02:16 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v5 3/5] tests/acpi/bios-tables-test: use the correct slot on
 the pcie-root-port
Date: Mon, 26 Jun 2023 21:31:54 +0530
Message-Id: <20230626160156.3938-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626160156.3938-1-anisinha@redhat.com>
References: <20230626160156.3938-1-anisinha@redhat.com>
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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


