Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A46D741F28
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 06:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEixH-0004I6-F2; Thu, 29 Jun 2023 00:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEixC-0004G2-L4
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEix7-00016k-3d
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688011695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=T6JUoecbuthLm0ggYRMlTThkywx/9qqfnnq2i+kxUt1YgF+dXAbvzLlh8+lyXxPBhu/wqq
 H9IpxfWL28oL2IUda2VtrhBpSX5QIHQdDp2jcm7u45xnXnyvvJnL++U619evSEtmnzB8zj
 EzFwcnlrE/KxFzjJHuLQO82UkJOACIE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-Wyly94E8M9aJ6hqvYIzhRQ-1; Thu, 29 Jun 2023 00:08:10 -0400
X-MC-Unique: Wyly94E8M9aJ6hqvYIzhRQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-39ecef7a101so371094b6e.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 21:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688011689; x=1690603689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=FWSQXsKc63yyjF+7raAzabVjNGjWWXaFh1J8e2ceya1x/UPPrg5JtPTgvjTV278ryq
 Tc6RY4dYgeXFunOOzuDcIavBzrEaTNqa5aQZUwQhqOE13SaTnsVOPoIX8dl0uQWFFo7I
 MO82lVNxfiPTTqNcQRD/JdIZoD8yaMdHyFfve+LAD3w0HGqVUpUm36U2+BL9mzQxiAth
 gIJOS0QE3dcuK6VyMtk5j1vgkC0K7eXeuAr5Yu6CyW31PLK2INAsyY8LApJ6RR3YQ09K
 FXWZEz2Zu2qC+WdMbQf5cYCWvsR7puuVtsTkzVjCtmVDe0xTpXw+eTos0hRcafWnO7zC
 Hanw==
X-Gm-Message-State: AC+VfDzDKnxxM0AbExgg+MLt8wbfRrVbtMBSuZ/WyVT/e4sLv8++pICr
 +mQ5XNkFN6Q/iWAnDSMiyw+OYN/41XNPX5/UT81XCXTwH55WX6VaGioVqA5LNVbaYVp89aTiLLA
 VXExUdkrkudHzH+TXZ3wzciQWN0KDWgf3/WJhbNcKn/uf3qPxKeiwMaMmRCi0aWIZsO/+grMQWt
 U=
X-Received: by 2002:a05:6808:1922:b0:3a2:f91a:cb08 with SMTP id
 bf34-20020a056808192200b003a2f91acb08mr7479558oib.42.1688011689669; 
 Wed, 28 Jun 2023 21:08:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oRSmKIaFvfx6yUPmOr1wUlk/jSkUXlpzp4w4W3OFZEXttpm7zYNk0UJPD00CBFE6+xF93vQ==
X-Received: by 2002:a05:6808:1922:b0:3a2:f91a:cb08 with SMTP id
 bf34-20020a056808192200b003a2f91acb08mr7479534oib.42.1688011689261; 
 Wed, 28 Jun 2023 21:08:09 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.183])
 by smtp.googlemail.com with ESMTPSA id
 21-20020a17090a019500b00256b67208b1sm10978169pjc.56.2023.06.28.21.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 21:08:08 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v6 2/5] tests/acpi/bios-tables-test: use the correct slot on
 the pcie-root-port
Date: Thu, 29 Jun 2023 09:37:04 +0530
Message-Id: <20230629040707.115656-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230629040707.115656-1-anisinha@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
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


