Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A6746FE2
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeAx-0001oP-Ru; Tue, 04 Jul 2023 07:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAg-0001n0-1c
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAe-0002CF-J8
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688469972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=g+tK0V5VCkerESuVIrdkSSiQ3Z5QtA5qTorGmWWVQVgdOGor18FivGls/6BKplU49ltlm+
 tUKKS5hnHG8fOtVG82DBprDjdB+MggTzc90GzuW7TLYMnvYwy1ZLhafnMP0bi2x7rWNgnR
 KMChPW8kG0b1lesb1HgR/uqXHo/t5E4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-cbwrhBsGPky6A88eP6UfNg-1; Tue, 04 Jul 2023 07:26:10 -0400
X-MC-Unique: cbwrhBsGPky6A88eP6UfNg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b8a4e947a1so8873945ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688469969; x=1691061969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=Kq80rxCpnbJNjzPzzoq3X9eijFI1mOjGW/QBKv1YX/pHhfq68LXnItIM2aLleQqmTo
 MJGM6Rp1Atf92rBjdE0wwCeWzog7y1MYPm27ZyPzhHihK2KmOLFXXQuuSUMnaJkYkbJA
 +JcTTzJkUa8Ch00ro4OKFvnxjC7ja+YiwYPdOSya5vtbHUXERqs2fLPeDiucUqzaw/ri
 4taVlD4SeFkTijoyb2RCYivHFnDfMkGpjC7TU8g/pdrm09eiQG4FuBJ2DPklL5PTrTE+
 zHnPh1j2NFpPRUfnlgOBxNpQtii52vzSkYhqJL7RUGO2NJjs/Z5LHvd6mWTMILWLUWlG
 dLtQ==
X-Gm-Message-State: ABy/qLYsp4620bj5cxtVhdfYpt+fp5DdxRkZUsv22980a5gOQtPTqYYr
 fF+E6O2+Su6uH/bvC9zf/+4uC4sj1XClfftIocU3g4QXnkBvRqaEo2ZkzNpRhNzNLLzWGdqUrBT
 Mxp4Pgg2pISsdEuLchxcFwq4fwQCdl8v3nYjHouVfClOk/CGUsuSTiyiHiv2GT+fszvxQ5zVivl
 o=
X-Received: by 2002:a17:902:cec9:b0:1b8:6952:5381 with SMTP id
 d9-20020a170902cec900b001b869525381mr20532702plg.9.1688469969298; 
 Tue, 04 Jul 2023 04:26:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3ZNdNpiO4KfPDBHRqf3YlW7js6k+nBgIfvBCqOSw/BPrRic1+fKAogZGVNXrRP6pYct7vBA==
X-Received: by 2002:a17:902:cec9:b0:1b8:6952:5381 with SMTP id
 d9-20020a170902cec900b001b869525381mr20532670plg.9.1688469968856; 
 Tue, 04 Jul 2023 04:26:08 -0700 (PDT)
Received: from localhost.localdomain ([115.96.131.170])
 by smtp.googlemail.com with ESMTPSA id
 o7-20020a170902bcc700b001b8a897cd26sm780608pls.195.2023.07.04.04.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 04:26:08 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v7 2/6] tests/acpi/bios-tables-test: use the correct slot on
 the pcie-root-port
Date: Tue,  4 Jul 2023 16:55:51 +0530
Message-Id: <20230704112555.5629-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230704112555.5629-1-anisinha@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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


