Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A70C97483A8
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Af-0006J0-Vj; Wed, 05 Jul 2023 07:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1Ad-0006Ii-W7
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1Ac-000112-Hz
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688558381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=AqVobUrt2bKAVaRrdoYF4ULri5gocM5Xv5X5rvNNuW32u0LmMrrnaSkABRoZNJNxfBuJZp
 OdRW/eGcUUU3tSG7W8HirzW++ei2AKUZvtPERniOLSU+jvrGgUP1IwLYPFwiScrccJZdR4
 2VJShBHVzFPp0ANr+uBqT/mZFw+X0yo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-QpmOocZiMTGXWPZ7xfgvBg-1; Wed, 05 Jul 2023 07:59:40 -0400
X-MC-Unique: QpmOocZiMTGXWPZ7xfgvBg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b88dee40ecso54399205ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558379; x=1691150379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQi5DNpBee1TXBxFEGyYLPk0MTnw7h1zNgmbfk3WRkU=;
 b=QqIJgBG8bCL5jZ6aAJDhKg+rG+PngzF7snbBX3+bWw7mBjANmGVQRWy8VWxLdsYAD3
 UKxf9CMYn0D5584k0ZR8VCHBZGVwXNrK6m6yuaFwQMz3j683eg42F5mDE2falx18Vt5h
 +sHRFNtfofkxdcZd7l/EHhVM/Qydea54gOYsCNXgogYooW9A84RRYxDQKKbpb3/GF7L2
 /hKhoG8swk4us0IWlvTRkEMnlozE4Be7h9Psu+FLzEtqRsDFl+J9fUR2tso7w5/I5/gj
 CuVVE2HbGRbyTzIdADvEtcxRnOpiKghlk5mYIGHOpvMqKzGa6jkYrKRplE698osvrsJV
 UncQ==
X-Gm-Message-State: ABy/qLZQ/w48hKNtAB0Vojju5Hah3u40lqX4t+BrPnhE32wSjyPXQNXZ
 In63VZBKIv1sq6adZlkgGPvEGNinxrCQDqmuTaah/gRLj2gQOdE6SgFxHZNAH9Aj7MwEsdn3tvG
 dDbwA8AC+NKyp58jhqJtuhxeoRy9YiZ944kMjXOPFjzgka2u6ZYHuVxrh6m2a9OGLh9ycy+Lfa5
 s=
X-Received: by 2002:a17:902:f683:b0:1b6:9954:2037 with SMTP id
 l3-20020a170902f68300b001b699542037mr18711678plg.4.1688558379387; 
 Wed, 05 Jul 2023 04:59:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLm782gRhw5jXqMo0NAncYjOwj4W7FsOyHtBotzWNY2154GTo/JuVsoHE2sFymeoLn43IhIA==
X-Received: by 2002:a17:902:f683:b0:1b6:9954:2037 with SMTP id
 l3-20020a170902f68300b001b699542037mr18711654plg.4.1688558378985; 
 Wed, 05 Jul 2023 04:59:38 -0700 (PDT)
Received: from localhost.localdomain ([115.96.119.220])
 by smtp.googlemail.com with ESMTPSA id
 v3-20020a1709028d8300b001b89c313185sm4878852plo.205.2023.07.05.04.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:59:38 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v8 2/6] tests/acpi/bios-tables-test: use the correct slot on
 the pcie-root-port
Date: Wed,  5 Jul 2023 17:29:20 +0530
Message-Id: <20230705115925.5339-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230705115925.5339-1-anisinha@redhat.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
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


