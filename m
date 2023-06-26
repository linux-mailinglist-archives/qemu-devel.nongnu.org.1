Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C12D73E11C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmf2-0004vM-UO; Mon, 26 Jun 2023 09:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmf1-0004v7-Eg
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmez-00060n-Vk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=NE7+py0WvtL9aJXm9eOQPW5I2il1GrZBbkvLbVE/UfTbYTzkM1fbZgUYaYl0kvOmZduAin
 L+Zmm5aHvCAvlDyn/4Vrk4HWK2Kbivoj7IzJ03F77nT10RlGHLUYpQLwBGWpGZiwkW9DXB
 /52E6EyzsDJjRYBBbT4LMgp1NCTDR5w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-YWkOEMxdOX-tpVSpGWLlxg-1; Mon, 26 Jun 2023 09:53:39 -0400
X-MC-Unique: YWkOEMxdOX-tpVSpGWLlxg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b7d5826f1fso6263225ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787618; x=1690379618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=CEUXtdwc22eekikzzMBn9Ksh45e1W5tLc4kdzFfCSpCkDNeHCXh0nL2KLcUGaDx+tO
 sylItwI2VJFbE1Uzdrwytbi0cnAdVXxnn6aJEPK9K9NkS2GghHD9OGKXy6fJ/Of9c3hy
 BApVONc2JDTTh3P2747Fk7MtQ1ZGZP02XfflyHeLtwxDHzcpg6aPoCO5b30leKKR2/NQ
 XFCv/wFePxO7StO3ip9ruThFt/MX/tCSJZZ8gp1I59z8hEpg+E1S1BQ9E8YNlAboj50/
 hSRDu5EPTRuyKhewDk8hO2zYtoeZQdzxDAz6k7DxhD1vr65ZLysjq/6a8tSq1wvaWcI5
 Ndjw==
X-Gm-Message-State: AC+VfDwRVF+9+UIe5Ge/hCXtNo0ULcK9HkvNWDSjTx6QdQxJj5hpAlNK
 t/duGD55qYSYrU6AM4VyIfmD+6PtZqMEaQ0i/S+TG2bAAQH/YJxvWo7r7YIgDMMiqtKkbFIz7/V
 x3HvcGRWRmIgthqZ2IOM6BDEPRm6cDqb60TwGuZvScsV4aEDAYwfDjCaaxdPj2s9XnRZsQVqK7b
 I=
X-Received: by 2002:a17:902:d2c1:b0:1b1:e6a4:2797 with SMTP id
 n1-20020a170902d2c100b001b1e6a42797mr3636783plc.45.1687787618110; 
 Mon, 26 Jun 2023 06:53:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aiaoRQGIwAM6zeVHikS+Ze+zpVv7Gnbe0OTlYy/MtDepGpH8euMzBLwUA1MBf4zU3CF/Vag==
X-Received: by 2002:a17:902:d2c1:b0:1b1:e6a4:2797 with SMTP id
 n1-20020a170902d2c100b001b1e6a42797mr3636767plc.45.1687787617782; 
 Mon, 26 Jun 2023 06:53:37 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 w7-20020a170902904700b001b809082a69sm1559621plz.235.2023.06.26.06.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:53:37 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 2/5] tests/acpi/bios-tables-test: use the correct slot on
 the pcie-root-port
Date: Mon, 26 Jun 2023 19:23:21 +0530
Message-Id: <20230626135324.10687-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626135324.10687-1-anisinha@redhat.com>
References: <20230626135324.10687-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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


